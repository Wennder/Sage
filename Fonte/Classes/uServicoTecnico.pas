unit uServicoTecnico;

interface

uses ZConnection, ZDataset, SysUtils, uConstantes, Classes, uProcedimentosBanco, uExceptions, Variants, Forms,
     Dialogs, Windows, uSubGrupo, uMarca, uUnidade, Contnrs, uProduto;

type
  TListaServicoTecnico = class
  private
    zcoConnection: TZConnection;
  public
    oServicoTecnico: TObjectList;
    constructor Create(pzcoConnection: TZConnection);
    destructor Destroy; override;
    function AlimentaLista(iPedido:Integer): Integer;
    function Count: Integer;

  end;

  TServicoTecnico = class
  public
    oProduto: TProduto;
    procedure SetCodigo(piCodigo: Integer);
    procedure SetPedido(piPedido: Integer);
    procedure SetServico(piServico: Integer);
    procedure SetTecnico(piTecnico: Integer);
    procedure SetComissao(pnComissao: Real);
    procedure SetValorServico(pnValorServico: Real);
    procedure SetValorComissao(pnValorComissao: Real);

    function GetiCodigo: Integer;
    function GetiPedido: Integer;
    function GetiServico: Integer;
    function GetiTecnico: Integer;
    function GetnComissao: Real;
    function GetnValorServico: Real;
    function GetnValorComissao: Real;

    function iRetornaUltimoCodigo: Integer;
    constructor Create(pzcoConnection: TZConnection);
    destructor Destroy; override;
    procedure Cadastra;
  private
    zcoConnection: TZConnection;
    iCodigo: Integer;
    iPedido: Integer;
    iServico: Integer;
    iTecnico: Integer;
    nComissao: Real;
    nValorServico: Real;
    nValorComissao: Real;
  end;

implementation

uses ZAbstractDataset, ZAbstractRODataset, uGrupo, DB;

{ TServicoTecnico }

procedure TServicoTecnico.Cadastra;
var
  ZQry: TZQuery;
begin
  ZQry := TZQuery.Create(nil);
  with ZQry do
  begin
    SetCodigo(iRetornaUltimoCodigo+1);
    Connection := zcoConnection;
    SQL.Clear;
    SQL.Add('delete from TbServicoTecnico');
    SQL.Add('WHERE iPedido = :iPedido and iServico = :iServico');
    ParamByName('iPedido').AsInteger       := GetiPedido;
    ParamByName('iServico').AsInteger      := GetiServico;
    ExecSQL;
    SQL.Clear;
    SQL.Add('INSERT INTO TbServicoTecnico(');
    SQL.Add(' iCodigo,');
    SQL.Add(' iPedido,');
    SQL.Add(' iServico,');
    SQL.Add(' iTecnico,');
    SQL.Add(' nComissao,');
    SQL.Add(' nValorServico, ');
    SQL.Add(' nValorComissao)');
    SQL.Add('VALUES(');
    SQL.Add(' :iCodigo,');
    SQL.Add(' :iPedido,');
    SQL.Add(' :iServico,');
    SQL.Add(' :iTecnico,');
    SQL.Add(' :nComissao,');
    SQL.Add(' :nValorServico, ');
    SQL.Add(' :nValorComissao)');
    ParamByName('iCodigo').AsInteger       := GetiCodigo;
    ParamByName('iPedido').AsInteger       := GetiPedido;
    ParamByName('iServico').AsInteger      := GetiServico;
    ParamByName('iTecnico').AsInteger      := GetiTecnico;
    ParamByName('nComissao').AsFloat     := GetnComissao;
    ParamByName('nValorServico').AsFloat := GetnValorServico;
    ParamByName('nValorComissao').AsFloat:= GetnValorComissao;
    try
      ExecSQL;
    except
      on E: Exception do
      begin
        TrataErro(E.Message);
        Application.MessageBox(Pchar(E.Message),'Erro',MB_OK);
      end;
    end;
  end;
  FreeAndNil(ZQry);
end;

constructor TServicoTecnico.Create(pzcoConnection: TZConnection);
begin
  zcoConnection := pzcoConnection;
  oProduto := TProduto.Create(pzcoConnection);
