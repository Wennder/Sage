unit uProduto;

interface

uses ZConnection, ZDataset, SysUtils, uConstantes, Classes, uProcedimentosBanco, uExceptions, Variants, Forms,
     Dialogs, Windows, uSubGrupo, uMarca, uUnidade, uNCM;

type
  TProduto = class
  public
    oSubGrupo: TSubGrupo;
    oMarca: TMarca;
    oNCM: TNCM;
    oUndEntrada: TUnidade;
    oUndSaida: TUnidade;
    procedure SetCodigo(piCodigo: Integer);
    procedure SetReferencia(psReferencia: String);
    procedure SetFabricacao(psFabricacao: String);
    procedure SetDescricao(psDescricao: String);
    procedure SetCusto(pnCusto: Real);
    procedure SetQtdEntrada(piQtdEntrada: Integer);
    procedure SetQtdSaida(piQtdSaida: Integer);
    procedure SetStatus(psStatus: String);
    procedure SetServico(psServico: String);
    procedure SetDescricaoComMarca(psDescricao: String);

    function GetiCodigo: Integer;
    function GetsReferencia: String;
    function GetsFabricacao: String;
    function GetsDescricao: String;
    function GetnCusto: Real;
    function GetiQtdEntrada: Integer;
    function GetiQtdSaida: Integer;
    function GetsStatus:String;
    function GetsServico: String;
    function GetsDescricaoComMarca: String;
    function GetProdutoTemNCM: Boolean;

    function iRetornaUltimoCodigo: Integer;
    constructor Create(pzcoConnection: TZConnection);
    destructor Destroy; override;
    procedure CadastraProduto;
    procedure AlteraProduto;
    procedure DeletaProduto;
    function bPesquisaProduto(piCodigo: Integer): Boolean;
  private
    zcoConnection: TZConnection;
    iCodigo: Integer;
    sReferencia: String;
    sFabricacao: String;
    sDescricao: String;
    nCusto: Real;
    iQtdEntrada: Integer;
    iQtdSaida: Integer;
    sStatus:String;
    sServico: String;
    sDescricaoComMarca: String;
    bProdutoComNCM: Boolean;
    function iCamposConsistentes: Integer;
  end;

implementation

uses ZAbstractDataset, ZAbstractRODataset, uGrupo;


{ TProduto }

procedure TProduto.AlteraProduto;
var
  ZQryProduto: TZQuery;
begin
  if iCamposConsistentes = 0 then
  begin
    ZQryProduto := TZQuery.Create(nil);
    with ZQryProduto do
    begin
      Connection := zcoConnection;
      SQL.Clear;
      SQL.Add('UPDATE tbproduto SET ');
      SQL.Add(' sReferencia = :sReferencia,');
      SQL.Add(' sFabricacao = :sFabricacao,');
      SQL.Add(' sDescricao = :sDescricao,');
      SQL.Add(' nCusto = :nCusto,');
      SQL.Add(' iQtdEntrada = :iQtdEntrada, ');
      SQL.Add(' iQtdSaida = :iQtdSaida,');
      SQL.Add(' sStatus = :sStatus,');
      SQL.Add(' iSubGrupo = :iSubGrupo,');
      SQL.Add(' iMarca = :iMarca,');
      SQL.Add(' iUndEntrada = :iUndEntrada,');
      SQL.Add(' iUndSaida = :iUndSaida,');
      SQL.Add(' sServico = :sServico,');
      SQL.Add(' incm = :incm');
      SQL.Add('WHERE icodigo = :icodigo');
      ParamByName('sReferencia').AsString := GetsReferencia;
      ParamByName('sFabricacao').AsString := GetsFabricacao;
      ParamByName('sDescricao').AsString  := GetsDescricao;
      ParamByName('nCusto').AsFloat       := GetnCusto;
      ParamByName('iQtdEntrada').AsInteger:= GetiQtdEntrada;
      ParamByName('iQtdSaida').AsInteger  := GetiQtdSaida;
      ParamByName('sStatus').AsString     := GetsStatus;
      ParamByName('iSubGrupo').AsInteger  := oSubGrupo.iGetCodigo;
      ParamByName('iMarca').AsInteger     := oMarca.iGetCodigo;
      ParamByName('iUndEntrada').AsInteger:= oUndEntrada.iGetCodigo;
      ParamByName('iUndSaida').AsInteger  := oUndSaida.iGetCodigo;
      ParamByName('sServico').AsString    := GetsServico;
      ParamByName('incm').AsInteger        := oNCM.GetiCodigo;
      ParamByName('iCodigo').AsInteger    := GetiCodigo;
      ExecSQL;
    end;
    FreeAndNil(ZQryProduto);
  end;
