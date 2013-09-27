unit uVenda;

interface

uses SysUtils, uPedido, uPedidoItens, Contnrs, ZConnection, uProduto,
  uTabelaPrecoItens,
  uConsumidor, uControleECF, ZDataset;

type
  TItemVenda = class
  public
    oProduto: TProduto;
    oTabelaPrecoItem: TTabelaPrecoItens;

    constructor Create(pzcoConnection: TZConnection);
    destructor Destroy; override;

  end;

  TVenda = class
  public
    oPedido: TPedido;
    oItensPedido: TObjectList;
    oItemVenda: TItemVenda;
    oConsumidor: TConsumidor;

    constructor Create(pzcoConnection: TZConnection);
    destructor Destroy; override;

    procedure InsereConsumidor(sNome, sEndereco, sBairro, sCep, sFone: String;
      iCidade: Integer);

    procedure ImprimeCupomFiscal;

    procedure InsereEditaPedido(iNatureza, iCFOP, iCliente, iVendedor: Integer;
      nTotalProdutos, nAjusteValor, nAjustePercentual, nKm: Real;
      sObservacao, sVeiculo, sPlaca: String; bIsPedido: Boolean;
      bIsCupomFiscal: Boolean; bisOrcamento: Boolean; bFecharOrcamento: Boolean;
      bEdicaoOrcamento: Boolean; iCodigoPedido: Integer);
    procedure InsereItem(iProduto: Integer; nQuantidade, nValor: Real);
    function VendaTemServico(piPedido: Integer): Boolean;

    procedure GravaFormaRecebimento(piPedido, piFormaRecebimento,
      piBandeiraCartao: Integer);

    procedure SalvaOrcamento;
    procedure EditaOrcamento;

  private
    zcoConnection: TZConnection;

  end;

implementation

{ TVenda }

constructor TVenda.Create(pzcoConnection: TZConnection);
begin
  zcoConnection := pzcoConnection;
  oPedido := TPedido.Create(pzcoConnection);
  oItensPedido := TObjectList.Create;
  oItemVenda := TItemVenda.Create(pzcoConnection);
  oConsumidor := TConsumidor.Create(pzcoConnection);
end;

destructor TVenda.Destroy;
begin
  FreeAndNil(oPedido);
  FreeAndNil(oItensPedido);
  FreeAndNil(oConsumidor);
  inherited;
end;

procedure TVenda.EditaOrcamento;
begin

end;

procedure TVenda.GravaFormaRecebimento(piPedido, piFormaRecebimento,
  piBandeiraCartao: Integer);
var
  ZQry: TZQuery;
begin
  ZQry := TZQuery.Create(nil);
  with ZQry do
  begin
    Connection := zcoConnection;
    SQL.Clear;
    SQL.Add('insert into tbformarecebimento(pedido, forma, bandeira)');
    SQL.Add('values(:ipedido, :iforma, :ibandeira)');
    ParamByName('iPedido').AsInteger := piPedido;
    ParamByName('iforma').AsInteger := piFormaRecebimento;
    ParamByName('ibandeira').AsInteger := piBandeiraCartao;
    ExecSQL;
  end;
  FreeAndNil(ZQry);
end;

procedure TVenda.ImprimeCupomFiscal;
begin
  uControleECF.ImprimeCupomFiscal(oPedido.iGetCodigo, zcoConnection);
end;

procedure TVenda.InsereConsumidor(sNome, sEndereco, sBairro, sCep,
  sFone: String; iCidade: Integer);
begin
  with oConsumidor do
  begin
    SetiPedido(oPedido.iGetCodigo);
    SetsNome(sNome);
    SetsEndereco(sEndereco);
    SetsBairro(sBairro);
    SetiCidade(iCidade);
    SetsCep(sCep);
    SetsFone(sFone);
    CadastraConsumidor;
  end;
end;

procedure TVenda.InsereItem(iProduto: Integer; nQuantidade, nValor: Real);
var
  iIndice: Integer;
begin
  iIndice := oItensPedido.Add(TPedidoItens.Create(zcoConnection));
  TPedidoItens(oItensPedido.Items[iIndice]).SetiProduto(iProduto);
  TPedidoItens(oItensPedido.Items[iIndice]).SetnQuantidade(nQuantidade);
  TPedidoItens(oItensPedido.Items[iIndice]).SetnValor(nValor);
  TPedidoItens(oItensPedido.Items[iIndice]).SetiPedido(oPedido.iGetCodigo);
  TPedidoItens(oItensPedido.Items[iIndice]).CadastraPedido;
end;

procedure TVenda.InsereEditaPedido(iNatureza, iCFOP, iCliente,
  iVendedor: Integer; nTotalProdutos, nAjusteValor, nAjustePercentual,
  nKm: Real; sObservacao, sVeiculo, sPlaca: String; bIsPedido: Boolean;
  bIsCupomFiscal: Boolean; bisOrcamento: Boolean; bFecharOrcamento: Boolean;
  bEdicaoOrcamento: Boolean; iCodigoPedido: Integer);

begin
  oPedido.oNatureza.SetiCodigo(iNatureza);
  oPedido.oCFOP.SetiCodigo(iCFOP);
  oPedido.oCliente.SetCodigo(IntToStr(iCliente));
  oPedido.SetTotalProdutos(nTotalProdutos);
  oPedido.SetAjusteValor(nAjusteValor);
  oPedido.SetObservacao(sObservacao);
  oPedido.SetAjustePercentual(nAjustePercentual);
  oPedido.SetIsPedido(bIsPedido);
  oPedido.SetsVeiculo(sVeiculo);
  oPedido.SetsPlaca(sPlaca);
  oPedido.SetnKM(nKm);
  oPedido.oVendedor.SetCodigo(IntToStr(iVendedor));
  oPedido.SetisCupomFiscal(bIsCupomFiscal);
  oPedido.SetisOrcamento(bisOrcamento);
  oPedido.SetCodigo(iCodigoPedido);
  oPedido.SetDataPedido(Now);
  oPedido.SetHoraPedido(Now);
  oPedido.SetbFecharOrcamento(bFecharOrcamento);
  if bEdicaoOrcamento then
    oPedido.EditaPedido

  else
    oPedido.CadastraPedido;
end;

procedure TVenda.SalvaOrcamento;
begin

end;

function TVenda.VendaTemServico(piPedido: Integer): Boolean;
var
  ZQry: TZQuery;
begin
  ZQry := TZQuery.Create(nil);
  with ZQry do
  begin
    Connection := zcoConnection;
    SQL.Clear;
    SQL.Add('select *');
    SQL.Add('from tbpedidoitens');
    SQL.Add('join tbproduto on tbproduto.icodigo = tbpedidoitens.iproduto');
    SQL.Add('where tbproduto.sservico = ''S'' and tbpedidoitens.ipedido = :ipedido');
    ParamByName('iPedido').AsInteger := piPedido;
    Open;
    Result := not(Bof and Eof);
  end;
  FreeAndNil(ZQry);
end;

{ TItemVenda }

constructor TItemVenda.Create(pzcoConnection: TZConnection);
begin
  oProduto := TProduto.Create(pzcoConnection);
  oTabelaPrecoItem := TTabelaPrecoItens.Create(pzcoConnection);
end;

destructor TItemVenda.Destroy;
begin
  FreeAndNil(oProduto);
  FreeAndNil(oTabelaPrecoItem);
  inherited;
end;

end.
