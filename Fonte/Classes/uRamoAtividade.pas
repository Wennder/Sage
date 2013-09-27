unit uRamoAtividade;

interface

uses ZConnection, ZDataset, SysUtils, Forms, Windows, Classes, uConstantes, uProcedimentosBanco, uExceptions, uNumeros;

{ 
CREATE TABLE TbRamoAtividade(
	iCodigo		INTEGER		PRIMARY KEY,
	sDescricao	VARCHAR(50)	NOT NULL,
	sStatus		CHAR(01)	NOT NULL DEFAULT 0
);
}

type
  TRamoAtividade = class
  public
    constructor Create(pzcoConnection: TZConnection);
    destructor Destroy;override;

    procedure CadastraRamoAtividade;
    procedure AlteraRamoAtividade;
    procedure DeletaRamoAtividade;
    function iCamposConsistentes: Integer;
    function iRetornaUltimoCodigo: Integer;
    function bPesquisaRamoAtividade(psCodigo: String): Boolean;

    function sGetDescricao: String;
    function sGetCodigo: String;
    function sGetStatus: String;
    function iGetRegistrosAfetadosRamoAtividade: Longint;

    procedure SetDescricao(psDescricao: String);
    procedure SetCodigo(psCodigo: String);
    procedure SetStatus(psStatus: String);
    procedure SetRegistrosAfetadosRamoAtividade(piRegistros: Longint);

  private
    iCodigo: Integer;
    sDescricao: String;
    sStatus: String;
    iRegistrosAfetados: Longint;
    zcoConnection: TZConnection;
  end;

implementation

uses ZAbstractDataset, ZAbstractRODataset;

{ TRamoAtividade }

procedure TRamoAtividade.AlteraRamoAtividade;
var
  ZQryRamoAtividade: TZQuery;
begin
  SetRegistrosAfetadosRamoAtividade(0);
  ZQryRamoAtividade:=TZQuery.Create(nil);
  with ZQryRamoAtividade do
  begin
    Connection:=zcoConnection;
    SQL.Clear;
    SQL.Add('UPDATE tbramoatividade SET sdescricao = :sdescricao, sstatus = :sstatus');
    SQL.Add('WHERE icodigo = :icodigo');
    ParamByName('sdescricao').AsString:=sGetDescricao;
    ParamByName('icodigo').AsInteger:=StrToInt(sGetCodigo);
    ParamByName('sstatus').AsString:=sGetStatus;
    try
      ExecSQL;
      SetRegistrosAfetadosRamoAtividade(RowsAffected);
    except
      on E: Exception do
      begin
        TrataErro(E.Message);
        Application.MessageBox(Pchar(E.Message),'Erro',MB_OK);
      end;
    end;
  end;
   FreeAndNil(ZQryRamoAtividade);
end;

function TRamoAtividade.bPesquisaRamoAtividade(psCodigo: String): Boolean;
var
  ZQryRamoAtividade: TZQuery;
begin
  if Trim(psCodigo) <> '' then
  begin
    ZQryRamoAtividade:=TZQuery.Create(nil);
    Result:=False;
    with ZQryRamoAtividade do
    begin
      Connection:=zcoConnection;
      SQL.Clear;
      SQL.Add('SELECT * FROM tbramoatividade WHERE icodigo = :icodigo');
      ParamByName('icodigo').AsString:=psCodigo;
      Open;
      if not IsEmpty then
      begin
        Result:=True;
        SetCodigo(FieldByName('icodigo').AsString);
        SetDescricao(FieldByName('sdescricao').AsString);
        SetStatus(FieldByName('sstatus').AsString);

        if sGetStatus = 'I' then
          if Application.MessageBox('Este Ramo de Atividade está Inativo! Deseja Reativar?',
          'Reativar Ramo de Atividade',MB_YESNO) = IDYES then
          begin
            SetStatus('A');
            AlteraRamoAtividade;
          end;
      end
      else
      begin
        SetCodigo('-1');
        SetDescricao('');
        SetStatus('');
      end;
    end;
    FreeAndNil(ZQryRamoAtividade);
  end;
end;

procedure TRamoAtividade.CadastraRamoAtividade;
var
  ZQryRamoAtividade: TZQuery;
