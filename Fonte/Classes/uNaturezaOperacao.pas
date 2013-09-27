unit uNaturezaOperacao;

interface

uses ZConnection, ZDataset, SysUtils, uConstantes, Classes, uProcedimentosBanco, uExceptions, Variants, Forms,
     Dialogs, Windows;

type
  TNaturezaOperacao = class
  public
    procedure SetiCodigo(piCodigo: Integer);
    procedure SetsDescricao(psDescricao: String);
    procedure SetsStatus(psStatus: String);

    function iGetCodigo: Integer;
    function sGetDescricao: String;
    function sGetStatus: String;
    function iRetornaUltimoCodigo: Integer;
    function bPesquisaNaturezaOperacao(piCodigo: Integer): Boolean;
    constructor Create(pzcoConnection: TZConnection);
    destructor Destroy; override;
    procedure CadastraNaturezaOperacao;
    procedure AlteraNaturezaOperacao;
    procedure DeletaNaturezaOperacao;
  private
    zcoConnection: TZConnection;
    iCodigo: Integer;
    sDescricao: String;
    sStatus: String;
    function iCamposConsistentes: Integer;
  end;

implementation

uses ZAbstractDataset, ZAbstractRODataset, ComConst, DB;

{ TNaturezaOperacao }

procedure TNaturezaOperacao.AlteraNaturezaOperacao;
var
  ZQryNaturezaOperacao: TZQuery;
begin
  if iCamposConsistentes = 0 then
  begin
    ZQryNaturezaOperacao := TZQuery.Create(nil);
    with ZQryNaturezaOperacao do
    begin
      Connection := zcoConnection;
      SQL.Clear;
      SQL.Add('UPDATE tbnatureza SET sdescricao = :sdescricao, sstatus = :sstatus');
      SQL.Add('WHERE icodigo = :icodigo');
      ParamByName('sdescricao').AsString := sDescricao;
      ParamByName('icodigo').AsInteger   := iCodigo;
      ParamByName('sstatus').AsString    := sStatus;
      ExecSQL;
    end;
     FreeAndNil(ZQryNaturezaOperacao);
  end;
end;


function TNaturezaOperacao.bPesquisaNaturezaOperacao(
  piCodigo: Integer): Boolean;
var
  ZQryNaturezaOperacao: TZQuery;
begin
  ZQryNaturezaOperacao := TZQuery.Create(nil);
  Result:=False;
  with ZQryNaturezaOperacao do
  begin
    Connection := zcoConnection;
    SQL.Clear;
    SQL.Add('SELECT * FROM tbnatureza WHERE icodigo = :icodigo');
    ParamByName('icodigo').AsInteger:=piCodigo;
    Open;
    if not IsEmpty then
    begin
      Result:=True;
      SetiCodigo(FieldByName('icodigo').AsInteger);
      SetsDescricao(FieldByName('sdescricao').AsString);
      SetsStatus(FieldByName('sstatus').AsString);
      if sGetStatus = 'I' then
        if Application.MessageBox('Esta Natureza de Operação está Inativa! Deseja Reativar?','Reativar Natureza de Operação',MB_YESNO) = IDYES then
        begin
          SetsStatus('A');
          AlteraNaturezaOperacao;
          SetsStatus('A');
        end;
    end
    else
    begin
      SetiCodigo(-1);
      SetsDescricao('');
    end;
  end;
  FreeAndNil(ZQryNaturezaOperacao);
end;

procedure TNaturezaOperacao.CadastraNaturezaOperacao;
var
  ZQryNaturezaOperacao: TZQuery;
begin
    if iCamposConsistentes = 0 then
    begin
      ZQryNaturezaOperacao := TZQuery.Create(nil);
      with ZQryNaturezaOperacao do
      begin
        Connection := zcoConnection;
        SQL.Clear;
        SQL.Add('INSERT INTO tbnatureza(icodigo, sdescricao, sstatus)');
        SQL.Add('VALUES(:icodigo, :sdescricao, :sstatus)');
        ParamByName('sdescricao').AsString := sDescricao;
        ParamByName('icodigo').AsInteger   := iCodigo;
        ParamByName('sstatus').AsString   := 'A';
        try
          ExecSQL;
        except
          on E: Exception do begin
            TrataErro(E.Message);
            Application.MessageBox(Pchar(E.Message),'Erro',MB_OK);
          end;
      end;
    end;
    FreeAndNil(ZQryNaturezaOperacao);
  end;
end;

constructor TNaturezaOperacao.Create(pzcoConnection: TZConnection);
begin
  inherited Create;
  zcoConnection := pzcoConnection;
end;

procedure TNaturezaOperacao.DeletaNaturezaOperacao;
var
  ZQryNaturezaOperacao: TZQuery;
begin
  ZQryNaturezaOperacao := TZQuery.Create(nil);
  with ZQryNaturezaOperacao do
  begin
    Connection := zcoConnection;
    SQL.Clear;
    SQL.Add('UPDATE tbnatureza SET sstatus = ' + QuotedStr('I') + ' ');
    SQL.Add('WHERE icodigo = :icodigo');
    ParamByName('icodigo').AsInteger := iGetCodigo;
    ExecSQL;
  end;
  FreeAndNil(ZQryNaturezaOperacao);
end;


destructor TNaturezaOperacao.Destroy;
begin
end;

function TNaturezaOperacao.iCamposConsistentes: Integer;
var
  iCont: SmallInt;
  slCampos: TStringList;
begin
  Result:=0;
  slCampos:=TStringList.Create;
  slCampos.CommaText:=sCamposObrigatorios('tbnatureza',zcoConnection);

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

function TNaturezaOperacao.iGetCodigo: Integer;
begin
  Result := iCodigo;
end;

function TNaturezaOperacao.iRetornaUltimoCodigo: Integer;
var
  ZQryNaturezaOperacao: TZQuery;
begin
  ZQryNaturezaOperacao := TZQuery.Create(nil);
  with ZQryNaturezaOperacao do
  begin
    Connection := zcoConnection;
    SQL.Clear;
    SQL.Add('SELECT COALESCE(MAX(icodigo),0) AS ULTIMO FROM tbnatureza');
    Open;
    Result := FieldByName('ULTIMO').AsInteger;
  end;
  FreeAndNil(ZQryNaturezaOperacao);
end;


procedure TNaturezaOperacao.SetiCodigo(piCodigo: Integer);
begin
  iCodigo := piCodigo;
end;

procedure TNaturezaOperacao.SetsDescricao(psDescricao: String);
begin
  sDescricao := psDescricao;
end;

procedure TNaturezaOperacao.SetsStatus(psStatus: String);
begin
  sStatus := psStatus;
end;

function TNaturezaOperacao.sGetDescricao: String;
begin
  Result := sDescricao;
end;

function TNaturezaOperacao.sGetStatus: String;
begin
  Result := sStatus;
end;

end.
