unit uCliente;

interface

uses ZConnection, ZDataset, SysUtils, uPessoa, uRamoAtividade, uPessoaFisica, uPessoaJuridica, uCidade, uComissionado,
  Forms, Classes, Windows, Variants, uDataHora, uExceptions, uProcedimentosBanco, uConstantes;

{
  CREATE TABLE TbCliente(
  iCodigo         INTEGER         PRIMARY KEY REFERENCES TbPessoa(iCodigo),
  sEnderecoCobr   VARCHAR(50)     NULL,
  sBairroCobr     VARCHAR(30)     NULL,
  iCidadeCobr     INTEGER         NULL REFERENCES TbCidade(iCodigo),
  sCEPCobr        CHAR(08)        NULL,
  iComissionado   INTEGER         NULL REFERENCES TbComissionado(iCodigo),
  dDataCadastro   DATE            NOT NULL DEFAULT CURRENT_DATE,
  sStatus         CHAR(01)        NOT NULL DEFAULT 'A'
  );

  COMMENT ON TABLE TbCliente IS 'Tabela de Clientes';
  COMMENT ON COLUMN TbCliente.iCodigo IS 'Código do Cliente';
  COMMENT ON COLUMN TbCliente.sEnderecoCobr IS 'Endereço de Cobrança do Cliente';
  COMMENT ON COLUMN TbCliente.sBairroCobr IS 'Bairro de Cobrança do Cliente';
  COMMENT ON COLUMN TbCliente.iCidadeCobr IS 'Cidade de Cobrança do Cliente';
  COMMENT ON COLUMN TbCliente.sCEPCobr IS 'CEP de Cobrança do Cliente';
  COMMENT ON COLUMN TbCliente.iComissionado IS 'Comissionado ligado ao Cliente';
  COMMENT ON COLUMN TbCliente.dDataCadastro IS 'Data do Cadastro do Cliente';
  COMMENT ON COLUMN TbCliente.sStatus IS 'A = Ativo - I = Inativo';
}

type
  TCliente = class(TPessoa)
    oComissionado: TComissionado;
    oFisica: TPessoaFisica;
    oJuridica: TPessoaJuridica;
    oCidadeCobr: TCidade;
  public
    constructor Create(pzcoConnection: TZConnection);
    destructor Destroy; override;

    procedure CadastraCliente;
    procedure AlteraCliente;
    procedure DeletaCliente;

    procedure CadastraPessoaFisica;
    procedure DeletaPessoaFisica;
    procedure CadastraPessoaJuridica;
    procedure DeletaPessoaJuridica;

    function iRetornaUltimoCodigo: Integer;
    function bPesquisaCliente(psCodigo: String): Boolean;
    function iCamposConsistentes: Integer;

    procedure SetEnderecoCobr(psEnderecoCobr: String);
    procedure SetBairroCobr(psBairroCobr: String);
    procedure SetCepCobr(psCepCobr: String);
    procedure SetDataCadastro(psDataCadastro: String);
    procedure SetStatus(psStatus: String);
    procedure SetRegistrosAfetadosCliente(piRegistros: Longint);

    function sGetEnderecoCobr: String;
    function sGetBairroCobr: String;
    function sGetCepCobr: String;
    function sGetDataCadastro: String;
    function sGetStatus: String;
    function iGetRegistrosAfetadosCliente: Longint;
  private
    sEnderecoCobr: String;
    sBairroCobr: String;
    sCepCobr: String;
    dDataCadastro: TDateTime;
    sStatus: String;
    iRegistrosAfetados: Longint;
  end;

implementation

uses ZAbstractDataset, ZAbstractRODataset, Math, DB;

{ TCliente }

procedure TCliente.AlteraCliente;
var
  zqryCliente: TZQuery;
