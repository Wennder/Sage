unit uControleOrcamentos;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uCadastroGenerico, JvXPCore, JvXPButtons, JvExControls, uProcedimentosBanco,
  JvComponent, cxGraphics, cxLookAndFeels, cxLookAndFeelPainters, Menus,
  cxControls, cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit,
  DB, cxDBData, JvMemoryDataset, StdCtrls, Mask, cxGridLevel,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxClasses,
  cxGridCustomView, cxGrid, ExtCtrls, cxButtons, JvNavigationPane,
  ZAbstractRODataset, ZAbstractDataset, ZDataset,
  cxContainer, cxLabel, dxSkinsCore, dxSkinOffice2010Silver, dxSkinscxPCPainter,
  cxNavigator,
  Datasnap.DBClient, Vcl.ComCtrls, dxCore, cxDateUtils, cxTextEdit, cxMaskEdit,
  cxDropDownEdit,
  cxCalendar, cxCurrencyEdit, ppDB, ppDBPipe, ppParameter, ppDesignLayer,
  ppModule, raCodMod,
  ppCtrls, ppStrtch, ppMemo, ppBands, ppVar, dxGDIPlusClasses, ppPrnabl,
  ppClass, ppCache, ppComm,
  ppRelatv, ppProd, ppReport, dxSkinBlack, dxSkinBlue, dxSkinBlueprint,
  dxSkinCaramel, dxSkinCoffee, dxSkinDarkRoom, dxSkinDarkSide,
  dxSkinDevExpressDarkStyle, dxSkinDevExpressStyle, dxSkinFoggy,
  dxSkinGlassOceans, dxSkinHighContrast, dxSkiniMaginary, dxSkinLilian,
  dxSkinLiquidSky, dxSkinLondonLiquidSky, dxSkinMcSkin, dxSkinMoneyTwins,
  dxSkinOffice2007Black, dxSkinOffice2007Blue, dxSkinOffice2007Green,
  dxSkinOffice2007Pink, dxSkinOffice2007Silver, dxSkinOffice2010Black,
  dxSkinOffice2010Blue, dxSkinPumpkin, dxSkinSeven, dxSkinSevenClassic,
  dxSkinSharp, dxSkinSharpPlus, dxSkinSilver, dxSkinSpringTime, dxSkinStardust,
  dxSkinSummer2008, dxSkinTheAsphaltWorld, dxSkinsDefaultPainters,
  dxSkinValentine, dxSkinVS2010, dxSkinWhiteprint, dxSkinXmas2008Blue;

