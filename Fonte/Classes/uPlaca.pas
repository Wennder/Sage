unit uPlaca;

interface

uses ZConnection, ZDataset, SysUtils, uConstantes, Classes, uProcedimentosBanco, uExceptions, Variants, Forms,
  Dialogs, Windows, uCliente, JvMemoryDataset, DB, Datasnap.DBClient;

type
  TPlaca = class
  public
    oCliente: TCliente;

    procedure SetCodigo(piCodigo: Integer);
    procedure SetPlaca(psPlaca: String);
    procedure SetVeiculo(psVeiculo: String);
    procedure SetKm(piKm: Integer);

    function GetiCodigo: Integer;
    function GetsPlaca: String;
    function GetsVeiculo: String;
    function GetiKm: Integer;

    function iRetornaUltimoCodigo: Integer;
    constructor Create(pzcoConnection: TZConnection);
    destructor Destroy; override;
    procedure CadastraPlaca;
    procedure AlteraPlaca;
    procedure DeletaPlaca;
    function bPesquisaPlacaCodigo(piCodigo: Integer): Boolean;
    function bPesquisaPlaca(psPlaca: String): Boolean;
    function bPesquisaPlacaCliente(psPlaca: String; piCliente: Integer): Boolean;
    function bPesquisaCliente(piCliente: Integer; var MemoryData: TClientDataSet): Boolean;

  private
    iCodigo: Integer;
    sPlaca: String;
    sVeiculo: String;
    iKm: Integer;
    zcoConnection: TZConnection;
    function iCamposConsistentes: Integer;
  end;

implementation

{ TPlaca }

procedure TPlaca.AlteraPlaca;
var
  ZQryPlaca: TZQuery;
begin
  if iCamposConsistentes = 0 then
  begin
    ZQryPlaca := TZQuery.Create(nil);
    with ZQryPlaca do
    begin
      Connection := zcoConnection;
      SQL.Clear;
      SQL.Add('UPDATE tbplaca SET ');
      SQL.Add(' splaca = :splaca,');
      SQL.Add(' sveiculo = :sveiculo,');
      SQL.Add(' nKm = :nKm,');
      SQL.Add(' icliente = :icliente');
      SQL.Add('WHERE icodigo = :icodigo');
      ParamByName('splaca').AsString := GetsPlaca;
      ParamByName('sveiculo').AsString := GetsVeiculo;
      ParamByName('nKm').AsFloat := GetiKm;
      ParamByName('icliente').AsString := oCliente.sGetCodigo;
      ParamByName('iCodigo').AsInteger := GetiCodigo;
      ExecSQL;
    end;
    FreeAndNil(ZQryPlaca);
  end;
end;

function TPlaca.bPesquisaCliente(piCliente: Integer; var MemoryData: TClientDataSet): Boolean;
var
  ZQryPlaca: TZQuery;
begin
  ZQryPlaca := TZQuery.Create(nil);
  with ZQryPlaca do
  begin
    Connection := zcoConnection;
    SQL.Clear;
    SQL.Add('SELECT * FROM tbplaca');
    SQL.Add('where icliente = :icliente');
    SQL.Add('  and sstatus = ''A''');

    ParamByName('icliente').AsInteger := piCliente;
    Open;
    Result := not Bof and Eof;

    MemoryData.Close;
    MemoryData.CreateDataSet;
    MemoryData.EmptyDataSet;
    MemoryData.Open;

    while not Eof do
    begin
      MemoryData.Insert;
      MemoryData.FieldByName('DML').AsString := 'S'; // S = Select, I = Insert, A = Alteração, E = Exclusão.
      MemoryData.FieldByName('Placa').AsString := FieldByName('sPlaca').AsString;
      MemoryData.FieldByName('Veiculo').AsString := FieldByName('sVeiculo').AsString;
      MemoryData.FieldByName('Km').AsInteger := FieldByName('nKm').AsInteger;
      MemoryData.Post;
      Next;
    end;
  end;
  FreeAndNil(ZQryPlaca);
end;

function TPlaca.bPesquisaPlaca(psPlaca: String): Boolean;
var
  ZQryPlaca: TZQuery;
begin
  ZQryPlaca := TZQuery.Create(nil);
  with ZQryPlaca do
  begin
    Connection := zcoConnection;
    SQL.Clear;
    SQL.Add('SELECT * FROM tbplaca where splaca = :splaca');
    ParamByName('splaca').AsString := psPlaca;
    Open;
    Result := not Bof and Eof;
  end;
  FreeAndNil(ZQryPlaca);
end;

function TPlaca.bPesquisaPlacaCliente(psPlaca: String; piCliente: Integer): Boolean;
var
  ZQryPlaca: TZQuery;
begin
  ZQryPlaca := TZQuery.Create(nil);
  with ZQryPlaca do
  begin
    Connection := zcoConnection;
    SQL.Clear;
    SQL.Add('SELECT * FROM tbplaca where splaca = :splaca and icliente = :icliente');
    ParamByName('splaca').AsString := psPlaca;
    ParamByName('icliente').AsInteger := piCliente;
    Open;
    Result := not(Bof and Eof);
    SetCodigo(FieldByName('icodigo').AsInteger);
    SetPlaca(FieldByName('sPlaca').AsString);
    SetVeiculo(FieldByName('sVeiculo').AsString);
    SetKm(FieldByName('nKm').AsInteger);
  end;
  FreeAndNil(ZQryPlaca);
end;

function TPlaca.bPesquisaPlacaCodigo(piCodigo: Integer): Boolean;
begin

