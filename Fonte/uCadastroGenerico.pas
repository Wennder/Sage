unit uCadastroGenerico;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, JvExControls, JvComponent, JvButton, Grids, ppReport, ppTypes,
  JvNavigationPane, JvExStdCtrls, JvMemoryDataset, cxCalendar, cxGridExportLink, cxMaskEdit,
  JvEdit, JvValidateEdit, Mask, uPesquisaGeral, ZConnection, ZDataset, ComCtrls, cxImageComboBox,
  cxGraphics, cxLookAndFeels, cxLookAndFeelPainters, Menus, cxButtons, ExtCtrls, cxTextEdit,
  dxSkinsCore, dxSkinSeven, dxSkinOffice2010Silver, cxCurrencyEdit, Datasnap.DBClient;

type
  TfrmCadastroGenerico = class(TForm)
    JvNavPaneToolPanel1: TJvNavPaneToolPanel;
    pn: TPanel;
    btnGrava: TcxButton;
    btnCancela: TcxButton;
    brnDeleta: TcxButton;
    BtnSair: TcxButton;
    btnExportar: TcxButton;
    SaveDlg: TSaveDialog;
    btnImprimir: TcxButton;
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BtnSairClick(Sender: TObject);
    procedure btnImprimirClick(Sender: TObject);
  private
    { Private declarations }
    procedure ColorControl(Sender: TObject);
  public
    { Public declarations }
    procedure LimpaCampos(fForm: TForm; aIgnorados: array of TComponent);
    procedure KeyPressNumerico(var sKey: Char);
    function ChamaPesquisa(Sender: TObject; pzcoConnection: TZConnection; sParametro: string = ''; pExibeBtnCad: Boolean = False;
      pExibeBtnOk: Boolean = True): TResultArray;
    function DeleteGridRow(AGrid: TStringGrid; ARow: Integer): Boolean;
    procedure LimpaGrid(AGrid: TStringGrid);
  end;

var
  frmCadastroGenerico: TfrmCadastroGenerico;

implementation

uses DateUtils;

{$R *.dfm}

procedure TfrmCadastroGenerico.ColorControl(Sender: TObject);
begin
end;

procedure TfrmCadastroGenerico.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    Perform(WM_NEXTDLGCTL, 0, 0);
  end;
end;

procedure TfrmCadastroGenerico.LimpaCampos(fForm: TForm; aIgnorados: array of TComponent);
var
  iCont: Integer;
  function bComponenteIgnorado(oComponente: TComponent): Boolean;
  var
    iCont1: Integer;
  begin
    Result := False;
    if (high(aIgnorados) >= 0) then
    begin
      for iCont1 := 0 to high(aIgnorados) do
      begin
        if oComponente = aIgnorados[iCont1] then
          Result := True;
        break;
      end;
    end;
  end;

begin
  with fForm do
  begin
    for iCont := 0 to ComponentCount - 1 do
    begin
      if not bComponenteIgnorado(Components[iCont]) then
        if Components[iCont] is TEdit then
          TEdit(Components[iCont]).Clear
        else if Components[iCont] is TcxTextEdit then
          TcxTextEdit(Components[iCont]).Clear
        else if Components[iCont] is TcxCurrencyEdit then
          TcxCurrencyEdit(Components[iCont]).EditValue := 0
        else if Components[iCont] is TcxImageComboBox then
          TcxImageComboBox(Components[iCont]).ItemIndex := -1
        else if Components[iCont] is TComboBox then
          TComboBox(Components[iCont]).ItemIndex := -1
        else if Components[iCont] is TJvValidateEdit then
          TJvValidateEdit(Components[iCont]).Value := 0
        else if Components[iCont] is TMaskEdit then
          TMaskEdit(Components[iCont]).Clear
        else if Components[iCont] is TcxMaskEdit then
          TcxMaskEdit(Components[iCont]).Clear
        else if Components[iCont] is TMemo then
          TMemo(Components[iCont]).Lines.Clear
        else if Components[iCont] is TStaticText then
          TStaticText(Components[iCont]).Caption := ''
        else if Components[iCont] is TDateTimePicker then
          TDateTimePicker(Components[iCont]).Date := Today
        else if Components[iCont] is TCheckBox then
          TCheckBox(Components[iCont]).Checked := False
        else if Components[iCont] is TcxDateEdit then
          TcxDateEdit(Components[iCont]).Clear
        else if Components[iCont] is TJvValidateEdit then
          TJvValidateEdit(Components[iCont]).Clear
        else if Components[iCont] is TJvMemoryData then
          TJvMemoryData(Components[iCont]).Active := False;
    end;
  end;
