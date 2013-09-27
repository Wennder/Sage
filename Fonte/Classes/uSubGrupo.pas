unit uSubGrupo;

interface

uses ZConnection, ZDataset, SysUtils, uConstantes, Classes, uProcedimentosBanco, uExceptions, Variants, Forms,
     Dialogs, Windows, uGrupo;

type
  TSubGrupo = class
  public
    oGrupo: TGrupo;
    function iGetCodigo: Integer;
    function sGetDescricao: String;
    function sGetStatus: String;
    procedure SetCodigo(piCodigo: Integer);
    procedure SetDescricao(psDescricao: String);
    procedure SetStatus(psStatus: String);
    constructor Create(pzcoConnection: TZConnection);
    destructor Destroy; override;
    procedure CadastraSubGrupo;
    procedure AlteraSubGrupo;
    procedure DeletaSubGrupo;
    function bPesquisaSubGrupo(piCodigo, piGrupo: Integer): Boolean;
    function iRetornaUltimoCodigo: Integer;
  private
    zcoConnection: TZConnection;
    iCodigo: Integer;
    sDescricao: String;
    sStatus: String;
    function iCamposConsistentes: Integer;
  end;

implementation

uses ZAbstractDataset, ZAbstractRODataset;

{ TSubGrupo }

procedure TSubGrupo.AlteraSubGrupo();
var
  ZQrySubGrupo: TZQuery;
begin
  if iCamposConsistentes = 0 then
  begin
    ZQrySubGrupo := TZQuery.Create(nil);
    with ZQrySubGrupo do
    begin
      Connection := zcoConnection;
      SQL.Clear;
      SQL.Add('UPDATE tbSubGrupo SET sdescricao = :sdescricao, sstatus = :sstatus');
      SQL.Add('WHERE icodigo = :icodigo and iGrupo = :iGrupo');
      ParamByName('sdescricao').AsString := sDescricao;
      ParamByName('icodigo').AsInteger   := iCodigo;
      ParamByName('sstatus').AsString    := sStatus;
      ParamByName('iGrupo').AsInteger    := oGrupo.iGetCodigo;
      ExecSQL;
    end;
    FreeAndNil(ZQrySubGrupo);
  end;
end;

function TSubGrupo.iCamposConsistentes: Integer;
var
  iCont: SmallInt;
  slCampos: TStringList;
begin
  Result:=0;
  slCampos:=TStringList.Create;
  slCampos.CommaText:=sCamposObrigatorios('tbsubgrupo',zcoConnection);

  for iCont:=0 to slCampos.Count - 1 do
  begin
    if AnsiLowerCase(slCampos.Strings[iCont]) = 'sdescricao' then
    begin
      if Trim(sGetDescricao) = '' then
      begin
        Result:=c_CampoVazio;
        eCampoNaoPreenchido.Create(StringReplace(asMensagemErro[c_CampoVazio],'%','Descrição',[rfReplaceAll]));
      end;
    end;
    if AnsiLowerCase(slCampos.Strings[iCont]) = 'icodigo' then
    begin
      if (IntToStr(iGetCodigo) = '') or (iGetCodigo <= 0) then
      begin
        Result:=c_CampoVazio;
        eCampoNaoPreenchido.Create(StringReplace(asMensagemErro[c_CampoVazio],'%','Código',[rfReplaceAll]));
      end;
    end;
    if AnsiLowerCase(slCampos.Strings[iCont]) = 'igrupo' then
    begin
      if (IntToStr(oGrupo.iGetCodigo) = '') or (oGrupo.iGetCodigo <= 0) then
      begin
        Result:=c_CampoVazio;
        eCampoNaoPreenchido.Create(StringReplace(asMensagemErro[c_CampoVazio],'%','Grupo',[rfReplaceAll]));
      end;
    end;
  end;
end;


procedure TSubGrupo.CadastraSubGrupo;
var
  ZQrySubGrupo: TZQuery;
