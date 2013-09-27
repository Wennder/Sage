unit uCadastroGrupoUsuario;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uCadastroGenerico, JvExControls,
  JvComponent, JvNavigationPane, StdCtrls, uGrupoUsuario, cxGraphics,
  cxLookAndFeels, cxLookAndFeelPainters, Menus, cxButtons, ExtCtrls, cxControls,
  cxContainer, cxEdit, cxTextEdit, UsoGeral, cxLabel;

type
  TfrmCadastroGrupoUsuario = class(TfrmCadastroGenerico)
    edtCodigo: TcxTextEdit;
    edtNome: TcxTextEdit;
    lblCodigo: TcxLabel;
    lblNome: TcxLabel;
    procedure FormShow(Sender: TObject);
    procedure edtCodigoEnter(Sender: TObject);
    procedure edtCodigoExit(Sender: TObject);
    procedure edtCodigoKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edtCodigoKeyPress(Sender: TObject; var Key: Char);
    procedure btnGravaClick(Sender: TObject);
    procedure btnCancelaClick(Sender: TObject);
    procedure brnDeletaClick(Sender: TObject);
  private
    { Private declarations }
    procedure InicializaForm;
  public
    { Public declarations }
    oGrupoUsuario: TGrupoUsuario;
    bRegistroNovo: Boolean;
  end;

var
  frmCadastroGrupoUsuario: TfrmCadastroGrupoUsuario;

implementation

uses uPrincipal;

{$R *.dfm}

procedure TfrmCadastroGrupoUsuario.FormShow(Sender: TObject);
begin
  inherited;
  oGrupoUsuario := TGrupoUsuario.Create(frmPrincipal.zcoConexaoBanco);
end;

procedure TfrmCadastroGrupoUsuario.edtCodigoEnter(Sender: TObject);
begin
  inherited;
  LimpaCampos(Self, []);
  edtCodigo.Text := IntToStr(oGrupoUsuario.iRetornaUltimoCodigo + 1);
  edtCodigo.SelectAll;
end;

procedure TfrmCadastroGrupoUsuario.edtCodigoExit(Sender: TObject);
begin
  inherited;
  if Trim(edtCodigo.Text) = '' then
    edtCodigo.Text := IntToStr(oGrupoUsuario.iRetornaUltimoCodigo + 1);

  oGrupoUsuario.SetCodigo(StrToInt(edtCodigo.Text));
  if oGrupoUsuario.bPesquisaGrupoUsuario(oGrupoUsuario.GetiCodigo) then
  begin
    edtNome.Text := oGrupoUsuario.GetsNome;
    bRegistroNovo := False;
  end
  else
    bRegistroNovo := True;
end;

procedure TfrmCadastroGrupoUsuario.edtCodigoKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  if Key = vk_F2 then
  begin
    edtCodigo.Text := ChamaPesquisa(TEdit(Sender), frmPrincipal.zcoConexaoBanco)[0];
    edtCodigoExit(Sender);
  end;
end;

procedure TfrmCadastroGrupoUsuario.edtCodigoKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  KeyPressNumerico(Key);
end;

procedure TfrmCadastroGrupoUsuario.btnGravaClick(Sender: TObject);
begin
  inherited;
  if Trim(edtCodigo.Text) = '' then
    edtCodigo.Text := IntToStr(oGrupoUsuario.iRetornaUltimoCodigo + 1);

  if Trim(edtNome.Text) = '' then
  begin
    pMsgAtencao('Campo Descrição não pode ser vazio.');
    edtNome.SetFocus;
    Abort;
  end;

  oGrupoUsuario.SetNome(edtNome.Text);
  if bRegistroNovo then
    oGrupoUsuario.CadastraGrupoUsuario
  else
    oGrupoUsuario.AlteraGrupoUsuario;
  InicializaForm;
end;

procedure TfrmCadastroGrupoUsuario.brnDeletaClick(Sender: TObject);
begin
  inherited;
  oGrupoUsuario.SetCodigo(StrToInt(edtCodigo.Text));
  oGrupoUsuario.DeletaGrupoUsuario;
  InicializaForm;
end;

procedure TfrmCadastroGrupoUsuario.btnCancelaClick(Sender: TObject);
begin
  inherited;
  InicializaForm;
  edtCodigo.Text := IntToStr(oGrupoUsuario.iRetornaUltimoCodigo + 1);
  edtCodigo.SelectAll;
end;

procedure TfrmCadastroGrupoUsuario.InicializaForm;
begin
  LimpaCampos(Self, [nil]);
  edtCodigo.SetFocus;
end;

end.
