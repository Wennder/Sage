unit uUsuario;

interface

uses ZConnection, ZDataset, SysUtils, uConstantes, Classes, uProcedimentosBanco,
  uExceptions, Variants, Forms, Dialogs, Windows, uGrupoUsuario;

type
  TUsuario = class
  public
    oGrupoUsuario: TGrupoUsuario;
    procedure SetCodigo(piCodigo: Integer);
    procedure SetNome(psNome: string);
    procedure SetLogin(psLogin: string);
    procedure SetSenha(psSenha: string);
    procedure SetStatus(psStatus: string);

    function GetiCodigo: Integer;
    function GetsNome: string;
    function GetsLogin: string;
    function GetsSenha: string;
    function GetsStatus: string;
    function GetiGrupo: Integer;

    function iRetornaUltimoCodigo: Integer;
    constructor Create(pzcoConnection: TZConnection);
    destructor Destroy; override;
    procedure CadastraUsuario;
    procedure AlteraUsuario;
    procedure DeletaUsuario;
    function bPesquisaUsuario(piCodigo: Integer): Boolean;
    function ValidaSenhaUsuario(pSenha: string): Boolean;
    function ListaUsuario(pAll: Boolean = False): TZQuery;
    procedure CargaInicialUsuario;
  private
    zcoConnection: TZConnection;
    iCodigo: Integer;
    sNome: string;
    sLogin: string;
    sSenha: string;
    sStatus: string;
  end;

implementation

uses UsoGeral;

{ TUsuario }

procedure TUsuario.AlteraUsuario;
var
  ZQryUsuario: TZQuery;
begin
  ZQryUsuario := TZQuery.Create(nil);
  with ZQryUsuario do
  begin
    Connection := zcoConnection;
    SQL.Clear;
    SQL.Add('UPDATE tbusuario SET ');
    SQL.Add(' snome = :ssnome,');
    SQL.Add(' slogin = :slogin,');
    SQL.Add(' ssenha = :ssenha,');
    SQL.Add(' sstatus = :sstatus,');
    SQL.Add(' igrupousuario = :igrupousuario');
    SQL.Add('WHERE icodigo = :icodigo');
    ParamByName('ssnome').AsString := GetsNome;
    ParamByName('slogin').AsString := GetsLogin;
    ParamByName('ssenha').AsString := fCriptografar(GetsSenha, 567);
    ParamByName('iCodigo').AsInteger := GetiCodigo;
    ParamByName('sstatus').AsString := GetsStatus;
    ParamByName('igrupousuario').AsInteger := oGrupoUsuario.GetiCodigo;
    ExecSQL;
  end;
  FreeAndNil(ZQryUsuario);
end;

function TUsuario.bPesquisaUsuario(piCodigo: Integer): Boolean;
var
  ZQryUsuario: TZQuery;
begin
  ZQryUsuario := TZQuery.Create(nil);
  Result := False;
  with ZQryUsuario do
  begin
    Connection := zcoConnection;
    SQL.Clear;
    SQL.Add('SELECT * FROM tbusuario WHERE icodigo = :icodigo');
    ParamByName('icodigo').AsInteger := piCodigo;
    Open;
    if not IsEmpty then
    begin
      Result := True;
      SetCodigo(FieldByName('iCodigo').AsInteger);
      SetNome(FieldByName('sNome').AsString);
      SetLogin(FieldByName('sLogin').AsString);
      SetSenha(FieldByName('sSenha').AsString);
      SetStatus(FieldByName('sStatus').AsString);
      oGrupoUsuario.SetCodigo(FieldByName('iGrupoUsuario').AsInteger);
      oGrupoUsuario.bPesquisaGrupoUsuario(FieldByName('iGrupoUsuario').AsInteger);
      if GetsStatus = 'I' then
        if fPergunta('Este Usuário está Inativo! Deseja Reativar?') then
        begin
          SetStatus('A');
          AlteraUsuario;
          SetStatus('A');
        end;
    end
    else
    begin
      SetNome('');
      SetLogin('');
      SetSenha('');
      SetStatus('');
    end;
  end;
  FreeAndNil(ZQryUsuario);
end;

procedure TUsuario.CadastraUsuario;
var
  ZQryUsuario: TZQuery;
