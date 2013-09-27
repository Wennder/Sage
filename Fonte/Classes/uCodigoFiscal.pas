unit uCodigoFiscal;

interface

uses ZConnection, ZDataset, SysUtils, uConstantes, Classes, uProcedimentosBanco, uExceptions, Variants, Forms,
  Dialogs, Windows;

type
  TCodigoFiscal = class
  public
    procedure SetiCodigo(piCodigo: Integer);
    procedure SetsDescricao(psDescricao: string);
    procedure SetsStatus(psStatus: string);
    procedure SetnIcmsPF(pnIcmsPF: Real);
    procedure SetnIcmsPJ(pnIcmsPJ: Real);

    function iGetCodigo: Integer;
    function sGetDescricao: string;
    function sGetStatus: string;
    function nGetIcmsPF: Real;
    function nGetIcmsPJ: Real;
    function bPesquisaCodigoFiscal(piCodigo: Integer): Boolean;
    constructor Create(pzcoConnection: TZConnection);
    destructor Destroy; override;

    procedure CadastraCodigoFiscal;
    procedure AlteraCodigoFiscal;
    procedure DeletaCodigoFiscal;
  private
    zcoConnection: TZConnection;
    iCodigo: Integer;
    sDescricao: string;
    nIcmsPF: Real;
    nIcmsPJ: Real;
    sStatus: string;
    function iCamposConsistentes: Integer;
  end;

implementation

uses ZAbstractDataset, ZAbstractRODataset, ComConst, DB;

{ TCodigoFiscal }

procedure TCodigoFiscal.AlteraCodigoFiscal;
var
  ZQryCodigoFiscal: TZQuery;
begin
  if iCamposConsistentes = 0 then
  begin
    ZQryCodigoFiscal := TZQuery.Create(nil);
    with ZQryCodigoFiscal do
    begin
      Connection := zcoConnection;
      SQL.Clear;
      SQL.Add('UPDATE tbcodigofiscal SET sdescricao = :sdescricao, sstatus = :sstatus,');
      SQL.Add('nicmspf = :nicmspf, nicmspj = :nicmspj');
      SQL.Add('WHERE icodigo = :icodigo');
      ParamByName('sdescricao').AsString := sDescricao;
      ParamByName('icodigo').AsInteger := iCodigo;
      ParamByName('sstatus').AsString := sStatus;
      ParamByName('nicmspf').AsFloat := nIcmsPF;
      ParamByName('nicmspj').AsFloat := nIcmsPJ;
      ExecSQL;
    end;
    FreeAndNil(ZQryCodigoFiscal);
  end;
end;

function TCodigoFiscal.bPesquisaCodigoFiscal(piCodigo: Integer): Boolean;
var
  ZQryCodigoFiscal: TZQuery;
begin
  ZQryCodigoFiscal := TZQuery.Create(nil);
  Result := False;
  with ZQryCodigoFiscal do
  begin
    Connection := zcoConnection;
    SQL.Clear;
    SQL.Add('SELECT * FROM tbcodigofiscal WHERE icodigo = :icodigo');
    ParamByName('icodigo').AsInteger := piCodigo;
    Open;
    if not IsEmpty then
    begin
      Result := True;
      SetiCodigo(FieldByName('icodigo').AsInteger);
      SetsDescricao(FieldByName('sdescricao').AsString);
      SetsStatus(FieldByName('sstatus').AsString);
      SetnIcmsPF(FieldByName('nicmspf').AsFloat);
      SetnIcmsPJ(FieldByName('nicmspj').AsFloat);
      if sGetStatus = 'I' then
        if Application.MessageBox('Este Código Fiscal está Inativo! Deseja Reativar?', 'Reativar Código Fiscal', MB_YESNO) = IDYES then
        begin
          SetsStatus('A');
          AlteraCodigoFiscal;
          SetsStatus('A');
        end;
    end
    else
    begin
      SetiCodigo(-1);
      SetsDescricao('');
      SetnIcmsPF(0);
      SetnIcmsPJ(0);
    end;
  end;
  FreeAndNil(ZQryCodigoFiscal);
end;

procedure TCodigoFiscal.CadastraCodigoFiscal;
var
  ZQryCodigoFiscal: TZQuery;
begin
  if iCamposConsistentes = 0 then
  begin
    ZQryCodigoFiscal := TZQuery.Create(nil);
    with ZQryCodigoFiscal do
    begin
      Connection := zcoConnection;
      SQL.Clear;
      SQL.Add('INSERT INTO tbcodigofiscal(icodigo, sdescricao, sstatus, nicmspf, nicmspj)');
      SQL.Add('VALUES(:icodigo, :sdescricao, :sstatus, :nicmspf, :nicmspj)');
      ParamByName('sdescricao').AsString := sDescricao;
      ParamByName('icodigo').AsInteger := iCodigo;
      ParamByName('sstatus').AsString := 'A';
      ParamByName('nicmspf').AsFloat := nIcmsPF;
      ParamByName('nicmspj').AsFloat := nIcmsPJ;
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
    FreeAndNil(ZQryCodigoFiscal);
  end;
end;

constructor TCodigoFiscal.Create(pzcoConnection: TZConnection);
begin
  inherited Create;
  zcoConnection := pzcoConnection;
end;

procedure TCodigoFiscal.DeletaCodigoFiscal;
var
  ZQryCodigoFiscal: TZQuery;
begin
  ZQryCodigoFiscal := TZQuery.Create(nil);
  with ZQryCodigoFiscal do
  begin
    Connection := zcoConnection;
    SQL.Clear;
    SQL.Add('UPDATE tbcodigofiscal SET sstatus = ' + QuotedStr('I') + ' ');
    SQL.Add('WHERE icodigo = :icodigo');
    ParamByName('icodigo').AsInteger := iGetCodigo;
    ExecSQL;
  end;
  FreeAndNil(ZQryCodigoFiscal);
end;

destructor TCodigoFiscal.Destroy;
begin
end;

function TCodigoFiscal.iCamposConsistentes: Integer;
var
  iCont: SmallInt;
  slCampos: TStringList;
begin
  Result := 0;
  slCampos := TStringList.Create;
  slCampos.CommaText := sCamposObrigatorios('tbcodigofiscal', zcoConnection);

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

function TCodigoFiscal.iGetCodigo: Integer;
begin
  Result := iCodigo;
end;

function TCodigoFiscal.nGetIcmsPF: Real;
begin
  Result := nIcmsPF;
end;

function TCodigoFiscal.nGetIcmsPJ: Real;
begin
  Result := nIcmsPJ;
end;

procedure TCodigoFiscal.SetiCodigo(piCodigo: Integer);
begin
  iCodigo := piCodigo;
end;

procedure TCodigoFiscal.SetnIcmsPF(pnIcmsPF: Real);
begin
  nIcmsPF := pnIcmsPF;
end;

procedure TCodigoFiscal.SetnIcmsPJ(pnIcmsPJ: Real);
begin
  nIcmsPJ := pnIcmsPJ;
end;

procedure TCodigoFiscal.SetsDescricao(psDescricao: string);
begin
  sDescricao := psDescricao;
end;

procedure TCodigoFiscal.SetsStatus(psStatus: string);
begin
  sStatus := psStatus;
end;

function TCodigoFiscal.sGetDescricao: string;
begin
  Result := sDescricao;
end;

function TCodigoFiscal.sGetStatus: string;
begin
  Result := sStatus;
end;

end.
