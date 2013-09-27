unit uCadastroTabelaPreco;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uCadastroGenerico, JvExControls, UsoGeral,
  JvComponent, JvNavigationPane, StdCtrls, uTabelaPreco, cxGraphics,
  cxLookAndFeels, cxLookAndFeelPainters, Menus, cxButtons, ExtCtrls, cxControls,
  cxContainer, cxEdit, cxTextEdit, cxLabel;

type
  TfrmCadastroTabelaPreco = class(TfrmCadastroGenerico)
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
    oTabelaPreco: TTabelaPreco;
    bRegistroNovo: Boolean;
    procedure InicializaForm;
  public
    { Public declarations }
  end;

var
  frmCadastroTabelaPreco: TfrmCadastroTabelaPreco;

implementation

uses uPrincipal;

{$R *.dfm}
{ TfrmCadastroTabelaPreco }

procedure TfrmCadastroTabelaPreco.InicializaForm;
begin
  LimpaCampos(self, [edtCodigo]);
  edtCodigo.SetFocus;
end;

procedure TfrmCadastroTabelaPreco.FormShow(Sender: TObject);
begin
  inherited;
  oTabelaPreco := TTabelaPreco.Create(frmPrincipal.zcoConexaoBanco);
end;

procedure TfrmCadastroTabelaPreco.brnDeletaClick(Sender: TObject);
begin
  inherited;
  oTabelaPreco.SetCodigo(StrToInt(edtCodigo.Text));
  oTabelaPreco.DeletaTabelaPreco;
  InicializaForm;
end;

procedure TfrmCadastroTabelaPreco.btnCancelaClick(Sender: TObject);
begin
  inherited;
  InicializaForm;
end;

procedure TfrmCadastroTabelaPreco.edtCodigoEnter(Sender: TObject);
begin
  inherited;
  InicializaForm;
  edtCodigo.Text := IntToStr(oTabelaPreco.iRetornaUltimoCodigo + 1);
  edtCodigo.SelectAll;
end;

procedure TfrmCadastroTabelaPreco.edtCodigoKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  if Key = vk_F2 then
  begin
    edtCodigo.Text := ChamaPesquisa(TEdit(Sender), frmPrincipal.zcoConexaoBanco)[0];
    Perform(WM_NEXTDLGCTL, 0, 0);
  end;
end;

procedure TfrmCadastroTabelaPreco.edtCodigoKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  KeyPressNumerico(Key);
end;

procedure TfrmCadastroTabelaPreco.edtCodigoExit(Sender: TObject);
begin
  inherited;
  if Trim(edtCodigo.Text) = '' then
    edtCodigo.Text := IntToStr(oTabelaPreco.iRetornaUltimoCodigo + 1);

  oTabelaPreco.SetCodigo(StrToInt(edtCodigo.Text));
  if oTabelaPreco.bPesquisaTabelaPreco(StrToInt(edtCodigo.Text)) then
  begin
    edtDescricao.Text := oTabelaPreco.sGetDescricao;
    bRegistroNovo := False;
  end
  else
    bRegistroNovo := True;
end;

procedure TfrmCadastroTabelaPreco.btnGravaClick(Sender: TObject);
begin
  inherited;
  if Trim(edtCodigo.Text) = '' then
    edtCodigo.Text := IntToStr(oTabelaPreco.iRetornaUltimoCodigo + 1);

  if Trim(edtDescricao.Text) = '' then
  begin
    pMsgAtencao('Campo Descrição não pode ser vazio.');
    edtDescricao.SetFocus;
    Abort;
  end;

  oTabelaPreco.SetCodigo(StrToInt(edtCodigo.Text));
  oTabelaPreco.SetDescricao(edtDescricao.Text);
  if bRegistroNovo then
    oTabelaPreco.CadastraTabelaPreco
  else
    oTabelaPreco.AlteraTabelaPreco;
  InicializaForm;
end;

end.
