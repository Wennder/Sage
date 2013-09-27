unit uPedido;

interface

uses ZConnection, ZDataset, SysUtils, uConstantes, Classes, uProcedimentosBanco,
  uExceptions, Variants, Forms,
  Dialogs, Windows, uNumeros, Controls, uNaturezaOperacao, uCodigoFiscal,
  uCliente, uComissionado, uEmpresa, uPrincipal;

type
  TPedido = class
  public

    oNatureza: TNaturezaOperacao;
    oCFOP: TCodigoFiscal;
    oCliente: TCliente;
    oVendedor: TComissionado;

    constructor Create(pzcoConnection: TZConnection);
    destructor Destroy; override;

    procedure CadastraPedido;
    procedure CancelaPedido;
    procedure geraOrcamentoAberto;
    procedure FechaOrcamento;
    procedure EditaPedido;
    procedure ExcluiPedidoItens;
    procedure TransformaOrcamentoFechadoEmNF;
    function iCamposConsistentes: Integer;
    function iRetornaUltimoCodigo: Integer;

    function iGetCodigo: Variant;
    function dGetDataPedido: TDate;
    function tGetHoraPedido: TTime;
    function nGetTotalProdutos: Real;
    function nGetAjusteValor: Real;
    function sGetObservacao: String;
    function sGetStatus: String;
    function nGetAjustePercentual: Real;
    function bGetIsPedido: Boolean;
    function sGetVeiculo: String;
    function sGetPlaca: String;
    function nGetKM: Real;
    function bGetIsCupomFiscal: Boolean;
    function GetiCliente: Variant;
    function GetsCliente: Variant;
    function GetIsNF: Boolean;

    procedure SetCodigo(piCodigo: Variant);
    procedure SetiCliente(piCliente: Variant);
    procedure SetDataPedido(pdDataPedido: TDate);
    procedure SetHoraPedido(ptHoraPedido: TTime);
    procedure SetTotalProdutos(pnTotalProdutos: Real);
    procedure SetAjusteValor(pnAjusteValor: Real);
    procedure SetObservacao(psObservacao: String);
    procedure SetStatus(psStatus: String);
    procedure SetAjustePercentual(pnAjustePercentual: Real);
    procedure SetIsPedido(pbIsPedido: Boolean);
    procedure SetsVeiculo(psVeiculo: String);
    procedure SetsPlaca(psPlaca: String);
    procedure SetnKM(pnKM: Real);
    procedure SetIsCupomFiscal(pbIsCupomFiscal: Boolean);
    procedure SetIsOrcamento(pbIsOrcamento: Boolean);
    procedure SetbFecharOrcamento(pbFecharOrcamento: Boolean);
    procedure SetsCliente(psCliente: Variant);
    procedure SetIsNF(pParametro: Boolean);
    function PesquisaPedido(piCodigo: Integer): Boolean;

  private
    zcoConnection: TZConnection;
    iCodigo: Variant;
    iNatureza: Integer;
    iCFOP: Integer;
    iCliente: Variant;
    sCliente: Variant;
    dDataPedido: TDate;
    tHoraPedido: TTime;
    nTotalProdutos: Real;
    nAjusteValor: Real;
    sObservacao: String;
    sStatus: String;
    nAjustePercentual: Real;
    bIsPedido: Boolean;
    bIsNF: Boolean;
    sVeiculo: String;
    sPlaca: String;
    nKM: Real;
    bIsCupomFiscal: Boolean;
    bIsOrcamento: Boolean;
    bFecharOrcamento: Boolean;
  end;

implementation

uses Math, uFuncoes;

{ TPedido }

procedure TPedido.CadastraPedido;
var
  ZQryPedido: TZQuery;