end;

procedure TPlaca.CadastraPlaca;
var
  ZQryPlaca: TZQuery;
begin
  if iCamposConsistentes = 0 then
  begin
    ZQryPlaca := TZQuery.Create(nil);
    with ZQryPlaca do
    begin
      Connection := zcoConnection;
      SQL.Clear;
      SQL.Add('INSERT INTO tbplaca(');
      SQL.Add(' iCodigo,');
      SQL.Add(' splaca,');
      SQL.Add(' sveiculo,');
      SQL.Add(' nkm,');
      SQL.Add(' icliente)');
      SQL.Add('VALUES(');
      SQL.Add(' :iCodigo,');
      SQL.Add(' :splaca,');
      SQL.Add(' :sveiculo,');
      SQL.Add(' :nkm,');
      SQL.Add(' :icliente)');
      ParamByName('splaca').AsString := GetsPlaca;
      ParamByName('sveiculo').AsString := GetsVeiculo;
      ParamByName('icliente').AsString := oCliente.sGetCodigo;
      ParamByName('nkm').AsInteger := GetiKm;
      ParamByName('icodigo').AsInteger := GetiCodigo;
      try
        ExecSQL;
      except
        on E: Exception do
        begin
          TrataErro(E.Message);
          Application.MessageBox(Pchar(E.Message), 'Erro', MB_OK);
        end;
      end;
    end;
    FreeAndNil(ZQryPlaca);
  end;
end;

constructor TPlaca.Create(pzcoConnection: TZConnection);
begin
  zcoConnection := pzcoConnection;
  oCliente := TCliente.Create(pzcoConnection);
end;

procedure TPlaca.DeletaPlaca;
var
  ZQryPlaca: TZQuery;
begin
  ZQryPlaca := TZQuery.Create(nil);
  with ZQryPlaca do
  begin
    Connection := zcoConnection;
    SQL.Clear;
    SQL.Add('DELETE FROM tbplaca');
    SQL.Add('WHERE iCliente = :Cliente');
    SQL.Add(' and splaca = :Placa');
    SQL.Add(' and sveiculo = :Veiculo');
    SQL.Add(' and nkm = :KM');

    ParamByName('Cliente').Value := oCliente.sGetCodigo;
    ParamByName('Placa').Value := GetsPlaca;
    ParamByName('Veiculo').Value := GetsVeiculo;
    ParamByName('KM').Value := GetiKm;

    ExecSQL;
  end;
  FreeAndNil(ZQryPlaca);
end;

destructor TPlaca.Destroy;
begin
  FreeAndNil(oCliente);
  inherited;
end;

function TPlaca.GetiCodigo: Integer;
begin
  Result := iCodigo;
end;

function TPlaca.GetiKm: Integer;
begin
  Result := iKm;
end;

function TPlaca.GetsPlaca: String;
begin
  Result := sPlaca;
end;

function TPlaca.GetsVeiculo: String;
begin
  Result := sVeiculo;
end;

function TPlaca.iCamposConsistentes: Integer;
var
  iCont: SmallInt;
  slCampos: TStringList;
begin
  Result := 0;
  slCampos := TStringList.Create;
  slCampos.CommaText := sCamposObrigatorios('tbplaca', zcoConnection);
  for iCont := 0 to slCampos.Count - 1 do
  begin
    if AnsiLowerCase(slCampos.Strings[iCont]) = 'splaca' then
    begin
      if Trim(GetsPlaca) = '' then
      begin
        Result := c_CampoVazio;
        eCampoNaoPreenchido.Create(StringReplace(asMensagemErro[c_CampoVazio], '%', 'Descrição', [rfReplaceAll]));
      end;
    end;
    if AnsiLowerCase(slCampos.Strings[iCont]) = 'icodigo' then
    begin
      if (IntToStr(GetiCodigo) = '') or (GetiCodigo <= 0) then
      begin
        Result := c_CampoVazio;
        eCampoNaoPreenchido.Create(StringReplace(asMensagemErro[c_CampoVazio], '%', 'Código', [rfReplaceAll]));
      end;
    end;
    if AnsiLowerCase(slCampos.Strings[iCont]) = 'icliente' then
    begin
      if (oCliente.sGetCodigo = '') or (StrtoInt(oCliente.sGetCodigo) <= 0) then
      begin
        Result := c_CampoVazio;
        eCampoNaoPreenchido.Create(StringReplace(asMensagemErro[c_CampoVazio], '%', 'Cliente', [rfReplaceAll]));
      end;
    end;
  end;
end;

function TPlaca.iRetornaUltimoCodigo: Integer;
var
  ZQryPlaca: TZQuery;
begin
  ZQryPlaca := TZQuery.Create(nil);
  with ZQryPlaca do
  begin
    Connection := zcoConnection;
    SQL.Clear;
    SQL.Add('SELECT COALESCE(MAX(icodigo),0) AS ULTIMO FROM tbplaca');
    Open;
    Result := FieldByName('ULTIMO').AsInteger;
  end;
  FreeAndNil(ZQryPlaca);
end;

procedure TPlaca.SetCodigo(piCodigo: Integer);
begin
  iCodigo := piCodigo;
end;

procedure TPlaca.SetKm(piKm: Integer);
begin
  iKm := piKm;
end;

procedure TPlaca.SetPlaca(psPlaca: String);
begin
  sPlaca := psPlaca;
end;

procedure TPlaca.SetVeiculo(psVeiculo: String);
begin
  sVeiculo := psVeiculo
end;

end.
