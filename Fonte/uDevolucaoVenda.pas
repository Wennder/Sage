unit uDevolucaoVenda;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uCadastroGenerico, cxGraphics, cxLookAndFeels,
  cxLookAndFeelPainters, Vcl.Menus, cxControls, cxContainer, cxEdit, cxTextEdit, cxLabel,
  Vcl.StdCtrls, cxButtons, Vcl.ExtCtrls, JvExControls, JvNavigationPane, Vcl.ComCtrls, dxCore,
  cxDateUtils, cxMaskEdit, cxDropDownEdit, cxCalendar, cxImageComboBox, cxStyles, cxCustomData,
  cxFilter, cxData, cxDataStorage, cxNavigator, Data.DB, cxDBData, cxGridLevel, cxClasses,
  cxGridCustomView, cxGridCustomTableView, cxGridTableView, cxGridBandedTableView,
  cxGridDBBandedTableView, cxGrid, cxDBEdit, uInventario, ZAbstractRODataset, ZAbstractDataset,
  ZDataset, UsoGeral, uProcedimentosBanco, uPesquisaGeral, Datasnap.DBClient, cxGridDBTableView,
  cxCurrencyEdit, ppParameter, ppProd, ppClass, ppReport, ppComm, ppRelatv, ppDB, ppDBPipe,
  ppDesignLayer, ppModule, raCodMod, ppBands, ppCtrls, ppVar, dxGDIPlusClasses, ppPrnabl, ppCache, uDevVenda, uPedido,
  cxLookupEdit, cxDBLookupEdit, cxDBLookupComboBox, uEmpresa;

type
  TfrmDevolucaoVenda = class(TfrmCadastroGenerico)
    Bevel1: TBevel;
    lbPedido: TcxLabel;
    edtPedido: TcxTextEdit;
    lbDtOperacao: TcxLabel;
    stCliente: TcxTextEdit;
    lbCliente: TcxLabel;
    grdProduto: TcxGrid;
    grdProdutoDBTableView1: TcxGridDBTableView;
    grdProdutoLevel: TcxGridLevel;
    edtDataPedido: TcxDateEdit;
    cdsItens: TClientDataSet;
    cdsItensDML: TStringField;
    cdsItensicodigo: TIntegerField;
    cdsItensiinventario: TIntegerField;
    cdsItensiproduto: TIntegerField;
    cdsItenssproduto: TStringField;
    cdsItensnqtdcontada: TFloatField;
    dsItens: TDataSource;
    grdProdutoDBTableView1DML: TcxGridDBColumn;
    grdProdutoDBTableView1icodigo: TcxGridDBColumn;
    grdProdutoDBTableView1iDevVenda: TcxGridDBColumn;
    grdProdutoDBTableView1iproduto: TcxGridDBColumn;
    grdProdutoDBTableView1sproduto: TcxGridDBColumn;
    cdsItensnqtdVendida: TFloatField;
    grdProdutoDBTableView1nqtdVendida: TcxGridDBColumn;
    grdProdutoDBTableView1nqtddevolvida: TcxGridDBColumn;
    cdsItensqtdDevolver: TFloatField;
    grdProdutoDBTableView1qtdDevolver: TcxGridDBColumn;
    cxLabel1: TcxLabel;
    edtNatOp: TcxLookupComboBox;
    edtCFOP: TcxLookupComboBox;
    cxLabel2: TcxLabel;
    edtObservacao: TcxTextEdit;
    cxLabel3: TcxLabel;
    qrNatOp: TZQuery;
    dsNatOp: TDataSource;
    dsCfop: TDataSource;
    qrCfop: TZQuery;
    qrNatOpicodigo: TIntegerField;
    qrNatOpsdescricao: TWideStringField;
    qrNatOpsdescricaocomcodigo: TWideMemoField;
    qrCfopicodigo: TIntegerField;
    qrCfopsdescricao: TWideStringField;
    edtTexto: TcxTextEdit;
    procedure edtPedidoKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edtPedidoKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
    procedure edtPedidoExit(Sender: TObject);
    procedure btnCancelaClick(Sender: TObject);
    procedure btnGravaClick(Sender: TObject);
    procedure cdsItensqtdDevolverChange(Sender: TField);
    procedure cdsItensAfterScroll(DataSet: TDataSet);
  private
    { Private declarations }
    oPedido: TPedido;
    oDevVenda: TDevVenda;
    oDevVendaItem: TDevVendaItem;
  public
    { Public declarations }
  end;

var
  frmDevolucaoVenda: TfrmDevolucaoVenda;

implementation

Uses uPrincipal, uRelNotasFiscais;

{$R *.dfm}

procedure TfrmDevolucaoVenda.btnCancelaClick(Sender: TObject);
begin
  inherited;
  oDevVenda.LimpaAtributosDevVenda;
  oDevVendaItem.LimpaAtributosDevVendaItm;
  oDevVendaItem.FiltraListaItem(cdsItens, '');
  LimpaCampos(self, []);

  cdsItens.Close;
  cdsItens.CreateDataSet;
  cdsItens.EmptyDataSet;
  cdsItens.Open;

  qrNatOp.Close;
  qrNatOp.Open;

  qrCfop.Close;
  qrCfop.Open;

  edtNatOp.EditValue := -1;
  edtCFOP.EditValue := -1;

  edtTexto.Visible := False;
  edtTexto.Text := '';

  edtPedido.SetFocus;
end;

procedure TfrmDevolucaoVenda.btnGravaClick(Sender: TObject);
Var
  ResultGravacao: TResult;
