unit uAtualizacaoScript;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, dxGDIPlusClasses, Vcl.ExtCtrls, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage,
  cxEdit, cxNavigator, Data.DB, cxDBData, Vcl.Menus, Vcl.StdCtrls, cxButtons, cxGridLevel, uScript,
  cxClasses, cxGridCustomView, cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid,
  Datasnap.DBClient, cxContainer, cxTextEdit, cxLabel, uCadastroGenerico, cxProgressBar;

type
  TfrmAtualizacaoScript = class(TForm)
    imgFundo: TImage;
    grdScriptDBTableView1: TcxGridDBTableView;
    grdScriptLevel1: TcxGridLevel;
    grdScript: TcxGrid;
    btnExecutar: TcxButton;
    btnVisualizar: TcxButton;
    cdsScriptsPendentes: TClientDataSet;
    dsScriptsPendentes: TDataSource;
    cdsScriptsPendentesnmscript: TStringField;
    grdScriptDBTableView1nmscript: TcxGridDBColumn;
    cxLabel1: TcxLabel;
    edtUltScript: TcxTextEdit;
    BtnSair: TcxButton;
    btnHistorico: TcxButton;
    progress: TcxProgressBar;
    procedure FormShow(Sender: TObject);
    procedure btnVisualizarClick(Sender: TObject);
    procedure btnExecutarClick(Sender: TObject);
    procedure BtnSairClick(Sender: TObject);
    procedure btnHistoricoClick(Sender: TObject);
  private
    { Private declarations }
    oScript: TScript;
  public
    { Public declarations }
  end;

var
  frmAtualizacaoScript: TfrmAtualizacaoScript;

implementation

Uses uPrincipal, uTexto, UsoGeral;

{$R *.dfm}

procedure TfrmAtualizacaoScript.btnHistoricoClick(Sender: TObject);
Var
  Resultado: String;
begin
  Resultado := frmCadastroGenerico.ChamaPesquisa(Sender, frmPrincipal.zcoConexaoBanco, '', False, False)[0];
  Perform(WM_NEXTDLGCTL, 0, 0);
end;

procedure TfrmAtualizacaoScript.BtnSairClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmAtualizacaoScript.btnExecutarClick(Sender: TObject);
Var
  i: integer;
begin
  if Trim(cdsScriptsPendentes.FieldByName('nmscript').Text) <> '' then
  begin
    with cdsScriptsPendentes do
    begin
      First;
      i := 0;
      progress.Properties.Max := RecordCount;
      progress.Properties.Text := 'Atualização em andamento. Aguarde...';
      while not Eof do
      begin
        oScript.ListaScriptPendente(Self, cdsScriptsPendentes, ExtractFilePath(Application.Exename) + 'Scripts');
        edtUltScript.Text := oScript.RetornaUltScriptExecutado;
        if oScript.ExecutaScript(Self, ExtractFilePath(Application.Exename) + 'Scripts\' + cdsScriptsPendentes.FieldByName('nmscript').Text,
          cdsScriptsPendentes.FieldByName('nmscript').Text) then
        begin
          inc(i);
          progress.Position := (RecNo * 100) / RecordCount;
          progress.Repaint;
          Self.Repaint;
          Next;
        end
        else
        begin
          progress.Position := 0;
          progress.Properties.Text := '';
          Abort;
        end;
      end;
      if i = cdsScriptsPendentes.RecordCount then
      begin
        pMsgInfo('Atualização de Scripts realizada com sucesso!');
        progress.Position := 0;
        progress.Properties.Text := '';
        oScript.ListaScriptPendente(Self, cdsScriptsPendentes, ExtractFilePath(Application.Exename) + 'Scripts');
        edtUltScript.Text := oScript.RetornaUltScriptExecutado;
      end;
    end;
  end
  else
  begin
    pMsgAtencao('Não existe(m) script(s) pendentes na lista para atualização.');
    progress.Position := 0;
    progress.Properties.Text := '';
    btnExecutar.SetFocus;
    Abort;
  end;
end;

procedure TfrmAtualizacaoScript.btnVisualizarClick(Sender: TObject);
Var
  vTexto: String;
begin
  if Trim(cdsScriptsPendentes.FieldByName('nmscript').Text) <> '' then
  begin
    vTexto := oScript.AbreScript(Self, ExtractFilePath(Application.Exename) + 'Scripts\' + cdsScriptsPendentes.FieldByName('nmscript').Text,
      cdsScriptsPendentes.FieldByName('nmscript').Text);

    if Trim(vTexto) <> '' then
    begin
      frmTexto := TfrmTexto.Create(nil);
      frmTexto.mmTexto.Lines.Add('/*');
      frmTexto.mmTexto.Lines.Add(' * Nome do Arquivo: ' + cdsScriptsPendentes.FieldByName('nmscript').Text);
      frmTexto.mmTexto.Lines.Add(' * Caminho do Arquivo: ' + ExtractFilePath(Application.Exename) + 'Scripts\');
      frmTexto.mmTexto.Lines.Add(' */');
      frmTexto.mmTexto.Lines.Add('');
      frmTexto.mmTexto.Lines.Add(vTexto);
      frmTexto.ShowModal;
      FreeAndNil(frmTexto);
    end;
  end
  else
  begin
    pMsgAtencao('Nenhum arquivo de script foi selecionado para visualização.');
    btnVisualizar.SetFocus;
    Abort;
  end;
end;

procedure TfrmAtualizacaoScript.FormShow(Sender: TObject);
begin
  oScript := TScript.Create(frmPrincipal.zcoConexaoBanco);
  oScript.CargaInicialScript;
  oScript.ListaScriptPendente(Self, cdsScriptsPendentes, ExtractFilePath(Application.Exename) + 'Scripts');
  oScript.Setidusuario(vIdUsuario);
  edtUltScript.Text := oScript.RetornaUltScriptExecutado;
  progress.Position := 0;
  progress.Properties.Text := '';
end;

end.
