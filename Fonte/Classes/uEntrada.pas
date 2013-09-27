unit uEntrada;

interface

uses SysUtils, Contnrs, ZConnection, uProduto, ZDataset, SQLMemMain, Controls, uPrincipal;

type
  TItemEntrada = class
  public
    oProduto: TProduto;
    constructor Create(pzcoConnection: TZConnection);
    destructor Destroy; override;
    procedure CadastraItemEntrada(const iCodigo, iProduto: Integer; nQuantidade, nValor: Real);
  private
    zcoConnection: TZConnection;
  end;

  TEntrada = class
  public
    constructor Create(pzcoConnection: TZConnection);
    destructor Destroy; override;
    procedure CadastraEntrada(iFornecedor, iNumeroNF: Integer; sSerie: String; dDataEntrada, dDataEmissao, dDataDigitacao: TDate; nTotal: Real);
    procedure CadastraItemEntrada(MemTable: TSQLMemTable);
    function LocalizaEntrada(iFornecedor, iNumeroNF: Integer; sSerie: String): Boolean;
    procedure CancelaNF(Fornecedor, NumeroNF, Serie: String);

    function iCamposConsistentes: Integer;
    function iRetornaUltimoCodigo: Integer;
  private
    zcoConnection: TZConnection;
    oItemEntrada: TItemEntrada;
    iCodigoEntrada: Integer;
  end;

implementation

{ TEntrada }

procedure TEntrada.CadastraEntrada(iFornecedor, iNumeroNF: Integer; sSerie: String; dDataEntrada, dDataEmissao, dDataDigitacao: TDate; nTotal: Real);
var
  ZQry: TZQuery;
begin
  ZQry := TZQuery.Create(nil);
  with ZQry do
  begin
    Connection := zcoConnection;
    SQL.Clear;
    SQL.Add('INSERT INTO TBENTRADA(fornecedor, serie, numero, dataentrada, dataemissao, ddataoperacao, ntotal, idusuariocad)');
    SQL.Add('VALUES(:fornecedor, :serie, :numero, :dataentrada, :dataemissao, :ddataoperacao, :ntotal, :idusuariocad)');
    ParamByName('fornecedor').AsInteger := iFornecedor;
    ParamByName('serie').AsString := sSerie;
    ParamByName('numero').AsInteger := iNumeroNF;
    ParamByName('dataentrada').AsDateTime := dDataEntrada;
    ParamByName('dataemissao').AsDateTime := dDataEmissao;
    ParamByName('ddataoperacao').AsDateTime := dDataDigitacao;
    ParamByName('ntotal').AsFloat := nTotal;
    ParamByName('idusuariocad').AsInteger := vIdUsuario;

    ExecSQL;
    iCodigoEntrada := iRetornaUltimoCodigo;
  end;
  FreeAndNil(ZQry);
end;

procedure TEntrada.CadastraItemEntrada(MemTable: TSQLMemTable);
begin
  oItemEntrada := TItemEntrada.Create(zcoConnection);
  with MemTable do
  begin
    First;
    while not Eof do
    begin
      oItemEntrada.CadastraItemEntrada(iCodigoEntrada, FieldByName('Produto').AsInteger, FieldByName('Quantidade').AsFloat,
        FieldByName('ValorUnitario').AsFloat);
      Next;
    end;
  end;
end;

constructor TEntrada.Create(pzcoConnection: TZConnection);
begin
  zcoConnection := pzcoConnection;
end;

destructor TEntrada.Destroy;
begin

  inherited;
end;

function TEntrada.iCamposConsistentes: Integer;
begin

end;

function TEntrada.iRetornaUltimoCodigo: Integer;
var
  ZQry: TZQuery;
begin
  ZQry := TZQuery.Create(nil);
  with ZQry do
  begin
    Connection := zcoConnection;
    SQL.Clear;
    SQL.Add('select coalesce((select max(icodigo) from tbentrada),0)');
    Open;
    Result := Fields[0].AsInteger;
  end;
  FreeAndNil(ZQry);
end;

function TEntrada.LocalizaEntrada(iFornecedor, iNumeroNF: Integer; sSerie: String): Boolean;
var
  ZQry: TZQuery;
begin
  ZQry := TZQuery.Create(nil);
  with ZQry do
  begin
    Connection := zcoConnection;
    SQL.Clear;
    SQL.Add('SELECT * FROM TBENTRADA');
    SQL.Add('WHERE FORNECEDOR = :FORNECEDOR AND SERIE = :SERIE AND NUMERO = :NUMERO');
    ParamByName('FORNECEDOR').AsInteger := iFornecedor;
    ParamByName('SERIE').AsString := sSerie;
    ParamByName('NUMERO').AsInteger := iNumeroNF;
    Open;
    Result := not IsEmpty;
  end;
  FreeAndNil(ZQry);
end;

{ TItemEntrada }

procedure TItemEntrada.CadastraItemEntrada(const iCodigo, iProduto: Integer; nQuantidade, nValor: Real);
var
  ZQry: TZQuery;
begin
  ZQry := TZQuery.Create(nil);
  with ZQry do
  begin
    Connection := zcoConnection;
    SQL.Clear;
    SQL.Add('INSERT INTO TBENTRADAITENS(iproduto, nquantidade, valor, ientrada)');
    SQL.Add('VALUES(:iproduto, :nquantidade, :valor, :ientrada)');

    ParamByName('iproduto').AsInteger := iProduto;
    ParamByName('nquantidade').AsFloat := nQuantidade;
    ParamByName('Valor').AsFloat := nValor;
    ParamByName('ientrada').AsInteger := iCodigo;
    ExecSQL;
  end;
  FreeAndNil(ZQry);
end;

constructor TItemEntrada.Create(pzcoConnection: TZConnection);
begin
  zcoConnection := pzcoConnection;
end;

destructor TItemEntrada.Destroy;
begin

  inherited;
end;

procedure TEntrada.CancelaNF(Fornecedor, NumeroNF, Serie: String);
var
  ZQryPedido: TZQuery;
begin
  // Antes de cancelar, deve se validar o saldo (implementar quando a procedure estiver pronta).
  ZQryPedido := TZQuery.Create(nil);

  with ZQryPedido do
  begin
    Connection := zcoConnection;
    SQL.Clear;
    SQL.Add('update tbentrada set sstatus = ''I'', idusuarioultalt = :idusuarioultalt, datahoraultalt = now()');
    SQL.Add('where fornecedor  = :fornecedor');
    SQL.Add('and numero  = :numero');
    SQL.Add('and serie  = :serie');

    ParamByName('fornecedor').AsInteger := StrToInt(Fornecedor);
    ParamByName('numero').AsInteger := StrToInt(NumeroNF);
    ParamByName('serie').AsString := Serie;
    ParamByName('idusuarioultalt').AsInteger := vIdUsuario;
    ExecSQL;
  end;
  FreeAndNil(ZQryPedido);
end;

end.
