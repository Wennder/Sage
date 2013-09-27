unit uPedidoItens;

interface

uses ZConnection, ZDataset, SysUtils, uConstantes, Classes, uProcedimentosBanco, uExceptions, Variants, Forms,
     Dialogs, Windows, uNumeros, Controls, uTabelaPrecoItens, uPedido;

type

  TPedidoItens = class
  public
    constructor Create(pzcoConnection: TZConnection);
    destructor Destroy;override;

    procedure CadastraPedido;
    function iRetornaUltimoCodigo: Integer;

    procedure SetiCodigo(piCodigo: Integer);
    procedure SetiPedido(piPedido: Integer);
    procedure SetiProduto(piProduto: Integer);
    procedure SetnQuantidade(pnQuantidade: Real);
    procedure SetnValor(pnValor: Real);

    function GetiCodigo: Integer;
    function GetiPedido: Integer;
    function GetiProduto: Integer;
    function GetnQuantidade: Real;
    function GetnValor: Real;

  private
    zcoConnection   : TZConnection;
    iCodigo         : Integer;
    iPedido         : Integer;
    iProduto        : Integer;
    nQuantidade     : Real;
    nValor          : Real;
  end;

implementation

{ TPedidoItens }

procedure TPedidoItens.CadastraPedido;
var
  ZQryPedidoItens: TZQuery;
begin
  ZQryPedidoItens := TZQuery.Create(nil);
  with ZQryPedidoItens do
  begin
    SetiCodigo(iRetornaUltimoCodigo + 1);
    Connection := zcoConnection;
    SQL.Clear;
    SQL.Add('INSERT INTO tbPedidoItens(icodigo, iPedido, iProduto, nQuantidade, nValor)');
    SQL.Add('VALUES(:icodigo, :ipedido, :iproduto, :nquantidade, :nvalor)');
    ParamByName('icodigo'    ).AsInteger := GetiCodigo;
    ParamByName('iPedido'    ).AsInteger := GetiPedido;
    ParamByName('iProduto'   ).AsInteger := GetiProduto;
    ParamByName('nQuantidade').AsFloat   := GetnQuantidade;
    ParamByName('nValor'     ).AsFloat   := GetnValor;
    ExecSQL;
  end;
  FreeAndNil(ZQryPedidoItens);
end;

constructor TPedidoItens.Create(pzcoConnection: TZConnection);
begin
    zcoConnection := pzcoConnection;
end;

destructor TPedidoItens.Destroy;
begin
  inherited;
end;


function TPedidoItens.GetiCodigo: Integer;
begin
  Result := iCodigo;
end;

function TPedidoItens.GetiPedido: Integer;
begin
  Result := iPedido;
end;

function TPedidoItens.GetiProduto: Integer;
begin
  Result := iProduto;
end;

function TPedidoItens.GetnQuantidade: Real;
begin
  Result := nQuantidade;
end;

function TPedidoItens.GetnValor: Real;
begin
  Result := nValor;
end;

function TPedidoItens.iRetornaUltimoCodigo: Integer;
var
  ZQryPedidoItens: TZQuery;
begin
  ZQryPedidoItens := TZQuery.Create(nil);
  with ZQryPedidoItens do
  begin
    Connection := zcoConnection;
    SQL.Clear;
    SQL.Add('SELECT COALESCE(MAX(icodigo),0) AS ULTIMO FROM tbPedidoItens');
    Open;
    Result := FieldByName('ULTIMO').AsInteger;
  end;
  FreeAndNil(ZQryPedidoItens);
end;

procedure TPedidoItens.SetiCodigo(piCodigo: Integer);
begin
  iCodigo := piCodigo;
end;

procedure TPedidoItens.SetiPedido(piPedido: Integer);
begin
  iPedido := piPedido;
end;

procedure TPedidoItens.SetiProduto(piProduto: Integer);
begin
  iProduto := piProduto;
end;

procedure TPedidoItens.SetnQuantidade(pnQuantidade: Real);
begin
  nQuantidade := pnQuantidade;
end;

procedure TPedidoItens.SetnValor(pnValor: Real);
begin
  nValor := pnValor;
end;

end.
