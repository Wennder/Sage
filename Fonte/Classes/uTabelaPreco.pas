unit uTabelaPreco;

interface

uses ZConnection, ZDataset, SysUtils, uConstantes, Classes, uProcedimentosBanco, uExceptions, Variants, Forms,
  Dialogs, Windows, uNumeros;

type
  TTabelaPreco = class
  public
    constructor Create(pzcoConnection: TZConnection);
    destructor Destroy; override;

    procedure CadastraTabelaPreco;
    procedure AlteraTabelaPreco;
    procedure DeletaTabelaPreco;
    function iCamposConsistentes: Integer;
    function iRetornaUltimoCodigo: Integer;
    function bPesquisaTabelaPreco(piCodigo: Integer): Boolean;

    function iGetCodigo: Integer;
    function sGetDescricao: string;
    function sGetStatus: string;

    procedure SetCodigo(piCodigo: Integer);
    procedure SetDescricao(psDescricao: string);
    procedure SetStatus(psStatus: string);
  private
    iCodigo: Integer;
    sDescricao: string;
    sStatus: string;
    zcoConnection: TZConnection;
  end;

implementation

uses ZAbstractDataset, ZAbstractRODataset, ComConst, DB;

{ TTabelaPreco }

procedure TTabelaPreco.AlteraTabelaPreco;
var
  ZQryTabelaPreco: TZQuery;
begin
  if iCamposConsistentes = 0 then
  begin
    ZQryTabelaPreco := TZQuery.Create(nil);
    with ZQryTabelaPreco do
    begin
      Connection := zcoConnection;
      SQL.Clear;
      SQL.Add('UPDATE tbtabelapreco SET sdescricao = :sdescricao, sstatus = :sstatus');
      SQL.Add('WHERE icodigo = :icodigo');
      ParamByName('sdescricao').AsString := sGetDescricao;
      ParamByName('icodigo').AsInteger := iGetCodigo;
      ParamByName('sstatus').AsString := sGetStatus;
      try
        ExecSQL;
      except
        on E: Exception do
          TrataErro(E.Message);
      end;
    end;
    FreeAndNil(ZQryTabelaPreco);
  end;
end;

function TTabelaPreco.bPesquisaTabelaPreco(piCodigo: Integer): Boolean;
var
  ZQryTabelaPreco: TZQuery;
begin
  Result := False;
  if piCodigo <> 0 then
  begin
    ZQryTabelaPreco := TZQuery.Create(nil);
    with ZQryTabelaPreco do
    begin
      Connection := zcoConnection;
      SQL.Clear;
      SQL.Add('SELECT * FROM tbtabelapreco WHERE icodigo = :icodigo');
      ParamByName('icodigo').AsInteger := piCodigo;
      Open;
      if not IsEmpty then
      begin
        Result := True;
        SetCodigo(FieldByName('icodigo').AsInteger);
        SetDescricao(FieldByName('sdescricao').AsString);
        SetStatus(FieldByName('sstatus').AsString);

        if sGetStatus = 'I' then
          if Application.MessageBox('Esta Tabela de Preço está Inativa! Deseja Reativar?', 'Reativar Tabela de Preço', MB_YESNO) = IDYES then
          begin
            SetStatus('A');
            AlteraTabelaPreco;
          end;
      end
      else
      begin
        SetCodigo(0);
        SetDescricao('');
        SetStatus('');
      end;
    end;
    FreeAndNil(ZQryTabelaPreco);
  end;
end;

procedure TTabelaPreco.CadastraTabelaPreco;
var
  ZQryTabelaPreco: TZQuery;
begin
  if iCamposConsistentes = 0 then
  begin
    ZQryTabelaPreco := TZQuery.Create(nil);
    with ZQryTabelaPreco do
    begin
      Connection := zcoConnection;
      SQL.Clear;
      SQL.Add('INSERT INTO tbtabelapreco(icodigo, sdescricao)');
      SQL.Add('VALUES(:icodigo, :sdescricao)');
      ParamByName('sdescricao').AsString := sGetDescricao;
      ParamByName('icodigo').AsInteger := iGetCodigo;
      try
        ExecSQL;
      except
        on E: Exception do
          TrataErro(E.Message);
      end;
    end;
    FreeAndNil(ZQryTabelaPreco);
  end;
end;

constructor TTabelaPreco.Create(pzcoConnection: TZConnection);
begin
  inherited Create;
  zcoConnection := pzcoConnection;
end;

procedure TTabelaPreco.DeletaTabelaPreco;
var
  ZQryTabelaPreco: TZQuery;
begin
  ZQryTabelaPreco := TZQuery.Create(nil);
  with ZQryTabelaPreco do
  begin
    Connection := zcoConnection;
    SQL.Clear;
    SQL.Add('UPDATE tbtabelapreco SET sstatus = ' + QuotedStr('I') + ' ');
    SQL.Add('WHERE icodigo = :icodigo');
    ParamByName('icodigo').AsInteger := iGetCodigo;
    ExecSQL;
  end;
  FreeAndNil(ZQryTabelaPreco);
end;

destructor TTabelaPreco.Destroy;
begin
  inherited;
end;

function TTabelaPreco.iCamposConsistentes: Integer;
var
  iCont: SmallInt;
  slCampos: TStringList;
begin
  Result := 0;
  slCampos := TStringList.Create;
  slCampos.CommaText := sCamposObrigatorios('tbtabelapreco', zcoConnection);

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
      if iGetCodigo = 0 then
      begin
        Result := c_CampoVazio;
        raise eCampoNaoPreenchido.Create(StringReplace(asMensagemErro[c_CampoVazio], '%', 'Código', [rfReplaceAll]));
      end;
    end;
  end;
  FreeAndNil(slCampos);
end;

function TTabelaPreco.iGetCodigo: Integer;
begin
  Result := iCodigo;
end;

function TTabelaPreco.iRetornaUltimoCodigo: Integer;
var
  ZQryTabelaPreco: TZQuery;
begin
  ZQryTabelaPreco := TZQuery.Create(nil);
  with ZQryTabelaPreco do
  begin
    Connection := zcoConnection;
    SQL.Clear;
    SQL.Add('SELECT COALESCE(MAX(icodigo),0) AS ULTIMO FROM tbtabelapreco');
    Open;
    Result := FieldByName('ULTIMO').AsInteger;
  end;
  FreeAndNil(ZQryTabelaPreco);
end;

procedure TTabelaPreco.SetCodigo(piCodigo: Integer);
begin
  iCodigo := piCodigo;
end;

procedure TTabelaPreco.SetDescricao(psDescricao: string);
begin
  sDescricao := psDescricao;
end;

procedure TTabelaPreco.SetStatus(psStatus: string);
begin
  sStatus := psStatus;
end;

function TTabelaPreco.sGetDescricao: string;
begin
  Result := sDescricao;
end;

function TTabelaPreco.sGetStatus: string;
begin
  Result := sStatus;
end;

end.
