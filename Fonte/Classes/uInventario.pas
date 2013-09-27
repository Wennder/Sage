unit uInventario;

interface

uses ZConnection, ZDataset, SysUtils, uConstantes, Classes, Contnrs, uProcedimentosBanco, uExceptions, Variants, Forms,
  Dialogs, Windows, Datasnap.DBClient, UsoGeral, Vcl.FileCtrl, Data.DB, Vcl.StdCtrls, Vcl.Controls, uEmpresa;

type
  TInventario = class
  public
    constructor Create(pzcoConnection: TZConnection);
    destructor Destroy; override;

    function GetiCodigo: Variant;
    function Getddataoperacao: Variant;
    function Getsstatus: Variant;
    function Getidusuariocad: Variant;
    function Getidusuarioultalt: Variant;
    function Getdatahoraultalt: Variant;
    function Getdatafechamento: Variant;

    procedure SetiCodigo(pParametro: Variant);
    procedure Setddataoperacao(pParametro: Variant);
    procedure Setsstatus(pParametro: Variant);
    procedure Setidusuariocad(pParametro: Variant);
    procedure Setidusuarioultalt(pParametro: Variant);
    procedure Setdatahoraultalt(pParametro: Variant);
    procedure Setdatafechamento(pParametro: Variant);

    function ConsultaInventario(pCodigo: Integer; pObj: TObject = Nil): boolean;
    function IncluiInventario: boolean;
    function AlteraInventario: boolean;
    function ExcluiInventario: boolean;
    procedure LimpaAtributosInv;
    function FechaInventario(pcds: TClientDataSet; pInventario: Integer): Integer; { 0 = Falso, 1 = True, 2 = Vazio }
    function CalculaDiferenca(pProduto, pQtdContada: Variant): Variant;
    function iRetornaUltimoCodigo: Variant;
  private
    zcoConnection: TZConnection;

    icodigo: Variant;
    ddataoperacao: Variant;
    sstatus: Variant; { A = Aberto / F = Fechado / I= Inativo }
    idusuariocad: Variant;
    idusuarioultalt: Variant;
    datahoraultalt: Variant;
    datafechamento: Variant;
    iEmpresa: Variant;
  end;

type
  TInventarioItem = class
  public
    constructor Create(pzcoConnection: TZConnection);
    destructor Destroy; override;

    function GetiCodigoItm: Variant;
    function GetiInventario: Variant;
    function GetiProduto: Variant;
    function GetsProduto: Variant;
    function GetnQtdContada: Variant;
    function GetnDiferenca: Variant;

    procedure SetiCodigoItm(pParametro: Variant);
    procedure SetiInventario(pParametro: Variant);
    procedure SetiProduto(pParametro: Variant);
    procedure SetsProduto(pParametro: Variant);
    procedure SetnQtdContada(pParametro: Variant);
    procedure SetnDiferenca(pParametro: Variant);

    procedure ConsultaInventarioItem(pcds: TClientDataSet; pCodigoInventario: Integer);
    procedure FiltraListaItem(pcds: TClientDataSet; pFiltro: String);

    function AdicionaItemLista(pcds: TClientDataSet; pDML: String): boolean;
    function RemoveItemLista(pcds: TClientDataSet; pDML: String): boolean;
    function EditaItemLista(pcds: TClientDataSet; pDML: String): boolean;

    function IncluiItemInventario(pcds: TClientDataSet): boolean;
    function AlteraItemInventario(pcds: TClientDataSet): boolean;
    function ExcluiItemInventario(pcds: TClientDataSet): boolean;
    procedure LimpaAtributosInvItm;
  private
    zcoConnection: TZConnection;

    icodigoItm: Variant;
    iinventario: Variant;
    iproduto: Variant;
    sproduto: Variant;
    nqtdcontada: Variant;
    ndiferenca: Variant;
  end;

implementation

{ TInventario }

