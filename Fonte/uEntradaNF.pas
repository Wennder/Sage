unit uEntradaNF;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uCadastroGenerico, JvExControls, uFuncoes, uProcedimentosBanco, UsoGeral, uEntrada, uFornecedor,
  JvComponent, JvNavigationPane, Mask, StdCtrls, cxStyles,
  cxCustomData, cxGraphics, cxFilter, cxData, cxDataStorage, cxEdit, DB,
  cxDBData, cxGridCustomTableView, cxGridTableView, cxGridBandedTableView,
  cxGridDBBandedTableView, SQLMemMain, cxControls, cxGridCustomView,
  cxClasses, cxGridLevel, cxGrid, Buttons, uProduto,
  JvExStdCtrls, JvEdit, JvValidateEdit, cxLookAndFeels,
  cxLookAndFeelPainters, Menus, dxSkinsCore, dxSkinOffice2010Silver,
  dxSkinscxPCPainter, cxButtons, ExtCtrls, cxContainer, cxTextEdit, cxLabel, cxNavigator,
  Vcl.ComCtrls, dxCore, cxDateUtils, cxMaskEdit, cxDropDownEdit, cxCalendar;

type
  TfrmEntradaNF = class(TfrmCadastroGenerico)
    SQLMemTableEntrada: TSQLMemTable;
    DataSourceEntrada: TDataSource;
    SQLMemTableEntradaProduto: TIntegerField;
    SQLMemTableEntradaQuantidade: TFloatField;
    SQLMemTableEntradaValorUnitario: TFloatField;
    SQLMemTableEntradaDescricao: TStringField;
    SQLMemTableEntradaCodigoPreferencial: TStringField;
    SQLMemTableEntradaValorTotal: TFloatField;
    edtValor: TJvValidateEdit;
    edtQuantidade: TJvValidateEdit;
    SQLMemQuery: TSQLMemQuery;
    edtFornecedor: TcxTextEdit;
    EditSerie: TcxTextEdit;
    EditNumeroNF: TcxTextEdit;
    edtProduto: TcxTextEdit;
    lblProduto: TcxLabel;
    Label1: TcxLabel;
    Label2: TcxLabel;
    Label3: TcxLabel;
    Label4: TcxLabel;
    Label5: TcxLabel;
    lblPreco: TcxLabel;
    Label6: TcxLabel;
    Label7: TcxLabel;
    stFornecedor: TcxTextEdit;
    stProduto: TcxTextEdit;
    stUnidade: TcxTextEdit;
    edtDataEmissao: TcxDateEdit;
    edtDataEntrada: TcxDateEdit;
    Bevel1: TBevel;
    btnInsere: TcxButton;
    btnDeleta: TcxButton;
    cxGrid1: TcxGrid;
    cxGrid1DBBandedTableView1: TcxGridDBBandedTableView;
    cxGrid1DBBandedTableView1Produto: TcxGridDBBandedColumn;
    cxGrid1DBBandedTableView1Quantidade: TcxGridDBBandedColumn;
    cxGrid1DBBandedTableView1ValorUnitario: TcxGridDBBandedColumn;
    cxGrid1DBBandedTableView1Descricao: TcxGridDBBandedColumn;
    cxGrid1DBBandedTableView1CodigoPreferencial: TcxGridDBBandedColumn;
    cxGrid1DBBandedTableView1ValorTotal: TcxGridDBBandedColumn;
    cxGrid1Level1: TcxGridLevel;
    procedure edtFornecedorKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edtFornecedorKeyPress(Sender: TObject; var Key: Char);
    procedure edtFornecedorExit(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure edtProdutoExit(Sender: TObject);
    procedure edtProdutoKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edtProdutoKeyPress(Sender: TObject; var Key: Char);
    procedure edtFornecedorEnter(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure btnGravaClick(Sender: TObject);
    procedure btnInsereClick(Sender: TObject);
    procedure btnDeletaClick(Sender: TObject);
    procedure BtnSairClick(Sender: TObject);
    procedure LimpaCamposProduto;
    procedure edtProdutoEnter(Sender: TObject);
    procedure EditSerieExit(Sender: TObject);
    procedure EditNumeroNFExit(Sender: TObject);
  private
    { Private declarations }
    oFornecedor: TFornecedor;
    oProduto: TProduto;
    oEntrada: TEntrada;
  public
    { Public declarations }
  end;

var
  frmEntradaNF: TfrmEntradaNF;

implementation

uses uPrincipal;

{$R *.dfm}

procedure TfrmEntradaNF.edtFornecedorKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  if Key = vk_F2 then
  begin
    edtFornecedor.Text := ChamaPesquisa(TEdit(Sender), frmPrincipal.zcoConexaoBanco)[0];
    Perform(WM_NEXTDLGCTL, 0, 0);
  end;
end;

procedure TfrmEntradaNF.edtFornecedorKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  KeyPressNumerico(Key);
end;

procedure TfrmEntradaNF.edtFornecedorExit(Sender: TObject);
begin
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

procedure TfrmEntradaNF.FormShow(Sender: TObject);
begin
  inherited;
  edtDataEmissao.Date := fDataHoraSrv(frmPrincipal.zcoConexaoBanco);
  edtDataEntrada.Date := edtDataEmissao.Date;

  oFornecedor := TFornecedor.Create(frmPrincipal.zcoConexaoBanco);
  oProduto := TProduto.Create(frmPrincipal.zcoConexaoBanco);
  oEntrada := TEntrada.Create(frmPrincipal.zcoConexaoBanco);
  InicializaSqlMemTable(SQLMemTableEntrada);
end;

procedure TfrmEntradaNF.edtProdutoExit(Sender: TObject);
begin
  inherited;
  if (ActiveControl = cxGrid1) or (ActiveControl = btnGrava) or (ActiveControl = btnCancela) or (ActiveControl = btnSair) then
    Exit;
  if (edtProduto.Text = '') or (edtProduto.Text = '0') then
  begin
    Exit;
  end;
  oProduto.bPesquisaProduto(StrToInt(edtProduto.Text));
  stProduto.Text := oProduto.GetsDescricaoComMarca;
  stUnidade.Text := oProduto.oUndSaida.sGetDescricao;
end;

procedure TfrmEntradaNF.edtProdutoKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  if Key = vk_F2 then
  begin
    edtProduto.Text := ChamaPesquisa(TEdit(Sender), frmPrincipal.zcoConexaoBanco)[0];
    Perform(WM_NEXTDLGCTL, 0, 0);
  end;
end;

procedure TfrmEntradaNF.edtProdutoKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  KeyPressNumerico(Key);
end;

procedure TfrmEntradaNF.edtFornecedorEnter(Sender: TObject);
begin
  inherited;
  if SQLMemTableEntrada.RecordCount > 0 then
  begin
    if fPergunta('Os dados informados não foram salvos. Deseja realmente cancelar a digitação da entrada?') then
    begin
      InicializaSqlMemTable(SQLMemTableEntrada);
      LimpaCampos(Self, []);

      edtDataEmissao.Date := fDataHoraSrv(frmPrincipal.zcoConexaoBanco);
      edtDataEntrada.Date := edtDataEmissao.Date;

      edtFornecedor.SetFocus;
    end;
  end;
end;

procedure TfrmEntradaNF.BitBtn1Click(Sender: TObject);
begin
  inherited;
  with SQLMemTableEntrada do
  begin
    if Locate('Produto', IntToStr(oProduto.GetiCodigo), []) then
      pMsgAtencao('Produto já inserido. Para edita-lo deverá excluir e inseri-lo novamente.')
    else
    begin
      Append;
      FieldByName('Produto').AsInteger := oProduto.GetiCodigo;
      FieldByName('Quantidade').AsFloat := edtQuantidade.Value;
      FieldByName('ValorUnitario').AsFloat := edtValor.Value;
      FieldByName('Descricao').AsString := oProduto.GetsDescricaoComMarca;
      FieldByName('CodigoPreferencial').AsString := oProduto.GetsReferencia;
      FieldByName('ValorTotal').AsFloat := edtQuantidade.Value * edtValor.Value;
      Post;
    end;
  end;
end;

procedure TfrmEntradaNF.BitBtn2Click(Sender: TObject);
begin
  inherited;
  SQLMemTableEntrada.Delete;
end;

procedure TfrmEntradaNF.btnGravaClick(Sender: TObject);
var
  TotalNF: Real;
begin
  inherited;
  if Trim(EditSerie.Text) = '' then
  begin
    pMsgAtencao('A Serie da NF de Entrada não foi informada.');
    EditSerie.SetFocus;
    Abort;
  end;

  if Trim(EditNumeroNF.Text) = '' then
  begin
    pMsgAtencao('O Número da NF de Entrada não foi informado.');
    EditNumeroNF.SetFocus;
    Abort;
  end;

  if Trim(edtDataEntrada.Text) = '' then
  begin
    pMsgAtencao('A Data da Entrada não foi informada.');
    edtDataEntrada.SetFocus;
    Abort;
  end;

  if Trim(edtDataEmissao.Text) = '' then
  begin
    pMsgAtencao('A Data de Emissão da Entrada não foi informada.');
    edtDataEmissao.SetFocus;
    Abort;
  end;

  with SQLMemQuery do
  begin
    Close;
    SQL.Add('select sum(Quantidade * ValorUnitario) as Total from TableEntradaNF');
    Open;
    TotalNF := FieldByName('Total').AsFloat;
    Close;
  end;

  with oEntrada do
  begin
    CadastraEntrada(StrToInt(edtFornecedor.Text), StrToInt(EditNumeroNF.Text), EditSerie.Text, StrToDate(edtDataEntrada.Text),
      StrToDate(edtDataEmissao.Text), fDataHoraSrv(frmPrincipal.zcoConexaoBanco), TotalNF);

    CadastraItemEntrada(SQLMemTableEntrada);
    pMsgInfo('Entrada salva com sucesso!');
    InicializaSqlMemTable(SQLMemTableEntrada);
    LimpaCampos(Self, []);

    edtDataEmissao.Date := fDataHoraSrv(frmPrincipal.zcoConexaoBanco);
    edtDataEntrada.Date := edtDataEmissao.Date;

    edtFornecedor.SetFocus;
  end;
end;

procedure TfrmEntradaNF.btnInsereClick(Sender: TObject);
begin
  inherited;
  if Trim(edtProduto.Text) = '' then
  begin
    pMsgAtencao('O código do produto não foi informado.');
    edtProduto.SetFocus;
    Abort;
  end;

  if (edtQuantidade.Value <= 0) then
  begin
    pMsgAtencao('A Quantidade do Produto não foi informada.');
    edtQuantidade.SetFocus;
    Abort;
  end;

  if (edtValor.Value <= 0) then
  begin
    pMsgAtencao('O Valor Unitário do Produto não foi informado.');
    edtValor.SetFocus;
    Abort;
  end;

  with SQLMemTableEntrada do
  begin
    if Locate('Produto', IntToStr(oProduto.GetiCodigo), []) then
      pMsgAtencao('Produto já inserido. Para edita-lo deverá excluir e inseri-lo novamente.')
    else
    begin
      Append;
      FieldByName('Produto').AsInteger := oProduto.GetiCodigo;
      FieldByName('Quantidade').AsFloat := edtQuantidade.Value;
      FieldByName('ValorUnitario').AsFloat := edtValor.Value;
      FieldByName('Descricao').AsString := oProduto.GetsDescricaoComMarca;
      FieldByName('CodigoPreferencial').AsString := oProduto.GetsReferencia;
      FieldByName('ValorTotal').AsFloat := edtQuantidade.Value * edtValor.Value;
      Post;
      LimpaCamposProduto;
      edtProduto.SetFocus;
    end;
  end;
end;

procedure TfrmEntradaNF.btnDeletaClick(Sender: TObject);
begin
  inherited;
  SQLMemTableEntrada.Delete;
  edtProduto.SetFocus;
end;

procedure TfrmEntradaNF.BtnSairClick(Sender: TObject);
begin
  if SQLMemTableEntrada.RecordCount > 0 then
  begin
    if fPergunta('Os dados informados não foram salvos. Deseja realmente cancelar a digitação da entrada?') then
    begin
      InicializaSqlMemTable(SQLMemTableEntrada);
      LimpaCampos(Self, []);
    end;
  end;
  inherited;
end;

procedure TfrmEntradaNF.LimpaCamposProduto;
begin
  edtProduto.Text := '';
  stProduto.Text := '';
  edtValor.Value := 0;
  edtQuantidade.Value := 0;
  stUnidade.Text := '';
  edtProduto.SetFocus;
end;

procedure TfrmEntradaNF.edtProdutoEnter(Sender: TObject);
begin
  inherited;
  LimpaCamposProduto;
end;

procedure TfrmEntradaNF.EditSerieExit(Sender: TObject);
begin
  inherited;
  if EditSerie.Text = '' then
    EditSerie.SetFocus;
end;

procedure TfrmEntradaNF.EditNumeroNFExit(Sender: TObject);
begin
  inherited;
  if oEntrada.LocalizaEntrada(StrToInt(edtFornecedor.Text), StrToInt(EditNumeroNF.Text), EditSerie.Text) then
  begin
    pMsgAtencao('Existe nota de entrada cadastrada para este fornecedor com essa série e numeração!');
    EditNumeroNF.SetFocus;
    Abort;
  end;
end;

end.