begin
  ZQryPedido := TZQuery.Create(nil);
  with ZQryPedido do
  begin
    Connection := zcoConnection;
    SetCodigo(iRetornaUltimoCodigo + 1);
    SetDataPedido(fDataHoraSrv(frmprincipal.zcoConexaoBanco));
    SetHoraPedido(fDataHoraSrv(frmprincipal.zcoConexaoBanco));
    SQL.Clear;
    SQL.Add('INSERT INTO tbPedido(icodigo, inatureza, icfop,');
    SQL.Add('icliente,');
    SQL.Add('ddatapedido, thorapedido, ntotalprodutos, najustevalor, sobservacao, nAjustePercentual, bPedido,');
    SQL.Add('sVeiculo, sPlaca, nKM, ivendedor, bCupomFiscal, iEmpresa, iflagsituacao)');
    SQL.Add('VALUES(:icodigo, :inatureza, :icfop,');
    if oCliente.sGetCodigo = '' then
      SQL.Add('NULL,')
    else
      SQL.Add(':icliente,');
    SQL.Add(':ddatapedido, :thorapedido,  :ntotalprodutos, :najustevalor, :sobservacao, :nAjustePercentual, :bPedido,');
    SQL.Add(':sVeiculo, :sPlaca, :nKM');
    if oVendedor.sGetCodigo = '' then
      SQL.Add(',NULL')
    else
      SQL.Add(',:iVendedor');
    SQL.Add(',:bCupomFiscal, :iEmpresa, :iflagsituacao)');
    ParamByName('icodigo').AsInteger := iGetCodigo;
    ParamByName('inatureza').AsInteger := oNatureza.iGetCodigo;
    ParamByName('icfop').AsInteger := oCFOP.iGetCodigo;
    if oCliente.sGetCodigo <> '' then
      ParamByName('icliente').AsInteger := StrToInt(oCliente.sGetCodigo);
    ParamByName('ddatapedido').AsDate := dGetDataPedido;
    ParamByName('thorapedido').AsTime := tGetHoraPedido;
    ParamByName('ntotalprodutos').AsFloat := nGetTotalProdutos;
    ParamByName('najustevalor').AsFloat := nGetAjusteValor;
    ParamByName('sobservacao').AsString := sGetObservacao;
    ParamByName('nAjustePercentual').AsFloat := nGetAjustePercentual;
    ParamByName('bPedido').AsBoolean := bGetIsPedido;
    ParamByName('sVeiculo').AsString := sGetVeiculo;
    ParamByName('sPlaca').AsString := sGetPlaca;
    ParamByName('nKm').AsFloat := nGetKM;
    if oVendedor.sGetCodigo <> '' then
      ParamByName('iVendedor').AsInteger := StrToInt(oVendedor.sGetCodigo);
    ParamByName('bCupomFiscal').AsBoolean := bGetIsCupomFiscal;
    ParamByName('iEmpresa').AsInteger := oEmpresaPrincipal.Getiempresa;;
    if bIsOrcamento then
    begin
      if bFecharOrcamento then
        ParamByName('iflagsituacao').Value := 2
      else
        ParamByName('iflagsituacao').Value := 1;
    end
    else if bIsPedido then
      ParamByName('iflagsituacao').Value := 3
    else
      ParamByName('iflagsituacao').Value := 1;
    ExecSQL;
  end;
  FreeAndNil(ZQryPedido);
end;

constructor TPedido.Create(pzcoConnection: TZConnection);
begin
  inherited Create;
  zcoConnection := pzcoConnection;
  oNatureza := TNaturezaOperacao.Create(pzcoConnection);
  oCFOP := TCodigoFiscal.Create(pzcoConnection);
  oCliente := TCliente.Create(pzcoConnection);
  oVendedor := TComissionado.Create(pzcoConnection);
end;

destructor TPedido.Destroy;
begin
  FreeAndNil(oNatureza);
  FreeAndNil(oCFOP);
  FreeAndNil(oCliente);
  FreeAndNil(oVendedor);
  inherited;
end;

function TPedido.dGetDataPedido: TDate;
begin
  Result := dDataPedido;
end;

procedure TPedido.EditaPedido;
var
  ZQryPedido: TZQuery;
