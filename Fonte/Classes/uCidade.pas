unit uCidade;

interface

uses ZConnection, ZDataset, SysUtils, uConstantes, Classes, uProcedimentosBanco, uExceptions, Variants, Forms,
  Dialogs, Windows, uNumeros;

type
  TCidade = class
  public
    constructor Create(pzcoConnection: TZConnection);
    destructor Destroy; override;

    procedure CadastraCidade;
    procedure AlteraCidade;
    procedure DeletaCidade;
    function iCamposConsistentes: Integer;
    function iRetornaUltimoCodigo: Integer;
    function bPesquisaCidade(psCodigo: String): Boolean;

    function sGetCodigo: String;
    function sGetNome: String;
    function sGetUF: String;
    function sGetStatus: String;
    function sGetCodIBGE: String;
    function iGetRegistrosAfetadosCidade: Longint;
    function zcoGetConnection: TZConnection;

    procedure SetCodigo(psCodigo: String);
    procedure SetNome(psNome: String);
    procedure SetUF(psUF: String);
    procedure SetStatus(psStatus: String);
    procedure SetCodIBGE(psCodIBGE: String);
    procedure SetRegistrosAfetadosCidade(piRegistros: Longint);
  private
    iCodigo: Integer;
    sNome: String;
    sUF: String;
    sStatus: String;
    sCodIBGE: String;
    sCodIBGEUF: String;
    iRegistrosAfetados: Longint;
    zcoConnection: TZConnection;
  end;

implementation

uses ZAbstractDataset, ZAbstractRODataset, ComConst, DB;

{ TCidade }

procedure TCidade.AlteraCidade;
var
  ZQryCidade: TZQuery;
begin
  SetRegistrosAfetadosCidade(0);
  if iCamposConsistentes = 0 then
  begin
    ZQryCidade := TZQuery.Create(nil);
    with ZQryCidade do
    begin
      Connection := zcoConnection;
      SQL.Clear;
      SQL.Add('UPDATE tbcidade SET snome = :snome, suf = :suf, sstatus = :sstatus');
      SQL.Add(',scodibge = :scodibge');
      SQL.Add('WHERE icodigo = :icodigo');
      ParamByName('snome').AsString := sGetNome;
      ParamByName('icodigo').AsInteger := StrToInt(sGetCodigo);
      ParamByName('suf').AsString := sGetUF;
      ParamByName('sstatus').AsString := sGetStatus;
      ParamByName('sCodIbge').AsString := sGetCodIBGE;
      try
        ExecSQL;
        SetRegistrosAfetadosCidade(RowsAffected);
      except
        on E: Exception do
          TrataErro(E.Message);
      end;
    end;
    FreeAndNil(ZQryCidade);
  end;
end;

function TCidade.iCamposConsistentes: Integer;
var
  iCont: SmallInt;
  slCampos: TStringList;
begin
  Result := 0;
  slCampos := TStringList.Create;
  slCampos.CommaText := sCamposObrigatorios('tbcidade', zcoConnection);

  for iCont := 0 to slCampos.Count - 1 do
  begin
    if AnsiLowerCase(slCampos.Strings[iCont]) = 'snome' then
    begin
      if Trim(sGetNome) = '' then
      begin
        Result := c_CampoVazio;
        raise eCampoNaoPreenchido.Create(StringReplace(asMensagemErro[c_CampoVazio], '%', 'Nome', [rfReplaceAll]));
      end;
    end;
    if AnsiLowerCase(slCampos.Strings[iCont]) = 'icodigo' then
    begin
      if sGetCodigo = '' then
      begin
        Result := c_CampoVazio;
        raise eCampoNaoPreenchido.Create(StringReplace(asMensagemErro[c_CampoVazio], '%', 'Código', [rfReplaceAll]));
      end;
    end;
    if AnsiLowerCase(slCampos.Strings[iCont]) = 'suf' then
    begin
      if Trim(sGetUF) = '' then
      begin
        Result := c_CampoVazio;
        raise eCampoNaoPreenchido.Create(StringReplace(asMensagemErro[c_CampoVazio], '%', 'Unidade Federal', [rfReplaceAll]));
      end;
    end;
  end;
  FreeAndNil(slCampos);
end;

procedure TCidade.CadastraCidade;
var
  ZQryCidade: TZQuery;
begin
  SetRegistrosAfetadosCidade(0);
  if iCamposConsistentes = 0 then
  begin
    ZQryCidade := TZQuery.Create(nil);
    with ZQryCidade do
    begin
      Connection := zcoConnection;
      SQL.Clear;
      SQL.Add('INSERT INTO tbcidade(icodigo, snome, suf, scodibge)');
      SQL.Add('VALUES(:icodigo, :snome, :suf, :scodibge)');
      ParamByName('snome').AsString := sGetNome;
      ParamByName('icodigo').AsInteger := StrToInt(sGetCodigo);
      ParamByName('suf').AsString := sGetUF;
      ParamByName('scodibge').AsString := sGetCodIBGE;
      try
        ExecSQL;
        SetRegistrosAfetadosCidade(RowsAffected);
      except
        on E: Exception do
          TrataErro(E.Message);
      end;
    end;
    FreeAndNil(ZQryCidade);
  end;
