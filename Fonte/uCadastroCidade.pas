unit uCadastroCidade;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uCadastroGenerico, JvExControls,
  JvComponent, JvNavigationPane, uCidade, StdCtrls, cxGraphics,
  cxLookAndFeels, cxLookAndFeelPainters, Menus, cxButtons, ExtCtrls, cxControls,
  cxContainer, cxEdit, cxTextEdit, cxLabel, dxSkinsCore, dxSkinOffice2010Silver;

type
  TfrmCadastroCidade = class(TfrmCadastroGenerico)
    cboUF: TComboBox;
    edtCodigo: TcxTextEdit;
    edtNome: TcxTextEdit;
    EditCodIbge: TcxTextEdit;
    lblCodigo: TcxLabel;
    lblNome: TcxLabel;
    lblUF: TcxLabel;
    Label1: TcxLabel;
    procedure FormShow(Sender: TObject);
    procedure btnGravaClick(Sender: TObject);
    procedure btnCancelaClick(Sender: TObject);
    procedure edtCodigoEnter(Sender: TObject);
    procedure edtCodigoKeyPress(Sender: TObject; var Key: Char);
    procedure brnDeletaClick(Sender: TObject);
    procedure edtCodigoExit(Sender: TObject);
    procedure edtCodigoKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    oCidade: TCidade;
    bRegistroNovo: Boolean;
    procedure InicializaForm;
  public
    { Public declarations }
  end;

var
  frmCadastroCidade: TfrmCadastroCidade;

implementation

uses uPrincipal;

{$R *.dfm}

procedure TfrmCadastroCidade.FormShow(Sender: TObject);
begin
  inherited;
  oCidade := TCidade.Create(frmPrincipal.zcoConexaoBanco);
  edtCodigo.SetFocus;
end;

procedure TfrmCadastroCidade.InicializaForm;
begin
  LimpaCampos(self, []);
  edtCodigo.SetFocus;
end;

procedure TfrmCadastroCidade.btnGravaClick(Sender: TObject);
begin
  inherited;
  if Trim(edtCodigo.Text) = '' then
    edtCodigo.Text := IntToStr(oCidade.iRetornaUltimoCodigo + 1);

  with oCidade do
  begin
    SetCodigo(edtCodigo.Text);
    SetNome(edtNome.Text);
    SetUF(cboUF.Text);
    SetCodIbge(EditCodIbge.Text);
    if iCamposConsistentes = 0 then
    begin
      if bRegistroNovo then
        CadastraCidade
      else
        AlteraCidade;
      if iGetRegistrosAfetadosCidade > 0 then
        InicializaForm;
    end;
  end;
end;

procedure TfrmCadastroCidade.btnCancelaClick(Sender: TObject);
begin
  inherited;
  InicializaForm;
end;

procedure TfrmCadastroCidade.edtCodigoEnter(Sender: TObject);
begin
  inherited;
  if Trim(edtCodigo.Text) = '' then
    edtCodigo.Text := IntToStr(oCidade.iRetornaUltimoCodigo + 1);
  edtCodigo.SelectAll;
end;

procedure TfrmCadastroCidade.edtCodigoKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  KeyPressNumerico(Key);
end;

procedure TfrmCadastroCidade.brnDeletaClick(Sender: TObject);
begin
  inherited;
  oCidade.SetCodigo(edtCodigo.Text);
  oCidade.DeletaCidade;
  InicializaForm;
end;

procedure TfrmCadastroCidade.edtCodigoExit(Sender: TObject);
begin
  inherited;
  if Trim(edtCodigo.Text) = '' then
    edtCodigo.Text := IntToStr(oCidade.iRetornaUltimoCodigo + 1);

  oCidade.SetCodigo(edtCodigo.Text);
  if oCidade.bPesquisaCidade(edtCodigo.Text) then
  begin
    edtNome.Text := oCidade.sGetNome;
    cboUF.ItemIndex := cboUF.Items.IndexOf(oCidade.sGetUF);
    EditCodIbge.Text := oCidade.sGetCodIbge;
    bRegistroNovo := False;
  end
  else
  begin
    LimpaCampos(self, [edtCodigo]);
    bRegistroNovo := True;
  end;
end;

procedure TfrmCadastroCidade.edtCodigoKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  if Key = vk_F2 then
  begin
    edtCodigo.Text := ChamaPesquisa(TEdit(Sender), frmPrincipal.zcoConexaoBanco)[0];
    Perform(WM_NEXTDLGCTL, 0, 0);
  end;
end;

end.