function TInventario.AlteraInventario: boolean;
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
        Sql.Add('update tbinventario set ');
        Sql.Add('sstatus = :sstatus, idusuarioultalt = :idusuarioultalt, datahoraultalt = :datahoraultalt');
        Sql.Add('where icodigo = :icodigo');
        Sql.Add('and iempresa = :iempresa');

        ParamByName('icodigo').Value := GetiCodigo;
        ParamByName('iempresa').Value := oEmpresaPrincipal.Getiempresa;
        ParamByName('sstatus').Value := Getsstatus;
        ParamByName('idusuarioultalt').Value := Getidusuarioultalt;
        ParamByName('datahoraultalt').Value := Getdatahoraultalt;
        ExecSQL;
        Result := true;
      end;
    except
      on E: Exception do
      begin
        pMsgAtencao('Problemas na Gravação: Não foi alterar o inventário.' + #13 +
          'Verifique os detalhes do erro e contate o suporte para transmitir o problema.', 'Mensagem original: ' + #13 + E.Message);
        Abort;
      end;
    end;
  finally
    FreeAndNil(pQuery);
  end;
end;

function TInventario.CalculaDiferenca(pProduto, pQtdContada: Variant): Variant;
begin
  Result := pQtdContada - 0;
end;

function TInventario.ConsultaInventario(pCodigo: Integer; pObj: TObject = Nil): boolean;
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
      Sql.Add('select * from vwinventario');
      Sql.Add(' where icodigo = :icodigo');
      Sql.Add(' and iempresa = :iempresa');

      ParamByName('icodigo').Value := pCodigo;
      ParamByName('iEmpresa').Value := oEmpresaPrincipal.Getiempresa;

      Open;
      if Not isEmpty then
      begin
        SetiCodigo(fieldbyname('iCodigo').Value);
        Setddataoperacao(fieldbyname('ddataoperacao').Value);
        Setsstatus(fieldbyname('sstatus').Value);
        Setidusuariocad(fieldbyname('idusuariocad').Value);

        if not fieldbyname('idusuarioultalt').IsNull then
          Setidusuarioultalt(fieldbyname('idusuarioultalt').Value);

        if not fieldbyname('datahoraultalt').IsNull then
          Setdatahoraultalt(fieldbyname('datahoraultalt').Value);

        if not fieldbyname('ddatafechamento').IsNull then
          Setdatahoraultalt(fieldbyname('ddatafechamento').Value);

        Result := true;
      end
      else
      begin
        LimpaAtributosInv;

        Result := false;
        if pObj <> Nil then
        begin
          pMsgAtencao('Inventário não encontrado!');
          TWinControl(pObj).SetFocus;
          Abort;
        end;
      end;
    end;
  finally
    FreeAndNil(pQuery);
  end;
end;

constructor TInventario.Create(pzcoConnection: TZConnection);
begin
  zcoConnection := pzcoConnection;
  Setsstatus('A');
end;

destructor TInventario.Destroy;
begin

  inherited;
end;

function TInventario.ExcluiInventario: boolean;
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
        Sql.Add('update tbinventario set ');
        Sql.Add('sstatus = :sstatus, idusuarioultalt = :idusuarioultalt, datahoraultalt = :datahoraultalt');
        Sql.Add('where icodigo = :icodigo');
        Sql.Add('and iempresa = :iempresa');

        ParamByName('icodigo').Value := GetiCodigo;
        ParamByName('iempresa').Value := oEmpresaPrincipal.Getiempresa;
        ParamByName('sstatus').Value := Getsstatus;
        ParamByName('idusuarioultalt').Value := Getidusuarioultalt;
        ParamByName('datahoraultalt').Value := Getdatahoraultalt;
        ExecSQL;
        Result := true;
      end;
    except
      on E: Exception do
      begin
        pMsgAtencao('Problemas na Operação: Não foi excluir o inventário.' + #13 +
          'Verifique os detalhes do erro e contate o suporte para transmitir o problema.', 'Mensagem original: ' + #13 + E.Message);
        Abort;
      end;
    end;
  finally
    FreeAndNil(pQuery);
  end;
end;

function TInventario.FechaInventario(pcds: TClientDataSet; pInventario: Integer): Integer;
Var
  pQuery: TZQuery;
begin
  try
    try
      { 0 = Falso, 1 = True, 2 = Vazio }
      Result := 0;
      pQuery := TZQuery.Create(nil);
      with pQuery do
      begin
        Connection := zcoConnection;
        Close;

        { Grava diferença dos produtos Qtd Contada - Saldo em Estoque }
        pcds.Filtered := false;
        if not pcds.isEmpty then
        begin
          pcds.First;
          while not pcds.Eof do
          begin
            pQuery.Sql.Clear;
            pQuery.Sql.Add('update tbinventarioitens set ndiferenca = :diferenca');
            pQuery.Sql.Add(' where iproduto = :iproduto');
            pQuery.Sql.Add('   and iinventario = :iinventario');

            pQuery.ParamByName('diferenca').Value := CalculaDiferenca(pcds.fieldbyname('iproduto').Value, pcds.fieldbyname('nqtdcontada').Value);
            pQuery.ParamByName('iproduto').Value := pcds.fieldbyname('iproduto').Value;
            pQuery.ParamByName('iinventario').Value := pcds.fieldbyname('iinventario').Value;
            pQuery.ExecSQL;
            pcds.Next;
          end;
          { Fecha inventário após a alteração da diferença de todos os produtos. }
          SetiCodigo(pInventario);
          Setsstatus('F');
          if AlteraInventario then
            Result := 1;
        end
        else
          Result := 2;
      end;
    except
      on E: Exception do
      begin
        pMsgAtencao('Problemas na Gravação: Não foi fechar o inventário.' + #13 +
          'Verifique os detalhes do erro e contate o suporte para transmitir o problema.', 'Mensagem original: ' + #13 + E.Message);
        Abort;
      end;
    end;
  finally
    FreeAndNil(pQuery);
  end;
end;

function TInventario.Getdatafechamento: Variant;
begin
  Result := datafechamento;
end;

function TInventario.Getdatahoraultalt: Variant;
begin
  Result := datahoraultalt;
end;

function TInventario.Getddataoperacao: Variant;
begin
  Result := ddataoperacao;
end;

function TInventario.GetiCodigo: Variant;
begin
  Result := icodigo;
end;

function TInventario.Getidusuariocad: Variant;
begin
  Result := idusuariocad;
end;

function TInventario.Getidusuarioultalt: Variant;
begin
  Result := idusuarioultalt;
end;

function TInventario.Getsstatus: Variant;
begin
  Result := sstatus;
end;

function TInventario.IncluiInventario: boolean;
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
        Sql.Add('insert into tbinventario(icodigo, ddataoperacao, sstatus, idusuariocad, idusuarioultalt, datahoraultalt, iEmpresa)');
        Sql.Add('values(:icodigo, :ddataoperacao, :sstatus, :idusuariocad, null, null, :iEmpresa)');

        ParamByName('icodigo').Value := GetiCodigo;
        ParamByName('ddataoperacao').Value := Getddataoperacao;
        ParamByName('sstatus').Value := Getsstatus;
        ParamByName('idusuariocad').Value := Getidusuariocad;
        ParamByName('iempresa').Value := oEmpresaPrincipal.Getiempresa;
        ExecSQL;
        Result := true;
      end;
    except
      on E: Exception do
      begin
        pMsgAtencao('Problemas na Gravação: Não foi incluir o inventário.' + #13 +
          'Verifique os detalhes do erro e contate o suporte para transmitir o problema.', 'Mensagem original: ' + #13 + E.Message);
        Abort;
      end;
    end;
  finally
    FreeAndNil(pQuery);
  end;
end;

function TInventario.iRetornaUltimoCodigo: Variant;
var
  ZQryRamoAtividade: TZQuery;
begin
  ZQryRamoAtividade := TZQuery.Create(nil);
  with ZQryRamoAtividade do
  begin
    Connection := zcoConnection;
    Sql.Clear;
    Sql.Add('SELECT COALESCE(MAX(icodigo),0) + 1 AS ULTIMO FROM tbinventario');
    Open;
    Result := fieldbyname('ULTIMO').AsInteger;
  end;
  FreeAndNil(ZQryRamoAtividade);
end;

procedure TInventario.LimpaAtributosInv;
begin
  SetiCodigo(-1);
  Setddataoperacao(Null);
  Setsstatus('A');
  Setidusuariocad(Null);
  Setidusuarioultalt(Null);
  Setdatahoraultalt(Null);
  Setdatafechamento(Null);
end;

procedure TInventario.Setdatafechamento(pParametro: Variant);
begin
  datafechamento := pParametro;
end;

procedure TInventario.Setdatahoraultalt(pParametro: Variant);
begin
  datahoraultalt := pParametro;
end;

procedure TInventario.Setddataoperacao(pParametro: Variant);
begin
  ddataoperacao := pParametro;
end;

procedure TInventario.SetiCodigo(pParametro: Variant);
begin
  icodigo := pParametro;
end;

procedure TInventario.Setidusuariocad(pParametro: Variant);
begin
  idusuariocad := pParametro;
end;

procedure TInventario.Setidusuarioultalt(pParametro: Variant);
begin
  idusuarioultalt := pParametro;
end;

procedure TInventario.Setsstatus(pParametro: Variant);
begin
  sstatus := pParametro;
end;

{ TInventarioItem }

function TInventarioItem.AdicionaItemLista(pcds: TClientDataSet; pDML: String): boolean;
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
      FindField('iInventario').Value := GetiInventario;
      FindField('iProduto').Value := GetiProduto;
      FindField('sProduto').Value := GetsProduto;
      FindField('nQtdContada').Value := GetnQtdContada;
      FindField('nDiferenca').Value := GetnDiferenca;
      Post;
      Result := true;
    end;
  end;
end;

function TInventarioItem.AlteraItemInventario(pcds: TClientDataSet): boolean;
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
        pcds.First;
        while not pcds.Eof do
        begin
          Sql.Clear;
          Sql.Add('update tbinventarioitens set ');
          Sql.Add('nqtdcontada = :nqtdcontada, ndiferenca = :ndiferenca');
          Sql.Add('where icodigo = :icodigo');

          ParamByName('icodigo').Value := pcds.FindField('iCodigo').Value;
          ParamByName('nqtdcontada').Value := pcds.FindField('nQtdContada').Value;
          ParamByName('ndiferenca').Value := pcds.FindField('nDiferenca').Value;
          ExecSQL;
          pcds.Next;
        end;
        Result := true;
      end;
    except
      on E: Exception do
      begin
        pMsgAtencao('Problemas na Gravação: Não foi alterar o item de inventário.' + #13 +
          'Verifique os detalhes do erro e contate o suporte para transmitir o problema.', 'Mensagem original: ' + #13 + E.Message);
        Abort;
      end;
    end;
  finally
    FreeAndNil(pQuery);
  end;
end;

procedure TInventarioItem.ConsultaInventarioItem(pcds: TClientDataSet; pCodigoInventario: Integer);
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
      Sql.Add('select * from vwinventarioitens');
      Sql.Add(' where iinventario = :iinventario');

      ParamByName('iinventario').Value := pCodigoInventario;
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
          SetiInventario(fieldbyname('iinventario').Value);
          SetiProduto(fieldbyname('iProduto').Value);
          SetsProduto(fieldbyname('nmprodutocommarca').Value);
          SetnQtdContada(fieldbyname('nqtdcontada').Value);
          SetnDiferenca(fieldbyname('ndiferenca').Value);

          AdicionaItemLista(pcds, 'X');
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

constructor TInventarioItem.Create(pzcoConnection: TZConnection);
begin
  zcoConnection := pzcoConnection;
end;

destructor TInventarioItem.Destroy;
begin

  inherited;
end;

function TInventarioItem.EditaItemLista(pcds: TClientDataSet; pDML: String): boolean;
begin
  with pcds do
  begin
    if FindField('DML').Value <> 'I' then
    begin
      if not(State in [dsEdit]) then
        Edit;
      FindField('DML').Value := pDML;
    end;
  end;
end;

function TInventarioItem.ExcluiItemInventario(pcds: TClientDataSet): boolean;
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
        pcds.First;
        while not pcds.Eof do
        begin
          Sql.Clear;
          Sql.Add('delete from tbinventarioitens');
          Sql.Add('where icodigo = :icodigo');

          ParamByName('icodigo').Value := pcds.FindField('iCodigo').Value;
          ExecSQL;
          pcds.Next;
        end;
        Result := true;
      end;
    except
      on E: Exception do
      begin
        pMsgAtencao('Problemas na Operação: Não foi excluir o item de inventário.' + #13 +
          'Verifique os detalhes do erro e contate o suporte para transmitir o problema.', 'Mensagem original: ' + #13 + E.Message);
        Abort;
      end;
    end;
  finally
    FreeAndNil(pQuery);
  end;
end;

procedure TInventarioItem.FiltraListaItem(pcds: TClientDataSet; pFiltro: String);
begin
  with pcds do
  begin
    Filter := '';
    Filtered := false;
    Filter := pFiltro;
    Filtered := true;
  end;
end;

function TInventarioItem.GetiCodigoItm: Variant;
begin
  Result := icodigoItm;
end;

function TInventarioItem.GetiInventario: Variant;
begin
  Result := iinventario;
end;

function TInventarioItem.GetiProduto: Variant;
begin
  Result := iproduto;
end;

function TInventarioItem.GetnDiferenca: Variant;
begin
  Result := ndiferenca;
end;

function TInventarioItem.GetnQtdContada: Variant;
begin
  Result := nqtdcontada;
end;

function TInventarioItem.GetsProduto: Variant;
begin
  Result := sproduto;
end;

function TInventarioItem.IncluiItemInventario(pcds: TClientDataSet): boolean;
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
        pcds.First;
        while not pcds.Eof do
        begin
          Sql.Clear;
          Sql.Add('insert into tbinventarioitens(iinventario, iproduto, nqtdcontada, ndiferenca)');
          Sql.Add('values(:iinventario, :iproduto, :nqtdcontada, :ndiferenca)');

          ParamByName('iinventario').Value := pcds.FindField('iInventario').Value;
          ParamByName('iproduto').Value := pcds.FindField('iProduto').Value;
          ParamByName('nqtdcontada').Value := pcds.FindField('nQtdContada').Value;
          ParamByName('ndiferenca').Value := pcds.FindField('nDiferenca').Value;
          ExecSQL;
          pcds.Next;
        end;
        Result := true;
      end;
    except
      on E: Exception do
      begin
        pMsgAtencao('Problemas na Gravação: Não foi incluir o item de inventário.' + #13 +
          'Verifique os detalhes do erro e contate o suporte para transmitir o problema.', 'Mensagem original: ' + #13 + E.Message);
        Abort;
      end;
    end;
  finally
    FreeAndNil(pQuery);
  end;
end;

procedure TInventarioItem.LimpaAtributosInvItm;
begin
  SetiCodigoItm(Null);
  SetiInventario(Null);
  SetiProduto(Null);
  SetsProduto(Null);
  SetnQtdContada(0);
  SetnDiferenca(0);
end;

function TInventarioItem.RemoveItemLista(pcds: TClientDataSet; pDML: String): boolean;
begin
  with pcds do
  begin
    Edit;
    FindField('DML').Value := pDML;
    Post;
    FiltraListaItem(pcds, 'DML <> ''E''');
  end;
end;

procedure TInventarioItem.SetiCodigoItm(pParametro: Variant);
begin
  icodigoItm := pParametro;
end;

procedure TInventarioItem.SetiInventario(pParametro: Variant);
begin
  iinventario := pParametro;
end;

procedure TInventarioItem.SetiProduto(pParametro: Variant);
begin
  iproduto := pParametro;
end;

procedure TInventarioItem.SetnDiferenca(pParametro: Variant);
begin
  ndiferenca := pParametro;
end;

procedure TInventarioItem.SetnQtdContada(pParametro: Variant);
begin
  nqtdcontada := pParametro;
end;

procedure TInventarioItem.SetsProduto(pParametro: Variant);
begin
  sproduto := pParametro;
end;

end.
