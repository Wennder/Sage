unit uUnidade;

interface

uses ZConnection, ZDataset, SysUtils, uConstantes, Classes, uProcedimentosBanco, uExceptions, Variants, Forms,
     Dialogs, Windows;

type
  TUnidade = class
  public
    function iGetCodigo: Integer;
    function sGetDescricao: String;
    function sGetStatus: String;
    procedure SetCodigo(piCodigo: Integer);
    procedure SetDescricao(psDescricao: String);
    procedure SetStatus(psStatus: String);

    function iRetornaUltimoCodigo: Integer;
    function sRetornaDescricaoPorCodigo: String;
    function bPesquisaUnidade(piCodigo: Integer): Boolean;

    constructor Create(pzcoConnection: TZConnection);
    destructor Destroy; override;
    procedure CadastraUnidade;
    procedure AlteraUnidade;
    procedure DeletaUnidade;
  private
    zcoConnection: TZConnection;
    iCodigo: Integer;
    sDescricao: String;
    sStatus: String;
    function iCamposConsistentes: Integer;
  end;

implementation

uses ZAbstractDataset, ZAbstractRODataset;

{ TUnidade }

procedure TUnidade.AlteraUnidade;
var
  ZQryUnidade: TZQuery;
begin
  if iCamposConsistentes = 0 then
  begin
    ZQryUnidade := TZQuery.Create(nil);
    with ZQryUnidade do
    begin
      Connection := zcoConnection;
      SQL.Clear;
      SQL.Add('UPDATE tbUnidade SET sdescricao = :sdescricao, sstatus = :sstatus');
      SQL.Add('WHERE icodigo = :icodigo');
      ParamByName('sdescricao').AsString := sDescricao;
      ParamByName('icodigo').AsInteger   := iCodigo;
      ParamByName('sstatus').AsString    := sStatus;
      ExecSQL;
    end;
     FreeAndNil(ZQryUnidade);
  end;
end;

function TUnidade.bPesquisaUnidade(piCodigo: Integer): Boolean;
var
  ZQryUnidade: TZQuery;
begin
  ZQryUnidade := TZQuery.Create(nil);
  Result:=False;
  with ZQryUnidade do
  begin
    Connection := zcoConnection;
    SQL.Clear;
    SQL.Add('SELECT * FROM tbunidade WHERE icodigo = :icodigo');
    ParamByName('icodigo').AsInteger:=piCodigo;
    Open;
    if not IsEmpty then
    begin
      Result:=True;
      SetCodigo(FieldByName('icodigo').AsInteger);
      SetDescricao(FieldByName('sdescricao').AsString);
      SetStatus(FieldByName('sstatus').AsString);
      if sGetStatus = 'I' then
        if Application.MessageBox('Esta Unidade está Inativa! Deseja Reativar?','Reativar Unidade',MB_YESNO) = IDYES then
        begin
          SetStatus('A');
          AlteraUnidade;
          SetStatus('A');
        end;
    end
    else
    begin
      SetCodigo(-1);
      SetDescricao('');
    end;
  end;
  FreeAndNil(ZQryUnidade);
end;

procedure TUnidade.CadastraUnidade();
var
  ZQryUnidade: TZQuery;
begin
  if iCamposConsistentes = 0 then
  begin
    ZQryUnidade := TZQuery.Create(nil);
    with ZQryUnidade do
    begin
      Connection := zcoConnection;
      SQL.Clear;
      SQL.Add('INSERT INTO tbunidade(icodigo, sdescricao)');
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
    FreeAndNil(ZQryUnidade);
  end;
end;

constructor TUnidade.Create(pzcoConnection: TZConnection);
begin
  inherited Create;
  zcoConnection := pzcoConnection;
end;

procedure TUnidade.DeletaUnidade;
var
  ZQryUnidade: TZQuery;
begin
  ZQryUnidade := TZQuery.Create(nil);
  with ZQryUnidade do
  begin
    Connection := zcoConnection;
    SQL.Clear;
    SQL.Add('UPDATE tbunidade SET sstatus = ' + QuotedStr('I') + ' ');
    SQL.Add('WHERE icodigo = :icodigo');
    ParamByName('icodigo').AsInteger := iGetCodigo;
    ExecSQL;
  end;
  FreeAndNil(ZQryUnidade);
end;

destructor TUnidade.Destroy;
begin
  FreeAndNil(zcoConnection);
end;

function TUnidade.iCamposConsistentes: Integer;
var
  iCont: SmallInt;
  slCampos: TStringList;
begin
  Result:=0;
  slCampos:=TStringList.Create;
  slCampos.CommaText:=sCamposObrigatorios('tbunidade',zcoConnection);
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

function TUnidade.iGetCodigo: Integer;
begin
  Result := iCodigo;
end;

function TUnidade.iRetornaUltimoCodigo: Integer;
var
  ZQryUnidade: TZQuery;
begin
  ZQryUnidade := TZQuery.Create(nil);
  with ZQryUnidade do
  begin
    Connection := zcoConnection;
    SQL.Clear;
    SQL.Add('SELECT COALESCE(MAX(icodigo),0) AS ULTIMO FROM tbunidade');
    Open;
    Result := FieldByName('ULTIMO').AsInteger;
  end;
  FreeAndNil(ZQryUnidade);
end;

procedure TUnidade.SetCodigo(piCodigo: Integer);
begin
  iCodigo := piCodigo;
end;

procedure TUnidade.SetDescricao(psDescricao: String);
begin
  sDescricao := psDescricao;
end;

procedure TUnidade.SetStatus(psStatus: String);
begin
  sStatus := psStatus;
end;

function TUnidade.sGetDescricao: String;
begin
  Result := sDescricao;
end;

function TUnidade.sGetStatus: String;
begin
  Result := sStatus;
end;

function TUnidade.sRetornaDescricaoPorCodigo: String;
var
  ZQryUnidade: TZQuery;
begin
  ZQryUnidade := TZQuery.Create(nil);
  with ZQryUnidade do
  begin
    Connection := zcoConnection;
    SQL.Clear;
    SQL.Add('SELECT sdescricao FROM tbunidade');
    SQL.Add('WHERE icodigo = :icodigo');
    ParamByName('icodigo').AsInteger := iCodigo;
    Open;
    Result := FieldByName('sdescricao').AsString;
  end;
  FreeAndNil(ZQryUnidade);
end;

end.
