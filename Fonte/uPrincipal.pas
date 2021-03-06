unit uPrincipal;

interface

uses
  Forms, SysUtils, uControleAcesso,
  Dialogs, Menus, ZConnection, DB, ZAbstractRODataset, ZAbstractDataset,
  ZDataset, uProcedimentosBanco, Classes, Controls, StdCtrls, uCadastroGenerico,
  JvExControls, JvComponent, JvNavigationPane, uControleECF,
  ComCtrls, dxGDIPlusClasses, ExtCtrls, cxGraphics, cxLookAndFeels,
  cxLookAndFeelPainters, cxButtons, dxSkinsCore, dxSkinOffice2010Silver,
  dxSkinsForm, cxControls, dxSkinsdxStatusBarPainter, dxStatusBar,
  dxRibbonStatusBar, JvMenus, PlatformDefaultStyleActnCtrls, ActnList, ActnMan,
  verslab, System.Actions, dxSkinSeven, Data.Win.ADODB, ppComm, ppRelatv, ppDB,
  ppDBPipe, uEmpresa,
  dxSkinBlack, dxSkinBlue, dxSkinBlueprint, dxSkinCaramel, dxSkinCoffee,
  dxSkinDarkRoom, dxSkinDarkSide, dxSkinDevExpressDarkStyle,
  dxSkinDevExpressStyle, dxSkinFoggy, dxSkinGlassOceans, dxSkinHighContrast,
  dxSkiniMaginary, dxSkinLilian, dxSkinLiquidSky, dxSkinLondonLiquidSky,
  dxSkinMcSkin, dxSkinMoneyTwins, dxSkinOffice2007Black, dxSkinOffice2007Blue,
  dxSkinOffice2007Green, dxSkinOffice2007Pink, dxSkinOffice2007Silver,
  dxSkinOffice2010Black, dxSkinOffice2010Blue, dxSkinPumpkin,
  dxSkinSevenClassic, dxSkinSharp, dxSkinSharpPlus, dxSkinSilver,
  dxSkinSpringTime, dxSkinStardust, dxSkinSummer2008, dxSkinTheAsphaltWorld,
  dxSkinsDefaultPainters, dxSkinValentine, dxSkinVS2010, dxSkinWhiteprint,
  dxSkinXmas2008Blue, Vcl.FileCtrl, ZAbstractConnection;

