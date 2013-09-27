unit uCadastroConta;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uCadastroGenerico, JvExControls, uProcedimentosBanco,
  JvComponent,  JvNavigationPane, StdCtrls, Mask, cxStyles,
  cxCustomData, cxGraphics, cxFilter, cxData, cxDataStorage, cxEdit, DB,
  cxDBData, SQLMemMain, cxGridLevel, cxClasses, cxControls,
  cxGridCustomView, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxGrid, cxContainer, cxTextEdit, cxCurrencyEdit, ucliente,
  urecconta, uFuncoes, cxLookAndFeels, cxLookAndFeelPainters, Menus, cxButtons,
  ExtCtrls, cxLabel, cxNavigator;

type
  TfrmCadastroConta = class(TfrmCadastroGenerico)
    stCliente: TStaticText;
    edtDataEmissao: TMaskEdit;
    cxCurrencyEditValor: TcxCurrencyEdit;
    cxGrid1DBTableView1: TcxGridDBTableView;
    cxGrid1Level1: TcxGridLevel;
    cxGrid1: TcxGrid;
    SQLMemTable: TSQLMemTable;
    SQLMemTableParcela: TIntegerField;
    SQLMemTableVencimento: TDateField;
    SQLMemTableValor: TFloatField;
    DataSource: TDataSource;
    cxGrid1DBTableView1Parcela: TcxGridDBColumn;
    cxGrid1DBTableView1Vencimento: TcxGridDBColumn;
    cxGrid1DBTableView1Valor: TcxGridDBColumn;
    edtCliente: TcxTextEdit;
    EditSerie: TcxTextEdit;
    EditNumero: TcxTextEdit;
    EditParcelas: TcxTextEdit;
    lblCliente: TcxLabel;
    LabelSerie: TcxLabel;
    LabelNumero: TcxLabel;
    LabelEmissao: TcxLabel;
    LabelQtdParcelas: TcxLabel;
    LabelValor: TcxLabel;
    procedure FormShow(Sender: TObject);
    procedure edtClienteEnter(Sender: TObject);
    procedure edtClienteExit(Sender: TObject);
    procedure edtClienteKeyPress(Sender: TObject; var Key: Char);
    procedure EditParcelasKeyPress(Sender: TObject; var Key: Char);
    procedure btnGravaClick(Sender: TObject);
    procedure edtClienteKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edtDataEmissaoExit(Sender: TObject);
    procedure EditParcelasExit(Sender: TObject);
  private
    { Private declarations }
    oCliente: TCliente;
    oRecContaOrigem: TRecContaOrigem;
    oRecConta: TRecConta;
  public
    { Public declarations }
  end;

var
  frmCadastroConta: TfrmCadastroConta;

implementation

uses uPrincipal;

{$R *.dfm}

procedure TfrmCadastroConta.FormShow(Sender: TObject);
begin
  inherited;
  InicializaSqlMemTable(SQLMemTable);
  oCliente := TCliente.Create(frmPrincipal.zcoConexaoBanco);
  oRecContaOrigem := TRecContaOrigem.Create(frmPrincipal.zcoConexaoBanco);
  oRecConta := TRecConta.Create(frmPrincipal.zcoConexaoBanco);
end;

procedure TfrmCadastroConta.edtClienteEnter(Sender: TObject);
begin
  inherited;
  InicializaSqlMemTable(SQLMemTable);
  edtCliente.Clear;
  stCliente.Caption := '';
  EditSerie.Text := '';
  EditNumero.Text := '';
  edtDataEmissao.Text := '';
  EditParcelas.Text := '1';
  cxCurrencyEditValor.Value := 0;
end;

procedure TfrmCadastroConta.edtClienteExit(Sender: TObject);
begin
  inherited;
  oCliente.bPesquisaCliente(edtCliente.Text);
  stCliente.Caption := oCliente.sGetNome;
end;

procedure TfrmCadastroConta.edtClienteKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  KeyPressNumerico(Key);
end;

procedure TfrmCadastroConta.EditParcelasKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  KeyPressNumerico(Key);
end;

procedure TfrmCadastroConta.btnGravaClick(Sender: TObject);
begin
  inherited;
  with oRecContaOrigem do
  begin
    Setsserie(EditSerie.Text);
    Setnumero(EditNumero.Text);
    SetQtdParcelas(StrToInt(EditParcelas.Text));
    SetEmissao(StrToDate(edtDataEmissao.Text));
    SetValorTotal(cxCurrencyEditValor.Value);
    oCliente.SetCodigo(edtCliente.Text);
    CadastraContaOrigem;
  end;
  with SQLMemTable do
  begin
    First;
    while not Eof do
    begin
      oRecConta.CadastraConta(oRecContaOrigem.GetiContaOrigem, FieldByName('parcela').asInteger, FieldByName('vencimento').asdatetime,
        FieldByName('valor').asfloat, 0, 0);
      Next;
    end;
  end;
end;

procedure TfrmCadastroConta.edtClienteKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  if Key = vk_F2 then
  begin
    edtCliente.Text := ChamaPesquisa(TEdit(Sender), frmPrincipal.zcoConexaoBanco)[0];
    Perform(WM_NEXTDLGCTL, 0, 0);
  end;
end;

procedure TfrmCadastroConta.edtDataEmissaoExit(Sender: TObject);
begin
  inherited;
  if Length(edtDataEmissao.Text) = 8 then
  begin
    edtDataEmissao.Text := Copy(edtDataEmissao.Text, 1, 6) + '20' + Copy(edtDataEmissao.Text, 7, 2)
  end;
end;

procedure TfrmCadastroConta.EditParcelasExit(Sender: TObject);
var
  Vencimento: TDate;
  C: Integer;
begin
  inherited;
  if EditParcelas.Text = '' then
    EditParcelas.Text := '1';
  if StrToInt(EditParcelas.Text) <= 0 then
    EditParcelas.Text := '1';
  InicializaSqlMemTable(SQLMemTable);
  Vencimento := fDataHoraSrv(frmprincipal.zcoConexaoBanco);
  for C := 1 to StrToInt(EditParcelas.Text) do
  begin
    SQLMemTable.Insert;
    SQLMemTable.FieldByName('Parcela').asInteger := C;
    SQLMemTable.FieldByName('Vencimento').asdatetime := Vencimento + 30;
    SQLMemTable.FieldByName('Valor').asfloat := cxCurrencyEditValor.Value / StrToInt(EditParcelas.Text);
    Vencimento := Vencimento + 30;
    SQLMemTable.Post;
  end;
end;

end.
