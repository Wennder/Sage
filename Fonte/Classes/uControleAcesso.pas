unit uControleAcesso;

interface

uses ZConnection, ZDataset, SysUtils, uConstantes, Classes, uProcedimentosBanco,
  uExceptions, Variants, Forms, Dialogs, Windows, uGrupoUsuario, Contnrs;

type

  TRotina = class
  public
    procedure SetCodigo(piCodigo: Integer);
    procedure SetDescricao(psDescricao: string);
    procedure SetFormulario(psFormulario: string);
    procedure SetTipo(psTipo: string);
    procedure SetTemAcesso(pbTemAcesso: Boolean);

    function GetiCodigo: Integer;
    function GetsDescricao: string;
    function GetsFormulario: string;
    function GetsTipo: string;
    function GetTemAcesso: Boolean;

    constructor Create(pzcoConnection: TZConnection);
    destructor Destroy; override;

    function bPesquisaRotina(piCodigo, piCodigoGrupo: Integer): Boolean;
    function bPesquisaAcesso(piCodigoGrupo: Integer; psForm: string): String;
  private
    zcoConnection: TZConnection;
    iCodigo: Integer;
    sDescricao: string;
    sFormulario: string;
    sTipo: string;
    bTemAcesso: Boolean;
  end;

  TControleAcesso = class
  public
    oGrupoUsuario: TGrupoUsuario;
    oRotina: TRotina;
    procedure SetCodigo(piCodigo: Integer);
    procedure SetCodigoGrupo(piCodigoGrupo: Integer);
    procedure SetCodigoMenu(piCodigoMenu: Integer);

    function GetiCodigo: Integer;
    function GetiCodigoGrupo: Integer;
    function GetiCodigoMenu: Integer;

    function iRetornaUltimoCodigo: Integer;
    constructor Create(pzcoConnection: TZConnection);
    destructor Destroy; override;
    procedure CadastraAcesso;
    procedure DeletaAcesso;
    function bPesquisaAcessoGrupoUsuarioRotina(piGrupoUsuario, piRotina: Integer): Boolean;
    function bPesquisaAcessoCodigo(piCodigo: Integer): Boolean;
  private
    zcoConnection: TZConnection;
    iCodigo: Integer;
    iRotina: Integer;
    iCodigoGrupo: Integer;
    iCodigoMenu: Integer;
  end;

  TAcesso = class
  public
    oListaAcesso: TObjectList;

    constructor Create(pzcoConnection: TZConnection);
    destructor Destroy; override;

    procedure bPesquisaAcessoGrupoUsuario(piGrupoUsuario: Integer);
  private
    zcoConnection: TZConnection;
  end;

  TListaRotinas = class
  public
    oListaRotinas: TObjectList;
    constructor Create(pzcoConnection: TZConnection);
    procedure ListaRotinas(piCodigoGrupo: Integer);

  private
    zcoConnection: TZConnection;
  end;

implementation

uses UsoGeral, ZAbstractRODataset;

{ TControleAcesso }

function TControleAcesso.bPesquisaAcessoCodigo(piCodigo: Integer): Boolean;
var
  ZQryAcesso: TZQuery;
begin
  ZQryAcesso := TZQuery.Create(nil);
  with ZQryAcesso do
  begin
    Connection := zcoConnection;
    SQL.Clear;
    SQL.Add('select * from tbcontroleacesso where icodigo = :codigo');
    ParamByName('Codigo').AsInteger := piCodigo;
    Open;

    Result := not(Bof and Eof);

    SetCodigo(piCodigo);
    oGrupoUsuario.SetCodigo(FieldByName('igrupousuario').AsInteger);
    oRotina.SetCodigo(FieldByName('idmenuacesso').AsInteger);
    oGrupoUsuario.bPesquisaGrupoUsuario(FieldByName('igrupousuario').AsInteger);
    oRotina.bPesquisaRotina(FieldByName('idmenuacesso').AsInteger, FieldByName('igrupousuario').AsInteger);
  end;
  FreeAndNil(ZQryAcesso);
end;

function TControleAcesso.bPesquisaAcessoGrupoUsuarioRotina(piGrupoUsuario, piRotina: Integer): Boolean;
var
  ZQryAcesso: TZQuery;
begin
  ZQryAcesso := TZQuery.Create(nil);
  with ZQryAcesso do
  begin
    Connection := zcoConnection;
    SQL.Clear;
    SQL.Add('select * from tbcontroleacesso where igrupousuario = :grupousuario and idmenuacesso = :rotina');
    ParamByName('grupousuario').AsInteger := piGrupoUsuario;
    ParamByName('rotina').AsInteger := piRotina;
    Open;
    Result := not(Bof and Eof);
    SetCodigo(FieldByName('icodigo').AsInteger);
    oGrupoUsuario.SetCodigo(FieldByName('igrupousuario').AsInteger);
    oRotina.SetCodigo(FieldByName('idmenuacesso').AsInteger);
    oGrupoUsuario.bPesquisaGrupoUsuario(FieldByName('igrupousuario').AsInteger);
    oRotina.bPesquisaRotina(FieldByName('idmenuacesso').AsInteger, FieldByName('igrupousuario').AsInteger);
  end;

  FreeAndNil(ZQryAcesso);
