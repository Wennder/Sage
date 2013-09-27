unit uCor;

interface

uses ZConnection, ZDataset, SysUtils, uConstantes, Classes, uProcedimentosBanco, uExceptions, Variants, Forms,
     Dialogs, Windows;

type
  TCor = class
  public
    procedure SetCodigo(piCodigo: Integer);
    procedure SetDescricao(psDescricao: String);
    procedure SetStatus(psStatus: String);
    function iGetCodigo: Integer;
    function sGetDescricao: String;
    function sGetStatus: String;
    function iRetornaUltimoCodigo: Integer;
    function sRetornaDescricaoPorCodigo: String;
    function bPesquisaCor(piCodigo: Integer): Boolean;
    constructor Create(pzcoConnection: TZConnection);
    destructor Destroy; override;
    procedure CadastraCor;
    procedure AlteraCor;
    procedure DeletaCor;
  private
    zcoConnection: TZConnection;
    iCodigo: Integer;
    sDescricao: String;
    sStatus: String;
    function iCamposConsistentes: Integer;
  end;

implementation

uses ZAbstractDataset, ZAbstractRODataset;

{ TCor }

procedure TCor.AlteraCor;
var
  ZQryCor: TZQuery;
begin
  if iCamposConsistentes = 0 then
  begin
  ZQryCor := TZQuery.Create(nil);
    with ZQryCor do
    begin
      Connection := zcoConnection;
      SQL.Clear;
      SQL.Add('UPDATE tbcor SET sdescricao = :sdescricao, sstatus = :sstatus');
      SQL.Add('WHERE icodigo = :icodigo');
      ParamByName('sdescricao').AsString := sDescricao;
      ParamByName('icodigo').AsInteger   := iCodigo;
      ParamByName('sstatus').AsString    := sStatus; 
      ExecSQL;
    end;
     FreeAndNil(ZQryCor);
  end;
end;

function TCor.iCamposConsistentes: Integer;
var
  iCont: SmallInt;
  slCampos: TStringList;
begin
  Result:=0;
  slCampos:=TStringList.Create;
  slCampos.CommaText:=sCamposObrigatorios('tbcor',zcoConnection);
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


procedure TCor.CadastraCor;
var
  ZQryCor: TZQuery;
begin
  if iCamposConsistentes = 0 then
  begin
    ZQryCor := TZQuery.Create(nil);
    with ZQryCor do
    begin
      Connection := zcoConnection;
      SQL.Clear;
      SQL.Add('INSERT INTO tbcor(icodigo, sdescricao, sstatus)');
      SQL.Add('VALUES(:icodigo, :sdescricao, :sstatus)');
      ParamByName('sdescricao').AsString := sDescricao;
      ParamByName('icodigo').AsInteger   := iCodigo;
      ParamByName('sstatus').AsString    := sStatus;
      try
        ExecSQL;
      except
        on E: Exception do begin
          TrataErro(E.Message);
          Application.MessageBox(Pchar(E.Message),'Erro',MB_OK);
        end;
      end;
    end;
    FreeAndNil(ZQryCor);
  end;
end;

constructor TCor.Create(pzcoConnection: TZConnection);
begin
  inherited Create;
  zcoConnection := pzcoConnection;
end;

procedure TCor.DeletaCor;
var
  ZQryCor: TZQuery;
begin
  ZQryCor := TZQuery.Create(nil);
  with ZQryCor do
  begin
    Connection := zcoConnection;
    SQL.Clear;
    SQL.Add('UPDATE tbcor SET sstatus = ' + QuotedStr('I') + ' ');
    SQL.Add('WHERE icodigo = :icodigo');
    ParamByName('icodigo').AsInteger := iGetCodigo;
    ExecSQL;
  end;
  FreeAndNil(ZQryCor);
end;

destructor TCor.Destroy;
begin
end;

function TCor.iGetCodigo: Integer;
begin
  Result := iCodigo;
end;

procedure TCor.SetCodigo(piCodigo: Integer);
begin
  iCodigo := piCodigo;
end;

procedure TCor.SetDescricao(psDescricao: String);
begin
  sDescricao := psDescricao;
end;

procedure TCor.SetStatus(psStatus: String);
begin
  sStatus := psStatus;
end;

function TCor.sGetDescricao: String;
begin
  Result := sDescricao;
end;

function TCor.sGetStatus: String;
begin
  Result := sStatus;
end;

function TCor.bPesquisaCor(piCodigo: Integer): Boolean;
var
  ZQryCor: TZQuery;
begin
  ZQryCor := TZQuery.Create(nil);
  Result:=False;
  with ZQryCor do
  begin
    Connection := zcoConnection;
    SQL.Clear;
    SQL.Add('SELECT * FROM tbcor WHERE icodigo = :icodigo');
    ParamByName('icodigo').AsInteger:=piCodigo;
    Open;
    if not IsEmpty then
    begin
      Result:=True;
      SetCodigo(FieldByName('icodigo').AsInteger);
      SetDescricao(FieldByName('sdescricao').AsString);
      SetStatus(FieldByName('sstatus').AsString);
      if sGetStatus = 'I' then
        if Application.MessageBox('Esta Cor está Inativa! Deseja Reativar?','Reativar Cor',MB_YESNO) = IDYES then
        begin
          SetStatus('A');
          AlteraCor;
          SetStatus('A');
        end;
    end
    else
    begin
      SetCodigo(-1);
      SetDescricao('');
    end;
  end;
  FreeAndNil(ZQryCor);
end;

function TCor.iRetornaUltimoCodigo: Integer;
var
  ZQryCor: TZQuery;
begin
  ZQryCor := TZQuery.Create(nil);
  with ZQryCor do
  begin
    Connection := zcoConnection;
    SQL.Clear;
    SQL.Add('SELECT COALESCE(MAX(icodigo),0) AS ULTIMO FROM tbcor');
    Open;
    Result := FieldByName('ULTIMO').AsInteger;
  end;
  FreeAndNil(ZQryCor);
end;

function TCor.sRetornaDescricaoPorCodigo: String;
var
  ZQryCor: TZQuery;
begin
  ZQryCor := TZQuery.Create(nil);
  with ZQryCor do
  begin
    Connection := zcoConnection;
    SQL.Clear;
    SQL.Add('SELECT sdescricao FROM tbcor');
    SQL.Add('WHERE icodigo = :icodigo');
    ParamByName('icodigo').AsInteger := iCodigo;
    Open;
    Result := FieldByName('sdescricao').AsString;
  end;
  FreeAndNil(ZQryCor);
end;

end.
