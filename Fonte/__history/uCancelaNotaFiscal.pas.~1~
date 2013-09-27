unit uCancelaNotaFiscal;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uCadastroGenerico, JvExControls,
  JvComponent, JvNavigationPane, StdCtrls, DB,
  ZAbstractRODataset, ZAbstractDataset, ZDataset, cxGraphics, cxLookAndFeels,
  cxLookAndFeelPainters, Menus, cxButtons, ExtCtrls, cxControls, cxContainer,
  cxEdit, cxTextEdit, cxLabel;

type
  TfrmCancelaNotaFiscal = class(TfrmCadastroGenerico)
    edtDataPedido: TStaticText;
    edtCliente: TStaticText;
    Query: TZQuery;
    Memo: TMemo;
    edtPedido: TcxTextEdit;
    Label1: TcxLabel;
    Label3: TcxLabel;
    procedure btnGravaClick(Sender: TObject);
    procedure BtnSairClick(Sender: TObject);
    procedure edtPedidoExit(Sender: TObject);
    procedure edtPedidoKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edtPedidoKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmCancelaNotaFiscal: TfrmCancelaNotaFiscal;

implementation

uses UsoGeral, uPrincipal;

{$R *.dfm}

procedure TfrmCancelaNotaFiscal.btnGravaClick(Sender: TObject);
var
  Justificativa: string;
begin
  inherited;
  if edtPedido.Text = '' then
    Exit;

  if FileExists(ExtractFilePath(Application.ExeName) + 'NFE\SAINFE.TXT') then
  begin
    DeleteFile(ExtractFilePath(Application.ExeName) + 'NFE\SAINFE.TXT');
  end;
  Justificativa := InputBox('Justificativa', 'Justificativa', 'Cancelamento de NF-e devido a problemas tecnicos');
  Query.Connection := frmPrincipal.zcoConexaoBanco;
  with Query do
  begin
    SQL.Clear;
    SQL.Add('Select tbpedido.chave From TbPedido');
    SQL.Add('Where tbpedido.icodigo = :codigo');
    ParamByName('Codigo').AsInteger := StrToInt(edtPedido.Text);
    Open;

    Memo.Lines.Clear;
    Memo.Lines.Add('NFE.CANCELARNFE("' + Copy(FieldByName('Chave').AsSTring, 4, Length(FieldByName('Chave').AsSTring) - 1) + '","' +
      Justificativa + '")');
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
      begin
        pMsgAtencao('Não foi possível realizar o cancelamento da NFe, por favor verifique o motivo nos detalhes.' + #13 + 'Possíveis problemas:' + #13
          + '- Inconsistência nos dados gerados pela Nota.' + #13 + '- Problemas com WebService', Lines.Text);
        abort;
      end
      else
      begin
        pMsgInfo('NFe cancelada com sucesso!', Lines.Text);
        SQL.Clear;
        SQL.Add('update tbpedido set sstatus = ''I''');
        SQL.Add('Where tbpedido.icodigo = :codigo');
        ParamByName('Codigo').AsInteger := StrToInt(edtPedido.Text);
        Open;
      end;
      Lines.Clear;
      Lines.SaveToFile(ExtractFilePath(Application.ExeName) + 'NFE\SAINFE.TXT');
    end;
  end;
end;

procedure TfrmCancelaNotaFiscal.BtnSairClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TfrmCancelaNotaFiscal.edtPedidoExit(Sender: TObject);
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
      edtCliente.Caption := FieldByName('icliente').AsSTring + ' - ' + FieldByName('sNome').AsSTring;
    end
    else
      ShowMessage('Pedido não encontrado!');
  end;
end;

procedure TfrmCancelaNotaFiscal.edtPedidoKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  if Key = vk_F2 then
  begin
    edtPedido.Text := ChamaPesquisa(TEdit(Sender), frmPrincipal.zcoConexaoBanco)[0];
    edtPedidoExit(Sender);
  end;
end;

procedure TfrmCancelaNotaFiscal.edtPedidoKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  KeyPressNumerico(Key);
end;

end.
