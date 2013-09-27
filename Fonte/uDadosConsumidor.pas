unit uDadosConsumidor;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uCadastroGenerico, StdCtrls, JvXPCore, JvXPButtons,
  JvExControls, JvComponent, JvNavigationPane, Mask, uCidade,
  uConsumidor, cxGraphics, cxLookAndFeels, cxLookAndFeelPainters, Menus,
  cxControls, cxContainer, cxEdit, cxTextEdit, cxButtons, ExtCtrls, cxLabel, dxSkinsCore,
  dxSkinOffice2010Silver;

type
  TfrmDadosConsumidor = class(TfrmCadastroGenerico)
    edtCEP: TMaskEdit;
    edtFone: TMaskEdit;
    edtNome: TcxTextEdit;
    edtEndereco: TcxTextEdit;
    edtBairro: TcxTextEdit;
    edtCidade: TcxTextEdit;
    edtCidadeNome: TcxTextEdit;
    lblNome: TcxLabel;
    Label1: TcxLabel;
    Label2: TcxLabel;
    Label3: TcxLabel;
    Label4: TcxLabel;
    Label5: TcxLabel;
    procedure BtnSairClick(Sender: TObject);
    procedure edtCidadeExit(Sender: TObject);
    procedure edtCidadeEnter(Sender: TObject);
    procedure edtCidadeKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edtCidadeKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure btnGravaClick(Sender: TObject);
  private
    { Private declarations }
    oCidade: TCidade;
    // oConsumidor: TConsumidor;
  public
    { Public declarations }
  end;

var
  frmDadosConsumidor: TfrmDadosConsumidor;

implementation

uses uPrincipal;

{$R *.dfm}

procedure TfrmDadosConsumidor.BtnSairClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TfrmDadosConsumidor.edtCidadeExit(Sender: TObject);
var
  bCidadeNaoEncontrada: boolean;
begin
  inherited;
  bCidadeNaoEncontrada := False;

  if ActiveControl = BtnSair then
    Exit;

  if (edtCidade.Text = '') or (edtCidade.Text = '0') then
  begin
    edtCidadeNome.Clear;
    Exit;
  end;

  if oCidade.bPesquisaCidade(edtCidade.Text) then
  begin
    if oCidade.sGetStatus = 'A' then
      edtCidadeNome.Text := oCidade.sGetNome
    else
      bCidadeNaoEncontrada := true;
  end
  else
    bCidadeNaoEncontrada := true;
  if bCidadeNaoEncontrada then
  begin
    Application.MessageBox(PChar('Cidade não cadastrada!'), 'Aviso', MB_OK);
    edtCidade.SetFocus;
  end;

end;

procedure TfrmDadosConsumidor.edtCidadeEnter(Sender: TObject);
begin
  inherited;
  edtCidade.SelectAll;
end;

procedure TfrmDadosConsumidor.edtCidadeKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  if Key = vk_F2 then
  begin
    edtCidade.Text := ChamaPesquisa(TEdit(Sender), frmPrincipal.zcoConexaoBanco)[0];
    edtCidadeExit(Sender);
  end;
end;

procedure TfrmDadosConsumidor.edtCidadeKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  KeyPressNumerico(Key);
end;

procedure TfrmDadosConsumidor.FormCreate(Sender: TObject);
begin
  inherited;
  oCidade := TCidade.Create(frmPrincipal.zcoConexaoBanco);
end;

procedure TfrmDadosConsumidor.btnGravaClick(Sender: TObject);
begin
  inherited;
  Close;
end;

end.
