unit uRelNotasFiscais;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uCadastroGenerico, StdCtrls, UsoGeral,
  JvExControls, JvComponent, JvNavigationPane, ZConnection, DB,
  ZAbstractRODataset, ZAbstractDataset, ZDataset, ppBands, ppCtrls,
  ppPrnabl, ppClass, ppCache, ppProd, ppReport, ppComm, ppRelatv, ppDB,
  ppDBPipe, ppModule, raCodMod, ppStrtch, ppMemo, ppParameter,
  ppFormWrapper, ppRptExp, ppVar, ExtCtrls, uNFe, cxGraphics, cxLookAndFeels,
  cxLookAndFeelPainters, Menus, cxButtons, cxControls, cxContainer, cxEdit,
  cxTextEdit, cxLabel, dxSkinsCore, dxSkinOffice2010Silver, ppDesignLayer, dxGDIPlusClasses, cxMemo;

type
  TfrmNotaFiscal = class(TfrmCadastroGenerico)
    ppReport: TppReport;
    DataSource1: TDataSource;
    RadioGroupTipo: TRadioGroup;
    edtCliente: TStaticText;
    edtDataPedido: TStaticText;
    ppDBPipeline1: TppDBPipeline;
    Memo: TMemo;
    ButtonAssinar: TButton;
    ButtonValidar: TButton;
    ButtonEnviar: TButton;
    ButtonConsultar: TButton;
    ButtonImprimir: TButton;
    ZQuery1: TZQuery;
    Query: TZQuery;
    edtPedido: TcxTextEdit;
    Label1: TcxLabel;
    Label2: TcxLabel;
    Label3: TcxLabel;
    LblUltimoPedido: TcxLabel;
    LabelStatus: TcxLabel;
    ppHeaderBand2: TppHeaderBand;
    ppShape4: TppShape;
    ppShape1: TppShape;
    ppImage1: TppImage;
    ppDBText11: TppDBText;
    ppVariable3: TppVariable;
    ppLabel10: TppLabel;
    ppDBText19: TppDBText;
    ppLabel12: TppLabel;
    ppDBText21: TppDBText;
    ppShape5: TppShape;
    ppLabel13: TppLabel;
    ppDBText23: TppDBText;
    ppVariable4: TppVariable;
    ppLabel14: TppLabel;
    ppLabel8: TppLabel;
    ppDBText18: TppDBText;
    ppLabel9: TppLabel;
    ppDBText22: TppDBText;
    ppLabel15: TppLabel;
    ppVariable2: TppVariable;
    ppShape6: TppShape;
    ppLabel17: TppLabel;
    ppLabel18: TppLabel;
    ppLabel16: TppLabel;
    ppLabel19: TppLabel;
    ppLabel20: TppLabel;
    ppLabel11: TppLabel;
    ppDBText30: TppDBText;
    ppVariable5: TppVariable;
    ppDetailBand2: TppDetailBand;
    ppShape2: TppShape;
    ppDBText24: TppDBText;
    ppDBText25: TppDBText;
    ppDBText26: TppDBText;
    ppDBText27: TppDBText;
    ppDBText28: TppDBText;
    ppDBText29: TppDBText;
    ppFooterBand2: TppFooterBand;
    ppShape8: TppShape;
    ppLabel24: TppLabel;
    ppSystemVariable1: TppSystemVariable;
    ppLabel25: TppLabel;
    ppLabel26: TppLabel;
    ppSystemVariable2: TppSystemVariable;
    ppSummaryBand1: TppSummaryBand;
    ppShape7: TppShape;
    ppLabel21: TppLabel;
    ppLabel22: TppLabel;
    ppDBCalc2: TppDBCalc;
    ppDBCalc1: TppDBCalc;
    ppShape3: TppShape;
    ppLabel23: TppLabel;
    ppVariable6: TppVariable;
    ppDBMemo1: TppDBMemo;
    ppVariable7: TppVariable;
    ppLine1: TppLine;
    ppVariable8: TppVariable;
    ppLine4: TppLine;
    ppLabel1: TppLabel;
    raCodeModule2: TraCodeModule;
    ppDesignLayers2: TppDesignLayers;
    ppDesignLayer2: TppDesignLayer;
    mmLog: TcxMemo;
    procedure edtPedidoKeyPress(Sender: TObject; var Key: Char);
    procedure btnGravaClick(Sender: TObject);
    procedure edtPedidoExit(Sender: TObject);
    procedure edtPedidoKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure EmiteNFe;
    procedure ButtonAssinarClick(Sender: TObject);
    procedure ButtonValidarClick(Sender: TObject);
    procedure ButtonEnviarClick(Sender: TObject);
    procedure ButtonConsultarClick(Sender: TObject);
    procedure ButtonImprimirClick(Sender: TObject);

  private
    bPedido: Boolean;
    sNomeArquivo: string;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmNotaFiscal: TfrmNotaFiscal;