begin
  SetRegistrosAfetadosCliente(0);
  if iAlteraPessoa = 0 then
  begin
    if Trim(oFisica.sGetCPF) <> '' then
    begin
      if oFisica.iCamposConsistentes = 0 then
      begin
        DeletaPessoaJuridica;
        DeletaPessoaFisica;
        CadastraPessoaFisica;
      end
      else
        Exit;
    end
    else
    begin
      if oJuridica.iCamposConsistentes = 0 then
      begin
        DeletaPessoaJuridica;
        DeletaPessoaFisica;
        CadastraPessoaJuridica;
      end
      else
        Exit;
    end;

    zqryCliente := TZQuery.Create(nil);
    with zqryCliente do
    begin
      Connection := zcoGetConnection;
      SQL.Clear;
      SQL.Add('UPDATE tbcliente SET senderecocobr = :senderecocobr, sbairrocobr = :sbairrocobr, icidadecobr = :icidadecobr, ');
      SQL.Add('scepcobr = :scepcobr, icomissionado = :icomissionado, ddatacadastro = :ddatacadastro, sstatus = :sstatus');
      SQL.Add('WHERE icodigo = :icodigo');
      ParamByName('icodigo').AsString := sGetCodigo;
      ParamByName('senderecocobr').AsString := sGetEnderecoCobr;
      ParamByName('sbairrocobr').AsString := sGetBairroCobr;
      if oCidadeCobr.sGetCodigo <> '' then
        ParamByName('iCidadeCobr').AsInteger := StrToInt(oCidadeCobr.sGetCodigo)
      else
        ParamByName('iCidadeCobr').Value := NULL;
      ParamByName('sCepCobr').AsString := sGetCepCobr;
      if oComissionado.sGetCodigo <> '' then
        ParamByName('iComissionado').AsInteger := StrToInt(oComissionado.sGetCodigo)
      else
        ParamByName('iComissionado').Value := NULL;
      ParamByName('dDataCadastro').AsDateTime := StrToDate(sGetDataCadastro);
      ParamByName('sstatus').AsString := sGetStatus;
      ExecSQL;
      SetRegistrosAfetadosCliente(RowsAffected);
    end;
    FreeAndNil(zqryCliente);
  end;
end;

function TCliente.bPesquisaCliente(psCodigo: String): Boolean;
var
  zqryCliente: TZQuery;
begin
  if Trim(psCodigo) <> '' then
  begin
    zqryCliente := TZQuery.Create(nil);
    Result := False;
    with zqryCliente do
    begin
      Connection := zcoGetConnection;
      SQL.Clear;
      SQL.Add('SELECT * FROM tbcliente ');
      SQL.Add('WHERE icodigo = :icodigo');
      ParamByName('icodigo').AsString := psCodigo;
      Open;
      if not IsEmpty then
      begin
        Result := True;
        SetCodigo(FieldByName('icodigo').AsString);
        bPesquisaPessoa(FieldByName('icodigo').AsString);
        SetEnderecoCobr(FieldByName('senderecocobr').AsString);
        SetBairroCobr(FieldByName('sbairrocobr').AsString);
        oCidadeCobr.bPesquisaCidade(FieldByName('icidadecobr').AsString);
        SetCepCobr(FieldByName('scepcobr').AsString);
        oComissionado.bPesquisaComissionado(FieldByName('icomissionado').AsString);
        SetDataCadastro(FieldByName('ddatacadastro').AsString);
        SetStatus(FieldByName('sstatus').AsString);

        oFisica.bPesquisaPessoaFisica(FieldByName('icodigo').AsString);
        oJuridica.bPesquisaPessoaJuridica(FieldByName('icodigo').AsString);

        if sGetStatus = 'I' then
          if Application.MessageBox('Este Cliente está Inativo! Deseja Reativar?', 'Reativar Cliente', MB_YESNO) = IDYES then
          begin
            SetStatus('A');
            AlteraCliente;
          end;
      end
      else
      begin
        SetCodigo('-1');
        bPesquisaPessoa('-1');
        oFisica.bPesquisaPessoaFisica('-1');
        oJuridica.bPesquisaPessoaJuridica('-1');
        SetEnderecoCobr('');
        SetBairroCobr('');
        SetCepCobr('');
        oCidadeCobr.SetCodigo('-1');
        SetStatus('');
      end;
    end;
    FreeAndNil(zqryCliente);
  end;
end;

procedure TCliente.CadastraCliente;
var
  zqryCliente: TZQuery;
