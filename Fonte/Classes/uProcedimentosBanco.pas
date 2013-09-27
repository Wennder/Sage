unit uProcedimentosBanco;

interface

uses ZConnection, DB, ZAbstractRODataset, ZAbstractDataset, ZDataset, SysUtils, IniFiles, Dialogs, Forms;

const
  // Nome do arquivo com parâmetros de conexão com banco
  c_ArquivoConexao = 'conexao.ini';
  // Password de conexão com o banco
  c_PassPostgres = 'sage@2006';

procedure CarregaConexaoBanco(var pzcoConexao: TZConnection);
procedure CriaArquivoConexaoBanco;

function sCamposObrigatorios(sTabela: String; pzcoConnection: TZConnection): String;
function fDataHoraSrv(pzcoConnection: TZConnection): TDatetime;

implementation

procedure CarregaConexaoBanco(var pzcoConexao: TZConnection);
var
  iniArquivoConexao: TIniFile;

  sDataBase: String;
  sHostName: String;
  iPort: integer;
  // Protocol postgresql-7.4 está confirmado que funciona com a versão do banco
  sProtocol: String;
  sUser: String;
begin

  if FileExists(c_ArquivoConexao) then
  begin
    iniArquivoConexao := TIniFile.Create(ExtractFilePath(ParamStr(0)) + '\' + c_ArquivoConexao);
    with iniArquivoConexao do
    begin
      sDataBase := ReadString('CONEXAO', 'DataBase', 'AI');
      sHostName := ReadString('CONEXAO', 'HostName', 'naoinformado');
      iPort := ReadInteger('CONEXAO', 'Port', 5432);
      sProtocol := ReadString('CONEXAO', 'Protocol', 'postgresql-7.4');
      sUser := ReadString('CONEXAO', 'User', 'postgres');

      if Assigned(pzcoConexao) then
        FreeAndnil(pzcoConexao);

      pzcoConexao := TZConnection.Create(nil);
      with pzcoConexao do
      begin
        Database := sDataBase;
        HostName := sHostName;
        Port := iPort;
        Protocol := sProtocol;
        User := sUser;
        Password := c_PassPostgres;
      end;
    end;
  end
  else
  begin
    CriaArquivoConexaoBanco;
    ShowMessage('O arquivo de parâmetros de conexão com o banco não foi encontrado.' + #13 +
      'Para que seja possível prosseguir, o sistema criará um arquivo padrão' + #13 +
      'no diretório da aplicação. Após a aplicação ser finalizada, reconfigure' + #13 + 'o arquivo conexao.ini de acordo com o ambiente local.');
    Application.Terminate;
  end;
end;

procedure CriaArquivoConexaoBanco;
var
  tfArquivoConexao: TextFile;
begin
  AssignFile(tfArquivoConexao, ExtractFilePath(ParamStr(0)) + '\' + c_ArquivoConexao);
  Rewrite(tfArquivoConexao);
  Writeln(tfArquivoConexao, '[CONEXAO]');
  Writeln(tfArquivoConexao, 'DataBase=AI');
  Writeln(tfArquivoConexao, 'HostName=naoinformado');
  Writeln(tfArquivoConexao, 'Port=5432');
  Writeln(tfArquivoConexao, 'Protocol=postgresql-7.4');
  Writeln(tfArquivoConexao, 'User=postgres');
  CloseFile(tfArquivoConexao);
end;

function sCamposObrigatorios(sTabela: String; pzcoConnection: TZConnection): String;
var
  zqryConsulta: TZQuery;
  iCont: SmallInt;
  sCamposRequeridos: String;
begin
  Result := '';
  sCamposRequeridos := '';
  if (Trim(sTabela) <> '') and (Assigned(pzcoConnection)) then
  begin
    zqryConsulta := TZQuery.Create(nil);
    zqryConsulta.Connection := pzcoConnection;
    with zqryConsulta do
    begin
      SQL.Add('SELECT * FROM ' + sTabela + ' WHERE 1 = 2');
      try
        Open;
        for iCont := 0 to Fields.Count - 1 do
        begin
          if (AnsiLowerCase(Fields[iCont].FieldName) <> 'sstatus') and (Fields[iCont].Required) then
          begin
            if (sCamposRequeridos <> '') then
              sCamposRequeridos := sCamposRequeridos + ',';
            sCamposRequeridos := sCamposRequeridos + Fields[iCont].FieldName;
          end;
        end;
        Result := sCamposRequeridos;
        Close;
      except
        ShowMessage('Função bCampoObrigatorio: Nome da Tabela, Nome do Campo ou Conexão com o Banco estão vazios!');
      end;
    end;
    FreeAndnil(zqryConsulta);
  end
  else
  begin
    ShowMessage('Função bCampoObrigatorio: Nome da Tabela, Nome do Campo ou Conexão com o Banco estão vazios!');
  end;
end;

function fDataHoraSrv(pzcoConnection: TZConnection): TDatetime;
Var
  zqryConsulta: TZQuery;
begin
  zqryConsulta := TZQuery.Create(nil);
  zqryConsulta.Connection := pzcoConnection;
  with zqryConsulta do
  begin
    SQL.Add('Select Now() as "DataHora"');
    Open;

    Result := FieldByName('DataHora').AsDateTime;
    Close;
  end;
  FreeAndnil(zqryConsulta);
end;

end.