implementation

uses uPrincipal;

{$R *.dfm}

procedure TfrmNotaFiscal.edtPedidoKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  KeyPressNumerico(Key);
end;

procedure TfrmNotaFiscal.btnGravaClick(Sender: TObject);
begin
  inherited;
  if bPedido then
  begin
    if RadioGroupTipo.ItemIndex = 0 then
    begin
      uNFe.PesquisaDadosNF(edtPedido.Text);
      if uNFe.Query.isEmpty then
        ShowMessage('Pedido: ' + edtPedido.Text + ' não encontrado!')
      else
        sNomeArquivo := ExportarNFe(edtPedido.Text);
    end
    else
    begin
      ZQuery1.Connection := frmPrincipal.zcoConexaoBanco;
      ZQuery1.SQL.LoadFromFile(ExtractFilePath(Application.ExeName) + 'Sql\select_NFS.txt');
      ZQuery1.ParamByName('Pedido').AsString := edtPedido.Text;
      ZQuery1.Open;
      ppReport.Template.FileName := ExtractFilePath(Application.ExeName) + 'Rtm\NotaServico.rtm';
      ppReport.Template.LoadFromFile;
      ppReport.Print;
    end;
  end
  else
  begin
    if Trim(frmPrincipal.fGetParams('NmArqOrcamento')) = '' then
    begin
      pMsgAtencao('Arquivo de Relatório para emissão de Orçamento não foi definido.' + #13 +
        'Entre em contato com o suporte e relate este problema.');
      Abort;
    end;
    ZQuery1.Connection := frmPrincipal.zcoConexaoBanco;
    ZQuery1.SQL.LoadFromFile(ExtractFilePath(Application.ExeName) + 'Sql\select_pedido.txt');
    ZQuery1.ParamByName('Pedido').AsString := edtPedido.Text;
    ZQuery1.Open;
    ppReport.Template.FileName := ExtractFilePath(Application.ExeName) + 'Rtm\' + frmPrincipal.fGetParams('NmArqOrcamento');
    ppReport.Template.LoadFromFile;
    ppReport.Print;
  end;
end;

procedure TfrmNotaFiscal.edtPedidoExit(Sender: TObject);
begin
  inherited;
  if edtPedido.Text = '' then
    Exit;
  Query.Connection := frmPrincipal.zcoConexaoBanco;
  with Query do
  begin
    SQL.Clear;
    SQL.Add('Select tbpedido.ddatapedido, tbpedido.icliente, tbpessoa.snome, tbPedido.bPedido From TbPedido');
    SQL.Add('left outer Join tbpessoa on tbpessoa.icodigo = icliente');
    SQL.Add('Where tbpedido.icodigo = :codigo');
    ParamByName('Codigo').AsInteger := StrToInt(edtPedido.Text);
    Open;
    if not isEmpty then
    begin
      edtDataPedido.Caption := FormatDatetime('dd/mm/yyyy', FieldByName('ddatapedido').asDateTime);
      edtCliente.Caption := FieldByName('icliente').AsString + ' - ' + FieldByName('sNome').AsString;
      RadioGroupTipo.Enabled := True;
      LabelStatus.Caption := '';
      if not FieldByName('bPedido').AsBoolean then
      begin
        RadioGroupTipo.Enabled := False;
        LabelStatus.Caption := 'Orçamento';
      end;
      bPedido := FieldByName('bPedido').AsBoolean;
    end
    else
      ShowMessage('Pedido não encontrado!');
  end;
end;

procedure TfrmNotaFiscal.edtPedidoKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  if Key = vk_F2 then
  begin
    edtPedido.Text := ChamaPesquisa(TEdit(Sender), frmPrincipal.zcoConexaoBanco)[0];
    edtPedidoExit(Sender);
  end;