end;

destructor TServicoTecnico.Destroy;
begin

  inherited;
end;

function TServicoTecnico.GetiCodigo: Integer;
begin
  Result := iCodigo;
end;

function TServicoTecnico.GetiPedido: Integer;
begin
  Result := iPedido;
end;

function TServicoTecnico.GetiServico: Integer;
begin
  Result := iServico;
end;

function TServicoTecnico.GetiTecnico: Integer;
begin
  Result := iTecnico;
end;

function TServicoTecnico.GetnComissao: Real;
begin
  Result := nComissao;
end;

function TServicoTecnico.GetnValorComissao: Real;
begin
  Result := nValorComissao;
end;

function TServicoTecnico.GetnValorServico: Real;
begin
  Result:= nValorServico;
end;


function TServicoTecnico.iRetornaUltimoCodigo: Integer;
var
  ZQry: TZQuery;
begin
  ZQry := TZQuery.Create(nil);
  with ZQry do
  begin
    Connection := zcoConnection;
    SQL.Clear;
    SQL.Add('SELECT COALESCE(MAX(icodigo),0) AS ULTIMO FROM TbServicoTecnico');
    Open;
    Result := FieldByName('ULTIMO').AsInteger;
  end;
  FreeAndNil(ZQry);
end;

procedure TServicoTecnico.SetCodigo(piCodigo: Integer);
begin
  iCodigo := piCodigo;
end;

procedure TServicoTecnico.SetComissao(pnComissao: Real);
begin
  nComissao := pnComissao;
end;

procedure TServicoTecnico.SetPedido(piPedido: Integer);
begin
  iPedido := piPedido;
end;

procedure TServicoTecnico.SetServico(piServico: Integer);
begin
  iServico := piServico;
end;

procedure TServicoTecnico.SetTecnico(piTecnico: Integer);
begin
  iTecnico := piTecnico;
end;

procedure TServicoTecnico.SetValorComissao(pnValorComissao: Real);
begin
  nValorComissao := pnValorComissao;
end;

procedure TServicoTecnico.SetValorServico(pnValorServico: Real);
begin
  nValorServico := pnValorServico;
end;

{ TListaServicoTecnico }

function TListaServicoTecnico.AlimentaLista(iPedido: Integer): Integer;
var
  Qry: TZQuery;
  iIndice: Integer;
begin
  Qry := TZQuery.Create(nil);
  with Qry do begin
    Connection := zcoConnection;
    SQL.Clear;
    SQL.Add('SELECT TbPedidoItens.iProduto, TbPedidoItens.nValor * TbPedidoItens.nquantidade as Valor');
    SQL.Add('FROM TbPedido');
    SQL.Add('JOIN TbPedidoItens ON TbPedidoItens.iPedido = TbPedido.iCodigo');
    SQL.Add('JOIN tbProduto ON TbProduto.iCodigo = tbPedidoItens.iProduto');
    SQL.Add('WHERE tbPedido.iCodigo = :iPedido');
    SQL.Add('AND tbProduto.sServico = ''S''');
    ParamByName('iPedido').AsInteger := iPedido;
    Open;
    if not IsEmpty then begin
      while not Eof do begin
        iIndice := oServicoTecnico.Add(TServicoTecnico.Create(zcoConnection));
        TServicoTecnico(oServicoTecnico.Items[iIndice]).SetPedido(iPedido);
        TServicoTecnico(oServicoTecnico.Items[iIndice]).SetServico(FieldByName('iProduto').AsInteger);
        TServicoTecnico(oServicoTecnico.Items[iIndice]).SetValorServico(FieldByName('Valor').AsFloat);
        Next;
      end;
    end;
  end;
  Result := oServicoTecnico.Count;
end;

function TListaServicoTecnico.Count: Integer;
begin
  Result := oServicoTecnico.Count;
end;

constructor TListaServicoTecnico.Create(pzcoConnection: TZConnection);
begin
  zcoConnection := pzcoConnection;
  oServicoTecnico := TObjectList.Create;
end;

destructor TListaServicoTecnico.Destroy;
begin
  FreeAndNil(oServicoTecnico);
  inherited;
end;

end.