type
  TfrmPrincipal = class(TForm)
    imgFundo: TImage;
    pnlprincipal: TPanel;
    btnFatura: TcxButton;
    btnProdutos: TcxButton;
    dxSkinController1: TdxSkinController;
    btnPessoas: TcxButton;
    btnTermVendas: TcxButton;
    pmProdutos: TPopupMenu;
    pmPessoas: TPopupMenu;
    btnConsultaNFE: TcxButton;
    stBar: TdxRibbonStatusBar;
    mmPrincipal: TMainMenu;
    MenuCadastro: TMenuItem;
    MenuItemProdutos: TMenuItem;
    uCadastroCor: TMenuItem;
    uCadastroGrupo: TMenuItem;
    uCadastroSubGrupo: TMenuItem;
    uCadastroMarca: TMenuItem;
    uCadastroProduto: TMenuItem;
    uCadastroUnidade: TMenuItem;
    uCadastroNCM: TMenuItem;
    Pessoas1: TMenuItem;
    uCadastroComissionado: TMenuItem;
    uCadastroCliente: TMenuItem;
    uCadastroRamoAtividade: TMenuItem;
    uCadastroAnaliseCredito: TMenuItem;
    Preos1: TMenuItem;
    uCadastroTabelaPreco: TMenuItem;
    uCadastroTabelaPrecoItens: TMenuItem;
    uCadastroCidade: TMenuItem;
    Vendas1: TMenuItem;
    uCadastroNaturezaOperacao: TMenuItem;
    uCadastroCodigoFiscal: TMenuItem;
    uCadastroPlacas: TMenuItem;
    ControledeUsurios1: TMenuItem;
    uCadastroGrupoUsuario: TMenuItem;
    uCadastroUsuario: TMenuItem;
    uCadastroControleAcesso: TMenuItem;
    uCadastroConta: TMenuItem;
    uCadastroClienteFornecedor: TMenuItem;
    uEntradaNF: TMenuItem;
    Consultas1: TMenuItem;
    uPesqComissaoPeriodo: TMenuItem;
    uConsultaNFe: TMenuItem;
    Relatorios: TMenuItem;
    uRelProdutosCadastrados: TMenuItem;
    Vendas3: TMenuItem;
    uRelNotasFiscais: TMenuItem;
    uRelPedidosEmitidos: TMenuItem;
    uRelListagemPrecos: TMenuItem;
    uRelVendasProdutosPeriodo: TMenuItem;
    uRelComissaoPeriodo: TMenuItem;
    Estoque2: TMenuItem;
    uRelEntradaPeriodo: TMenuItem;
    uRelEntradaProdutoPeriodo: TMenuItem;
    RotinasOperacionais1: TMenuItem;
    Vendas2: TMenuItem;
    uTerminalVenda: TMenuItem;
    uCancelaCupomFiscal: TMenuItem;
    uCancelaNotaFiscal: TMenuItem;
    uInutilizaNumeroNF: TMenuItem;
    uFaturaPedido: TMenuItem;
    mnEstoque: TMenuItem;
    Gerenciador1: TMenuItem;
    Estoque1: TMenuItem;
    ContasaReceber1: TMenuItem;
    uCadastroCor1: TMenuItem;
    uCadastroGrupo1: TMenuItem;
    uCadastroSubGrupo1: TMenuItem;
    uCadastroMarca1: TMenuItem;
    uCadastroUnidade1: TMenuItem;
    uCadastroProduto1: TMenuItem;
    uCadastroNCM1: TMenuItem;
    ActionManager1: TActionManager;
    uCadastroComissionado1: TMenuItem;
    uCadastroCliente1: TMenuItem;
    uCadastroRamoAtividade1: TMenuItem;
    uCadastroAnaliseCredito1: TMenuItem;
    lbVersao: TVersionLabel;
    uControleOrcamentos: TMenuItem;
    Utilitrios1: TMenuItem;
    BackupBancodeDados1: TMenuItem;
    btnOrcamento: TcxButton;
    EditarOramento1: TMenuItem;
    CancelaOramento1: TMenuItem;
    Cancelamentos1: TMenuItem;
    Oramentos1: TMenuItem;
    uEntradaNFCancela: TMenuItem;
    uEntradaNF1: TMenuItem;
    uEntradaNFCancela1: TMenuItem;
    conexaodesenv: TZConnection;
    uInventarioProduto: TMenuItem;
    uRelContagemInventario: TMenuItem;
    uDevolucaoVenda: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure uCadastroMarcaClick(Sender: TObject);
    procedure uCadastroCorClick(Sender: TObject);
    procedure uCadastroGrupoClick(Sender: TObject);
    procedure uCadastroUnidadeClick(Sender: TObject);
    procedure uCadastroComissionadoClick(Sender: TObject);
    procedure uCadastroClienteClick(Sender: TObject);
    procedure uCadastroProdutoClick(Sender: TObject);
    procedure uCadastroCidadeClick(Sender: TObject);
    procedure uCadastroSubGrupoClick(Sender: TObject);
    procedure uCadastroRamoAtividadeClick(Sender: TObject);
    procedure uCadastroAnaliseCreditoClick(Sender: TObject);
    procedure uCadastroTabelaPrecoClick(Sender: TObject);
    procedure uCadastroTabelaPrecoItensClick(Sender: TObject);
    procedure uCadastroNaturezaOperacaoClick(Sender: TObject);
    procedure uCadastroCodigoFiscalClick(Sender: TObject);
    procedure uTerminalVendaClick(Sender: TObject);
    procedure uRelNotasFiscaisClick(Sender: TObject);
    procedure uRelPedidosEmitidosClick(Sender: TObject);
    procedure uRelListagemPrecosClick(Sender: TObject);
    procedure uCadastroPlacasClick(Sender: TObject);
    procedure uCancelaCupomFiscalClick(Sender: TObject);
    procedure uCadastroUsuarioClick(Sender: TObject);
    procedure uCadastroGrupoUsuarioClick(Sender: TObject);
    procedure uCadastroControleAcessoClick(Sender: TObject);
    procedure uPesqComissaoPeriodoClick(Sender: TObject);
    procedure uRelComissaoPeriodoClick(Sender: TObject);
    procedure uCadastroContaClick(Sender: TObject);
    procedure uCadastroNCMClick(Sender: TObject);
    procedure uCancelaNotaFiscalClick(Sender: TObject);
    procedure uInutilizaNumeroNFClick(Sender: TObject);
    procedure uFaturaPedidoClick(Sender: TObject);
    procedure uConsultaNFeClick(Sender: TObject);
    procedure uRelVendasProdutosPeriodoClick(Sender: TObject);
    procedure uCadastroClienteFornecedorClick(Sender: TObject);
    procedure uEntradaNFClick(Sender: TObject);
    procedure uRelEntradaPeriodoClick(Sender: TObject);
    procedure uRelProdutosCadastradosClick(Sender: TObject);
    procedure uRelEntradaProdutoPeriodoClick(Sender: TObject);
    procedure btnProdutosClick(Sender: TObject);
    procedure btnPessoasClick(Sender: TObject);
    procedure pTextoSplash(S: string);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    function fGetParams(pNMParametro: string): Variant;
    function fSetParams(pNMParametro, pValor: string): Boolean;
    procedure uControleOrcamentosClick(Sender: TObject);
    procedure BackupBancodeDados1Click(Sender: TObject);
    procedure EditarOramento1Click(Sender: TObject);
    procedure CancelaOramento1Click(Sender: TObject);
    procedure uEntradaNFCancelaClick(Sender: TObject);
    procedure uInventarioProdutoClick(Sender: TObject);
    procedure uRelContagemInventarioClick(Sender: TObject);
    procedure uDevolucaoVendaClick(Sender: TObject);
  private
    { Private declarations }
  public
    oGrupoAcesso: TRotina;
    zcoConexaoBanco: TZConnection;
    function fCarregaMenus(): Boolean;
    procedure pConfiguraMenuAcessoUsuario(pGrupoUsuario: Integer);
  end;

