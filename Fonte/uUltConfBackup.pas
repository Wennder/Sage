unit uUltConfBackup;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uCadastroGenerico, cxGraphics, cxLookAndFeels,
  cxLookAndFeelPainters, Vcl.Menus, dxSkinsCore, dxSkinOffice2010Silver, Vcl.StdCtrls, cxButtons,
  Vcl.ExtCtrls, JvExControls, JvNavigationPane, cxControls, cxContainer, cxEdit, cxLabel, cxTextEdit,
  cxMaskEdit, cxSpinEdit;

type
  TfrmUltConfBackup = class(TfrmCadastroGenerico)
    edtCaminhoPostGre: TcxTextEdit;
    cxLabel1: TcxLabel;
    edtSalvar: TcxTextEdit;
    cxLabel2: TcxLabel;
    cxLabel3: TcxLabel;
    edtServer: TcxTextEdit;
    cxLabel4: TcxLabel;
    edtPorta: TcxSpinEdit;
    btnDirInst: TcxButton;
    btnDirSalvar: TcxButton;
    procedure btnGravaClick(Sender: TObject);
    procedure btnDirInstClick(Sender: TObject);
    procedure btnDirSalvarClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmUltConfBackup: TfrmUltConfBackup;

implementation

Uses UsoGeral;

{$R *.dfm}

procedure TfrmUltConfBackup.btnDirInstClick(Sender: TObject);
begin
  inherited;
  edtCaminhoPostGre.Text := fGetSelectDirectory('Selecione o diretório do PostGreSQL');
end;

procedure TfrmUltConfBackup.btnGravaClick(Sender: TObject);
begin
  inherited;
  if trim(edtCaminhoPostGre.Text) = '' then
  begin
    pMsgAtencao('Caminho da instalação do PostGreSQL não foi informado.');
    edtCaminhoPostGre.SetFocus;
    Abort;
  end;

  if trim(edtSalvar.Text) = '' then
  begin
    pMsgAtencao('Caminho onde será salvo o backup não foi informado.');
    edtSalvar.SetFocus;
    Abort;
  end;

  if trim(edtServer.Text) = '' then
  begin
    pMsgAtencao('Nome do Servidor (Host) não foi informado.');
    edtServer.SetFocus;
    Abort;
  end;

  if edtPorta.Value <= 0 then
  begin
    pMsgAtencao('Porta do Servidor não foi informada.');
    edtPorta.SetFocus;
    Abort;
  end;

  fRealizaBackupPostGreSQL(edtCaminhoPostGre.Text, ExtractFilePath(Application.Exename), edtSalvar.Text, edtServer.Text, edtPorta.Value);
end;

procedure TfrmUltConfBackup.btnDirSalvarClick(Sender: TObject);
begin
  inherited;
  edtSalvar.Text := fGetSelectDirectory('Selecione o diretório para Salvar o Backup');
end;

end.
