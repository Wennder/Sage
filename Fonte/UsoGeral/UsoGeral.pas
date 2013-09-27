unit UsoGeral;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, DB, ADODB, jpeg, ExtCtrls, Mask, DBTables,
  DBCtrls, MaskUtils, Psapi, tlhelp32, DateUtils,
  WinInet, cxEdit, cxTimeEdit, cxTextEdit, cxStyles, cxCustomData, cxGraphics,
  cxFilter, cxData, cxDataStorage, cxDBData, cxGridLevel, cxClasses,
  cxGridCustomView, cxCalendar, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxGrid, cxCurrencyEdit, IniFiles, DBClient, FileCtrl,
  cxPC, cxContainer, cxGroupBox, cxRadioGroup, cxDBEdit, cxMaskEdit, cxDropDownEdit, cxLookupEdit, cxButtons,
  cxDBLookupEdit, cxDBLookupComboBox, cxLabel, cxCheckBox, ShellApi, Registry, verslab, ComCtrls;

procedure pCarregaIni(pNomeArquivo: string);
procedure pSalvaConfigIni(pNomeArquivo: string);
procedure pMsgAtencao(nMensagem: string; nTextoDetalhe: string = '');
procedure pMsgErro(nMensagem: string; nTextoDetalhe: string = '');
procedure pMsgInfo(nMensagem: string; nTextoDetalhe: string = '');
procedure pSetConfigBD(pConexao: TAdoConnection; pSetAnsiWarnings: Boolean = False; pSetAnsiNulls: Boolean = False; pSetDateFormat: Boolean = False);
procedure pKeyPressNumerico(var Tecla: Char);
procedure pKeyPressNumericoDecimal(var Tecla: Char);
procedure pKeyPressAlfabetico(var Tecla: Char);
procedure pStartTransaction(pConexao: TAdoConnection);
procedure pRollbackTransaction(pConexao: TAdoConnection);
procedure pCommitTransaction(pConexao: TAdoConnection);
procedure pEmiteSinalSonoro(pTipo: Integer);
procedure pCarregaForm(FrmClass: TComponentClass; var Frm; pTag: Integer = 0; pWindowState: TWindowState = WsNormal);
procedure pExecutePrograma(pNome, pParametros: string);
procedure pHabilitaDesabilita(pHabDes: Boolean; pGrupo: TObject);
procedure pExpandGrupoCxGrid(AView: TcxGridTableView; ALevel: Integer);
procedure pFocoPrimeiroObj(cParent: TWinControl);
procedure pFechaComponentes(pForm: TForm);
procedure pMudaImgBotao(pForm: TForm; pSender: TObject; pImgAtivo, pImgDesativo: TcxImageList);
procedure pSetFocus(pObjeto: TObject; pField: string);

function fConectaBD(AdoConexao: TAdoConnection; pServidor, pBancodeDados, pUsuario, pSenha: string): Boolean;
function fPergunta(nMensagem: string; nSimDefault: Boolean = True; nTextoDetalhe: string = ''): Boolean;
function fDescriptografar(const pTexto: Ansistring; pFator: Integer): Ansistring;
function fCriptografar(const pTexto: Ansistring; pFator: Integer): Ansistring;
function fExisteForm(pNomeForm: string): Boolean;
function iif(nCondicao: Boolean; nTrue, nFalse: Variant): Variant;
function fGetMachineName: string;
function fVerificaTransacao(pConexao: TAdoConnection): Integer;
function fStrZero(Num: Real; Zeros, Deci: Integer): string;
function fBuscaUltimoCodigo(pConexao: TAdoConnection; pTabela, pCampo: string; pPsqIntervalo: Boolean = False; pWhere: string = ''): Variant;
function fRetiraMascara(nTexto: string): string;
function fExecSqlTabela(pConexao: TAdoConnection; pSql: string; pControlaTran: Boolean = True; pExecuteSql: Boolean = False): TAdoQuery;
function fDataSrvSQL(pConexao: TAdoConnection): TDatetime;
function fGravarRegistroWin(pPropriedade, pValorPropriedade: string): Boolean;
function fLeRegistroWin(pPropriedade, pValorPropriedade: string): Variant;
function fexisteInt(Texto: string): Boolean;
function IsInteger(const S: string): Boolean;
function fLimpaObjs(cParent: TWinControl): Boolean;
function fValorAsc(Letra: string): Byte;
function fDescriptografarBaixo(pTexto: string): string;
function fCriptografarBaixo(pTexto: string): string;
function fGetVersaoAplicacao(pCaminhoApp: string; pForm: TForm; pExiste: Boolean = True): string;
procedure pValidaCamposObrigatorios(pCds: TClientDataSet; pPnlObjetos: TObject);
procedure pAlimentaStoredProc(pCds: TClientDataSet; pSP: TADOStoredProc; pDML: string = '');
function fExecuteProcedure(pClientDataSet: TClientDataSet; pStored: TADOStoredProc): Boolean;
function fRetiraInteiro(nTexto: string): string;
function fRealizaBackupPostGreSQL(pCaminhoInstalacao, pCaminhoAplicacao, pCaminhoDestino, pServer: String; pPorta: Integer): Boolean;
function fGetSelectDirectory(Title: string): string;
function fWinExecAndWait32(Filename: String; WorkDir: String; Visibility: Integer): Integer;
function fBuscaStringMemo(pMemo: TMemo; pTexto: String): Boolean;
function fAlinhaEsquerda(preenche: Char; str: String; tamanho: Integer): String;
function fAlinhaDireita(preenche: Char; str: String; tamanho: Integer): String;
function fModulo11(str: string): String;
function fRetiraCaracteresEspeciais(valor: string): string;

const
  cPastaRaizRegistro: string = 'Liberty';

var
  nArqIni: TIniFile;

  { Variaveis Globais do Sistema. }
  _vNMServidor, _vNMBD, _vNMUsuarioBD, _vSenhaBD, _vPorta, _vTipoBD: string; { Armazena informações da conexao com o banco de dados. }

  _vIDUsuario: Integer; { Armazena código do usuário logado }
  _vNMUsuario: string; { Armazena nome do usuário logado }

  _vIDOrganizacao: Integer; { Armazena código da Organização logada }
  _vNMOrganizacao: string; { Armazena nome da Organização logada }

  _vUsuMsgAlertaSis: Boolean; { Armazena Configuração do Usuário se Recebe Msg de Alerta de Sistema }

implementation

uses uMensagem;

procedure pCarregaIni(pNomeArquivo: string);
var
  i: Integer;
