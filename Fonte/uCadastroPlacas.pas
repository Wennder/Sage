unit uCadastroPlacas;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uCadastroGenerico, JvExControls, UsoGeral,
  JvComponent, JvNavigationPane, Mask, JvExStdCtrls, JvEdit,
  JvValidateEdit, StdCtrls, uCliente, uPlaca, cxStyles, cxCustomData,
  cxGraphics, cxFilter, cxData, cxDataStorage, cxEdit, DB, cxDBData,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView,
  JvMemoryDataset, cxGridLevel, cxClasses, cxControls, cxGridCustomView,
  cxGrid, cxLookAndFeels, cxLookAndFeelPainters, Menus, cxButtons, ExtCtrls,
  cxContainer, cxTextEdit, cxLabel, dxSkinsCore, dxSkinOffice2010Silver, dxSkinscxPCPainter,
  cxNavigator, cxCurrencyEdit, cxMaskEdit, Datasnap.DBClient;

type
  TfrmPlacas = class(TfrmCadastroGenerico)
    cxGridDBTableView: TcxGridDBTableView;
    cxGridLevel: TcxGridLevel;
    cxGrid: TcxGrid;
    dsCadastro: TDataSource;
    cxGridDBTableViewPlaca: TcxGridDBColumn;
    cxGridDBTableViewVeiculo: TcxGridDBColumn;
    cxGridDBTableViewKm: TcxGridDBColumn;
    edtCliente: TcxTextEdit;
    edtVeiculo: TcxTextEdit;
    lblCliente: TcxLabel;
    lblPlaca: TcxLabel;
    lblKm: TcxLabel;
    lblVeiculo: TcxLabel;
    edtPlaca: TcxMaskEdit;
    edtKM: TcxCurrencyEdit;
    stCliente: TcxTextEdit;
    cdsCadastro: TClientDataSet;
    cdsCadastroPlaca: TStringField;
    cdsCadastroVeiculo: TStringField;
    cdsCadastroKM: TIntegerField;
    cdsCadastroDML: TStringField;
    btnInsere: TcxButton;
    btnDeleta: TcxButton;
    procedure edtClienteKeyPress(Sender: TObject; var Key: Char);
    procedure edtClienteKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edtClienteExit(Sender: TObject);
    procedure btnGravaClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnInsereClick(Sender: TObject);
    procedure btnDeletaClick(Sender: TObject);
    procedure cdsCadastroNewRecord(DataSet: TDataSet);
    procedure cdsCadastroAfterEdit(DataSet: TDataSet);
  private
    { Private declarations }
    oCliente: TCliente;
    oPlaca: TPlaca;
    procedure InicializaForm;
  public
    { Public declarations }
  end;

var
  frmPlacas: TfrmPlacas;

implementation

uses uPrincipal, uUltimasDefinicoesVenda;

{$R *.dfm}

procedure TfrmPlacas.edtClienteKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  KeyPressNumerico(Key);
end;

procedure TfrmPlacas.edtClienteKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  if Key = vk_F2 then
  begin
    edtCliente.Text := ChamaPesquisa(TEdit(Sender), frmPrincipal.zcoConexaoBanco)[0];
    Perform(WM_NEXTDLGCTL, 0, 0);
  end;
end;

procedure TfrmPlacas.btnInsereClick(Sender: TObject);
begin
  inherited;
  with cdsCadastro do
  begin
    if Locate('Placa;Veiculo', VarArrayOf([edtPlaca.EditValue, edtVeiculo.EditValue]), []) then
    begin
      pMsgAtencao('Já existe um veículo cadastrado com esta placa.');
      edtPlaca.SetFocus;
      Abort;
    end;
    if edtPlaca.EditValue = Null then
    begin
      pMsgAtencao('O campo Placa não pode ser vazio.');
      edtPlaca.SetFocus;
      Abort;
    end;

    if edtVeiculo.EditValue = Null then
    begin
      pMsgAtencao('O campo Veículo não pode ser vazio.');
      edtVeiculo.SetFocus;
      Abort;
    end;
    Insert;
    FieldByName('Placa').AsString := edtPlaca.EditValue;
    FieldByName('Veiculo').AsString := edtVeiculo.EditValue;
    FieldByName('Km').AsInteger := edtKM.EditValue;
    Post;
  end;
end;

procedure TfrmPlacas.cdsCadastroAfterEdit(DataSet: TDataSet);
begin
  inherited;
  cdsCadastro.FieldByName('DML').AsString := 'A';
end;

procedure TfrmPlacas.cdsCadastroNewRecord(DataSet: TDataSet);
begin
  inherited;
  cdsCadastro.FieldByName('DML').AsString := 'I';
end;

procedure TfrmPlacas.edtClienteExit(Sender: TObject);
begin
  inherited;
  if Trim(edtCliente.Text) <> '' then
  begin
    if oCliente.bPesquisaCliente(edtCliente.Text) then
    begin
      stCliente.Text := oCliente.sGetNome;
      oPlaca.bPesquisaCliente(StrToInt(edtCliente.Text), cdsCadastro);
    end
    else
    begin
      Application.MessageBox('Cliente não encontrado!', 'Informação', MB_OK + MB_ICONINFORMATION);
      edtCliente.SetFocus;
    end;
  end;
end;

procedure TfrmPlacas.btnDeletaClick(Sender: TObject);
begin
  inherited;
  cdsCadastro.Edit;
  cdsCadastro.FieldByName('DML').Value := 'E';
  cdsCadastro.Post;
end;

procedure TfrmPlacas.btnGravaClick(Sender: TObject);
var
  bContinuar, bRegistroNovo: Boolean;
begin
  inherited;
  with oPlaca do
  begin
    with cdsCadastro do
    begin
      First;
      Filtered := False;
      while not Eof do
      begin
        SetPlaca(FieldByName('Placa').Value);
        SetVeiculo(FieldByName('Veiculo').Value);
        SetKm(FieldByName('KM').Value);
        oCliente.SetCodigo(edtCliente.Text);

        if FieldByName('DML').Value = 'I' then
        begin
          SetCodigo(iRetornaUltimoCodigo + 1);
          CadastraPlaca
        end
        else if FieldByName('DML').Value = 'A' then
          AlteraPlaca
        else if FieldByName('DML').Value = 'E' then
          DeletaPlaca;
        Next;
      end;
      Filtered := True;
    end;
    InicializaForm;
  end;
end;

procedure TfrmPlacas.InicializaForm;
begin
  LimpaCampos(self, []);
  if Assigned(frmUltimasDefinicoes) then
    Close
  else
    edtCliente.SetFocus;
end;

procedure TfrmPlacas.FormCreate(Sender: TObject);
begin
  inherited;
  oPlaca := TPlaca.Create(frmPrincipal.zcoConexaoBanco);
  oCliente := TCliente.Create(frmPrincipal.zcoConexaoBanco);
end;

procedure TfrmPlacas.FormShow(Sender: TObject);
begin
  inherited;
  if not Assigned(frmUltimasDefinicoes) then
    if Trim(edtCliente.Text) = '' then
    begin
      edtCliente.Enabled := True;
      edtCliente.SetFocus;
    end
    else
      oPlaca.bPesquisaCliente(edtCliente.EditValue, cdsCadastro);
end;

end.