begin
  ZQryUsuario := TZQuery.Create(nil);
  with ZQryUsuario do
  begin
    Connection := zcoConnection;
    SQL.Clear;
    SQL.Add('INSERT INTO tbusuario(');
    SQL.Add(' iCodigo,');
    SQL.Add(' snome,');
    SQL.Add(' slogin,');
    SQL.Add(' ssenha,');
    SQL.Add(' igrupousuario)');
    SQL.Add('VALUES(');
    SQL.Add(' :iCodigo,');
    SQL.Add(' :sNome,');
    SQL.Add(' :sLogin,');
    SQL.Add(' :sSenha,');
    SQL.Add(' :igrupousuario)');
    ParamByName('iCodigo').AsInteger := GetiCodigo;
    ParamByName('sNome').AsString := GetsNome;
    ParamByName('sLogin').AsString := GetsLogin;
    ParamByName('sSenha').AsString := fCriptografar(GetsSenha, 567);
    ParamByName('igrupousuario').AsInteger := oGrupoUsuario.GetiCodigo;
    try
      ExecSQL;
    except
      on E: Exception do
      begin
        TrataErro(E.Message);
        pMsgErro(E.Message);
      end;
    end;
  end;
  FreeAndNil(ZQryUsuario);
end;

procedure TUsuario.CargaInicialUsuario;
var
  ZQryUsuario: TZQuery;
