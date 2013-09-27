unit uGrupo;

interface

uses ZConnection, ZDataset, SysUtils, uConstantes, Classes, uProcedimentosBanco, uExceptions, Variants, Forms,
     Dialogs, Windows;


type
  TGrupo = class
  public
    function iGetCodigo: Integer;
    function sGetDescricao: String;
    function sGetStatus: String;
    procedure SetCodigo(piCodigo: Integer);
    procedure SetDescricao(psDecricao: String);
    procedure SetStatus(psStatus: String);
    function iRetornaUltimoCodigo: Integer;
    function sRetornaDescricaoPorCodigo: String;
    function bPesquisaGrupo(piCodigo: Integer): Boolean;
    constructor Create(pzcoConnection: TZConnection);
    destructor Destroy; override;
    procedure CadastraGrupo;
    procedure AlteraGrupo;
    procedure DeletaGrupo;
  private
    zcoConnection: TZConnection;
    iCodigo: Integer;
    sDescricao: String;
    sStatus: String;
    function iCamposConsistentes: Integer;
  end;

implementation

uses ZAbstractDataset, ZAbstractRODataset, RTLConsts;

{ TGrupo }

procedure TGrupo.AlteraGrupo;
var
  ZQryGrupo: TZQuery;
begin
  if iCamposConsistentes = 0 then
  begin
    ZQryGrupo := TZQuery.Create(nil);
    with ZQryGrupo do
    begin
      Connection := zcoConnection;
      SQL.Clear;
      SQL.Add('UPDATE tbgrupo SET sdescricao = :sdescricao, sstatus = :sstatus');
      SQL.Add('WHERE icodigo = :icodigo');
      ParamByName('sdescricao').AsString := sDescricao;
      ParamByName('icodigo').AsInteger   := iCodigo;
      ParamByName('sstatus').AsString    := sStatus;
      ExecSQL;
    end;
     FreeAndNil(ZQryGrupo);
  end;
end;

function TGrupo.bPesquisaGrupo(piCodigo: Integer): Boolean;
var
  ZQryGrupo: TZQuery;
begin
  ZQryGrupo := TZQuery.Create(nil);
  Result:=False;
  with ZQryGrupo do
  begin
    Connection := zcoConnection;
    SQL.Clear;
    SQL.Add('SELECT * FROM tbgrupo WHERE icodigo = :icodigo');
    ParamByName('icodigo').AsInteger:=piCodigo;
    Open;
    if not IsEmpty then
    begin
      Result:=True;
      SetCodigo(FieldByName('icodigo').AsInteger);
      SetDescricao(FieldByName('sdescricao').AsString);
      SetStatus(FieldByName('sstatus').AsString);
      if sGetStatus = 'I' then
        if Application.MessageBox('Este Grupo está Inativo! Deseja Reativar?','Reativar Grupo',MB_YESNO) = IDYES then
        begin
          SetStatus('A');
          AlteraGrupo;
          SetStatus('A');
        end;
    end
    else
    begin
      SetCodigo(-1);
      SetDescricao('');
    end;
  end;
  FreeAndNil(ZQryGrupo);
end;

procedure TGrupo.CadastraGrupo;
var
  ZQryGrupo: TZQuery;
begin
  if iCamposConsistentes = 0 then
  begin
    ZQryGrupo := TZQuery.Create(nil);
    with ZQryGrupo do
    begin
      Connection := zcoConnection;
      SQL.Clear;
      SQL.Add('INSERT INTO tbgrupo(icodigo, sdescricao)');
      SQL.Add('VALUES(:icodigo, :sdescricao)');
      ParamByName('sdescricao').AsString := sDescricao;
      ParamByName('icodigo').AsInteger   := iCodigo;
      try
        ExecSQL;
      except
        on E: Exception do begin
          TrataErro(E.Message);
          Application.MessageBox(Pchar(E.Message),'Erro',MB_OK);
        end;
      end;
    end;
    FreeAndNil(ZQryGrupo);
  end;
end;

constructor TGrupo.Create(pzcoConnection: TZConnection);
begin
  inherited Create;
  zcoConnection := pzcoConnection;
end;

procedure TGrupo.DeletaGrupo;
var
  ZQryGrupo: TZQuery;
begin
  ZQryGrupo := TZQuery.Create(nil);
  with ZQryGrupo do
  begin
    Connection := zcoConnection;
    SQL.Clear;
    SQL.Add('UPDATE tbgrupo set sstatus = ' + QuotedStr('I'));
    SQL.Add('WHERE icodigo = :icodigo');
    ParamByName('icodigo').AsInteger   := iCodigo;
    ExecSQL;
  end;
  FreeAndNil(ZQryGrupo);
end;

destructor TGrupo.Destroy;
begin
  FreeAndNil(zcoConnection);
end;

function TGrupo.iCamposConsistentes: Integer;
var
  iCont: SmallInt;
  slCampos: TStringList;
begin
  Result:=0;
  slCampos:=TStringList.Create;
  slCampos.CommaText:=sCamposObrigatorios('tbgrupo',zcoConnection);
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
      if (IntToStr(iGetCodigo) = '') or (iGetCodigo <= 0) then
      begin
        Result:=c_CampoVazio;
        raise eCampoNaoPreenchido.Create(StringReplace(asMensagemErro[c_CampoVazio],'%','Código',[rfReplaceAll]));
      end;
    end;
  end;
end;



function TGrupo.iGetCodigo: Integer;
begin
  Result := iCodigo;
end;

function TGrupo.iRetornaUltimoCodigo: Integer;
var
  ZQryGrupo: TZQuery;
begin
  ZQryGrupo := TZQuery.Create(nil);
  with ZQryGrupo do
  begin
    Connection := zcoConnection;
    SQL.Clear;
    SQL.Add('SELECT COALESCE(MAX(icodigo),0) AS ULTIMO FROM tbgrupo');
    Open;
    Result := FieldByName('ULTIMO').AsInteger;
  end;
  FreeAndNil(ZQryGrupo);
end;

procedure TGrupo.SetCodigo(piCodigo: Integer);
begin
  iCodigo := piCodigo;
end;

procedure TGrupo.SetDescricao(psDecricao: String);
begin
  sDescricao := psDecricao;
end;

procedure TGrupo.SetStatus(psStatus: String);
begin
  sStatus := psStatus;
end;

function TGrupo.sGetDescricao: String;
begin
  Result := sDescricao;
end;

function TGrupo.sGetStatus: String;
begin
  Result := sStatus;
end;

function TGrupo.sRetornaDescricaoPorCodigo: String;
var
  ZQryGrupo: TZQuery;
begin
  ZQryGrupo := TZQuery.Create(nil);
  with ZQryGrupo do
  begin
    Connection := zcoConnection;
    SQL.Clear;
    SQL.Add('SELECT sdescricao FROM tbgrupo');
    SQL.Add('WHERE icodigo = :icodigo');
    ParamByName('icodigo').AsInteger := iCodigo;
    Open;
    Result := FieldByName('sdescricao').AsString;
  end;
  FreeAndNil(ZQryGrupo);
end;

end.