end;

procedure TfrmNotaFiscal.FormShow(Sender: TObject);
begin
  inherited;
  Query.Connection := frmPrincipal.zcoConexaoBanco;
  with Query do
  begin
    Close;
    SQL.Clear;
    SQL.Add('select max(icodigo)as MaxPedido from tbpedido');
    Open;
    LblUltimoPedido.Caption := 'Último Pedido: ' + FieldByName('MaxPedido').AsString;
  end;

end;

procedure TfrmNotaFiscal.EmiteNFe;
begin
  ExportarNFe(edtPedido.Text);
end;

procedure TfrmNotaFiscal.ButtonAssinarClick(Sender: TObject);
begin
  inherited;
  if FileExists(ExtractFilePath(Application.ExeName) + 'NFE\ACBrNFeMonitor\SAINFE.TXT') then
  begin
    DeleteFile(ExtractFilePath(Application.ExeName) + 'NFE\ACBrNFeMonitor\SAINFE.TXT');
  end;
  Memo.Lines.Clear;
  Memo.Lines.Add('NFE.ASSINARNFE("' + sNomeArquivo + '")');

  Memo.Lines.SaveToFile(ExtractFilePath(Application.ExeName) + 'NFE\ACBrNFeMonitor\ENTNFE.TXT');

  while not FileExists(ExtractFilePath(Application.ExeName) + 'NFE\ACBrNFeMonitor\SAINFE.TXT') do
  begin
    Sleep(2000);
    mmLog.Lines.Add('Localizando arquivos NFe...');
  end;

  with Memo do
  begin
    Lines.Clear;
    Lines.LoadFromFile(ExtractFilePath(Application.ExeName) + 'NFE\ACBrNFeMonitor\SAINFE.TXT');
    if fBuscaStringMemo(Memo, 'ERRO') then
      pMsgAtencao('Não foi possível realizar a assinatura da NFe, por favor verifique o motivo nos detalhes.', Lines.Text)
    else
      pMsgInfo('NFe assinada com sucesso!', Lines.Text);
    Lines.Clear;
    Lines.SaveToFile(ExtractFilePath(Application.ExeName) + 'NFE\ACBrNFeMonitor\SAINFE.TXT');
  end;
end;

procedure TfrmNotaFiscal.ButtonValidarClick(Sender: TObject);
begin
  inherited;
  if FileExists(ExtractFilePath(Application.ExeName) + 'NFE\SAINFE.TXT') then
  begin
    DeleteFile(ExtractFilePath(Application.ExeName) + 'NFE\SAINFE.TXT');
  end;
  Memo.Lines.Clear;
  Memo.Lines.Add('NFE.VALIDARNFE("' + sNomeArquivo + '")');
  Memo.Lines.SaveToFile(ExtractFilePath(Application.ExeName) + 'NFE\ENTNFE.TXT');
  while not FileExists(ExtractFilePath(Application.ExeName) + 'NFE\SAINFE.TXT') do
  begin
    Sleep(2000);
  end;

  with Memo do
  begin
    Lines.Clear;
    Lines.LoadFromFile(ExtractFilePath(Application.ExeName) + 'NFE\SAINFE.TXT');
    if fBuscaStringMemo(Memo, 'ERRO') then
      pMsgAtencao('Não foi possível realizar a validação da NFe, por favor verifique o motivo nos detalhes.', Lines.Text)
    else
      pMsgInfo('NFe validada com sucesso!', Lines.Text);
    Lines.Clear;
    Lines.SaveToFile(ExtractFilePath(Application.ExeName) + 'NFE\SAINFE.TXT');
  end;
end;

