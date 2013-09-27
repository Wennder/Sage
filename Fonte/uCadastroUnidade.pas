unit uCadastroUnidade;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uCadastroGenerico, JvExControls, UsoGeral,
  JvComponent, JvNavigationPane, StdCtrls, uUnidade, cxGraphics,
  cxLookAndFeels, cxLookAndFeelPainters, Menus, cxButtons, ExtCtrls, cxControls,
  cxContainer, cxEdit, cxTextEdit, cxLabel;

type
  TfrmCadastroUnidade = class(TfrmCadastroGenerico)
    edtCodigo: TcxTextEdit;
    edtDescricao: TcxTextEdit;
    lblCodigo: TcxLabel;
    lblDescricao: TcxLabel;
    procedure FormShow(Sender: TObject);
    procedure brnDeletaClick(Sender: TObject);
    procedure btnCancelaClick(Sender: TObject);
    procedure edtCodigoEnter(Sender: TObject);
    procedure edtCodigoKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodigoExit(Sender: TObject);
    procedure btnGravaClick(Sender: TObject);
    procedure edtCodigoKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }
    oUnidade: TUnidade;
    bRegistroNovo: Boolean;
    procedure InicializaForm;
  public
    { Public declarations }
  end;

var
  frmCadastroUnidade: TfrmCadastroUnidade;

implementation

uses uPrincipal;

{$R *.dfm}

procedure TfrmCadastroUnidade.FormShow(Sender: TObject);
begin
  inherited;
  oUnidade := TUnidade.Create(frmPrincipal.zcoConexaoBanco);
end;

procedure TfrmCadastroUnidade.InicializaForm;
begin
  LimpaCampos(self, [edtCodigo]);
  edtCodigo.SetFocus;
end;

procedure TfrmCadastroUnidade.brnDeletaClick(Sender: TObject);
begin
  inherited;
  oUnidade.SetCodigo(StrToInt(edtCodigo.Text));
  oUnidade.DeletaUnidade;
  InicializaForm;
end;

procedure TfrmCadastroUnidade.btnCancelaClick(Sender: TObject);
begin
  inherited;
  InicializaForm;
end;

procedure TfrmCadastroUnidade.edtCodigoEnter(Sender: TObject);
begin
  inherited;
  InicializaForm;
  edtCodigo.Text := IntToStr(oUnidade.iRetornaUltimoCodigo + 1);
  edtCodigo.SelectAll;
end;

procedure TfrmCadastroUnidade.edtCodigoKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  if Key = vk_F2 then
  begin
    edtCodigo.Text := ChamaPesquisa(TEdit(Sender), frmPrincipal.zcoConexaoBanco)[0];
    Perform(WM_NEXTDLGCTL, 0, 0);
  end;
end;

procedure TfrmCadastroUnidade.edtCodigoKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  KeyPressNumerico(Key);
end;

procedure TfrmCadastroUnidade.edtCodigoExit(Sender: TObject);
begin
  inherited;
  if Trim(edtCodigo.Text) = '' then
    edtCodigo.Text := IntToStr(oUnidade.iRetornaUltimoCodigo + 1);

  oUnidade.SetCodigo(StrToInt(edtCodigo.Text));
  if oUnidade.bPesquisaUnidade(StrToInt(edtCodigo.Text)) then
  begin
    edtDescricao.Text := oUnidade.sGetDescricao;
    bRegistroNovo := False;
  end
  else
    bRegistroNovo := True;
end;

procedure TfrmCadastroUnidade.btnGravaClick(Sender: TObject);
begin
  inherited;
  if Trim(edtCodigo.Text) = '' then
    edtCodigo.Text := IntToStr(oUnidade.iRetornaUltimoCodigo + 1);

  if Trim(edtDescricao.Text) = '' then
  begin
    pMsgAtencao('Campo Descrição não pode ser vazio.');
    edtDescricao.SetFocus;
    Abort;
  end;

  oUnidade.SetCodigo(StrToInt(edtCodigo.Text));
  oUnidade.SetDescricao(edtDescricao.Text);
  if bRegistroNovo then
    oUnidade.CadastraUnidade
  else
    oUnidade.AlteraUnidade;
  InicializaForm;
end;

end.
