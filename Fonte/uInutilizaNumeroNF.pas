unit uInutilizaNumeroNF;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uCadastroGenerico, JvExControls,
  JvComponent, JvNavigationPane, StdCtrls, DB,
  ZAbstractRODataset, ZAbstractDataset, ZDataset, cxGraphics, cxLookAndFeels,
  cxLookAndFeelPainters, Menus, cxButtons, ExtCtrls, cxControls, cxContainer,
  cxEdit, cxTextEdit, cxLabel;

type
  TfrmInutilizaNumeroNF = class(TfrmCadastroGenerico)
    Query: TZQuery;
    Memo: TMemo;
    edtNumeroInicial: TcxTextEdit;
    edtNumeroFinal: TcxTextEdit;
    Label1: TcxLabel;
    Label2: TcxLabel;
    procedure edtNumeroInicialKeyPress(Sender: TObject; var Key: Char);
    procedure edtNumeroFinalKeyPress(Sender: TObject; var Key: Char);
    procedure btnGravaClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmInutilizaNumeroNF: TfrmInutilizaNumeroNF;

implementation

uses uPrincipal;

{$R *.dfm}

procedure TfrmInutilizaNumeroNF.edtNumeroInicialKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  KeyPressNumerico(Key);
end;

procedure TfrmInutilizaNumeroNF.edtNumeroFinalKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  KeyPressNumerico(Key);
end;

procedure TfrmInutilizaNumeroNF.btnGravaClick(Sender: TObject);
var
  Justificativa: string;
begin
  inherited;
  if edtNumeroFinal.Text = '' then
    Exit;
  if edtNumeroInicial.Text = '' then
    Exit;

  if StrToInt(edtNumeroFinal.Text) < StrToInt(edtNumeroInicial.Text) then
  begin
    ShowMessage('O número final não pode ser menor que o número inicial!');
    Exit;
  end;

  if FileExists(ExtractFilePath(Application.ExeName) + 'NFE\SAINFE.TXT') then
  begin
    DeleteFile(ExtractFilePath(Application.ExeName) + 'NFE\SAINFE.TXT');
  end;
  Justificativa := InputBox('Justificativa', 'Justificativa', 'Inutilizacao de numero devido a problemas tecnicos');
  Query.Connection := frmPrincipal.zcoConexaoBanco;
  with Query do
  begin

    Memo.Lines.Clear;

    Memo.Lines.Add('NFE.INUTILIZARNFE("36963452000116","' + Justificativa + '", 10, 55, 1, ' + edtNumeroInicial.Text + ',' +
      edtNumeroFinal.Text + ')');

    Memo.Lines.SaveToFile(ExtractFilePath(Application.ExeName) + 'NFE\ENTNFE.TXT');
    while not FileExists(ExtractFilePath(Application.ExeName) + 'NFE\SAINFE.TXT') do
    begin
      Sleep(2000);
    end;
    Memo.Lines.Clear;
    Memo.Lines.loadFromFile(ExtractFilePath(Application.ExeName) + 'NFE\SAINFE.TXT');
    ShowMessage('Inutilização de números: ' + Memo.Lines.Text);
    Memo.Lines.Clear;
    Memo.Lines.SaveToFile(ExtractFilePath(Application.ExeName) + 'NFE\SAINFE.TXT');
  end;
end;

end.
