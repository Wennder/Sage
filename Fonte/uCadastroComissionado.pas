unit uCadastroComissionado;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uCadastroGenerico, JvExControls,
  JvComponent, JvNavigationPane, StdCtrls, JvExStdCtrls,
  JvEdit, JvValidateEdit, uComissionado, Mask, cxGraphics, cxLookAndFeels,
  cxLookAndFeelPainters, Menus, cxButtons, ExtCtrls, cxControls, cxContainer,
  cxEdit, cxTextEdit, cxLabel;

type
  TfrmCadastroComissionado = class(TfrmCadastroGenerico)
    edtComissao: TJvValidateEdit;
    edtCEP: TMaskEdit;
    edtFone: TMaskEdit;
    edtFax: TMaskEdit;
    edtCelular: TMaskEdit;
    edtCodigo: TcxTextEdit;
    edtNome: TcxTextEdit;
    edtEndereco: TcxTextEdit;
    edtBairro: TcxTextEdit;
    edtCidade: TcxTextEdit;
    edtEmail: TcxTextEdit;
    edtCidadeNome: TcxTextEdit;
    lblCodigo: TcxLabel;
    lblNome: TcxLabel;
    lblComissao: TcxLabel;
    lblEndereco: TcxLabel;
    lblBairro: TcxLabel;
    lblCidade: TcxLabel;
    lblCEP: TcxLabel;
    lblFone: TcxLabel;
    lblFax: TcxLabel;
    lblCelular: TcxLabel;
    lblEmail: TcxLabel;
    procedure FormShow(Sender: TObject);
    procedure btnGravaClick(Sender: TObject);
    procedure btnCancelaClick(Sender: TObject);
    procedure edtCodigoEnter(Sender: TObject);
    procedure edtCodigoKeyPress(Sender: TObject; var Key: Char);
    procedure brnDeletaClick(Sender: TObject);
    procedure edtCodigoExit(Sender: TObject);
    procedure edtCidadeEnter(Sender: TObject);
    procedure edtCidadeExit(Sender: TObject);
    procedure edtCidadeKeyPress(Sender: TObject; var Key: Char);
    procedure edtCidadeKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edtCodigoKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    oComissionado: TComissionado;
    bRegistroNovo: Boolean;
    procedure InicializaForm;
  public
    { Public declarations }
  end;

var
  frmCadastroComissionado: TfrmCadastroComissionado;

implementation

uses uPrincipal, uPessoa;

{$R *.dfm}

procedure TfrmCadastroComissionado.FormShow(Sender: TObject);
begin
  inherited;
  oComissionado := TComissionado.Create(frmPrincipal.zcoConexaoBanco);
  edtCodigo.SetFocus;
end;

procedure TfrmCadastroComissionado.InicializaForm;
begin
  LimpaCampos(self, []);
  edtCodigo.SetFocus;
end;

procedure TfrmCadastroComissionado.btnGravaClick(Sender: TObject);
begin
  inherited;

  with oComissionado do
  begin
    SetCodigo(edtCodigo.Text);
    SetNome(edtNome.Text);
    SetComissao(FloatToStr(edtComissao.AsFloat));
    SetEndereco(edtEndereco.Text);
    SetBairro(edtBairro.Text);
    oCidade.SetCodigo(edtCidade.Text);
    SetCep(edtCEP.Text);
    SetFone(edtFone.Text);
    SetFax(edtFax.Text);
    SetCelular(edtCelular.Text);
    SetEmail(edtEmail.Text);
    if iCamposConsistentes = 0 then
    begin
      if bRegistroNovo then
        CadastraComissionado
      else
        AlteraComissionado;
      if iGetRegistrosAfetadosComissionado > 0 then
        InicializaForm;
    end;
  end;
end;

procedure TfrmCadastroComissionado.btnCancelaClick(Sender: TObject);
begin
  inherited;
  InicializaForm;
end;

procedure TfrmCadastroComissionado.edtCodigoEnter(Sender: TObject);
begin
  inherited;
  if Trim(edtCodigo.Text) = '' then
    edtCodigo.Text := IntToStr(oComissionado.iRetornaUltimoCodigo + 1);
  edtCodigo.SelectAll;
end;

procedure TfrmCadastroComissionado.edtCodigoKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  KeyPressNumerico(Key);
end;

procedure TfrmCadastroComissionado.brnDeletaClick(Sender: TObject);
begin
  inherited;
  oComissionado.SetCodigo(edtCodigo.Text);
  oComissionado.DeletaComissionado;
  InicializaForm;
end;

procedure TfrmCadastroComissionado.edtCodigoExit(Sender: TObject);
begin
  inherited;
  if Trim(edtCodigo.Text) <> '' then
  begin
    oComissionado.SetCodigo(edtCodigo.Text);
    if oComissionado.bPesquisaComissionado(edtCodigo.Text) then
    begin
      with oComissionado do
      begin
        edtNome.Text := sGetNome;
        edtComissao.AsFloat := StrToFloat(sGetComissao);
        edtEndereco.Text := sGetEndereco;
        edtBairro.Text := sGetBairro;
        edtCidade.Text := oCidade.sGetCodigo;
        edtCidadeNome.Text := oCidade.sGetNome;
        edtCEP.Text := sGetCep;
        edtFone.Text := sGetFone;
        edtFax.Text := sGetFax;
        edtCelular.Text := sGetCelular;
        edtEmail.Text := sGetEmail;
      end;
      bRegistroNovo := False;
    end
    else
    begin
      if oComissionado.bPesquisaPessoa(edtCodigo.Text) then
      begin
        ShowMessage('Código já utilizado para outra Pessoa!');
        btnCancelaClick(self);
      end
      else
      begin
        LimpaCampos(self, [edtCodigo]);
        bRegistroNovo := True;
      end;
    end;
  end;
end;

procedure TfrmCadastroComissionado.edtCidadeEnter(Sender: TObject);
begin
  inherited;
  edtCidade.SelectAll;
end;

procedure TfrmCadastroComissionado.edtCidadeExit(Sender: TObject);
var
  bCidadeNaoEncontrada: Boolean;
begin
  inherited;
  bCidadeNaoEncontrada := False;

  if ActiveControl = BtnSair then
    Exit;

  if (edtCidade.Text = '') or (edtCidade.Text = '0') then
    Exit;

  if oComissionado.oCidade.bPesquisaCidade(edtCidade.Text) then
  begin
    if oComissionado.oCidade.sGetStatus = 'A' then
      edtCidadeNome.Text := oComissionado.oCidade.sGetNome
    else
      bCidadeNaoEncontrada := True;
  end
  else
    bCidadeNaoEncontrada := True;
  if bCidadeNaoEncontrada then
  begin
    Application.MessageBox(PChar('Cidade não cadastrada!'), 'Aviso', MB_OK);
    edtCidade.SetFocus;
  end;
end;

procedure TfrmCadastroComissionado.edtCidadeKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  KeyPressNumerico(Key);
end;

procedure TfrmCadastroComissionado.edtCidadeKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  if Key = vk_F2 then
  begin
    edtCidade.Text := ChamaPesquisa(TEdit(Sender), frmPrincipal.zcoConexaoBanco)[0];
    edtCidadeExit(Sender);
  end;
end;

procedure TfrmCadastroComissionado.edtCodigoKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  if Key = vk_F2 then
  begin
    edtCodigo.Text := ChamaPesquisa(TEdit(Sender), frmPrincipal.zcoConexaoBanco)[0];
    Perform(WM_NEXTDLGCTL, 0, 0);
  end;
end;

end.
