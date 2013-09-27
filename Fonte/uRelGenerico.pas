unit uRelGenerico;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, cxGraphics, cxLookAndFeels, cxLookAndFeelPainters,
  Vcl.Menus, Vcl.StdCtrls, cxButtons, Vcl.ExtCtrls, JvExControls, JvNavigationPane, Data.DB,
  ZAbstractRODataset, ZAbstractDataset, ZDataset, ppDB, ppDBPipe, ppParameter, ppDesignLayer,
  ppModule, raCodMod, ppBands, ppCtrls, ppClass, ppVar, dxGDIPlusClasses, ppPrnabl, ppCache, ppComm,
  uPesquisaGeral, ZConnection, cxTextEdit,
  ppRelatv, ppProd, ppReport, uprincipal;

type
  TfrmRelGenerico = class(TForm)
    JvNavPaneToolPanel1: TJvNavPaneToolPanel;
    Panel1: TPanel;
    btnSair: TcxButton;
    btnImprimir: TcxButton;
    ppRelatorio: TppReport;
    ppHeaderBand1: TppHeaderBand;
    ppImgSage: TppImage;
    LabelTitulo: TppLabel;
    ppLbDetalhe: TppLabel;
    pplbSistema: TppLabel;
    ppDetailBand1: TppDetailBand;
    ppFooterBand1: TppFooterBand;
    pplineRodape: TppLine;
    pplbPaginas: TppSystemVariable;
    pplbDataHora: TppSystemVariable;
    ppSummaryBand1: TppSummaryBand;
    ppDesignLayers1: TppDesignLayers;
    ppDesignLayer1: TppDesignLayer;
    ppParameterList1: TppParameterList;
    ppDBPipeline: TppDBPipeline;
    dsRelatorio: TDataSource;
    qrRelatorio: TZQuery;
    procedure btnSairClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    function ChamaPesquisa(Sender: TObject; pzcoConnection: TZConnection; sParametro: string = ''; pExibeBtnCad: Boolean = False;
      pExibeBtnOk: Boolean = True): TResultArray;
  end;

var
  frmRelGenerico: TfrmRelGenerico;

implementation

{$R *.dfm}

procedure TfrmRelGenerico.btnSairClick(Sender: TObject);
begin
  Close;
end;

function TfrmRelGenerico.ChamaPesquisa(Sender: TObject; pzcoConnection: TZConnection; sParametro: string = ''; pExibeBtnCad: Boolean = False;
  pExibeBtnOk: Boolean = True): TResultArray;
begin
  if TWinControl(Sender) is TEdit then
    Result := Pesquisar(TEdit(Sender).Tag, TEdit(Sender).Text, pzcoConnection, sParametro, pExibeBtnCad)
  else if TWinControl(Sender) is TcxTextEdit then
    Result := Pesquisar(TcxTextEdit(Sender).Tag, TcxTextEdit(Sender).Text, pzcoConnection, sParametro, pExibeBtnCad)
  else if TWinControl(Sender) is TcxButton then
    Result := Pesquisar(TcxButton(Sender).Tag, TcxButton(Sender).Hint, pzcoConnection, sParametro, pExibeBtnCad, pExibeBtnOk);

  SetLength(Result, Length(Result));
end;

end.
