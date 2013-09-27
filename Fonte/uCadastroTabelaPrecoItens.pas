unit uCadastroTabelaPrecoItens;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uCadastroGenerico, JvExControls,
  JvComponent, JvNavigationPane, uTabelaPrecoItens,
  JvExStdCtrls, JvEdit, JvValidateEdit, StdCtrls, cxGraphics, cxLookAndFeels,
  cxLookAndFeelPainters, Menus, cxButtons, ExtCtrls, cxControls, cxContainer,
  cxEdit, cxTextEdit, cxLabel;

type
  TfrmCadastroTabelaPrecoItens = class(TfrmCadastroGenerico)
    stTabela: TStaticText;
    stProduto: TStaticText;
    edtPreco: TJvValidateEdit;
    edtTabela: TcxTextEdit;
    edtProduto: TcxTextEdit;
    lblTabela: TcxLabel;
    lblProduto: TcxLabel;
    lblPreco: TcxLabel;
    procedure edtTabelaKeyPress(Sender: TObject; var Key: Char);
    procedure edtTabelaKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edtProdutoKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edtTabelaEnter(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure edtTabelaExit(Sender: TObject);
    procedure edtProdutoExit(Sender: TObject);
    procedure btnCancelaClick(Sender: TObject);
    procedure brnDeletaClick(Sender: TObject);
    procedure btnGravaClick(Sender: TObject);
  private
    { Private declarations }
    oTabelaPrecoItens: TTabelaPrecoItens;
    bRegistroNovo: Boolean;
    procedure InicializaForm;
  public
    { Public declarations }
  end;

var
  frmCadastroTabelaPrecoItens: TfrmCadastroTabelaPrecoItens;

implementation

uses uPrincipal, uTabelaPreco, uProduto, uMarca;

{$R *.dfm}
{ TfrmCadastroTabelaPrecoItens }

procedure TfrmCadastroTabelaPrecoItens.InicializaForm;
begin
  LimpaCampos(self, [edtTabela]);
  edtTabela.SetFocus;
end;

procedure TfrmCadastroTabelaPrecoItens.edtTabelaKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  KeyPressNumerico(Key);
end;

procedure TfrmCadastroTabelaPrecoItens.edtTabelaKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  if Key = vk_F2 then
  begin
    edtTabela.Text := ChamaPesquisa(TEdit(Sender), frmPrincipal.zcoConexaoBanco)[0];
    edtProduto.SetFocus;
  end;
end;

procedure TfrmCadastroTabelaPrecoItens.edtProdutoKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  if Key = vk_F2 then
  begin
    edtProduto.Text := ChamaPesquisa(TEdit(Sender), frmPrincipal.zcoConexaoBanco)[0];
    edtPreco.SetFocus;
  end;
end;

procedure TfrmCadastroTabelaPrecoItens.edtTabelaEnter(Sender: TObject);
begin
  inherited;
  LimpaCampos(self, []);
  edtTabela.SelectAll;
end;

procedure TfrmCadastroTabelaPrecoItens.FormShow(Sender: TObject);
begin
  inherited;
  oTabelaPrecoItens := TTabelaPrecoItens.Create(frmPrincipal.zcoConexaoBanco);
end;

procedure TfrmCadastroTabelaPrecoItens.edtTabelaExit(Sender: TObject);
begin
  inherited;
  if (edtTabela.Text = '') or (edtTabela.Text = '0') then
  begin
    edtTabela.SetFocus;
    Exit;
  end;
  oTabelaPrecoItens.oTabelaPreco.SetCodigo(StrToInt(edtTabela.Text));
  if oTabelaPrecoItens.oTabelaPreco.bPesquisaTabelaPreco(oTabelaPrecoItens.oTabelaPreco.iGetCodigo) then
  begin
    stTabela.Caption := oTabelaPrecoItens.oTabelaPreco.sGetDescricao;
  end
  else
  begin
    Application.MessageBox('Tabela de Preço não encontrada', 'Alerta', MB_OK + MB_ICONEXCLAMATION);
    edtTabela.SetFocus;
  end;
end;

procedure TfrmCadastroTabelaPrecoItens.edtProdutoExit(Sender: TObject);
begin
  inherited;
  if (edtProduto.Text = '') or (edtProduto.Text = '0') then
  begin
    edtProduto.SetFocus;
    Exit;
  end;
  oTabelaPrecoItens.oProduto.SetCodigo(StrToInt(edtProduto.Text));
  if oTabelaPrecoItens.oProduto.bPesquisaProduto(oTabelaPrecoItens.oProduto.GetiCodigo) then
  begin
    stProduto.Caption := oTabelaPrecoItens.oProduto.GetsDescricaoComMarca;
    edtTabelaExit(edtTabela);
    if oTabelaPrecoItens.bPesquisaTabelaPrecoItens(oTabelaPrecoItens.oTabelaPreco.iGetCodigo, oTabelaPrecoItens.oProduto.GetiCodigo) then
    begin
      edtPreco.Value := oTabelaPrecoItens.nGetPreco;
      bRegistroNovo := False;
    end
    else
    begin
      edtPreco.Value := 0;
      bRegistroNovo := True;
      oTabelaPrecoItens.SetCodigo(oTabelaPrecoItens.iRetornaUltimoCodigo + 1);
    end;
  end
  else
  begin
    Application.MessageBox('Código do Produto não encontrado', 'Alerta', MB_OK + MB_ICONEXCLAMATION);
    edtProduto.SetFocus;
  end;
end;

procedure TfrmCadastroTabelaPrecoItens.btnCancelaClick(Sender: TObject);
begin
  inherited;
  InicializaForm;
end;

procedure TfrmCadastroTabelaPrecoItens.brnDeletaClick(Sender: TObject);
begin
  inherited;
  oTabelaPrecoItens.DeletaTabelaPrecoItens;
  InicializaForm;
end;

procedure TfrmCadastroTabelaPrecoItens.btnGravaClick(Sender: TObject);
begin
  inherited;
  oTabelaPrecoItens.SetPreco(edtPreco.Value);
  oTabelaPrecoItens.oTabelaPreco.SetCodigo(StrToInt(edtTabela.Text));
  oTabelaPrecoItens.oProduto.SetCodigo(StrToInt(edtProduto.Text));
  if bRegistroNovo then
    oTabelaPrecoItens.CadastraTabelaPrecoItens
  else
    oTabelaPrecoItens.AlteraTabelaPrecoItens;
  InicializaForm;
end;

end.
