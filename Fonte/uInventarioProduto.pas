unit uInventarioProduto;

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
  ZDataset, UsoGeral, uProcedimentosBanco, uProduto, Datasnap.DBClient, cxGridDBTableView,
  cxCurrencyEdit, ppParameter, ppProd, ppClass, ppReport, ppComm, ppRelatv, ppDB, ppDBPipe,
  ppDesignLayer, ppModule, raCodMod, ppBands, ppCtrls, ppVar, dxGDIPlusClasses, ppPrnabl, ppCache;

type
  TfrmInventarioProduto = class(TfrmCadastroGenerico)
    lbCod: TcxLabel;
    edtInventario: TcxTextEdit;
    lbDtOperacao: TcxLabel;
    lbStatus: TcxLabel;
    Bevel1: TBevel;
    btnDeleta: TcxButton;
    btnInsere: TcxButton;
    stProduto: TcxTextEdit;
    edtProduto: TcxTextEdit;
    Label5: TcxLabel;
    grdProduto: TcxGrid;
    grdProdutoLevel: TcxGridLevel;
    cxLabel1: TcxLabel;
    edtDataOperacao: TcxDateEdit;
    edtDataFechamento: TcxDateEdit;
    edtStatus: TcxImageComboBox;
    dsItens: TDataSource;
    grdProdutoDBTableView1: TcxGridDBTableView;
    grdProdutoDBTableView1sproduto: TcxGridDBColumn;
    grdProdutoDBTableView1nqtdcontada: TcxGridDBColumn;
    cdsItens: TClientDataSet;
    cdsItensicodigo: TIntegerField;
    cdsItensiinventario: TIntegerField;
    cdsItensiproduto: TIntegerField;
    cdsItensnqtdcontada: TFloatField;
    cdsItensndiferenca: TFloatField;
    cdsItensDML: TStringField;
    cdsItenssproduto: TStringField;
    grdProdutoDBTableView1DML: TcxGridDBColumn;
    grdProdutoDBTableView1icodigo: TcxGridDBColumn;
    grdProdutoDBTableView1iinventario: TcxGridDBColumn;
    grdProdutoDBTableView1iproduto: TcxGridDBColumn;
    grdProdutoDBTableView1ndiferenca: TcxGridDBColumn;
    edtQtdContada: TcxCurrencyEdit;
    lbQuantidade: TcxLabel;
    pmInventarios: TPopupMenu;
    ListadeProdutosdoInventrio1: TMenuItem;
    ppDBPipeline: TppDBPipeline;
    Report: TppReport;
    ppParameterList1: TppParameterList;
    btnFechar: TcxButton;
    ppHeaderBand1: TppHeaderBand;
    ppImage1: TppImage;
    LabelTitulo: TppLabel;
    ppLabel15: TppLabel;
    ppLine1: TppLine;
    ppLabel9: TppLabel;
    ppLabel10: TppLabel;
    ppLabel11: TppLabel;
    ppLabel3: TppLabel;
    ppDetailBand1: TppDetailBand;
    ppDBText8: TppDBText;
    ppDBText9: TppDBText;
    ppDBText10: TppDBText;
    ppLabel4: TppLabel;
    ppFooterBand1: TppFooterBand;
    ppLine2: TppLine;
    ppSystemVariable1: TppSystemVariable;
    ppSystemVariable2: TppSystemVariable;
    ppSummaryBand1: TppSummaryBand;
    ppGroup1: TppGroup;
    ppGroupHeaderBand1: TppGroupHeaderBand;
    ppShape1: TppShape;
    ppiinventario: TppLabel;
    ppLabel2: TppLabel;
    ppLabel1: TppLabel;
    ppLabel16: TppLabel;
    ppddataoperacao: TppLabel;
    ppsstatus: TppLabel;
    ppGroupFooterBand1: TppGroupFooterBand;
    raCodeModule1: TraCodeModule;
    ppDesignLayers1: TppDesignLayers;
    ppDesignLayer1: TppDesignLayer;
    procedure FormShow(Sender: TObject);
    procedure edtInventarioExit(Sender: TObject);
    procedure edtProdutoEnter(Sender: TObject);
    procedure edtProdutoExit(Sender: TObject);
    procedure edtProdutoKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edtProdutoKeyPress(Sender: TObject; var Key: Char);
    procedure btnCancelaClick(Sender: TObject);
    procedure btnInsereClick(Sender: TObject);
    procedure btnDeletaClick(Sender: TObject);
    procedure cdsItensAfterEdit(DataSet: TDataSet);
    procedure ListadeProdutosdoInventrio1Click(Sender: TObject);
    procedure btnFecharClick(Sender: TObject);
    procedure btnGravaClick(Sender: TObject);
    procedure edtInventarioKeyPress(Sender: TObject; var Key: Char);
    procedure edtInventarioKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }
    oInventario: TInventario;
    oInventarioItem: TInventarioItem;
    oProduto: TProduto;
    procedure pGravacao(pAcao: String);
  public
    { Public declarations }
  end;

