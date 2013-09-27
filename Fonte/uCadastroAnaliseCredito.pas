unit uCadastroAnaliseCredito;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uCadastroGenerico, JvExControls,
  JvComponent, JvNavigationPane, ComCtrls, JvExStdCtrls,
  JvEdit, JvValidateEdit, StdCtrls, uAnaliseCredito, cxGraphics, cxLookAndFeels,
  cxLookAndFeelPainters, Menus, cxButtons, ExtCtrls, cxControls, cxContainer,
  cxEdit, cxTextEdit, cxLabel, cxMaskEdit, cxDropDownEdit, cxCalendar, dxCore, cxDateUtils;

type
  TfrmCadastroAnaliseCredito = class(TfrmCadastroGenerico)
    stCliente: TStaticText;
    edtLimiteCredito: TJvValidateEdit;
    edtCliente: TcxTextEdit;
    Label1: TcxLabel;
    Label2: TcxLabel;
    Label3: TcxLabel;
    edtValidade: TcxDateEdit;
    procedure edtClienteKeyPress(Sender: TObject; var Key: Char);
    procedure edtClienteKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edtClienteEnter(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure edtClienteExit(Sender: TObject);
    procedure btnCancelaClick(Sender: TObject);
    procedure brnDeletaClick(Sender: TObject);
    procedure btnGravaClick(Sender: TObject);
  private
    { Private declarations }
    oAnaliseCredito: TAnaliseCredito;
    bRegistroNovo: Boolean;
    procedure InicializaForm;
  public
    { Public declarations }
  end;

var
  frmCadastroAnaliseCredito: TfrmCadastroAnaliseCredito;

implementation

uses uPrincipal, uPessoa, UsoGeral;

{$R *.dfm}

procedure TfrmCadastroAnaliseCredito.InicializaForm;
begin
  LimpaCampos(self, [edtCliente]);
  edtCliente.SetFocus;
end;

procedure TfrmCadastroAnaliseCredito.edtClienteKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  KeyPressNumerico(Key);
end;

procedure TfrmCadastroAnaliseCredito.edtClienteKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  if Key = vk_F2 then
  begin
    edtCliente.Text := ChamaPesquisa(TEdit(Sender), frmPrincipal.zcoConexaoBanco)[0];
    edtLimiteCredito.SetFocus;
  end;
end;

procedure TfrmCadastroAnaliseCredito.edtClienteEnter(Sender: TObject);
begin
  inherited;
  LimpaCampos(self, []);
  edtCliente.SelectAll;
end;

procedure TfrmCadastroAnaliseCredito.FormShow(Sender: TObject);
begin
  inherited;
  oAnaliseCredito := TAnaliseCredito.Create(frmPrincipal.zcoConexaoBanco);
end;

procedure TfrmCadastroAnaliseCredito.edtClienteExit(Sender: TObject);
begin
  inherited;
  if (edtCliente.Text = '') or (edtCliente.Text = '0') then
  begin
    edtCliente.SetFocus;
    Exit;
  end;
  oAnaliseCredito.SetCodigo(StrToInt(edtCliente.Text));
  if oAnaliseCredito.bPesquisaAnalise(oAnaliseCredito.iGetCodigo) then
  begin
    stCliente.Caption := oAnaliseCredito.oCliente.sGetNome;
    edtLimiteCredito.Value := oAnaliseCredito.nGetLimiteCredito;
    edtValidade.Date := oAnaliseCredito.dGetVencimento;
  end
  else
  begin
    Application.MessageBox('Código de cliente não encontrado', 'Alerta', MB_OK + MB_ICONEXCLAMATION);
    edtCliente.SetFocus;
  end;
end;

procedure TfrmCadastroAnaliseCredito.btnCancelaClick(Sender: TObject);
begin
  inherited;
  InicializaForm;
end;

procedure TfrmCadastroAnaliseCredito.brnDeletaClick(Sender: TObject);
begin
  inherited;
  oAnaliseCredito.SetCodigo(StrToInt(edtCliente.Text));
  oAnaliseCredito.DeletaAnalise;
  InicializaForm;
end;

procedure TfrmCadastroAnaliseCredito.btnGravaClick(Sender: TObject);
begin
  inherited;
  if trim(edtCliente.Text) = '' then
  begin
    pMsgAtencao('Nenhum cliente selecionado.');
    edtCliente.SetFocus;
    Abort;
  end
  else
  begin
    with oAnaliseCredito do
    begin
      SetCodigo(StrToInt(edtCliente.Text));
      SetLimiteCredito(edtLimiteCredito.Value);
      SetVencimento(edtValidade.Date);
      CadastraAnalise;
    end;
    InicializaForm;
  end;
end;

end.
