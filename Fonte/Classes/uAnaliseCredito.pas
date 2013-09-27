unit uAnaliseCredito;

interface

uses ZConnection, ZDataset, SysUtils, uConstantes, Classes, uProcedimentosBanco, uExceptions, Variants, Forms,
  Dialogs, Windows, Controls, uCliente;

type
  TAnaliseCredito = class
    oCliente: TCliente;
    procedure SetCodigo(piCodigo: Integer);
    procedure SetLimiteCredito(pnLimiteCredito: Real);
    procedure SetVencimento(pdVencimento: TDate);
    procedure SetStatus(psStatus: string);

    function iGetCodigo: Integer;
    function nGetLimiteCredito: Real;
    function dGetVencimento: TDate;
    function sGetStatus: string;

    constructor Create(pzcoConnection: TZConnection);
    destructor Destroy; override;
    procedure CadastraAnalise;
    procedure AlteraAnalise;
    procedure DeletaAnalise;
    function bPesquisaAnalise(piCodigo: Integer): Boolean;

  private
    zcoConnection: TZConnection;
    iCodigo: Integer;
    nLimiteCredito: Real;
    dVencimento: TDate;
    sStatus: string;
    function iCamposConsistentes: Integer;

  end;

implementation

uses ZAbstractDataset, ZAbstractRODataset, DateUtils;

{ TAnaliseCredito }

procedure TAnaliseCredito.AlteraAnalise;
var
  ZQryAnalise: TZQuery;
begin
  if iCamposConsistentes = 0 then
  begin
    ZQryAnalise := TZQuery.Create(nil);
    with ZQryAnalise do
    begin
      Connection := zcoConnection;
      SQL.Clear;
      SQL.Add('UPDATE TbAnaliseCredito SET ');
      SQL.Add(' nLimiteCredito = :nLimiteCredito,');
      SQL.Add(' dVencimento = :dVencimento,');
      SQL.Add(' sStatus = :sStatus');
      SQL.Add('WHERE icodigo = :icodigo');
      ParamByName('nLimiteCredito').AsFloat := nGetLimiteCredito;
      ParamByName('dVencimento').AsDate := dGetVencimento;
      ParamByName('sStatus').AsString := sGetStatus;
      ParamByName('iCodigo').AsInteger := iGetCodigo;
      ExecSQL;
    end;
    FreeAndNil(ZQryAnalise);
  end;
end;

function TAnaliseCredito.bPesquisaAnalise(piCodigo: Integer): Boolean;
var
  ZQryAnalise: TZQuery;
begin
  ZQryAnalise := TZQuery.Create(nil);
  Result := False;
  with ZQryAnalise do
  begin
    Connection := zcoConnection;
    if oCliente.bPesquisaCliente(IntToStr(piCodigo)) then
    begin
      Result := True;
      SQL.Clear;
      SQL.Add('SELECT * FROM TbAnaliseCredito WHERE icodigo = :icodigo ');
      ParamByName('icodigo').AsInteger := piCodigo;
      Open;
      if not IsEmpty then
      begin
        SetCodigo(FieldByName('iCodigo').AsInteger);
        SetLimiteCredito(FieldByName('nLimiteCredito').AsFloat);
        SetVencimento(FieldByName('dVencimento').AsDateTime);
        SetStatus(FieldByName('sStatus').AsString);

        if sGetStatus = 'I' then
          if Application.MessageBox('Esta Análise de Crédito está Inativa! Deseja Reativar?', 'Reativar Análise de Crédito', MB_YESNO) = IDYES then
          begin
            SetStatus('A');
            AlteraAnalise;
            SetStatus('A');
          end;
      end
      else
      begin
        SetLimiteCredito(0);
        SetVencimento(Date);
        SetStatus('A');
      end;
    end;
  end;
  FreeAndNil(ZQryAnalise);
end;

procedure TAnaliseCredito.CadastraAnalise;
var
  ZQryAnalise: TZQuery;