var
  frmPrincipal: TfrmPrincipal;
  vIdUsuario, vIdGrupo: Integer;

implementation

uses UsoGeral,
  uSplash, uTraducaoDevExpress, uCadastroMarca, uCadastroCor, uCadastroGrupo,
  uCadastroUnidade, uCadastroComissionado, uCadastroCliente,
  uCadastroProduto, uCadastroSubGrupo, uCadastroCidade, uCadastroRamoAtividade,
  uCadastroAnaliseCredito, uCadastroTabelaPreco,
  uCadastroTabelaPrecoItens, uCadastroNaturezaOperacao, uCadastroCodigoFiscal,
  uTerminalVenda, uRB, uRelNotasFiscais, uRelPedidosEmitidos,
  uControlaServicoTecnico, uRelListagemPrecos, uCadastroPlacas,
  uCadastroUsuario, uCadastroGrupoUsuario, uCadastroControleAcesso,
  uPesqComissaoPeriodo, uRelComissao, uCadastroConta, uCadastroNCM,
  uCancelaNotaFiscal, uInutilizaNumeroNF, uFaturaPedido, uConsultaStattus,
  uCancelaCupomFiscal, uRelVendasProdutosPeriodo, uEntradaNF,
  uRelEntradaPeriodo, uRelProdutosCadastrados, uRelEntradaProdutoPeriodo,
  uControleOrcamentos, uUltConfBackup, uEntradaNFCancela, uInventarioProduto,
  uRelContagemInventario, uDevolucaoVenda;

{$R *.dfm}

procedure TfrmPrincipal.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  FreeAndNil(zcoConexaoBanco);
  Application.Terminate;
end;

procedure TfrmPrincipal.FormCreate(Sender: TObject);
begin
  TtraducaoDevExpress.Translate_PTBR;
  pTextoSplash('Aguarde, localizando banco de dados...');
  pTextoSplash('Conectando ao banco de dados...');
  CarregaConexaoBanco(zcoConexaoBanco);
  pTextoSplash('Verificando a vers�o do aplicativo...');

  if LowerCase(ParamStr(1)) = '/menus' then
  begin
    if fCarregaMenus then
    begin
      pMsgInfo('Os menus do sistema foram recarregados com sucesso!' + #13 +
        'Por favor, abra a aplica��o novamente retirando o par�metro "/menus" do atalho.');
      Application.Terminate;
    end
  end;

  if Assigned(zcoConexaoBanco) then
  begin
    try
      zcoConexaoBanco.Connect;
    except
      pMsgAtencao('N�o foi poss�vel conectar � base! Verifique as configura��es ' + #13 +
        'de conex�o e tente reinicializar o servidor de banco de dados');
      FreeAndNil(zcoConexaoBanco);
      Application.Terminate;
    end;
  end
  else
  begin
    pMsgAtencao('N�o foi poss�vel conectar � base! Verifique as configura��es ' + #13 +
      'de conex�o e tente reinicializar o servidor de banco de dados');
    FreeAndNil(zcoConexaoBanco);
    Application.Terminate;
  end;
  oEmpresaPrincipal := TEmpresa.Create(frmPrincipal.zcoConexaoBanco);
