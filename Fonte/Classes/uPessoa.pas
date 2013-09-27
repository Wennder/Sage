unit uPessoa;

interface

uses ZConnection, ZDataset, SysUtils, uCidade, uNumeros, uExceptions, Forms, Windows, Classes, uProcedimentosBanco,
  uConstantes;

type
  TPessoa = class
    oCidade: TCidade;
  public
    constructor Create(pzcoConnection: TZConnection);
    destructor Destroy; override;

    function iCadastraPessoa: Integer;
    function iAlteraPessoa: Integer;
    procedure DeletaPessoa;

    function bPesquisaPessoa(psCodigo: String): Boolean;
    function zcoGetConnection: TZConnection;
    function iCamposConsistentes: Integer;

    procedure SetCodigo(psCodigo: String);
    procedure SetNome(psNome: String);
    procedure SetEndereco(psEndereco: String);
    procedure SetBairro(psBairro: String);
    procedure SetCep(psCep: String);
    procedure SetFone(psFone: String);
    procedure SetFax(psFax: String);
    procedure SetCelular(psCelular: String);
    procedure SetEmail(psEmail: String);
    procedure SetObservacao(psObservacao: String);
    procedure SetRegistrosAfetadosPessoa(piRegistros: Longint);
    procedure SetCadastroFornecedor(pbCadastroFornecedor: Boolean);

    function sGetCodigo: String;
    function sGetNome: String;
    function sGetEndereco: String;
    function sGetBairro: String;
    function sGetCep: String;
    function sGetFone: String;
    function sGetFax: String;
    function sGetCelular: String;
    function sGetEmail: String;
    function sGetObservacao: String;
    function iGetRegistrosAfetadosPessoa: Longint;
  private
    iCodigo: Integer;
    sNome: String;
    sEndereco: String;
    sBairro: String;
    sCep: String;
    sFone: String;
    sFax: String;
    sCelular: String;
    sEmail: String;
    sObservacao: String;
    iRegistrosAfetados: Longint;
    zcoConnection: TZConnection;
    bCadastroFornecedor: Boolean;
  end;

implementation

uses ZAbstractDataset, ZAbstractRODataset;

{ TPessoa }

function TPessoa.iAlteraPessoa: Integer;
var
  ZQryPessoa: TZQuery;
begin
  SetRegistrosAfetadosPessoa(0);
  Result := iCamposConsistentes;
  if Result = 0 then
  begin
    ZQryPessoa := TZQuery.Create(nil);
    with ZQryPessoa do
    begin
      Connection := zcoGetConnection;
      SQL.Clear;
      SQL.Add('UPDATE tbpessoa SET snome = :snome, sendereco = :sendereco, sbairro = :sbairro, icidade = :icidade, ');
      SQL.Add('scep = :scep, sfone = :sfone, sfax = :sfax, scelular = :scelular, semail = :semail, sobservacao = :sobservacao');
      SQL.Add('WHERE icodigo = :icodigo');
      ParamByName('icodigo').AsInteger := StrToInt(sGetCodigo);
      ParamByName('snome').AsString := sGetNome;
      ParamByName('sendereco').AsString := sGetEndereco;
      ParamByName('sbairro').AsString := sGetBairro;
      ParamByName('icidade').AsInteger := StrToInt(oCidade.sGetCodigo);
      ParamByName('scep').AsString := sGetCep;
      ParamByName('sfone').AsString := sGetFone;
      ParamByName('sfax').AsString := sGetFax;
      ParamByName('scelular').AsString := sGetCelular;
      ParamByName('semail').AsString := sGetEmail;
      ParamByName('sobservacao').AsString := sGetObservacao;
      ExecSQL;
      SetRegistrosAfetadosPessoa(RowsAffected);
    end;
    FreeAndNil(ZQryPessoa);
  end;
end;

function TPessoa.iCadastraPessoa: Integer;
var
  ZQryPessoa: TZQuery;