begin
  ZQryPedido := TZQuery.Create(nil);
  with ZQryPedido do
  begin
    Connection := zcoConnection;
    SQL.Clear;
    SQL.Add('update tbPedido set inatureza = :inatureza, icfop = :icfop,');
    SQL.Add('icliente = ');
    if oCliente.sGetCodigo = '' then
      SQL.Add('NULL,')
    else
      SQL.Add(':icliente,');
    SQL.Add('ddatapedido = :ddatapedido, thorapedido = :thorapedido, ntotalprodutos = :ntotalprodutos, najustevalor = :najustevalor, sobservacao = :sobservacao, nAjustePercentual = :nAjustePercentual, bPedido = :bPedido,');
    SQL.Add('sVeiculo = :sVeiculo, sPlaca = :sPlaca, nKM = :nKM, ivendedor = ');
    if oVendedor.sGetCodigo = '' then
      SQL.Add(' NULL')
    else
      SQL.Add(' :iVendedor');
    SQL.Add(',bCupomFiscal = :bCupomFiscal, iEmpresa = :iEmpresa, iflagsituacao = :iflagsituacao');
    SQL.Add('where icodigo = :icodigo');
    ParamByName('icodigo').AsInteger := iGetCodigo;
    ParamByName('inatureza').AsInteger := oNatureza.iGetCodigo;
    ParamByName('icfop').AsInteger := oCFOP.iGetCodigo;
    if oCliente.sGetCodigo <> '' then
      ParamByName('icliente').AsInteger := StrToInt(oCliente.sGetCodigo);
    ParamByName('ddatapedido').AsDate := dGetDataPedido;
    ParamByName('thorapedido').AsTime := tGetHoraPedido;
    ParamByName('ntotalprodutos').AsFloat := nGetTotalProdutos;
    ParamByName('najustevalor').AsFloat := nGetAjusteValor;
    ParamByName('sobservacao').AsString := sGetObservacao;
    ParamByName('nAjustePercentual').AsFloat := nGetAjustePercentual;
    ParamByName('bPedido').AsBoolean := bGetIsPedido;
    ParamByName('sVeiculo').AsString := sGetVeiculo;
    ParamByName('sPlaca').AsString := sGetPlaca;
    ParamByName('nKm').AsFloat := nGetKM;
    if oVendedor.sGetCodigo <> '' then
      ParamByName('iVendedor').AsInteger := StrToInt(oVendedor.sGetCodigo);
    ParamByName('bCupomFiscal').AsBoolean := bGetIsCupomFiscal;
    ParamByName('iEmpresa').AsInteger := oEmpresaPrincipal.Getiempresa;;
    if bIsOrcamento then
    begin
      if bFecharOrcamento then
        ParamByName('iflagsituacao').Value := 2
      else
        ParamByName('iflagsituacao').Value := 1;
    end
    else if bIsPedido then
      ParamByName('iflagsituacao').Value := 3
    else
      ParamByName('iflagsituacao').Value := 1;
    ExecSQL;
  end;
  FreeAndNil(ZQryPedido);
  ExcluiPedidoItens;
end;

procedure TPedido.ExcluiPedidoItens;
var
  ZQryPedidoItens: TZQuery;
begin
  ZQryPedidoItens := TZQuery.Create(nil);
  with ZQryPedidoItens do
  begin
    Connection := zcoConnection;
    SQL.Clear;
    SQL.Add('delete from tbPedidoItens');
    SQL.Add('where ipedido = :ipedido');
    ParamByName('iPedido').AsInteger := iGetCodigo;
    ExecSQL;
  end;
  FreeAndNil(ZQryPedidoItens);
end;

procedure TPedido.FechaOrcamento;
var
  ZQryPedido: TZQuery;
begin
  ZQryPedido := TZQuery.Create(nil);
  with ZQryPedido do
  begin
    Connection := zcoConnection;
    SQL.Clear;
    SQL.Add('update tbPedido set iflagsituacao = :iflagsituacao where icodigo = :icodigo');
    ParamByName('icodigo').AsInteger := iGetCodigo;
    ParamByName('iflagsituacao').AsInteger := 2;
    ExecSQL;
  end;
  FreeAndNil(ZQryPedido);