type
  TTipoOperacaoControleOrcamento = (TTpOprCtrlOrcmntConsultaPadrao, TTpOprCtrlOrcmntEdicaoOrcamento, TTpOprCtrlOrcmntCancelaOrcamento);

  TfrmControleOrcamentos = class(TfrmCadastroGenerico)
    cxGrid1: TcxGrid;
    cxGrid1DBTableView1: TcxGridDBTableView;
    cxGrid1Level1: TcxGridLevel;
    dsOrcamento: TDataSource;
    cxGrid1DBTableView1Orcamento: TcxGridDBColumn;
    cxGrid1DBTableView1Data: TcxGridDBColumn;
    cxGrid1DBTableView1CodigoCliente: TcxGridDBColumn;
    cxGrid1DBTableView1NomeCliente: TcxGridDBColumn;
    cxGrid1DBTableView1Valor: TcxGridDBColumn;
    cdsOrcamento: TClientDataSet;
    cdsOrcamentoOrcamento: TIntegerField;
    cdsOrcamentoData: TDateField;
    cdsOrcamentoCodigoCliente: TIntegerField;
    cdsOrcamentoNomeCliente: TStringField;
    cdsOrcamentoValor: TFloatField;
    pnlFiltro: TPanel;
    Label2: TcxLabel;
    Label3: TcxLabel;
    btnFiltrar: TcxButton;
    edtDataInicio: TcxDateEdit;
    edtDataFinal: TcxDateEdit;
    ppReport: TppReport;
    ppParameterList1: TppParameterList;
    ZQuery1: TZQuery;
    DataSource1: TDataSource;
    ppDBPipeline1: TppDBPipeline;
    btnItens: TcxButton;
    btnDuplicar: TcxButton;
    ppHeaderBand2: TppHeaderBand;
    ppShape4: TppShape;
    ppShape1: TppShape;
    ppImage1: TppImage;
    ppDBText11: TppDBText;
    ppVariable3: TppVariable;
    ppLabel10: TppLabel;
    ppDBText19: TppDBText;
    ppLabel12: TppLabel;
    ppDBText21: TppDBText;
    ppShape5: TppShape;
    ppLabel13: TppLabel;
    ppDBText23: TppDBText;
    ppVariable4: TppVariable;
    ppLabel14: TppLabel;
    ppLabel8: TppLabel;
    ppDBText18: TppDBText;
    ppLabel9: TppLabel;
    ppDBText22: TppDBText;
    ppLabel15: TppLabel;
    ppVariable2: TppVariable;
    ppLabel11: TppLabel;
    ppDBText30: TppDBText;
    ppVariable5: TppVariable;
    ppDetailBand2: TppDetailBand;
    ppShape2: TppShape;
    ppDBText24: TppDBText;
    ppDBText25: TppDBText;
    ppDBText26: TppDBText;
    ppDBText27: TppDBText;
    ppDBText28: TppDBText;
    ppDBText29: TppDBText;
    ppFooterBand2: TppFooterBand;
    ppShape8: TppShape;
    ppLabel24: TppLabel;
    ppSystemVariable1: TppSystemVariable;
    ppLabel25: TppLabel;
    ppLabel26: TppLabel;
    ppSystemVariable2: TppSystemVariable;
    ppSummaryBand1: TppSummaryBand;
    ppLine1: TppLine;
    ppVariable8: TppVariable;
    ppLine4: TppLine;
    ppLabel1: TppLabel;
    ppGroup1: TppGroup;
    ppGroupHeaderBand1: TppGroupHeaderBand;
    ppGroupFooterBand1: TppGroupFooterBand;
    ppShape3: TppShape;
    ppLabel23: TppLabel;
    ppVariable6: TppVariable;
    ppDBMemo1: TppDBMemo;
    ppVariable7: TppVariable;
    ppGroup2: TppGroup;
    ppGroupHeaderBand2: TppGroupHeaderBand;
    ppShape6: TppShape;
    ppLabel17: TppLabel;
    ppLabel18: TppLabel;
    ppLabel16: TppLabel;
    ppLabel19: TppLabel;
    ppLabel20: TppLabel;
    ppGroupFooterBand2: TppGroupFooterBand;
    ppShape7: TppShape;
    ppLabel21: TppLabel;
    ppLabel22: TppLabel;
    ppDBCalc2: TppDBCalc;
    ppDBCalc1: TppDBCalc;
    raCodeModule2: TraCodeModule;
    ppDesignLayers2: TppDesignLayers;
    ppDesignLayer2: TppDesignLayer;
    btnEditar: TcxButton;
    btnCancelar: TcxButton;
    procedure BtnSairClick(Sender: TObject);
    procedure btnFiltrarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnItensClick(Sender: TObject);
    procedure cxGrid1DBTableView1CellDblClick(Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton;
      AShift: TShiftState; var AHandled: Boolean);
    procedure btnImprimirClick(Sender: TObject);
    procedure btnDuplicarClick(Sender: TObject);
    procedure btnEditarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    TipoOperacaoControleOrcamento: TTipoOperacaoControleOrcamento;
  end;

var
  frmControleOrcamentos: TfrmControleOrcamentos;

implementation

uses UsoGeral, uPrincipal, uControleOrcamentoItens, uTerminalVenda;

{$R *.dfm}

procedure TfrmControleOrcamentos.btnImprimirClick(Sender: TObject);
begin
  inherited;
  if Trim(cdsOrcamentoOrcamento.AsString) <> '' then
  begin
    if Trim(frmPrincipal.fGetParams('NmArqOrcamento')) = '' then
    begin
      pMsgAtencao('Arquivo de Relatório para emissão de Orçamento não foi definido.' + #13 +
        'Entre em contato com o suporte e relate este problema.');
      Abort;
    end;
    ZQuery1.Connection := frmPrincipal.zcoConexaoBanco;
    ZQuery1.SQL.LoadFromFile(ExtractFilePath(Application.ExeName) + 'Sql\select_pedido.txt');
    ZQuery1.ParamByName('Pedido').AsInteger := cdsOrcamentoOrcamento.AsInteger;
    ZQuery1.Open;
    ppReport.Template.FileName := ExtractFilePath(Application.ExeName) + 'Rtm\' + frmPrincipal.fGetParams('NmArqOrcamento');
    ppReport.Template.LoadFromFile;
    ppReport.Print;
  end
  else
  begin
    pMsgAtencao('Nenhum orçamento selecionado para impressão.');
    btnItens.SetFocus;
    Abort;
  end;
