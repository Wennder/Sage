unit uTerminalVenda;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uCadastroGenerico, JvExControls,
  JvComponent, JvNavigationPane, JvExStdCtrls, JvEdit,
  JvValidateEdit, StdCtrls, uVenda, ExtCtrls, Grids, uFuncoes, cxGraphics,
  cxLookAndFeels, cxLookAndFeelPainters, Menus, cxButtons, cxControls,
  cxContainer, cxEdit, cxTextEdit, cxLabel, dxSkinsCore, dxSkinOffice2010Silver,
  Data.DB, SQLMemMain, cxStyles, dxSkinscxPCPainter, cxCustomData, cxFilter,
  cxData, cxDataStorage, cxNavigator, cxDBData, cxGridLevel, cxClasses,
  cxGridCustomView, cxGridCustomTableView, cxGridTableView, cxGridDBTableView,
  cxGrid, cxCurrencyEdit, Datasnap.DBClient, dxSkinBlack, dxSkinBlue,
  dxSkinBlueprint, dxSkinCaramel, dxSkinCoffee, dxSkinDarkRoom, dxSkinDarkSide,
  dxSkinDevExpressDarkStyle, dxSkinDevExpressStyle, dxSkinFoggy,
  dxSkinGlassOceans, dxSkinHighContrast, dxSkiniMaginary, dxSkinLilian,
  dxSkinLiquidSky, dxSkinLondonLiquidSky, dxSkinMcSkin, dxSkinMoneyTwins,
  dxSkinOffice2007Black, dxSkinOffice2007Blue, dxSkinOffice2007Green,
  dxSkinOffice2007Pink, dxSkinOffice2007Silver, dxSkinOffice2010Black,
  dxSkinOffice2010Blue, dxSkinPumpkin, dxSkinSeven, dxSkinSevenClassic,
  dxSkinSharp, dxSkinSharpPlus, dxSkinSilver, dxSkinSpringTime, dxSkinStardust,
  dxSkinSummer2008, dxSkinTheAsphaltWorld, dxSkinsDefaultPainters,
  dxSkinValentine, dxSkinVS2010, dxSkinWhiteprint, dxSkinXmas2008Blue;