end;

procedure TControleAcesso.CadastraAcesso;
var
  ZQryAcesso: TZQuery;
begin
  ZQryAcesso := TZQuery.Create(nil);
  with ZQryAcesso do
  begin
    Connection := zcoConnection;
    SQL.Clear;
    SQL.Add('INSERT INTO tbcontroleacesso(');
    SQL.Add(' iCodigo,');
    SQL.Add(' igrupousuario,');
    SQL.Add(' idmenuacesso)');
    SQL.Add('VALUES(');
    SQL.Add(' :iCodigo,');
    SQL.Add(' :igrupousuario,');
    SQL.Add(' :idmenuacesso)');
    ParamByName('iCodigo').AsInteger := iRetornaUltimoCodigo + 1;
    ParamByName('iGrupoUsuario').AsInteger := GetiCodigoGrupo;
    ParamByName('idmenuacesso').AsInteger := GetiCodigoMenu;
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
  FreeAndNil(ZQryAcesso);
end;

constructor TControleAcesso.Create(pzcoConnection: TZConnection);
begin
  zcoConnection := pzcoConnection;
  oGrupoUsuario := TGrupoUsuario.Create(pzcoConnection);
  oRotina := TRotina.Create(pzcoConnection);
end;

procedure TControleAcesso.DeletaAcesso;
var
  ZQryAcesso: TZQuery;
begin
  ZQryAcesso := TZQuery.Create(nil);
  with ZQryAcesso do
  begin
    Connection := zcoConnection;
    SQL.Clear;
    SQL.Add('DELETE FROM tbcontroleacesso');
    SQL.Add(' WHERE iGrupoUsuario = :iGrupoUsuario');
    SQL.Add('   AND idmenuacesso = :idmenuacesso');

    ParamByName('iGrupoUsuario').AsInteger := GetiCodigoGrupo;
    ParamByName('idmenuacesso').AsInteger := GetiCodigoMenu;
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
  FreeAndNil(ZQryAcesso);
end;

destructor TControleAcesso.Destroy;
begin
  FreeAndNil(oGrupoUsuario);
  FreeAndNil(oRotina);
  inherited;
end;

function TControleAcesso.GetiCodigo: Integer;
begin
  Result := iCodigo;
end;

function TControleAcesso.GetiCodigoGrupo: Integer;
begin
  Result := iCodigoGrupo;
end;

function TControleAcesso.GetiCodigoMenu: Integer;
begin
  Result := iCodigoMenu;
end;

function TControleAcesso.iRetornaUltimoCodigo: Integer;
var
  ZQryAcesso: TZQuery;
begin
  ZQryAcesso := TZQuery.Create(nil);
  with ZQryAcesso do
  begin
    Connection := zcoConnection;
    SQL.Clear;
    SQL.Add('SELECT COALESCE(MAX(icodigo),0) AS ULTIMO FROM tbcontroleacesso');
    Open;
    Result := FieldByName('ULTIMO').AsInteger;
  end;
  FreeAndNil(ZQryAcesso);
end;

procedure TControleAcesso.SetCodigo(piCodigo: Integer);
begin
  iCodigo := piCodigo;
end;

procedure TControleAcesso.SetCodigoGrupo(piCodigoGrupo: Integer);
begin
  iCodigoGrupo := piCodigoGrupo;
end;

procedure TControleAcesso.SetCodigoMenu(piCodigoMenu: Integer);
begin
  iCodigoMenu := piCodigoMenu;
end;

{ TAcesso }

procedure TAcesso.bPesquisaAcessoGrupoUsuario(piGrupoUsuario: Integer);
var
  ZQryAcesso: TZQuery;
  iIndice: Integer;
begin
  ZQryAcesso := TZQuery.Create(nil);
  with ZQryAcesso do
  begin
    Connection := zcoConnection;
    SQL.Clear;
    SQL.Add('SELECT * FROM tbcontroleacesso where igrupousuario = :grupousuario');
    ParamByName('grupousuario').AsInteger := piGrupoUsuario;
    Open;
    while not Eof do
    begin
      iIndice := oListaAcesso.Add(TControleAcesso.Create(zcoConnection));
      TControleAcesso(oListaAcesso.Items[iIndice]).SetCodigo(FieldByName('icodigo').AsInteger);
      TControleAcesso(oListaAcesso.Items[iIndice]).bPesquisaAcessoCodigo(FieldByName('icodigo').AsInteger);
      Next;
    end;
  end;
  FreeAndNil(ZQryAcesso);
end;

constructor TAcesso.Create(pzcoConnection: TZConnection);
begin
  zcoConnection := pzcoConnection;
  oListaAcesso := TObjectList.Create;
end;

destructor TAcesso.Destroy;
begin
  FreeAndNil(oListaAcesso);
  inherited;
end;

{ TRotina }

function TRotina.bPesquisaRotina(piCodigo, piCodigoGrupo: Integer): Boolean;
var
  ZQryRotina: TZQuery;