end;

procedure TfrmPrincipal.FormShow(Sender: TObject);
begin
  Self.Caption := 'SAGE - Sistema de Automa��o e Gerenciamento de Empresas [Vers�o: ' + lbVersao.InfoString + ']';
end;

procedure TfrmPrincipal.uCadastroMarcaClick(Sender: TObject);
begin
  frmCadastroMarca := TfrmCadastroMarca.Create(nil);
  frmCadastroMarca.ShowModal;
  FreeAndNil(frmCadastroMarca);
end;

procedure TfrmPrincipal.uCadastroCorClick(Sender: TObject);
begin
  frmCadastroCor := TfrmCadastroCor.Create(nil);
  frmCadastroCor.ShowModal;
  FreeAndNil(frmCadastroCor);
end;

procedure TfrmPrincipal.uCadastroGrupoClick(Sender: TObject);
begin
  frmCadastroGrupo := TfrmCadastroGrupo.Create(nil);
  frmCadastroGrupo.ShowModal;
  FreeAndNil(frmCadastroGrupo);
end;

procedure TfrmPrincipal.uCadastroUnidadeClick(Sender: TObject);
begin
  frmCadastroUnidade := TfrmCadastroUnidade.Create(nil);
  frmCadastroUnidade.ShowModal;
  FreeAndNil(frmCadastroUnidade);
end;

procedure TfrmPrincipal.uCadastroComissionadoClick(Sender: TObject);
begin
  frmCadastroComissionado := TfrmCadastroComissionado.Create(nil);
  frmCadastroComissionado.ShowModal;
  FreeAndNil(frmCadastroComissionado);
end;

procedure TfrmPrincipal.uCadastroClienteClick(Sender: TObject);
begin
  frmCadastroCliente := TfrmCadastroCliente.Create(nil);
  frmCadastroCliente.bCadastroFornecedor := False;
  frmCadastroCliente.ShowModal;
  FreeAndNil(frmCadastroCliente);
end;

procedure TfrmPrincipal.uCadastroProdutoClick(Sender: TObject);
begin
  frmCadastroProduto := TfrmCadastroProduto.Create(nil);
  frmCadastroProduto.ShowModal;
  FreeAndNil(frmCadastroProduto);
end;

procedure TfrmPrincipal.uCadastroCidadeClick(Sender: TObject);
begin
  frmCadastroCidade := TfrmCadastroCidade.Create(nil);
  frmCadastroCidade.ShowModal;
  FreeAndNil(frmCadastroCidade);
end;

procedure TfrmPrincipal.uCadastroSubGrupoClick(Sender: TObject);
begin
  frmCadastroSubGrupo := TfrmCadastroSubGrupo.Create(nil);
  frmCadastroSubGrupo.ShowModal;
  FreeAndNil(frmCadastroSubGrupo);
end;

procedure TfrmPrincipal.uCadastroRamoAtividadeClick(Sender: TObject);
begin
  frmCadastroRamoAtividade := TfrmCadastroRamoAtividade.Create(nil);
  frmCadastroRamoAtividade.ShowModal;
  FreeAndNil(frmCadastroRamoAtividade);
end;

procedure TfrmPrincipal.uCadastroAnaliseCreditoClick(Sender: TObject);
begin
  frmCadastroAnaliseCredito := TfrmCadastroAnaliseCredito.Create(nil);
  frmCadastroAnaliseCredito.ShowModal;
  FreeAndNil(frmCadastroAnaliseCredito);
end;

procedure TfrmPrincipal.BackupBancodeDados1Click(Sender: TObject);
begin
  frmUltConfBackup := TfrmUltConfBackup.Create(nil);
  frmUltConfBackup.ShowModal;
  FreeAndNil(frmUltConfBackup);
end;

procedure TfrmPrincipal.btnPessoasClick(Sender: TObject);
begin
  pmPessoas.Popup(btnPessoas.Left + 2, btnPessoas.Top + pnlprincipal.Height + 35);
end;

procedure TfrmPrincipal.btnProdutosClick(Sender: TObject);
begin
  pmProdutos.Popup(btnProdutos.Left + 2, btnProdutos.Top + pnlprincipal.Height + 35);
end;

