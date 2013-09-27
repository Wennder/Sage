unit uRelPedidosEmitidos;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uCadastroGenerico, JvExControls,
  JvComponent, JvNavigationPane, StdCtrls, Mask, DB, ppDB,
  ppDBPipe, ZAbstractRODataset, ZAbstractDataset, ZDataset, ZConnection,
  ppBands, ppCache, ppClass, ppComm, ppRelatv, ppProd, ppReport, ppCtrls,
  ppPrnabl, ppVar, ppParameter, uCliente, cxGraphics, cxLookAndFeels,
  cxLookAndFeelPainters, Menus, cxButtons, ExtCtrls, cxControls, cxContainer,
  cxEdit, cxTextEdit, cxLabel, Vcl.ComCtrls, dxCore, cxDateUtils, cxMaskEdit,
  cxDropDownEdit, cxCalendar, UsoGeral, ppDesignLayer, dxGDIPlusClasses, dxSkinsCore,
  dxSkinOffice2010Silver, ppModule, raCodMod;

type
  TfrmPedidosEmitidos = class(TfrmCadastroGenerico)
    Report: TppReport;
    ppDBPipeline1: TppDBPipeline;
    dsPedidosEmitidos: TDataSource;
    stCliente: TStaticText;
    QryPedidosEmitidos: TZQuery;
    edtCliente: TcxTextEdit;
    Label1: TcxLabel;
    Label3: TcxLabel;
    lblCliente: TcxLabel;
    edtDataInicio: TcxDateEdit;
    edtDataFinal: TcxDateEdit;
    ppHeaderBand1: TppHeaderBand;
    ppImage1: TppImage;
    LabelTitulo: TppLabel;
    ppLbDetalhe: TppLabel;
    ppLabel15: TppLabel;
    ppLine3: TppLine;
    ppLabel9: TppLabel;
    ppLabel10: TppLabel;
    ppLabel13: TppLabel;
    ppLabel8: TppLabel;
    ppLabel6: TppLabel;
    ppLabel7: TppLabel;
    ppDetailBand1: TppDetailBand;
    ppDBText9: TppDBText;
    ppDBText10: TppDBText;
    ppDBText11: TppDBText;
    ppVariable1: TppVariable;
    ppFooterBand1: TppFooterBand;
    ppLine2: TppLine;
    ppSystemVariable1: TppSystemVariable;
    ppSystemVariable2: TppSystemVariable;
    ppSummaryBand1: TppSummaryBand;
    ppLabel5: TppLabel;
    ppDBCalc1: TppDBCalc;
    ppGroup1: TppGroup;
    ppGroupHeaderBand1: TppGroupHeaderBand;
    ppDBText2: TppDBText;
    ppDBCalc2: TppDBCalc;
    ppVariable2: TppVariable;
    ppDBText1: TppDBText;
    ppLabel1: TppLabel;
    ppLabel2: TppLabel;
    ppLabel3: TppLabel;
    ppLabel4: TppLabel;
    ppDBText3: TppDBText;
    ppDBText4: TppDBText;
    ppGroupFooterBand1: TppGroupFooterBand;
    raCodeModule1: TraCodeModule;
    ppDesignLayers1: TppDesignLayers;
    ppDesignLayer1: TppDesignLayer;
    procedure edtClienteKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edtClienteKeyPress(Sender: TObject; var Key: Char);
    procedure edtClienteExit(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnImprimirClick(Sender: TObject);
  private
    { Private declarations }
    oCliente: TCliente;
  public
    { Public declarations }
  end;

var
  frmPedidosEmitidos: TfrmPedidosEmitidos;

implementation

uses uPrincipal;

{$R *.dfm}

procedure TfrmPedidosEmitidos.edtClienteKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  if Key = vk_F2 then
  begin
    edtCliente.Text := ChamaPesquisa(TEdit(Sender), frmPrincipal.zcoConexaoBanco)[0];
    Perform(WM_NEXTDLGCTL, 0, 0);
  end;
end;

procedure TfrmPedidosEmitidos.edtClienteKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  KeyPressNumerico(Key);
end;

procedure TfrmPedidosEmitidos.btnImprimirClick(Sender: TObject);
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
      Sql.Add('SELECT * FROM VWPEDIDO');
      Sql.Add('WHERE  sstatus = ''A''');
      Sql.Add('  AND ddatapedido BETWEEN :DataI AND :DataF');

      if Trim(edtCliente.Text) <> '' then
      begin
        Sql.Add('  AND iCliente = :Cliente');
        ParamByName('Cliente').AsString := edtCliente.Text;
      end;
      Sql.Add('order by ddatapedido, thorapedido');
      ParamByName('DataI').AsDateTime := StrToDate(edtDataInicio.Text);
      ParamByName('DataF').AsDateTime := StrToDate(edtDataFinal.Text);
      Open;
      if isEmpty then
      begin
        pMsgInfo('Não existe(m) registro(s) para emissão do relatório.');
        edtCliente.SetFocus;
        Abort;
      end;
    end;
    Report.Print;
  end;
end;

procedure TfrmPedidosEmitidos.edtClienteExit(Sender: TObject);
begin
  inherited;
  if edtCliente.Text = '' then
  begin
    stCliente.Caption := '';
    Exit;
  end;
  oCliente.bPesquisaCliente(edtCliente.Text);
  stCliente.Caption := oCliente.sGetNome;
end;

procedure TfrmPedidosEmitidos.FormShow(Sender: TObject);
begin
  inherited;
  oCliente := TCliente.Create(frmPrincipal.zcoConexaoBanco);
end;

end.
