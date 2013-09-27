unit uRelEntradaProdutoPeriodo;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uCadastroGenerico, JvExControls,
  JvComponent, JvNavigationPane, ppParameter, ppModule,
  raCodMod, ppBands, ppClass, ppVar, ppCtrls, ppPrnabl, ppCache, ppProd,
  ppReport, DB, ZAbstractRODataset, ZAbstractDataset, ZDataset, ppComm,
  ppRelatv, ppDB, ppDBPipe, StdCtrls, Mask, ZConnection, cxGraphics,
  cxLookAndFeels, cxLookAndFeelPainters, Menus, cxButtons, ExtCtrls, cxControls,
  cxContainer, cxEdit, cxLabel, Vcl.ComCtrls, dxCore, cxDateUtils, cxTextEdit,
  cxMaskEdit, cxDropDownEdit, cxCalendar, UsoGeral, ppDesignLayer,
  dxGDIPlusClasses;

type
  TfrmRelEntradaProdutoPeriodo = class(TfrmCadastroGenerico)
    ppDBPipeline1: TppDBPipeline;
    dsPedidosEmitidos: TDataSource;
    Report: TppReport;
    ppHeaderBand1: TppHeaderBand;
    ppDetailBand1: TppDetailBand;
    ppDBText1: TppDBText;
    ppDBText2: TppDBText;
    ppDBText3: TppDBText;
    ppFooterBand1: TppFooterBand;
    ppGroup1: TppGroup;
    ppGroupHeaderBand1: TppGroupHeaderBand;
    ppLabel5: TppLabel;
    ppDBText4: TppDBText;
    ppGroupFooterBand1: TppGroupFooterBand;
    raCodeModule1: TraCodeModule;
    ppParameterList1: TppParameterList;
    QryPedidosEmitidos: TZQuery;
    Label3: TcxLabel;
    edtDataInicio: TcxDateEdit;
    edtDataFinal: TcxDateEdit;
    ppDesignLayers1: TppDesignLayers;
    ppDesignLayer1: TppDesignLayer;
    ppImage1: TppImage;
    LabelTitulo: TppLabel;
    ppLbDetalhe: TppLabel;
    ppLabel15: TppLabel;
    ppLine3: TppLine;
    ppLabel8: TppLabel;
    ppLabel9: TppLabel;
    ppLabel11: TppLabel;
    ppLabel13: TppLabel;
    ppLine2: TppLine;
    ppSystemVariable1: TppSystemVariable;
    ppSystemVariable2: TppSystemVariable;
    Label1: TcxLabel;
    ppSummaryBand1: TppSummaryBand;
    ppLabel1: TppLabel;
    ppDBText5: TppDBText;
    ppLabel2: TppLabel;
    ppDBText6: TppDBText;
    ppDBCalc1: TppDBCalc;
    procedure FormShow(Sender: TObject);
    procedure btnImprimirClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmRelEntradaProdutoPeriodo: TfrmRelEntradaProdutoPeriodo;

implementation

uses uPrincipal, uProcedimentosBanco;

{$R *.dfm}

procedure TfrmRelEntradaProdutoPeriodo.btnImprimirClick(Sender: TObject);
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
      Sql.Add('SELECT tbproduto.icodigo AS iproduto');
      Sql.Add('      ,tbproduto.sdescricao');
      Sql.Add('      ,SUM(tbentradaitens.nquantidade) AS nqtd');
      Sql.Add('      ,tbentradaitens.valor');
      Sql.Add('      ,(SUM(tbentradaitens.nquantidade) * tbentradaitens.valor) as Total');
      Sql.Add('      ,tbentrada.dataentrada');
      Sql.Add('FROM   tbentrada');
      Sql.Add('JOIN tbentradaitens ON tbentradaitens.ientrada = tbentrada.icodigo');
      Sql.Add('JOIN tbproduto ON tbproduto.icodigo = tbentradaitens.iproduto');
      Sql.Add('WHERE  tbentrada.dataentrada BETWEEN :dataI AND :dataF');
      Sql.Add('  AND tbentrada.sstatus = ''A''');
      Sql.Add('GROUP BY tbproduto.icodigo');
      Sql.Add('      	,tbproduto.sdescricao');
      Sql.Add('      	,tbentradaitens.valor');
      Sql.Add('      	,tbentrada.dataentrada');
      Sql.Add('ORDER BY tbentrada.dataentrada');
      Sql.Add('      	 ,tbproduto.sdescricao');

      ParamByName('DataI').AsDateTime := StrToDate(edtDataInicio.Text);
      ParamByName('DataF').AsDateTime := StrToDate(edtDataFinal.Text);

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

procedure TfrmRelEntradaProdutoPeriodo.FormShow(Sender: TObject);
begin
  inherited;
  edtDataInicio.Date := fDataHoraSrv(frmPrincipal.zcoConexaoBanco);
  edtDataFinal.Date := edtDataInicio.Date;
  QryPedidosEmitidos.Connection := frmPrincipal.zcoConexaoBanco;
end;

end.