procedure TfrmPrincipal.CancelaOramento1Click(Sender: TObject);
begin
  frmControleOrcamentos := TfrmControleOrcamentos.Create(Self);
  frmControleOrcamentos.TipoOperacaoControleOrcamento := TTpOprCtrlOrcmntCancelaOrcamento;
  frmControleOrcamentos.ShowModal;
  FreeAndNil(frmControleOrcamentos);
end;

procedure TfrmPrincipal.EditarOramento1Click(Sender: TObject);
begin
  frmControleOrcamentos := TfrmControleOrcamentos.Create(Self);
  frmControleOrcamentos.TipoOperacaoControleOrcamento := TTpOprCtrlOrcmntEdicaoOrcamento;
  frmControleOrcamentos.ShowModal;
  FreeAndNil(frmControleOrcamentos);
end;

procedure TfrmPrincipal.uInventarioProdutoClick(Sender: TObject);
begin
  frmInventarioProduto := TfrmInventarioProduto.Create(nil);
  frmInventarioProduto.ShowModal;
  FreeAndNil(frmInventarioProduto);
end;

procedure TfrmPrincipal.uCadastroTabelaPrecoClick(Sender: TObject);
begin
  frmCadastroTabelaPreco := TfrmCadastroTabelaPreco.Create(nil);
  frmCadastroTabelaPreco.ShowModal;
  FreeAndNil(frmCadastroTabelaPreco);
end;

procedure TfrmPrincipal.uCadastroTabelaPrecoItensClick(Sender: TObject);
begin
  frmCadastroTabelaPrecoItens := TfrmCadastroTabelaPrecoItens.Create(nil);
  frmCadastroTabelaPrecoItens.ShowModal;
  FreeAndNil(frmCadastroTabelaPrecoItens);
end;

procedure TfrmPrincipal.uCadastroNaturezaOperacaoClick(Sender: TObject);
begin
  frmCadastroNaturezaOperacao := TfrmCadastroNaturezaOperacao.Create(nil);
  frmCadastroNaturezaOperacao.ShowModal;
  FreeAndNil(frmCadastroNaturezaOperacao);
end;

procedure TfrmPrincipal.uCadastroCodigoFiscalClick(Sender: TObject);
begin
  frmCadastroCodigoFiscal := TfrmCadastroCodigoFiscal.Create(nil);
  frmCadastroCodigoFiscal.ShowModal;
  FreeAndNil(frmCadastroCodigoFiscal);
end;

procedure TfrmPrincipal.uTerminalVendaClick(Sender: TObject);
begin
  frmTerminalVenda := TfrmTerminalVenda.Create(nil);
  frmTerminalVenda.ShowModal;
  FreeAndNil(frmTerminalVenda);
end;

procedure TfrmPrincipal.uRelNotasFiscaisClick(Sender: TObject);
begin
  frmNotaFiscal := TfrmNotaFiscal.Create(nil);
  frmNotaFiscal.ShowModal;
  FreeAndNil(frmNotaFiscal);
end;

procedure TfrmPrincipal.uRelPedidosEmitidosClick(Sender: TObject);
begin
  frmPedidosEmitidos := TfrmPedidosEmitidos.Create(nil);
  frmPedidosEmitidos.ShowModal;
  FreeAndNil(frmPedidosEmitidos);
end;

procedure TfrmPrincipal.uRelListagemPrecosClick(Sender: TObject);
begin
  frmListagemPrecos := TfrmListagemPrecos.Create(Self);
  frmListagemPrecos.ShowModal;
  FreeAndNil(frmListagemPrecos);
end;

procedure TfrmPrincipal.uCadastroPlacasClick(Sender: TObject);
begin
  frmPlacas := TfrmPlacas.Create(Self);
  frmPlacas.ShowModal;
  FreeAndNil(frmPlacas);
end;

procedure TfrmPrincipal.uCancelaCupomFiscalClick(Sender: TObject);
begin
  frmCancelaCupomFiscal := TfrmCancelaCupomFiscal.Create(Self);
  frmCancelaCupomFiscal.ShowModal;
  FreeAndNil(frmCancelaCupomFiscal);
end;

procedure TfrmPrincipal.uCadastroUsuarioClick(Sender: TObject);
begin
  frmCadastroUsuarios := TfrmCadastroUsuarios.Create(Self);
  frmCadastroUsuarios.ShowModal;
  FreeAndNil(frmCadastroUsuarios);
end;

procedure TfrmPrincipal.uCadastroGrupoUsuarioClick(Sender: TObject);
begin
  frmCadastroGrupoUsuario := TfrmCadastroGrupoUsuario.Create(Self);
  frmCadastroGrupoUsuario.ShowModal;
  FreeAndNil(frmCadastroGrupoUsuario);
