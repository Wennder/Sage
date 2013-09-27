unit uControleCartaCorrecao;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uCadastroGenerico, cxGraphics,
  cxLookAndFeels, cxLookAndFeelPainters, Vcl.Menus, dxSkinsCore,
  dxSkinOffice2010Silver, Vcl.StdCtrls, cxButtons, Vcl.ExtCtrls, JvExControls,
  JvNavigationPane, cxControls, cxContainer, cxEdit, cxLabel, cxTextEdit;

type
  TfrmControleCartaCorrecao = class(TfrmCadastroGenerico)
    OpenDialog1: TOpenDialog;
    cxLabelMsg: TcxLabel;
    Memo: TMemo;
    cxTextEditCorrecao: TcxTextEdit;
    cxLabel1: TcxLabel;
    cxLabel2: TcxLabel;
    cxTextEditChaveNFe: TcxTextEdit;
    cxLabel3: TcxLabel;
    cxTextEditCNPJEmpresa: TcxTextEdit;
    procedure btnGravaClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmControleCartaCorrecao: TfrmControleCartaCorrecao;

implementation

uses UsoGeral;

{$R *.dfm}

procedure TfrmControleCartaCorrecao.btnGravaClick(Sender: TObject);
var
  ArquivoXMLNFe, ArquivoXMLCCe: String;
begin
  inherited;
  cxLabelMsg.Caption := 'Preparando para envio de CC-e...';
  Application.ProcessMessages;
  cxLabelMsg.Caption := 'Excluindo SAINFE.TXT';
  Application.ProcessMessages;
  if FileExists(ExtractFilePath(Application.ExeName) + 'NFE\SAINFE.TXT') then
  begin
    DeleteFile(ExtractFilePath(Application.ExeName) + 'NFE\SAINFE.TXT');
  end;
  cxLabelMsg.Caption := 'Gerando ENTNFE.txt';
  Application.ProcessMessages;
  Memo.Lines.Clear;
  Memo.Lines.Add('NFE.CARTADECORRECAO(');
  Memo.Lines.Add('[CCE]');
  Memo.Lines.Add('idLote=1');
  Memo.Lines.Add('[EVENTO001]');
  Memo.Lines.Add('chNFe=' + cxTextEditChaveNFe.Text);
  Memo.Lines.Add('cOrgao=51');
  Memo.Lines.Add('CNPJ=' + cxTextEditCNPJEmpresa.Text);
  Memo.Lines.Add('dhEvento=' + FormatDateTime('dd/mm/yyyy hh:mm:ss', Now));
  Memo.Lines.Add('nSeqEvento=1');
  Memo.Lines.Add('xCorrecao=' + cxTextEditCorrecao.Text);
  Memo.Lines.Add(')');
  cxLabelMsg.Caption := 'Enviando arquivo de CCE';
  Application.ProcessMessages;
  Memo.Lines.SaveToFile(ExtractFilePath(Application.ExeName) +
    'NFE\ENTNFE.TXT');
  cxLabelMsg.Caption := 'Aguardando retorno da SEFAZ...';
  Application.ProcessMessages;
  while not FileExists(ExtractFilePath(Application.ExeName) +
    'NFE\SAINFE.TXT') do
  begin
    Sleep(2000);
  end;
  with Memo do
  begin
    Lines.Clear;
    Lines.LoadFromFile(ExtractFilePath(Application.ExeName) + 'NFE\SAINFE.TXT');
    if fBuscaStringMemo(Memo, 'Rejeicao') then
      pMsgAtencao
        ('N�o foi poss�vel realizar o envio da Carta de Corre��o, por favor verifique o motivo nos detalhes.'
        + #13 + 'Poss�veis problemas:' + #13 + '- Chave da NFe incorreta' + #13
        + '- CNPJ incorreto' + #13 + '- Problemas com WebService', Lines.Text)
    else
      pMsgInfo('Carta de Corre��o enviada com sucesso!', Lines.Text);
    Lines.Clear;
    Lines.SaveToFile(ExtractFilePath(Application.ExeName) + 'NFE\SAINFE.TXT');
    cxLabelMsg.Caption := '';
    Application.ProcessMessages;
  end;
  if fPergunta('Deseja imprimir o evento da Carta de Corre��o?', True, '') then
  begin
    cxLabelMsg.Caption := 'Gerando impress�o do evento de carta de corre��o';
    OpenDialog1.Title :=
      'Arquivo XML da NF-e para gera��o de carta de corre��o (Com recibo da SEFAZ)';
    if OpenDialog1.Execute then
    begin
      ArquivoXMLNFe := OpenDialog1.FileName;
    end;
    OpenDialog1.Title := 'Arquivo XML da CC-e (Com recibo da SEFAZ)';
    if OpenDialog1.Execute then
    begin
      ArquivoXMLCCe := OpenDialog1.FileName;
    end;
    if FileExists(ExtractFilePath(Application.ExeName) + 'NFE\SAINFE.TXT') then
    begin
      DeleteFile(ExtractFilePath(Application.ExeName) + 'NFE\SAINFE.TXT');
    end;
    cxLabelMsg.Caption := 'Gerando arquivo para impress�o do evento';
    Application.ProcessMessages;
    Memo.Lines.Clear;
    Memo.Lines.Add('NFe.ImprimirEvento(' + ArquivoXMLCCe + ',' +
      ArquivoXMLNFe + ')');
    cxLabelMsg.Caption := 'Enviando arquivo de impress�o CCE';
    Memo.Lines.SaveToFile(ExtractFilePath(Application.ExeName) +
      'NFE\ENTNFE.TXT');
    cxLabelMsg.Caption := 'Agardando resposta do ACBR...';
    Application.ProcessMessages;
    Application.ProcessMessages;
    while not FileExists(ExtractFilePath(Application.ExeName) +
      'NFE\SAINFE.TXT') do
    begin
      Sleep(2000);
    end;
    with Memo do
    begin
      Lines.Clear;
      Lines.LoadFromFile(ExtractFilePath(Application.ExeName) +
        'NFE\SAINFE.TXT');
      if fBuscaStringMemo(Memo, 'Rejeicao') then
        pMsgAtencao
          ('N�o foi poss�vel realizar a impress�o do evento, por favor verifique o motivo nos detalhes.'
          ,Lines.Text)
      else
        pMsgInfo('Impress�o da carta de corre��o realizada com sucesso!', Lines.Text);
      Lines.Clear;
      Lines.SaveToFile(ExtractFilePath(Application.ExeName) + 'NFE\SAINFE.TXT');
      cxLabelMsg.Caption := '';
      Application.ProcessMessages;
    end;
  end;
end;

end.