end;



procedure TProduto.CadastraProduto;
var
  ZQryProduto: TZQuery;
begin
  if iCamposConsistentes = 0 then
  begin
    ZQryProduto := TZQuery.Create(nil);
    with ZQryProduto do
    begin
      Connection := zcoConnection;
      SQL.Clear;
      SQL.Add('INSERT INTO tbproduto(');
      SQL.Add(' iCodigo,');
      SQL.Add(' sReferencia,');
      SQL.Add(' sFabricacao,');
      SQL.Add(' sDescricao,');
      SQL.Add(' nCusto,');
      SQL.Add(' iQtdEntrada, ');
      SQL.Add(' iQtdSaida,');
      SQL.Add(' sStatus,');
      SQL.Add(' iSubGrupo,');
      SQL.Add(' iMarca,');
      SQL.Add(' iUndEntrada,');
      SQL.Add(' iUndSaida,');
      SQL.Add(' iGrupo,');
      SQL.Add(' sServico,');
      SQL.Add(' incm)');
      SQL.Add('VALUES(');
      SQL.Add(' :iCodigo,');
      SQL.Add(' :sReferencia,');
      SQL.Add(' :sFabricacao,');
      SQL.Add(' :sDescricao,');
      SQL.Add(' :nCusto,');
      SQL.Add(' :iQtdEntrada, ');
      SQL.Add(' :iQtdSaida,');
      SQL.Add(' :sStatus,');
      SQL.Add(' :iSubGrupo,');
      SQL.Add(' :iMarca,');
      SQL.Add(' :iUndEntrada,');
      SQL.Add(' :iUndSaida,');
      SQL.Add(' :iGrupo, :sServico,');
      SQL.Add(' :incm)');
      ParamByName('sReferencia').AsString := GetsReferencia;
      ParamByName('sFabricacao').AsString := GetsFabricacao;
      ParamByName('sDescricao').AsString  := GetsDescricao;
      ParamByName('nCusto').AsFloat       := GetnCusto;
      ParamByName('iQtdEntrada').AsInteger:= GetiQtdEntrada;
      ParamByName('iQtdSaida').AsInteger  := GetiQtdSaida;
      ParamByName('sStatus').AsString     := 'A';
      ParamByName('iSubGrupo').AsInteger  := oSubGrupo.iGetCodigo;
      ParamByName('iMarca').AsInteger     := oMarca.iGetCodigo;
      ParamByName('iUndEntrada').AsInteger:= oUndEntrada.iGetCodigo;
      ParamByName('iUndSaida').AsInteger  := oUndSaida.iGetCodigo;
      ParamByName('iCodigo').AsInteger    := GetiCodigo;
      ParamByName('iGrupo').Asinteger     := oSubGrupo.oGrupo.iGetCodigo;
      ParamByName('sServico').AsString    := GetsServico;
      ParamByName('incm').AsInteger       := oNcm.GetiCodigo;
      try
        ExecSQL;
      except
        on E: Exception do
        begin
          TrataErro(E.Message);
          Application.MessageBox(Pchar(E.Message),'Erro',MB_OK);
        end;
      end;
    end;
    FreeAndNil(ZQryProduto);
  end;
end;

constructor TProduto.Create(pzcoConnection: TZConnection);
begin
  zcoConnection := pzcoConnection;
  oSubGrupo:= TSubGrupo.Create(pzcoConnection);
  oMarca:= TMarca.Create(pzcoConnection);
  oUndEntrada:= TUnidade.Create(pzcoConnection);
  oUndSaida:= TUnidade.Create(pzcoConnection);
  oNCM := TNCM.Create(pzcoConnection);

