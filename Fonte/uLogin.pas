unit uLogin;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, cxGraphics, cxControls, uUsuario, cxLookAndFeels, cxLookAndFeelPainters,
  cxContainer, cxEdit, cxLabel, dxGDIPlusClasses, ExtCtrls, dxSkinsCore,
  dxSkinOffice2010Blue, dxSkinOffice2010Silver, Menus, StdCtrls, cxButtons,
  cxMaskEdit, cxDropDownEdit, cxLookupEdit, cxDBLookupEdit, cxDBLookupComboBox,
  cxTextEdit, verslab, DB, SQLMemMain, ZAbstractRODataset, ZAbstractDataset, ZDataset,
  Datasnap.DBClient, uEmpresa;

type
  TfLogin = class(TForm)
    pPrincipal: TPanel;
    imgFundo: TImage;
    lbVersao: TVersionLabel;
    edtSenha: TcxTextEdit;
    lbsenha: TcxLabel;
    lbusuario: TcxLabel;
    edtNMUsuario: TcxLookupComboBox;
    btnsair: TcxButton;
    btnentrar: TcxButton;
    dsUsuario: TDataSource;
    edtEmpresa: TcxLookupComboBox;
    lbEmpresa: TcxLabel;
    qrEmpresa: TZQuery;
    dsEmpresa: TDataSource;
    btnAtualizar: TcxButton;
    ClientDataSet1: TClientDataSet;
    procedure btnsairClick(Sender: TObject);
    procedure btnentrarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure edtNMUsuarioPropertiesEditValueChanged(Sender: TObject);
    procedure edtSenhaKeyPress(Sender: TObject; var Key: Char);
    procedure btnAtualizarClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    oUsuario: TUsuario;
  end;

var
  fLogin: TfLogin;

implementation

uses uPrincipal, uAtualizacaoScript;

{$R *.dfm}

procedure TfLogin.btnAtualizarClick(Sender: TObject);
begin
  if Trim(edtNMUsuario.Text) = '' then
  begin
    ShowMessage('Por favor, selecione um usuário!');
    edtNMUsuario.SetFocus;
    Exit;
  end;

  if Trim(edtSenha.Text) = '' then
  begin
    ShowMessage('Por favor, digite a senha!');
    edtSenha.SetFocus;
    Exit;
  end;

  vIDUsuario := oUsuario.GetiCodigo;
  vIdGrupo := oUsuario.GetiGrupo;

  if oUsuario.ValidaSenhaUsuario(edtSenha.Text) then
  begin
    frmAtualizacaoScript := TfrmAtualizacaoScript.Create(nil);
    frmAtualizacaoScript.ShowModal;
    FreeAndNil(frmAtualizacaoScript);
  end;
end;

procedure TfLogin.btnentrarClick(Sender: TObject);
begin
  if Trim(edtNMUsuario.Text) = '' then
  begin
    ShowMessage('Por favor, selecione um usuário!');
    edtNMUsuario.SetFocus;
    Exit;
  end;

  if Trim(edtSenha.Text) = '' then
  begin
    ShowMessage('Por favor, digite a senha!');
    edtSenha.SetFocus;
    Exit;
  end;

  if oUsuario.ValidaSenhaUsuario(edtSenha.Text) then
  begin
    vIDUsuario := oUsuario.GetiCodigo;
    vIdGrupo := oUsuario.GetiGrupo;

    oEmpresaPrincipal.fPesquisar(edtEmpresa.EditValue);

    with frmPrincipal do
    begin
      pConfiguraMenuAcessoUsuario(oUsuario.GetiGrupo);
      stBar.Panels[0].Text := 'Usuário: ' + oUsuario.GetsNome;
    end;
    Self.Close
  end
  else
    btnentrar.SetFocus;
end;

procedure TfLogin.btnsairClick(Sender: TObject);
begin
  Application.Terminate;
end;

procedure TfLogin.edtNMUsuarioPropertiesEditValueChanged(Sender: TObject);
begin
  if Trim(edtNMUsuario.Text) <> '' then
    oUsuario.bPesquisaUsuario(edtNMUsuario.EditValue);
end;

procedure TfLogin.edtSenhaKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
    btnentrar.OnClick(btnentrar);
end;

procedure TfLogin.FormShow(Sender: TObject);
begin
  oUsuario := TUsuario.Create(frmPrincipal.zcoConexaoBanco);
  oUsuario.CargaInicialUsuario;
  dsUsuario.DataSet := oUsuario.ListaUsuario(False);

  with qrEmpresa do
  begin
    Connection := frmPrincipal.zcoConexaoBanco;
    Close;
    Sql.Clear;
    Sql.Add('SELECT iempresa');
    Sql.Add('      ,srazaosocial');
    Sql.Add('      ,sfantasia');
    Sql.Add('FROM   tbempresa');
    Open;
    edtEmpresa.EditValue := 1;
  end;

  // Facilitador para quando a aplicação estiver em modo de depuração.
  if DebugHook <> 0 then
  begin
    edtNMUsuario.EditValue := 0;
    edtNMUsuario.Properties.OnEditValueChanged(edtNMUsuario);
    edtSenha.EditValue := 'semsenha@2013';
    btnentrar.SetFocus;
  end;
end;

end.