begin
  SetRegistrosAfetadosCliente(0);
  if iCadastraPessoa > 0 then
    Exit;

  zqryCliente := TZQuery.Create(nil);
  with zqryCliente do
  begin
    Connection := zcoGetConnection;
    SQL.Clear;
    SQL.Add('INSERT INTO tbcliente (icodigo, senderecocobr, sbairrocobr, icidadecobr, scepcobr, ');
    SQL.Add('icomissionado, ddatacadastro)');
    SQL.Add('VALUES(:icodigo, :senderecocobr, :sbairrocobr, :icidadecobr, :scepcobr, :icomissionado, :ddatacadastro)');
    ParamByName('iCodigo').AsInteger := StrToInt(sGetCodigo);
    ParamByName('sEnderecoCobr').AsString := sGetEnderecoCobr;
    ParamByName('sBairroCobr').AsString := sGetBairroCobr;
    if oCidadeCobr.sGetCodigo <> '' then
      ParamByName('iCidadeCobr').AsInteger := StrToInt(oCidadeCobr.sGetCodigo)
    else
      ParamByName('iCidadeCobr').Value := NULL;
    ParamByName('sCepCobr').AsString := sGetCepCobr;
    if oComissionado.sGetCodigo <> '' then
      ParamByName('iComissionado').AsInteger := StrToInt(oComissionado.sGetCodigo)
    else
      ParamByName('iComissionado').Value := NULL;
    ParamByName('dDataCadastro').AsDateTime := StrToDate(sGetDataCadastro);
    ExecSQL;
    SetRegistrosAfetadosCliente(RowsAffected);
  end;

  if Trim(oFisica.sGetCPF) <> '' then
  begin
    if oFisica.iCamposConsistentes = 0 then
    begin
      DeletaPessoaJuridica;
      CadastraPessoaFisica;
    end
  end
  else
  begin
    if oJuridica.iCamposConsistentes = 0 then
    begin
      DeletaPessoaFisica;
      CadastraPessoaJuridica;
    end
  end;
  FreeAndNil(zqryCliente);
end;

constructor TCliente.Create(pzcoConnection: TZConnection);
begin
  inherited Create(pzcoConnection);
  // oCidade:=TCidade.Create(zcoGetConnection);
  oCidadeCobr := TCidade.Create(zcoGetConnection);
  oComissionado := TComissionado.Create(zcoGetConnection);
  oFisica := TPessoaFisica.Create(zcoGetConnection);
  oJuridica := TPessoaJuridica.Create(zcoGetConnection);
  iRegistrosAfetados := 0;
end;

procedure TCliente.DeletaCliente;
var
  zqryCliente: TZQuery;
begin
  zqryCliente := TZQuery.Create(nil);
  with zqryCliente do
  begin
    Connection := zcoGetConnection;
    SQL.Clear;
    SQL.Add('UPDATE tbcliente SET sstatus = ''I'' WHERE icodigo = :icodigo');
    ParamByName('iCodigo').AsInteger := StrToInt(sGetCodigo);
    ExecSQL;
  end;
  FreeAndNil(zqryCliente);
end;

destructor TCliente.Destroy;
begin
  inherited;
end;

function TCliente.sGetDataCadastro: String;
begin
  if dDataCadastro > 0 then
    Result := FormatDateTime('dd/mm/yyyy', dDataCadastro)
  else
    Result := '';
end;

function TCliente.iRetornaUltimoCodigo: Integer;
var
  zqryCliente: TZQuery;
begin
  zqryCliente := TZQuery.Create(nil);
  with zqryCliente do
  begin
    Connection := zcoGetConnection;
    SQL.Clear;
    SQL.Add('SELECT COALESCE(MAX(icodigo),0) AS ULTIMO FROM tbpessoa');
    Open;
    Result := FieldByName('ULTIMO').AsInteger;
  end;
  FreeAndNil(zqryCliente);
end;

procedure TCliente.SetBairroCobr(psBairroCobr: String);
begin
  sBairroCobr := psBairroCobr;
end;

procedure TCliente.SetCepCobr(psCepCobr: String);
begin
  sCepCobr := psCepCobr;
end;

procedure TCliente.SetDataCadastro(psDataCadastro: String);
begin
  if bDataValida(psDataCadastro) then
    dDataCadastro := StrToDate(psDataCadastro)
  else
    dDataCadastro := -1;
end;