var
  frmInventarioProduto: TfrmInventarioProduto;

implementation

Uses uPrincipal;

{$R *.dfm}

procedure TfrmInventarioProduto.btnCancelaClick(Sender: TObject);
begin
  inherited;
  oInventario.LimpaAtributosInv;
  oInventarioItem.LimpaAtributosInvItm;
  oInventarioItem.FiltraListaItem(cdsItens, '');
  LimpaCampos(self, []);

  edtInventario.Text := oInventario.iRetornaUltimoCodigo;
  edtInventario.SetFocus;

  cdsItens.Close;
  cdsItens.CreateDataSet;
  cdsItens.EmptyDataSet;
  cdsItens.Open;
end;

procedure TfrmInventarioProduto.btnDeletaClick(Sender: TObject);
begin
  inherited;
  oInventarioItem.RemoveItemLista(cdsItens, 'E');
end;

procedure TfrmInventarioProduto.btnFecharClick(Sender: TObject);
begin
  inherited;
  pGravacao('F');
end;

procedure TfrmInventarioProduto.btnGravaClick(Sender: TObject);
begin
  inherited;
  pGravacao('X');
end;

procedure TfrmInventarioProduto.btnInsereClick(Sender: TObject);
begin
  inherited;
  with oInventarioItem do
  begin
    SetiInventario(edtInventario.Text);
    SetiProduto(edtProduto.Text);
    SetsProduto(oProduto.GetsDescricaoComMarca);
    SetnQtdContada(edtQtdContada.Value);

    if not AdicionaItemLista(cdsItens, 'I') then
    begin
      pMsgAtencao('Este produto já foi adicionado ao inventário.');
      edtProduto.SetFocus;
      Abort;
    end
    else
    begin
      edtProduto.Clear;
      stProduto.Clear;
      edtQtdContada.Value := 0;
      edtProduto.SetFocus;
    end;
  end;
end;

procedure TfrmInventarioProduto.cdsItensAfterEdit(DataSet: TDataSet);
begin
  inherited;
  oInventarioItem.EditaItemLista(cdsItens, 'A');
end;

procedure TfrmInventarioProduto.edtInventarioExit(Sender: TObject);
var
  vDataFechamento: String;
begin
  inherited;
  if trim(edtInventario.Text) <> '' then
  begin
    with oInventario do
    begin
      if ConsultaInventario(StrToInt(edtInventario.Text)) then
      begin
        edtDataOperacao.EditValue := Getddataoperacao;
        edtStatus.EditValue := Getsstatus;
        if edtStatus.EditValue = 'F' then
        begin
          edtDataFechamento.EditValue := GetDatafechamento;
          btnInsere.Enabled := False;
          btnDeleta.Enabled := False;
          btnFechar.Enabled := False;
          btnGrava.Enabled := False;
          grdProdutoDBTableView1.OptionsData.Editing := False;
          edtProduto.Enabled := False;
          edtQtdContada.Enabled := False;
        end
        else
        begin
          btnInsere.Enabled := True;
          btnDeleta.Enabled := True;
          btnFechar.Enabled := True;
          btnGrava.Enabled := True;
          grdProdutoDBTableView1.OptionsData.Editing := True;
          edtProduto.Enabled := True;
          edtQtdContada.Enabled := True;
        end;
      end
      else
      begin
        // Novo Inventario.
        btnInsere.Enabled := True;
        btnDeleta.Enabled := True;
        btnFechar.Enabled := True;
        btnGrava.Enabled := True;
        grdProdutoDBTableView1.OptionsData.Editing := True;
        edtProduto.Enabled := True;
        edtQtdContada.Enabled := True;

        oInventario.Setddataoperacao(fDataHoraSrv(frmPrincipal.zcoConexaoBanco));

        edtDataOperacao.EditValue := oInventario.Getddataoperacao;
        edtStatus.EditValue := 'A';
        edtDataFechamento.Clear;
        edtProduto.SetFocus;
      end;
      oInventarioItem.ConsultaInventarioItem(cdsItens, StrToInt(edtInventario.Text));
    end;
  end;
end;

procedure TfrmInventarioProduto.edtInventarioKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  if Key = vk_F2 then
  begin
    edtInventario.Text := ChamaPesquisa(TEdit(Sender), frmPrincipal.zcoConexaoBanco)[0];
    Perform(WM_NEXTDLGCTL, 0, 0);
  end;
end;

procedure TfrmInventarioProduto.edtInventarioKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  pKeyPressNumerico(Key);
end;

procedure TfrmInventarioProduto.edtProdutoEnter(Sender: TObject);
begin
  inherited;
  edtProduto.Clear;
  stProduto.Clear;
  edtQtdContada.Value := 0;
end;