end;

procedure TPedido.geraOrcamentoAberto;
var
  ZQryPedido: TZQuery;
begin
  ZQryPedido := TZQuery.Create(nil);
  with ZQryPedido do
  begin
    Connection := zcoConnection;
    SQL.Clear;
    SQL.Add('update tbPedido set iflagsituacao = :iflagsituacao where icodigo = :icodigo');
    ParamByName('icodigo').AsInteger := iGetCodigo;
    ParamByName('iflagsituacao').AsInteger := 1;
    ExecSQL;
  end;
  FreeAndNil(ZQryPedido);
end;

function TPedido.GetiCliente: Variant;
begin
  Result := iCliente;
end;

function TPedido.GetIsNF: Boolean;
begin
  Result := bIsNF;
end;

function TPedido.GetsCliente: Variant;
begin
  Result := sCliente;
end;

function TPedido.iCamposConsistentes: Integer;
begin

end;

function TPedido.iGetCodigo: Variant;
begin
  Result := iCodigo;
end;

function TPedido.iRetornaUltimoCodigo: Integer;
var
  ZQryPedido: TZQuery;
begin
  ZQryPedido := TZQuery.Create(nil);
  with ZQryPedido do
  begin
    Connection := zcoConnection;
    SQL.Clear;
    SQL.Add('SELECT COALESCE(MAX(icodigo),0) AS ULTIMO FROM tbPedido');
    Open;
    Result := FieldByName('ULTIMO').AsInteger;
  end;
  FreeAndNil(ZQryPedido);
end;

function TPedido.nGetAjusteValor: Real;
begin
  Result := nAjusteValor;
end;

function TPedido.nGetTotalProdutos: Real;
begin
  Result := nTotalProdutos;
end;

procedure TPedido.SetAjusteValor(pnAjusteValor: Real);
begin
  nAjusteValor := pnAjusteValor;
end;

procedure TPedido.SetbFecharOrcamento(pbFecharOrcamento: Boolean);
begin
  bFecharOrcamento := pbFecharOrcamento;
end;

procedure TPedido.SetCodigo(piCodigo: Variant);
begin
  iCodigo := piCodigo;
end;

procedure TPedido.SetDataPedido(pdDataPedido: TDate);
begin
  dDataPedido := pdDataPedido;
end;

procedure TPedido.SetHoraPedido(ptHoraPedido: TTime);
begin
  tHoraPedido := ptHoraPedido;
end;

procedure TPedido.SetiCliente(piCliente: Variant);
begin
  iCodigo := piCliente;
end;

procedure TPedido.SetObservacao(psObservacao: String);
begin
  sObservacao := psObservacao;
end;

procedure TPedido.SetStatus(psStatus: String);
begin
  sStatus := psStatus;
end;

procedure TPedido.SetTotalProdutos(pnTotalProdutos: Real);
begin
  nTotalProdutos := pnTotalProdutos;
end;

function TPedido.sGetObservacao: String;
begin
  Result := sObservacao;
end;

function TPedido.sGetStatus: String;
begin
  Result := sStatus;
end;

function TPedido.tGetHoraPedido: TTime;
begin
  Result := tHoraPedido;
end;

procedure TPedido.TransformaOrcamentoFechadoEmNF;
begin

end;

procedure TPedido.SetAjustePercentual(pnAjustePercentual: Real);
begin
  nAjustePercentual := pnAjustePercentual;
end;

function TPedido.nGetAjustePercentual: Real;
begin
  Result := nAjustePercentual;
end;

function TPedido.bGetIsPedido: Boolean;
begin
  Result := bIsPedido;
end;

procedure TPedido.SetIsPedido(pbIsPedido: Boolean);
begin
  bIsPedido := pbIsPedido;
end;

function TPedido.nGetKM: Real;
begin
  Result := nKM;
end;

procedure TPedido.SetnKM(pnKM: Real);
begin
  nKM := pnKM;
end;