begin
  SetRegistrosAfetadosRamoAtividade(0);
  ZQryRamoAtividade:=TZQuery.Create(nil);
  with ZQryRamoAtividade do
  begin
    Connection:=zcoConnection;
    SQL.Clear;
    SQL.Add('INSERT INTO tbramoatividade(icodigo, sdescricao)');
    SQL.Add('VALUES(:icodigo, :sdescricao)');
    ParamByName('sdescricao').AsString:=sGetDescricao;
    ParamByName('icodigo').AsInteger:=StrToInt(sGetCodigo);
    try
      ExecSQL;
      SetRegistrosAfetadosRamoAtividade(RowsAffected);
    except
      on E: Exception do
      begin
        TrataErro(E.Message);
        Application.MessageBox(Pchar(E.Message),'Erro',MB_OK);
      end;
    end;
  end;
  FreeAndNil(ZQryRamoAtividade);
end;

constructor TRamoAtividade.Create(pzcoConnection: TZConnection);
begin
  inherited Create;
  zcoConnection:=pzcoConnection;
  iRegistrosAfetados:=0;
end;

procedure TRamoAtividade.DeletaRamoAtividade;
var
  ZQryRamoAtividade: TZQuery;
begin
  ZQryRamoAtividade:=TZQuery.Create(nil);
  with ZQryRamoAtividade do
  begin
    Connection:=zcoConnection;
    SQL.Clear;
    SQL.Add('UPDATE tbramoatividade');
    SQL.Add('SET sstatus = ''I''');
    SQL.Add('WHERE icodigo = :icodigo');
    ParamByName('icodigo').AsInteger:=StrToInt(sGetCodigo);
    ExecSQL;
  end;
  FreeAndNil(ZQryRamoAtividade);
end;

destructor TRamoAtividade.Destroy;
begin
end;

function TRamoAtividade.iCamposConsistentes: Integer;
var
  iCont: SmallInt;
  slCampos: TStringList;
begin
  Result:=0;
  slCampos:=TStringList.Create;
  slCampos.CommaText:=sCamposObrigatorios('tbramoatividade',zcoConnection);

  for iCont:=0 to slCampos.Count - 1 do
  begin
    if AnsiLowerCase(slCampos.Strings[iCont]) = 'sdescricao' then
    begin
      if Trim(sGetDescricao) = '' then
      begin
        Result:=c_CampoVazio;
        raise eCampoNaoPreenchido.Create(StringReplace(asMensagemErro[c_CampoVazio],'%','Descrição',[rfReplaceAll]));
      end;
    end;
    if AnsiLowerCase(slCampos.Strings[iCont]) = 'icodigo' then
    begin
      if sGetCodigo = '' then
      begin
        Result:=c_CampoVazio;
        raise eCampoNaoPreenchido.Create(StringReplace(asMensagemErro[c_CampoVazio],'%','Código',[rfReplaceAll]));
      end;
    end;
  end;
  FreeAndNil(slCampos);
end;

function TRamoAtividade.sGetCodigo: String;
begin
  if iCodigo > 0 then
    Result:=IntToStr(iCodigo)
  else
    Result:='';
end;

function TRamoAtividade.iRetornaUltimoCodigo: Integer;
var
  ZQryRamoAtividade: TZQuery;
begin
  ZQryRamoAtividade:=TZQuery.Create(nil);
  with ZQryRamoAtividade do
  begin
    Connection:=zcoConnection;
    SQL.Clear;
    SQL.Add('SELECT COALESCE(MAX(icodigo),0) AS ULTIMO FROM tbramoatividade');
    Open;
    Result:=FieldByName('ULTIMO').AsInteger;
  end;
  FreeAndNil(ZQryRamoAtividade);
end;

procedure TRamoAtividade.SetCodigo(psCodigo: String);
begin
  if bInteiroValido(psCodigo) then
    iCodigo:=StrToInt(psCodigo)
  else
    iCodigo:=-1;
end;

procedure TRamoAtividade.SetDescricao(psDescricao: String);
begin
  sDescricao:=psDescricao;
end;

procedure TRamoAtividade.SetStatus(psStatus: String);
begin
  sStatus:=psStatus;
end;

function TRamoAtividade.sGetDescricao: String;
begin
  Result:=sDescricao;
end;

function TRamoAtividade.sGetStatus: String;
begin
  Result:=sStatus;
end;

function TRamoAtividade.iGetRegistrosAfetadosRamoAtividade: Longint;
begin
  Result:=iRegistrosAfetados;
end;

procedure TRamoAtividade.SetRegistrosAfetadosRamoAtividade(piRegistros: Integer);
begin
  iRegistrosAfetados:=piRegistros;
end;

end.
