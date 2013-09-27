unit uFaturaPedido;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uCadastroGenerico, JvExControls,
  JvComponent, JvNavigationPane, cxStyles, cxCustomData,
  cxGraphics, cxFilter, cxData, cxDataStorage, cxEdit, DB, cxDBData,
  cxContainer, cxTextEdit, cxCurrencyEdit, Mask, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, SQLMemMain, cxGridLevel, cxClasses,
  cxControls, cxGridCustomView, cxGrid, StdCtrls, uPedidoParcela,
  ZAbstractRODataset, ZAbstractDataset, ZDataset, uFuncoes, cxLookAndFeels,
  cxLookAndFeelPainters, dxSkinsCore, dxSkinBlack, dxSkinBlue, dxSkinCaramel,
  dxSkinCoffee, dxSkinDarkRoom, dxSkinDarkSide, dxSkinFoggy, dxSkinGlassOceans,
  dxSkiniMaginary, dxSkinLilian, dxSkinLiquidSky, dxSkinLondonLiquidSky,
  dxSkinMcSkin, dxSkinMoneyTwins, dxSkinOffice2007Black, dxSkinOffice2007Blue,
  dxSkinOffice2007Green, dxSkinOffice2007Pink, dxSkinOffice2007Silver,
  dxSkinOffice2010Black, dxSkinOffice2010Blue, dxSkinOffice2010Silver,
  dxSkinPumpkin, dxSkinSeven, dxSkinSharp, dxSkinSilver, dxSkinSpringTime,
  dxSkinStardust, dxSkinSummer2008, dxSkinsDefaultPainters, dxSkinValentine,
  dxSkinXmas2008Blue, dxSkinscxPCPainter, Menus, cxButtons, ExtCtrls, cxLabel;

type
  TfrmFaturaPedido = class(TfrmCadastroGenerico)
    edtDataPedido: TStaticText;
    edtCliente: TStaticText;
    cxGrid1: TcxGrid;
    cxGrid1DBTableView1: TcxGridDBTableView;
    cxGrid1Level1: TcxGridLevel;
    SQLMemTable: TSQLMemTable;
    DataSource: TDataSource;
    SQLMemTableFatura: TStringField;
    SQLMemTableVencimento: TDateField;
    SQLMemTableValor: TFloatField;
    cxGrid1DBTableView1Fatura: TcxGridDBColumn;
    cxGrid1DBTableView1Vencimento: TcxGridDBColumn;
    cxGrid1DBTableView1Valor: TcxGridDBColumn;
    edtDataEmissao: TMaskEdit;
    cxCurrencyEditValor: TcxCurrencyEdit;
    Query: TZQuery;
    btnInsere: TcxButton;
    btnDeleta: TcxButton;
    edtPedido: TcxTextEdit;
    EditFatura: TcxTextEdit;
    Label1: TcxLabel;
    Label3: TcxLabel;
    LabelFatura: TcxLabel;
    LabelVencimento: TcxLabel;
    LabelValor: TcxLabel;
    procedure edtPedidoExit(Sender: TObject);
    procedure edtPedidoKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edtPedidoKeyPress(Sender: TObject; var Key: Char);
    procedure btnInsereClick(Sender: TObject);
    procedure btnGravaClick(Sender: TObject);
    procedure btnDeletaClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure edtPedidoEnter(Sender: TObject);
    procedure btnCancelaClick(Sender: TObject);
  private
    { Private declarations }
    oPedidoParcela: TPedidoParcela;
  public
    { Public declarations }
  end;

var
  frmFaturaPedido: TfrmFaturaPedido;

implementation

uses uPrincipal;

{$R *.dfm}

procedure TfrmFaturaPedido.edtPedidoExit(Sender: TObject);
begin
  inherited;
  if edtPedido.Text = '' then
    Exit;
  Query.Connection := frmPrincipal.zcoConexaoBanco;
  with Query do
  begin
    SQL.Clear;
    SQL.Add('Select tbpedido.ddatapedido, tbpedido.icliente, tbpessoa.snome, tbPedido.bPedido From TbPedido');
    SQL.Add('left outer Join tbpessoa on tbpessoa.icodigo = icliente');
    SQL.Add('Where tbpedido.icodigo = :codigo');
    ParamByName('Codigo').AsInteger := StrToInt(edtPedido.Text);
    Open;
    if not isEmpty then
    begin
      edtDataPedido.Caption := FormatDatetime('dd/mm/yyyy', FieldByName('ddatapedido').asDateTime);
      edtCliente.Caption := FieldByName('icliente').AsString + ' - ' + FieldByName('sNome').AsString;
      InicializaSqlMemTable(SQLMemTable);

    end
    else
      ShowMessage('Pedido não encontrado!');
  end;
end;

procedure TfrmFaturaPedido.edtPedidoKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  if Key = vk_F2 then
  begin
    edtPedido.Text := ChamaPesquisa(TEdit(Sender), frmPrincipal.zcoConexaoBanco)[0];
    edtPedidoExit(Sender);
  end;
end;

procedure TfrmFaturaPedido.edtPedidoKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  KeyPressNumerico(Key);
end;

procedure TfrmFaturaPedido.btnInsereClick(Sender: TObject);
begin
  inherited;
  if edtPedido.Text = '' then
    Exit;
  SQLMemTable.Append;
  SQLMemTableFatura.AsString := EditFatura.Text;
  SQLMemTableVencimento.asDateTime := StrToDate(edtDataEmissao.Text);
  SQLMemTableValor.AsFloat := cxCurrencyEditValor.Value;
  SQLMemTable.Post;
  EditFatura.Text := '';
  edtDataEmissao.Text := '';
  cxCurrencyEditValor.Value := 0;
  EditFatura.SetFocus;

end;

procedure TfrmFaturaPedido.btnGravaClick(Sender: TObject);
begin
  inherited;
  if edtPedido.Text = '' then
    Exit;
  with SQLMemTable, oPedidoParcela do
  begin
    First;
    Setipedido(StrToInt(edtPedido.Text));
    DeletaPedidoParcela;
    while not Eof do
    begin
      Setsfatura(SQLMemTableFatura.AsString);
      Setdvencimento(SQLMemTableVencimento.asDateTime);
      Setnvalor(SQLMemTableValor.AsFloat);
      Seticodigo(iRetornaUltimoCodigo + 1);
      CadastraPedidoParcela;
      Next;
    end;
    edtPedido.SetFocus;
  end;
end;

procedure TfrmFaturaPedido.btnDeletaClick(Sender: TObject);
begin
  inherited;
  if edtPedido.Text = '' then
    Exit;
  if not SQLMemTable.isEmpty then
    SQLMemTable.Delete;
end;

procedure TfrmFaturaPedido.FormShow(Sender: TObject);
begin
  inherited;
  oPedidoParcela := TPedidoParcela.Create(frmPrincipal.zcoConexaoBanco);
end;

procedure TfrmFaturaPedido.edtPedidoEnter(Sender: TObject);
begin
  inherited;
  edtPedido.Text := '';
  EditFatura.Text := '';
  edtDataEmissao.Text := '';
  cxCurrencyEditValor.Value := 0;
  edtDataPedido.Caption := '';
  edtCliente.Caption := '';
  InicializaSqlMemTable(SQLMemTable);
end;

procedure TfrmFaturaPedido.btnCancelaClick(Sender: TObject);
begin
  inherited;
  edtPedido.SetFocus;
end;

end.