end;

procedure TfrmPrincipal.uCadastroControleAcessoClick(Sender: TObject);
begin
  frmCadastroControleAcesso := TfrmCadastroControleAcesso.Create(Self);
  frmCadastroControleAcesso.ShowModal;
  FreeAndNil(frmCadastroControleAcesso);
  if vIdUsuario > 0 then
    pConfiguraMenuAcessoUsuario(vIdGrupo);
end;

procedure TfrmPrincipal.uPesqComissaoPeriodoClick(Sender: TObject);
begin
  frmPesqComissaoPeriodo := TfrmPesqComissaoPeriodo.Create(Self);
  frmPesqComissaoPeriodo.ShowModal;
  FreeAndNil(frmPesqComissaoPeriodo);
end;

procedure TfrmPrincipal.uRelComissaoPeriodoClick(Sender: TObject);
begin
  frmRelComissaoPeriodo := TfrmRelComissaoPeriodo.Create(Self);
  frmRelComissaoPeriodo.ShowModal;
  FreeAndNil(frmRelComissaoPeriodo);
end;

procedure TfrmPrincipal.uRelContagemInventarioClick(Sender: TObject);
begin
  frmRelContagemInventario := TfrmRelContagemInventario.Create(Self);
  frmRelContagemInventario.ShowModal;
  FreeAndNil(frmRelContagemInventario);
end;

procedure TfrmPrincipal.uCadastroContaClick(Sender: TObject);
begin
  frmCadastroConta := TfrmCadastroConta.Create(Self);
  frmCadastroConta.ShowModal;
  FreeAndNil(frmCadastroConta);
end;

procedure TfrmPrincipal.uCadastroNCMClick(Sender: TObject);
begin
  frmCadastroNCM := TfrmCadastroNCM.Create(Self);
  frmCadastroNCM.ShowModal;
  FreeAndNil(frmCadastroNCM);
end;

procedure TfrmPrincipal.uCancelaNotaFiscalClick(Sender: TObject);
begin
  frmCancelaNotaFiscal := TfrmCancelaNotaFiscal.Create(Self);
  frmCancelaNotaFiscal.ShowModal;
  FreeAndNil(frmCancelaNotaFiscal);
end;

procedure TfrmPrincipal.uInutilizaNumeroNFClick(Sender: TObject);
begin
  frmInutilizaNumeroNF := TfrmInutilizaNumeroNF.Create(Self);
  frmInutilizaNumeroNF.ShowModal;
  FreeAndNil(frmInutilizaNumeroNF);
end;

procedure TfrmPrincipal.uFaturaPedidoClick(Sender: TObject);
begin
  frmFaturaPedido := TfrmFaturaPedido.Create(Self);
  frmFaturaPedido.ShowModal;
  FreeAndNil(frmFaturaPedido);
end;

procedure TfrmPrincipal.uConsultaNFeClick(Sender: TObject);
begin
  frmConsultaNFe := TfrmConsultaNFe.Create(Self);
  frmConsultaNFe.ShowModal;
  FreeAndNil(frmConsultaNFe);
end;

procedure TfrmPrincipal.uControleOrcamentosClick(Sender: TObject);
begin
  frmControleOrcamentos := TfrmControleOrcamentos.Create(Self);
  frmControleOrcamentos.TipoOperacaoControleOrcamento := TTpOprCtrlOrcmntConsultaPadrao;
  frmControleOrcamentos.ShowModal;
  FreeAndNil(frmControleOrcamentos);
end;

procedure TfrmPrincipal.uDevolucaoVendaClick(Sender: TObject);
begin
  frmDevolucaoVenda := TfrmDevolucaoVenda.Create(Self);
  frmDevolucaoVenda.ShowModal;
  FreeAndNil(frmDevolucaoVenda);
end;

procedure TfrmPrincipal.uRelVendasProdutosPeriodoClick(Sender: TObject);
begin
  frmRelVendasProdutosPeriodo := TfrmRelVendasProdutosPeriodo.Create(Self);
  frmRelVendasProdutosPeriodo.ShowModal;
  FreeAndNil(frmRelVendasProdutosPeriodo);
end;

procedure TfrmPrincipal.uCadastroClienteFornecedorClick(Sender: TObject);
begin
  frmCadastroCliente := TfrmCadastroCliente.Create(nil);
  frmCadastroCliente.bCadastroFornecedor := True;
  frmCadastroCliente.ShowModal;
  FreeAndNil(frmCadastroCliente);