procedure TfrmNotaFiscal.ButtonEnviarClick(Sender: TObject);
begin
  inherited;
  if FileExists(ExtractFilePath(Application.ExeName) + 'NFE\SAINFE.TXT') then
  begin
    DeleteFile(ExtractFilePath(Application.ExeName) + 'NFE\SAINFE.TXT');
  end;
  Query.Connection := frmPrincipal.zcoConexaoBanco;
  with Query do
  begin
    SQL.Clear;
    SQL.Add('Select tbpedido.lote From TbPedido');
    SQL.Add('Where tbpedido.icodigo = :codigo');
    ParamByName('Codigo').AsInteger := StrToInt(edtPedido.Text);
    Open;

    Memo.Lines.Clear;
    Memo.Lines.Add('NFE.ENVIARNFE("' + sNomeArquivo + '",' + FieldByName('lote').AsString + ',0,1)');
    Memo.Lines.SaveToFile(ExtractFilePath(Application.ExeName) + 'NFE\ENTNFE.TXT');
    while not FileExists(ExtractFilePath(Application.ExeName) + 'NFE\SAINFE.TXT') do
    begin
      Sleep(2000);
    end;
    with Memo do
    begin
      Lines.Clear;
      Lines.LoadFromFile(ExtractFilePath(Application.ExeName) + 'NFE\SAINFE.TXT');
      if fBuscaStringMemo(Memo, 'Rejeicao') then
        pMsgAtencao('Não foi possível realizar o envio da NFe, por favor verifique o motivo nos detalhes.' + #13 + 'Possíveis problemas:' + #13 +
          '- Inconsistência nos dados gerados pela Nota.' + #13 + '- Problemas com WebService', Lines.Text)
      else
        pMsgInfo('NFe enviada com sucesso!', Lines.Text);
      Lines.Clear;
      Lines.SaveToFile(ExtractFilePath(Application.ExeName) + 'NFE\SAINFE.TXT');
    end;
  end;
end;

procedure TfrmNotaFiscal.ButtonConsultarClick(Sender: TObject);
begin
  inherited;
  if FileExists(ExtractFilePath(Application.ExeName) + 'NFE\SAINFE.TXT') then
  begin
    DeleteFile(ExtractFilePath(Application.ExeName) + 'NFE\SAINFE.TXT');
  end;
  Query.Connection := frmPrincipal.zcoConexaoBanco;
  with Query do
  begin
    SQL.Clear;
    SQL.Add('Select tbpedido.chave From TbPedido');
    SQL.Add('Where tbpedido.icodigo = :codigo');
    ParamByName('Codigo').AsInteger := StrToInt(edtPedido.Text);
    Open;

    Memo.Lines.Clear;
    Memo.Lines.Add('NFE.CONSULTARNFE("' + Copy(FieldByName('Chave').AsString, 4, Length(FieldByName('Chave').AsString) - 1) + '")');
    Memo.Lines.SaveToFile(ExtractFilePath(Application.ExeName) + 'NFE\ENTNFE.TXT');
    while not FileExists(ExtractFilePath(Application.ExeName) + 'NFE\SAINFE.TXT') do
    begin
      Sleep(2000);
    end;

    with Memo do
    begin
      Lines.Clear;
      Lines.LoadFromFile(ExtractFilePath(Application.ExeName) + 'NFE\SAINFE.TXT');
      pMsgInfo('Consulta realizada no WebService da SEFAZ, abra os detalhes para visualização do status!', Lines.Text);
      Lines.Clear;
      Lines.SaveToFile(ExtractFilePath(Application.ExeName) + 'NFE\SAINFE.TXT');
    end;
  end;
end;

procedure TfrmNotaFiscal.ButtonImprimirClick(Sender: TObject);
begin
  inherited;
  if FileExists(ExtractFilePath(Application.ExeName) + 'NFE\SAINFE.TXT') then
  begin
    DeleteFile(ExtractFilePath(Application.ExeName) + 'NFE\SAINFE.TXT');
  end;
  Memo.Lines.Clear;
  Memo.Lines.Add('NFE.IMPRIMIRDANFE("' + sNomeArquivo + '")');
  Memo.Lines.SaveToFile(ExtractFilePath(Application.ExeName) + 'NFE\ENTNFE.TXT');
  while not FileExists(ExtractFilePath(Application.ExeName) + 'NFE\SAINFE.TXT') do
  begin
    Sleep(2000);
  end;
  with Memo do
  begin
    Lines.Clear;
    Lines.LoadFromFile(ExtractFilePath(Application.ExeName) + 'NFE\SAINFE.TXT');
    if fBuscaStringMemo(Memo, 'ERRO') then
      pMsgAtencao('Não foi possível realizar a impressão do DANFE, por favor verifique o motivo nos detalhes.', Lines.Text)
    else
      pMsgInfo('DANFE impresso com sucesso!', Lines.Text);
    Lines.Clear;
    Lines.SaveToFile(ExtractFilePath(Application.ExeName) + 'NFE\SAINFE.TXT');
  end;
end;

end.
