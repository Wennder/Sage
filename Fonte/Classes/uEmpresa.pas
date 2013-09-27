unit uEmpresa;

interface

uses ZConnection, ZDataset, SysUtils, uConstantes, Classes, Contnrs, uProcedimentosBanco, uExceptions, Variants, Forms,
  Dialogs, Windows, Datasnap.DBClient, UsoGeral, Vcl.FileCtrl, Data.DB, Vcl.StdCtrls, Vcl.Controls;

type
  TEmpresa = class
  public
    constructor Create(pzcoConnection: TZConnection);
    destructor Destroy; override;

    function Getiempresa: Variant;
    function Getsrazaosocial: Variant;
    function Getsfantasia: Variant;
    function Getscnpj: Variant;
    function Getsendereco: Variant;
    function Getsnumero: Variant;
    function Getscomplemento: Variant;
    function Getsbairro: Variant;
    function Geticidade: Variant;
    function Getscep: Variant;
    function Getsfone: Variant;
    function Getsemail: Variant;
    function Getsinscestadual: Variant;
    function Getsinscmunicipal: Variant;
    function Getsinscsubstituto: Variant;
    function Getscnae: Variant;
    function Getscrt: Variant;
    function Getativo: Variant;

    procedure Setiempresa(pParametro: Variant);
    procedure Setsrazaosocial(pParametro: Variant);
    procedure Setsfantasia(pParametro: Variant);
    procedure Setscnpj(pParametro: Variant);
    procedure Setsendereco(pParametro: Variant);
    procedure Setsnumero(pParametro: Variant);
    procedure Setscomplemento(pParametro: Variant);
    procedure Setsbairro(pParametro: Variant);
    procedure Seticidade(pParametro: Variant);
    procedure Setscep(pParametro: Variant);
    procedure Setsfone(pParametro: Variant);
    procedure Setsemail(pParametro: Variant);
    procedure Setsinscestadual(pParametro: Variant);
    procedure Setsinscmunicipal(pParametro: Variant);
    procedure Setsinscsubstituto(pParametro: Variant);
    procedure Setscnae(pParametro: Variant);
    procedure Setscrt(pParametro: Variant);
    procedure Setativo(pParametro: Variant);

    procedure pLimpaAtributos;
    function fPesquisar(piempresa: integer): Boolean;
    function fInserir(): Boolean;
    function fAlterar(): Boolean;
    function fDeletar(): Boolean;
    function fRetornaUltimoCodigo(pIncrementa: Boolean = False): integer;

  private
    zcoConnection: TZConnection;

    iempresa: Variant;
    srazaosocial: Variant;
    sfantasia: Variant;
    scnpj: Variant;
    sendereco: Variant;
    snumero: Variant;
    scomplemento: Variant;
    sbairro: Variant;
    icidade: Variant;
    scep: Variant;
    sfone: Variant;
    semail: Variant;
    sinscestadual: Variant;
    sinscmunicipal: Variant;
    sinscsubstituto: Variant;
    scnae: Variant;
    scrt: Variant;
    ativo: Variant;

  end;

Var
  oEmpresaPrincipal: TEmpresa;

implementation

{ TEmpresa }

constructor TEmpresa.Create(pzcoConnection: TZConnection);
begin
  zcoConnection := pzcoConnection;
end;

destructor TEmpresa.Destroy;
begin

  inherited;
end;

function TEmpresa.Getiempresa: Variant;
begin
  Result := iempresa;
end;

function TEmpresa.Getsrazaosocial: Variant;
begin
  Result := srazaosocial;
end;

function TEmpresa.Getsfantasia: Variant;
begin
  Result := sfantasia;
end;

function TEmpresa.Getscnpj: Variant;
begin
  Result := scnpj;
end;

function TEmpresa.Getsendereco: Variant;
begin
  Result := sendereco;
end;

function TEmpresa.Getsnumero: Variant;
begin
  Result := snumero;
end;

function TEmpresa.Getscomplemento: Variant;
begin
  Result := scomplemento;
end;

function TEmpresa.Getsbairro: Variant;
begin
  Result := sbairro;
end;

function TEmpresa.Geticidade: Variant;
begin
  Result := icidade;
end;

function TEmpresa.Getscep: Variant;
begin
  Result := scep;
end;

function TEmpresa.Getsfone: Variant;
begin
  Result := sfone;
end;

function TEmpresa.Getsemail: Variant;
begin
  Result := semail;
end;

function TEmpresa.Getsinscestadual: Variant;
begin
  Result := sinscestadual;
end;

function TEmpresa.Getsinscmunicipal: Variant;
begin
  Result := sinscmunicipal;
end;

function TEmpresa.Getsinscsubstituto: Variant;
begin
  Result := sinscsubstituto;
end;

function TEmpresa.Getscnae: Variant;
begin
  Result := scnae;
end;

