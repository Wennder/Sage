unit uComissionado;

interface

uses ZConnection, ZDataset, SysUtils, uPessoa, uRamoAtividade, Forms, Classes, Windows, uExceptions, uConstantes,
     uProcedimentosBanco, uCidade, uNumeros;

{
CREATE TABLE TbComissionado(
	iCodigo		INTEGER		PRIMARY KEY REFERENCES TbPessoa(iCodigo),
  nComissao	NUMERIC(6,4)	NOT NULL DEFAULT 0,
	sStatus		CHAR(01)	NOT NULL DEFAULT 'A'
);
}

type
  TComissionado = class(TPessoa)
  public
    constructor Create(pzcoConnection: TZConnection);
    destructor Destroy;override;

    procedure CadastraComissionado;
    procedure AlteraComissionado;
    procedure DeletaComissionado;

    function iCamposConsistentes: Integer;
    function iRetornaUltimoCodigo: Integer;
    function bPesquisaComissionado(psCodigo: String): Boolean;

    procedure SetComissao(psComissao: String);
    procedure SetStatus(psStatus: String);
    procedure SetRegistrosAfetadosComissionado(piRegistros: Longint);

    function sGetComissao: String;
    function sGetStatus: String;
    function iGetRegistrosAfetadosComissionado: Longint;



  private
    nComissao: Extended;
    sStatus: String;
    iRegistrosAfetados: Longint;
  end;

implementation

uses ZAbstractDataset, ZAbstractRODataset;

{ TComissionado }

procedure TComissionado.AlteraComissionado;
var
  ZQryComissionado: TZQuery;
begin
  SetRegistrosAfetadosComissionado(0);
  Try
    if iAlteraPessoa = 0 then
    begin
      ZQryComissionado := TZQuery.Create(nil);
      with ZQryComissionado do
      begin
        Connection := zcoGetConnection;
        SQL.Clear;
        SQL.Add('UPDATE tbcomissionado SET ncomissao = :ncomissao, sstatus = :sstatus');
        SQL.Add('WHERE icodigo = :icodigo');
        ParamByName('icodigo').AsInteger:=StrToInt(sGetCodigo);
        ParamByName('ncomissao').AsFloat:=StrToFloat(sGetComissao);
        ParamByName('sstatus').AsString:=sGetStatus;
        try
          ExecSQL;
          SetRegistrosAfetadosComissionado(RowsAffected);
        except
          on E: Exception do
            TrataErro(E.Message);
        end;
      end;
      FreeAndNil(ZQryComissionado);
    end;
  Except
  end;
end;

function TComissionado.bPesquisaComissionado(psCodigo: String): Boolean;
var
  ZQryComissionado: TZQuery;
begin
  if Trim(psCodigo) <> '' then
  begin
    ZQryComissionado := TZQuery.Create(nil);
    Result:=False;
    with ZQryComissionado do
    begin
      Connection := zcoGetConnection;
      SQL.Clear;
      SQL.Add('SELECT * FROM tbcomissionado WHERE icodigo = :icodigo');
      ParamByName('icodigo').AsString:=psCodigo;
      Open;
      if not IsEmpty then
      begin
        Result:=True;
        SetCodigo(FieldByName('icodigo').AsString);
        bPesquisaPessoa(FieldByName('icodigo').AsString);
        SetComissao(FieldByName('ncomissao').AsString);
        SetStatus(FieldByName('sstatus').AsString);
        if sGetStatus = 'I' then
          if Application.MessageBox('Este Comissionado está Inativo! Deseja Reativar?','Reativar Comissionado',
          MB_YESNO) = IDYES then
          begin
            SetStatus('A');
            AlteraComissionado;
          end;
      end
      else
      begin
        bPesquisaPessoa('-1');
        SetCodigo('-1');
        SetComissao('0');
        SetStatus('');
      end;
    end;
    FreeAndNil(ZQryComissionado);
  end;
end;

