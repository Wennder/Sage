unit uRB;

{$I ppIfDef.pas}
interface
uses
 {$IFDEF Delphi7} XPMan,{$ENDIF}
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ppComm, ppEndUsr, ppDB, ppDBPipe, ppRelatv, ppProd,
  ppClass, ppReport, DB, ZAbstractRODataset, ZAbstractDataset, ZDataset,
  ppBands, ppCache, ppModule, raCodMod, ppCtrls, ppPrnabl, ppParameter;

type
  TfRB = class(TForm)
    ppDesigner1: TppDesigner;
    Button1: TButton;
    ppReport1: TppReport;
    ppDBPipeline1: TppDBPipeline;
    ZQuery1: TZQuery;
    DataSource1: TDataSource;
    ppParameterList1: TppParameterList;
    ppHeaderBand1: TppHeaderBand;
    ppLabel2: TppLabel;
    ppDBText1: TppDBText;
    ppDBText2: TppDBText;
    ppDBText3: TppDBText;
    ppDBText5: TppDBText;
    ppDBText6: TppDBText;
    ppDBText7: TppDBText;
    ppDBText8: TppDBText;
    ppDBText9: TppDBText;
    ppDBText10: TppDBText;
    ppDBText11: TppDBText;
    ppDBText12: TppDBText;
    ppDBText13: TppDBText;
    ppDBText14: TppDBText;
    ppDetailBand1: TppDetailBand;
    ppDBText15: TppDBText;
    ppDBText16: TppDBText;
    ppDBText17: TppDBText;
    ppDBText18: TppDBText;
    ppDBText19: TppDBText;
    ppDBText20: TppDBText;
    ppDBText21: TppDBText;
    ppFooterBand1: TppFooterBand;
    ppLabel1: TppLabel;
    ppLabel3: TppLabel;
    raCodeModule1: TraCodeModule;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fRB: TfRB;

implementation

uses uPrincipal;
{$R *.dfm}

procedure TfRB.Button1Click(Sender: TObject);
begin
  ZQuery1.Connection := frmPrincipal.zcoConexaoBanco;
  ZQuery1.Open;
  ppDesigner1.ShowModal;
end;

end.