procedure TCliente.SetEnderecoCobr(psEnderecoCobr: String);
begin
  sEnderecoCobr := psEnderecoCobr;
end;

procedure TCliente.SetStatus(psStatus: String);
begin
  sStatus := psStatus;
end;

function TCliente.sGetBairroCobr: String;
begin
  Result := sBairroCobr;
end;

function TCliente.sGetCepCobr: String;
begin
  Result := sCepCobr;
end;

function TCliente.sGetEnderecoCobr: String;
begin
  Result := sEnderecoCobr;
end;

function TCliente.sGetStatus: String;
begin
  Result := sStatus;
end;

procedure TCliente.CadastraPessoaFisica;
var
  zqryPessoaFisica: TZQuery;
begin
  SetRegistrosAfetadosCliente(0);
  zqryPessoaFisica := TZQuery.Create(nil);
  with zqryPessoaFisica do
  begin
    Connection := zcoGetConnection;
    SQL.Clear;
    SQL.Add('INSERT INTO tbpessoafisica (icodigo, scpf, srg, iramoatividade, ddatanascimento)');
    SQL.Add('VALUES(:icodigo, :scpf, :srg, :iramoatividade, :ddatanascimento)');
    ParamByName('icodigo').AsInteger := StrToInt(sGetCodigo);
    ParamByName('scpf').AsString := oFisica.sGetCPF;
    ParamByName('srg').AsString := oFisica.sGetRG;
    ParamByName('iramoatividade').AsInteger := StrToInt(oFisica.oRamoAtividade.sGetCodigo);
    ParamByName('ddatanascimento').AsDateTime := StrToDate(oFisica.sGetDataNascimento);
    try
      ExecSQL;
      SetRegistrosAfetadosCliente(RowsAffected);
    except
      on E: Exception do
        TrataErro(E.Message);
    end;
  end;
  FreeAndNil(zqryPessoaFisica);
end;

procedure TCliente.DeletaPessoaFisica;
var
  zqryPessoaFisica: TZQuery;
begin
  zqryPessoaFisica := TZQuery.Create(nil);
  with zqryPessoaFisica do
  begin
    Connection := zcoGetConnection;
    SQL.Clear;
    SQL.Add('DELETE FROM tbpessoafisica WHERE icodigo = :icodigo');
    ParamByName('icodigo').AsInteger := StrToInt(sGetCodigo);
    ExecSQL;
  end;
  FreeAndNil(zqryPessoaFisica);
end;

procedure TCliente.CadastraPessoaJuridica;
var
  zqryPessoaJuridica: TZQuery;
begin
  SetRegistrosAfetadosCliente(0);
  Try
    zqryPessoaJuridica := TZQuery.Create(nil);
    with zqryPessoaJuridica do
    begin
      Connection := zcoGetConnection;
      SQL.Clear;
      SQL.Add('INSERT INTO tbpessoajuridica (icodigo, scnpj, sinscestadual, sinscmunicipal, srazaosocial, iramoatividade)');
      SQL.Add('VALUES(:icodigo, :scnpj, :sinscestadual, :sinscmunicipal, :srazaosocial, :iramoatividade)');
      ParamByName('iCodigo').AsInteger := StrToInt(sGetCodigo);
      ParamByName('scnpj').AsString := oJuridica.sGetCNPJ;
      ParamByName('sinscestadual').AsString := oJuridica.sGetInscEstadual;
      ParamByName('sinscmunicipal').AsString := oJuridica.sGetInscMunicipal;
      ParamByName('srazaosocial').AsString := oJuridica.sGetRazaoSocial;
      ParamByName('iramoatividade').AsInteger := StrToInt(oJuridica.oRamoAtividade.sGetCodigo);
      try
        ExecSQL;
        SetRegistrosAfetadosCliente(RowsAffected);
      except
        on E: Exception do
          TrataErro(E.Message);
      end;
    end;
    FreeAndNil(zqryPessoaJuridica);
  Except
  end;
end;

procedure TCliente.DeletaPessoaJuridica;
var
  zqryPessoaJuridica: TZQuery;
