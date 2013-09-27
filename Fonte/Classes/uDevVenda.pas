unit uDevVenda;

interface

uses ZConnection, ZDataset, SysUtils, uConstantes, Classes, Contnrs, uProcedimentosBanco, uExceptions, Variants, Forms,
  Dialogs, Windows, Datasnap.DBClient, UsoGeral, Vcl.FileCtrl, Data.DB, Vcl.StdCtrls, Vcl.Controls;

type
  TResult = array of string;

type
  TDevVenda = class
  public
    constructor Create(pzcoConnection: TZConnection);
    destructor Destroy; override;

    function GetiCodigo: Variant;
    function GetiEmpresa: Variant;
    function Getddataoperacao: Variant;
    function Getsstatus: Variant;
    function Getidusuariocad: Variant;
    function Getidusuarioultalt: Variant;
    function Getdatahoraultalt: Variant;
    function GetiNaturezaOp: Variant;
    function GetiCfop: Variant;
    function GetiPedido: Variant;
    function GetsObservacao: Variant;
    function GetsCliente: Variant;

    procedure SetiCodigo(pParametro: Variant);
    procedure SetiEmpresa(pParametro: Variant);
    procedure Setddataoperacao(pParametro: Variant);
    procedure Setsstatus(pParametro: Variant);
    procedure Setidusuariocad(pParametro: Variant);
    procedure Setidusuarioultalt(pParametro: Variant);
    procedure Setdatahoraultalt(pParametro: Variant);
    procedure SetiNaturezaOp(pParametro: Variant);
    procedure SetiCfop(pParametro: Variant);
    procedure SetiPedido(pParametro: Variant);
    procedure SetsObservacao(pParametro: Variant);
    procedure SetsCliente(pParametro: Variant);

    function ConsultaDevVenda(pCodigo: Integer; pObj: TObject = Nil): boolean;
    function IncluiDevVenda(pcds: Tclientdataset): TResult;
    function CancelaDevVenda: boolean;
    procedure LimpaAtributosDevVenda;
    function iRetornaUltimoCodigo(pIncrementa: boolean = true): Variant;
  private
    zcoConnection: TZConnection;

    icodigo: Variant;
    iempresa: Variant;
    ddataoperacao: Variant;
    sstatus: Variant; { A = Aberto / I= Inativo, Cancelado }
    idusuariocad: Variant;
    idusuarioultalt: Variant;
    datahoraultalt: Variant;
    iNaturezaOp: Variant;
    iCfop: Variant;
    iPedido: Variant;
    sObservacao: Variant;
    sCliente: Variant;
  end;

type
  TDevVendaItem = class
  public
    constructor Create(pzcoConnection: TZConnection);
    destructor Destroy; override;

    function GetiCodigoItm: Variant;
    function GetiDevVenda: Variant;
    function GetiProduto: Variant;
    function GetsProduto: Variant;
    function GetnQtdDevolvida: Variant;
    function GetnQtdDevolver: Variant;
    function GetnQtdVendido: Variant;

    procedure SetiCodigoItm(pParametro: Variant);
    procedure SetiDevVenda(pParametro: Variant);
    procedure SetiProduto(pParametro: Variant);
    procedure SetsProduto(pParametro: Variant);
    procedure SetnQtdDevolvida(pParametro: Variant);
    procedure SetnQtdDevolver(pParametro: Variant);
    procedure SetnQtdVendido(pParametro: Variant);

    procedure ConsultaPedidoItem(pcds: Tclientdataset; piPedido: Integer);
    procedure FiltraListaItem(pcds: Tclientdataset; pFiltro: String);

    function AdicionaItemLista(pcds: Tclientdataset; pDML: String): boolean;
    function RemoveItemLista(pcds: Tclientdataset; pDML: String): boolean;
    function EditaItemLista(pcds: Tclientdataset; pDML: String): boolean;

    procedure LimpaAtributosDevVendaItm;
  private
    zcoConnection: TZConnection;

    icodigoItm: Variant;
    idevvenda: Variant;
    iproduto: Variant;
    sproduto: Variant;
    nqtddevolvida: Variant;
    nqtdDevolver: Variant;
    nqtdvendido: Variant;
  end;