end;

procedure TfrmCadastroGenerico.FormCreate(Sender: TObject);
begin
  Screen.OnActiveControlChange := ColorControl;
end;

procedure TfrmCadastroGenerico.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Screen.OnActiveControlChange := nil;
end;

procedure TfrmCadastroGenerico.btnImprimirClick(Sender: TObject);
var
  nConta: Integer;
  nZoom: TppZoomSettingType;
begin
  with Self do
  begin
    nZoom := zs100Percent;
    if not DirectoryExists(ExtractFilePath(Application.Exename) + 'Relatórios Salvos\') then
      CreateDir(ExtractFilePath(Application.Exename) + 'Relatórios Salvos\');

    for nConta := 0 to ComponentCount - 1 do
    begin
      if LowerCase(Components[nConta].ClassName) = 'tppreport' then
      begin
        TppReport(Components[nConta]).TextFileName := ExtractFilePath(Application.Exename) + 'Relatórios Salvos\' + Self.Caption + '.pdf';
        TppReport(Components[nConta]).AllowPrintToArchive := True;
        TppReport(Components[nConta]).AllowPrintToFile := True;
        TppReport(Components[nConta]).OutlineSettings.CreateNode := False;
        TppReport(Components[nConta]).OutlineSettings.CreatePageNodes := False;
        TppReport(Components[nConta]).OutlineSettings.Enabled := False;
        TppReport(Components[nConta]).OutlineSettings.Visible := False;
        TppReport(Components[nConta]).PreviewFormSettings.WindowState := wsMaximized;
        TppReport(Components[nConta]).PreviewFormSettings.ZoomSetting := nZoom;
      end;
    end;
  end;
end;

procedure TfrmCadastroGenerico.BtnSairClick(Sender: TObject);
begin
  Self.Close;
end;

procedure TfrmCadastroGenerico.KeyPressNumerico(var sKey: Char);
begin
  if (not(sKey in ['0' .. '9'])) and (sKey <> Chr(8)) then
    sKey := #0;
end;

function TfrmCadastroGenerico.ChamaPesquisa(Sender: TObject; pzcoConnection: TZConnection; sParametro: string = ''; pExibeBtnCad: Boolean = False;
  pExibeBtnOk: Boolean = True): TResultArray;
begin
  if TWinControl(Sender) is TEdit then
    Result := Pesquisar(TEdit(Sender).Tag, TEdit(Sender).Text, pzcoConnection, sParametro, pExibeBtnCad)
  else if TWinControl(Sender) is TcxTextEdit then
    Result := Pesquisar(TcxTextEdit(Sender).Tag, TcxTextEdit(Sender).Text, pzcoConnection, sParametro, pExibeBtnCad)
  else if TWinControl(Sender) is TcxButton then
    Result := Pesquisar(TcxButton(Sender).Tag, TcxButton(Sender).Hint, pzcoConnection, sParametro, pExibeBtnCad, pExibeBtnOk);

  SetLength(Result, Length(Result));
end;

function TfrmCadastroGenerico.DeleteGridRow(AGrid: TStringGrid; ARow: Integer): Boolean;
var
  i: Integer;
  j: Integer;
begin
  if (ARow < AGrid.FixedRows) or (ARow >= AGrid.RowCount) then
  begin
    Exception.Create('Tentativa de deletar uma linha acima do intervalo ');
  end;
  if AGrid.RowCount = 2 then
  begin
    AGrid.RowCount := 2;
    LimpaGrid(AGrid);
    Exit;
  end;
  if (ARow < AGrid.RowCount - 1) then
  begin
    for i := ARow + 1 to AGrid.RowCount - 1 do
    begin
      for j := 0 to 10 do
        AGrid.Cells[j, i - 1] := AGrid.Cells[j, i];
    end;
  end;
  AGrid.RowCount := AGrid.RowCount - 1;
end;

procedure TfrmCadastroGenerico.LimpaGrid(AGrid: TStringGrid);
var
  i, j: Integer;
begin
  for i := 1 to AGrid.RowCount - 1 do
  begin
    for j := 0 to 10 do
    begin
      AGrid.Cells[j, i] := '';
    end;
  end;
  AGrid.RowCount := 2;
end;

end.
