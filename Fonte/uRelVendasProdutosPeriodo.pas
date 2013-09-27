unit uRelVendasProdutosPeriodo;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uCadastroGenerico, StdCtrls, Mask, JvXPCore, JvXPButtons,
  JvExControls, JvComponent, JvNavigationPane, DB,
  ZAbstractRODataset, ZAbstractDataset, ZDataset, ppDB, ppDBPipe,
  ppParameter, ppCtrls, ppBands, ppVar, ppPrnabl, ppClass, ppCache, ppComm,
  ppRelatv, ppProd, ppReport, ZConnection, ppModule, raCodMod, cxGraphics,
  cxLookAndFeels, cxLookAndFeelPainters, Menus, cxButtons, ExtCtrls, cxControls,
  cxContainer, cxEdit, cxLabel, Vcl.ComCtrls, dxCore, cxDateUtils, cxTextEdit,
  cxMaskEdit, cxDropDownEdit, cxCalendar, UsoGeral, dxGDIPlusClasses,
  ppDesignLayer, dxSkinsCore, dxSkinOffice2010Silver;

type
  TfrmRelVendasProdutosPeriodo = class(TfrmCadastroGenerico)
    Report: TppReport;
    ppHeaderBand1: TppHeaderBand;
    ppDetailBand1: TppDetailBand;
    ppDBText3: TppDBText;
    ppFooterBand1: TppFooterBand;
    ppParameterList1: TppParameterList;
    ppDBPipeline1: TppDBPipeline;
    dsPedidosEmitidos: TDataSource;
    ppVariable1: TppVariable;
    raCodeModule1: TraCodeModule;
    ppGroup1: TppGroup;
    ppGroupHeaderBand1: TppGroupHeaderBand;
    ppGroupFooterBand1: TppGroupFooterBand;
    ppLabel5: TppLabel;
    ppDBText4: TppDBText;
    QryPedidosEmitidos: TZQuery;
    Label3: TcxLabel;
    edtDataInicio: TcxDateEdit;
    edtDataFinal: TcxDateEdit;
    Label1: TcxLabel;
    ppDesignLayers1: TppDesignLayers;
    ppDesignLayer1: TppDesignLayer;
    ppImage1: TppImage;
    LabelTitulo: TppLabel;
    ppLbDetalhe: TppLabel;
    ppLabel15: TppLabel;
    ppLine3: TppLine;
    ppLabel8: TppLabel;
    ppLabel9: TppLabel;
    ppLabel13: TppLabel;
    ppLine2: TppLine;
    ppSystemVariable1: TppSystemVariable;
    ppSystemVariable2: TppSystemVariable;
    ppVariable2: TppVariable;
    ppLabel1: TppLabel;
    ppDBText1: TppDBText;
    procedure FormShow(Sender: TObject);
    procedure btnImprimirClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmRelVendasProdutosPeriodo: TfrmRelVendasProdutosPeriodo;

implementation

uses uPrincipal;

{$R *.dfm}

procedure TfrmRelVendasProdutosPeriodo.btnImprimirClick(Sender: TObject);
begin
  inherited;
  if (Trim(edtDataInicio.Text) <> '') and (Trim(edtDataFinal.Text) <> '') then
  begin
    if edtDataFinal.Date < edtDataInicio.Date then
    begin
      pMsgAtencao('Data final não pode ser menor que a data inicial.');
      edtDataFinal.SetFocus;
      Abort;
    end;

    ppLbDetalhe.Caption := 'Período de: ' + edtDataInicio.Text + ' à ' + edtDataFinal.Text;
    with QryPedidosEmitidos do
    begin
      Connection := frmPrincipal.zcoConexaoBanco;
      Close;
      Sql.Clear;
      Sql.Add('SELECT tbproduto.sreferencia AS iproduto');
      Sql.Add('      ,tbproduto.sdescricao');
      Sql.Add('      ,SUM(tbpedidoitens.nquantidade) AS nqtd');
      Sql.Add('      ,tbpedidoitens.nvalor');
      Sql.Add('      ,tbpedido.ddatapedido');
      Sql.Add('FROM   tbpedido');
      Sql.Add('JOIN tbpedidoitens ON tbpedidoitens.ipedido = tbpedido.icodigo');
      Sql.Add('JOIN tbproduto ON tbproduto.icodigo = tbpedidoitens.iproduto');
      Sql.Add('WHERE  tbpedido.ddatapedido BETWEEN :DataI AND :DataF');
      Sql.Add('  AND tbpedido.sstatus = ''A''');
      Sql.Add('  AND tbpedido.bcupomfiscal = TRUE');
      Sql.Add('GROUP BY tbproduto.sreferencia');
      Sql.Add('      	,tbproduto.sdescricao');
      Sql.Add('      	,tbpedidoitens.nvalor');
      Sql.Add('      	,tbpedido.ddatapedido');
      Sql.Add('ORDER BY tbpedido.ddatapedido');
      Sql.Add('      	 ,tbproduto.sdescricao');

      ParamByName('DataI').AsDate := edtDataInicio.Date;
      ParamByName('DataF').AsDate := edtDataFinal.Date;
      Open;
      if isEmpty then
      begin
        pMsgInfo('Não existe(m) registro(s) para emissão do relatório.');
        edtDataInicio.SetFocus;
        Abort;
      end;
    end;
    Report.Print;
  end;
end;

procedure TfrmRelVendasProdutosPeriodo.FormShow(Sender: TObject);
begin
  inherited;
  QryPedidosEmitidos.Connection := frmPrincipal.zcoConexaoBanco;
end;

end.