function TEmpresa.Getscrt: Variant;
begin
  Result := scrt;
end;

function TEmpresa.Getativo: Variant;
begin
  Result := ativo;
end;

procedure TEmpresa.Setiempresa(pParametro: Variant);
begin
  iempresa := pParametro;
end;

procedure TEmpresa.Setsrazaosocial(pParametro: Variant);
begin
  srazaosocial := pParametro;
end;

procedure TEmpresa.Setsfantasia(pParametro: Variant);
begin
  sfantasia := pParametro;
end;

procedure TEmpresa.Setscnpj(pParametro: Variant);
begin
  scnpj := pParametro;
end;

procedure TEmpresa.Setsendereco(pParametro: Variant);
begin
  sendereco := pParametro;
end;

procedure TEmpresa.Setsnumero(pParametro: Variant);
begin
  snumero := pParametro;
end;

procedure TEmpresa.Setscomplemento(pParametro: Variant);
begin
  scomplemento := pParametro;
end;

procedure TEmpresa.Setsbairro(pParametro: Variant);
begin
  sbairro := pParametro;
end;

procedure TEmpresa.Seticidade(pParametro: Variant);
begin
  icidade := pParametro;
end;

procedure TEmpresa.Setscep(pParametro: Variant);
begin
  scep := pParametro;
end;

procedure TEmpresa.Setsfone(pParametro: Variant);
begin
  sfone := pParametro;
end;

procedure TEmpresa.Setsemail(pParametro: Variant);
begin
  semail := pParametro;
end;

procedure TEmpresa.Setsinscestadual(pParametro: Variant);
begin
  sinscestadual := pParametro;
end;

procedure TEmpresa.Setsinscmunicipal(pParametro: Variant);
begin
  sinscmunicipal := pParametro;
end;

procedure TEmpresa.Setsinscsubstituto(pParametro: Variant);
begin
  sinscsubstituto := pParametro;
end;

procedure TEmpresa.Setscnae(pParametro: Variant);
begin
  scnae := pParametro;
end;

procedure TEmpresa.Setscrt(pParametro: Variant);
begin
  scrt := pParametro;
end;

procedure TEmpresa.Setativo(pParametro: Variant);
begin
  ativo := pParametro;
end;

procedure TEmpresa.pLimpaAtributos;
begin
  Setiempresa(0);
  Setsrazaosocial(Null);
  Setsfantasia(Null);
  Setscnpj(Null);
  Setsendereco(Null);
  Setsnumero(Null);
  Setscomplemento(Null);
  Setsbairro(Null);
  Seticidade(0);
  Setscep(Null);
  Setsfone(Null);
  Setsemail(Null);
  Setsinscestadual(Null);
  Setsinscmunicipal(Null);
  Setsinscsubstituto(Null);
  Setscnae(Null);
  Setscrt(Null);
  Setativo(Null);
end;

function TEmpresa.fPesquisar(piempresa: integer): Boolean;
var
  qrPesquisa: TZQuery;
begin
  try
    qrPesquisa := TZQuery.Create(nil);
    Result := False;
    with qrPesquisa do
    begin
      Connection := zcoConnection;
      SQL.Clear;
      SQL.Add('SELECT * FROM tbempresa');
      SQL.Add('WHERE 1=1');
      SQL.Add('AND iempresa= :iempresa');
      ParamByName('iempresa').Value := piempresa;

      Open;

      if not IsEmpty then
      begin
        Result := True;
        Setiempresa(FieldByName('iempresa').Value);
        Setsrazaosocial(FieldByName('srazaosocial').Value);
        Setsfantasia(FieldByName('sfantasia').Value);
        Setscnpj(FieldByName('scnpj').Value);
        Setsendereco(FieldByName('sendereco').Value);
        Setsnumero(FieldByName('snumero').Value);
        Setscomplemento(FieldByName('scomplemento').Value);
        Setsbairro(FieldByName('sbairro').Value);
        Seticidade(FieldByName('icidade').Value);
        Setscep(FieldByName('scep').Value);
        Setsfone(FieldByName('sfone').Value);
        Setsemail(FieldByName('semail').Value);
        Setsinscestadual(FieldByName('sinscestadual').Value);
        Setsinscmunicipal(FieldByName('sinscmunicipal').Value);
        Setsinscsubstituto(FieldByName('sinscsubstituto').Value);
        Setscnae(FieldByName('scnae').Value);
        Setscrt(FieldByName('scrt').Value);
        Setativo(FieldByName('ativo').Value);

      end
      else
        pLimpaAtributos;
    end;
  finally
    FreeAndNil(qrPesquisa);
  end;
end;

function TEmpresa.fInserir(): Boolean;
var
  qrCadastro: TZQuery;