end;

procedure TfrmPrincipal.uEntradaNFCancelaClick(Sender: TObject);
begin
  frmEntradaNFCancela := TfrmEntradaNFCancela.Create(nil);
  frmEntradaNFCancela.ShowModal;
  FreeAndNil(frmEntradaNFCancela);
end;

procedure TfrmPrincipal.uEntradaNFClick(Sender: TObject);
begin
  frmEntradaNF := TfrmEntradaNF.Create(nil);
  frmEntradaNF.ShowModal;
  FreeAndNil(frmEntradaNF);
end;

procedure TfrmPrincipal.uRelEntradaPeriodoClick(Sender: TObject);
begin
  frmEntradaPeriodo := TfrmEntradaPeriodo.Create(nil);
  frmEntradaPeriodo.ShowModal;
  FreeAndNil(frmEntradaPeriodo);
end;

procedure TfrmPrincipal.uRelProdutosCadastradosClick(Sender: TObject);
begin
  frmRelProdutosCadastrados := TfrmRelProdutosCadastrados.Create(nil);
  frmRelProdutosCadastrados.ShowModal;
  FreeAndNil(frmRelProdutosCadastrados);
end;

procedure TfrmPrincipal.uRelEntradaProdutoPeriodoClick(Sender: TObject);
begin
  frmRelEntradaProdutoPeriodo := TfrmRelEntradaProdutoPeriodo.Create(nil);
  frmRelEntradaProdutoPeriodo.ShowModal;
  FreeAndNil(frmRelEntradaProdutoPeriodo);
end;

procedure TfrmPrincipal.pTextoSplash(S: string);
begin
  if Assigned(fSplash) then
  begin
    fSplash.lbStatus.Caption := S;
    fSplash.Update;
    sleep(700);
  end;
end;

function TfrmPrincipal.fCarregaMenus(): Boolean;
var
  c: Integer;
  qryConsulta: TZQuery;
