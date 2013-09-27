unit uEntradaNFCancela;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uCadastroGenerico, cxGraphics, cxLookAndFeels,
  cxLookAndFeelPainters, Vcl.Menus, Vcl.StdCtrls, cxButtons, Vcl.ExtCtrls, JvExControls,
  JvNavigationPane, cxControls, cxContainer, cxEdit, Vcl.ComCtrls, dxCore, cxDateUtils, cxMaskEdit,
  cxDropDownEdit, cxCalendar, cxLabel, cxTextEdit, uFuncoes, uProcedimentosBanco, UsoGeral, uEntrada,
  uPesquisaGeral, uFornecedor;

type
  TfrmEntradaNFCancela = class(TfrmCadastroGenerico)
    Bevel1: TBevel;
    edtFornecedor: TcxTextEdit;
    EditSerie: TcxTextEdit;
    lblProduto: TcxLabel;
    Label1: TcxLabel;
    Label3: TcxLabel;
    Label4: TcxLabel;
    stFornecedor: TcxTextEdit;
    edtDataEmissao: TcxDateEdit;
    edtDataEntrada: TcxDateEdit;
    EditNumeroNF: TcxTextEdit;
    Label2: TcxLabel;
    procedure edtFornecedorExit(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure edtFornecedorKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edtFornecedorKeyPress(Sender: TObject; var Key: Char);
    procedure EditNumeroNFKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnGravaClick(Sender: TObject);
  private
    { Private declarations }
    oFornecedor: TFornecedor;
    oEntrada: TEntrada;
  public
    { Public declarations }
  end;

var
  frmEntradaNFCancela: TfrmEntradaNFCancela;

implementation

Uses uPrincipal;

{$R *.dfm}

procedure TfrmEntradaNFCancela.btnGravaClick(Sender: TObject);
begin
  inherited;
  if Trim(edtFornecedor.Text) = '' then
  begin
    pMsgAtencao('Código do Fornecedor da Entrada não foi informado.');
    edtFornecedor.SetFocus;
    Abort;
  end;

  if Trim(EditNumeroNF.Text) = '' then
  begin
    pMsgAtencao('Número da Nota de Entrada não foi informado.');
    EditNumeroNF.SetFocus;
    Abort;
  end;

  if Trim(EditSerie.Text) = '' then
  begin
    pMsgAtencao('Série da Nota de Entrada não foi informada');
    EditSerie.SetFocus;
    Abort;
  end;

  if fPergunta('O cancelamento da entrada implicará no estorno da quantidade de itens que foram adicionados ao estoque' + #13 + 'Deseja prosseguir?')
  then
    oEntrada.CancelaNF(edtFornecedor.Text, EditNumeroNF.Text, EditSerie.Text)
  else
  begin
    btnGrava.SetFocus;
    Abort;
  end;
end;

procedure TfrmEntradaNFCancela.EditNumeroNFKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
Var
  Resultado: TResultArray;
begin
  inherited;
  if Key = vk_F2 then
  begin
    Resultado := ChamaPesquisa(TEdit(Sender), frmPrincipal.zcoConexaoBanco, 'where e.fornecedor = ' + QuotedStr(edtFornecedor.Text));
    SetLength(Resultado, Length(Resultado));

    EditSerie.Text := Resultado[0];
    EditNumeroNF.Text := Resultado[1];
    edtDataEntrada.Text := Resultado[2];
    edtDataEmissao.Text := Resultado[3];

    Perform(WM_NEXTDLGCTL, 0, 0);
  end;

end;

procedure TfrmEntradaNFCancela.edtFornecedorExit(Sender: TObject);
begin
  inherited;
  if edtFornecedor.Text = '' then
  begin
    edtFornecedor.SetFocus;
    Exit;
  end;

  oFornecedor.bPesquisaFornecedor(edtFornecedor.Text);
  stFornecedor.Text := oFornecedor.sGetNome;
  if stFornecedor.Text = '' then
    edtFornecedor.SetFocus;
end;

procedure TfrmEntradaNFCancela.edtFornecedorKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  if Key = vk_F2 then
  begin
    edtFornecedor.Text := ChamaPesquisa(TEdit(Sender), frmPrincipal.zcoConexaoBanco)[0];
    Perform(WM_NEXTDLGCTL, 0, 0);
  end;
end;

procedure TfrmEntradaNFCancela.edtFornecedorKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  KeyPressNumerico(Key);
end;

procedure TfrmEntradaNFCancela.FormShow(Sender: TObject);
begin
  inherited;
  oFornecedor := TFornecedor.Create(frmPrincipal.zcoConexaoBanco);
  oEntrada := TEntrada.Create(frmPrincipal.zcoConexaoBanco);
end;

end.