end;

procedure TfrmControleOrcamentos.btnItensClick(Sender: TObject);
begin
  inherited;
  if Trim(cdsOrcamentoOrcamento.AsString) <> '' then
  begin
    frmControleOrcamentoItens := TfrmControleOrcamentoItens.Create(Self);
    frmControleOrcamentoItens.ShowModal;
    FreeAndNil(frmControleOrcamentoItens);
  end
  else
  begin
    pMsgAtencao('Nenhum orçamento selecionado para visualização dos itens.');
    btnItens.SetFocus;
    Abort;
  end;
end;

procedure TfrmControleOrcamentos.BtnSairClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TfrmControleOrcamentos.btnDuplicarClick(Sender: TObject);
Var
  Qry: TZQuery;
begin
  inherited;
  if Trim(cdsOrcamentoOrcamento.AsString) <> '' then
  begin
    frmTerminalVenda := TfrmTerminalVenda.Create(nil);
    Qry := TZQuery.Create(nil);
    with Qry do
    begin
      Close;
      Connection := frmPrincipal.zcoConexaoBanco;
      SQL.Clear;

      SQL.Add('SELECT PI.icodigo');
      SQL.Add('      ,PI.ipedido');
      SQL.Add('      ,PI.iproduto');
      SQL.Add('      ,p.sdescricao AS "sproduto"');
      SQL.Add('      ,p.imarca');
      SQL.Add('      ,m.sdescricao AS "smarca"');
      SQL.Add('      ,p.igrupo');
      SQL.Add('      ,g.sdescricao AS "sgrupo"');
      SQL.Add('      ,p.isubgrupo');
      SQL.Add('      ,sg.sdescricao AS "ssubgrupo"');
      SQL.Add('      ,PI.nquantidade');
      SQL.Add('      ,PI.nvalor');
      SQL.Add('      ,(PI.nquantidade * PI.nvalor) AS "totalitem"');
      SQL.Add('      ,(pd.najustevalor)');
      SQL.Add('      ,(');
      SQL.Add('           SELECT (SUM((pi2.nquantidade * pi2.nvalor)))');
      SQL.Add('           FROM   tbpedidoitens pi2');
      SQL.Add('           WHERE  pi2.ipedido = PI.ipedido');
      SQL.Add('       ) AS "totalpedidobruto"');
      SQL.Add('      ,(');
      SQL.Add('           SELECT (SUM((pi2.nquantidade * pi2.nvalor)) + (pd.najustevalor))');
      SQL.Add('           FROM   tbpedidoitens pi2');
      SQL.Add('           WHERE  pi2.ipedido = PI.ipedido');
      SQL.Add('       ) AS "totalpedidoliquido"');
      SQL.Add('FROM   tbpedidoitens PI');
      SQL.Add('INNER JOIN tbpedido pd ON pd.icodigo = PI.ipedido');
      SQL.Add('INNER JOIN tbproduto p ON p.icodigo = PI.iproduto');
      SQL.Add('INNER JOIN tbmarca m ON m.icodigo = p.imarca');
      SQL.Add('INNER JOIN tbsubgrupo sg ON sg.icodigo = p.isubgrupo AND sg.igrupo = p.igrupo');
      SQL.Add('INNER JOIN tbgrupo g ON g.icodigo = sg.igrupo');
      SQL.Add('WHERE  PI.ipedido = :pedido');
      SQL.Add('GROUP BY PI.icodigo');
      SQL.Add('      	,p.sDescricao');
      SQL.Add('      	,p.imarca');
      SQL.Add('      	,m.sdescricao');
      SQL.Add('      	,p.igrupo');
      SQL.Add('      	,g.sdescricao');
      SQL.Add('      	,p.isubgrupo');
      SQL.Add('      	,sg.sdescricao');
      SQL.Add('      	,(pd.najustevalor)');
      SQL.Add('ORDER BY PI.icodigo');

      ParamByName('pedido').AsInteger := cdsOrcamentoOrcamento.Value;

      Open;
      First;
      while not Eof do
      begin
        frmTerminalVenda.InsereItemGrid(FieldByName('iproduto').Value, FieldByName('sproduto').Value,
          FormatFloat('#,##0.00', FieldByName('nquantidade').Value), FormatCurr('#,##0.00', FieldByName('nvalor').Value),
          FormatCurr('#,##0.00', FieldByName('nquantidade').Value * FieldByName('nvalor').Value), '');

        frmTerminalVenda.edtSubtotal.Value := frmTerminalVenda.TotalPedido;
        frmTerminalVenda.edtTotal.Value := frmTerminalVenda.TotalPedido;

        Next;
      end;
      Open;
    end;

    frmTerminalVenda.ShowModal;
    FreeAndNil(frmTerminalVenda);
  end
  else
  begin
    pMsgAtencao('Nenhum orçamento selecionado para duplicar.');
    btnItens.SetFocus;
    Abort;
  end;
