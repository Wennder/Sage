unit uRelEntradaPeriodo;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uCadastroGenerico, DB, ZAbstractRODataset, ZAbstractDataset,
  ZDataset, ppDB, ppDBPipe, ppParameter, ppVar, ppBands, ppCtrls, ppPrnabl,
  ppClass, ppCache, ppComm, ppRelatv, ppProd, ppReport, StdCtrls, Mask,
  JvExControls, JvComponent,
  JvNavigationPane, ppModule, raCodMod, ZConnection, cxGraphics, cxLookAndFeels,
  cxLookAndFeelPainters, Menus, cxButtons, ExtCtrls, cxControls, cxContainer,
  cxEdit, cxLabel, Vcl.ComCtrls, dxCore, cxDateUtils, cxTextEdit, cxMaskEdit,
  cxDropDownEdit, cxCalendar, ppDesignLayer, dxGDIPlusClasses, dxSkinsCore,
  dxSkinOffice2010Silver, cxImageComboBox;

type
  TfrmEntradaPeriodo = class(TfrmCadastroGenerico)
    Report: TppReport;
    ppParameterList1: TppParameterList;
    ppDBPipeline1: TppDBPipeline;
    dsPedidosEmitidos: TDataSource;
    ppHeaderBand1: TppHeaderBand;
    ppDetailBand1: TppDetailBand;
    ppDBText8: TppDBText;
    ppDBText9: TppDBText;
    ppDBText10: TppDBText;
    ppDBText11: TppDBText;
    ppVariable1: TppVariable;
    ppFooterBand1: TppFooterBand;
    ppGroup1: TppGroup;
    ppGroupHeaderBand1: TppGroupHeaderBand;
    ppLabel2: TppLabel;
    ppLabel3: TppLabel;
    ppDBText1: TppDBText;
    ppDBText2: TppDBText;
    ppDBText3: TppDBText;
    ppLabel4: TppLabel;
    ppDBText4: TppDBText;
    ppLabel5: TppLabel;
    ppDBText5: TppDBText;
    ppLabel7: TppLabel;
    ppDBText6: TppDBText;
    ppLine1: TppLine;
    ppGroupFooterBand1: TppGroupFooterBand;
    ppLabel14: TppLabel;
    raCodeModule1: TraCodeModule;
    Qry: TZQuery;
    Label3: TcxLabel;
    ppDesignLayers1: TppDesignLayers;
    ppDesignLayer1: TppDesignLayer;
    edtDataInicio: TcxDateEdit;
    edtDataFinal: TcxDateEdit;
    ppImage1: TppImage;
    LabelTitulo: TppLabel;
    ppLbDetalhe: TppLabel;
    ppLabel15: TppLabel;
    ppLine2: TppLine;
    ppSystemVariable1: TppSystemVariable;
    ppSystemVariable2: TppSystemVariable;
    ppLabel9: TppLabel;
    ppLabel10: TppLabel;
    ppLabel11: TppLabel;
    ppLabel12: TppLabel;
    ppLabel13: TppLabel;
    ppShape1: TppShape;
    Label1: TcxLabel;
    ppDBText7: TppDBText;
    ppLabel1: TppLabel;
    ppSummaryBand1: TppSummaryBand;
    ppLabel6: TppLabel;
    ppDBCalc1: TppDBCalc;
    cxLabel1: TcxLabel;
    cbsituacao: TcxImageComboBox;
    ppLabel16: TppLabel;
    ppDBText13: TppDBText;
    ppDBCalc2: TppDBCalc;
    procedure FormShow(Sender: TObject);
    procedure btnImprimirClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmEntradaPeriodo: TfrmEntradaPeriodo;

implementation

uses uPrincipal, UsoGeral, uProcedimentosBanco;

{$R *.dfm}

procedure TfrmEntradaPeriodo.btnImprimirClick(Sender: TObject);
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
    with Qry do
    begin
      Connection := frmPrincipal.zcoConexaoBanco;
      Close;
      Sql.Clear;
      Sql.Add('SELECT *, cast(case when tbentrada.sstatus = ''A'' then ''Ativa''');
      Sql.Add('                    else ''Cancelada'' END as varchar(10)) as situacao,');
      Sql.Add('(tbentradaitens.nquantidade * tbentradaitens.valor) as ntotalitem');
      Sql.Add('FROM   tbentrada');
      Sql.Add('JOIN tbentradaitens ON tbentradaitens.ientrada = tbentrada.icodigo');
      Sql.Add('JOIN tbproduto ON tbproduto.icodigo = tbentradaitens.iproduto');
      Sql.Add('JOIN tbpessoa ON tbpessoa.icodigo = tbentrada.fornecedor');
      Sql.Add('WHERE  tbentrada.dataentrada BETWEEN :DataI AND :DataF');

      if cbsituacao.ItemIndex > 0 then
      begin
        Sql.Add('and tbentrada.sstatus = :status');
        ParamByName('status').AsString := cbsituacao.EditValue;
      end;

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

procedure TfrmEntradaPeriodo.FormShow(Sender: TObject);
begin
  inherited;
  edtDataInicio.Date := fDataHoraSrv(frmPrincipal.zcoConexaoBanco);
  edtDataFinal.Date := edtDataInicio.Date;
  Qry.Connection := frmPrincipal.zcoConexaoBanco;
end;

end.