begin
  SetRegistrosAfetadosPessoa(0);
  Result := iCamposConsistentes;
  if Result = 0 then
  begin
    ZQryPessoa := TZQuery.Create(nil);
    with ZQryPessoa do
    begin
      Connection := zcoGetConnection;
      SQL.Clear;
      SQL.Add('INSERT INTO tbpessoa(icodigo, snome, sendereco, sbairro, icidade, scep, sfone, sfax, scelular, ');
      SQL.Add('semail, sobservacao)');
      SQL.Add('VALUES(:icodigo, :snome, :sendereco, :sbairro, :icidade, :scep, :sfone, :sfax, :scelular, ');
      SQL.Add(':semail, :sobservacao)');
      ParamByName('icodigo').AsInteger := StrToInt(sGetCodigo);
      ParamByName('snome').AsString := sGetNome;
      ParamByName('sendereco').AsString := sGetEndereco;
      ParamByName('sbairro').AsString := sGetBairro;
      ParamByName('icidade').AsInteger := StrToInt(oCidade.sGetCodigo);
      ParamByName('scep').AsString := sGetCep;
      ParamByName('sfone').AsString := sGetFone;
      ParamByName('sfax').AsString := sGetFax;
      ParamByName('scelular').AsString := sGetCelular;
      ParamByName('semail').AsString := sGetEmail;
      ParamByName('sobservacao').AsString := sGetObservacao;
      try
        ExecSQL;
        SetRegistrosAfetadosPessoa(RowsAffected);
      except
        on E: Exception do
          TrataErro(E.Message);
      end;
      if bCadastroFornecedor then
      begin
        SQL.Clear;
        SQL.Add('INSERT INTO tbfornecedor(icodigo, ipessoa)');
        SQL.Add('VALUES((select coalesce((select max(icodigo) from tbfornecedor),(select 0))+1), :ipessoa)');
        ParamByName('ipessoa').AsInteger := StrToInt(sGetCodigo);
        ExecSQL;
      end;
    end;
    FreeAndNil(ZQryPessoa);
  end;
end;

constructor TPessoa.Create(pzcoConnection: TZConnection);
begin
  inherited Create;
  oCidade := TCidade.Create(pzcoConnection);
  zcoConnection := pzcoConnection;
  iRegistrosAfetados := 0;
end;

procedure TPessoa.DeletaPessoa;
var
  ZQryPessoa: TZQuery;
begin
  ZQryPessoa := TZQuery.Create(nil);
  with ZQryPessoa do
  begin
    Connection := zcoGetConnection;
    SQL.Clear;
    SQL.Add('UPDATE tbpessoa SET sstatus = ''I''');
    SQL.Add('WHERE icodigo = :icodigo');
    ParamByName('icodigo').AsInteger := StrToInt(sGetCodigo);
    ExecSQL;
  end;
  FreeAndNil(ZQryPessoa);
end;

destructor TPessoa.Destroy;
begin
end;

function TPessoa.sGetBairro: String;
begin
  Result := sBairro;
end;

function TPessoa.sGetCelular: String;
begin
  Result := sCelular;
end;

function TPessoa.sGetCep: String;
begin
  Result := sCep;
end;

function TPessoa.sGetCodigo: String;
begin
  if iCodigo > 0 then
    Result := IntToStr(iCodigo)
  else
    Result := '';
end;

function TPessoa.sGetEmail: String;
begin
  Result := sEmail;
end;

function TPessoa.sGetEndereco: String;
begin
  Result := sEndereco;
end;

function TPessoa.sGetFax: String;
begin
  Result := sFax;
end;

function TPessoa.sGetFone: String;
begin
  Result := sFone;
end;

function TPessoa.sGetNome: String;
begin
  Result := sNome;
end;

function TPessoa.sGetObservacao: String;
begin
  Result := sObservacao;
end;

procedure TPessoa.SetBairro(psBairro: String);
begin
  sBairro := psBairro;
end;

procedure TPessoa.SetCelular(psCelular: String);
begin
  sCelular := psCelular;
end;

procedure TPessoa.SetCep(psCep: String);
begin
  sCep := psCep;
end;

procedure TPessoa.SetCodigo(psCodigo: String);
begin
  if bInteiroValido(psCodigo) then
    iCodigo := StrToInt(psCodigo)
  else
    iCodigo := -1;
end;

procedure TPessoa.SetEmail(psEmail: String);
begin
  sEmail := psEmail;
end;

procedure TPessoa.SetEndereco(psEndereco: String);
begin
  sEndereco := psEndereco;
end;

procedure TPessoa.SetFax(psFax: String);
begin
  sFax := psFax;
end;

procedure TPessoa.SetFone(psFone: String);
begin
  sFone := psFone;
end;

procedure TPessoa.SetNome(psNome: String);
begin
  sNome := psNome;
end;

procedure TPessoa.SetObservacao(psObservacao: String);
begin
  sObservacao := psObservacao;
end;

function TPessoa.zcoGetConnection: TZConnection;
begin
  Result := zcoConnection;
end;

function TPessoa.bPesquisaPessoa(psCodigo: String): Boolean;
var
  ZQryPessoa: TZQuery;