begin
  zqryPessoaJuridica := TZQuery.Create(nil);
  with zqryPessoaJuridica do
  begin
    Connection := zcoGetConnection;
    SQL.Clear;
    SQL.Add('DELETE FROM tbpessoajuridica WHERE icodigo = :icodigo');
    ParamByName('iCodigo').AsInteger := StrToInt(sGetCodigo);
    ExecSQL;
  end;
  FreeAndNil(zqryPessoaJuridica);
end;

{ procedure TCliente.AlteraPessoaFisica;
  var
  ZQryPessoaFisica: TZQuery;
  begin
  Try
  ZQryPessoaFisica := TZQuery.Create(nil);
  with ZQryPessoaFisica do
  begin
  Connection := zcoGetConnection;
  SQL.Clear;
  SQL.Add('UPDATE tbpessoafisica SET srg = :srg, scpf = :scpf, iramoatividade = :iramoatividade,');
  SQL.Add('ddatanascimento = :ddatanascimento');
  SQL.Add('WHERE icodigo = :icodigo');
  ParamByName('icodigo').AsInteger:=StrToInt(sGetCodigo);
  ParamByName('srg').AsString:=oFisica.sGetRG;
  ParamByName('scpf').AsString:=oFisica.sGetCPF;
  ParamByName('iramoatividade').AsInteger:=StrToInt(oFisica.oRamoAtividade.sGetCodigo);
  ParamByName('ddatanascimento').AsDateTime:=StrToDate(oFisica.sGetDataNascimento);
  ExecSQL;
  end;
  FreeAndNil(ZQryPessoaFisica);
  Except
  end;
  end;

  procedure TCliente.AlteraPessoaJuridica;
  var
  ZQryPessoaJuridica: TZQuery;
  begin
  Try
  ZQryPessoaJuridica := TZQuery.Create(nil);
  with ZQryPessoaJuridica do
  begin
  Connection := zcoGetConnection;
  SQL.Clear;
  SQL.Add('UPDATE tbpessoajuridica SET sinscmunicipal = :sinscmunicipal, scnpj = :scnpj, iramoatividade = :iramoatividade,');
  SQL.Add('sinscestadual = :sinscestadual, srazaosocial = :srazaosocial');
  SQL.Add('WHERE icodigo = :icodigo');
  ParamByName('icodigo').AsInteger:=StrToInt(sGetCodigo);
  ParamByName('sinscmunicipal').AsString:=oJuridica.sGetInscMunicipal;
  ParamByName('sinscestadual').AsString:=oJuridica.sGetInscEstadual;
  ParamByName('scnpj').AsString:=oJuridica.sGetCNPJ;
  ParamByName('srazaosocial').AsString:=oJuridica.sGetRazaoSocial;
  ParamByName('iramoatividade').AsInteger:=StrToInt(oJuridica.oRamoAtividade.sGetCodigo);
  ExecSQL;
  end;
  FreeAndNil(ZQryPessoaJuridica);
  Except
  end;
  end;
}

function TCliente.iCamposConsistentes: Integer;
var
  iCont: SmallInt;
  slCampos: TStringList;
begin
  Result := 0;
  slCampos := TStringList.Create;
  slCampos.CommaText := sCamposObrigatorios('tbcliente', zcoGetConnection);

  for iCont := 0 to slCampos.Count - 1 do
  begin
    if AnsiLowerCase(slCampos.Strings[iCont]) = 'icodigo' then
    begin
      if sGetCodigo = '' then
      begin
        Result := c_CampoVazio;
        raise eCampoNaoPreenchido.Create(StringReplace(asMensagemErro[c_CampoVazio], '%', 'Código', [rfReplaceAll]));
      end;
    end;
    if AnsiLowerCase(slCampos.Strings[iCont]) = 'ddatacadastro' then
    begin
      if sGetDataCadastro = '' then
      begin
        Result := c_CampoVazio;
        raise eCampoNaoPreenchido.Create(StringReplace(asMensagemErro[c_CampoVazio], '%', 'Data do Cadastro', [rfReplaceAll]));
      end;
    end;
  end;
  FreeAndNil(slCampos);
end;

function TCliente.iGetRegistrosAfetadosCliente: Longint;
begin
  Result := iRegistrosAfetados;
end;

procedure TCliente.SetRegistrosAfetadosCliente(piRegistros: Integer);
begin
  iRegistrosAfetados := piRegistros;
end;

end.
