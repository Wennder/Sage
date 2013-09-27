unit uScript;

interface

uses ZConnection, ZDataset, SysUtils, uConstantes, Classes, Contnrs, uProcedimentosBanco, uExceptions, Variants, Forms,
  Dialogs, Windows, Datasnap.DBClient, UsoGeral, Vcl.FileCtrl, Data.DB, Vcl.StdCtrls;

type
  TScript = class
  public
    constructor Create(pzcoConnection: TZConnection);
    destructor Destroy; override;

    function Getidscript: Variant;
    procedure Setidscript(pParametro: Variant);

    function Getnmscript: Variant;
    procedure Setnmscript(pParametro: Variant);

    function Getdataexecucao: Variant;
    procedure Setdataexecucao(pParametro: Variant);

    function Getidusuario: Variant;
    procedure Setidusuario(pParametro: Variant);

    function Getconteudo: Variant;
    procedure Setconteudo(pParametro: Variant);

    procedure GravaScript; { Gravar informações do script na tabela tbscript }
    procedure ListaScriptExecutado(pQuery: TZQuery); { Relaciona todos os scripts executados existentes na tabela tbscript }
    function ConsultaScriptExecutado(pNmScript: String): Boolean; { Consulta se um script foi executado }
    procedure ListaScriptPendente(pFormChamada: TForm; pcdsLista: TClientDataSet; pPastaArquivos: String); { Carrega lista de scripts pendentes }
    function AbreScript(pFormChamada: TForm; pCaminhoArquivo, nmscript: String): String; { Abre conteúdo do arquivo de script }
    function ExecutaScript(pFormChamada: TForm; pCaminhoArquivo, nmscript: String): Boolean; { Executa o conteudo do arquivo de script }
    function RetornaUltScriptExecutado(): String;
    procedure CargaInicialScript;
  private
    zcoConnection: TZConnection;

    idscript: integer;
    nmscript: string;
    dataexecucao: TDatetime;
    idusuario: integer;
    conteudo: WideString;
  end;

implementation

{ TScript }

function TScript.AbreScript(pFormChamada: TForm; pCaminhoArquivo, nmscript: String): string;
Var
  memo: TMemo;