end;

procedure TProduto.DeletaProduto;
var
  ZQryProduto: TZQuery;
begin
  ZQryProduto := TZQuery.Create(nil);
  with ZQryProduto do
  begin
    Connection := zcoConnection;
    SQL.Clear;
    SQL.Add('UPDATE tbproduto SET sstatus = ' + QuotedStr('I') + ' ');
    SQL.Add('WHERE icodigo = :icodigo');
    ParamByName('icodigo').AsInteger   := GetiCodigo;
    ExecSQL;
  end;
  FreeAndNil(ZQryProduto);
end;

destructor TProduto.Destroy;
begin
end;

function TProduto.GetiCodigo: Integer;
begin
  Result := iCodigo;
end;

function TProduto.GetiQtdEntrada: Integer;
begin
  Result := iQtdEntrada;
end;

function TProduto.GetiQtdSaida: Integer;
begin
  Result := iQtdSaida;
end;

function TProduto.GetnCusto: Real;
begin
  Result := nCusto;
end;

function TProduto.GetsDescricao: String;
begin
  Result := sDescricao;
end;

function TProduto.GetsFabricacao: String;
begin
  Result := sFabricacao;
end;

function TProduto.GetsReferencia: String;
begin
  Result := sReferencia;
end;

function TProduto.GetsStatus: String;
begin
  Result := sStatus;
end;

function TProduto.iCamposConsistentes: Integer;
var
  iCont: SmallInt;
  slCampos: TStringList;
begin
  Result:=0;
  slCampos:=TStringList.Create;
  slCampos.CommaText:=sCamposObrigatorios('tbproduto',zcoConnection);
  for iCont:=0 to slCampos.Count - 1 do
  begin
    if AnsiLowerCase(slCampos.Strings[iCont]) = 'sdescricao' then
    begin
      if Trim(GetsDescricao) = '' then
      begin
        Result:=c_CampoVazio;
        eCampoNaoPreenchido.Create(StringReplace(asMensagemErro[c_CampoVazio],'%','Descrição',[rfReplaceAll]));
      end;
    end;
    if AnsiLowerCase(slCampos.Strings[iCont]) = 'icodigo' then
    begin
      if (IntToStr(GetiCodigo) = '') or (GetiCodigo <= 0) then
      begin
        Result:=c_CampoVazio;
        eCampoNaoPreenchido.Create(StringReplace(asMensagemErro[c_CampoVazio],'%','Código',[rfReplaceAll]));
      end;
    end;
    if AnsiLowerCase(slCampos.Strings[iCont]) = 'isubgrupo' then
    begin
      if (IntToStr(osubGrupo.iGetCodigo) = '') or (osubGrupo.iGetCodigo <= 0) then
      begin
        Result:=c_CampoVazio;
        eCampoNaoPreenchido.Create(StringReplace(asMensagemErro[c_CampoVazio],'%','SubGrupo',[rfReplaceAll]));
      end;
    end;
    if AnsiLowerCase(slCampos.Strings[iCont]) = 'igrupo' then
    begin
      if (IntToStr(osubGrupo.oGrupo.iGetCodigo) = '') or (osubGrupo.oGrupo.iGetCodigo <= 0) then
      begin
        Result:=c_CampoVazio;
        eCampoNaoPreenchido.Create(StringReplace(asMensagemErro[c_CampoVazio],'%','Grupo',[rfReplaceAll]));
      end;
    end;
  end;
end;

function TProduto.iRetornaUltimoCodigo: Integer;
var
  ZQryProduto: TZQuery;
begin
  ZQryProduto := TZQuery.Create(nil);
  with ZQryProduto do
  begin
    Connection := zcoConnection;
    SQL.Clear;
    SQL.Add('SELECT COALESCE(MAX(icodigo),0) AS ULTIMO FROM tbproduto');
    Open;
    Result := FieldByName('ULTIMO').AsInteger;
  end;
  FreeAndNil(ZQryProduto);