end;

procedure TfrmControleOrcamentos.cxGrid1DBTableView1CellDblClick(Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo;
  AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
begin
  inherited;
  btnItens.OnClick(btnItens);
end;

procedure TfrmControleOrcamentos.btnEditarClick(Sender: TObject);
Var
  Qry: TZQuery;
begin
  inherited;
  if Trim(cdsOrcamentoOrcamento.AsString) <> '' then
  begin
    frmTerminalVenda := TfrmTerminalVenda.Create(nil);
    Qry := TZQuery.Create(nil);
    with Qry do
    begin
      Close;
      Connection := frmPrincipal.zcoConexaoBanco;
      SQL.Clear;

      SQL.Add('SELECT PI.icodigo');
      SQL.Add('      ,PI.ipedido');
      SQL.Add('      ,PI.iproduto');
      SQL.Add('      ,p.sdescricao AS "sproduto"');
      SQL.Add('      ,p.imarca');
      SQL.Add('      ,m.sdescricao AS "smarca"');
      SQL.Add('      ,p.igrupo');
      SQL.Add('      ,g.sdescricao AS "sgrupo"');
      SQL.Add('      ,p.isubgrupo');
      SQL.Add('      ,sg.sdescricao AS "ssubgrupo"');
      SQL.Add('      ,PI.nquantidade');
      SQL.Add('      ,PI.nvalor');
      SQL.Add('      ,(PI.nquantidade * PI.nvalor) AS "totalitem"');
      SQL.Add('      ,(pd.najustevalor)');
      SQL.Add('      ,(');
      SQL.Add('           SELECT (SUM((pi2.nquantidade * pi2.nvalor)))');
      SQL.Add('           FROM   tbpedidoitens pi2');
      SQL.Add('           WHERE  pi2.ipedido = PI.ipedido');
      SQL.Add('       ) AS "totalpedidobruto"');
      SQL.Add('      ,(');
      SQL.Add('           SELECT (SUM((pi2.nquantidade * pi2.nvalor)) + (pd.najustevalor))');
      SQL.Add('           FROM   tbpedidoitens pi2');
      SQL.Add('           WHERE  pi2.ipedido = PI.ipedido');
      SQL.Add('       ) AS "totalpedidoliquido"');
      SQL.Add('FROM   tbpedidoitens PI');
      SQL.Add('INNER JOIN tbpedido pd ON pd.icodigo = PI.ipedido');
      SQL.Add('INNER JOIN tbproduto p ON p.icodigo = PI.iproduto');
      SQL.Add('INNER JOIN tbmarca m ON m.icodigo = p.imarca');
      SQL.Add('INNER JOIN tbsubgrupo sg ON sg.icodigo = p.isubgrupo AND sg.igrupo = p.igrupo');
      SQL.Add('INNER JOIN tbgrupo g ON g.icodigo = sg.igrupo');
      SQL.Add('WHERE  PI.ipedido = :pedido');
      SQL.Add('GROUP BY PI.icodigo');
      SQL.Add('      	,p.sDescricao');
      SQL.Add('      	,p.imarca');
      SQL.Add('      	,m.sdescricao');
      SQL.Add('      	,p.igrupo');
      SQL.Add('      	,g.sdescricao');
      SQL.Add('      	,p.isubgrupo');
      SQL.Add('      	,sg.sdescricao');
      SQL.Add('      	,(pd.najustevalor)');
      SQL.Add('ORDER BY PI.icodigo');

      ParamByName('pedido').AsInteger := cdsOrcamentoOrcamento.Value;

      Open;
      First;
      while not Eof do
      begin
        frmTerminalVenda.InsereItemGrid(FieldByName('iproduto').Value, FieldByName('sproduto').Value,
          FormatFloat('#,##0.00', FieldByName('nquantidade').Value), FormatCurr('#,##0.00', FieldByName('nvalor').Value),
          FormatCurr('#,##0.00', FieldByName('nquantidade').Value * FieldByName('nvalor').Value), '');

        frmTerminalVenda.edtSubtotal.Value := frmTerminalVenda.TotalPedido;
        frmTerminalVenda.edtTotal.Value := frmTerminalVenda.TotalPedido;

        Next;
      end;
      Open;
    end;
    frmTerminalVenda.iCodigoPedidoEdicao := cdsOrcamentoOrcamento.Value;
    frmTerminalVenda.bisEdicaoOrcamento := True;

    frmTerminalVenda.ShowModal;
    FreeAndNil(frmTerminalVenda);

  end
  else
  begin
    pMsgAtencao('Nenhum orçamento selecionado para edição.');
    btnItens.SetFocus;
    Abort;
  end;
end;

procedure TfrmControleOrcamentos.btnFiltrarClick(Sender: TObject);
var
  Qry: TZQuery;
begin
  inherited;
  Qry := TZQuery.Create(nil);
  with Qry do
  begin
    Connection := frmPrincipal.zcoConexaoBanco;
    SQL.Clear;
    SQL.Add('select tbpedido.icodigo, ddatapedido, icliente,');
    SQL.Add('coalesce(tbconsumidor.snome, tbpessoa.snome, ''CONSUMIDOR'') as snome,');
    SQL.Add('ntotalprodutos + najustevalor as total');
    SQL.Add('from tbpedido');
    SQL.Add('left outer join tbpessoa on tbpessoa.icodigo = tbpedido.icliente');
    SQL.Add('left outer join tbconsumidor on tbconsumidor.ipedido = tbpedido.icodigo');
    SQL.Add('where ddatapedido between :dataini and :datafim and bpedido = ''N''');
    { Caso a finalidade da rotina seja edição de orçamento, selecionar apenas
      orçamentos em aberto (iflagsituacao = 1).
    }
    if TipoOperacaoControleOrcamento = TTpOprCtrlOrcmntEdicaoOrcamento then
      SQL.Add('and iflagsituacao = 1');
    ParamByName('dataIni').AsDateTime := StrToDate(edtDataInicio.Text);
    ParamByName('dataFim').AsDateTime := StrToDate(edtDataFinal.Text);
    Open;

    if not isEmpty then
    begin
      cdsOrcamento.Close;
      cdsOrcamento.CreateDataSet;
      cdsOrcamento.EmptyDataSet;
      cdsOrcamento.Open;
      First;
      while not Eof do
      begin
        cdsOrcamento.Append;
        cdsOrcamentoOrcamento.Value := FieldByName('icodigo').AsInteger;
        cdsOrcamentoData.Value := FieldByName('ddatapedido').AsDateTime;
        if not FieldByName('iCliente').IsNull then
          cdsOrcamentoCodigoCliente.Value := FieldByName('iCliente').AsInteger;
        cdsOrcamentoNomeCliente.Value := FieldByName('sNome').AsString;
        cdsOrcamentoValor.Value := FieldByName('total').AsFloat;
        cdsOrcamento.Post;
        Next;
      end;
    end;
  end;
end;

procedure TfrmControleOrcamentos.FormCreate(Sender: TObject);
begin
  inherited;
  TipoOperacaoControleOrcamento := TTpOprCtrlOrcmntConsultaPadrao;
end;

procedure TfrmControleOrcamentos.FormShow(Sender: TObject);
begin
  inherited;
  if TipoOperacaoControleOrcamento = TTpOprCtrlOrcmntEdicaoOrcamento then
  begin
    btnDuplicar.Visible := False;
    btnEditar.Visible := True;
    btnCancelar.Visible := False;
  end
  else if TipoOperacaoControleOrcamento = TTpOprCtrlOrcmntConsultaPadrao then
  begin
    btnEditar.Visible := False;
    btnDuplicar.Visible := True;
    btnCancelar.Visible := False;
  end
  else if TipoOperacaoControleOrcamento = TTpOprCtrlOrcmntCancelaOrcamento then
  begin
    btnEditar.Visible := False;
    btnDuplicar.Visible := False;
    btnCancelar.Visible := True;
  end;
  edtDataInicio.Text := FormatDateTime('dd/mm/yyyy', fDataHoraSrv(frmPrincipal.zcoConexaoBanco));
  edtDataFinal.Text := FormatDateTime('dd/mm/yyyy', fDataHoraSrv(frmPrincipal.zcoConexaoBanco));
  btnFiltrar.OnClick(btnFiltrar);
end;

end.
