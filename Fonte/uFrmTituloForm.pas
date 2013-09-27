unit uFrmTituloForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, JvExControls, JvNavigationPane, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit, cxLabel, ImgList,
  dxGDIPlusClasses, cxImage, dxSkinsCore, dxSkinOffice2010Blue,
  dxSkinOffice2010Silver;

type
  TfFrmTituloForm = class(TFrame)
    pnlTituloForm: TJvNavPanelHeader;
    cxImg: TcxImageList;
    lbTitulo: TcxLabel;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

end.