type
  TfrmTerminalVenda = class(TfrmCadastroGenerico)
    edtValidador: TJvValidateEdit;
    lbTotal: TcxLabel;
    lbDesconto: TcxLabel;
    lbAcrescimo: TcxLabel;
    lbSubTotal: TcxLabel;
    LabelNCM: TcxLabel;
    dsItens: TDataSource;
    grdItens: TcxGrid;
    grdItensDBTableView: TcxGridDBTableView;
    grdItensLevel: TcxGridLevel;
    grdItensDBTableViewCodigo: TcxGridDBColumn;
    grdItensDBTableViewDescricao: TcxGridDBColumn;
    grdItensDBTableViewQuantidade: TcxGridDBColumn;
    grdItensDBTableViewPreco: TcxGridDBColumn;
    grdItensDBTableViewTotal: TcxGridDBColumn;
    cdsItens: TClientDataSet;
    cdsItensCodigo: TStringField;
    cdsItensDescricao: TStringField;
    cdsItensQuantidade: TStringField;
    cdsItensPreco: TStringField;
    cdsItensTotal: TStringField;
    cdsItensTabela: TStringField;
    edtTotal: TcxCurrencyEdit;
    edtDesconto: TcxCurrencyEdit;
    edtAcrescimo: TcxCurrencyEdit;
    edtSubtotal: TcxCurrencyEdit;
    lblPreco: TcxLabel;
    edtPreco: TcxCurrencyEdit;
    lbQuantidade: TcxLabel;
    edtQuantidade: TcxCurrencyEdit;
    lbUnidade: TcxLabel;
    btnInsere: TcxButton;
    btnDeleta: TcxButton;
    edtTabela: TcxTextEdit;
    lblTabela: TcxLabel;
    edtProduto: TcxTextEdit;
    lblProduto: TcxLabel;
    stUnidade: TcxTextEdit;
    stTabela: TcxTextEdit;
    stProduto: TcxTextEdit;
    edtAcrescimoPercentual: TcxCurrencyEdit;
    edtDescontoPercentual: TcxCurrencyEdit;
    procedure edtProdutoExit(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure edtTabelaExit(Sender: TObject);
    procedure edtProdutoKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtTabelaKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtProdutoKeyPress(Sender: TObject; var Key: Char);
    procedure btnInsereClick(Sender: TObject);
    procedure btnDeletaClick(Sender: TObject);
    procedure btnCancelaClick(Sender: TObject);
    procedure btnGravaClick(Sender: TObject);
    procedure edtAcrescimoExit(Sender: TObject);
    procedure edtDescontoExit(Sender: TObject);
    procedure edtAcrescimoPercentualExit(Sender: TObject);
    procedure edtDescontoPercentualExit(Sender: TObject);
    procedure edtProdutoEnter(Sender: TObject);
    procedure grdItensDBTableViewCellClick(Sender: TcxCustomGridTableView;
      ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton;
      AShift: TShiftState; var AHandled: Boolean);
    procedure InsereItemGrid(sProduto, sDescricao, sQuantidade, sPreco, sTotal,
      sTabela: string);
    procedure FormCreate(Sender: TObject);
    function TotalPedido: Real;
  private
    { Private declarations }
    oVenda: TVenda;
    bFecharOrcamento: Boolean;
  public
    iCodigoPedidoEdicao: integer;
    bisEdicaoOrcamento: Boolean;

    { Public declarations }
  end;

var
  frmTerminalVenda: TfrmTerminalVenda;

implementation

{$R *.dfm}

uses uPrincipal, uProduto, uUnidade, uTabelaPrecoItens, uTabelaPreco,
  uUltimasDefinicoesVenda, uDadosConsumidor, uControlaServicoTecnico,
  uControleECF, uRelNotasFiscais, uCondicaoPagamento;

procedure TfrmTerminalVenda.edtProdutoExit(Sender: TObject);
begin
  inherited;
  if (Trim(edtProduto.Text) <> '') and (edtProduto.Text <> '0') then
  begin
    oVenda.oItemVenda.oProduto.bPesquisaProduto(StrToInt(edtProduto.Text));
    stProduto.Text := oVenda.oItemVenda.oProduto.GetsDescricaoComMarca;
    stUnidade.Text := oVenda.oItemVenda.oProduto.oUndSaida.sGetDescricao;
    LabelNCM.Caption := '';
    if not oVenda.oItemVenda.oProduto.GetProdutoTemNCM then
      LabelNCM.Caption := 'Produto sem NCM!'
  end;
end;

procedure TfrmTerminalVenda.FormCreate(Sender: TObject);
begin
  inherited;
  cdsItens.Close;
  cdsItens.CreateDataSet;
  cdsItens.Open;
  cdsItens.EmptyDataSet;
  bisEdicaoOrcamento := False;
  iCodigoPedidoEdicao := 0;
end;

procedure TfrmTerminalVenda.FormShow(Sender: TObject);
begin
  inherited;
  oVenda := TVenda.Create(frmPrincipal.zcoConexaoBanco);
end;

procedure TfrmTerminalVenda.grdItensDBTableViewCellClick
  (Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo;
  AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
begin
  inherited;
  with cdsItens do
  begin
    edtProduto.Text := FieldByName('Codigo').Value;
    edtProdutoExit(Sender);
    edtTabela.Text := FieldByName('Tabela').Value;
    edtTabelaExit(Sender);
    edtPreco.Text := FieldByName('Preco').Value;
    edtQuantidade.Text := FieldByName('Quantidade').Value;
  end;
end;

procedure TfrmTerminalVenda.edtTabelaExit(Sender: TObject);
begin
  inherited;
  if (Trim(edtTabela.Text) <> '') and (edtTabela.Text <> '0') then
  begin
    stTabela.Text := '';
    edtPreco.Value := 0;
    if not oVenda.oItemVenda.oTabelaPrecoItem.bPesquisaTabelaPrecoItens
      (StrToInt(edtTabela.Text), StrToInt(edtProduto.Text)) then
    begin
      if Application.MessageBox('Tabela de preço não encontrada!'#13 +
        'Deseja prosseguir?', 'Confirmação', MB_YESNO + MB_ICONINFORMATION) = IDNO
      then
      begin;
        edtTabela.SetFocus;
        Exit;
      end;
    end;
    stTabela.Text := oVenda.oItemVenda.oTabelaPrecoItem.oTabelaPreco.
      sGetDescricao;
    edtPreco.Value := oVenda.oItemVenda.oTabelaPrecoItem.nGetPreco;
  end;
end;

procedure TfrmTerminalVenda.edtProdutoKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  if Key = vk_F2 then
  begin
    edtProduto.Text := ChamaPesquisa(TEdit(Sender),
      frmPrincipal.zcoConexaoBanco)[0];
    Perform(WM_NEXTDLGCTL, 0, 0);
  end;
end;

procedure TfrmTerminalVenda.edtTabelaKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  if Key = vk_F2 then
  begin
    edtTabela.Text := ChamaPesquisa(TEdit(Sender),
      frmPrincipal.zcoConexaoBanco)[0];
    Perform(WM_NEXTDLGCTL, 0, 0);
  end;
end;

procedure TfrmTerminalVenda.edtProdutoKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  KeyPressNumerico(Key);
end;

procedure TfrmTerminalVenda.btnInsereClick(Sender: TObject);
begin
  inherited;
  if (edtProduto.Text = '') or (edtTabela.Text = '') then
    Exit;
  if (edtPreco.Value = 0) then
  begin
    edtPreco.SetFocus;
    Exit;
  end;
  if (edtQuantidade.Value = 0) then
  begin
    edtQuantidade.SetFocus;
    Exit;
  end;

  InsereItemGrid(edtProduto.Text, stProduto.Text,
    FormatFloat('#,##0.00', edtQuantidade.Value),
    FormatCurr('#,##0.00', edtPreco.Value), FormatCurr('#,##0.00',
    edtQuantidade.Value * edtPreco.Value), edtTabela.Text);

  LimpaCampos(Self, [grdItens, edtTotal]);

  edtSubtotal.Value := TotalPedido;
  edtTotal.Value := TotalPedido;

  edtProduto.SetFocus;
end;

procedure TfrmTerminalVenda.InsereItemGrid(sProduto, sDescricao, sQuantidade,
  sPreco, sTotal, sTabela: string);
begin
  with cdsItens do
  begin
    if Locate('Codigo;Tabela', VarArrayOf([sProduto, sTabela]), []) then
    begin
      Edit;
      FieldByName('Codigo').Value := sProduto;
      FieldByName('Descricao').Value := sDescricao;
      FieldByName('Quantidade').Value := sQuantidade;
      FieldByName('Preco').Value := sPreco;
      FieldByName('Total').Value := sTotal;
      FieldByName('Tabela').Value := sTabela;
      Post;
    end
    else
    begin
      Insert;
      FieldByName('Codigo').Value := sProduto;
      FieldByName('Descricao').Value := sDescricao;
      FieldByName('Quantidade').Value := sQuantidade;
      FieldByName('Preco').Value := sPreco;
      FieldByName('Total').Value := sTotal;
      FieldByName('Tabela').Value := sTabela;
      Post;
    end;
  end;
end;

procedure TfrmTerminalVenda.btnDeletaClick(Sender: TObject);
begin
  inherited;
  cdsItens.Delete;
  edtProduto.SetFocus;
  edtSubtotal.Value := TotalPedido;
  edtTotal.Value := TotalPedido;
end;

procedure TfrmTerminalVenda.btnCancelaClick(Sender: TObject);
begin
  inherited;
  cdsItens.EmptyDataSet;
  LimpaCampos(Self, []);
  edtProduto.SetFocus;
  FreeAndNil(oVenda);
  oVenda := TVenda.Create(frmPrincipal.zcoConexaoBanco);
end;

procedure TfrmTerminalVenda.btnGravaClick(Sender: TObject);
var
  iCont: integer;
  nQtd, nValor, nAjuste, nAjustePercentual: Real;
  isPedido, isCupom, isOrcamento: Boolean;
  sCliente: string;
begin
  inherited;
  if cdsItens.IsEmpty then
  begin
    Application.MessageBox('Pedido/Orçamento sem itens cadastrados.', 'Aviso',
      MB_OK + MB_ICONINFORMATION);
    edtProduto.SetFocus;
    Abort;
  end;

  if not Assigned(frmUltimasDefinicoes) then
    frmUltimasDefinicoes := TfrmUltimasDefinicoes.Create(nil);

  if frmUltimasDefinicoes.ShowModal = mrOK then
  begin
    with frmUltimasDefinicoes do
    begin
      if (edtCliente.Text = '') or (edtCliente.Text = '0') then
      begin
        edtCliente.Text := '0';
        if Application.MessageBox('Deseja informar os dados do consumidor?',
          'Confirmação', MB_YESNO + MB_ICONQUESTION) = IDYES then
        begin
          frmDadosConsumidor := TfrmDadosConsumidor.Create(Self);
          frmDadosConsumidor.ShowModal;
        end;
      end;
      if edtDesconto.Value > 0 then
      begin
        nAjuste := edtDesconto.Value * -1;
        nAjustePercentual := edtDescontoPercentual.EditValue * -1;
      end
      else
      begin
        nAjuste := edtAcrescimo.Value;
        nAjustePercentual := edtAcrescimoPercentual.EditValue;
      end;

      isPedido := ComboBoxOperacao.ItemIndex = 1;
      isCupom := ComboBoxOperacao.ItemIndex = 2;
      isOrcamento := ComboBoxOperacao.ItemIndex = 0;

      if isOrcamento then
        bFecharOrcamento := Application.MessageBox
          ('Deseja fechar este orçamento?' + #13 +
          '(Ao fechar o orçamento, o mesmo não poderá ser editado e será gerada a movimentação de estoque.)',
          'Confirmação', MB_YESNO + MB_ICONQUESTION) = IDYES;

      if (isPedido) or (isOrcamento and bFecharOrcamento) then
      begin
        frmFormaRecebimento := TfrmFormaRecebimento.Create(nil);
        if frmFormaRecebimento.ShowModal <> mrOK then
          Abort;
      end;

      oVenda.InsereEditaPedido(StrToInt(edtNaturezaOperacao.Text),
        StrToInt(edtCFOP.Text), StrToInt(edtCliente.Text),
        StrToInt(edtVendedor.Text), edtSubtotal.Value, nAjuste,
        nAjustePercentual, edtKM.Value, EdtObservacao.Lines.Text,
        edtVeiculo.Text, edtPlaca.Text, isPedido, isCupom, isOrcamento,
        bFecharOrcamento, bisEdicaoOrcamento, iCodigoPedidoEdicao);
      sCliente := stCliente.Text;
    end;
    if frmDadosConsumidor <> nil then
    begin
      with frmDadosConsumidor do
      begin
        if edtNome.Text <> '' then
        begin
          if edtCidade.Text = '' then
            edtCidade.Text := '0';
          oVenda.InsereConsumidor(edtNome.Text, edtEndereco.Text,
            edtBairro.Text, edtCep.Text, edtFone.Text,
            StrToInt(edtCidade.Text));
          sCliente := edtNome.Text;
        end;
      end;
    end;

    with cdsItens do
    begin
      First;
      while not Eof do
      begin
        edtValidador.Text := FieldByName('Quantidade').Value;
        nQtd := edtValidador.Value;
        edtValidador.Text := FieldByName('Preco').Value;
        nValor := edtValidador.Value;
        oVenda.InsereItem(StrToInt(FieldByName('Codigo').Value), nQtd, nValor);
        Next;
      end;
    end;
    if (isPedido) or (isOrcamento and bFecharOrcamento) then
    begin
      if frmFormaRecebimento.ComboBoxFormaRecebimento.ItemIndex >= 0 then
        oVenda.GravaFormaRecebimento(oVenda.oPedido.iGetCodigo,
          frmFormaRecebimento.ComboBoxFormaRecebimento.ItemIndex,
          frmFormaRecebimento.ComboBoxBandeira.ItemIndex);
    end;

    if isCupom then
    begin
      if Application.MessageBox('Deseja emitir cupom?', 'Confirmação',
        MB_YESNO + MB_ICONQUESTION) = IDYES then
        oVenda.ImprimeCupomFiscal;
    end;

    if (isPedido) or (isOrcamento and bFecharOrcamento) then
    begin
      if Application.MessageBox('Confirma a impressão?', 'Confirmação',
        MB_YESNO + MB_ICONQUESTION) = IDYES then
      begin
        frmNotaFiscal := TfrmNotaFiscal.Create(nil);
        frmNotaFiscal.edtPedido.Text := IntToStr(oVenda.oPedido.iGetCodigo);
        frmNotaFiscal.edtPedidoExit(frmNotaFiscal.edtPedido);
        frmNotaFiscal.ShowModal;
        FreeAndNil(frmNotaFiscal);
      end;
      if oVenda.VendaTemServico(oVenda.oPedido.iGetCodigo) then
      begin
        frmControlaServicoTecnico := TfrmControlaServicoTecnico.Create(Self);
        frmControlaServicoTecnico.iPedido := oVenda.oPedido.iGetCodigo;
        frmControlaServicoTecnico.sCliente := sCliente;
        frmControlaServicoTecnico.ShowModal;
        FreeAndNil(frmControlaServicoTecnico);
      end;
    end;
    cdsItens.EmptyDataSet;
    LimpaCampos(Self, []);

    FreeAndNil(frmUltimasDefinicoes);
    FreeAndNil(frmFormaRecebimento);
    FreeAndNil(frmDadosConsumidor);
    FreeAndNil(oVenda);

    edtProduto.SetFocus;
    oVenda := TVenda.Create(frmPrincipal.zcoConexaoBanco);
  end;
end;

function TfrmTerminalVenda.TotalPedido: Real;
var
  iCont: integer;
begin
  Result := 0;
  with cdsItens do
  begin
    First;
    while not Eof do
    begin
      edtValidador.Text := FieldByName('Total').Value;
      Result := Result + edtValidador.Value;
      Next;
    end;
  end;
end;

procedure TfrmTerminalVenda.edtAcrescimoExit(Sender: TObject);
begin
  inherited;
  if (edtDesconto.Value = 0) and (edtAcrescimo.Value = 0) then
    edtTotal.Value := edtSubtotal.Value;
  if edtAcrescimo.Value > 0 then
  begin
    edtDesconto.Value := 0;
    edtDescontoPercentual.EditValue := 0;
    edtAcrescimoPercentual.EditValue := (edtAcrescimo.Value * 100) /
      edtSubtotal.Value;
    edtTotal.Value := edtSubtotal.Value + edtAcrescimo.Value;
  end;
end;

procedure TfrmTerminalVenda.edtDescontoExit(Sender: TObject);
begin
  inherited;
  if (edtDesconto.Value = 0) and (edtAcrescimo.Value = 0) then
    edtTotal.Value := edtSubtotal.Value;
  if edtDesconto.Value > 0 then
  begin
    edtAcrescimo.Value := 0;
    edtAcrescimoPercentual.EditValue := 0;
    if edtDesconto.Value >= edtSubtotal.Value then
    begin
      Application.MessageBox('Desconto maior ou igual ao Subtotal!', 'Erro',
        MB_OK + MB_ICONERROR);
      edtDesconto.Value := 0;
      edtDescontoPercentual.EditValue := 0;
      edtDesconto.SetFocus;
      Exit;
    end;
    edtDescontoPercentual.EditValue := (edtDesconto.Value * 100) /
      edtSubtotal.Value;
    edtTotal.Value := edtSubtotal.Value - (edtDesconto.Value)
  end;
end;

procedure TfrmTerminalVenda.edtAcrescimoPercentualExit(Sender: TObject);
begin
  inherited;
  edtAcrescimo.Value := ((edtAcrescimoPercentual.EditValue / 100) *
    edtSubtotal.Value);
  edtAcrescimoExit(edtAcrescimo);
end;

procedure TfrmTerminalVenda.edtDescontoPercentualExit(Sender: TObject);
begin
  inherited;
  edtDesconto.Value := ((edtDescontoPercentual.EditValue / 100) *
    edtSubtotal.Value);
  edtDescontoExit(edtDesconto);
end;

procedure TfrmTerminalVenda.edtProdutoEnter(Sender: TObject);
begin
  inherited;
  LabelNCM.Caption := '';
end;

end.