begin
  Try
    qrCadastro := TZQuery.Create(nil);
    Result := False;
    with qrCadastro do
    begin
      Connection := zcoConnection;
      SQL.Clear;
      SQL.Add('INSERT INTO tbempresa(srazaosocial,sfantasia,scnpj,sendereco,snumero,scomplemento,sbairro,icidade,scep,sfone,semail,sinscestadual,sinscmunicipal,sinscsubstituto,scnae,scrt,ativo)');
      SQL.Add('VALUES (:srazaosocial,:sfantasia,:scnpj,:sendereco,:snumero,:scomplemento,:sbairro,:icidade,:scep,:sfone,:semail,:sinscestadual,:sinscmunicipal,:sinscsubstituto,:scnae,:scrt,:ativo)');

      ParamByName('srazaosocial').Value := Getsrazaosocial;
      ParamByName('sfantasia').Value := Getsfantasia;
      ParamByName('scnpj').Value := Getscnpj;
      ParamByName('sendereco').Value := Getsendereco;
      ParamByName('snumero').Value := Getsnumero;
      ParamByName('scomplemento').Value := Getscomplemento;
      ParamByName('sbairro').Value := Getsbairro;
      ParamByName('icidade').Value := Geticidade;
      ParamByName('scep').Value := Getscep;
      ParamByName('sfone').Value := Getsfone;
      ParamByName('semail').Value := Getsemail;
      ParamByName('sinscestadual').Value := Getsinscestadual;
      ParamByName('sinscmunicipal').Value := Getsinscmunicipal;
      ParamByName('sinscsubstituto').Value := Getsinscsubstituto;
      ParamByName('scnae').Value := Getscnae;
      ParamByName('scrt').Value := Getscrt;
      ParamByName('ativo').Value := Getativo;

      try
        ExecSQL;
      except
        on E: Exception do
        begin
          pMsgAtencao('Não foi possível realizar a inclusão do registro.', 'Mensagem Original: ' + #13 + E.Message);
          Result := False;
        end;
      end;
    end;
  finally
    FreeAndNil(qrCadastro);
  end;
end;

function TEmpresa.fAlterar(): Boolean;
var
  qrAlteracao: TZQuery;
begin
  Try
    qrAlteracao := TZQuery.Create(nil);
    Result := False;
    with qrAlteracao do
    begin
      Connection := zcoConnection;
      SQL.Clear;
      SQL.Add('UPDATE tbempresa SET ');
      SQL.Add('srazaosocial = :srazaosocial,sfantasia = :sfantasia,scnpj = :scnpj,sendereco = :sendereco,snumero = :snumero,scomplemento = :scomplemento,sbairro = :sbairro,');
      SQL.Add('icidade = :icidade,scep = :scep,sfone = :sfone,semail = :semail,sinscestadual = :sinscestadual,sinscmunicipal = :sinscmunicipal,sinscsubstituto = :sinscsubstituto,scnae = :scnae,scrt = :scrt,ativo = :ativo');
      SQL.Add(' WHERE iempresa = :iempresa');

      ParamByName('iempresa').Value := Getiempresa;

      try
        ExecSQL;
      except
        on E: Exception do
        begin
          pMsgAtencao('Não foi possível realizar a alteração do registro.', 'Mensagem Original: ' + #13 + E.Message);
          Result := False;
        end;
      end;
    end;
  finally
    FreeAndNil(qrAlteracao);
  end;
end;

function TEmpresa.fDeletar(): Boolean;
var
  qrExclusao: TZQuery;
begin
  Try
    qrExclusao := TZQuery.Create(nil);
    Result := False;
    with qrExclusao do
    begin
      Connection := zcoConnection;
      SQL.Clear;
      SQL.Add('DELETE FROM tbempresa');
      SQL.Add(' WHERE iempresa = :iempresa');

      ParamByName('iempresa').Value := Getiempresa;

      try
        ExecSQL;
      except
        on E: Exception do
        begin
          pMsgAtencao('Não foi possível realizar a exclusão do registro.', 'Mensagem Original: ' + #13 + E.Message);
          Result := False;
        end;
      end;
    end;
  finally
    FreeAndNil(qrExclusao);
  end;
end;

function TEmpresa.fRetornaUltimoCodigo(pIncrementa: Boolean = False): integer;
var
  qrPesquisa: TZQuery;
begin
  Try
    qrPesquisa := TZQuery.Create(nil);
    with qrPesquisa do
    begin
      Connection := zcoConnection;
      SQL.Clear;
      SQL.Add('SELECT COALESCE(MAX(iempresa),0) AS UltimoCodigo, COALESCE(MAX(iempresa),0)+1 AS ProximoCodigo FROM tbempresa');
      Open;
      if pIncrementa then
        Result := FieldByName('ProximoCodigo').AsInteger
      else
        Result := FieldByName('UltimoCodigo').AsInteger;
    end;
  Finally
    FreeAndNil(qrPesquisa);
  end;
end;

end.