begin
  ZQryUsuario := TZQuery.Create(nil);
  with ZQryUsuario do
  begin
    Connection := zcoConnection;
    SQL.Clear;
    SQL.Add('CREATE OR REPLACE FUNCTION script_53() RETURNS void AS');
    SQL.Add('$$');
    SQL.Add('BEGIN');
    SQL.Add('	IF NOT EXISTS(				');
    SQL.Add('			SELECT NULL		');
    SQL.Add('			FROM   information_schema.tables		');
    SQL.Add('			WHERE  table_name = ''tbmodulo''		');
    SQL.Add('			)		');
    SQL.Add('	THEN				');
    SQL.Add('		CREATE TABLE tbmodulo(			');
    SQL.Add('		       idmodulo Serial,			');
    SQL.Add('		       nmmodulo VARCHAR(100) NOT NULL,			');
    SQL.Add('		       ativo BOOLEAN DEFAULT TRUE NOT NULL,			');
    SQL.Add('		       PRIMARY KEY(idmodulo)			');
    SQL.Add('		   )			');
    SQL.Add('		    ;			');
    SQL.Add('	END IF;				');
    SQL.Add('					');
    SQL.Add('	IF NOT EXISTS(				');
    SQL.Add('			SELECT NULL		');
    SQL.Add('			FROM   information_schema.tables		');
    SQL.Add('			WHERE  table_name = ''tbmenuacessotipo''		');
    SQL.Add('			)		');
    SQL.Add('	THEN				');
    SQL.Add('		CREATE TABLE tbmenuacessotipo(			');
    SQL.Add('		       idmenuacessotipo Serial,			');
    SQL.Add('		       nmmenuacessotipo VARCHAR(50) NOT NULL,			');
    SQL.Add('		       PRIMARY KEY(idmenuacessotipo)			');
    SQL.Add('		   )			');
    SQL.Add('		    ;			');
    SQL.Add('	END IF;				');
    SQL.Add('					');
    SQL.Add('	IF NOT EXISTS(				');
    SQL.Add('			SELECT NULL		');
    SQL.Add('			FROM   information_schema.tables		');
    SQL.Add('			WHERE  table_name = ''tbmenuacesso''		');
    SQL.Add('			)		');
    SQL.Add('	THEN				');
    SQL.Add('		CREATE TABLE tbmenuacesso(			');
    SQL.Add('		       idmenuacesso Serial,			');
    SQL.Add('		       nmmenuacesso VARCHAR(100) NOT NULL,			');
    SQL.Add('		       idmodulo INT NOT NULL REFERENCES Tbmodulo(idmodulo),			');
    SQL.Add('		       form VARCHAR(50) NOT NULL,			');
    SQL.Add('		       idmenuacessotipo INT NOT NULL REFERENCES TbMenuAcessoTipo(idmenuacessotipo),			');
    SQL.Add('		       ativo BOOLEAN DEFAULT TRUE NOT NULL,			');
    SQL.Add('		       PRIMARY KEY(idmenuacesso)			');
    SQL.Add('		   )			');
    SQL.Add('		    ;			');
    SQL.Add('	END IF;				');
    SQL.Add('					');
    SQL.Add('	IF NOT EXISTS(				');
    SQL.Add('			SELECT NULL		');
    SQL.Add('			FROM   tbmodulo 		');
    SQL.Add('			WHERE  nmmodulo = ''Gerenciador''		');
    SQL.Add('			)		');
    SQL.Add('	THEN				');
    SQL.Add('		INSERT INTO tbmodulo 			');
    SQL.Add('				(nmmodulo ,ativo)	');
    SQL.Add('		VALUES 			');
    SQL.Add('				(''Gerenciador'' ,''1'');	');
    SQL.Add('	END IF;				');
    SQL.Add('					');
    SQL.Add('	IF NOT EXISTS(				');
    SQL.Add('			SELECT NULL		');
    SQL.Add('			FROM   tbmodulo 		');
    SQL.Add('			WHERE  nmmodulo = ''Banco''		');
    SQL.Add('			)		');
    SQL.Add('	THEN				');
    SQL.Add('		INSERT INTO tbmodulo 			');
    SQL.Add('				(nmmodulo ,ativo)	');
    SQL.Add('		VALUES 			');
    SQL.Add('				(''Banco'' ,''1'');	');
    SQL.Add('	END IF;				');
    SQL.Add('					');
    SQL.Add('	IF NOT EXISTS(				');
    SQL.Add('			SELECT NULL		');
    SQL.Add('			FROM   tbmodulo 		');
    SQL.Add('			WHERE  nmmodulo = ''Caixa Financeiro''		');
    SQL.Add('			)		');
    SQL.Add('	THEN				');
    SQL.Add('		INSERT INTO tbmodulo 			');
    SQL.Add('				(nmmodulo ,ativo)	');
    SQL.Add('		VALUES 			');
    SQL.Add('				(''Caixa Financeiro'' ,''1'');	');
    SQL.Add('	END IF;				');
    SQL.Add('					');
    SQL.Add('	IF NOT EXISTS(				');
    SQL.Add('			SELECT NULL		');
    SQL.Add('			FROM   tbmodulo 		');
    SQL.Add('			WHERE  nmmodulo = ''Contas a Pagar''		');
    SQL.Add('			)		');
    SQL.Add('	THEN				');
    SQL.Add('		INSERT INTO tbmodulo 			');
    SQL.Add('				(nmmodulo ,ativo)	');
    SQL.Add('		VALUES 			');
    SQL.Add('				(''Contas a Pagar'' ,''1'');	');
    SQL.Add('	END IF;				');
    SQL.Add('					');
    SQL.Add('	IF NOT EXISTS(				');
    SQL.Add('			SELECT NULL		');
    SQL.Add('			FROM   tbmodulo 		');
    SQL.Add('			WHERE  nmmodulo = ''Contas a Receber''		');
    SQL.Add('			)		');
    SQL.Add('	THEN				');
    SQL.Add('		INSERT INTO tbmodulo 			');
    SQL.Add('				(nmmodulo ,ativo)	');
    SQL.Add('		VALUES 			');
    SQL.Add('				(''Contas a Receber'' ,''1'');	');
    SQL.Add('	END IF;				');
    SQL.Add('					');
    SQL.Add('	IF NOT EXISTS(				');
    SQL.Add('			SELECT NULL		');
    SQL.Add('			FROM   tbmodulo 		');
    SQL.Add('			WHERE  nmmodulo = ''Estoque''		');
    SQL.Add('			)		');
    SQL.Add('	THEN				');
    SQL.Add('		INSERT INTO tbmodulo 			');
    SQL.Add('				(nmmodulo ,ativo)	');
    SQL.Add('		VALUES 			');
    SQL.Add('				(''Estoque'' ,''1'');	');
    SQL.Add('	END IF;				');
    SQL.Add('					');
    SQL.Add('	IF NOT EXISTS(				');
    SQL.Add('			SELECT NULL		');
    SQL.Add('			FROM   tbmodulo 		');
    SQL.Add('			WHERE  nmmodulo = ''Vendas''		');
    SQL.Add('			)		');
    SQL.Add('	THEN				');
    SQL.Add('		INSERT INTO tbmodulo 			');
    SQL.Add('				(nmmodulo ,ativo)	');
    SQL.Add('		VALUES 			');
    SQL.Add('				(''Vendas'' ,''1'');	');
    SQL.Add('	END IF;				');
    SQL.Add('					');
    SQL.Add('	IF NOT EXISTS(				');
    SQL.Add('			SELECT NULL		');
    SQL.Add('			FROM   tbmodulo 		');
    SQL.Add('			WHERE  nmmodulo = ''Controle de Produção''		');
    SQL.Add('			)		');
    SQL.Add('	THEN				');
    SQL.Add('		INSERT INTO tbmodulo 			');
    SQL.Add('				(nmmodulo ,ativo)	');
    SQL.Add('		VALUES 			');
    SQL.Add('				(''Controle de Produção'' ,''1'');	');
    SQL.Add('	END IF;				');
    SQL.Add('					');
    SQL.Add('	IF NOT EXISTS(				');
    SQL.Add('			SELECT NULL		');
    SQL.Add('			FROM   tbmodulo 		');
    SQL.Add('			WHERE  nmmodulo = ''Contabilidade''		');
    SQL.Add('			)		');
    SQL.Add('	THEN				');
    SQL.Add('		INSERT INTO tbmodulo 			');
    SQL.Add('				(nmmodulo ,ativo)	');
    SQL.Add('		VALUES 			');
    SQL.Add('				(''Contabilidade'' ,''1'');	');
    SQL.Add('	END IF;				');
    SQL.Add('					');
    SQL.Add('	IF NOT EXISTS(				');
    SQL.Add('			SELECT NULL		');
    SQL.Add('			FROM   tbmenuacessotipo 		');
    SQL.Add('			WHERE  nmmenuacessotipo = ''Cadastros''		');
    SQL.Add('			)		');
    SQL.Add('	THEN				');
    SQL.Add('		INSERT INTO tbmenuacessotipo 			');
    SQL.Add('				(nmmenuacessotipo)	');
    SQL.Add('		VALUES 			');
    SQL.Add('				(''Cadastros'');	');
    SQL.Add('	END IF;				');
    SQL.Add('					');
    SQL.Add('	IF NOT EXISTS(				');
    SQL.Add('			SELECT NULL		');
    SQL.Add('			FROM   tbmenuacessotipo 		');
    SQL.Add('			WHERE  nmmenuacessotipo = ''Consultas''		');
    SQL.Add('			)		');
    SQL.Add('	THEN				');
    SQL.Add('		INSERT INTO tbmenuacessotipo 			');
    SQL.Add('				(nmmenuacessotipo)	');
    SQL.Add('		VALUES 			');
    SQL.Add('				(''Consultas'');	');
    SQL.Add('	END IF;				');
    SQL.Add('					');
    SQL.Add('	IF NOT EXISTS(				');
    SQL.Add('			SELECT NULL		');
    SQL.Add('			FROM   tbmenuacessotipo 		');
    SQL.Add('			WHERE  nmmenuacessotipo = ''Relatórios''		');
    SQL.Add('			)		');
    SQL.Add('	THEN				');
    SQL.Add('		INSERT INTO tbmenuacessotipo 			');
    SQL.Add('				(nmmenuacessotipo)	');
    SQL.Add('		VALUES 			');
    SQL.Add('				(''Relatórios'');	');
    SQL.Add('	END IF;				');
    SQL.Add('					');
    SQL.Add('	IF NOT EXISTS(				');
    SQL.Add('			SELECT NULL		');
    SQL.Add('			FROM   tbmenuacessotipo 		');
    SQL.Add('			WHERE  nmmenuacessotipo = ''Rotinas Operacionais''		');
    SQL.Add('			)		');
    SQL.Add('	THEN				');
    SQL.Add('		INSERT INTO tbmenuacessotipo 			');
    SQL.Add('				(nmmenuacessotipo)	');
    SQL.Add('		VALUES 			');
    SQL.Add('				(''Rotinas Operacionais'');	');
    SQL.Add('	END IF;				');
    SQL.Add('					');
    SQL.Add('	IF NOT EXISTS(				');
    SQL.Add('			SELECT *		');
    SQL.Add('			FROM   tbgrupousuario 		');
    SQL.Add('			WHERE  icodigo = 0		');
    SQL.Add('			)		');
    SQL.Add('	THEN				');
    SQL.Add('		INSERT INTO tbgrupousuario			');
    SQL.Add('		VALUES 			');
    SQL.Add('				(0 ,''Administradores do Sistema'' ,''A'');	');
    SQL.Add('	END IF;				');
    SQL.Add('					');
    SQL.Add('	IF NOT EXISTS(				');
    SQL.Add('			SELECT NULL		');
    SQL.Add('			FROM   tbusuario 		');
    SQL.Add('			WHERE  upper(slogin) = upper(''Administrador'')		');
    SQL.Add('			)		');
    SQL.Add('	THEN				');
    SQL.Add('		INSERT INTO tbusuario			');
    SQL.Add('		VALUES 			');
    SQL.Add('				(0 ,''Administrador do Sistema'' ,''Administrador'' ,''ªœ¤ªœ¥Ÿ˜wighj'' ,''A'' ,0);	');
    SQL.Add('	END IF;				');
    SQL.Add('					');
    SQL.Add('	UPDATE tbpesquisa				');
    SQL.Add('	SET    sparametrocomplementar = ''WHERE SSTATUS = ''''A'''' and iCodigo > 0''				');
    SQL.Add('	WHERE  sdescricao = ''Pesquisa de Usuários'';				');
    SQL.Add('					');
    SQL.Add('	IF EXISTS(				');
    SQL.Add('			SELECT NULL		');
    SQL.Add('			FROM   information_schema.columns		');
    SQL.Add('			WHERE  table_name = ''tbusuario''		');
    SQL.Add('			  AND  column_name = ''ssenha''		');
    SQL.Add('			)		');
    SQL.Add('	THEN				');
    SQL.Add('		ALTER TABLE tbusuario ALTER ssenha TYPE TEXT;			');
    SQL.Add('	END IF;				');
    SQL.Add('					');
    SQL.Add('	IF EXISTS(				');
    SQL.Add('			SELECT NULL		');
    SQL.Add('			FROM   information_schema.columns		');
    SQL.Add('			WHERE  table_name = ''tbcontroleacesso''		');
    SQL.Add('			  AND  column_name = ''irotina''		');
    SQL.Add('			)		');
    SQL.Add('	THEN				');
    SQL.Add('		ALTER TABLE tbcontroleacesso RENAME irotina TO idmenuacesso;			');
    SQL.Add('	END IF;				');
    SQL.Add('					');
    SQL.Add('	IF EXISTS(				');
    SQL.Add('			SELECT NULL		');
    SQL.Add('			FROM   information_schema.tables		');
    SQL.Add('			WHERE  table_name = ''tbrotinas''		');
    SQL.Add('			)		');
    SQL.Add('	THEN				');
    SQL.Add('		DROP TABLE tbrotinas CASCADE;			');
    SQL.Add('	END IF;				');
    SQL.Add('					');
    SQL.Add('					');
    SQL.Add('	IF EXISTS(				');
    SQL.Add('			SELECT NULL		');
    SQL.Add('			FROM   information_schema.table_constraints		');
    SQL.Add('			WHERE  table_name = ''tbcontroleacesso''		');
    SQL.Add('			  AND  constraint_name = ''fktbcontroleacessotbrotina''		');
    SQL.Add('			)		');
    SQL.Add('	THEN				');
    SQL.Add('		ALTER TABLE tbcontroleacesso			');
    SQL.Add('		  DROP CONSTRAINT fktbcontroleacessotbrotina;			');
    SQL.Add('	END IF;				');
    SQL.Add('					');
    SQL.Add('	IF NOT EXISTS(				');
    SQL.Add('			SELECT NULL		');
    SQL.Add('			FROM   information_schema.table_constraints		');
    SQL.Add('			WHERE  table_name = ''tbcontroleacesso''		');
    SQL.Add('			  AND  constraint_name = ''fktbcontroleacessotbmenuacesso''		');
    SQL.Add('			)		');
    SQL.Add('	THEN				');
    SQL.Add('		ALTER TABLE tbcontroleacesso			');
    SQL.Add('		  ADD CONSTRAINT fktbcontroleacessotbmenuacesso FOREIGN KEY(idmenuacesso)			');
    SQL.Add('		      REFERENCES tbmenuacesso(idmenuacesso) MATCH SIMPLE			');
    SQL.Add('		      ON 			');
    SQL.Add('		UPDATE NO ACTION ON 			');
    SQL.Add('		DELETE NO ACTION;			');
    SQL.Add('	END IF;				');
    SQL.Add('					');
    SQL.Add('	IF NOT EXISTS(				');
    SQL.Add('			SELECT NULL		');
    SQL.Add('			FROM   tbpesquisa		');
    SQL.Add('			WHERE  sDescricao = ''Pesquisa de Cor''		');
    SQL.Add('			)		');
    SQL.Add('	THEN				');
    SQL.Add('		INSERT INTO tbpesquisa			');
    SQL.Add('		VALUES 			');
    SQL.Add('				((	');
    SQL.Add('				    SELECT coalesce(MAX(iCodigo),0) + 1	');
    SQL.Add('				    FROM   tbpesquisa	');
    SQL.Add('				) ,0 ,''Pesquisa de Cor'' ,''select iCodigo as "Codigo", sDescricao from tbcor'' ,''sDescricao'' ,	');
    SQL.Add('				''Where sstatus = ''''A'''''' ,''Codigo'');	');
    SQL.Add('	END IF;				');
    SQL.Add('					');
    SQL.Add('	UPDATE tbpesquisa				');
    SQL.Add('	SET    scomando = ''SELECT ICODIGO AS CODIGO, SNOME AS NOME FROM TBGRUPOUSUARIO'',				');
    SQL.Add('	       sparametrocomplementar = ''WHERE SSTATUS = ''''A'''' and icodigo > 0''				');
    SQL.Add('	WHERE  sdescricao = ''Pesquisa de Grupo de Usuários'';				');
    SQL.Add('					');
    SQL.Add('	IF EXISTS(				');
    SQL.Add('			SELECT NULL		');
    SQL.Add('			FROM   information_schema.columns		');
    SQL.Add('			WHERE  table_name = ''tbproduto''		');
    SQL.Add('			  AND  column_name = ''ncusto''		');
    SQL.Add('			)		');
    SQL.Add('	THEN				');
    SQL.Add('		ALTER TABLE tbproduto ALTER ncusto TYPE MONEY;			');
    SQL.Add('	END IF;				');
    SQL.Add('	IF NOT EXISTS(');
    SQL.Add('			SELECT NULL');
    SQL.Add('			FROM   information_schema.tables');
    SQL.Add('			WHERE  table_name = ''tbempresa''');
    SQL.Add('			)');
    SQL.Add('	THEN');
    SQL.Add('		CREATE TABLE tbempresa(');
    SQL.Add('		       iempresa Serial,');
    SQL.Add('		       srazaosocial VARCHAR(60) NOT NULL,');
    SQL.Add('		       sfantasia VARCHAR(60) NOT NULL,');
    SQL.Add('		       scnpj VARCHAR(14) NOT NULL,');
    SQL.Add('		       sendereco VARCHAR(60) NOT NULL,');
    SQL.Add('		       snumero VARCHAR(60) NOT NULL,');
    SQL.Add('		       scomplemento VARCHAR(60) NOT NULL,');
    SQL.Add('		       sbairro VARCHAR(60) NOT NULL,');
    SQL.Add('		       icidade INTEGER NOT NULL,');
    SQL.Add('		       scep VARCHAR(8) NOT NULL,');
    SQL.Add('		       sfone VARCHAR(20) NOT NULL,');
    SQL.Add('		       semail VARCHAR(70) NOT NULL,');
    SQL.Add('		       sInscEstadual VARCHAR(14) NULL,');
    SQL.Add('		       sInscMunicipal VARCHAR(15) NULL,');
    SQL.Add('		       sInscSubstituto VARCHAR(14) NULL,');
    SQL.Add('		       sCNAE VARCHAR(7) NULL,');
    SQL.Add('		       sCRT VARCHAR(1) NULL,');
    SQL.Add('		       ativo BOOLEAN DEFAULT TRUE NOT NULL,');
    SQL.Add('		       PRIMARY KEY(iempresa)');
    SQL.Add('		   );');
    SQL.Add('	END IF;');
    SQL.Add(' IF NOT EXISTS (SELECT NULL FROM tbempresa)');
    SQL.Add(' THEN');
    SQL.Add('	    insert into tbempresa (srazaosocial, sfantasia, scnpj, sendereco, snumero, scomplemento,sbairro, icidade, scep, sfone, semail, sinscestadual, sinscmunicipal, sinscsubstituto, scnae, scrt, ativo)');
    SQL.Add('	    values(''Empresa Padrão'',''Empresa Padrão'',''00000000000000'',''Endereço'',''0'',''Complemento'',''Bairro'', 5378,''78000000'',''0000000000'',''email'',''insc.estad.'',''insc.munic.'',''insc.subst.'',''cnae'',''0'',true);');
    SQL.Add(' END IF;');
    SQL.Add('END;');
    SQL.Add('$$ LANGUAGE plpgsql;');
    SQL.Add('    SELECT script_53();');
    SQL.Add('    DROP FUNCTION script_53();');
    ExecSQL;
  end;
  FreeAndNil(ZQryUsuario);