end;


function TProduto.bPesquisaProduto(piCodigo: Integer): Boolean;
var
  ZQryProduto: TZQuery;
begin
  ZQryProduto := TZQuery.Create(nil);
  Result:=False;
  with ZQryProduto do
  begin
    Connection := zcoConnection;
    SQL.Clear;
    SQL.Add('SELECT * FROM tbproduto WHERE icodigo = :icodigo ');
    ParamByName('icodigo').AsInteger :=piCodigo;
    Open;
    if not IsEmpty then
    begin
      Result:=True;
      SetCodigo(FieldByName('iCodigo').AsInteger);
      SetReferencia(FieldByName('sReferencia').AsString);
      SetFabricacao(FieldByName('sFabricacao').AsString);
      SetDescricao(FieldByName('sDescricao').AsString);
      SetCusto(FieldByName('nCusto').AsFloat);
      SetQtdEntrada(FieldByName('iQtdEntrada').AsInteger);
      SetQtdSaida(FieldByName('iQtdSaida').AsInteger);
      SetStatus(FieldByName('sStatus').AsString);
      SetServico(FieldByName('sServico').AsString);
      if GetsStatus = 'I' then
        if Application.MessageBox('Este Produto está Inativo! Deseja Reativar?','Reativar Produto',MB_YESNO) = IDYES then
        begin
          SetStatus('A');
          AlteraProduto;
          SetStatus('A');
        end;
      oSubGrupo.bPesquisaSubGrupo(FieldByName('iSubGrupo').AsInteger, FieldByName('iGrupo').AsInteger);
      oMarca.bPesquisaMarca(FieldByName('iMarca').AsInteger);
      oUndEntrada.bPesquisaUnidade(FieldByName('iUndEntrada').AsInteger);
      oUndSaida.bPesquisaUnidade(FieldByName('iUndSaida').AsInteger);
      SetDescricaoComMarca(GetsDescricao + ' - ' + oMarca.sGetDescricao + ' '+ GetsReferencia);
      oNCM.bPesquisaNCMCodigo(FieldByName('iNCM').AsInteger);
      bProdutoComNCM := FieldByName('iNCM').AsInteger > 0;

    end
    else
    begin
      SetReferencia('');
      SetFabricacao('');
      SetDescricao('');
      SetCusto(0);
      SetQtdEntrada(0);
      SetQtdSaida(0);
      SetStatus('');
      SetServico('N');
    end;
  end;
  FreeAndNil(ZQryProduto);
end;

procedure TProduto.SetCodigo(piCodigo: Integer);
begin
  iCodigo := piCodigo;
end;

procedure TProduto.SetCusto(pnCusto: Real);
begin
  nCusto := pnCusto;
end;

procedure TProduto.SetDescricao(psDescricao: String);
begin
  sDescricao := psDescricao;
end;

procedure TProduto.SetFabricacao(psFabricacao: String);
begin
  sFabricacao := psFabricacao;
end;

procedure TProduto.SetQtdEntrada(piQtdEntrada: Integer);
begin
  iQtdEntrada := piQtdEntrada;
end;

procedure TProduto.SetQtdSaida(piQtdSaida: Integer);
begin
  iQtdSaida := piQtdSaida;
end;

procedure TProduto.SetReferencia(psReferencia: String);
begin
  sReferencia := psReferencia;
end;

procedure TProduto.SetStatus(psStatus: String);
begin
  sStatus := psStatus;
end;

function TProduto.GetsServico: String;
begin
  Result := sServico;
end;

procedure TProduto.SetServico(psServico: String);
begin
  sServico := psServico;
end;

function TProduto.GetsDescricaoComMarca: String;
begin
  Result:= sDescricaoComMarca;
end;

procedure TProduto.SetDescricaoComMarca(psDescricao: String);
begin
  sDescricaoComMarca := psDescricao;
end;

function TProduto.GetProdutoTemNCM: Boolean;
begin
   Result := bProdutoComNCM;
end;

end.