begin
  if iCamposConsistentes = 0 then
  begin
    ZQrySubGrupo := TZQuery.Create(nil);
    with ZQrySubGrupo do
    begin
      Connection := zcoConnection;
      SQL.Clear;
      SQL.Add('INSERT INTO tbSubGrupo(icodigo, igrupo, sdescricao)');
      SQL.Add('VALUES(:icodigo, :igrupo, :sdescricao)');
      ParamByName('sdescricao').AsString := sGetDescricao;
      ParamByName('icodigo').AsInteger   := iGetCodigo;
      ParamByName('igrupo').AsInteger    := oGrupo.iGetCodigo;
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
    FreeAndNil(ZQrySubGrupo);
  end;
end;

constructor TSubGrupo.Create(pzcoConnection: TZConnection);
begin
  inherited Create;
  zcoConnection := pzcoConnection;
  oGrupo := TGrupo.Create(pzcoConnection);
end;

procedure TSubGrupo.DeletaSubGrupo;
var
  ZQrySubGrupo: TZQuery;
begin
  ZQrySubGrupo := TZQuery.Create(nil);
  with ZQrySubGrupo do
  begin
    Connection := zcoConnection;
    SQL.Clear;
    SQL.Add('UPDATE tbsubgrupo SET sstatus = ' + QuotedStr('I') + ' ');
    SQL.Add('WHERE icodigo = :icodigo and igrupo = :igrupo');
    ParamByName('icodigo').AsInteger   := iGetCodigo;
    ParamByName('igrupo').AsInteger   := oGrupo.iGetCodigo;
    ExecSQL;
  end;
  FreeAndNil(ZQrySubGrupo);
end;

destructor TSubGrupo.Destroy;
begin
  FreeAndNil(zcoConnection);
end;

function TSubGrupo.iGetCodigo: Integer;
begin
  Result := iCodigo;
end;

procedure TSubGrupo.SetCodigo(piCodigo: Integer);
begin
  iCodigo := piCodigo;
end;

procedure TSubGrupo.SetDescricao(psDescricao: String);
begin
  sDescricao := psDescricao;
end;

procedure TSubGrupo.SetStatus(psStatus: String);
begin
  sStatus := psStatus;
end;

function TSubGrupo.sGetDescricao: String;
begin
  Result := sDescricao;
end;

function TSubGrupo.sGetStatus: String;
begin
  Result := sStatus;
end;

function TSubGrupo.bPesquisaSubGrupo(piCodigo, piGrupo: Integer): Boolean;
var
  ZQrySubGrupo: TZQuery;
begin
  ZQrySubGrupo := TZQuery.Create(nil);
  Result:=False;
  with ZQrySubGrupo do
  begin
    Connection := zcoConnection;
    SQL.Clear;
    SQL.Add('SELECT * FROM tbsubgrupo WHERE icodigo = :icodigo and igrupo = :igrupo');
    ParamByName('icodigo').AsInteger :=piCodigo;
    ParamByName('igrupo' ).AsInteger := piGrupo;
    Open;
    if not IsEmpty then
    begin
      Result:=True;
      SetCodigo(FieldByName('icodigo').AsInteger);
      SetDescricao(FieldByName('sdescricao').AsString);
      SetStatus(FieldByName('sstatus').AsString);
      if sGetStatus = 'I' then
        if Application.MessageBox('Este SubGrupo está Inativo! Deseja Reativar?','Reativar SubGrupo',MB_YESNO) = IDYES then
        begin
          SetStatus('A');
          AlteraSubGrupo;
          SetStatus('A');
        end;
      oGrupo.bPesquisaGrupo(piGrupo);
    end
    else
    begin
      SetCodigo(-1);
      SetDescricao('');
    end;
  end;
  FreeAndNil(ZQrySubGrupo);
end;

function TSubGrupo.iRetornaUltimoCodigo: Integer;
var
  ZQrySubGrupo: TZQuery;
begin
  ZQrySubGrupo := TZQuery.Create(nil);
  with ZQrySubGrupo do
  begin
    Connection := zcoConnection;
    SQL.Clear;
    SQL.Add('SELECT COALESCE(MAX(icodigo),0) AS ULTIMO FROM tbsubgrupo');
    SQL.Add('WHERE igrupo = :igrupo');
    ParamByName('igrupo').AsInteger := oGrupo.iGetCodigo;
    Open;
    Result := FieldByName('ULTIMO').AsInteger;
  end;
  FreeAndNil(ZQrySubGrupo);
end;


end.