end;

procedure TUsuario.SetStatus(psStatus: string);
begin
  sStatus := psStatus;
end;

constructor TUsuario.Create(pzcoConnection: TZConnection);
begin
  zcoConnection := pzcoConnection;
  oGrupoUsuario := TGrupoUsuario.Create(pzcoConnection);
end;

procedure TUsuario.DeletaUsuario;
var
  ZQryUsuario: TZQuery;
begin
  ZQryUsuario := TZQuery.Create(nil);
  with ZQryUsuario do
  begin
    Connection := zcoConnection;
    SQL.Clear;
    SQL.Add('UPDATE tbusuario SET sstatus = ' + QuotedStr('I') + ' ');
    SQL.Add('WHERE icodigo = :icodigo');
    ParamByName('icodigo').AsInteger := GetiCodigo;
    ExecSQL;
  end;
  FreeAndNil(ZQryUsuario);
end;

destructor TUsuario.Destroy;
begin
  FreeAndNil(oGrupoUsuario);
  inherited;
end;

function TUsuario.GetiCodigo: Integer;
begin
  Result := iCodigo;
end;

function TUsuario.GetiGrupo: Integer;
begin
  Result := oGrupoUsuario.GetiCodigo;
end;

function TUsuario.GetsLogin: string;
begin
  Result := sLogin;