procedure TPedido.SetsCliente(psCliente: Variant);
begin
  sCliente := psCliente;
end;

procedure TPedido.SetsPlaca(psPlaca: String);
begin
  sPlaca := psPlaca;
end;

procedure TPedido.SetsVeiculo(psVeiculo: String);
begin
  sVeiculo := psVeiculo
end;

function TPedido.sGetPlaca: String;
begin
  Result := sPlaca;
end;

function TPedido.sGetVeiculo: String;
begin
  Result := sVeiculo;
end;

function TPedido.PesquisaPedido(piCodigo: Integer): Boolean;
var
  ZQry: TZQuery;
begin
  try
    Result := False;
    ZQry := TZQuery.Create(nil);
    with ZQry do
    begin
      Connection := zcoConnection;
      Close;
      SQL.Clear;

      SQL.Add('SELECT');
      SQL.Add('	p.*,');
      SQL.Add('	coalesce(coalesce(c.snome, cc.snome), ''CONSUMIDOR'') as sCliente,');
      SQL.Add('	case when ((bpedido = true) and (nf.inotafiscal > 0)) then true ELSE false End as bnf');
      SQL.Add('FROM TBPEDIDO p');
      SQL.Add('left join tbpessoa c on c.icodigo = p.icliente');
      SQL.Add('left join tbconsumidor cc on cc.ipedido = p.icodigo');
      SQL.Add('left join tbnotafiscal nf on nf.icodigo = p.icodnotafiscal');
      SQL.Add(' WHERE p.icodigo = :ipedido');

      ParamByName('ipedido').Value := piCodigo;

      Open;
      if not IsEmpty then
      begin
        SetCodigo(FieldByName('iCodigo').Value);

        SetiCliente(FieldByName('iCliente').Value);
        SetsCliente(FieldByName('sCliente').Value);
        SetDataPedido(FieldByName('ddatapedido').Value);
        SetHoraPedido(FieldByName('thorapedido').Value);
        SetTotalProdutos(FieldByName('ntotalprodutos').Value);
        SetAjusteValor(FieldByName('najustevalor').Value);
        SetObservacao(FieldByName('sobservacao').Value);
        SetStatus(FieldByName('sstatus').Value);
        SetAjustePercentual(FieldByName('najustepercentual').Value);
        SetIsPedido(FieldByName('bpedido').Value);
        SetsVeiculo(FieldByName('sveiculo').Value);
        SetsPlaca(FieldByName('splaca').Value);
        SetnKM(FieldByName('nKm').Value);
        SetIsCupomFiscal(FieldByName('bcupomfiscal').Value);
        SetIsNF(FieldByName('bnf').Value);

        Result := True;
      end;
    end;
  finally
    FreeAndNil(ZQry);
  end;
end;

function TPedido.bGetIsCupomFiscal: Boolean;
begin
  Result := bIsCupomFiscal;
end;

procedure TPedido.SetIsCupomFiscal(pbIsCupomFiscal: Boolean);
begin
  bIsCupomFiscal := pbIsCupomFiscal;
end;

procedure TPedido.SetIsNF(pParametro: Boolean);
begin
  bIsNF := pParametro;
end;

procedure TPedido.SetIsOrcamento(pbIsOrcamento: Boolean);
begin
  bIsOrcamento := pbIsOrcamento;
end;

procedure TPedido.CancelaPedido;
var
  ZQryPedido: TZQuery;
begin
  ZQryPedido := TZQuery.Create(nil);

  with ZQryPedido do
  begin
    Connection := zcoConnection;
    SQL.Clear;
    SQL.Add('update tbPedido set sstatus = :sstatus');
    SQL.Add('where icodigo  = :pedido');
    SQL.Add('  and iempresa = :empresa');
    ParamByName('pedido').AsInteger := iGetCodigo;
    ParamByName('sstatus').AsString := 'I';
    ParamByName('empresa').AsInteger := oEmpresaPrincipal.Getiempresa;
    ExecSQL;
  end;
  FreeAndNil(ZQryPedido);
end;

end.