implementation

{ TDevVenda }

function TDevVenda.ConsultaDevVenda(pCodigo: Integer; pObj: TObject = Nil): boolean;
Var
  pQuery: TZQuery;
begin
  try
    Result := false;
    pQuery := TZQuery.Create(nil);
    with pQuery do
    begin
      Connection := zcoConnection;
      Close;
      Sql.Clear;
      Sql.Add('select * from vwDevolucaoVenda');
      Sql.Add(' where icodigo = :icodigo');

      ParamByName('icodigo').Value := pCodigo;
      Open;
      if Not isEmpty then
      begin
        SetiCodigo(fieldbyname('iCodigo').Value);
        Setddataoperacao(fieldbyname('ddataoperacao').Value);
        Setsstatus(fieldbyname('sstatus').Value);
        Setidusuariocad(fieldbyname('idusuariocad').Value);
        SetsCliente(fieldbyname('sCliente').Value);

        if not fieldbyname('idusuarioultalt').IsNull then
          Setidusuarioultalt(fieldbyname('idusuarioultalt').Value);

        if not fieldbyname('datahoraultalt').IsNull then
          Setdatahoraultalt(fieldbyname('datahoraultalt').Value);

        SetiNaturezaOp(fieldbyname('iNaturezaOp').Value);
        SetiCfop(fieldbyname('iCfop').Value);
        SetiPedido(fieldbyname('iPedido').Value);
        SetsObservacao(fieldbyname('sObservacao').Value);

        Result := true;
      end
      else
      begin
        LimpaAtributosDevVenda;

        Result := false;
        if pObj <> Nil then
        begin
          pMsgAtencao('Devolução de Venda não encontrada!');
          TWinControl(pObj).SetFocus;
          Abort;
        end;
      end;
    end;
  finally
    FreeAndNil(pQuery);
  end;
end;

constructor TDevVenda.Create(pzcoConnection: TZConnection);
begin
  zcoConnection := pzcoConnection;
  Setsstatus('A');
end;

destructor TDevVenda.Destroy;
begin

  inherited;
end;

function TDevVenda.CancelaDevVenda: boolean;
Var
  pQuery: TZQuery;
