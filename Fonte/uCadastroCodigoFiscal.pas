unit uCadastroCodigoFiscal;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uCadastroGenerico, JvExControls,
  JvComponent, JvNavigationPane, uCodigoFiscal, StdCtrls,
  JvExStdCtrls, JvEdit, JvValidateEdit, cxGraphics, cxLookAndFeels,
  cxLookAndFeelPainters, Menus, cxButtons, ExtCtrls, cxControls, cxContainer,
  cxEdit, cxTextEdit, cxLabel;

type
  TfrmCadastroCodigoFiscal = class(TfrmCadastroGenerico)
    edtIcmsPF: TJvValidateEdit;
    edtIcmsPJ: TJvValidateEdit;
    edtCodigo: TcxTextEdit;
    edtDescricao: TcxTextEdit;
    lblCodigo: TcxLabel;
    lblDescricao: TcxLabel;
    Label1: TcxLabel;
    Label2: TcxLabel;
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
    oCodigoFiscal: TCodigoFiscal;
    bRegistroNovo: Boolean;
    procedure InicializaForm;
  public
    { Public declarations }
  end;

var
  frmCadastroCodigoFiscal: TfrmCadastroCodigoFiscal;

implementation

uses uPrincipal, UsoGeral;

{$R *.dfm}
{ TfrmCadastroCodigoFiscal }

procedure TfrmCadastroCodigoFiscal.InicializaForm;
begin
  LimpaCampos(self, [edtCodigo]);
  edtCodigo.SetFocus;
end;

procedure TfrmCadastroCodigoFiscal.FormShow(Sender: TObject);
begin
  inherited;
  oCodigoFiscal := TCodigoFiscal.Create(frmPrincipal.zcoConexaoBanco);
end;

procedure TfrmCadastroCodigoFiscal.btnGravaClick(Sender: TObject);
begin
  inherited;
  if (trim(edtCodigo.Text) = '') or (trim(edtCodigo.Text) = '0000') then
  begin
    pMsgAtencao('Código fiscal não pode ser vazio ou 0000.');
    edtCodigo.SetFocus;
    Abort;
  end
  else
  begin
    with oCodigoFiscal do
    begin
      SetiCodigo(StrToInt(edtCodigo.Text));
      SetsDescricao(edtDescricao.Text);
      SetnIcmsPF(edtIcmsPF.Value);
      SetnIcmsPJ(edtIcmsPJ.Value);
      if bRegistroNovo then
        CadastraCodigoFiscal
      else
        AlteraCodigoFiscal;
      InicializaForm;
    end;
  end;
end;

procedure TfrmCadastroCodigoFiscal.btnCancelaClick(Sender: TObject);
begin
  inherited;
  InicializaForm;
end;

procedure TfrmCadastroCodigoFiscal.edtCodigoEnter(Sender: TObject);
begin
  inherited;
  InicializaForm;
  edtCodigo.Text := '0000';
  edtCodigo.SelectAll;
end;

procedure TfrmCadastroCodigoFiscal.edtCodigoKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  KeyPressNumerico(Key);
end;

procedure TfrmCadastroCodigoFiscal.brnDeletaClick(Sender: TObject);
begin
  inherited;
  oCodigoFiscal.SetiCodigo(StrToInt(edtCodigo.Text));
  oCodigoFiscal.DeletaCodigoFiscal;
  InicializaForm;
end;

procedure TfrmCadastroCodigoFiscal.edtCodigoExit(Sender: TObject);
begin
  inherited;
  oCodigoFiscal.SetiCodigo(StrToInt(edtCodigo.Text));
  if oCodigoFiscal.bPesquisaCodigoFiscal(StrToInt(edtCodigo.Text)) then
  begin
    edtDescricao.Text := oCodigoFiscal.sGetDescricao;
    edtIcmsPF.Value := oCodigoFiscal.nGetIcmsPF;
    edtIcmsPJ.Value := oCodigoFiscal.nGetIcmsPJ;
    bRegistroNovo := False;
  end
  else
    bRegistroNovo := True;
end;

procedure TfrmCadastroCodigoFiscal.edtCodigoKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  if Key = vk_F2 then
  begin
    edtCodigo.Text := ChamaPesquisa(TEdit(Sender), frmPrincipal.zcoConexaoBanco)[0];
    edtCodigoExit(Sender);
  end;
end;

end.
