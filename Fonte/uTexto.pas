unit uTexto;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxContainer, cxEdit, Vcl.Menus, Vcl.StdCtrls, cxButtons, Vcl.ExtCtrls,
  cxTextEdit, cxMemo;

type
  TfrmTexto = class(TForm)
    mmTexto: TcxMemo;
    pn: TPanel;
    BtnSair: TcxButton;
    procedure BtnSairClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmTexto: TfrmTexto;

implementation

{$R *.dfm}

procedure TfrmTexto.BtnSairClick(Sender: TObject);
begin
  Close;
end;

end.