begin
  try
    try
      Result := false;
      pQuery := TZQuery.Create(nil);
      with pQuery do
      begin
        Connection := zcoConnection;
        Close;
        Sql.Clear;
        Sql.Add('update tbdevolucaovenda set ');
        Sql.Add('sstatus = :sstatus, idusuarioultalt = :idusuarioultalt, datahoraultalt = :datahoraultalt');
        Sql.Add('where icodigo = :icodigo');
        Sql.Add('and iEmpresa = :iEmpresa');

        ParamByName('icodigo').Value := GetiCodigo;
        ParamByName('iEmpresa').Value := GetiEmpresa;
        ParamByName('sstatus').Value := Getsstatus;
        ParamByName('idusuarioultalt').Value := Getidusuarioultalt;
        ParamByName('datahoraultalt').Value := Getdatahoraultalt;
        ExecSQL;
        Result := true;
      end;
    except
      on E: Exception do
      begin
        pMsgAtencao('Problemas na Operação: Não foi cancelar a devolução de venda.' + #13 +
          'Verifique os detalhes do erro e contate o suporte para transmitir o problema.', 'Mensagem original: ' + #13 + E.Message);
        Abort;
      end;
    end;
  finally
    FreeAndNil(pQuery);
  end;
end;

function TDevVenda.Getdatahoraultalt: Variant;
begin
  Result := datahoraultalt;
end;

function TDevVenda.Getddataoperacao: Variant;
begin
  Result := ddataoperacao;
end;

function TDevVenda.GetiCfop: Variant;
begin
  Result := iCfop;
end;

function TDevVenda.GetiCodigo: Variant;
begin
  Result := icodigo;
end;

function TDevVenda.Getidusuariocad: Variant;
begin
  Result := idusuariocad;
end;

function TDevVenda.Getidusuarioultalt: Variant;
begin
  Result := idusuarioultalt;
end;

function TDevVenda.GetiEmpresa: Variant;
begin
  Result := iempresa;
end;

function TDevVenda.GetiNaturezaOp: Variant;
begin
  Result := iNaturezaOp;
end;

function TDevVenda.GetiPedido: Variant;
begin
  Result := iPedido;
end;

function TDevVenda.GetsCliente: Variant;
begin
  Result := sCliente;
end;

function TDevVenda.GetsObservacao: Variant;
begin
  Result := sObservacao;
end;

function TDevVenda.Getsstatus: Variant;
begin
  Result := sstatus;
end;

function TDevVenda.IncluiDevVenda(pcds: Tclientdataset): TResult;
Var
  pQuery: TZQuery;
begin
  try
    try
      // Configura tamanho do Array de Retorno
      SetLength(Result, 4);
      Result[0] := 'F';
      Result[1] := '';
      Result[2] := '-1';
      Result[3] := '';

      // Netureza.
      if GetiNaturezaOp = Null then
      begin
        Result[0] := 'F';
        Result[1] := 'Por favor, verifique se a Natureza de Operação para devolução foi preenchida.';
        Result[3] := 'edtNatOp';
        Exit;
      end;

      // CFOP.
      if GetiCfop = Null then
      begin
        Result[0] := 'F';
        Result[1] := 'Por favor, verifique se o CFOP para devolução foi preenchido.';
        Result[3] := 'edtCfop';
        Exit;
      end;

      if (pcds.FindField('nqtdVendida').Value - pcds.FindField('nqtdDevolvida').Value) < pcds.FindField('qtdDevolver').Value then
      begin
        Result[0] := 'F';
        Result[1] := 'Não é possível devolver uma quantidade maior do que a quantidade disponível. Verifique a Quantidade a Devolver dos itens.';
        Result[3] := 'gdrProduto';
        Exit;
      end;

      // Grava Devolução e Itens.
      pQuery := TZQuery.Create(nil);
      with pQuery do
      begin
        Connection := zcoConnection;
        Close;
        Sql.Clear;
        Sql.Add('Begin;');
        Sql.Add('insert into tbdevolucaovenda (iempresa, ddataoperacao, sstatus, idusuariocad, idusuarioultalt, datahoraultalt, inaturezaop, icfop, ipedido, sobservacao)');
        Sql.Add('values(:iempresa, :ddataoperacao, :sstatus, :idusuariocad, null, null, :inaturezaop, :icfop, :ipedido, :sobservacao);');

        pcds.First;
        while not pcds.Eof do
        begin
          // Adiciona direto o valor dos itens para inserção.
          Sql.Add('insert into tbdevolucaovendaitens(idevvenda, iproduto, nqtddevolvida)');
          Sql.Add('values((select currval(''tbdevolucaovenda_icodigo_seq'')), ' + QuotedStr(pcds.FindField('iproduto').Value) + ', ' +
            QuotedStr(pcds.FindField('qtdDevolver').Value) + ');');
          pcds.Next;
        end;
        // Caso aconteça algum erro de dados na gravação, o commit se encarrega do Rollback.
        Sql.Add('Commit;');

        ParamByName('iempresa').Value := GetiEmpresa;
        ParamByName('ddataoperacao').Value := Getddataoperacao;
        ParamByName('sstatus').Value := Getsstatus;
        ParamByName('idusuariocad').Value := Getidusuariocad;
        ParamByName('inaturezaop').Value := GetiNaturezaOp;
        ParamByName('icfop').Value := GetiCfop;
        ParamByName('ipedido').Value := GetiPedido;
        ParamByName('sobservacao').Value := GetsObservacao;

        ExecSQL;
        Result[0] := 'T';
        Result[1] := '';
        Result[2] := iRetornaUltimoCodigo(false);
        Result[3] := '';
      end;
    except
      on E: Exception do
      begin
        pMsgAtencao('Problemas na Gravação: Não foi incluir a devolução de venda.' + #13 +
          'Verifique os detalhes do erro e contate o suporte para transmitir o problema.', 'Mensagem original: ' + #13 + E.Message);
        Abort;
      end;
    end;
  finally
    FreeAndNil(pQuery);
  end;
end;

function TDevVenda.iRetornaUltimoCodigo(pIncrementa: boolean = true): Variant;
var
  ZQryRamoAtividade: TZQuery;
begin
  ZQryRamoAtividade := TZQuery.Create(nil);
  with ZQryRamoAtividade do
  begin
    Connection := zcoConnection;
    Sql.Clear;
    if pIncrementa then
      Sql.Add('SELECT COALESCE(MAX(icodigo),0) + 1 AS ULTIMO FROM tbdevolucaovenda')
    else
      Sql.Add('SELECT COALESCE(MAX(icodigo),0) AS ULTIMO FROM tbdevolucaovenda');
    Open;
    Result := fieldbyname('ULTIMO').AsInteger;
  end;
  FreeAndNil(ZQryRamoAtividade);
end;

procedure TDevVenda.LimpaAtributosDevVenda;
begin
  SetiCodigo(-1);
  Setddataoperacao(Null);
  Setsstatus('A');
  Setidusuariocad(Null);
  Setidusuarioultalt(Null);
  Setdatahoraultalt(Null);
  SetiNaturezaOp(Null);
  SetiCfop(Null);
  SetiPedido(Null);
  SetsObservacao(Null);
  SetsCliente(Null);
end;

procedure TDevVenda.Setdatahoraultalt(pParametro: Variant);
begin
  datahoraultalt := pParametro;
end;

procedure TDevVenda.Setddataoperacao(pParametro: Variant);
begin
  ddataoperacao := pParametro;
end;

procedure TDevVenda.SetiCfop(pParametro: Variant);
begin
  iCfop := pParametro;
end;

procedure TDevVenda.SetiCodigo(pParametro: Variant);
begin
  icodigo := pParametro;
end;

procedure TDevVenda.Setidusuariocad(pParametro: Variant);
begin
  idusuariocad := pParametro;
end;

procedure TDevVenda.Setidusuarioultalt(pParametro: Variant);
begin
  idusuarioultalt := pParametro;
end;

procedure TDevVenda.SetiEmpresa(pParametro: Variant);
begin
  iempresa := pParametro;
end;

procedure TDevVenda.SetiNaturezaOp(pParametro: Variant);
begin
  iNaturezaOp := pParametro;
end;

procedure TDevVenda.SetiPedido(pParametro: Variant);
begin
  iPedido := pParametro;
end;

procedure TDevVenda.SetsCliente(pParametro: Variant);
begin
  sCliente := pParametro;
end;

procedure TDevVenda.SetsObservacao(pParametro: Variant);
begin
  sObservacao := pParametro;
end;

procedure TDevVenda.Setsstatus(pParametro: Variant);
begin
  sstatus := pParametro;
end;

{ TDevVendaItem }

function TDevVendaItem.AdicionaItemLista(pcds: Tclientdataset; pDML: String): boolean;
begin
  Result := false;
  with pcds do
  begin
    if Locate('iProduto', GetiProduto, []) then
      Result := false
    else
    begin
      Insert;
      FindField('DML').Value := pDML;
      if pDML = 'X' then
        FindField('iCodigo').Value := GetiCodigoItm;
      FindField('iDevVenda').Value := GetiDevVenda;
      FindField('iProduto').Value := GetiProduto;
      FindField('sProduto').Value := GetsProduto;
      FindField('nqtdvendida').Value := GetnQtdVendido;
      FindField('nQtdDevolvida').Value := GetnQtdDevolvida;
      FindField('QtdDevolver').Value := GetnQtdDevolver;

      Post;
      Result := true;
    end;
  end;
end;

procedure TDevVendaItem.ConsultaPedidoItem(pcds: Tclientdataset; piPedido: Integer);
var
  pQuery: TZQuery;
begin
  try
    pQuery := TZQuery.Create(nil);
    with pQuery do
    begin
      Connection := zcoConnection;
      Close;
      Sql.Clear;
      Sql.Add('select * from vwDevolucaoPedidoItem');
      Sql.Add('WHERE  ipedido = :iPedido');

      ParamByName('iPedido').Value := piPedido;
      Open;

      pcds.Close;
      pcds.CreateDataSet;
      pcds.EmptyDataSet;
      pcds.Open;

      if not isEmpty then
      begin
        First;
        while not Eof do
        begin
          SetiCodigoItm(fieldbyname('icodigo').Value);
          SetiDevVenda(fieldbyname('iDevVenda').Value);
          SetiProduto(fieldbyname('iProduto').Value);
          SetsProduto(fieldbyname('nmprodutocommarca').Value);
          SetnQtdDevolvida(fieldbyname('nqtdDevolvida').Value);
          SetnQtdDevolver(fieldbyname('nqtddevolver').Value);
          SetnQtdVendido(fieldbyname('nqtdvendido').Value);

          AdicionaItemLista(pcds, 'I');
          Next;
        end;
      end
      else
      begin
        pcds.Close;
        pcds.CreateDataSet;
        pcds.EmptyDataSet;
        pcds.Open;
      end;
    end;
  finally
    FreeAndNil(pQuery);
  end;
end;

constructor TDevVendaItem.Create(pzcoConnection: TZConnection);
begin
  zcoConnection := pzcoConnection;
end;

destructor TDevVendaItem.Destroy;
begin

  inherited;
end;

function TDevVendaItem.EditaItemLista(pcds: Tclientdataset; pDML: String): boolean;
begin
  pcds.FindField('DML').Value := pDML;
end;

procedure TDevVendaItem.FiltraListaItem(pcds: Tclientdataset; pFiltro: String);
begin
  with pcds do
  begin
    if Trim(pFiltro) <> '' then
    begin
      Filter := '';
      Filter := pFiltro;
      Filtered := true;
    end
    else
    begin
      Filter := '';
      Filtered := false;
    end;
  end;
end;

function TDevVendaItem.GetiCodigoItm: Variant;
begin
  Result := icodigoItm;
end;

function TDevVendaItem.GetiDevVenda: Variant;
begin
  Result := idevvenda;
end;

function TDevVendaItem.GetiProduto: Variant;
begin
  Result := iproduto;
end;

function TDevVendaItem.GetnQtdDevolver: Variant;
begin
  Result := nqtdDevolver;
end;

function TDevVendaItem.GetnQtdDevolvida: Variant;
begin
  Result := nqtddevolvida;
end;

function TDevVendaItem.GetnQtdVendido: Variant;
begin
  Result := nqtdvendido;
end;

function TDevVendaItem.GetsProduto: Variant;
begin
  Result := sproduto;
end;

procedure TDevVendaItem.LimpaAtributosDevVendaItm;
begin
  SetiCodigoItm(-1);
  SetiDevVenda(Null);
  SetiProduto(Null);
  SetsProduto(Null);
  SetnQtdDevolvida(0);
  SetnQtdDevolver(0);
  SetnQtdVendido(0);
end;

function TDevVendaItem.RemoveItemLista(pcds: Tclientdataset; pDML: String): boolean;
begin
  with pcds do
  begin
    Edit;
    FindField('DML').Value := pDML;
    Post;
    FiltraListaItem(pcds, 'DML <> ''E''');
  end;
end;

procedure TDevVendaItem.SetiCodigoItm(pParametro: Variant);
begin
  icodigoItm := pParametro;
end;

procedure TDevVendaItem.SetiDevVenda(pParametro: Variant);
begin
  idevvenda := pParametro;
end;

procedure TDevVendaItem.SetiProduto(pParametro: Variant);
begin
  iproduto := pParametro;
end;

procedure TDevVendaItem.SetnQtdDevolver(pParametro: Variant);
begin
  nqtdDevolver := pParametro;
end;

procedure TDevVendaItem.SetnQtdDevolvida(pParametro: Variant);
begin
  nqtddevolvida := pParametro;
end;

procedure TDevVendaItem.SetnQtdVendido(pParametro: Variant);
begin
  nqtdvendido := pParametro;
end;

procedure TDevVendaItem.SetsProduto(pParametro: Variant);
begin
  sproduto := pParametro;
end;

end.