procedure TComissionado.CadastraComissionado;
var
  ZQryComissionado: TZQuery;
begin
  SetRegistrosAfetadosComissionado(0);
  if iCadastraPessoa = 0 then
  begin
    ZQryComissionado := TZQuery.Create(nil);
    with ZQryComissionado do
    begin
      Connection := zcoGetConnection;
      SQL.Clear;
      SQL.Add('INSERT INTO tbcomissionado(icodigo, ncomissao)');
      SQL.Add('VALUES(:icodigo, :ncomissao)');
      ParamByName('icodigo').AsInteger:=StrToInt(sGetCodigo);
      ParamByName('ncomissao').AsString := sGetComissao;
      try
        ExecSQL;
        SetRegistrosAfetadosComissionado(RowsAffected);
      except
        on E: Exception do
          TrataErro(E.Message);
      end;
    end;
    FreeAndNil(ZQryComissionado);
  end;
end;

constructor TComissionado.Create(pzcoConnection: TZConnection);
begin
  inherited Create(pzcoConnection);
  oCidade:=TCidade.Create(pzcoConnection);
  iRegistrosAfetados:=0;
end;

procedure TComissionado.DeletaComissionado;
var
  ZQryComissionado: TZQuery;
begin
  ZQryComissionado := TZQuery.Create(nil);
  with ZQryComissionado do
  begin
    Connection := zcoGetConnection;
    SQL.Clear;
    SQL.Add('UPDATE tbcomissionado SET sstatus = ''I''');
    SQL.Add('WHERE icodigo = :icodigo');
    ParamByName('icodigo').AsInteger:=StrToInt(sGetCodigo);
    ExecSQL;
  end;
  FreeAndNil(ZQryComissionado);
end;

destructor TComissionado.Destroy;
begin
  inherited;
end;

function TComissionado.iCamposConsistentes: Integer;
var
  iCont: SmallInt;
  slCampos: TStringList;
begin
  Result:=0;
  slCampos:=TStringList.Create;
  slCampos.CommaText:=sCamposObrigatorios('tbcomissionado',zcoGetConnection);

  {for iCont:=0 to slCampos.Count - 1 do
  begin
    if AnsiLowerCase(slCampos.Strings[iCont]) = 'ncomissao' then
    begin
      if StrToFloat(sGetComissao) <= 0 then
      begin
        Result:=c_CampoVazio;
        raise eCampoNaoPreenchido.Create(StringReplace(asMensagemErro[c_CampoVazio],'%','Comissão',[rfReplaceAll]));
      end;
    end;
  end;}
  FreeAndNil(slCampos);
end;

function TComissionado.iRetornaUltimoCodigo: Integer;
var
  ZQryComissionado: TZQuery;
begin
  ZQryComissionado := TZQuery.Create(nil);
  with ZQryComissionado do
  begin
    Connection := zcoGetConnection;
    SQL.Clear;
    SQL.Add('SELECT COALESCE(MAX(icodigo),0) AS ULTIMO FROM tbpessoa');
    Open;
    Result := FieldByName('ULTIMO').AsInteger;
  end;
  FreeAndNil(ZQryComissionado);
end;

function TComissionado.sGetComissao: String;
begin
  Result:=FloatToStr(nComissao);
end;

procedure TComissionado.SetComissao(psComissao: String);
begin
  if bFloatValido(psComissao) then
    nComissao:=StrToFloat(psComissao)
  else
    nComissao:=0;
end;

procedure TComissionado.SetStatus(psStatus: String);
begin
  sStatus:=psStatus;
end;

function TComissionado.sGetStatus: String;
begin
  Result:=sStatus;
end;

function TComissionado.iGetRegistrosAfetadosComissionado: Longint;
begin
  Result:=iRegistrosAfetados;
end;

procedure TComissionado.SetRegistrosAfetadosComissionado(piRegistros: Integer);
begin
  iRegistrosAfetados:=piRegistros;
end;

end.