procedure TfrmInventarioProduto.edtProdutoExit(Sender: TObject);
begin
  inherited;
  if (ActiveControl = grdProduto) or (ActiveControl = btnGrava) or (ActiveControl = btnCancela) or (ActiveControl = btnSair) then
    Exit;
  if (edtProduto.Text = '') or (edtProduto.Text = '0') then
    Exit;

  oProduto.bPesquisaProduto(StrToInt(edtProduto.Text));
  stProduto.Text := oProduto.GetsDescricaoComMarca;
end;

procedure TfrmInventarioProduto.edtProdutoKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  if Key = vk_F2 then
  begin
    edtProduto.Text := ChamaPesquisa(TEdit(Sender), frmPrincipal.zcoConexaoBanco)[0];
    Perform(WM_NEXTDLGCTL, 0, 0);
  end;
end;

procedure TfrmInventarioProduto.edtProdutoKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  KeyPressNumerico(Key);
end;

procedure TfrmInventarioProduto.FormShow(Sender: TObject);
begin
  inherited;
  oInventario := TInventario.Create(frmPrincipal.zcoConexaoBanco);
  oInventarioItem := TInventarioItem.Create(frmPrincipal.zcoConexaoBanco);
  oProduto := TProduto.Create(frmPrincipal.zcoConexaoBanco);

  edtInventario.Text := oInventario.iRetornaUltimoCodigo;

  cdsItens.Close;
  cdsItens.CreateDataSet;
  cdsItens.EmptyDataSet;
  cdsItens.Open;
end;

procedure TfrmInventarioProduto.ListadeProdutosdoInventrio1Click(Sender: TObject);
begin
  inherited;
  if not cdsItens.IsEmpty then
  begin
    if oInventario.Getsstatus = 'A' then
    begin
      ppiinventario.Caption := edtInventario.Text;
      ppddataoperacao.Caption := oInventario.Getddataoperacao;
      ppsstatus.Caption := 'Aberto';
      Report.Print;
    end
    else
    begin
      pMsgAtencao('A Lista de Produtos só pode ser impressa para Inventário Aberto.');
      btnImprimir.SetFocus;
      Abort;
    end;
  end
  else
  begin
    pMsgAtencao('Não existem produtos adicionados ao Inventário.');
    btnImprimir.SetFocus;
    Abort;
  end;
end;

procedure TfrmInventarioProduto.pGravacao(pAcao: String);
begin
  with oInventario do
  begin
    if cdsItens.State in [dsEdit, dsInsert] then
      cdsItens.Post;

    if GetiCodigo = -1 then
    begin
      SetiCodigo(StrToInt(edtInventario.Text));
      Setddataoperacao(fDataHoraSrv(frmPrincipal.zcoConexaoBanco));
      Setsstatus('A');
      Setidusuariocad(vIdUsuario);

      IncluiInventario;

      // Insere itens
      oInventarioItem.FiltraListaItem(cdsItens, 'DML = ''I''');
      oInventarioItem.IncluiItemInventario(cdsItens);

      // Exclui itens
      oInventarioItem.FiltraListaItem(cdsItens, 'DML = ''A''');
      oInventarioItem.AlteraItemInventario(cdsItens);

      // Exclui itens
      oInventarioItem.FiltraListaItem(cdsItens, 'DML = ''E''');
      oInventarioItem.ExcluiItemInventario(cdsItens);

      if pAcao <> 'F' then
        pMsgInfo('Inventário incluso com sucesso!');
    end
    else
    begin
      Setidusuarioultalt(vIdUsuario);
      Setdatahoraultalt(fDataHoraSrv(frmPrincipal.zcoConexaoBanco));
      AlteraInventario;

      // Insere itens
      oInventarioItem.FiltraListaItem(cdsItens, 'DML = ''I''');
      oInventarioItem.IncluiItemInventario(cdsItens);

      // Exclui itens
      oInventarioItem.FiltraListaItem(cdsItens, 'DML = ''A''');
      oInventarioItem.AlteraItemInventario(cdsItens);

      // Exclui itens
      oInventarioItem.FiltraListaItem(cdsItens, 'DML = ''E''');
      oInventarioItem.ExcluiItemInventario(cdsItens);

      if pAcao <> 'F' then
        pMsgInfo('Inventário alterado com sucesso!');
    end;
  end;

  { Grava fechamento do inventário }
  if pAcao = 'F' then
  begin
    oInventario.Setidusuarioultalt(vIdUsuario);
    oInventario.Setdatahoraultalt(fDataHoraSrv(frmPrincipal.zcoConexaoBanco));

    case oInventario.FechaInventario(cdsItens, StrToInt(edtInventario.Text)) of
      0:
        pMsgAtencao('Inventário não foi fechado.');
      1:
        pMsgInfo('Inventário fechado com sucesso!');
      2:
        pMsgAtencao('Inventário não possui iten(s) contado(s).');
    end;
  end;

  LimpaCampos(self, []);
  btnCancela.OnClick(btnCancela);
end;

end.
