unit uCancelaCupomFiscal;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uCadastroGenerico, StdCtrls, JvXPCore, JvXPButtons,
  JvExControls, JvComponent, JvNavigationPane, uPedido, DB,
  ZAbstractRODataset, ZAbstractDataset, ZDataset, uControleECF, cxGraphics,
  cxLookAndFeels, cxLookAndFeelPainters, Menus, cxButtons, ExtCtrls, cxControls,
  cxContainer, cxEdit, cxTextEdit, cxLabel;

type
  TfrmCancelaCupomFiscal = class(TfrmCadastroGenerico)
    edtCliente: TStaticText;
    edtDataPedido: TStaticText;
    Query: TZQuery;
    edtPedido: TcxTextEdit;
    Label1: TcxLabel;
    Label2: TcxLabel;
    Label3: TcxLabel;
    procedure edtPedidoExit(Sender: TObject);
    procedure edtPedidoKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edtPedidoKeyPress(Sender: TObject; var Key: Char);
    procedure btnGravaClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    oPedido: TPedido;
  public
    { Public declarations }
  end;

var
  frmCancelaCupomFiscal: TfrmCancelaCupomFiscal;

implementation

uses uPrincipal;

{$R *.dfm}

procedure TfrmCancelaCupomFiscal.edtPedidoExit(Sender: TObject);
begin
  inherited;
  if edtPedido.Text = '' then
    Exit;
  Query.Connection := frmPrincipal.zcoConexaoBanco;
  with Query do
  begin
    SQL.Clear;
    SQL.Add('Select tbpedido.ddatapedido, tbpedido.icliente, COALESCE(TBPESSOA.SNOME, TBCONSUMIDOR.SNOME) AS snome, tbPedido.bPedido From TbPedido');
    SQL.Add('left outer Join tbpessoa on tbpessoa.icodigo = icliente');
    SQL.Add('LEFT OUTER JOIN TBCONSUMIDOR ON TBCONSUMIDOR.IPEDIDO = TBPEDIDO.ICODIGO');
    SQL.Add('Where tbpedido.icodigo = :codigo');
    ParamByName('Codigo').AsInteger := StrToInt(edtPedido.Text);
    Open;
    if not isEmpty then
    begin
      edtDataPedido.Caption := FormatDatetime('dd/mm/yyyy', FieldByName('ddatapedido').asDateTime);
      edtCliente.Caption := FieldByName('icliente').AsString + ' - ' + FieldByName('sNome').AsString;
    end
    else
      ShowMessage('Pedido não encontrado!');
  end;
end;

procedure TfrmCancelaCupomFiscal.edtPedidoKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  if Key = vk_F2 then
  begin
    edtPedido.Text := ChamaPesquisa(TEdit(Sender), frmPrincipal.zcoConexaoBanco)[0];
    edtPedidoExit(Sender);
  end;
end;

procedure TfrmCancelaCupomFiscal.edtPedidoKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  KeyPressNumerico(Key);
end;

procedure TfrmCancelaCupomFiscal.btnGravaClick(Sender: TObject);
begin
  inherited;
  if edtPedido.Text <> '' then
  begin
    oPedido.SetCodigo(StrToInt(edtPedido.Text));
    oPedido.CancelaPedido;
    Bematech_FI_CancelaCupom;
  end;
end;

procedure TfrmCancelaCupomFiscal.FormShow(Sender: TObject);
begin
  inherited;
  Query.Connection := frmPrincipal.zcoConexaoBanco;
  oPedido := TPedido.Create(frmPrincipal.zcoConexaoBanco);
end;

end.
