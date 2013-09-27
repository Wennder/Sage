unit uMarca;

interface

uses ZConnection, ZDataset, SysUtils, uConstantes, Classes, uProcedimentosBanco, uExceptions, Variants, Forms,
  Dialogs, Windows;

type
  TMarca = class
  public
    procedure SetCodigo(piCodigo: Integer);
    procedure SetDescricao(psDescricao: String);
    procedure sSetStatus(psStatus: String);
    function iGetCodigo: Integer;
    function sGetDescricao: String;
    function sGetStatus: String;
    function iRetornaUltimoCodigo: Integer;
    function sRetornaDescricaoPorCodigo: String;
    function bPesquisaMarca(piCodigo: Integer): Boolean;
    constructor Create(pzcoConnection: TZConnection);
    destructor Destroy; override;
    procedure CadastraMarca;
    procedure AlteraMarca;
    procedure DeletaMarca;
  private
    zcoConnection: TZConnection;
    iCodigo: Integer;
    sDescricao: String;
    sStatus: String;
    function iCamposConsistentes: Integer;
  end;

implementation

uses ZAbstractDataset, ZAbstractRODataset, ComConst, DB;

{ TCor }

procedure TMarca.AlteraMarca;
var
  ZQryMarca: TZQuery;
begin
  if iCamposConsistentes = 0 then
  begin
    ZQryMarca := TZQuery.Create(nil);
    with ZQryMarca do
    begin
      Connection := zcoConnection;
      SQL.Clear;
      SQL.Add('UPDATE tbmarca SET sdescricao = :sdescricao, sstatus = :sstatus');
      SQL.Add('WHERE icodigo = :icodigo');
      ParamByName('sdescricao').AsString := sDescricao;
      ParamByName('icodigo').AsInteger := iCodigo;
      ParamByName('sstatus').AsString := sStatus;
      ExecSQL;
    end;
    FreeAndNil(ZQryMarca);
  end;
end;

function TMarca.iCamposConsistentes: Integer;
var
  iCont: SmallInt;
  slCampos: TStringList;
begin
  Result := 0;
  slCampos := TStringList.Create;
  slCampos.CommaText := sCamposObrigatorios('tbmarca', zcoConnection);

  for iCont := 0 to slCampos.Count - 1 do
  begin
    if AnsiLowerCase(slCampos.Strings[iCont]) = 'sdescricao' then
    begin
      if Trim(sGetDescricao) = '' then
      begin
        Result := c_CampoVazio;
        raise eCampoNaoPreenchido.Create(StringReplace(asMensagemErro[c_CampoVazio], '%', 'Descrição', [rfReplaceAll]));
      end;
    end;
    if AnsiLowerCase(slCampos.Strings[iCont]) = 'icodigo' then
    begin
      if (IntToStr(iGetCodigo) = '') or (iGetCodigo <= 0) then
      begin
        Result := c_CampoVazio;
        raise eCampoNaoPreenchido.Create(StringReplace(asMensagemErro[c_CampoVazio], '%', 'Código', [rfReplaceAll]));
      end;
    end;
  end;
end;

procedure TMarca.CadastraMarca;
var
  ZQryMarca: TZQuery;
begin
  if iCamposConsistentes = 0 then
  begin
    ZQryMarca := TZQuery.Create(nil);
    with ZQryMarca do
    begin
      Connection := zcoConnection;
      SQL.Clear;
      SQL.Add('INSERT INTO tbmarca(icodigo, sdescricao, sstatus)');
      SQL.Add('VALUES(:icodigo, :sdescricao, :sstatus)');
      ParamByName('sdescricao').AsString := sDescricao;
      ParamByName('icodigo').AsInteger := iCodigo;
      ParamByName('sstatus').AsString := 'A';
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
    FreeAndNil(ZQryMarca);
  end;
end;

constructor TMarca.Create(pzcoConnection: TZConnection);
begin
  inherited Create;
  zcoConnection := pzcoConnection;
end;

procedure TMarca.DeletaMarca;
var
  ZQryMarca: TZQuery;
begin
  ZQryMarca := TZQuery.Create(nil);
  with ZQryMarca do
  begin
    Connection := zcoConnection;
    SQL.Clear;
    SQL.Add('UPDATE tbmarca SET sstatus = ' + QuotedStr('I') + ' ');
    SQL.Add('WHERE icodigo = :icodigo');
    ParamByName('icodigo').AsInteger := iGetCodigo;
    ExecSQL;
  end;
  FreeAndNil(ZQryMarca);
end;

destructor TMarca.Destroy;
begin
  FreeAndNil(zcoConnection);
end;

function TMarca.iGetCodigo: Integer;
begin
  Result := iCodigo;
end;

function TMarca.iRetornaUltimoCodigo: Integer;
var
  ZQryMarca: TZQuery;
begin
  ZQryMarca := TZQuery.Create(nil);
  with ZQryMarca do
  begin
    Connection := zcoConnection;
    SQL.Clear;
    SQL.Add('SELECT COALESCE(MAX(icodigo),0) AS ULTIMO FROM tbmarca');
    Open;
    Result := FieldByName('ULTIMO').AsInteger;
  end;
  FreeAndNil(ZQryMarca);
end;

procedure TMarca.SetCodigo(piCodigo: Integer);
begin
  iCodigo := piCodigo;
end;

procedure TMarca.SetDescricao(psDescricao: String);
begin
  sDescricao := psDescricao;
end;

function TMarca.sGetDescricao: String;
begin
  Result := sDescricao;
end;

function TMarca.sRetornaDescricaoPorCodigo: String;
var
  ZQryMarca: TZQuery;
begin
  ZQryMarca := TZQuery.Create(nil);
  with ZQryMarca do
  begin
    Connection := zcoConnection;
    SQL.Clear;
    SQL.Add('SELECT sdescricao FROM tbmarca');
    SQL.Add('WHERE icodigo = :icodigo');
    ParamByName('icodigo').AsInteger := iCodigo;
    Open;
    Result := FieldByName('sdescricao').AsString;
  end;
  FreeAndNil(ZQryMarca);
end;

function TMarca.bPesquisaMarca(piCodigo: Integer): Boolean;
var
  ZQryMarca: TZQuery;
begin
  ZQryMarca := TZQuery.Create(nil);
  Result := False;
  with ZQryMarca do
  begin
    Connection := zcoConnection;
    SQL.Clear;
    SQL.Add('SELECT * FROM tbmarca WHERE icodigo = :icodigo');
    ParamByName('icodigo').AsInteger := piCodigo;
    Open;
    if not IsEmpty then
    begin
      Result := True;
      SetCodigo(FieldByName('icodigo').AsInteger);
      SetDescricao(FieldByName('sdescricao').AsString);
      sSetStatus(FieldByName('sstatus').AsString);
      if sGetStatus = 'I' then
        if Application.MessageBox('Esta Marca está Inativa! Deseja Reativar?', 'Reativar Marca', MB_YESNO) = IDYES then
        begin
          sSetStatus('A');
          AlteraMarca;
          sSetStatus('A');
        end;
    end
    else
    begin
      SetCodigo(-1);
      SetDescricao('');
    end;
  end;
  FreeAndNil(ZQryMarca);
end;

function TMarca.sGetStatus: String;
begin
  Result := sStatus;
end;

procedure TMarca.sSetStatus(psStatus: String);
begin
  sStatus := psStatus;
end;

end.