end;

constructor TCidade.Create(pzcoConnection: TZConnection);
begin
  inherited Create;
  zcoConnection := pzcoConnection;
  iRegistrosAfetados := 0;
end;

procedure TCidade.DeletaCidade;
var
  ZQryCidade: TZQuery;
begin
  ZQryCidade := TZQuery.Create(nil);
  with ZQryCidade do
  begin
    Connection := zcoConnection;
    SQL.Clear;
    SQL.Add('UPDATE tbcidade SET sstatus = ' + QuotedStr('I') + ' ');
    SQL.Add('WHERE icodigo = :icodigo');
    ParamByName('icodigo').AsInteger := StrToInt(sGetCodigo);
    ExecSQL;
  end;
  FreeAndNil(ZQryCidade);
end;

destructor TCidade.Destroy;
begin
end;

function TCidade.sGetCodigo: String;
begin
  if iCodigo > 0 then
    Result := IntToStr(iCodigo)
  else
    Result := '';
end;

procedure TCidade.SetCodigo(psCodigo: String);
begin
  if psCodigo = '' then
    iCodigo := -1
  else if bInteiroValido(psCodigo) then
    iCodigo := StrToInt(psCodigo)
  else
    iCodigo := -1;
end;

procedure TCidade.SetNome(psNome: String);
begin
  sNome := psNome;
end;

procedure TCidade.SetUF(psUF: String);
begin
  sUF := psUF;
end;

function TCidade.sGetNome: String;
begin
  Result := sNome;
end;

function TCidade.sGetUF: String;
begin
  Result := sUF;
end;

function TCidade.iRetornaUltimoCodigo: Integer;
var
  ZQryCidade: TZQuery;
begin
  ZQryCidade := TZQuery.Create(nil);
  with ZQryCidade do
  begin
    Connection := zcoConnection;
    SQL.Clear;
    SQL.Add('SELECT COALESCE(MAX(icodigo),0) AS ULTIMO FROM tbcidade');
    Open;
    Result := FieldByName('ULTIMO').AsInteger;
  end;
  FreeAndNil(ZQryCidade);
end;

function TCidade.bPesquisaCidade(psCodigo: String): Boolean;
var
  ZQryCidade: TZQuery;
begin
  if Trim(psCodigo) <> '' then
  begin
    ZQryCidade := TZQuery.Create(nil);
    Result := False;
    with ZQryCidade do
    begin
      Connection := zcoGetConnection;
      SQL.Clear;
      SQL.Add('SELECT * FROM tbcidade c');
      SQL.Add('inner join tbuf u on u.icodigo = c.iuf');
      SQL.Add('where c.icodigo = :icodigo');
      ParamByName('icodigo').AsString := psCodigo;
      Open;
      if not IsEmpty then
      begin
        Result := True;
        SetCodigo(FieldByName('icodigo').AsString);
        SetNome(FieldByName('snome').AsString);
        SetUF(FieldByName('uf').AsString);
        SetStatus(FieldByName('sstatus').AsString);
        SetCodIBGE(FieldByName('sCodIBGE').AsString);

        if sGetStatus = 'I' then
          if Application.MessageBox('Esta Cidade está Inativa! Deseja Reativar?', 'Reativar Cidade', MB_YESNO) = IDYES then
          begin
            SetStatus('A');
            AlteraCidade;
          end;
      end
      else
      begin
        SetCodigo('-1');
        SetNome('');
        SetUF('');
        SetStatus('');
      end;
    end;
    FreeAndNil(ZQryCidade);
  end;
end;

function TCidade.sGetStatus: String;
begin
  Result := sStatus;
end;

procedure TCidade.SetStatus(psStatus: String);
begin
  sStatus := psStatus;
end;

function TCidade.zcoGetConnection: TZConnection;
begin
  Result := zcoConnection;
end;

function TCidade.iGetRegistrosAfetadosCidade: Longint;
begin
  Result := iRegistrosAfetados;
end;

procedure TCidade.SetRegistrosAfetadosCidade(piRegistros: Integer);
begin
  iRegistrosAfetados := piRegistros;
end;

procedure TCidade.SetCodIBGE(psCodIBGE: String);
begin
  sCodIBGE := psCodIBGE;
end;

function TCidade.sGetCodIBGE: String;
begin
  Result := sCodIBGE;
end;

end.