begin
  if Trim(psCodigo) <> '' then
  begin
    ZQryPessoa := TZQuery.Create(nil);
    Result := False;
    with ZQryPessoa do
    begin
      Connection := zcoGetConnection;
      SQL.Clear;
      SQL.Add('SELECT * FROM tbpessoa ');
      SQL.Add('WHERE icodigo = :icodigo');
      ParamByName('icodigo').AsString := psCodigo;
      Open;
      if not IsEmpty then
      begin
        Result := True;
        SetCodigo(FieldByName('icodigo').AsString);
        SetNome(FieldByName('snome').AsString);
        SetEndereco(FieldByName('sendereco').AsString);
        SetBairro(FieldByName('sbairro').AsString);
        SetCep(FieldByName('scep').AsString);
        SetFone(FieldByName('sfone').AsString);
        SetFax(FieldByName('sfax').AsString);
        SetCelular(FieldByName('scelular').AsString);
        SetEmail(FieldByName('semail').AsString);
        oCidade.bPesquisaCidade(FieldByName('icidade').AsString);
        SetObservacao(FieldByName('sobservacao').AsString);
      end
      else
      begin
        SetCodigo('-1');
        SetNome('');
        SetEndereco('');
        SetBairro('');
        oCidade.bPesquisaCidade('-1');
        SetCep('');
        SetFone('');
        SetFax('');
        SetCelular('');
        SetEmail('');
        SetObservacao('');
      end;
    end;
    FreeAndNil(ZQryPessoa);
  end;
end;

function TPessoa.iCamposConsistentes: Integer;
var
  iCont: SmallInt;
  slCampos: TStringList;
begin
  Result := 0;
  slCampos := TStringList.Create;
  slCampos.CommaText := sCamposObrigatorios('tbpessoa', zcoConnection);

  for iCont := 0 to slCampos.Count - 1 do
  begin
    if AnsiLowerCase(slCampos.Strings[iCont]) = 'snome' then
    begin
      if Trim(sGetNome) = '' then
      begin
        Result := c_CampoVazio;
        raise eCampoNaoPreenchido.Create(StringReplace(asMensagemErro[c_CampoVazio], '%', 'Nome', [rfReplaceAll]));
      end;
    end;
    if AnsiLowerCase(slCampos.Strings[iCont]) = 'icodigo' then
    begin
      if sGetCodigo = '' then
      begin
        Result := c_CampoVazio;
        raise eCampoNaoPreenchido.Create(StringReplace(asMensagemErro[c_CampoVazio], '%', 'Código', [rfReplaceAll]));
      end;
    end;
    if AnsiLowerCase(slCampos.Strings[iCont]) = 'sendereco' then
    begin
      if Trim(sGetEndereco) = '' then
      begin
        Result := c_CampoVazio;
        raise eCampoNaoPreenchido.Create(StringReplace(asMensagemErro[c_CampoVazio], '%', 'Endereço', [rfReplaceAll]));
      end;
    end;
    if AnsiLowerCase(slCampos.Strings[iCont]) = 'sbairro' then
    begin
      if Trim(sGetBairro) = '' then
      begin
        Result := c_CampoVazio;
        raise eCampoNaoPreenchido.Create(StringReplace(asMensagemErro[c_CampoVazio], '%', 'Bairro', [rfReplaceAll]));
      end;
    end;
    if AnsiLowerCase(slCampos.Strings[iCont]) = 'icidade' then
    begin
      if oCidade.sGetCodigo = '' then
      begin
        Result := c_CampoVazio;
        raise eCampoNaoPreenchido.Create(StringReplace(asMensagemErro[c_CampoVazio], '%', 'Cidade', [rfReplaceAll]));
      end;
    end;
    if AnsiLowerCase(slCampos.Strings[iCont]) = 'scep' then
    begin
      if Trim(sGetCep) = '' then
      begin
        Result := c_CampoVazio;
        raise eCampoNaoPreenchido.Create(StringReplace(asMensagemErro[c_CampoVazio], '%', 'CEP', [rfReplaceAll]));
      end;
    end;
    if AnsiLowerCase(slCampos.Strings[iCont]) = 'sfone' then
    begin
      if Trim(sGetFone) = '' then
      begin
        Result := c_CampoVazio;
        raise eCampoNaoPreenchido.Create(StringReplace(asMensagemErro[c_CampoVazio], '%', 'Fone', [rfReplaceAll]));
      end;
    end;
  end;
  FreeAndNil(slCampos);
end;

function TPessoa.iGetRegistrosAfetadosPessoa: Longint;
begin
  Result := iRegistrosAfetados;
end;

procedure TPessoa.SetRegistrosAfetadosPessoa(piRegistros: Integer);
begin
  iRegistrosAfetados := piRegistros;
end;

procedure TPessoa.SetCadastroFornecedor(pbCadastroFornecedor: Boolean);
begin
  bCadastroFornecedor := pbCadastroFornecedor;
end;

end.
