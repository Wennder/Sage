unit uNotaFiscal;

interface

uses ZConnection, ZDataset, SysUtils, uConstantes, Classes, Contnrs, uProcedimentosBanco, uExceptions, Variants, Forms,
  Dialogs, Windows, Datasnap.DBClient, UsoGeral, Vcl.FileCtrl, Data.DB, Vcl.StdCtrls, Vcl.Controls;

type
  TResult = array of string;

type
  TNotaFiscal = class
  public
    constructor Create(pzcoConnection: TZConnection);
    destructor Destroy; override;

    function Geticodigo: variant;
    function Getinotafiscal: variant;
    function Getchave: variant;
    function Getlote: variant;

    procedure Seticodigo(pParametro: variant);
    procedure Setinotafiscal(pParametro: variant);
    procedure Setchave(pParametro: variant);
    procedure Setlote(pParametro: variant);

  private
    zcoConnection: TZConnection;

    icodigo: variant;
    inotafiscal: variant;
    chave: variant;
    lote: variant;
  end;

implementation

{ TNotaFiscal }

constructor TNotaFiscal.Create(pzcoConnection: TZConnection);
begin
  zcoConnection := pzcoConnection;
end;

destructor TNotaFiscal.Destroy;
begin

  inherited;
end;

function TNotaFiscal.Getchave: variant;
begin
  Result := chave;
end;

function TNotaFiscal.Geticodigo: variant;
begin
  Result := icodigo;
end;

function TNotaFiscal.Getinotafiscal: variant;
begin
  Result := inotafiscal;
end;

function TNotaFiscal.Getlote: variant;
begin
  Result := lote;
end;

procedure TNotaFiscal.Setchave(pParametro: variant);
begin
  chave := pParametro;
end;

procedure TNotaFiscal.Seticodigo(pParametro: variant);
begin
  icodigo := pParametro;
end;

procedure TNotaFiscal.Setinotafiscal(pParametro: variant);
begin
  inotafiscal := pParametro;
end;

procedure TNotaFiscal.Setlote(pParametro: variant);
begin
  lote := pParametro;
end;

end.
