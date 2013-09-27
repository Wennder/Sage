unit uPedidoParcela;

interface
uses ZConnection, ZDataset, SysUtils, uConstantes, Classes, uProcedimentosBanco, uExceptions, Variants, Forms,
Dialogs, Windows, Controls;

type
  TPedidoParcela = class
public
   procedure Seticodigo(picodigo: Integer);
   procedure Setipedido(pipedido: Integer);
   procedure Setsfatura(psfatura: String);
   procedure Setdvencimento(pdvencimento: TDate);
   procedure Setnvalor(pnvalor: Real);

   function Geticodigo: Integer;
   function Getipedido: Integer;
   function Getsfatura: String;
   function Getdvencimento: TDate;
   function Getnvalor: Real;

   procedure AlteraPedidoParcela;
   procedure DeletaPedidoParcela;
   procedure CadastraPedidoParcela;

   function iRetornaUltimoCodigo: Integer;
   function bPesquisaPedidoParcela(piPedido: Integer): Boolean;

   constructor Create(pzcoConnection: TZConnection);
   destructor Destroy; override;

private
   zcoConnection: TZConnection;
   icodigo: Integer;
   ipedido: Integer;
   sfatura: String;
   dvencimento: TDate;
   nvalor: Real;
end;

implementation

uses ZAbstractDataset, ZAbstractRODataset, ComConst, DB;

procedure TPedidoParcela.AlteraPedidoParcela;
var
ZQry: TZQuery;
begin
   ZQry := TZQuery.Create(nil);
  with ZQry do
  begin
     Connection := zcoConnection;
     SQL.Clear;
     SQL.Add('UPDATE tbpedidoparcela SET ');
      SQL.Add('ipedido= :ipedido');
      SQL.Add(',sfatura= :sfatura');
      SQL.Add(',dvencimento= :dvencimento');
      SQL.Add(',nvalor= :nvalor');
      SQL.Add('WHERE icodigo= :icodigo');
      ParamByName('icodigo').AsInteger := icodigo;
      ParamByName('ipedido').AsInteger := ipedido;
      ParamByName('sfatura').AsString := sfatura;
      ParamByName('dvencimento').AsDateTime := dvencimento;
      ParamByName('nvalor').AsFloat := nvalor;
      ExecSQL;
   end;
   FreeAndNil(ZQry);
end;

procedure TPedidoParcela.DeletaPedidoParcela;
var
ZQry: TZQuery;
begin
   ZQry := TZQuery.Create(nil);
  with ZQry do
  begin
     Connection := zcoConnection;
     SQL.Clear;
     SQL.Add('delete from tbpedidoparcela ');
     //SQL.Add('sstatus = '+QuotedStr('I'));
      SQL.Add('WHERE ipedido= :ipedido');
      ParamByName('ipedido').AsInteger := ipedido;
      ExecSQL;
   end;
   FreeAndNil(ZQry);
end;


procedure TPedidoParcela.CadastraPedidoParcela;
var
ZQry: TZQuery;
begin
   ZQry := TZQuery.Create(nil);
  with ZQry do
  begin
     Connection := zcoConnection;
     SQL.Clear;
     SQL.Add('INSERT INTO tbpedidoparcela( ');
      SQL.Add('icodigo');
      SQL.Add(',ipedido');
      SQL.Add(',sfatura');
      SQL.Add(',dvencimento');
      SQL.Add(',nvalor');
      SQL.Add(')');
      SQL.Add('VALUES( :icodigo');
      SQL.Add(', :ipedido');
      SQL.Add(', :sfatura');
      SQL.Add(', :dvencimento');
      SQL.Add(', :nvalor');
      SQL.Add(')');
      ParamByName('icodigo').AsInteger := icodigo;
      ParamByName('ipedido').AsInteger := ipedido;
      ParamByName('sfatura').AsString := sfatura;
      ParamByName('dvencimento').AsDateTime := dvencimento;
      ParamByName('nvalor').AsFloat := nvalor;
      try
         ExecSQL;
      except
        on E: Exception do begin
            TrataErro(E.Message);
            Application.MessageBox(Pchar(E.Message),'Erro',MB_OK);
         end;
      end;
   end;
   FreeAndNil(ZQry);
end;

constructor TPedidoParcela.Create(pzcoConnection: TZConnection);
begin
   inherited Create;
   zcoConnection := pzcoConnection;
end;

destructor TPedidoParcela.Destroy;
begin
end;


function TPedidoParcela.Geticodigo: Integer;
begin
  Result := icodigo;
end;

function TPedidoParcela.Getipedido: Integer;
begin
  Result := ipedido;
end;

function TPedidoParcela.Getsfatura: String;
begin
  Result := sfatura;
end;

function TPedidoParcela.Getdvencimento: TDate;
begin
  Result := dvencimento;
end;

function TPedidoParcela.Getnvalor: Real;
begin
  Result := nvalor;
end;

procedure TPedidoParcela.Seticodigo(picodigo: Integer);
begin
   icodigo := picodigo;
end;

procedure TPedidoParcela.Setipedido(pipedido: Integer);
begin
   ipedido := pipedido;
end;

procedure TPedidoParcela.Setsfatura(psfatura: String);
begin
   sfatura := psfatura;
end;

procedure TPedidoParcela.Setdvencimento(pdvencimento: TDate);
begin
   dvencimento := pdvencimento;
end;

procedure TPedidoParcela.Setnvalor(pnvalor: Real);
begin
   nvalor := pnvalor;
end;

function TPedidoParcela.iRetornaUltimoCodigo: Integer;
var
  ZQry: TZQuery;
begin
  ZQry := TZQuery.Create(nil);
  with ZQry do
  begin
    Connection := zcoConnection;
    SQL.Clear;
    SQL.Add('SELECT COALESCE(MAX(icodigo),0) AS ULTIMO FROM tbpedidoparcela');
    Open;
    Result := FieldByName('ULTIMO').AsInteger;
  end;
  FreeAndNil(ZQry);
end;

function TPedidoParcela.bPesquisaPedidoParcela(piPedido: Integer): Boolean;
var
  ZQry: TZQuery;
begin
  if piPedido <> 0 then
  begin
    ZQry := TZQuery.Create(nil);
    Result:=False;
    with ZQry do
    begin
      Connection := zcoConnection;
      SQL.Clear;
      SQL.Add('SELECT * FROM tbpedidoparcela WHERE ipedido = :ipedido');
      ParamByName('ipedido').AsInteger:=pipedido;
      Open;
      if not IsEmpty then
      begin
        Result:=True;
      end;
    end;
    FreeAndNil(ZQry);
  end;
end;



end.
