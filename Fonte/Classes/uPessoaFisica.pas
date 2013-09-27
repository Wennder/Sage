unit uPessoaFisica;

interface

uses ZConnection, ZDataset, SysUtils, uRamoAtividade, Variants, Classes, uProcedimentosBanco, uConstantes, uExceptions,
     uDataHora;

type
  TPessoaFisica = class(TObject)
    oRamoAtividade: TRamoAtividade;
  public
    constructor Create(pzcoConnection: TZConnection);
    destructor Destroy;override;

    function zcoGetConnection: TZConnection;
    function iCamposConsistentes: Integer;
    function bPesquisaPessoaFisica(psCodigo: String): Boolean;

    procedure SetRG(psRG: String);
    procedure SetCPF(psCPF: String);
    procedure SetDataNascimento(psDataNascimento: String);

    function sGetRG: String;
    function sGetCPF: String;
    function sGetDataNascimento: String;
  private
    sRG: String;
    sCPF: String;
    dDataNascimento: TDateTime;
    zcoConnection: TZConnection;
  end;

implementation

uses ZAbstractDataset, ZAbstractRODataset;

{ TPessoaFisica }

function TPessoaFisica.bPesquisaPessoaFisica(psCodigo: String): Boolean;
var
  ZQryPessoaFisica: TZQuery;
begin
  if Trim(psCodigo) <> '' then
  begin
    ZQryPessoaFisica := TZQuery.Create(nil);
    Result:=False;
    with ZQryPessoaFisica do
    begin
      Connection := zcoConnection;
      SQL.Clear;
      SQL.Add('SELECT srg, scpf, ddatanascimento, iramoatividade FROM tbpessoafisica WHERE icodigo = :icodigo');
      ParamByName('icodigo').AsString:=psCodigo;
      Open;
      if not IsEmpty then
      begin
        Result:=True;
        SetRG(FieldByName('srg').AsString);
        SetCPF(FieldByName('scpf').AsString);
        SetDataNascimento(FieldByName('ddatanascimento').AsString);
        oRamoAtividade.bPesquisaRamoAtividade(FieldByName('iramoatividade').AsString)
      end
      else
      begin
        SetRG('');
        SetCPF('');
        SetDataNascimento('');
        oRamoAtividade.SetCodigo('-1');
      end;
    end;
    FreeAndNil(ZQryPessoaFisica);
  end;
end;

constructor TPessoaFisica.Create(pzcoConnection: TZConnection);
begin
  inherited Create;
  zcoConnection:=pzcoConnection;
  oRamoAtividade:=TRamoAtividade.Create(pzcoConnection);
end;

destructor TPessoaFisica.Destroy;
begin
end;

function TPessoaFisica.sGetDataNascimento: String;
begin
  if dDataNascimento > 0 then
    Result:=FormatDateTime('dd/mm/yyyy',dDataNascimento)
  else
    Result:='';
end;

function TPessoaFisica.iCamposConsistentes: Integer;
var
  iCont: SmallInt;
  slCampos: TStringList;
begin
  Result:=0;
  slCampos:=TStringList.Create;
  slCampos.CommaText:=sCamposObrigatorios('tbpessoafisica',zcoConnection);

  for iCont:=0 to slCampos.Count - 1 do
  begin
    if AnsiLowerCase(slCampos.Strings[iCont]) = 'scpf' then
    begin
      if Trim(sGetCPF) = '' then
      begin
        Result:=c_CampoVazio;
        raise eCampoNaoPreenchido.Create(StringReplace(asMensagemErro[c_CampoVazio],'%','CPF',[rfReplaceAll]));
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

procedure TPessoaFisica.SetCPF(psCPF: String);
begin
  sCPF:=psCPF;
end;

procedure TPessoaFisica.SetDataNascimento(psDataNascimento: String);
begin
  try
  if psDataNascimento = '' then
     dDataNascimento:=0
  else if bDataValida(psDataNascimento) then
    dDataNascimento:=StrToDate(psDataNascimento)
  else
    dDataNascimento:=0;
  except

  end;
end;

procedure TPessoaFisica.SetRG(psRG: String);
begin
  sRG:=psRG;
end;

function TPessoaFisica.sGetCPF: String;
begin
  Result:=sCPF;
end;

function TPessoaFisica.sGetRG: String;
begin
  Result:=sRG;
end;

function TPessoaFisica.zcoGetConnection: TZConnection;
begin
  Result:=zcoConnection;
end;

end.