begin
  if iCamposConsistentes = 0 then
  begin
    ZQryAnalise := TZQuery.Create(nil);
    with ZQryAnalise do
    begin
      Connection := zcoConnection;
      SQL.Clear;
      SQL.Add('select * from TbAnaliseCredito where icodigo = :icodigo');
      ParamByName('iCodigo').AsInteger := iGetCodigo;
      Open;
      if IsEmpty then
      begin
        SQL.Clear;
        SQL.Add('INSERT INTO tbAnaliseCredito(');
        SQL.Add(' iCodigo,');
        SQL.Add(' nLimiteCredito,');
        SQL.Add(' dVencimento,');
        SQL.Add(' sStatus)');
        SQL.Add(' VALUES(');
        SQL.Add(' :iCodigo,');
        SQL.Add(' :nLimiteCredito,');
        SQL.Add(' :dVencimento,');
        SQL.Add(' :sStatus)');
        ParamByName('iCodigo').AsInteger := iGetCodigo;
        ParamByName('nLimiteCredito').AsFloat := nGetLimiteCredito;
        ParamByName('dVencimento').AsDate := dGetVencimento;
        ParamByName('sStatus').AsString := sGetStatus;
        try
          ExecSQL;
        except
          on E: Exception do
          begin
            TrataErro(E.Message);
            Application.MessageBox(Pchar(E.Message), 'Erro', MB_OK);
          end;
        end;
      end
      else
        AlteraAnalise
    end;
    FreeAndNil(ZQryAnalise);
  end
end;

constructor TAnaliseCredito.Create(pzcoConnection: TZConnection);
begin
  zcoConnection := pzcoConnection;
  oCliente := TCliente.Create(pzcoConnection);
end;

procedure TAnaliseCredito.DeletaAnalise;
var
  ZQryAnalise: TZQuery;
begin
  ZQryAnalise := TZQuery.Create(nil);
  with ZQryAnalise do
  begin
    Connection := zcoConnection;
    SQL.Clear;
    SQL.Add('UPDATE TbAnaliseCredito SET sStatus = ' + QuotedStr('I') + ' ');
    SQL.Add('WHERE iCodigo = :iCodigo');
    ParamByName('iCodigo').AsInteger := iGetCodigo;
    ExecSQL;
  end;
  FreeAndNil(ZQryAnalise);
end;

destructor TAnaliseCredito.Destroy;
begin
  inherited;
end;

function TAnaliseCredito.dGetVencimento: TDate;
begin
  Result := dVencimento;
end;

function TAnaliseCredito.iGetCodigo: Integer;
begin
  Result := iCodigo;
end;

function TAnaliseCredito.nGetLimiteCredito: Real;
begin
  Result := nLimiteCredito;
end;

procedure TAnaliseCredito.SetCodigo(piCodigo: Integer);
begin
  iCodigo := piCodigo;
  oCliente.SetCodigo(IntToStr(piCodigo));
end;

procedure TAnaliseCredito.SetLimiteCredito(pnLimiteCredito: Real);
begin
  nLimiteCredito := pnLimiteCredito;
end;

procedure TAnaliseCredito.SetVencimento(pdVencimento: TDate);
begin
  dVencimento := pdVencimento;
end;

function TAnaliseCredito.sGetStatus: string;
begin
  Result := sStatus
end;

procedure TAnaliseCredito.SetStatus(psStatus: string);
begin
  sStatus := psStatus;
end;

function TAnaliseCredito.iCamposConsistentes: Integer;
var
  iCont: SmallInt;
  slCampos: TStringList;
begin
  Result := 0;
  slCampos := TStringList.Create;
  slCampos.CommaText := sCamposObrigatorios('TbAnaliseCredito', zcoConnection);
  for iCont := 0 to slCampos.Count - 1 do
  begin
    if AnsiLowerCase(slCampos.Strings[iCont]) = 'nlimitecredito' then
    begin
      if nGetLimiteCredito = 0 then
      begin
        raise eCampoNaoPreenchido.Create(StringReplace(asMensagemErro[c_CampoVazio], '%', 'Limite de Crédito', [rfReplaceAll]));
      end;
    end;
    if AnsiLowerCase(slCampos.Strings[iCont]) = 'icodigo' then
    begin
      if (IntToStr(iGetCodigo) = '') or (iGetCodigo <= 0) then
      begin
        raise eCampoNaoPreenchido.Create(StringReplace(asMensagemErro[c_CampoVazio], '%', 'Código', [rfReplaceAll]));
      end;
    end;
    if AnsiLowerCase(slCampos.Strings[iCont]) = 'dvencimento' then
    begin
      if (dGetVencimento = 0) then
      begin
        raise eCampoNaoPreenchido.Create(StringReplace(asMensagemErro[c_CampoVazio], '%', 'Vencimento', [rfReplaceAll]));
      end
      else if (dGetVencimento < Today) then
      begin
        raise eDataMenorAtual.Create(StringReplace(asMensagemErro[c_DataMenorAtual], '%', 'Vencimento', [rfReplaceAll]));
      end;
    end;
  end;
end;

end.
