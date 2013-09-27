unit uSplash;

interface

uses
   Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
   Dialogs, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters,
   cxContainer, cxEdit, cxLabel, dxGDIPlusClasses, ExtCtrls, dxSkinsCore,
   dxSkinOffice2010Blue, dxSkinOffice2010Silver;

type
   TfSplash = class(TForm)
      pPrincipal: TPanel;
      imgFundo: TImage;
      lbStatus: TcxLabel;
   private
      { Private declarations }
   public
      { Public declarations }
   end;

var
   fSplash: TfSplash;

implementation

{$R *.dfm}

end.
