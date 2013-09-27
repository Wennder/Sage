unit uNF;

interface

uses ZConnection, ZDataset, SysUtils, uConstantes, Classes, Contnrs, uProcedimentosBanco, uExceptions, Variants, Forms,
  Dialogs, Windows, Datasnap.DBClient, UsoGeral, Vcl.FileCtrl, Data.DB, Vcl.StdCtrls, Vcl.Controls;

type
  TResult = array of string;

type
  TNf = class
  public
    constructor Create(pzcoConnection: TZConnection);
    destructor Destroy; override;

    function GetiCodigo: Variant;
    function GetiEmpresa: Variant;
    function GetiNotaFiscal: Variant;
    function GetsChave: Variant;
    function GetsLote: Variant;
    function GetsSituacao: Variant;
    function GetdDataEnvio: Variant;

    procedure SetiCodigo(pParametro: Variant);
    procedure SetiEmpresa(pParametro: Variant);
    procedure SetiNotaFiscal(pParametro: Variant);
    procedure SetsChave(pParametro: Variant);
    procedure SetsLote(pParametro: Variant);
    procedure SetsSituacao(pParametro: Variant);
    procedure SetdDataEnvio(pParametro: Variant);

    function GetUltimoCodigo(pEmpresa: Integer; pIncrementa: Boolean = True): Variant;

  private
    zcoConnection: TZConnection;

    icodigo: Variant;
    iempresa: Variant;
    inotafiscal: Variant;
    schave: Variant;
    slote: Variant;
    ssituacao: Variant;
    ddataenvio: Variant;

  Var
    qrNF, qrEmpresa, qrCliente: TZQuery;
  end;

implementation

{ TNf }

constructor TNf.Create(pzcoConnection: TZConnection);
begin
  zcoConnection := pzcoConnection;

  qrNF := TZQuery.Create(nil);
  qrNF.Connection := zcoConnection;
  qrNF.Close;

  qrEmpresa := TZQuery.Create(nil);
  qrEmpresa.Connection := zcoConnection;
  qrEmpresa.Close;

  qrCliente := TZQuery.Create(nil);
  qrCliente.Connection := zcoConnection;
  qrCliente.Close;
end;

destructor TNf.Destroy;
begin
  FreeAndNil(qrNF);
  FreeAndNil(qrEmpresa);
  FreeAndNil(qrCliente);
  inherited;
end;

function TNf.GetdDataEnvio: Variant;
begin
  Result := ddataenvio;
end;

function TNf.GetiCodigo: Variant;
begin
  Result := icodigo;
end;

function TNf.GetiEmpresa: Variant;
begin
  Result := iempresa;
end;

function TNf.GetiNotaFiscal: Variant;
begin
  Result := inotafiscal;
end;

function TNf.GetsChave: Variant;
begin
  Result := schave;
end;

function TNf.GetsLote: Variant;
begin
  Result := slote;
end;

function TNf.GetsSituacao: Variant;
begin
  Result := ssituacao;
end;

function TNf.GetUltimoCodigo(pEmpresa: Integer; pIncrementa: Boolean = True): Variant;
Var
  pQuery: TZQuery;
begin
  try
    Result := 0;
    pQuery := TZQuery.Create(nil);
    with pQuery do
    begin
      Connection := zcoConnection;
      Close;
      Sql.Clear;
      if pIncrementa then
        Sql.Add('select coalesce(max(inotafiscal),0)+1 as inotafiscal from tbnotafiscal')
      else
        Sql.Add('select coalesce(max(inotafiscal),0) as inotafiscal from tbnotafiscal');
      Sql.Add('where iempresa = :iempresa');

      ParamByName('iempresa').Value := pEmpresa;
      Open;
      if not isEmpty then
        Result := FieldByName('inotafiscal').Value;
    end;
  finally
    FreeAndNil(pQuery);
  end;
end;

procedure TNf.SetdDataEnvio(pParametro: Variant);
begin
  ddataenvio := pParametro;
end;

procedure TNf.SetiCodigo(pParametro: Variant);
begin
  icodigo := pParametro;
end;

procedure TNf.SetiEmpresa(pParametro: Variant);
begin
  iempresa := pParametro;
end;

procedure TNf.SetiNotaFiscal(pParametro: Variant);
begin
  inotafiscal := pParametro;
end;

procedure TNf.SetsChave(pParametro: Variant);
begin
  schave := pParametro;
end;

procedure TNf.SetsLote(pParametro: Variant);
begin
  slote := pParametro;
end;

procedure TNf.SetsSituacao(pParametro: Variant);
begin
  ssituacao := pParametro;
end;

end.
