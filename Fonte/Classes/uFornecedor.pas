unit uFornecedor;

interface

uses ZConnection, ZDataset, SysUtils, uPessoa, uRamoAtividade, uPessoaFisica, uPessoaJuridica, uCidade, uComissionado,
     Forms, Classes, Windows, Variants, uDataHora, uExceptions, uProcedimentosBanco, uConstantes;


type
  TFornecedor = class(TPessoa)
    oFisica: TPessoaFisica;
    oJuridica: TPessoaJuridica;
  public
    constructor Create(pzcoConnection: TZConnection);
    destructor Destroy;override;

    procedure CadastraFornecedor;
    procedure AlteraFornecedor;


    function iRetornaUltimoCodigo: Integer;
    function iCamposConsistentes: Integer;

    procedure SetRegistrosAfetadosFornecedor(piRegistros: Longint);

    function iGetRegistrosAfetadosFornecedor: Longint;
    function bPesquisaFornecedor(psCodigo: String): Boolean;

  private
    iRegitrosAfetados: LongInt;

    procedure CadastraPessoaFisica;
    procedure DeletaPessoaFisica;
    procedure CadastraPessoaJuridica;
    procedure DeletaPessoaJuridica;
  end;


implementation



{ TFornecedor }

procedure TFornecedor.AlteraFornecedor;
begin
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
  end;
end;



function TFornecedor.bPesquisaFornecedor(psCodigo: String): Boolean;
var
  ZQry: TZQuery;
begin
  if Trim(psCodigo) <> '' then
  begin
    ZQry := TZQuery.Create(nil);
    Result:=False;
    with ZQry do
    begin
      Connection := zcoGetConnection;
      SQL.Clear;
      SQL.Add('SELECT * FROM tbfornecedor ');
      SQL.Add('WHERE ipessoa = :icodigo');
      ParamByName('icodigo').AsString:=psCodigo;
      Open;
      if not IsEmpty then
      begin
        Result:=True;
        SetCodigo(FieldByName('ipessoa').AsString);
        bPesquisaPessoa(FieldByName('ipessoa').AsString);
        oFisica.bPesquisaPessoaFisica(FieldByName('ipessoa').AsString);
        oJuridica.bPesquisaPessoaJuridica(FieldByName('ipessoa').AsString);

        {if sGetStatus = 'I' then
          if Application.MessageBox('Este Fornecedor está Inativo! Deseja Reativar?','Reativar Fornecedor',MB_YESNO) = IDYES then
          begin
            SetStatus('A');
            AlteraFornecedor;
          end;}
      end
      else
      begin
        SetCodigo('-1');
        //SetEnderecoCobr('');
        //SetBairroCobr('');
        //SetCepCobr('');
        //oCidadeCobr.SetCodigo('-1');
        //SetStatus('');
      end;
    end;
    FreeAndNil(ZQry);
  end;
end;


procedure TFornecedor.CadastraFornecedor;
var
  zqry: TZQuery;
begin
   if iCadastraPessoa > 0 then
     Exit;
  zqry:=TZQuery.Create(nil);
  with zqry do
  begin
    Connection:=zcoGetConnection;
    SQL.Clear;
    SQL.Add('INSERT INTO tbfornecedor (icodigo, ipessoa)');
    SQL.Add('VALUES(:icodigo, :iPessoa)');
    ParamByName('icodigo').AsInteger:=iRetornaUltimoCodigo;
    ParamByName('iPessoa').AsString:= Self.sGetCodigo;
    try
      ExecSQL;
      SetRegistrosAfetadosFornecedor(RowsAffected);
    except
      on E: Exception do
        TrataErro(E.Message);
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

  end;
  FreeAndNil(ZQry);
end;


procedure TFornecedor.CadastraPessoaFisica;
var
  zqryPessoaFisica: TZQuery;
begin
  SetRegistrosAfetadosFornecedor(0);
  zqryPessoaFisica:=TZQuery.Create(nil);
  with zqryPessoaFisica do
  begin
    Connection:=zcoGetConnection;
    SQL.Clear;
    SQL.Add('INSERT INTO tbpessoafisica (icodigo, scpf, srg, iramoatividade, ddatanascimento)');
    SQL.Add('VALUES(:icodigo, :scpf, :srg, :iramoatividade, :ddatanascimento)');
    ParamByName('icodigo').AsInteger:=StrToInt(Self.sGetCodigo);
    ParamByName('scpf').AsString:=oFisica.sGetCPF;
    ParamByName('srg').AsString:=oFisica.sGetRG;
    ParamByName('iramoatividade').AsInteger:=StrToInt(oFisica.oRamoAtividade.sGetCodigo);
    ParamByName('ddatanascimento').AsDateTime:=StrToDate(oFisica.sGetDataNascimento);
    try
      ExecSQL;
      SetRegistrosAfetadosFornecedor(RowsAffected);
    except
      on E: Exception do
        TrataErro(E.Message);
    end;
  end;
  FreeAndNil(zqryPessoaFisica);
