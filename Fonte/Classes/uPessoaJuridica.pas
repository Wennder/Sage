unit uPessoaJuridica;

interface

uses ZConnection, ZDataset, SysUtils, uRamoAtividade, Classes, uProcedimentosBanco, uConstantes, uExceptions;

type
  TPessoaJuridica = class(TObject)
    oRamoAtividade: TRamoAtividade;
  public
    constructor Create(pzcoConnection: TZConnection);
    destructor Destroy;override;

    function zcoGetConnection: TZConnection;
    function iCamposConsistentes: Integer;
    function bPesquisaPessoaJuridica(psCodigo: String): Boolean;

    procedure SetCNPJ(psCNPJ: String);
    procedure SetInscEstadual(psInscEstadual: String);
    procedure SetInscMunicipal(psInscMunicipal: String);
    procedure SetRazaoSocial(psRazaoSocial: String);

    function sGetCNPJ: String;
    function sGetInscEstadual: String;
    function sGetInscMunicipal: String;
    function sGetRazaoSocial: String;
  private
    sCnpj: String;
    sInscEstadual: String;
    sInscMunicipal: String;
    sRazaoSocial: String;
    zcoConnection: TZConnection;
  end;

implementation

uses ZAbstractDataset, ZAbstractRODataset;

{ TPessoaJuridica }

function TPessoaJuridica.bPesquisaPessoaJuridica(psCodigo: String): Boolean;
var
  ZQryPessoaJuridica: TZQuery;
begin
  if Trim(psCodigo) <> '' then
  begin
    ZQryPessoaJuridica := TZQuery.Create(nil);
    Result:=False;
    with ZQryPessoaJuridica do
    begin
      Connection := zcoConnection;
      SQL.Clear;
      SQL.Add('SELECT *');
      SQL.Add('FROM tbpessoajuridica WHERE icodigo = :icodigo');
      ParamByName('icodigo').AsString:=psCodigo;
      Open;
      if not IsEmpty then
      begin
        Result:=True;
        SetCNPJ(FieldByName('scnpj').AsString);
        SetInscEstadual(FieldByName('sinscestadual').AsString);
        SetInscMunicipal(FieldByName('sinscmunicipal').AsString);
        SetRazaoSocial(FieldByName('srazaosocial').AsString);
        oRamoAtividade.bPesquisaRamoAtividade(FieldByName('iramoatividade').AsString)
      end
      else
      begin
        SetCNPJ('');
        SetInscEstadual('');
        SetInscMunicipal('');
        SetRazaoSocial('');
        oRamoAtividade.SetCodigo('-1');
      end;
    end;
    FreeAndNil(ZQryPessoaJuridica);
  end;
end;

constructor TPessoaJuridica.Create(pzcoConnection: TZConnection);
begin
  inherited Create;
  zcoConnection:=pzcoConnection;
  oRamoAtividade:=TRamoAtividade.Create(zcoGetConnection);
end;

destructor TPessoaJuridica.Destroy;
begin
  
end;

function TPessoaJuridica.iCamposConsistentes: Integer;
var
  iCont: SmallInt;
  slCampos: TStringList;
begin
  Result:=0;
  slCampos:=TStringList.Create;
  slCampos.CommaText:=sCamposObrigatorios('tbpessoajuridica',zcoConnection);

  for iCont:=0 to slCampos.Count - 1 do
  begin
    if AnsiLowerCase(slCampos.Strings[iCont]) = 'srazaosocial' then
    begin
      if Trim(sGetRazaoSocial) = '' then
      begin
        Result:=c_CampoVazio;
        raise eCampoNaoPreenchido.Create(StringReplace(asMensagemErro[c_CampoVazio],'%','CNPJ',[rfReplaceAll]));
      end;
    end;
    if AnsiLowerCase(slCampos.Strings[iCont]) = 'scnpj' then
    begin
      if Trim(sGetCNPJ) = '' then
      begin
        Result:=c_CampoVazio;
        raise eCampoNaoPreenchido.Create(StringReplace(asMensagemErro[c_CampoVazio],'%','CNPJ',[rfReplaceAll]));
      end;
    end;
    if AnsiLowerCase(slCampos.Strings[iCont]) = 'iramoatividade' then
    begin
      if oRamoAtividade.sGetCodigo = '' then
      begin
        Result:=c_CampoVazio;
        raise eCampoNaoPreenchido.Create(StringReplace(asMensagemErro[c_CampoVazio],'%','Ramo de Atividade',[rfReplaceAll]));
      end;
    end;
  end;
  FreeAndNil(slCampos);
end;

procedure TPessoaJuridica.SetCNPJ(psCNPJ: String);
begin
  sCnpj:=psCNPJ;
end;

procedure TPessoaJuridica.SetInscEstadual(psInscEstadual: String);
begin
  sInscEstadual:=psInscEstadual;
end;

procedure TPessoaJuridica.SetInscMunicipal(psInscMunicipal: String);
begin
  sInscMunicipal:=psInscMunicipal;
end;

procedure TPessoaJuridica.SetRazaoSocial(psRazaoSocial: String);
begin
  sRazaoSocial:=psRazaoSocial;
end;

function TPessoaJuridica.sGetCNPJ: String;
begin
  Result:=sCnpj;
end;

function TPessoaJuridica.sGetInscEstadual: String;
begin
  Result:=sInscEstadual;
end;

function TPessoaJuridica.sGetInscMunicipal: String;
begin
  Result:=sInscMunicipal;
end;

function TPessoaJuridica.sGetRazaoSocial: String;
begin
  Result:=sRazaoSocial;
end;

function TPessoaJuridica.zcoGetConnection: TZConnection;
begin
  Result:=zcoConnection;
end;

end.
