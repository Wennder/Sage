unit uConsumidor;

interface

uses ZConnection, ZDataset, SysUtils, uConstantes, Classes, uProcedimentosBanco, uExceptions, Variants, Forms,
     Dialogs, Windows;


type
  TConsumidor = class
  public
    constructor Create(pzcoConnection: TZConnection);
    destructor Destroy;override;

    function zcoGetConnection: TZConnection;

    procedure SetiPedido(piPedido:Integer);
    procedure SetsNome(psNome: String);
    procedure SetsEndereco(psEndereco:String);
    procedure SetsBairro(psBairro: String);
    procedure SetiCidade(piCidade: Integer);
    procedure SetsCep(psCep: String);
    procedure SetsFone(psFone: String);

    function GetiPedido:Integer;
    function GetsNome: String;
    function GetsEndereco: String;
    function GetsBairro: String;
    function GetiCidade: Integer;
    function GetsCep: String;
    function GetsFone: String;

    procedure CadastraConsumidor;

  private
    iPedido: Integer;
    sNome: String;
    sEndereco: String;
    sBairro: String;
    iCidade: Integer;
    sCep: String;
    sFone :String;
    zcoConnection: TZConnection;
  end;


implementation

{ TConsumidor }

procedure TConsumidor.CadastraConsumidor;
var
  ZQry: TZQuery;
begin
  ZQry := TZQuery.Create(nil);
  with ZQry do
  begin
    Connection := zcoConnection;
    SQL.Clear;
    SQL.Add('DELETE FROM tbconsumidor WHERE iPedido = ' + IntToStr(GetiPedido));
    ExecSQL;
    SQL.Clear;
    SQL.Add('INSERT INTO tbconsumidor(');
    SQL.Add(' iPedido,');
    SQL.Add(' sNome,');
    SQL.Add(' sEndereco,');
    SQL.Add(' sBairro,');
    if GetiCidade <> 0 then
      SQL.Add(' iCidade,');
    SQL.Add(' sCep, ');
    SQL.Add(' sFone)');
    SQL.Add('VALUES(');
    SQL.Add(' :iPedido,');
    SQL.Add(' :sNome,');
    SQL.Add(' :sEndereco,');
    SQL.Add(' :sBairro,');
    if GetiCidade <> 0 then
      SQL.Add(' :iCidade,');
    SQL.Add(' :sCep, ');
    SQL.Add(' :sFone) ');
    ParamByName('iPedido').AsInteger   := GetiPedido;
    ParamByName('sNome').AsString     := GetsNome;
    ParamByName('sEndereco').AsString := GetsEndereco;
    ParamByName('sBairro').AsString    := GetsBairro;
    if GetiCidade <> 0 then
      ParamByName('iCidade').AsInteger  := GetiCidade;
    ParamByName('sCep').AsString     := GetsCep;
    ParamByName('sFone').AsString   := GetsFone;
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


constructor TConsumidor.Create(pzcoConnection: TZConnection);
begin
  inherited Create;
  zcoConnection:=pzcoConnection;
end;

destructor TConsumidor.Destroy;
begin

  inherited;
end;

function TConsumidor.GetiCidade: Integer;
begin
  Result := iCidade;
end;

function TConsumidor.GetiPedido: Integer;
begin
  Result := iPedido;
end;

function TConsumidor.GetsBairro: String;
begin
  Result := sBairro;
end;

function TConsumidor.GetsCep: String;
begin
  Result  := sCep;
end;

function TConsumidor.GetsEndereco: String;
begin
  Result := sEndereco;
end;

function TConsumidor.GetsFone: String;
begin
  Result := sFone;
end;

function TConsumidor.GetsNome: String;
begin
  Result := sNome;
end;

procedure TConsumidor.SetiCidade(piCidade: Integer);
begin
  iCidade := piCidade;
end;

procedure TConsumidor.SetiPedido(piPedido: Integer);
begin
  iPedido := piPedido;
end;

procedure TConsumidor.SetsBairro(psBairro: String);
begin
  sBairro := psBairro;
end;

procedure TConsumidor.SetsCep(psCep: String);
begin
  sCep := psCep;
end;

procedure TConsumidor.SetsEndereco(psEndereco: String);
begin
  sEndereco := psEndereco;
end;

procedure TConsumidor.SetsFone(psFone: String);
begin
  sFone := psFone;
end;

procedure TConsumidor.SetsNome(psNome: String);
begin
  sNome := psNome;
end;

function TConsumidor.zcoGetConnection: TZConnection;
begin
  Result:=zcoConnection;
end;

end.
