unit uCadastroGrupo;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uCadastroGenerico, StdCtrls,
  JvExControls, JvComponent, JvNavigationPane, uGrupo, cxGraphics,
  cxLookAndFeels, cxLookAndFeelPainters, Menus, cxButtons, ExtCtrls, cxControls,
  cxContainer, cxEdit, cxTextEdit, UsoGeral, cxLabel;

type
  TfrmCadastroGrupo = class(TfrmCadastroGenerico)
    edtCodigo: TcxTextEdit;
    edtDescricao: TcxTextEdit;
    lblCodigo: TcxLabel;
    lblDescricao: TcxLabel;
    procedure brnDeletaClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnCancelaClick(Sender: TObject);
    procedure edtCodigoEnter(Sender: TObject);
    procedure edtCodigoKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodigoExit(Sender: TObject);
    procedure btnGravaClick(Sender: TObject);
    procedure edtCodigoKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }
    oGrupo: TGrupo;
    bRegistroNovo: Boolean;
    procedure InicializaForm;
  public
    { Public declarations }
  end;

var
  frmCadastroGrupo: TfrmCadastroGrupo;

implementation

uses uPrincipal;

{$R *.dfm}

procedure TfrmCadastroGrupo.brnDeletaClick(Sender: TObject);
begin
  inherited;
  oGrupo.SetCodigo(StrToInt(edtCodigo.Text));
  oGrupo.DeletaGrupo;
  InicializaForm;
end;

procedure TfrmCadastroGrupo.InicializaForm;
begin
  LimpaCampos(self, [edtCodigo]);
  edtCodigo.SetFocus;
end;

procedure TfrmCadastroGrupo.FormShow(Sender: TObject);
begin
  inherited;
  oGrupo := TGrupo.Create(frmPrincipal.zcoConexaoBanco);
end;

procedure TfrmCadastroGrupo.btnCancelaClick(Sender: TObject);
begin
  inherited;
  InicializaForm;
end;

procedure TfrmCadastroGrupo.edtCodigoEnter(Sender: TObject);
begin
  inherited;
  InicializaForm;
  edtCodigo.Text := IntToStr(oGrupo.iRetornaUltimoCodigo + 1);
  edtCodigo.SelectAll;
end;

procedure TfrmCadastroGrupo.edtCodigoKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  if Key = vk_F2 then
  begin
    edtCodigo.Text := ChamaPesquisa(TEdit(Sender), frmPrincipal.zcoConexaoBanco)[0];
    Perform(WM_NEXTDLGCTL, 0, 0);
  end;
end;

procedure TfrmCadastroGrupo.edtCodigoKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  KeyPressNumerico(Key);
end;

procedure TfrmCadastroGrupo.edtCodigoExit(Sender: TObject);
begin
  inherited;
  if Trim(edtCodigo.Text) = '' then
    edtCodigo.Text := IntToStr(oGrupo.iRetornaUltimoCodigo + 1);

  oGrupo.SetCodigo(StrToInt(edtCodigo.Text));
  if oGrupo.bPesquisaGrupo(StrToInt(edtCodigo.Text)) then
  begin
    edtDescricao.Text := oGrupo.sGetDescricao;
    bRegistroNovo := False;
  end
  else
    bRegistroNovo := True;
end;

procedure TfrmCadastroGrupo.btnGravaClick(Sender: TObject);
begin
  inherited;
  if Trim(edtCodigo.Text) = '' then
    edtCodigo.Text := IntToStr(oGrupo.iRetornaUltimoCodigo + 1);

  if Trim(edtDescricao.Text) = '' then
  begin
    pMsgAtencao('Campo Descrição não pode ser vazio.');
    edtDescricao.SetFocus;
    Abort;
  end;

  oGrupo.SetCodigo(StrToInt(edtCodigo.Text));
  oGrupo.SetDescricao(edtDescricao.Text);
  if bRegistroNovo then
    oGrupo.CadastraGrupo
  else
    oGrupo.AlteraGrupo;
  InicializaForm;
end;

end.