end;

procedure TFornecedor.CadastraPessoaJuridica;
var
  zqryPessoaJuridica: TZQuery;
begin
  SetRegistrosAfetadosFornecedor(0);
  Try
    zqryPessoaJuridica:=TZQuery.Create(nil);
    with zqryPessoaJuridica do
    begin
      Connection:=zcoGetConnection;
      SQL.Clear;
      SQL.Add('INSERT INTO tbpessoajuridica (icodigo, scnpj, sinscestadual, sinscmunicipal, srazaosocial, iramoatividade)');
      SQL.Add('VALUES(:icodigo, :scnpj, :sinscestadual, :sinscmunicipal, :srazaosocial, :iramoatividade)');
      ParamByName('iCodigo').AsInteger:=StrToInt(Self.sGetCodigo);
      ParamByName('scnpj').AsString:=oJuridica.sGetCNPJ;
      ParamByName('sinscestadual').AsString:=oJuridica.sGetInscEstadual;
      ParamByName('sinscmunicipal').AsString:=oJuridica.sGetInscMunicipal;
      ParamByName('srazaosocial').AsString:=oJuridica.sGetRazaoSocial;
      ParamByName('iramoatividade').AsInteger:=StrToInt(oJuridica.oRamoAtividade.sGetCodigo);
      try
        ExecSQL;
        SetRegistrosAfetadosFornecedor(RowsAffected);
      except
        on E: Exception do
          TrataErro(E.Message);
      end;
    end;
    FreeAndNil(zqryPessoaJuridica);
  Except
  end;
end;


constructor TFornecedor.Create(pzcoConnection: TZConnection);
begin
   inherited Create(pzcoConnection);
   oFisica:=TPessoaFisica.Create(zcoGetConnection);
  oJuridica:=TPessoaJuridica.Create(zcoGetConnection);
end;

procedure TFornecedor.DeletaPessoaFisica;
var
  zqryPessoaFisica: TZQuery;
begin
  zqryPessoaFisica:=TZQuery.Create(nil);
  with zqryPessoaFisica do
  begin
    Connection:=zcoGetConnection;
    SQL.Clear;
    SQL.Add('DELETE FROM tbpessoafisica WHERE icodigo = :icodigo');
    ParamByName('icodigo').AsInteger:=StrToInt(sGetCodigo);
    ExecSQL;
  end;
   FreeAndNil(zqryPessoaFisica);
end;

procedure TFornecedor.DeletaPessoaJuridica;
var
  zqryPessoaJuridica: TZQuery;
begin
  zqryPessoaJuridica:=TZQuery.Create(nil);
  with zqryPessoaJuridica do
  begin
    Connection:=zcoGetConnection;
    SQL.Clear;
    SQL.Add('DELETE FROM tbpessoajuridica WHERE icodigo = :icodigo');
    ParamByName('iCodigo').AsInteger:=StrToInt(sGetCodigo);
    ExecSQL;
  end;
   FreeAndNil(zqryPessoaJuridica);
end;

destructor TFornecedor.Destroy;
begin

  inherited;
end;

function TFornecedor.iCamposConsistentes: Integer;
begin
   Result := 0;
end;

function TFornecedor.iGetRegistrosAfetadosFornecedor: Longint;
begin
   Result := iRegitrosAfetados;
end;

function TFornecedor.iRetornaUltimoCodigo: Integer;
var
   Qry: TZquery;
begin
   Qry  := TZQuery.Create(nil);
   with Qry do begin
      Connection := zcoGetConnection;
      SQL.Clear;
      SQL.Add('select coalesce((select max(icodigo) from tbfornecedor), 0)+1');
      Open;
      Result := Fields[0].AsInteger;
   end;
end;

procedure TFornecedor.SetRegistrosAfetadosFornecedor(piRegistros: Integer);
begin
   iRegitrosAfetados := piRegistros;
end;

end.
