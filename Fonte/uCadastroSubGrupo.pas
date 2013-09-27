unit uCadastroSubGrupo;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uCadastroGenerico, JvExControls, UsoGeral,
  JvComponent, JvNavigationPane, StdCtrls, uSubGrupo, cxGraphics,
  cxLookAndFeels, cxLookAndFeelPainters, Menus, cxButtons, ExtCtrls, cxControls,
  cxContainer, cxEdit, cxTextEdit, cxLabel;

type
  TfrmCadastroSubGrupo = class(TfrmCadastroGenerico)
    edtCodigo: TcxTextEdit;
    edtDescricao: TcxTextEdit;
    edtGrupo: TcxTextEdit;
    edtDescGrupo: TcxTextEdit;
    lblCodigo: TcxLabel;
    lblGrupo: TcxLabel;
    procedure edtGrupoExit(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure edtGrupoEnter(Sender: TObject);
    procedure btnCancelaClick(Sender: TObject);
    procedure edtCodigoEnter(Sender: TObject);
    procedure edtCodigoExit(Sender: TObject);
    procedure edtCodigoKeyPress(Sender: TObject; var Key: Char);
    procedure edtGrupoKeyPress(Sender: TObject; var Key: Char);
    procedure brnDeletaClick(Sender: TObject);
    procedure btnGravaClick(Sender: TObject);
    procedure edtGrupoKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edtCodigoKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }
    oSubGrupo: TSubGrupo;
    bRegistroNovo: boolean;
    procedure InicializaForm;
  public
    { Public declarations }
  end;

var
  frmCadastroSubGrupo: TfrmCadastroSubGrupo;

implementation

uses uPrincipal, uGrupo;

{$R *.dfm}

procedure TfrmCadastroSubGrupo.InicializaForm;
begin
  LimpaCampos(self, [nil]);
  edtGrupo.SetFocus;
end;

procedure TfrmCadastroSubGrupo.edtGrupoExit(Sender: TObject);
var
  bGrupoNaoEncontrado: boolean;
begin
  inherited;
  bGrupoNaoEncontrado := False;
  if ActiveControl = BtnSair then
    Exit;
  if (edtGrupo.Text = '') or (edtGrupo.Text = '0') then
  begin
    edtGrupo.SetFocus;
    Exit;
  end;
  oSubGrupo.oGrupo.SetCodigo(StrToInt(edtGrupo.Text));
  if oSubGrupo.oGrupo.bPesquisaGrupo(StrToInt(edtGrupo.Text)) then
  begin
    if oSubGrupo.oGrupo.sGetStatus = 'A' then
      edtDescGrupo.Text := oSubGrupo.oGrupo.sGetDescricao
    else
      bGrupoNaoEncontrado := true;
  end
  else
    bGrupoNaoEncontrado := true;
  if bGrupoNaoEncontrado then
  begin
    Application.MessageBox(PChar('Grupo não cadastrado!'), 'Aviso', MB_OK);
    edtGrupo.SetFocus;
  end;
end;

procedure TfrmCadastroSubGrupo.FormCreate(Sender: TObject);
begin
  inherited;
  oSubGrupo := TSubGrupo.Create(frmPrincipal.zcoConexaoBanco);
end;

procedure TfrmCadastroSubGrupo.edtGrupoEnter(Sender: TObject);
begin
  inherited;
  InicializaForm;
end;

procedure TfrmCadastroSubGrupo.btnCancelaClick(Sender: TObject);
begin
  inherited;
  InicializaForm;
end;

procedure TfrmCadastroSubGrupo.edtCodigoEnter(Sender: TObject);
begin
  inherited;
  edtDescricao.Clear;
  edtCodigo.Text := IntToStr(oSubGrupo.iRetornaUltimoCodigo + 1);
  edtCodigo.SelectAll;
end;

procedure TfrmCadastroSubGrupo.edtCodigoExit(Sender: TObject);
begin
  inherited;
  if Trim(edtCodigo.Text) = '' then
    edtCodigo.Text := IntToStr(oSubGrupo.iRetornaUltimoCodigo + 1);

  oSubGrupo.SetCodigo(StrToInt(edtCodigo.Text));
  if oSubGrupo.bPesquisaSubGrupo(oSubGrupo.iGetCodigo, oSubGrupo.oGrupo.iGetCodigo) then
  begin
    edtDescricao.Text := oSubGrupo.sGetDescricao;
    bRegistroNovo := False;
  end
  else
    bRegistroNovo := true;
end;

procedure TfrmCadastroSubGrupo.edtCodigoKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  if Key = vk_F2 then
  begin
    edtCodigo.Text := ChamaPesquisa(TEdit(Sender), frmPrincipal.zcoConexaoBanco, ' and iGrupo ' + iif(Trim(edtGrupo.Text) = '', 'is Null',
      ' = ' + Trim(edtGrupo.Text)))[0];
    Perform(WM_NEXTDLGCTL, 0, 0);
  end;
end;

procedure TfrmCadastroSubGrupo.edtCodigoKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  KeyPressNumerico(Key);
end;

procedure TfrmCadastroSubGrupo.edtGrupoKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  if Key = vk_F2 then
  begin
    edtGrupo.Text := ChamaPesquisa(TEdit(Sender), frmPrincipal.zcoConexaoBanco)[0];
    Perform(WM_NEXTDLGCTL, 0, 0);
  end;
end;

procedure TfrmCadastroSubGrupo.edtGrupoKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  KeyPressNumerico(Key);
end;

procedure TfrmCadastroSubGrupo.brnDeletaClick(Sender: TObject);
begin
  inherited;
  oSubGrupo.SetCodigo(StrToInt(edtCodigo.Text));
  oSubGrupo.oGrupo.SetCodigo(StrToInt(edtGrupo.Text));
  oSubGrupo.DeletaSubGrupo;
  InicializaForm;
end;

procedure TfrmCadastroSubGrupo.btnGravaClick(Sender: TObject);
begin
  inherited;
  if Trim(edtCodigo.Text) = '' then
    edtCodigo.Text := IntToStr(oSubGrupo.iRetornaUltimoCodigo + 1);

  if Trim(edtDescricao.Text) = '' then
  begin
    pMsgAtencao('A descrição do Subgrupo não pode ser vazia.');
    edtDescricao.SetFocus;
    Abort;
  end;

  oSubGrupo.SetCodigo(StrToInt(edtCodigo.Text));
  oSubGrupo.SetDescricao(edtDescricao.Text);
  oSubGrupo.oGrupo.SetCodigo(StrToInt(edtGrupo.Text));
  if bRegistroNovo then
    oSubGrupo.CadastraSubGrupo
  else
    oSubGrupo.AlteraSubGrupo;
  InicializaForm;
end;

end.