begin
  Result := False;
  try
    qryConsulta := TZQuery.Create(nil);
    with qryConsulta do
    begin
      Connection := zcoConexaoBanco;
      Close;
      with frmPrincipal do
      begin
        for c := 0 to ComponentCount - 1 do
        begin
          if Components[c] is TMenuItem then
          begin
            { M�dulo maior que zero (tbparmodulo) }
            if (TMenuItem(Components[c]).tag) > 0 then
            begin
              if (TMenuItem(Components[c]).tag) <> 99 then
              begin
                Sql.Clear;
                Sql.Add('INSERT INTO tbmenuacesso (nmmenuacesso, idmodulo, form, idmenuacessotipo)');
                Sql.Add('SELECT :nmmenuacesso, :idmodulo, :form, :idmenuacessotipo');
                Sql.Add(' WHERE NOT EXISTS (SELECT nmmenuacesso FROM tbmenuacesso WHERE nmmenuacesso = :nmmenuacesso)');

                ParamByName('nmmenuacesso').Value := TMenuItem(Components[c]).Hint;
                ParamByName('idmodulo').Value := TMenuItem(Components[c]).GroupIndex;
                ParamByName('form').Value := TMenuItem(Components[c]).Name;
                ParamByName('idmenuacessotipo').Value := TMenuItem(Components[c]).tag;

                ExecSQL;
              end;
            end;
          end;
        end;
        Result := True;
      end;
    end;
  except
    on E: Exception do
    begin
      pMsgAtencao('N�o foi poss�vel recarregar os Menus do sistema.' + #13 +
        'Verifique os detalhes do erro e contate o suporte para transmitir o problema.', 'Mensagem original: ' + #13 + E.Message);
      Application.Terminate;
    end;
  end;
end;

function TfrmPrincipal.fGetParams(pNMParametro: string): Variant;
var
  qrParametro: TZQuery;
begin
  try
    Result := '';
    qrParametro := TZQuery.Create(nil);
    try
      with qrParametro do
      begin
        Connection := zcoConexaoBanco;
        Close;
        Sql.Clear;
        Sql.Add('SELECT * FROM TBPARAMETRO');
        Sql.Add(' WHERE sparametro = :nmparametro');
        Sql.Add('   AND iEmpresa = :Empresa');

        ParamByName('Empresa').Value := oEmpresaPrincipal.Getiempresa;

        if Params.FindParam('nmparametro') <> nil then
          ParamByName('nmparametro').Value := pNMParametro;

        Open;

        if Fields.FindField('sValor') <> nil then
          Result := iif(IsEmpty, '', FieldByName('sValor').AsString);
      end;
    except
      on E: Exception do
      begin
        pMsgAtencao('N�o foi poss�vel carregar o par�metro!' + #13 + 'Verifique os detalhes do erro e contate o suporte para transmitir o problema.',
          'Mensagem original: ' + #13 + E.Message);
        Result := '';
        Exit;
      end;
    end;
  finally
    FreeAndNil(qrParametro);
  end;
end;

procedure TfrmPrincipal.pConfiguraMenuAcessoUsuario(pGrupoUsuario: Integer);
var
  c: Integer;
begin
  oGrupoAcesso := TRotina.Create(frmPrincipal.zcoConexaoBanco);
  with frmPrincipal do
  begin
    for c := 0 to ComponentCount - 1 do
    begin
      if pGrupoUsuario > 0 then
      begin
        if Components[c] is TMenuItem then
        begin
          if (TMenuItem(Components[c]).tag) > 0 then
          begin
            if oGrupoAcesso.bPesquisaAcesso(pGrupoUsuario, fRetiraInteiro(TMenuItem(Components[c]).Name)) = 'T' then
              TMenuItem(Components[c]).Enabled := True
            else if oGrupoAcesso.bPesquisaAcesso(pGrupoUsuario, fRetiraInteiro(TMenuItem(Components[c]).Name)) = 'F' then
              TMenuItem(Components[c]).Enabled := False
            else if oGrupoAcesso.bPesquisaAcesso(pGrupoUsuario, fRetiraInteiro(TMenuItem(Components[c]).Name)) = 'I' then
            begin
              TMenuItem(Components[c]).Enabled := False;
              TMenuItem(Components[c]).Visible := False;
            end;
          end
          else
            TMenuItem(Components[c]).Enabled := True;
        end;

        if Components[c] is TcxButton then
        begin
          if (TcxButton(Components[c]).tag) > 0 then
          begin
            if oGrupoAcesso.bPesquisaAcesso(pGrupoUsuario, fRetiraInteiro(TcxButton(Components[c]).HelpKeyword)) = 'T' then
              TcxButton(Components[c]).Enabled := True
            else if oGrupoAcesso.bPesquisaAcesso(pGrupoUsuario, fRetiraInteiro(TcxButton(Components[c]).HelpKeyword)) = 'F' then
              TcxButton(Components[c]).Enabled := False
            else if oGrupoAcesso.bPesquisaAcesso(pGrupoUsuario, fRetiraInteiro(TcxButton(Components[c]).HelpKeyword)) = 'I' then
            begin
              TcxButton(Components[c]).Enabled := False;
              TcxButton(Components[c]).Visible := False;
            end;
          end
          else
            TcxButton(Components[c]).Enabled := True;
        end;
      end
      else
      begin
        // Esconde menus com tag -1 (Desabilitado) para Administradores
        if Components[c] is TMenuItem then
        begin
          if TMenuItem(Components[c]).tag = -1 then
          begin
            TMenuItem(Components[c]).Enabled := False;
            TMenuItem(Components[c]).Visible := False;
          end;
        end;

        if Components[c] is TcxButton then
        begin
          if TcxButton(Components[c]).tag = -1 then
          begin
            TcxButton(Components[c]).Enabled := False;
            TcxButton(Components[c]).Visible := False;
          end;
        end;
      end;
    end;
  end;
end;

function TfrmPrincipal.fSetParams(pNMParametro, pValor: string): Boolean;
var
  qrParametro: TZQuery;
begin
  try
    Result := False;
    qrParametro := TZQuery.Create(nil);
    try
      with qrParametro do
      begin
        Connection := zcoConexaoBanco;
        Close;
        Sql.Clear;
        Sql.Add('UPDATE TBPARAMETRO SET sValor = :Valor');
        Sql.Add(' WHERE iEmpresa = :Empresa');

        ParamByName('Empresa').Value := oEmpresaPrincipal.Getiempresa;

        if Params.FindParam('valor') <> nil then
          ParamByName('valor').Value := pValor;

        ExecSQL;

        Result := True;
      end;
    except
      on E: Exception do
      begin
        pMsgAtencao('N�o foi poss�vel gravar a atera��o do par�metro!' + #13 +
          'Verifique os detalhes do erro e contate o suporte para transmitir o problema.', 'Mensagem original: ' + #13 + E.Message);
        Result := False;
        Exit;
      end;
    end;
  finally
    FreeAndNil(qrParametro);
  end;
end;

end.