begin
  try
    try
      if not FileExists(ExtractFilePath(Application.Exename) + pNomeArquivo) then
      begin
        pMsgAtencao('Arquivo de configurações(.ini) não encontrado! A Aplicação será Finalizada.');
        Application.Terminate;
      end;

      nArqIni := TIniFile.Create(ExtractFilePath(Application.Exename) + pNomeArquivo);

      _vNMServidor := nArqIni.ReadString('Configuracoes', 'Servidor', '');
      _vNMBD := nArqIni.ReadString('Configuracoes', 'BancoDeDados', '');
      _vNMUsuarioBD := nArqIni.ReadString('Configuracoes', 'Usuario', '');
      _vSenhaBD := nArqIni.ReadString('Configuracoes', 'Senha', '');
      _vPorta := nArqIni.ReadString('Configuracoes', 'Porta', '');
      _vTipoBD := nArqIni.ReadString('Configuracoes', 'TipoBD', '');

    except
      on E: Exception do
      begin
        pMsgErro('Ocorreu um erro interno ao carregar o arquivo ".ini".' + #13 + 'Entre em contato com o suporte e transmita a mensagem a seguir: ' +
          #13 + E.Message);
        Abort;
      end;
    end;
  finally
    FreeAndNil(nArqIni);
  end;
end;

function fConectaBD(AdoConexao: TAdoConnection; pServidor, pBancodeDados, pUsuario, pSenha: string): Boolean;
begin
  Result := False;

  if Trim(pServidor) = '' then
  begin
    pMsgAtencao('Por favor, configure o Nome do Servidor!');
    Application.Terminate;
  end;
  if Trim(pBancodeDados) = '' then
  begin
    pMsgAtencao('Por favor, configure o Nome do Banco de Dados!');
    Application.Terminate;
  end;
  if Trim(pUsuario) = '' then
  begin
    pMsgAtencao('Por favor, configure o Usuário de acesso ao Banco de Dados!');
    Application.Terminate;
  end;
  if Trim(pSenha) = '' then
  begin
    pMsgAtencao('Por favor, configure a Senha de acesso ao do Banco de Dados!');
    Application.Terminate;
  end;

  { Fecha DataBase por Segurança caso esteja conectado. }
  if AdoConexao.Connected then
    AdoConexao.Close;

  { Conexao com o Banco de Dados SQL Server. }
  AdoConexao.ConnectionString := 'Provider=SQLOLEDB.1;' + 'Password=' + fDescriptografar(pSenha, 1807) + ';' + 'Persist Security Info=True;' +
    'User ID=' + pUsuario + ';' + 'Initial Catalog=' + pBancodeDados + ';' + 'Data Source=' + pServidor + ';' + 'Use Procedure for Prepare=1;' +
    'Auto Translate=True;' + 'Packet Size=4096;' + 'Use Encryption for Data=False;' + 'Tag with column collation when possible=False';

  try
    AdoConexao.Open;
    Result := True;
  except
    on E: Exception do
    begin
      if not AdoConexao.Connected then
      begin
        pMsgAtencao('Não foi possível conectar ao Banco de Dados: ' + pBancodeDados + #13 + 'Verifique o arquivo de Configurações!');
        Application.Terminate;
      end;
    end;
  end;
end;

procedure pMsgAtencao(nMensagem: string; nTextoDetalhe: string = '');
begin
  if not fExisteForm('TfMensagem') then
  begin
    try
      Application.CreateForm(TfMensagem, fMensagem);
      with fMensagem do
      begin
        Position := poScreenCenter;
        fFrmTituloForm1.lbTitulo.Caption := 'Atenção';

        vIndexImagem := 0;

        lbMensagem.Caption := nMensagem;
        mmTextoDetalhes.Lines.Add(nTextoDetalhe);
        lbMensagem.Style.Font.Color := clBlack;

        pnlBtnSimNao.Enabled := False;
        pnlBtnSimNao.Visible := False;

        pnlBtnOk.Visible := True;
        pnlBtnOk.Enabled := True;

        pnlBtnOk.BringToFront;

        ShowModal;
      end;
    finally
      FreeAndNil(fMensagem);
    end;
  end;
end;

procedure pMsgErro(nMensagem: string; nTextoDetalhe: string = '');
begin
  if not fExisteForm('TfMensagem') then
  begin
    try
      Application.CreateForm(TfMensagem, fMensagem);
      with fMensagem do
      begin
        Position := poScreenCenter;
        fFrmTituloForm1.lbTitulo.Caption := 'Erro';

        vIndexImagem := 1;

        lbMensagem.Caption := nMensagem;
        mmTextoDetalhes.Lines.Add(nTextoDetalhe);
        lbMensagem.Style.Font.Color := clRed;

        pnlBtnSimNao.Enabled := False;
        pnlBtnSimNao.Visible := False;

        pnlBtnOk.Visible := True;
        pnlBtnOk.Enabled := True;

        pnlBtnOk.BringToFront;

        ShowModal;
      end;
    finally
      FreeAndNil(fMensagem);
    end;
  end;
end;

procedure pMsgInfo(nMensagem: string; nTextoDetalhe: string = '');
begin
  if not fExisteForm('TfMensagem') then
  begin
    try
      Application.CreateForm(TfMensagem, fMensagem);
      with fMensagem do
      begin
        Position := poScreenCenter;
        fFrmTituloForm1.lbTitulo.Caption := 'Informação';

        vIndexImagem := 2;

        lbMensagem.Caption := nMensagem;
        mmTextoDetalhes.Lines.Add(nTextoDetalhe);
        lbMensagem.Style.Font.Color := clBlack;

        pnlBtnSimNao.Enabled := False;
        pnlBtnSimNao.Visible := False;

        pnlBtnOk.Visible := True;
        pnlBtnOk.Enabled := True;

        pnlBtnOk.BringToFront;

        ShowModal;
      end;
    finally
      FreeAndNil(fMensagem);
    end;
  end;
end;

{ ...Codifica Strings... }
function fCriptografar(const pTexto: Ansistring; pFator: Integer): Ansistring;
var
  ResultStr: Ansistring;
  Temp, nMsg: AnsiChar;
  i, EncryptIndex: Integer;
begin
  try
    ResultStr := '';
    Temp := ' ';
    for i := 1 to length(pTexto) do
    begin
      nMsg := pTexto[i];
      for EncryptIndex := 1 to pFator do
        nMsg := Succ(nMsg);
      ResultStr := ResultStr + nMsg;
    end;
    fCriptografar := ResultStr;
  except
    on E: Exception do
    begin
      pMsgErro('Ocorreu um erro interno ao tentar aplicar a criptografia.' + #13 + 'Entre em contato com o suporte e transmita a mensagem a seguir: '
        + #13 + E.Message);
      Abort;
    end;
  end;
end;

{ ...Decodifica Strings... }
function fDescriptografar(const pTexto: Ansistring; pFator: Integer): Ansistring;
var
  ResultStr: Ansistring;
  Temp, nMsg: AnsiChar;
  i, DecryptIndex: Integer;
begin
  try
    ResultStr := '';
    Temp := ' ';
    for i := 1 to length(pTexto) do
    begin
      nMsg := pTexto[i];
      for DecryptIndex := 1 to pFator do
        nMsg := Pred(nMsg);
      ResultStr := ResultStr + nMsg;
    end;
    fDescriptografar := ResultStr;
  except
    on E: Exception do
    begin
      pMsgErro('Ocorreu um erro interno ao tentar reverter a criptografia.' + #13 + 'Entre em contato com o suporte e transmita a mensagem a seguir: '
        + #13 + E.Message);
      Abort;
    end;
  end;
end;

{
  Autor......: Jeimyson de O. Souza
  Data.......: 08/09/2010
  Objetivo...: "Setar" as configurações da conexão com o banco de dados ao abrir o Database.
  Parâmetros.:
  - pQuery = Objeto de TQuery que sera utilizado.
  - pSetAnsiWarnings = Indica se será configurado o comportamento padrão ISO para várias condições de erro.
  - pSetAnsiNulls = Indica se será configurado o comportamento dosoperadores de comparação com valores nulos.
  - pSetDateFormat = Indica se será configurado a order das partes de dia, mês e ano.
}
procedure pSetConfigBD(pConexao: TAdoConnection; pSetAnsiWarnings: Boolean = False; pSetAnsiNulls: Boolean = False; pSetDateFormat: Boolean = False);
var
  pQuery: TAdoQuery;
begin
  pQuery := TAdoQuery.Create(nil);
  with pQuery do
  begin
    Close;
    Sql.Clear;

    { Especifica o comportamento padrão ISO para várias condições de erro. }
    if pSetAnsiWarnings then
      Sql.Add('SET ANSI_WARNINGS ON');

    { Especifica o comportamento compatível ISO dos operadores de comparação Igual a (=) e Diferente de (<>)
      quando usados com valores nulos. }
    if pSetAnsiNulls then
      Sql.Add('SET ANSI_NULLS ON');

    { Define a ordem das partes do mês, dia e ano para interpretar date, smalldatetime, datetime,
      datetime2 e cadeias de caracteres datetimeoffset. }
    if pSetDateFormat then
      Sql.Add('SET DATEFORMAT DMY');

    { Controla o comportamento de bloqueio e controle de versão de linha
      das instruções Transact-SQL emitidas por uma conexão com SQL Server.
      Esta opção será sempre ativada para permitir a leitura quando estiver com transações pendentes. }
    Sql.Add('SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED');
    ExecSQL;
  end;
end;

procedure pKeyPressNumerico(var Tecla: Char);
begin
  if (Tecla <> #13) and (Tecla <> #$16) and (Tecla <> #3) then
  begin
    if Tecla <> #8 then
    begin
      if not(Tecla in ['0' .. '9']) then
      begin
        Tecla := #0;
      end;
    end;
  end;
end;

procedure pKeyPressNumericoDecimal(var Tecla: Char);
begin
  if (Tecla <> #13) and (Tecla <> #$16) and (Tecla <> #3) then
  begin
    if Tecla <> #8 then
    begin
      if (not(Tecla in ['0' .. '9'])) and (Tecla <> ',') then
      begin
        Tecla := #0;
      end;
    end;
  end;
end;

procedure pKeyPressAlfabetico(var Tecla: Char);
begin
  if (Tecla <> #13) and (Tecla <> #$16) and (Tecla <> #3) and (Tecla <> ' ') then
  begin
    Tecla := UpCase(Tecla);
    if Tecla <> #8 then
    begin
      if (Tecla in ['0' .. '9']) then
      begin
        Tecla := #0;
      end;
    end;
  end;
end;

function fExisteForm(pNomeForm: string): Boolean;
var
  i: Integer;
begin
  try
    Result := False;
    try
      for i := 0 to Screen.FormCount - 1 do
      begin
        if UpperCase(Screen.Forms[i].Name) = UpperCase(pNomeForm) then
        begin
          Result := True;
          Exit;
        end;
      end;
    except
      on E: Exception do
      begin
        pMsgErro('Ocorreu um erro interno ao localizar o formulário.' + #13 + 'Entre em contato com o suporte e transmita a mensagem a seguir: ' + #13
          + E.Message);
        Abort;
      end;
    end;
  finally
    Result := False;
  end;
end;

function iif(nCondicao: Boolean; nTrue, nFalse: Variant): Variant;
begin
  if nCondicao then
    Result := nTrue
  else
    Result := nFalse;
end;

function fGetMachineName: string;
var
  Size: DWORD;
begin
  Size := MAX_COMPUTERNAME_LENGTH + 1;
  SetLength(Result, Size);
  GetComputerName(PChar(Result), Size);
  SetLength(Result, StrLen(PChar(Result)));
end;

procedure pStartTransaction(pConexao: TAdoConnection);
var
  qrTransacao: TAdoQuery;
begin
  qrTransacao := TAdoQuery.Create(nil);
  with qrTransacao do
  begin
    Close;
    Connection := pConexao;
    Sql.Clear;
    Sql.Add('BEGIN TRANSACTION');
    ExecSQL;
  end;
end;

procedure pRollbackTransaction(pConexao: TAdoConnection);
var
  qrTransacao: TAdoQuery;
begin
  qrTransacao := TAdoQuery.Create(nil);
  with qrTransacao do
  begin
    Close;
    Connection := pConexao;
    Sql.Clear;
    Sql.Add('ROLLBACK TRANSACTION');
    ExecSQL;
  end;
end;

procedure pCommitTransaction(pConexao: TAdoConnection);
var
  qrTransacao: TAdoQuery;
begin
  qrTransacao := TAdoQuery.Create(nil);
  with qrTransacao do
  begin
    Close;
    Connection := pConexao;
    Sql.Clear;
    Sql.Add('COMMIT TRANSACTION');
    ExecSQL;
  end;
end;

function fVerificaTransacao(pConexao: TAdoConnection): Integer;
var
  qrTransacao: TAdoQuery;
begin
  qrTransacao := TAdoQuery.Create(nil);
  with qrTransacao do
  begin
    Close;
    Connection := pConexao;
    Sql.Clear;
    Sql.Add('SELECT "QtdTran" = @@TranCount');
    Open;
    Result := FieldByName('QtdTran').AsInteger;
  end;
end;

function fStrZero(Num: Real; Zeros, Deci: Integer): string;
var
  tam, z: Integer;
  res, zer: string;
begin
  str(Num: Zeros: Deci, res);
  res := Trim(res);
  tam := length(res);
  zer := '';
  for z := 1 to (Zeros - tam) do
    zer := zer + '0';
  Result := zer + res;
end;

procedure pEmiteSinalSonoro(pTipo: Integer);
begin
  { 0 - Evento Som Padrão }
  { 16 - Evento Parada Crítica }
  { 32 - Evento Pergunta }
  { 48 - Evento Exclamação }
  { 64 - Evento Asterisco }
  MessageBeep(pTipo);
end;

function fPergunta(nMensagem: string; nSimDefault: Boolean = True; nTextoDetalhe: string = ''): Boolean;
begin
  if not fExisteForm('TfMensagem') then
  begin
    try
      Application.CreateForm(TfMensagem, fMensagem);
      with fMensagem do
      begin
        Position := poScreenCenter;
        fFrmTituloForm1.lbTitulo.Caption := 'Confirmação';

        vIndexImagem := 3;

        lbMensagem.Caption := nMensagem;
        mmTextoDetalhes.Lines.Add(nTextoDetalhe);
        lbMensagem.Style.Font.Color := clBlack;

        pnlBtnSimNao.Enabled := True;
        pnlBtnSimNao.Visible := True;

        pnlBtnOk.Visible := False;
        pnlBtnOk.Enabled := False;

        pnlBtnSimNao.BringToFront;

        vFocoSim := nSimDefault;

        ShowModal;

        Result := vResult;
      end;
    finally
      FreeAndNil(fMensagem);
    end;
  end;
end;

function fBuscaUltimoCodigo(pConexao: TAdoConnection; pTabela, pCampo: string; pPsqIntervalo: Boolean = False; pWhere: string = ''): Variant;
var
  pQuery: TAdoQuery;
begin
  pQuery := TAdoQuery.Create(nil);
  with pQuery do
  begin
    Sql.Clear;
    if not pPsqIntervalo then
      Sql.Add('SELECT COALESCE(MAX(' + pCampo + '),0)+1 as UltCodigo FROM ' + pTabela)
    else
    begin
      Sql.Add('SELECT "UltCodigo" = MIN(tbCodigo.n)');
      Sql.Add('FROM   dbo.fnGetProximoCodigo() AS tbCodigo');
      Sql.Add('WHERE  NOT EXISTS(');
      Sql.Add('           SELECT 1');
      Sql.Add('           FROM   ' + pTabela + ' s');
      Sql.Add('           WHERE  s.' + pCampo + ' = tbCodigo.n)');
    end;
    Open;
    Result := FieldByName('UltCodigo').AsInteger;
  end;
  { Código SQL Função do banco SQLServer.
    CREATE Function dbo.fnGetProximoCodigo
    (
    )
    RETURNS TABLE
    AS
    RETURN(
    WITH Nbrs_3(n) AS (
    SELECT 1 UNION SELECT 0
    ),
    Nbrs_2(n) AS (
    SELECT 1
    FROM   Nbrs_3 n1
    CROSS JOIN Nbrs_3 n2
    ),
    Nbrs_1(n) AS (
    SELECT 1
    FROM   Nbrs_2 n1
    CROSS JOIN Nbrs_2 n2
    ),
    Nbrs_0(n) AS (
    SELECT 1
    FROM   Nbrs_1 n1
    CROSS JOIN Nbrs_1 n2
    ),
    Nbrs(n) AS (
    SELECT 1
    FROM   Nbrs_0 n1
    CROSS JOIN Nbrs_0 n2
    )
    SELECT n FROM (
    SELECT ROW_NUMBER() OVER(ORDER BY n)
    FROM   Nbrs
    ) D(n)
    )
  }
end;

function fRetiraMascara(nTexto: string): string;
var
  nRes: string;
  i: Integer;
begin
  try
    try
      nRes := '';
      for i := 1 to length(nTexto) do
        if (nTexto[i] <> '/') and (nTexto[i] <> '-') and (nTexto[i] <> '.') then
          nRes := nRes + nTexto[i];
    except
      on E: Exception do
      begin
        pMsgErro('Ocorreu um erro interno ao retirar a mascara.' + #13 + 'Entre em contato com o suporte e transmita a mensagem a seguir: ' + #13 +
          E.Message);
        Abort;
      end;
    end;
  finally
    Result := nRes;
  end;
end;

{
  Autor.....: Jeimyson de Oliveira Souza
  Data......: 03/07/2008
  Objetivo..: "Habilitar" ou "Desabilitar" componentes dentro de um conjunto.
  Parametros: pHabDes -> True = Habilita / False = Desabilita,
  ............ pGrupo = Conjunto.
}
procedure pHabilitaDesabilita(pHabDes: Boolean; pGrupo: TObject);
var
  i: Shortint;
  nCor: TColor;
begin
  try
    with TCustomGroupBox(pGrupo) do
    begin
      if pHabDes then
        nCor := ClWindow
      else
        nCor := clSilver;

      for i := 0 to ControlCount - 1 do
      begin
        if TWinControl(Controls[i]).tag <> 99 then
        begin
          TWinControl(Controls[i]).Enabled := pHabDes;
          if Controls[i] is TEdit then
            TEdit(Controls[i]).Color := nCor
          else if Controls[i] is TMaskEdit then
            TMaskEdit(Controls[i]).Color := nCor
          else if Controls[i] is TcxGrid then
            TcxGrid(Controls[i]).Canvas.SetBrushColor(nCor)
          else if Controls[i] is TComboBox then
            TComboBox(Controls[i]).Color := nCor
          else if Controls[i] is TMemo then
            TMemo(Controls[i]).Color := nCor
          else if Controls[i] is TcxDBTextEdit then
            TcxDBTextEdit(Controls[i]).Style.Color := nCor
          else if Controls[i] is TcxDBLookupComboBox then
            TcxDBLookupComboBox(Controls[i]).Style.Color := nCor
          else if Controls[i] is TGroupBox then
            pHabilitaDesabilita(pHabDes, Controls[i]);
        end;
      end;
    end;
    with TCustomButton(pGrupo) do
    begin
      TcxButton(pGrupo).Enabled := pHabDes;
      TcxGrid(pGrupo).Enabled := pHabDes;
      TcxdbCheckBox(pGrupo).Enabled := pHabDes;
      TcxtabSheet(pGrupo).Enabled := pHabDes;
    end;
  except
    on E: Exception do
    begin
      pMsgErro('Ocorreu um erro interno neste formulário.' + #13 + 'Entre em contato com o suporte e transmita a mensagem a seguir: ' + #13 +
        E.Message);
      Abort;
    end;
  end;
end;

function fExecSqlTabela(pConexao: TAdoConnection; pSql: string; pControlaTran: Boolean = True; pExecuteSql: Boolean = False): TAdoQuery;
var
  nQuery: TAdoQuery;
begin
  try
    nQuery := TAdoQuery.Create(nil);
    nQuery.Sql.Clear;
    if pControlaTran then
    begin
      nQuery.Sql.Add('BEGIN TRAN');
      nQuery.Sql.Add('DECLARE @RET BIT');
    end;
    nQuery.Sql.Add(pSql);
    if pControlaTran then
    begin
      nQuery.Sql.Add('IF @RET = 1 COMMIT TRAN ELSE ROLLBACK TRAN');
      nQuery.Sql.Add('SELECT "RET"=@RET');
    end;
    nQuery.Connection := pConexao;
    if pExecuteSql then
      nQuery.ExecSQL
    else
      nQuery.Open;
    Result := nQuery;
  except
    on E: Exception do
    begin
      pMsgErro(E.Message);
      Abort;
    end;
  end;
end;

procedure pCarregaForm(FrmClass: TComponentClass; var Frm; pTag: Integer = 0; pWindowState: TWindowState = WsNormal);
begin
  if not fExisteForm(Copy(FrmClass.ClassName, 2, length(FrmClass.ClassName))) then
  begin
    try
      try
        Application.CreateForm(FrmClass, Frm);
        with TForm(Frm) do
        begin
          if TForm(Frm).FormStyle <> fsMDIChild then
          begin
            WindowState := pWindowState;
            BorderStyle := bsDialog;
            BorderIcons := TForm(Frm).BorderIcons - [biSystemMenu];
            Position := poScreenCenter;
          end
          else
            WindowState := wsMaximized;

          tag := pTag;

          KeyPreview := True;

          if TForm(Frm).FormStyle <> fsMDIChild then
            ShowModal
          else
            Show;
        end;
      except
        on E: Exception do
        begin
          pMsgErro('Ocorreu um erro interno ao criar o formulário.' + #13 + 'Entre em contato com o suporte e transmita a mensagem a seguir: ' + #13 +
            E.Message);
          Abort;
        end;
      end;
    finally
      if TForm(Frm).FormStyle <> fsMDIChild then
        FreeAndNil(TForm(Frm));
    end;
  end;
end;

procedure pExecutePrograma(pNome, pParametros: string);
var
  Comando: array [0 .. 1024] of Char;
  Parms: array [0 .. 1024] of Char;
begin
  try
    StrPCopy(Comando, pNome);
    StrPCopy(Parms, pParametros);
    ShellExecute(0, nil, Comando, Parms, nil, SW_ShowMaximized);
  except
    on E: Exception do
    begin
      pMsgErro('Ocorreu um erro interno ao executar o programa.' + #13 + 'Entre em contato com o suporte e transmita a mensagem a seguir: ' + #13 +
        E.Message);
      Abort;
    end;
  end;
end;

function fDataSrvSQL(pConexao: TAdoConnection): TDatetime;
var
  nQry: TAdoQuery;
begin
  try
    try
      nQry := TAdoQuery.Create(nil);
      with nQry do
      begin
        Close;
        Connection := pConexao;
        Sql.Add('SELECT "Data" = GETDATE()');
        Open;
        Result := FieldByName('Data').AsDateTime;
      end;
    except
      on E: Exception do
      begin
        pMsgErro('Ocorreu um erro interno ao tentar buscar a data atual do servidor.' + #13 +
          'Entre em contato com o suporte e transmita a mensagem a seguir: ' + #13 + E.Message);
        Abort;
      end;
    end;
  finally
    nQry.Close;
    nQry.Destroy;
  end;
end;

function fGravarRegistroWin(pPropriedade, pValorPropriedade: string): Boolean;
var
  Registro: TRegistry;
begin
  try
    try
      Registro := TRegistry.Create;
      { Abre a chave se o 2°. Parâmetro for True. Cria automatico se a chave ainda não existir. }
      Registro.OpenKey(cPastaRaizRegistro, True);
      { Grava as propriedades }
      Registro.WriteString(pPropriedade, pValorPropriedade);
    except
      on E: Exception do
      begin
        pMsgErro('Ocorreu um erro interno ao tentar grsvar informações no registro do windows.' + #13 +
          'Entre em contato com o suporte e transmita a mensagem a seguir: ' + #13 + E.Message);
        Abort;
      end;
    end;
  finally
    Registro.CloseKey;
    Registro.Free;
  end;
end;

function fLeRegistroWin(pPropriedade, pValorPropriedade: string): Variant;
var
  Registro: TRegistry;
begin
  try
    try
      Registro := TRegistry.Create;
      with Registro do
      begin
        if OpenKey(cPastaRaizRegistro, False) then
          if ValueExists(pPropriedade) then
            Result := ReadString(pPropriedade);
      end;
    except
      on E: Exception do
      begin
        pMsgErro('Ocorreu um erro interno ao tentar ler informações no registro do windows.' + #13 +
          'Entre em contato com o suporte e transmita a mensagem a seguir: ' + #13 + E.Message);
        Abort;
      end;
    end;
  finally
    Registro.CloseKey;
    Registro.Free;
  end;
end;

procedure pExpandGrupoCxGrid(AView: TcxGridTableView; ALevel: Integer);
var
  i: Integer;
begin
  AView.BeginUpdate;
  try
    AView.DataController.Groups.FullExpand;
    for i := AView.DataController.RowCount - 1 downto 0 do
      if AView.DataController.GetRowInfo(i).Level > ALevel then
        AView.DataController.Groups.ChangeExpanding(i, False, True);
  finally
    AView.EndUpdate;
  end;
end;

procedure pSalvaConfigIni(pNomeArquivo: string);
begin
  if FileExists(ExtractFilePath(Application.Exename) + pNomeArquivo) then
  begin
    try
      try
        nArqIni := TIniFile.Create(ExtractFilePath(Application.Exename) + pNomeArquivo);
        with nArqIni do
        begin
          WriteString('Servidor1', 'Nome', '');
          WriteString('Servidor1', 'Servidor', '');
          WriteString('Servidor1', 'BancoDeDados', '');
          WriteString('Servidor1', 'Usuario', '');
          WriteString('Servidor1', 'Senha', '');

          WriteString('ServidorExterno', 'Nome', '');
          WriteString('ServidorExterno', 'Servidor', '');
          WriteString('ServidorExterno', 'BancoDeDados', '');
          WriteString('ServidorExterno', 'Usuario', '');
          WriteString('ServidorExterno', 'Senha', '');
        end;
      except
        on E: Exception do
        begin
          pMsgErro('Ocorreu um erro interno ao salvar informações no arquivo ".ini".' + #13 +
            'Entre em contato com o suporte e transmita a mensagem a seguir: ' + #13 + E.Message);
          Abort;
        end;
      end;
    finally
      FreeAndNil(nArqIni);
    end;
  end;
end;

{ Testa se em uma string existe um numero inteiro valido ou não }
function fexisteInt(Texto: string): Boolean;
var
  i: Integer;
begin
  try
    i := StrToInt(Texto);
    Result := True;
  except
    Result := False;
  end;
end;

function IsInteger(const S: string): Boolean;
begin
  try
    StrToInt(S);
    Result := True;
  except
    Result := False;
  end;
end;

function fLimpaObjs(cParent: TWinControl): Boolean;
var
  nConta: Integer;
begin
  try
    fLimpaObjs := True;
    for nConta := 0 to cParent.ControlCount - 1 do
    begin
      if (cParent.Controls[nConta].ClassType = TEdit) then
        (cParent.Controls[nConta] as TEdit).Clear;

      if cParent.Controls[nConta].ClassType = TMemo then
        (cParent.Controls[nConta] as TMemo).Clear;

      if cParent.Controls[nConta].ClassType = TcxTextEdit then
        (cParent.Controls[nConta] as TcxTextEdit).Clear;
    end;
  except
    fLimpaObjs := False;
  end;
end;

procedure pFocoPrimeiroObj(cParent: TWinControl);
var
  nConta: Integer;
begin
  try
    for nConta := 0 to cParent.ControlCount - 1 do
    begin
      if cParent.Controls[nConta].ClassType = TcxTextEdit then
        if (cParent.Controls[nConta] as TcxTextEdit).Enabled then
        begin
          (cParent.Controls[nConta] as TcxTextEdit).SetFocus;
          Break;
        end;

      if cParent.Controls[nConta].ClassType = TcxDBTextEdit then
        if (cParent.Controls[nConta] as TcxDBTextEdit).Enabled then
        begin
          (cParent.Controls[nConta] as TcxDBTextEdit).SetFocus;
          Break;
        end;

      if cParent.Controls[nConta].ClassType = TcxLookupComboBox then
        if (cParent.Controls[nConta] as TcxLookupComboBox).Enabled then
        begin
          (cParent.Controls[nConta] as TcxLookupComboBox).SetFocus;
          Break;
        end;

      if cParent.Controls[nConta].ClassType = TcxDBLookupComboBox then
        if (cParent.Controls[nConta] as TcxDBLookupComboBox).Enabled then
        begin
          (cParent.Controls[nConta] as TcxDBLookupComboBox).SetFocus;
          Break;
        end;

      if cParent.Controls[nConta].ClassType = TcxDateEdit then
        if (cParent.Controls[nConta] as TcxDateEdit).Enabled then
        begin
          (cParent.Controls[nConta] as TcxDateEdit).SetFocus;
          Break;
        end;

      if cParent.Controls[nConta].ClassType = TcxDBDateEdit then
        if (cParent.Controls[nConta] as TcxDBDateEdit).Enabled then
        begin
          (cParent.Controls[nConta] as TcxDBDateEdit).SetFocus;
          Break;
        end;
    end;
  except
    on E: Exception do
    begin
      pMsgErro('Ocorreu um erro interno neste formulário.' + #13 + 'Entre em contato com o suporte e transmita a mensagem a seguir: ' + #13 +
        E.Message);
      Abort;
    end;
  end;
end;

procedure pFechaComponentes(pForm: TForm);
var
  nConta: Integer;
begin
  try
    with pForm do
    begin
      for nConta := 0 to ComponentCount - 1 do
      begin
        if LowerCase(Components[nConta].ClassName) = 'tadoquery' then
          if TAdoQuery(Components[nConta]).Active then
            TAdoQuery(Components[nConta]).Close;

        if LowerCase(Components[nConta].ClassName) = 'tClientdataset' then
          if TClientDataSet(Components[nConta]).Active then
            TClientDataSet(Components[nConta]).Close;

        if LowerCase(Components[nConta].ClassName) = 'tadostoredproc' then
          if TADOStoredProc(Components[nConta]).Active then
            TADOStoredProc(Components[nConta]).Close;
      end;
    end;
  except
    on E: Exception do
    begin
      pMsgErro('Ocorreu um erro interno neste formulário.' + #13 + 'Entre em contato com o suporte e transmita a mensagem a seguir: ' + #13 +
        E.Message);
      Abort;
    end;
  end;
end;

function fCriptografarBaixo(pTexto: string): string;
var
  Cont, Cod: Integer;
  Retorna: string;
begin
  for Cont := 1 to length(pTexto) do
  begin
    Cod := fValorAsc(Copy(pTexto, Cont, 1));
    Retorna := Retorna + Chr(Cod + 18);
  end;
  Result := Retorna;
end;

function fDescriptografarBaixo(pTexto: string): string;
var
  Cont, Cod: Integer;
  Retorna: string;
begin
  for Cont := 1 to length(pTexto) do
  begin
    Cod := fValorAsc(Copy(pTexto, Cont, 1));
    Retorna := Retorna + Chr(Cod - 18);
  end;
  Result := Retorna;
end;

function fValorAsc(Letra: string): Byte;
begin
  if length(Letra) > 0 then
    fValorAsc := Ord(Letra[1])
  else
    fValorAsc := 0;
end;

function fGetVersaoAplicacao(pCaminhoApp: string; pForm: TForm; pExiste: Boolean = True): string;
var
  nVersao: TVersionLabel;
begin
  nVersao := TVersionLabel.Create(pForm);
  if (pExiste) and (not FileExists(pCaminhoApp)) then
  begin
    pMsgInfo('Não foi possivel encontrar o Executável: ' + QuotedStr(pCaminhoApp));
    Result := '';
    Exit;
  end;
  (nVersao as TVersionLabel).Filename := pCaminhoApp;
  (nVersao as TVersionLabel).ShowInfoPrefix := False;
  if not((nVersao as TVersionLabel).InfoString[1] in ['0' .. '9']) then
  begin
    if pExiste then
      pMsgErro('Aplicação não tem informação de versão!!');
    Result := '';
    Exit;
  end;
  Result := (nVersao as TVersionLabel).InfoString;
end;

procedure pMudaImgBotao(pForm: TForm; pSender: TObject; pImgAtivo, pImgDesativo: TcxImageList);
var
  nConta, nIndexImg: Integer;
begin
  try
    if Assigned(pForm) then
    begin
      with pForm do
      begin
        for nConta := 0 to ComponentCount - 1 do
        begin
          if Components[nConta].ClassName = 'TcxButton' then
          begin
            if Assigned(TcxButton(Components[nConta])) then
            begin
              if TcxButton(Components[nConta]).Visible then
              begin
                if TcxButton(Components[nConta]).Enabled then
                begin
                  if Trim(TcxButton(Components[nConta]).HelpKeyword) <> '' then
                  begin
                    nIndexImg := StrToInt(TcxButton(Components[nConta]).HelpKeyword);
                    if (pSender is TcxButton) then
                    begin
                      if ActiveControl <> nil then
                      begin
                        if (LowerCase(ActiveControl.Name) = LowerCase(TcxButton(Components[nConta]).Name)) or
                          (LowerCase((pSender as TcxButton).Name) = LowerCase(TcxButton(Components[nConta]).Name)) then
                        begin
                          if TcxButton(Components[nConta]).tag = 0 then
                          begin
                            pImgAtivo.GetImage(nIndexImg, TcxButton(Components[nConta]).Glyph);
                            TcxButton(Components[nConta]).tag := 1;
                            TcxButton(Components[nConta]).SetFocus;
                          end;
                        end
                        else
                        begin
                          pImgDesativo.GetImage(nIndexImg, TcxButton(Components[nConta]).Glyph);
                          TcxButton(Components[nConta]).tag := 0;
                        end;
                      end
                      else
                      begin

                      end;
                    end
                    else
                    begin
                      pImgDesativo.GetImage(nIndexImg, TcxButton(Components[nConta]).Glyph);
                      TcxButton(Components[nConta]).tag := 0;
                    end;
                  end;
                end;
              end;
            end;
          end;
        end;
      end;
    end;
  except
    on E: Exception do
    begin
      pMsgErro('Ocorreu um erro interno neste formulário.' + #13 + 'Entre em contato com o suporte e transmita a mensagem a seguir: ' + #13 +
        E.Message);
      Abort;
    end;
  end;
end;

procedure pSetFocus(pObjeto: TObject; pField: string);
var
  nConta, nContaFilho: Integer;
begin
  with TWinControl(pObjeto) do
  begin
    { Coloca o foco no objeto que não esta preenchido. }
    for nConta := 0 to TWinControl(pObjeto).ControlCount - 1 do
    begin
      { cxDBTextEdit }
      if (TWinControl(Controls[nConta]) is TcxDBTextEdit) then
      begin
        if (TWinControl(Controls[nConta]) as TcxDBTextEdit).Enabled then
        begin
          if LowerCase((TWinControl(Controls[nConta]) as TcxDBTextEdit).DataBinding.DataField) = LowerCase(pField) then
          begin
            if (((TWinControl(Controls[nConta]) as TcxDBTextEdit).Parent) is TcxtabSheet) then
            begin
              ((((TWinControl(Controls[nConta]) as TcxDBTextEdit).Parent) as TcxtabSheet).PageControl).ActivePageIndex :=
                (((TWinControl(Controls[nConta]) as TcxDBTextEdit).Parent) as TcxtabSheet).PageIndex;
              (TWinControl(Controls[nConta]) as TcxDBTextEdit).SetFocus;
            end
            else if (((TWinControl(Controls[nConta]) as TcxDBTextEdit).Parent) is TTabSheet) then
            begin
              ((((TWinControl(Controls[nConta]) as TcxDBTextEdit).Parent) as TTabSheet).PageControl).ActivePageIndex :=
                (((TWinControl(Controls[nConta]) as TcxDBTextEdit).Parent) as TTabSheet).PageIndex;
              (TWinControl(Controls[nConta]) as TcxDBTextEdit).SetFocus;
            end
            else
              (TWinControl(Controls[nConta]) as TcxDBTextEdit).SetFocus;
            Abort;
          end;
        end;
      end;

      { cxDBDateEdit }
      if (TWinControl(Controls[nConta]) is TcxDBDateEdit) then
      begin
        if (TWinControl(Controls[nConta]) as TcxDBDateEdit).Enabled then
        begin
          if LowerCase((TWinControl(Controls[nConta]) as TcxDBDateEdit).DataBinding.DataField) = LowerCase(pField) then
          begin
            if (((TWinControl(Controls[nConta]) as TcxDBDateEdit).Parent) is TcxtabSheet) then
            begin
              ((((TWinControl(Controls[nConta]) as TcxDBDateEdit).Parent) as TcxtabSheet).PageControl).ActivePageIndex :=
                (((TWinControl(Controls[nConta]) as TcxDBDateEdit).Parent) as TcxtabSheet).PageIndex;
              (TWinControl(Controls[nConta]) as TcxDBDateEdit).SetFocus;
            end
            else if (((TWinControl(Controls[nConta]) as TcxDBDateEdit).Parent) is TTabSheet) then
            begin
              ((((TWinControl(Controls[nConta]) as TcxDBDateEdit).Parent) as TTabSheet).PageControl).ActivePageIndex :=
                (((TWinControl(Controls[nConta]) as TcxDBDateEdit).Parent) as TTabSheet).PageIndex;
              (TWinControl(Controls[nConta]) as TcxDBDateEdit).SetFocus;
            end
            else
              (TWinControl(Controls[nConta]) as TcxDBDateEdit).SetFocus;
            Abort;
          end;
        end;
      end;

      { cxDBCheckBox }
      if (TWinControl(Controls[nConta]) is TcxdbCheckBox) then
      begin
        if (TWinControl(Controls[nConta]) as TcxdbCheckBox).Enabled then
        begin
          if LowerCase((TWinControl(Controls[nConta]) as TcxdbCheckBox).DataBinding.DataField) = LowerCase(pField) then
          begin
            if (((TWinControl(Controls[nConta]) as TcxdbCheckBox).Parent) is TcxtabSheet) then
            begin
              ((((TWinControl(Controls[nConta]) as TcxdbCheckBox).Parent) as TcxtabSheet).PageControl).ActivePageIndex :=
                (((TWinControl(Controls[nConta]) as TcxdbCheckBox).Parent) as TcxtabSheet).PageIndex;
              (TWinControl(Controls[nConta]) as TcxdbCheckBox).SetFocus;
            end
            else if (((TWinControl(Controls[nConta]) as TcxdbCheckBox).Parent) is TTabSheet) then
            begin
              ((((TWinControl(Controls[nConta]) as TcxdbCheckBox).Parent) as TTabSheet).PageControl).ActivePageIndex :=
                (((TWinControl(Controls[nConta]) as TcxdbCheckBox).Parent) as TTabSheet).PageIndex;
              (TWinControl(Controls[nConta]) as TcxdbCheckBox).SetFocus;
            end
            else
              (TWinControl(Controls[nConta]) as TcxdbCheckBox).SetFocus;
            Abort;
          end;
        end;
      end;

      { cxDBLookupComboBox }
      if (TWinControl(Controls[nConta]) is TcxDBLookupComboBox) then
      begin
        if (TWinControl(Controls[nConta]) as TcxDBLookupComboBox).Enabled then
        begin
          if LowerCase((TWinControl(Controls[nConta]) as TcxDBLookupComboBox).DataBinding.DataField) = LowerCase(pField) then
          begin
            if (((TWinControl(Controls[nConta]) as TcxDBLookupComboBox).Parent) is TcxtabSheet) then
            begin
              ((((TWinControl(Controls[nConta]) as TcxDBLookupComboBox).Parent) as TcxtabSheet).PageControl).ActivePageIndex :=
                (((TWinControl(Controls[nConta]) as TcxDBLookupComboBox).Parent) as TcxtabSheet).PageIndex;
              (TWinControl(Controls[nConta]) as TcxDBLookupComboBox).SetFocus;
            end
            else if (((TWinControl(Controls[nConta]) as TcxDBLookupComboBox).Parent) is TTabSheet) then
            begin
              ((((TWinControl(Controls[nConta]) as TcxDBLookupComboBox).Parent) as TTabSheet).PageControl).ActivePageIndex :=
                (((TWinControl(Controls[nConta]) as TcxDBLookupComboBox).Parent) as TTabSheet).PageIndex;
              (TWinControl(Controls[nConta]) as TcxDBLookupComboBox).SetFocus;
            end
            else
              (TWinControl(Controls[nConta]) as TcxDBLookupComboBox).SetFocus;
            Abort;
          end;
        end;
      end;
    end;
  end;
end;

procedure pValidaCamposObrigatorios(pCds: TClientDataSet; pPnlObjetos: TObject);
var
  vContador: Integer;
begin
  vContador := 0;
  with pCds do
  begin
    { Trata campos obrigatorios para não permitir vazio }
    for vContador := 0 to Fields.Count - 1 do
    begin
      if Fields[vContador].Required then
      begin
        if (Fields[vContador].IsNull) or (Trim(Fields[vContador].Value) = '') then
        begin
          pMsgAtencao('Campo ' + Fields[vContador].DisplayLabel + ' não pode ser vazio!');
          pSetFocus(pPnlObjetos, Fields[vContador].FieldName);
          Abort;
        end;
      end;
    end;
  end;
end;

procedure pAlimentaStoredProc(pCds: TClientDataSet; pSP: TADOStoredProc; pDML: string = '');
{ Procedimento para alimentar os parametros de um ADOStoredProc de acordo com um ClientDataSet.
  Obs.: Não executa o ADOStoredProc. }
var
  i: Integer;
begin
  try
    with pCds do
    begin
      for i := 0 to pCds.Fields.Count - 1 do
      begin
        if pSP.Parameters.FindParam('@' + pCds.Fields[i].FieldName) <> nil then
          if (pSP.Parameters.FindParam('@' + pCds.Fields[i].FieldName).Name = '@DML') and (pDML <> '') then
            pSP.Parameters.FindParam('@' + pCds.Fields[i].FieldName).Value := pCds.Fields[i].Value
          else
            pSP.Parameters.FindParam('@' + pCds.Fields[i].FieldName).Value := pCds.Fields[i].Value;
      end;
    end;
  except
    on E: Exception do
    begin
      pMsgErro('Não foi possível alimentar os parâmetros de gravação!' + #13 +
        'Verifique os detalhes do erro e contate o suporte para transmitir o problema.', 'Mensagem original: ' + #13 + E.Message);
      Abort;
    end;
  end;
end;

function fExecuteProcedure(pClientDataSet: TClientDataSet; pStored: TADOStoredProc): Boolean;
{ Procedimento para alimentar os parametros de um ADOStoredProc de acordo com um ClientDataSet.
  Obs.: Executa o ADOStoredProc. }
var
  i: Integer;
begin
  Result := False;
  try
    with pClientDataSet do
    begin
      DisableControls;
      First;
      while not Eof do
      begin
        for i := 0 to pClientDataSet.Fields.Count - 1 do
        begin
          if pStored.Parameters.FindParam('@' + pClientDataSet.Fields[i].FieldName) <> nil then
            pStored.Parameters.ParamByName('@' + pClientDataSet.Fields[i].FieldName).Value :=
              pClientDataSet.FieldByName(pClientDataSet.Fields[i].FieldName).Value;
        end;
        pStored.ExecProc;
        Next;
      end;
      EnableControls;
    end;
    Result := True;
  except
    on E: Exception do
    begin
      pMsgErro('Não foi possível executar o procedimento de gravação!' + #13 +
        'Verifique os detalhes do erro e contate o suporte para transmitir o problema.', 'Mensagem original: ' + #13 + E.Message);
      Abort;
    end;
  end;
end;

function fRetiraInteiro(nTexto: string): string;
var
  nRes: string;
  i: Integer;
begin
  nRes := '';
  for i := 1 to length(nTexto) do
  begin
    try
      StrToInt(nTexto[i]);
    except
      nRes := nRes + nTexto[i];
    end;
  end;
  Result := nRes;
end;

function fRealizaBackupPostGreSQL(pCaminhoInstalacao, pCaminhoAplicacao, pCaminhoDestino, pServer: String; pPorta: Integer): Boolean;
var
  i: Integer;
  arq: TextFile;
  vNmArq, Texto: string;
begin
  Result := False;
  Try
    Try
      Texto := '"' + pCaminhoInstalacao + 'pg_dump.exe" -h ' + pServer + ' -p ' + IntToStr(pPorta) + ' -U postgres -f "' + pCaminhoDestino +
        'BCK_SAGE' + FormatDateTime('_dd-mm-yyyy_', Date) + FormatDateTime('hh-nn-ss', now) + '.sql" -C AI';

      vNmArq := pCaminhoAplicacao + 'BCK_SAGE' + FormatDateTime('_dd-mm-yyyy_', Date) + FormatDateTime('hh-nn-ss', now) + '.sql';

      AssignFile(arq, pCaminhoAplicacao + 'BackupBancoSAGE.bat');
      Rewrite(arq);
      Writeln(arq, Texto);
      CloseFile(arq);
      if fWinExecAndWait32(pCaminhoAplicacao + 'BackupBancoSAGE.bat', pCaminhoAplicacao, SW_NORMAL) <> -1 then
      begin
        for i := 0 to 10 do
          if FileExists(pCaminhoDestino + 'BCK_SAGE' + FormatDateTime('_dd-mm-yyyy_', Date) + FormatDateTime('hh-nn-ss', now) + '.sql') then
            Result := True
          else
            Result := False;
        Sleep(100);
      end;
    except
      on E: Exception do
      begin
        pMsgAtencao('Não foi possível realizar o Backup do Banco de dados.' + #13 +
          'Tente realizar o procedimento manualmente ou entre em contate o suporte.');
        Result := False;
        Abort;
      end;
    end;
  Finally
    if Result then
    begin
      pMsgInfo('Backup realizado com sucesso!');
      Abort;
    end
    else
    begin
      pMsgAtencao('Não foi possível realizar o Backup do Banco de dados.' + #13 +
        'Tente realizar o procedimento manualmente ou entre em contate o suporte.');
      Abort;
    end;
  End;
end;

function fGetSelectDirectory(Title: string): string;
var
  Pasta: String;
begin
  SelectDirectory(Title, '', Pasta);
  if (Trim(Pasta) <> '') then
    if (Pasta[length(Pasta)] <> '\') then
      Pasta := Pasta + '\';
  Result := Pasta;
end;

function fWinExecAndWait32(Filename: String; WorkDir: String; Visibility: Integer): Integer;
var
  zAppName: array [0 .. 512] of Char;
  zCurDir: array [0 .. 255] of Char;
  StartupInfo: TStartupInfo;
  ProcessInfo: TProcessInformation;
begin
  StrPCopy(zAppName, Filename);
  StrPCopy(zCurDir, WorkDir);
  FillChar(StartupInfo, Sizeof(StartupInfo), #0);
  StartupInfo.cb := Sizeof(StartupInfo);
  StartupInfo.dwFlags := STARTF_USESHOWWINDOW;
  StartupInfo.wShowWindow := Visibility;

  if not CreateProcess(nil, zAppName, nil, nil, False, CREATE_NEW_CONSOLE or NORMAL_PRIORITY_CLASS, nil, zCurDir, StartupInfo, ProcessInfo) then
    Result := -1
  else
  begin
    WaitforSingleObject(ProcessInfo.hProcess, INFINITE);
    GetExitCodeProcess(ProcessInfo.hProcess, DWORD(Result));
  end;
end;

function fBuscaStringMemo(pMemo: TMemo; pTexto: String): Boolean;
var
  i, ipos, linha, tamanho: Integer;
  buffer: string;
begin
  Result := False;
  for i := 0 to pMemo.Lines.Count - 1 do
    if Pos(pTexto, pMemo.Lines.Text) > 0 then
    begin
      linha := i + 1;
      tamanho := length(pMemo.Lines.Strings[linha]);
      Result := True;
      Break;
    end;
end;

function fAlinhaEsquerda(preenche: Char; str: string; tamanho: Integer): string;
begin
  str := Trim(str);
  Result := str + StringOfChar(preenche, tamanho - length(str));
  Result := Copy(Result, 1, tamanho);
end;

function fAlinhaDireita(preenche: Char; str: string; tamanho: Integer): string;
begin
  str := Trim(str);
  Result := StringOfChar(preenche, tamanho - length(str)) + str;
  Result := Copy(Result, 1, tamanho);
end;

function fModulo11(str: string): String;
var
  mult: Integer;
  Digito: Integer;
  i: Integer;
begin
  Digito := 0;
  mult := 9;
  for i := length(str) downto 1 do
  begin
    Digito := Digito + (StrToInt(str[i]) * mult);
    If mult = 2 then
      mult := 9
    else
      dec(mult);
  end;
  Digito := Digito mod 11;
  If Digito = 10 then
    Result := 'X'
  else
    Result := IntToStr(Digito);
end;

function fRetiraCaracteresEspeciais(valor: string): string;
var
  i: Integer;
  S: Char;
begin
  for i := 1 to length(valor) do
  begin
    S := valor[i];
    if (S = 'Á') then
      S := 'A'
    else if (S = 'É') then
      S := 'E'
    else if (S = 'Í') then
      S := 'I'
    else if (S = 'Ó') then
      S := 'O'
    else if (S = 'Ú') then
      S := 'U'
    else if (S = 'á') then
      S := 'a'
    else if (S = 'é') then
      S := 'e'
    else if (S = 'í') then
      S := 'i'
    else if (S = 'ó') then
      S := 'o'
    else if (S = 'ú') then
      S := 'u'
    else if (S = 'À') then
      S := 'A'
    else if (S = 'È') then
      S := 'E'
    else if (S = 'Ì') then
      S := 'I'
    else if (S = 'Ò') then
      S := 'O'
    else if (S = 'Ù') then
      S := 'U'
    else if (S = 'à') then
      S := 'a'
    else if (S = 'è') then
      S := 'e'
    else if (S = 'ì') then
      S := 'i'
    else if (S = 'ò') then
      S := 'o'
    else if (S = 'ù') then
      S := 'u'
    else if (S = 'Â') then
      S := 'A'
    else if (S = 'Ê') then
      S := 'E'
    else if (S = 'Î') then
      S := 'I'
    else if (S = 'Ô') then
      S := 'O'
    else if (S = 'Û') then
      S := 'U'
    else if (S = 'â') then
      S := 'a'
    else if (S = 'ê') then
      S := 'e'
    else if (S = 'î') then
      S := 'i'
    else if (S = 'ô') then
      S := 'o'
    else if (S = 'û') then
      S := 'u'
    else if (S = 'Ã') then
      S := 'A'
    else if (S = 'Õ') then
      S := 'O'
    else if (S = 'ã') then
      S := 'a'
    else if (S = 'õ') then
      S := 'o'
    else if (S = 'Ä') then
      S := 'A'
    else if (S = 'Ë') then
      S := 'E'
    else if (S = 'Ï') then
      S := 'I'
    else if (S = 'Ö') then
      S := 'O'
    else if (S = 'Ü') then
      S := 'U'
    else if (S = 'ä') then
      S := 'a'
    else if (S = 'ë') then
      S := 'e'
    else if (S = 'ï') then
      S := 'i'
    else if (S = 'ö') then
      S := 'o'
    else if (S = 'ü') then
      S := 'u'
    else if (S = 'ç') then
      S := 'c'
    else if (S = 'Ç') then
      S := 'C'
    else if (S = 'å') then
      S := 'O'
    else if (S = '€') then
      S := 'C'
    else if not(S in ['a' .. 'z', 'A' .. 'Z', '0' .. '9', #13, #10, ' ', ',', '.', '|', '-', ':']) then
      S := ' ';
    valor[i] := S;
  end;
  Result := Trim(valor);
end;

end.
