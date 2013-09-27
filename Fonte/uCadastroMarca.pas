unit uCadastroMarca;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uCadastroGenerico, JvExControls,
  JvComponent, JvNavigationPane, StdCtrls, uMarca, cxGraphics,
  cxLookAndFeels, cxLookAndFeelPainters, Menus, cxButtons, ExtCtrls, cxControls,
  cxContainer, cxEdit, cxTextEdit, UsoGeral, cxLabel;

type
  TfrmCadastroMarca = class(TfrmCadastroGenerico)
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
    oMarca: TMarca;
    bRegistroNovo: Boolean;
    procedure InicializaForm;
  public
    { Public declarations }
  end;

var
  frmCadastroMarca: TfrmCadastroMarca;

implementation

uses uPrincipal;

{$R *.dfm}

procedure TfrmCadastroMarca.FormShow(Sender: TObject);
begin
  inherited;
  oMarca := TMarca.Create(frmPrincipal.zcoConexaoBanco);
end;

procedure TfrmCadastroMarca.btnGravaClick(Sender: TObject);
begin
  inherited;
  if Trim(edtCodigo.Text) = '' then
    edtCodigo.Text := IntToStr(oMarca.iRetornaUltimoCodigo + 1);

  if Trim(edtDescricao.Text) = '' then
  begin
    pMsgAtencao('Campo Descrição não pode ser vazio.');
    edtDescricao.SetFocus;
    Abort;
  end;

  oMarca.SetCodigo(StrToInt(edtCodigo.Text));
  oMarca.SetDescricao(edtDescricao.Text);
  if bRegistroNovo then
    oMarca.CadastraMarca
  else
    oMarca.AlteraMarca;
  InicializaForm;
end;

procedure TfrmCadastroMarca.btnCancelaClick(Sender: TObject);
begin
  inherited;
  InicializaForm;
end;

procedure TfrmCadastroMarca.edtCodigoEnter(Sender: TObject);
begin
  inherited;
  InicializaForm;
  edtCodigo.Text := IntToStr(oMarca.iRetornaUltimoCodigo + 1);
  edtCodigo.SelectAll;
end;

procedure TfrmCadastroMarca.edtCodigoKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  if Key = vk_F2 then
  begin
    edtCodigo.Text := ChamaPesquisa(TEdit(Sender), frmPrincipal.zcoConexaoBanco)[0];
    Perform(WM_NEXTDLGCTL, 0, 0);
  end;
end;

procedure TfrmCadastroMarca.edtCodigoKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  KeyPressNumerico(Key);
end;

procedure TfrmCadastroMarca.InicializaForm;
begin
  LimpaCampos(self, [edtCodigo]);
  edtCodigo.SetFocus;
end;

procedure TfrmCadastroMarca.brnDeletaClick(Sender: TObject);
begin
  inherited;
  oMarca.SetCodigo(StrToInt(edtCodigo.Text));
  oMarca.DeletaMarca;
  InicializaForm;
end;

procedure TfrmCadastroMarca.edtCodigoExit(Sender: TObject);
begin
  inherited;
  if Trim(edtCodigo.Text) = '' then
    edtCodigo.Text := IntToStr(oMarca.iRetornaUltimoCodigo + 1);

  oMarca.SetCodigo(StrToInt(edtCodigo.Text));
  if oMarca.bPesquisaMarca(StrToInt(edtCodigo.Text)) then
  begin
    edtDescricao.Text := oMarca.sGetDescricao;
    bRegistroNovo := False;
  end
  else
    bRegistroNovo := True;
end;

end.
