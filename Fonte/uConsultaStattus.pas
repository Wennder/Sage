unit uConsultaStattus;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uCadastroGenerico, JvExControls, JvNavigationPane, StdCtrls, DB,
  ZAbstractRODataset, ZAbstractDataset, ZDataset, cxGraphics, cxLookAndFeels,
  cxLookAndFeelPainters, Menus, cxButtons, ExtCtrls, cxControls, cxContainer,
  cxEdit, cxTextEdit, cxLabel, UsoGeral;

type
  TfrmConsultaNFe = class(TfrmCadastroGenerico)
    edtDataPedido: TStaticText;
    Memo: TMemo;
    Query: TZQuery;
    edtNotaFiscal: TcxTextEdit;
    Label1: TcxLabel;
    Label3: TcxLabel;
    lblPedido: TStaticText;
    cxLabel1: TcxLabel;
    Label2: TcxLabel;
    edtCliente: TStaticText;
    procedure edtNotaFiscalExit(Sender: TObject);
    procedure edtNotaFiscalKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edtNotaFiscalKeyPress(Sender: TObject; var Key: Char);
    procedure btnGravaClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    bPedido: Boolean;
    sNomeArquivo: string;
    iPedido: Integer;
  public
    { Public declarations }
  end;

var
  frmConsultaNFe: TfrmConsultaNFe;

implementation

uses uNFe, uPrincipal;

{$R *.dfm}

procedure TfrmConsultaNFe.edtNotaFiscalExit(Sender: TObject);
begin
  inherited;
  if edtNotaFiscal.Text = '' then
    Exit;
  iPedido := 0;
  Query.Connection := frmPrincipal.zcoConexaoBanco;
  with Query do
  begin
    SQL.Clear;
    SQL.Add('Select tbpedido.icodigo, tbpedido.ddatapedido, tbpedido.icliente, tbpessoa.snome, tbPedido.bPedido From TbPedido');
    SQL.Add('left outer Join tbpessoa on tbpessoa.icodigo = icliente');
    SQL.Add('Where tbpedido.inotafiscal = :notafiscal');
    ParamByName('notafiscal').AsInteger := StrToInt(edtNotaFiscal.Text);
    Open;
    if not isEmpty then
    begin
      iPedido := FieldByName('icodigo').AsInteger;
      edtDataPedido.Caption := FormatDatetime('dd/mm/yyyy', FieldByName('ddatapedido').asDateTime);
      edtCliente.Caption := FieldByName('icliente').AsString + ' - ' + FieldByName('sNome').AsString;
      bPedido := FieldByName('bPedido').AsBoolean;
      lblPedido.Caption := IntToStr(iPedido);
    end
    else
      ShowMessage('Nota Fiscal não encontrada!');
  end;
end;

procedure TfrmConsultaNFe.edtNotaFiscalKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  if Key = vk_F2 then
  begin
    edtNotaFiscal.Text := ChamaPesquisa(TEdit(Sender), frmPrincipal.zcoConexaoBanco)[0];
    edtNotaFiscalExit(Sender);
  end;
end;

procedure TfrmConsultaNFe.edtNotaFiscalKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  KeyPressNumerico(Key);
end;

procedure TfrmConsultaNFe.btnGravaClick(Sender: TObject);
begin
  inherited;
  if iPedido <= 0 then
    Exit;
  uNFe.PesquisaDadosNF(IntToStr(iPedido));
  if uNFe.Query.isEmpty then
    pMsgAtencao('Pedido: ' + IntToStr(iPedido) + ' não encontrado!')
  else
  begin
    lblPedido.Caption := IntToStr(iPedido);
    sNomeArquivo := ExportarNFe(edtNotaFiscal.Text);
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
      ParamByName('Codigo').AsInteger := iPedido;
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
end;

procedure TfrmConsultaNFe.FormShow(Sender: TObject);
begin
  inherited;
  Query.Connection := frmPrincipal.zcoConexaoBanco;
end;

end.
