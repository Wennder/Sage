unit uCadastroUsuario;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uCadastroGenerico, JvExControls,
  JvComponent, JvNavigationPane, StdCtrls, Mask, uUsuario, cxGraphics,
  cxLookAndFeels, cxLookAndFeelPainters, Menus, cxButtons, ExtCtrls, cxControls,
  cxContainer, cxEdit, cxTextEdit, cxLabel;

type
  TfrmCadastroUsuarios = class(TfrmCadastroGenerico)
    edtSenha: TMaskEdit;
    stDescricaoGrupo: TStaticText;
    edtCodigo: TcxTextEdit;
    edtNome: TcxTextEdit;
    edtLogin: TcxTextEdit;
    edtGrupoUsuario: TcxTextEdit;
    lblCodigo: TcxLabel;
    lblNome: TcxLabel;
    lblLogin: TcxLabel;
    lblSenha: TcxLabel;
    Label2: TcxLabel;
    procedure edtCodigoEnter(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure edtCodigoExit(Sender: TObject);
    procedure edtCodigoKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edtCodigoKeyPress(Sender: TObject; var Key: Char);
    procedure btnCancelaClick(Sender: TObject);
    procedure btnGravaClick(Sender: TObject);
    procedure edtGrupoUsuarioEnter(Sender: TObject);
    procedure edtGrupoUsuarioExit(Sender: TObject);
    procedure edtGrupoUsuarioKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edtGrupoUsuarioKeyPress(Sender: TObject; var Key: Char);
    procedure brnDeletaClick(Sender: TObject);
  private
    { Private declarations }
    procedure InicializaForm;
  public
    { Public declarations }
    oUsuario: TUsuario;
    bRegistroNovo: Boolean;
  end;

var
  frmCadastroUsuarios: TfrmCadastroUsuarios;

implementation

uses uPrincipal, UsoGeral;

{$R *.dfm}

procedure TfrmCadastroUsuarios.edtCodigoEnter(Sender: TObject);
begin
  inherited;
  LimpaCampos(Self, []);
  edtCodigo.Text := IntToStr(oUsuario.iRetornaUltimoCodigo + 1);
  edtCodigo.SelectAll;
end;

procedure TfrmCadastroUsuarios.FormShow(Sender: TObject);
begin
  inherited;
  oUsuario := TUsuario.Create(frmPrincipal.zcoConexaoBanco);
end;

procedure TfrmCadastroUsuarios.edtCodigoExit(Sender: TObject);
begin
  inherited;
  if (edtCodigo.Text = '') or (edtCodigo.Text = '0') then
    edtCodigo.SetFocus;
  oUsuario.SetCodigo(StrToInt(edtCodigo.Text));
  if oUsuario.bPesquisaUsuario(oUsuario.GetiCodigo) then
  begin
    edtNome.Text := oUsuario.GetsNome;
    edtLogin.Text := oUsuario.GetsLogin;
    edtSenha.Text := fDescriptografar(oUsuario.GetsSenha, 567);
    edtGrupoUsuario.Text := IntToStr(oUsuario.oGrupoUsuario.GetiCodigo);
    stDescricaoGrupo.Caption := oUsuario.oGrupoUsuario.GetsNome;
    bRegistroNovo := False;
  end
  else
    bRegistroNovo := True;
end;

procedure TfrmCadastroUsuarios.edtCodigoKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  if Key = vk_F2 then
  begin
    edtCodigo.Text := ChamaPesquisa(TEdit(Sender), frmPrincipal.zcoConexaoBanco)[0];
    edtCodigoExit(Sender);
  end;
end;

procedure TfrmCadastroUsuarios.edtCodigoKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  KeyPressNumerico(Key);
end;

procedure TfrmCadastroUsuarios.brnDeletaClick(Sender: TObject);
begin
  inherited;
  oUsuario.SetCodigo(StrToInt(edtCodigo.Text));
  oUsuario.DeletaUsuario;
  InicializaForm;
end;

procedure TfrmCadastroUsuarios.btnCancelaClick(Sender: TObject);
begin
  inherited;
  InicializaForm;
  edtCodigo.Text := IntToStr(oUsuario.iRetornaUltimoCodigo + 1);
  edtCodigo.SelectAll;
end;

procedure TfrmCadastroUsuarios.InicializaForm;
begin
  LimpaCampos(Self, [nil]);
  edtCodigo.SetFocus;
end;

procedure TfrmCadastroUsuarios.btnGravaClick(Sender: TObject);
begin
  inherited;
  if Trim(edtNome.Text) = '' then
  begin
    pMsgAtencao('O campo Nome não pode ser vazio.');
    edtNome.SetFocus;
    Abort;
  end;

  if Trim(edtLogin.Text) = '' then
  begin
    pMsgAtencao('O campo Login não pode ser vazio.');
    edtLogin.SetFocus;
    Abort;
  end;

  if Trim(edtSenha.Text) = '' then
  begin
    pMsgAtencao('O campo senha não pode ser vazio.');
    edtSenha.SetFocus;
    Abort;
  end;

  if (Trim(edtGrupoUsuario.Text) = '0') or (Trim(edtGrupoUsuario.Text) = '') then
  begin
    pMsgAtencao('O campo Grupo não pode ser zero ou vazio.');
    edtGrupoUsuario.SetFocus;
    Abort;
  end;

  oUsuario.SetNome(edtNome.Text);
  oUsuario.SetLogin(edtLogin.Text);
  oUsuario.SetSenha(edtSenha.Text);
  if bRegistroNovo then
    oUsuario.CadastraUsuario
  else
    oUsuario.AlteraUsuario;
  InicializaForm;
end;

procedure TfrmCadastroUsuarios.edtGrupoUsuarioEnter(Sender: TObject);
begin
  inherited;
  edtGrupoUsuario.SelectAll;
end;

procedure TfrmCadastroUsuarios.edtGrupoUsuarioExit(Sender: TObject);
var
  bGrupoUsuarioNaoEncontrado: Boolean;
begin
  inherited;
  bGrupoUsuarioNaoEncontrado := False;

  if ActiveControl = BtnSair then
    Exit;

  if (edtGrupoUsuario.Text = '') or (edtGrupoUsuario.Text = '0') then
  begin
    stDescricaoGrupo.Caption := '';
    Exit;
  end;

  if oUsuario.oGrupoUsuario.bPesquisaGrupoUsuario(StrToInt(edtGrupoUsuario.Text)) then
  begin
    if oUsuario.oGrupoUsuario.GetsStatus = 'A' then
      stDescricaoGrupo.Caption := oUsuario.oGrupoUsuario.GetsNome
    else
      bGrupoUsuarioNaoEncontrado := True;
  end
  else
    bGrupoUsuarioNaoEncontrado := True;
  if bGrupoUsuarioNaoEncontrado then
  begin
    pMsgAtencao('Grupo de usuário não cadastrado!');
    edtGrupoUsuario.SetFocus;
    Abort;
  end;
end;

procedure TfrmCadastroUsuarios.edtGrupoUsuarioKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  if Key = vk_F2 then
  begin
    edtGrupoUsuario.Text := ChamaPesquisa(TEdit(Sender), frmPrincipal.zcoConexaoBanco)[0];
    edtGrupoUsuarioExit(Sender);
  end;
end;

procedure TfrmCadastroUsuarios.edtGrupoUsuarioKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  KeyPressNumerico(Key);
end;

end.
