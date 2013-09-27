unit uCadastroRamoAtividade;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uCadastroGenerico, StdCtrls,
  JvExControls, JvComponent, JvNavigationPane, uRamoAtividade,
  cxGraphics, cxLookAndFeels, cxLookAndFeelPainters, Menus, cxButtons, ExtCtrls,
  cxControls, cxContainer, cxEdit, cxTextEdit, cxLabel, UsoGeral;

type
  TfrmCadastroRamoAtividade = class(TfrmCadastroGenerico)
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
  public
    oRamoAtividade: TRamoAtividade;
    bRegistroNovo: Boolean;
    procedure InicializaForm;
  end;

var
  frmCadastroRamoAtividade: TfrmCadastroRamoAtividade;

implementation

uses uPrincipal;

{$R *.dfm}
{ TfrmCadastroRamoAtividade }

procedure TfrmCadastroRamoAtividade.InicializaForm;
begin
  LimpaCampos(self, []);
  edtCodigo.SetFocus;
end;

procedure TfrmCadastroRamoAtividade.FormShow(Sender: TObject);
begin
  inherited;
  oRamoAtividade := TRamoAtividade.Create(frmPrincipal.zcoConexaoBanco);
  edtCodigo.SetFocus;
end;

procedure TfrmCadastroRamoAtividade.btnGravaClick(Sender: TObject);
begin
  inherited;
  with oRamoAtividade do
  begin
    if Trim(edtCodigo.Text) = '' then
      edtCodigo.Text := IntToStr(iRetornaUltimoCodigo + 1);

    if Trim(edtDescricao.Text) = '' then
    begin
      pMsgAtencao('Campo Descrição não pode ser vazio.');
      edtDescricao.SetFocus;
      Abort;
    end;

    SetCodigo(edtCodigo.Text);
    SetDescricao(edtDescricao.Text);
    if iCamposConsistentes = 0 then
    begin
      if bRegistroNovo then
        CadastraRamoAtividade
      else
        AlteraRamoAtividade;
      if iGetRegistrosAfetadosRamoAtividade > 0 then
        InicializaForm;
    end;
  end;
end;

procedure TfrmCadastroRamoAtividade.btnCancelaClick(Sender: TObject);
begin
  inherited;
  InicializaForm;
end;

procedure TfrmCadastroRamoAtividade.edtCodigoEnter(Sender: TObject);
begin
  inherited;
  if Trim(edtCodigo.Text) = '' then
    edtCodigo.Text := IntToStr(oRamoAtividade.iRetornaUltimoCodigo + 1);
  edtCodigo.SelectAll;
end;

procedure TfrmCadastroRamoAtividade.edtCodigoKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  if Key = vk_F2 then
  begin
    edtCodigo.Text := ChamaPesquisa(TEdit(Sender), frmPrincipal.zcoConexaoBanco)[0];
    Perform(WM_NEXTDLGCTL, 0, 0);
  end;
end;

procedure TfrmCadastroRamoAtividade.edtCodigoKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  KeyPressNumerico(Key);
end;

procedure TfrmCadastroRamoAtividade.brnDeletaClick(Sender: TObject);
begin
  inherited;
  oRamoAtividade.SetCodigo(edtCodigo.Text);
  oRamoAtividade.DeletaRamoAtividade;
  InicializaForm;
end;

procedure TfrmCadastroRamoAtividade.edtCodigoExit(Sender: TObject);
begin
  inherited;
  if Trim(edtCodigo.Text) = '' then
    edtCodigo.Text := IntToStr(oRamoAtividade.iRetornaUltimoCodigo + 1);

  oRamoAtividade.SetCodigo(edtCodigo.Text);
  if oRamoAtividade.bPesquisaRamoAtividade(edtCodigo.Text) then
  begin
    edtDescricao.Text := oRamoAtividade.sGetDescricao;
    bRegistroNovo := False;
  end
  else
  begin
    LimpaCampos(self, [edtCodigo]);
    bRegistroNovo := True;
  end;
end;

end.