begin
  memo := TMemo.Create(Nil);
  Try
    Result := '';
    Try
      with memo do
      begin
        Parent := pFormChamada;
        Visible := False;
        Lines.LoadFromFile(pCaminhoArquivo);
      end;
    except
      on E: Exception do
      begin
        pMsgAtencao('Não foi abrir o script "' + nmscript + '".' + #13 +
          'Verifique os detalhes do erro e contate o suporte para transmitir o problema.', 'Mensagem original: ' + #13 + E.Message);
        Result := '';
      end;
    end;
  Finally
    Result := memo.Text;
    FreeAndNil(memo);
  End;
end;

procedure TScript.CargaInicialScript;
Var
  qrExec: TZQuery;
begin
  Try
    qrExec := TZQuery.Create(nil);
    with qrExec do
    begin
      Close;
      Connection := zcoConnection;
      SQL.Clear;
      SQL.Add('	CREATE OR REPLACE FUNCTION script_00() RETURNS void AS				');
      SQL.Add('	$$				');
      SQL.Add('	BEGIN				');
      SQL.Add('		IF NOT EXISTS(');
      SQL.Add('				SELECT NULL');
      SQL.Add('				FROM   information_schema.tables');
      SQL.Add('				WHERE  table_name = ''tbscript''');
      SQL.Add('				)');
      SQL.Add('		THEN');
      SQL.Add('			CREATE TABLE tbscript(');
      SQL.Add('				   idscript Serial,');
      SQL.Add('				   nmscript VARCHAR(300) NOT NULL,');
      SQL.Add('				   dataexecucao timestamp NOT NULL,');
      SQL.Add('				   idusuario integer NOT NULL,');
      SQL.Add('				   conteudo text NOT NULL,');
      SQL.Add('				   PRIMARY KEY(idscript)');
      SQL.Add('			   );');
      SQL.Add('		END IF;');
      SQL.Add('		IF NOT EXISTS (select * from tbscript where nmscript = ''SCR00000001.ssg'')			');
      SQL.Add('		THEN			');
      SQL.Add('			INSERT INTO tbscript (nmscript, dataexecucao, idusuario, conteudo)		');
      SQL.Add('			VALUES (''SCR00000001.ssg'', Now(), 0, ''Incluso na tabela manualmente - Scripts criados antes da rotina'');		');
      SQL.Add('		END IF;			');
      SQL.Add('		IF NOT EXISTS (select null from tbscript where nmscript = ''SCR00000002.ssg'')			');
      SQL.Add('		THEN			');
      SQL.Add('			INSERT INTO tbscript (nmscript, dataexecucao, idusuario, conteudo)		');
      SQL.Add('			VALUES (''SCR00000002.ssg'', Now(), 0, ''Incluso na tabela manualmente - Scripts criados antes da rotina'');		');
      SQL.Add('		END IF;			');
      SQL.Add('		IF NOT EXISTS (select null from tbscript where nmscript = ''SCR00000003.ssg'')			');
      SQL.Add('		THEN			');
      SQL.Add('			INSERT INTO tbscript (nmscript, dataexecucao, idusuario, conteudo)		');
      SQL.Add('			VALUES (''SCR00000003.ssg'', Now(), 0, ''Incluso na tabela manualmente - Scripts criados antes da rotina'');		');
      SQL.Add('		END IF;			');
      SQL.Add('		IF NOT EXISTS (select null from tbscript where nmscript = ''SCR00000004.ssg'')			');
      SQL.Add('		THEN			');
      SQL.Add('			INSERT INTO tbscript (nmscript, dataexecucao, idusuario, conteudo)		');
      SQL.Add('			VALUES (''SCR00000004.ssg'', Now(), 0, ''Incluso na tabela manualmente - Scripts criados antes da rotina'');		');
      SQL.Add('		END IF;			');
      SQL.Add('		IF NOT EXISTS (select null from tbscript where nmscript = ''SCR00000005.ssg'')			');
      SQL.Add('		THEN			');
      SQL.Add('			INSERT INTO tbscript (nmscript, dataexecucao, idusuario, conteudo)		');
      SQL.Add('			VALUES (''SCR00000005.ssg'', Now(), 0, ''Incluso na tabela manualmente - Scripts criados antes da rotina'');		');
      SQL.Add('		END IF;			');
      SQL.Add('		IF NOT EXISTS (select null from tbscript where nmscript = ''SCR00000006.ssg'')			');
      SQL.Add('		THEN			');
      SQL.Add('			INSERT INTO tbscript (nmscript, dataexecucao, idusuario, conteudo)		');
      SQL.Add('			VALUES (''SCR00000006.ssg'', Now(), 0, ''Incluso na tabela manualmente - Scripts criados antes da rotina'');		');
      SQL.Add('		END IF;			');
      SQL.Add('		IF NOT EXISTS (select null from tbscript where nmscript = ''SCR00000007.ssg'')			');
      SQL.Add('		THEN			');
      SQL.Add('			INSERT INTO tbscript (nmscript, dataexecucao, idusuario, conteudo)		');
      SQL.Add('			VALUES (''SCR00000007.ssg'', Now(), 0, ''Incluso na tabela manualmente - Scripts criados antes da rotina'');		');
      SQL.Add('		END IF;			');
      SQL.Add('		IF NOT EXISTS (select null from tbscript where nmscript = ''SCR00000008.ssg'')			');
      SQL.Add('		THEN			');
      SQL.Add('			INSERT INTO tbscript (nmscript, dataexecucao, idusuario, conteudo)		');
      SQL.Add('			VALUES (''SCR00000008.ssg'', Now(), 0, ''Incluso na tabela manualmente - Scripts criados antes da rotina'');		');
      SQL.Add('		END IF;			');
      SQL.Add('		IF NOT EXISTS (select null from tbscript where nmscript = ''SCR00000009.ssg'')			');
      SQL.Add('		THEN			');
      SQL.Add('			INSERT INTO tbscript (nmscript, dataexecucao, idusuario, conteudo)		');
      SQL.Add('			VALUES (''SCR00000009.ssg'', Now(), 0, ''Incluso na tabela manualmente - Scripts criados antes da rotina'');		');
      SQL.Add('		END IF;			');
      SQL.Add('		IF NOT EXISTS (select null from tbscript where nmscript = ''SCR00000010.ssg'')			');
      SQL.Add('		THEN			');
      SQL.Add('			INSERT INTO tbscript (nmscript, dataexecucao, idusuario, conteudo)		');
      SQL.Add('			VALUES (''SCR00000010.ssg'', Now(), 0, ''Incluso na tabela manualmente - Scripts criados antes da rotina'');		');
      SQL.Add('		END IF;			');
      SQL.Add('		IF NOT EXISTS (select null from tbscript where nmscript = ''SCR00000011.ssg'')			');
      SQL.Add('		THEN			');
      SQL.Add('			INSERT INTO tbscript (nmscript, dataexecucao, idusuario, conteudo)		');
      SQL.Add('			VALUES (''SCR00000011.ssg'', Now(), 0, ''Incluso na tabela manualmente - Scripts criados antes da rotina'');		');
      SQL.Add('		END IF;			');
      SQL.Add('		IF NOT EXISTS (select null from tbscript where nmscript = ''SCR00000012.ssg'')			');
      SQL.Add('		THEN			');
      SQL.Add('			INSERT INTO tbscript (nmscript, dataexecucao, idusuario, conteudo)		');
      SQL.Add('			VALUES (''SCR00000012.ssg'', Now(), 0, ''Incluso na tabela manualmente - Scripts criados antes da rotina'');		');
      SQL.Add('		END IF;			');
      SQL.Add('		IF NOT EXISTS (select null from tbscript where nmscript = ''SCR00000013.ssg'')			');
      SQL.Add('		THEN			');
      SQL.Add('			INSERT INTO tbscript (nmscript, dataexecucao, idusuario, conteudo)		');
      SQL.Add('			VALUES (''SCR00000013.ssg'', Now(), 0, ''Incluso na tabela manualmente - Scripts criados antes da rotina'');		');
      SQL.Add('		END IF;			');
      SQL.Add('		IF NOT EXISTS (select null from tbscript where nmscript = ''SCR00000014.ssg'')			');
      SQL.Add('		THEN			');
      SQL.Add('			INSERT INTO tbscript (nmscript, dataexecucao, idusuario, conteudo)		');
      SQL.Add('			VALUES (''SCR00000014.ssg'', Now(), 0, ''Incluso na tabela manualmente - Scripts criados antes da rotina'');		');
      SQL.Add('		END IF;			');
      SQL.Add('		IF NOT EXISTS (select null from tbscript where nmscript = ''SCR00000015.ssg'')			');
      SQL.Add('		THEN			');
      SQL.Add('			INSERT INTO tbscript (nmscript, dataexecucao, idusuario, conteudo)		');
      SQL.Add('			VALUES (''SCR00000015.ssg'', Now(), 0, ''Incluso na tabela manualmente - Scripts criados antes da rotina'');		');
      SQL.Add('		END IF;			');
      SQL.Add('		IF NOT EXISTS (select null from tbscript where nmscript = ''SCR00000016.ssg'')			');
      SQL.Add('		THEN			');
      SQL.Add('			INSERT INTO tbscript (nmscript, dataexecucao, idusuario, conteudo)		');
      SQL.Add('			VALUES (''SCR00000016.ssg'', Now(), 0, ''Incluso na tabela manualmente - Scripts criados antes da rotina'');		');
      SQL.Add('		END IF;			');
      SQL.Add('		IF NOT EXISTS (select null from tbscript where nmscript = ''SCR00000017.ssg'')			');
      SQL.Add('		THEN			');
      SQL.Add('			INSERT INTO tbscript (nmscript, dataexecucao, idusuario, conteudo)		');
      SQL.Add('			VALUES (''SCR00000017.ssg'', Now(), 0, ''Incluso na tabela manualmente - Scripts criados antes da rotina'');		');
      SQL.Add('		END IF;			');
      SQL.Add('		IF NOT EXISTS (select null from tbscript where nmscript = ''SCR00000018.ssg'')			');
      SQL.Add('		THEN			');
      SQL.Add('			INSERT INTO tbscript (nmscript, dataexecucao, idusuario, conteudo)		');
      SQL.Add('			VALUES (''SCR00000018.ssg'', Now(), 0, ''Incluso na tabela manualmente - Scripts criados antes da rotina'');		');
      SQL.Add('		END IF;			');
      SQL.Add('		IF NOT EXISTS (select null from tbscript where nmscript = ''SCR00000019.ssg'')			');
      SQL.Add('		THEN			');
      SQL.Add('			INSERT INTO tbscript (nmscript, dataexecucao, idusuario, conteudo)		');
      SQL.Add('			VALUES (''SCR00000019.ssg'', Now(), 0, ''Incluso na tabela manualmente - Scripts criados antes da rotina'');		');
      SQL.Add('		END IF;			');
      SQL.Add('		IF NOT EXISTS (select null from tbscript where nmscript = ''SCR00000020.ssg'')			');
      SQL.Add('		THEN			');
      SQL.Add('			INSERT INTO tbscript (nmscript, dataexecucao, idusuario, conteudo)		');
      SQL.Add('			VALUES (''SCR00000020.ssg'', Now(), 0, ''Incluso na tabela manualmente - Scripts criados antes da rotina'');		');
      SQL.Add('		END IF;			');
      SQL.Add('		IF NOT EXISTS (select null from tbscript where nmscript = ''SCR00000021.ssg'')			');
      SQL.Add('		THEN			');
      SQL.Add('			INSERT INTO tbscript (nmscript, dataexecucao, idusuario, conteudo)		');
      SQL.Add('			VALUES (''SCR00000021.ssg'', Now(), 0, ''Incluso na tabela manualmente - Scripts criados antes da rotina'');		');
      SQL.Add('		END IF;			');
      SQL.Add('		IF NOT EXISTS (select null from tbscript where nmscript = ''SCR00000022.ssg'')			');
      SQL.Add('		THEN			');
      SQL.Add('			INSERT INTO tbscript (nmscript, dataexecucao, idusuario, conteudo)		');
      SQL.Add('			VALUES (''SCR00000022.ssg'', Now(), 0, ''Incluso na tabela manualmente - Scripts criados antes da rotina'');		');
      SQL.Add('		END IF;			');
      SQL.Add('		IF NOT EXISTS (select null from tbscript where nmscript = ''SCR00000023.ssg'')			');
      SQL.Add('		THEN			');
      SQL.Add('			INSERT INTO tbscript (nmscript, dataexecucao, idusuario, conteudo)		');
      SQL.Add('			VALUES (''SCR00000023.ssg'', Now(), 0, ''Incluso na tabela manualmente - Scripts criados antes da rotina'');		');
      SQL.Add('		END IF;			');
      SQL.Add('		IF NOT EXISTS (select null from tbscript where nmscript = ''SCR00000024.ssg'')			');
      SQL.Add('		THEN			');
      SQL.Add('			INSERT INTO tbscript (nmscript, dataexecucao, idusuario, conteudo)		');
      SQL.Add('			VALUES (''SCR00000024.ssg'', Now(), 0, ''Incluso na tabela manualmente - Scripts criados antes da rotina'');		');
      SQL.Add('		END IF;			');
      SQL.Add('		IF NOT EXISTS (select null from tbscript where nmscript = ''SCR00000025.ssg'')			');
      SQL.Add('		THEN			');
      SQL.Add('			INSERT INTO tbscript (nmscript, dataexecucao, idusuario, conteudo)		');
      SQL.Add('			VALUES (''SCR00000025.ssg'', Now(), 0, ''Incluso na tabela manualmente - Scripts criados antes da rotina'');		');
      SQL.Add('		END IF;			');
      SQL.Add('		IF NOT EXISTS (select null from tbscript where nmscript = ''SCR00000026.ssg'')			');
      SQL.Add('		THEN			');
      SQL.Add('			INSERT INTO tbscript (nmscript, dataexecucao, idusuario, conteudo)		');
      SQL.Add('			VALUES (''SCR00000026.ssg'', Now(), 0, ''Incluso na tabela manualmente - Scripts criados antes da rotina'');		');
      SQL.Add('		END IF;			');
      SQL.Add('		IF NOT EXISTS (select null from tbscript where nmscript = ''SCR00000027.ssg'')			');
      SQL.Add('		THEN			');
      SQL.Add('			INSERT INTO tbscript (nmscript, dataexecucao, idusuario, conteudo)		');
      SQL.Add('			VALUES (''SCR00000027.ssg'', Now(), 0, ''Incluso na tabela manualmente - Scripts criados antes da rotina'');		');
      SQL.Add('		END IF;			');
      SQL.Add('		IF NOT EXISTS (select null from tbscript where nmscript = ''SCR00000028.ssg'')			');
      SQL.Add('		THEN			');
      SQL.Add('			INSERT INTO tbscript (nmscript, dataexecucao, idusuario, conteudo)		');
      SQL.Add('			VALUES (''SCR00000028.ssg'', Now(), 0, ''Incluso na tabela manualmente - Scripts criados antes da rotina'');		');
      SQL.Add('		END IF;			');
      SQL.Add('		IF NOT EXISTS (select null from tbscript where nmscript = ''SCR00000029.ssg'')			');
      SQL.Add('		THEN			');
      SQL.Add('			INSERT INTO tbscript (nmscript, dataexecucao, idusuario, conteudo)		');
      SQL.Add('			VALUES (''SCR00000029.ssg'', Now(), 0, ''Incluso na tabela manualmente - Scripts criados antes da rotina'');		');
      SQL.Add('		END IF;			');
      SQL.Add('		IF NOT EXISTS (select null from tbscript where nmscript = ''SCR00000030.ssg'')			');
      SQL.Add('		THEN			');
      SQL.Add('			INSERT INTO tbscript (nmscript, dataexecucao, idusuario, conteudo)		');
      SQL.Add('			VALUES (''SCR00000030.ssg'', Now(), 0, ''Incluso na tabela manualmente - Scripts criados antes da rotina'');		');
      SQL.Add('		END IF;			');
      SQL.Add('		IF NOT EXISTS (select null from tbscript where nmscript = ''SCR00000031.ssg'')			');
      SQL.Add('		THEN			');
      SQL.Add('			INSERT INTO tbscript (nmscript, dataexecucao, idusuario, conteudo)		');
      SQL.Add('			VALUES (''SCR00000031.ssg'', Now(), 0, ''Incluso na tabela manualmente - Scripts criados antes da rotina'');		');
      SQL.Add('		END IF;			');
      SQL.Add('		IF NOT EXISTS (select null from tbscript where nmscript = ''SCR00000032.ssg'')			');
      SQL.Add('		THEN			');
      SQL.Add('			INSERT INTO tbscript (nmscript, dataexecucao, idusuario, conteudo)		');
      SQL.Add('			VALUES (''SCR00000032.ssg'', Now(), 0, ''Incluso na tabela manualmente - Scripts criados antes da rotina'');		');
      SQL.Add('		END IF;			');
      SQL.Add('		IF NOT EXISTS (select null from tbscript where nmscript = ''SCR00000033.ssg'')			');
      SQL.Add('		THEN			');
      SQL.Add('			INSERT INTO tbscript (nmscript, dataexecucao, idusuario, conteudo)		');
      SQL.Add('			VALUES (''SCR00000033.ssg'', Now(), 0, ''Incluso na tabela manualmente - Scripts criados antes da rotina'');		');
      SQL.Add('		END IF;			');
      SQL.Add('		IF NOT EXISTS (select null from tbscript where nmscript = ''SCR00000034.ssg'')			');
      SQL.Add('		THEN			');
      SQL.Add('			INSERT INTO tbscript (nmscript, dataexecucao, idusuario, conteudo)		');
      SQL.Add('			VALUES (''SCR00000034.ssg'', Now(), 0, ''Incluso na tabela manualmente - Scripts criados antes da rotina'');		');
      SQL.Add('		END IF;			');
      SQL.Add('		IF NOT EXISTS (select null from tbscript where nmscript = ''SCR00000035.ssg'')			');
      SQL.Add('		THEN			');
      SQL.Add('			INSERT INTO tbscript (nmscript, dataexecucao, idusuario, conteudo)		');
      SQL.Add('			VALUES (''SCR00000035.ssg'', Now(), 0, ''Incluso na tabela manualmente - Scripts criados antes da rotina'');		');
      SQL.Add('		END IF;			');
      SQL.Add('		IF NOT EXISTS (select null from tbscript where nmscript = ''SCR00000036.ssg'')			');
      SQL.Add('		THEN			');
      SQL.Add('			INSERT INTO tbscript (nmscript, dataexecucao, idusuario, conteudo)		');
      SQL.Add('			VALUES (''SCR00000036.ssg'', Now(), 0, ''Incluso na tabela manualmente - Scripts criados antes da rotina'');		');
      SQL.Add('		END IF;			');
      SQL.Add('		IF NOT EXISTS (select null from tbscript where nmscript = ''SCR00000037.ssg'')			');
      SQL.Add('		THEN			');
      SQL.Add('			INSERT INTO tbscript (nmscript, dataexecucao, idusuario, conteudo)		');
      SQL.Add('			VALUES (''SCR00000037.ssg'', Now(), 0, ''Incluso na tabela manualmente - Scripts criados antes da rotina'');		');
      SQL.Add('		END IF;			');
      SQL.Add('		IF NOT EXISTS (select null from tbscript where nmscript = ''SCR00000038.ssg'')			');
      SQL.Add('		THEN			');
      SQL.Add('			INSERT INTO tbscript (nmscript, dataexecucao, idusuario, conteudo)		');
      SQL.Add('			VALUES (''SCR00000038.ssg'', Now(), 0, ''Incluso na tabela manualmente - Scripts criados antes da rotina'');		');
      SQL.Add('		END IF;			');
      SQL.Add('		IF NOT EXISTS (select null from tbscript where nmscript = ''SCR00000039.ssg'')			');
      SQL.Add('		THEN			');
      SQL.Add('			INSERT INTO tbscript (nmscript, dataexecucao, idusuario, conteudo)		');
      SQL.Add('			VALUES (''SCR00000039.ssg'', Now(), 0, ''Incluso na tabela manualmente - Scripts criados antes da rotina'');		');
      SQL.Add('		END IF;			');
      SQL.Add('		IF NOT EXISTS (select null from tbscript where nmscript = ''SCR00000040.ssg'')			');
      SQL.Add('		THEN			');
      SQL.Add('			INSERT INTO tbscript (nmscript, dataexecucao, idusuario, conteudo)		');
      SQL.Add('			VALUES (''SCR00000040.ssg'', Now(), 0, ''Incluso na tabela manualmente - Scripts criados antes da rotina'');		');
      SQL.Add('		END IF;			');
      SQL.Add('		IF NOT EXISTS (select null from tbscript where nmscript = ''SCR00000041.ssg'')			');
      SQL.Add('		THEN			');
      SQL.Add('			INSERT INTO tbscript (nmscript, dataexecucao, idusuario, conteudo)		');
      SQL.Add('			VALUES (''SCR00000041.ssg'', Now(), 0, ''Incluso na tabela manualmente - Scripts criados antes da rotina'');		');
      SQL.Add('		END IF;			');
      SQL.Add('		IF NOT EXISTS (select null from tbscript where nmscript = ''SCR00000042.ssg'')			');
      SQL.Add('		THEN			');
      SQL.Add('			INSERT INTO tbscript (nmscript, dataexecucao, idusuario, conteudo)		');
      SQL.Add('			VALUES (''SCR00000042.ssg'', Now(), 0, ''Incluso na tabela manualmente - Scripts criados antes da rotina'');		');
      SQL.Add('		END IF;			');
      SQL.Add('		IF NOT EXISTS (select null from tbscript where nmscript = ''SCR00000043.ssg'')			');
      SQL.Add('		THEN			');
      SQL.Add('			INSERT INTO tbscript (nmscript, dataexecucao, idusuario, conteudo)		');
      SQL.Add('			VALUES (''SCR00000043.ssg'', Now(), 0, ''Incluso na tabela manualmente - Scripts criados antes da rotina'');		');
      SQL.Add('		END IF;			');
      SQL.Add('		IF NOT EXISTS (select null from tbscript where nmscript = ''SCR00000044.ssg'')			');
      SQL.Add('		THEN			');
      SQL.Add('			INSERT INTO tbscript (nmscript, dataexecucao, idusuario, conteudo)		');
      SQL.Add('			VALUES (''SCR00000044.ssg'', Now(), 0, ''Incluso na tabela manualmente - Scripts criados antes da rotina'');		');
      SQL.Add('		END IF;			');
      SQL.Add('		IF NOT EXISTS (select null from tbscript where nmscript = ''SCR00000045.ssg'')			');
      SQL.Add('		THEN			');
      SQL.Add('			INSERT INTO tbscript (nmscript, dataexecucao, idusuario, conteudo)		');
      SQL.Add('			VALUES (''SCR00000045.ssg'', Now(), 0, ''Incluso na tabela manualmente - Scripts criados antes da rotina'');		');
      SQL.Add('		END IF;			');
      SQL.Add('		IF NOT EXISTS (select null from tbscript where nmscript = ''SCR00000046.ssg'')			');
      SQL.Add('		THEN			');
      SQL.Add('			INSERT INTO tbscript (nmscript, dataexecucao, idusuario, conteudo)		');
      SQL.Add('			VALUES (''SCR00000046.ssg'', Now(), 0, ''Incluso na tabela manualmente - Scripts criados antes da rotina'');		');
      SQL.Add('		END IF;			');
      SQL.Add('		IF NOT EXISTS (select null from tbscript where nmscript = ''SCR00000047.ssg'')			');
      SQL.Add('		THEN			');
      SQL.Add('			INSERT INTO tbscript (nmscript, dataexecucao, idusuario, conteudo)		');
      SQL.Add('			VALUES (''SCR00000047.ssg'', Now(), 0, ''Incluso na tabela manualmente - Scripts criados antes da rotina'');		');
      SQL.Add('		END IF;			');
      SQL.Add('		IF NOT EXISTS (select null from tbscript where nmscript = ''SCR00000048.ssg'')			');
      SQL.Add('		THEN			');
      SQL.Add('			INSERT INTO tbscript (nmscript, dataexecucao, idusuario, conteudo)		');
      SQL.Add('			VALUES (''SCR00000048.ssg'', Now(), 0, ''Incluso na tabela manualmente - Scripts criados antes da rotina'');		');
      SQL.Add('		END IF;			');
      SQL.Add('		IF NOT EXISTS (select null from tbscript where nmscript = ''SCR00000049.ssg'')			');
      SQL.Add('		THEN			');
      SQL.Add('			INSERT INTO tbscript (nmscript, dataexecucao, idusuario, conteudo)		');
      SQL.Add('			VALUES (''SCR00000049.ssg'', Now(), 0, ''Incluso na tabela manualmente - Scripts criados antes da rotina'');		');
      SQL.Add('		END IF;			');
      SQL.Add('		IF NOT EXISTS (select null from tbscript where nmscript = ''SCR00000050.ssg'')			');
      SQL.Add('		THEN			');
      SQL.Add('			INSERT INTO tbscript (nmscript, dataexecucao, idusuario, conteudo)		');
      SQL.Add('			VALUES (''SCR00000050.ssg'', Now(), 0, ''Incluso na tabela manualmente - Scripts criados antes da rotina'');		');
      SQL.Add('		END IF;			');
      SQL.Add('		IF NOT EXISTS (select null from tbscript where nmscript = ''SCR00000051.ssg'')			');
      SQL.Add('		THEN			');
      SQL.Add('			INSERT INTO tbscript (nmscript, dataexecucao, idusuario, conteudo)		');
      SQL.Add('			VALUES (''SCR00000051.ssg'', Now(), 0, ''Incluso na tabela manualmente - Scripts criados antes da rotina'');		');
      SQL.Add('		END IF;			');
      SQL.Add('	END;				');
      SQL.Add('	$$ LANGUAGE plpgsql;				');
      SQL.Add('	SELECT script_00();				');
      SQL.Add('	DROP FUNCTION script_00();				');
      ExecSQL;
    end;
  Finally
    FreeAndNil(qrExec);
  End;
end;

function TScript.ConsultaScriptExecutado(pNmScript: String): Boolean;
Var
  QrConsulta: TZQuery;
begin
  Try
    Result := False;
    QrConsulta := TZQuery.Create(nil);
    with QrConsulta do
    begin
      Close;
      Connection := zcoConnection;
      SQL.Clear;
      SQL.Add('select * from tbscript');
      SQL.Add('where nmscript = :nmscript');
      ParamByName('nmscript').AsString := pNmScript;
      Open;
      if not IsEmpty then
        Result := True;
    end;
  Finally
    FreeAndNil(QrConsulta);
  End;
end;

constructor TScript.Create(pzcoConnection: TZConnection);
begin
  inherited Create;
  zcoConnection := pzcoConnection;
end;

destructor TScript.Destroy;
begin
  inherited;
end;

function TScript.ExecutaScript(pFormChamada: TForm; pCaminhoArquivo, nmscript: String): Boolean;
Var
  memo: TMemo;
  qrExecuta: TZQuery;
  i: integer;
begin
  memo := TMemo.Create(Nil);
  Try
    Result := False;

    // Carrega e Guarda o Texto do Script
    with memo do
    begin
      Parent := pFormChamada;
      Visible := False;
      Lines.LoadFromFile(pCaminhoArquivo);
    end;

    Try
      qrExecuta := TZQuery.Create(nil);
      with qrExecuta do
      begin
        Close;
        Connection := zcoConnection;
        SQL.Clear;
        SQL.Add(memo.Text);
        ParamCheck := False;

        // Força exclusão dos parâmetros.
        for i := 0 to ParamCount - 1 do
          Params.Items[i].Free;

        ExecSQL;
        Result := True;

        // Alimenta atributos e grava script como executado.
        Setnmscript(nmscript);

        memo.Text := StringReplace(memo.Text, '''', '"', [rfReplaceAll]);

        Setconteudo(memo.Text);
        GravaScript;
      end;
    except
      on E: Exception do
      begin
        pMsgAtencao('Problemas na Atualização: Não foi executar o script "' + nmscript + '".' + #13 +
          'Verifique os detalhes do erro e contate o suporte para transmitir o problema.', 'Mensagem original: ' + #13 + E.Message + #13 + #13 +
          '||Comando Executado:||' + #13 + memo.Text);
        Result := False;
      end;
    end;
  Finally
    FreeAndNil(memo);
  End;
end;

function TScript.Getconteudo: Variant;
begin
  Result := conteudo;
end;

function TScript.Getdataexecucao: Variant;
begin
  Result := dataexecucao;
end;

function TScript.Getidscript: Variant;
begin
  Result := idscript;
end;

function TScript.Getidusuario: Variant;
begin
  Result := idusuario;
end;

function TScript.Getnmscript: Variant;
begin
  Result := nmscript;
end;

procedure TScript.GravaScript;
var
  qrScript: TZQuery;
begin
  Try
    try
      qrScript := TZQuery.Create(nil);
      with qrScript do
      begin
        Connection := zcoConnection;
        SQL.Clear;
        SQL.Add('INSERT INTO tbscript(nmscript, dataexecucao, idusuario, conteudo)');
        SQL.Add('VALUES(:nmscript, now(), :idusuario, :conteudo)');

        ParamByName('nmscript').AsString := nmscript;
        ParamByName('idusuario').AsInteger := idusuario;
        ParamByName('conteudo').AsString := conteudo;
        ExecSQL;
      end;
    except
      on E: Exception do
      begin
        pMsgAtencao('Problemas na Atualização: Não foi gravar o script "' + nmscript + '" como executado.' + #13 +
          'Verifique os detalhes do erro e contate o suporte para transmitir o problema.', 'Mensagem original: ' + #13 + E.Message);
        Abort;
      end;
    end;
  Finally
    FreeAndNil(qrScript);
  End;
end;

procedure TScript.ListaScriptExecutado(pQuery: TZQuery);
begin
  with pQuery do
  begin
    Close;
    Connection := zcoConnection;
    SQL.Clear;
    SQL.Add('select * from tbscript');
    SQL.Add('order by dataexecucao');
    Open;
  end;
end;

procedure TScript.ListaScriptPendente(pFormChamada: TForm; pcdsLista: TClientDataSet; pPastaArquivos: String);
var
  FileListBox: TFileListBox;
  i: integer;
begin
  Try
    Try
      if not DirectoryExists(pPastaArquivos) then
        ForceDirectories(pPastaArquivos);

      FileListBox := TFileListBox.Create(nil);
      with FileListBox do
      begin
        FileListBox.Parent := pFormChamada;
        FileListBox.Visible := False;
        FileListBox.Directory := pPastaArquivos;
        FileListBox.Mask := 'SCR????????.ssg';
      end;

      with pcdsLista do
      begin
        Close;
        // Se o field não existe no client, cria.
        if FindField('nmscript') = Nil then
          FieldDefs.Add('nmscript', ftString, 15, False);
        CreateDataSet;
        EmptyDataSet;
        Open;
        // Se encontrou arquivos, alimenta client.
        if FileListBox.Count > 0 then
        begin
          for i := 0 to FileListBox.Count - 1 do
          begin
            // Se o script já foi executado (tbscript), não adiciona a lista.
            if not ConsultaScriptExecutado(FileListBox.Items[i]) then
            begin
              Append;
              FieldByName('nmscript').AsString := FileListBox.Items[i];
              Post;
            end;
          end;
        end;
      end;
    except
      on E: Exception do
      begin
        pMsgAtencao('Não foi possível carregar os arquivos de script.' + #13 +
          'Verifique os detalhes do erro e contate o suporte para transmitir o problema.', 'Mensagem original: ' + #13 + E.Message);
        pFormChamada.Close;
        Abort;
      end;
    end;
  Finally
    FreeAndNil(FileListBox);
    pcdsLista.Close;
    pcdsLista.Open;
  End;
end;

function TScript.RetornaUltScriptExecutado: String;
Var
  QrConsulta: TZQuery;
begin
  Try
    Result := '';
    QrConsulta := TZQuery.Create(nil);
    with QrConsulta do
    begin
      Close;
      Connection := zcoConnection;
      SQL.Clear;
      SQL.Add('select nmscript from tbscript');
      SQL.Add('order by idscript desc limit 1');
      Open;
      Result := FieldByName('nmscript').AsString;
    end;
  Finally
    FreeAndNil(QrConsulta);
  End;
end;

procedure TScript.Setconteudo(pParametro: Variant);
begin
  conteudo := pParametro;
end;

procedure TScript.Setdataexecucao(pParametro: Variant);
begin
  dataexecucao := pParametro;
end;

procedure TScript.Setidscript(pParametro: Variant);
begin
  idscript := pParametro;
end;

procedure TScript.Setidusuario(pParametro: Variant);
begin
  idusuario := pParametro;
end;

procedure TScript.Setnmscript(pParametro: Variant);
begin
  nmscript := pParametro;
end;

end.
