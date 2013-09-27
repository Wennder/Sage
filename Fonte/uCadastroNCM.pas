unit uCadastroNCM;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uCadastroGenerico, StdCtrls, JvXPCore, JvXPButtons,
  JvExControls, JvComponent, JvNavigationPane, UNCM, cxGraphics, cxLookAndFeels,
  cxLookAndFeelPainters, Menus, cxButtons, ExtCtrls, cxControls, cxContainer,
  cxEdit, cxTextEdit, cxLabel;

type
  TfrmCadastroNCM = class(TfrmCadastroGenerico)
    edtCodigo: TcxTextEdit;
    edtDescricao: TcxTextEdit;
    lblCodigo: TcxLabel;
    lblNome: TcxLabel;
    procedure edtCodigoKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
    procedure InicializaForm;
    procedure btnGravaClick(Sender: TObject);
    procedure edtCodigoEnter(Sender: TObject);
    procedure edtCodigoExit(Sender: TObject);
    procedure edtCodigoKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure brnDeletaClick(Sender: TObject);
  private
    { Private declarations }
    oNCM: tNCM;
  public
    { Public declarations }
  end;

var
  frmCadastroNCM: TfrmCadastroNCM;
  bRegistroNovo: Boolean;

implementation

uses uPrincipal;

{$R *.dfm}

procedure TfrmCadastroNCM.edtCodigoKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  KeyPressNumerico(Key);
end;

procedure TfrmCadastroNCM.FormShow(Sender: TObject);
begin
  inherited;
  oNCM := tNCM.Create(frmPrincipal.zcoConexaoBanco);
end;

procedure TfrmCadastroNCM.InicializaForm;
begin
  LimpaCampos(self, []);
  edtCodigo.SetFocus;
end;

procedure TfrmCadastroNCM.btnGravaClick(Sender: TObject);
begin
  inherited;
  with oNCM do
  begin
    SetDescricao(edtDescricao.Text);
    if bRegistroNovo then
    begin
      SetCodigo(StrToInt(edtCodigo.Text));
      CadastraNCM
    end
    else
      AlteraNCM;
    InicializaForm;
  end;
end;

procedure TfrmCadastroNCM.edtCodigoEnter(Sender: TObject);
begin
  inherited;
  InicializaForm;
  edtCodigo.Text := '';
  edtCodigo.SelectAll;
end;

procedure TfrmCadastroNCM.edtCodigoExit(Sender: TObject);
begin
  if Trim(edtCodigo.Text) <> '' then
  begin
    oNCM.SetCodigo(StrToInt(edtCodigo.Text));
    if oNCM.bPesquisaNCMCodigo(StrToInt(edtCodigo.Text)) then
    begin
      edtDescricao.Text := oNCM.GetsDescricao;
      bRegistroNovo := False;
    end
    else
      bRegistroNovo := True;
  end;
end;

procedure TfrmCadastroNCM.edtCodigoKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  if Key = vk_F2 then
  begin
    edtCodigo.Text := ChamaPesquisa(TEdit(Sender), frmPrincipal.zcoConexaoBanco)[0];
    edtCodigoExit(Sender);
  end;
end;

procedure TfrmCadastroNCM.brnDeletaClick(Sender: TObject);
begin
  inherited;
  oNCM.SetCodigo(StrToInt(edtCodigo.Text));
  oNCM.DeletaNCM;
  InicializaForm;
end;

end.
