unit uMensagem;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxContainer, cxEdit, cxTextEdit, cxMemo, Menus,
  cxButtons, cxGroupBox, ExtCtrls, cxLabel, dxGDIPlusClasses, cxImage,
  uFrmTituloForm, dxSkinsCore, dxSkinOffice2010Silver, ImgList, JvExControls,
  JvNavigationPane;

type
  TfMensagem = class(TForm)
    pnlBtnOk: TPanel;
    btnOK: TcxButton;
    pnlBtnSimNao: TPanel;
    fFrmTituloForm1: TfFrmTituloForm;
    btnNao: TcxButton;
    btnSim: TcxButton;
    imgGeral: TcxImageList;
    lbMensagem: TcxLabel;
    pnltopo: TPanel;
    pnlDetalhes: TPanel;
    btnDetalhes: TcxButton;
    pnlTextoDetalhes: TPanel;
    mmTextoDetalhes: TcxMemo;
    procedure btnOKClick(Sender: TObject);
    procedure btnNaoClick(Sender: TObject);
    procedure btnSimClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnDetalhesClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fMensagem: TfMensagem;
  vFocoSim, vResult: Boolean;
  vIndexImagem: Integer;

implementation

{$R *.dfm}

procedure TfMensagem.btnDetalhesClick(Sender: TObject);
begin
  if not pnlTextoDetalhes.Visible then
  begin
    Self.Height := 300;
    pnlTextoDetalhes.Visible := True;
    pnlTextoDetalhes.Enabled := True;
    btnDetalhes.Caption := '<< Detalhes';
    mmTextoDetalhes.SetFocus;
  end
  else
  begin
    Self.Height := 200;
    pnlTextoDetalhes.Visible := False;
    pnlTextoDetalhes.Enabled := False;
    btnDetalhes.Caption := 'Detalhes >>';
  end;
end;

procedure TfMensagem.btnNaoClick(Sender: TObject);
begin
  vResult := False;
  Close;
end;

procedure TfMensagem.btnOKClick(Sender: TObject);
begin
  Close;
end;

procedure TfMensagem.btnSimClick(Sender: TObject);
begin
  vResult := True;
  Close;
end;

procedure TfMensagem.FormShow(Sender: TObject);
begin
  fFrmTituloForm1.pnlTituloForm.Images := imgGeral;
  fFrmTituloForm1.pnlTituloForm.ImageIndex := vIndexImagem;

  if pnlBtnSimNao.Enabled then
  begin
    if vFocoSim then
      btnSim.SetFocus
    else
      btnNao.SetFocus;
  end;

  Self.Height := 200;

  if Trim(mmTextoDetalhes.Text) <> '' then
    pnlDetalhes.Visible := True
  else
    pnlDetalhes.Visible := False;
end;

end.
