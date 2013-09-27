unit uCadastroNaturezaOperacao;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uCadastroGenerico, JvExControls, UsoGeral,
  JvComponent, JvNavigationPane, uNaturezaOperacao, StdCtrls,
  cxGraphics, cxLookAndFeels, cxLookAndFeelPainters, Menus, cxButtons, ExtCtrls,
  cxControls, cxContainer, cxEdit, cxTextEdit, cxLabel;

type
  TfrmCadastroNaturezaOperacao = class(TfrmCadastroGenerico)
    edtCodigo: TcxTextEdit;
    edtDescricao: TcxTextEdit;
    lblCodigo: TcxLabel;
    lblDescricao: TcxLabel;
    procedure FormShow(Sender: TObject);
    procedure btnGravaClick(Sender: TObject);
    procedure btnCancelaClick(Sender: TObject);
    procedure edtCodigoEnter(Sender: TObject);
    procedure edtCodigoKeyPress(Sender: TObject; var Key: Char);
    procedure brnDeletaClick(Sender: TObject);
    procedure edtCodigoExit(Sender: TObject);
    procedure edtCodigoKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }
    oNaturezaOperacao: TNaturezaOperacao;
    bRegistroNovo: Boolean;
    procedure InicializaForm;
  public
    { Public declarations }
  end;

var
  frmCadastroNaturezaOperacao: TfrmCadastroNaturezaOperacao;

implementation

uses uPrincipal;

{$R *.dfm}

procedure TfrmCadastroNaturezaOperacao.FormShow(Sender: TObject);
begin
  inherited;
  oNaturezaOperacao := TNaturezaOperacao.Create(frmPrincipal.zcoConexaoBanco);
end;

procedure TfrmCadastroNaturezaOperacao.InicializaForm;
begin
  LimpaCampos(self, [edtCodigo]);
  edtCodigo.SetFocus;
end;

procedure TfrmCadastroNaturezaOperacao.btnGravaClick(Sender: TObject);
begin
  inherited;
  if Trim(edtCodigo.Text) = '' then
    edtCodigo.Text := IntToStr(oNaturezaOperacao.iRetornaUltimoCodigo + 1);

  if Trim(edtDescricao.Text) = '' then
  begin
    pMsgAtencao('Campo Descrição não pode ser vazio.');
    edtDescricao.SetFocus;
    Abort;
  end;

  oNaturezaOperacao.SetiCodigo(StrToInt(edtCodigo.Text));
  oNaturezaOperacao.SetsDescricao(edtDescricao.Text);
  if bRegistroNovo then
    oNaturezaOperacao.CadastraNaturezaOperacao
  else
    oNaturezaOperacao.AlteraNaturezaOperacao;
  InicializaForm;
end;

procedure TfrmCadastroNaturezaOperacao.btnCancelaClick(Sender: TObject);
begin
  inherited;
  InicializaForm;
end;

procedure TfrmCadastroNaturezaOperacao.edtCodigoEnter(Sender: TObject);
begin
  inherited;
  InicializaForm;
  edtCodigo.Text := IntToStr(oNaturezaOperacao.iRetornaUltimoCodigo + 1);
  edtCodigo.SelectAll;
end;

procedure TfrmCadastroNaturezaOperacao.edtCodigoKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  KeyPressNumerico(Key);
end;

procedure TfrmCadastroNaturezaOperacao.brnDeletaClick(Sender: TObject);
begin
  inherited;
  oNaturezaOperacao.SetiCodigo(StrToInt(edtCodigo.Text));
  oNaturezaOperacao.DeletaNaturezaOperacao;
  InicializaForm;
end;

procedure TfrmCadastroNaturezaOperacao.edtCodigoExit(Sender: TObject);
begin
  inherited;
  if Trim(edtCodigo.Text) = '' then
    edtCodigo.Text := IntToStr(oNaturezaOperacao.iRetornaUltimoCodigo + 1);

  oNaturezaOperacao.SetiCodigo(StrToInt(edtCodigo.Text));
  if oNaturezaOperacao.bPesquisaNaturezaOperacao(StrToInt(edtCodigo.Text)) then
  begin
    edtDescricao.Text := oNaturezaOperacao.sGetDescricao;
    bRegistroNovo := False;
  end
  else
    bRegistroNovo := True;
end;

procedure TfrmCadastroNaturezaOperacao.edtCodigoKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  if Key = vk_F2 then
  begin
    edtCodigo.Text := ChamaPesquisa(TEdit(Sender), frmPrincipal.zcoConexaoBanco)[0];
    edtCodigoExit(Sender);
  end;
end;

end.