begin
  ZQryRotina := TZQuery.Create(nil);
  with ZQryRotina do
  begin
    Connection := zcoConnection;
    SQL.Clear;

    SQL.Add('SELECT *');
    SQL.Add('      ,CASE');
    SQL.Add('            WHEN icodigo IS NULL THEN ''N''');
    SQL.Add('            ELSE ''S''');
    SQL.Add('       END AS possuiacesso');
    SQL.Add('FROM   tbmenuacesso ma');
    SQL.Add('INNER JOIN tbmodulo m ON m.idmodulo = ma.idmodulo');
    SQL.Add('INNER JOIN tbmenuacessotipo mat ON mat.idmenuacessotipo = ma.idmenuacessotipo');
    SQL.Add('LEFT JOIN tbcontroleacesso ca ON ca.idmenuacesso = ma.idmenuacesso and ca.igrupousuario = :codigogrupo');
    SQL.Add('WHERE  ma.ativo = ''t''');
    SQL.Add('and ma.idmenuacesso = :codigo');
    SQL.Add('ORDER BY ma.idmodulo');
    SQL.Add('      	 ,ma.idmenuacessotipo');
    SQL.Add('      	 ,ma.nmmenuacesso');

    ParamByName('codigo').AsInteger := piCodigo;
    ParamByName('codigogrupo').AsInteger := piCodigoGrupo;
    Open;
    Result := not(Bof and Eof);
    SetCodigo(FieldByName('idmenuacesso').AsInteger);
    SetDescricao(FieldByName('nmmenuacesso').AsString);
    SetFormulario(FieldByName('form').AsString);
    SetTipo(FieldByName('nmmenuacessotipo').AsString);
    SetTemAcesso(iif(FieldByName('possuiacesso').AsString = 'S', True, False));
  end;
  FreeAndNil(ZQryRotina);
end;

constructor TRotina.Create(pzcoConnection: TZConnection);
begin
  zcoConnection := pzcoConnection;
end;

destructor TRotina.Destroy;
begin

  inherited;
end;

function TRotina.GetiCodigo: Integer;
begin
  Result := iCodigo;
end;

function TRotina.GetsDescricao: string;
begin
  Result := sDescricao;
end;

function TRotina.GetsFormulario: string;
begin
  Result := sFormulario;
end;

function TRotina.GetsTipo: string;
begin
  Result := sTipo;
end;

function TRotina.GetTemAcesso: Boolean;
begin
  Result := bTemAcesso;
end;

procedure TRotina.SetCodigo(piCodigo: Integer);
begin
  iCodigo := piCodigo;
end;

procedure TRotina.SetDescricao(psDescricao: string);
begin
  sDescricao := psDescricao;
end;

procedure TRotina.SetFormulario(psFormulario: string);
begin
  sFormulario := psFormulario;
end;

procedure TRotina.SetTemAcesso(pbTemAcesso: Boolean);
begin
  bTemAcesso := pbTemAcesso;
end;

procedure TRotina.SetTipo(psTipo: string);
begin
  sTipo := psTipo;
end;

{ TListaRotinas }

constructor TListaRotinas.Create(pzcoConnection: TZConnection);
begin
  zcoConnection := pzcoConnection;
end;

procedure TListaRotinas.ListaRotinas(piCodigoGrupo: Integer);
var
  Qry: TZQuery;
  iIndice: Integer;
begin
  Qry := TZQuery.Create(nil);
  with Qry do
  begin
    Connection := zcoConnection;
    SQL.Clear;
    SQL.Add('select * from tbmenuacesso');
    SQL.Add('where ativo = true');
    Open;

    oListaRotinas := TObjectList.Create;
    while not Eof do
    begin
      iIndice := oListaRotinas.Add(TRotina.Create(zcoConnection));
      TRotina(oListaRotinas.Items[iIndice]).SetCodigo(FieldByName('idmenuacesso').AsInteger);
      TRotina(oListaRotinas.Items[iIndice]).bPesquisaRotina(FieldByName('idmenuacesso').AsInteger, piCodigoGrupo);
      Next;
    end;
  end;
  FreeAndNil(Qry);
end;

function TRotina.bPesquisaAcesso(piCodigoGrupo: Integer; psForm: string): String;
var
  ZQry: TZQuery;
begin
  { F = Falso / T = Verdadeiro / I = Inativo }
  ZQry := TZQuery.Create(nil);
  Result := 'I';
  with ZQry do
  begin
    Connection := zcoConnection;
    SQL.Clear;
    SQL.Add('SELECT * FROM tbcontroleacesso ca');
    SQL.Add('left join tbmenuacesso ma on ma.idmenuacesso = ca.idmenuacesso');
    SQL.Add(' WHERE iGrupoUsuario = :iGrupoUsuario');
    SQL.Add('   AND form = :sForm');
    ParamByName('iGrupoUsuario').AsInteger := piCodigoGrupo;
    ParamByName('sForm').AsString := psForm;

    Open;

    if not IsEmpty then
    begin
      if FieldByName('ativo').asBoolean then
        Result := 'T'
      else
        Result := 'I'
    end
    else
      Result := 'F';
  end;
  FreeAndNil(ZQry);
end;

end.