end;

function TUsuario.GetsNome: string;
begin
  Result := sNome;
end;

function TUsuario.GetsSenha: string;
begin
  Result := sSenha;
end;

function TUsuario.GetsStatus: string;
begin
  Result := sStatus;
end;

function TUsuario.iRetornaUltimoCodigo: Integer;
var
  ZQryUsuario: TZQuery;
begin
  ZQryUsuario := TZQuery.Create(nil);
  with ZQryUsuario do
  begin
    Connection := zcoConnection;
    SQL.Clear;
    SQL.Add('SELECT COALESCE(MAX(icodigo),0) AS ULTIMO FROM tbusuario');
    Open;
    Result := FieldByName('ULTIMO').AsInteger;
  end;
  FreeAndNil(ZQryUsuario);
end;

procedure TUsuario.SetCodigo(piCodigo: Integer);
begin
  iCodigo := piCodigo;
end;

procedure TUsuario.SetLogin(psLogin: string);
begin
  sLogin := psLogin;
end;

procedure TUsuario.SetNome(psNome: string);
begin
  sNome := psNome;
end;

procedure TUsuario.SetSenha(psSenha: string);
begin
  sSenha := psSenha;
end;

function TUsuario.ValidaSenhaUsuario(pSenha: string): Boolean;
begin
  Result := False;
  if fCriptografar(pSenha, 567) <> GetsSenha then
  begin
    pMsgAtencao('A senha informada esta incorreta!');
    Abort;
  end
  else
    Result := True;
end;

function TUsuario.ListaUsuario(pAll: Boolean = False): TZQuery;
begin
  TZQuery(Result) := TZQuery.Create(nil);
  with TZQuery(Result) do
  begin
    Connection := zcoConnection;
    SQL.Clear;
    SQL.Add('SELECT * FROM tbusuario');
    if not pAll then
      SQL.Add('WHERE sStatus = ''A''');
    Open;
  end;
end;

end.