begin
  inherited;
  if cdsItens.State in [dsEdit, dsInsert] then
    cdsItens.Post;

  with oDevVenda do
  begin
    SetiNaturezaOp(edtNatOp.EditValue);
    SetiCfop(edtCFOP.EditValue);
    SetsObservacao(edtObservacao.Text);
    Setidusuariocad(vIdUsuario);
    Setddataoperacao(fDataHoraSrv(frmPrincipal.zcoConexaoBanco));

    // Insere itens
    oDevVendaItem.FiltraListaItem(cdsItens, 'DML = ''I''');
    ResultGravacao := IncluiDevVenda(cdsItens);

    if ResultGravacao[0] = 'F' then
    begin
      pMsgAtencao(ResultGravacao[1]);
      if ResultGravacao[3] <> '' then
      begin
        if ResultGravacao[3] = 'edtNatOp' then
          edtNatOp.SetFocus;
        if ResultGravacao[3] = 'edtCfop' then
          edtCFOP.SetFocus;
      end;
      oDevVendaItem.FiltraListaItem(cdsItens, '');
      Abort;
    end
    else
    begin
      pMsgInfo('Devolução de venda realizada com sucesso!');
      btnCancela.OnClick(btnCancela);
    end;
  end;
end;

procedure TfrmDevolucaoVenda.cdsItensAfterScroll(DataSet: TDataSet);
begin
  inherited;
  if cdsItens.FieldByName('DML').Value = 'X' then
  begin
    cdsItens.FieldByName('qtdDevolver').ReadOnly := True;
    grdProdutoDBTableView1qtdDevolver.Editing := False;
  end
  else
  begin
    cdsItens.FieldByName('qtdDevolver').ReadOnly := False;
    grdProdutoDBTableView1qtdDevolver.Editing := True;
  end;
end;

procedure TfrmDevolucaoVenda.cdsItensqtdDevolverChange(Sender: TField);
begin
  inherited;
  Sender.ReadOnly := False;
  grdProdutoDBTableView1qtdDevolver.Editing := True;
  if Sender.Value > 0 then
    oDevVendaItem.EditaItemLista(cdsItens, 'I')
  else
    oDevVendaItem.EditaItemLista(cdsItens, 'X');
end;

procedure TfrmDevolucaoVenda.edtPedidoExit(Sender: TObject);
begin
  inherited;
  if Trim(edtPedido.Text) = '' then
    Abort;

  with oDevVenda do
  begin
    if oPedido.PesquisaPedido(StrToInt(edtPedido.Text)) then
    begin
      if not oPedido.GetIsNF then
      begin
        pMsgAtencao('Esta venda não gerou nenhum documento fiscal!' + #13 + 'Só é permitida a devolução de pedidos que geraram NF.');
        edtPedido.SetFocus;
        Abort;
      end;

      SetiPedido(edtPedido.Text);
      SetsCliente(oPedido.GetsCliente);
      edtDataPedido.EditValue := oPedido.dGetDataPedido;
      stCliente.Text := GetsCliente;

      oDevVendaItem.ConsultaPedidoItem(cdsItens, StrToInt(edtPedido.Text));
      if cdsItens.Locate('DML', 'I', []) then
      begin
        edtNatOp.Enabled := True;
        edtCFOP.Enabled := True;
        edtObservacao.Enabled := True;
        btnGrava.Enabled := True;
        grdProdutoDBTableView1qtdDevolver.Options.Editing := True;
        edtTexto.Visible := False;
      end
      else
      begin
        edtNatOp.Enabled := False;
        edtCFOP.Enabled := False;
        edtObservacao.Enabled := False;
        btnGrava.Enabled := False;
        grdProdutoDBTableView1qtdDevolver.Options.Editing := False;
        edtTexto.Visible := True;
        edtTexto.Text := 'Esta Nota Fiscal já teve todos os itens devolvidos. Disponível apenas para visualização.';
      end;
    end
    else
    begin
      pMsgAtencao('Pedido não encontrado.');
      edtPedido.SetFocus;
      Abort;
    end;
  end;
end;

procedure TfrmDevolucaoVenda.edtPedidoKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
Var
  Resultado: TResultArray;
begin
  inherited;
  if Key = vk_F2 then
  begin
    Resultado := ChamaPesquisa(TEdit(Sender), frmPrincipal.zcoConexaoBanco);
    SetLength(Resultado, Length(Resultado));

    edtPedido.Text := Resultado[0];
    edtDataPedido.Text := Resultado[1];
    stCliente.Text := Resultado[3];

    Perform(WM_NEXTDLGCTL, 0, 0);
  end;
end;

procedure TfrmDevolucaoVenda.edtPedidoKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  pKeyPressNumerico(Key);
end;

procedure TfrmDevolucaoVenda.FormShow(Sender: TObject);
begin
  inherited;
  oPedido := TPedido.Create(frmPrincipal.zcoConexaoBanco);
  oDevVenda := TDevVenda.Create(frmPrincipal.zcoConexaoBanco);
  oDevVendaItem := TDevVendaItem.Create(frmPrincipal.zcoConexaoBanco);

  oDevVenda.setiEmpresa(oEmpresaPrincipal.Getiempresa);

  with qrNatOp do
  begin
    Close;
    Connection := frmPrincipal.zcoConexaoBanco;
    Open;
  end;

  with qrCfop do
  begin
    Close;
    Connection := frmPrincipal.zcoConexaoBanco;
    Open;
  end;
end;

end.
