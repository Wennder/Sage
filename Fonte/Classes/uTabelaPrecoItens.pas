unit uTabelaPrecoItens;

interface

uses ZConnection, ZDataset, SysUtils, uConstantes, Classes, uProcedimentosBanco, uExceptions, Variants, Forms,
  Dialogs, Windows, uTabelaPreco, uProduto;

type
  TTabelaPrecoItens = class
  public
    oTabelaPreco: TTabelaPreco;
    oProduto: TProduto;

    constructor Create(pzcoConnection: TZConnection);
    destructor Destroy; override;

    procedure CadastraTabelaPrecoItens;
    procedure AlteraTabelaPrecoItens;
    procedure DeletaTabelaPrecoItens;
    function bPesquisaTabelaPrecoItens(piTabela, piProduto: Integer): Boolean;
    function bPesquisaTabelaPrecoItensCodigo(piCodigo: Integer): Boolean;
    function iRetornaUltimoCodigo: Integer;

    function iGetCodigo: Integer;
    function nGetPreco: Real;
    function sGetStatus: string;

    procedure SetCodigo(piCodigo: Integer);
    procedure SetStatus(psStatus: string);
    procedure SetPreco(pnPreco: Real);

  private
    iCodigo: Integer;
    nPreco: Real;
    sStatus: string;
    zcoConnection: TZConnection;
    function iCamposConsistentes: Integer;
  end;

implementation

{ TTabelaPrecoItens }

procedure TTabelaPrecoItens.AlteraTabelaPrecoItens;
var
  ZQryTabelaPrecoItens: TZQuery;
begin
  if iCamposConsistentes = 0 then
  begin
    ZQryTabelaPrecoItens := TZQuery.Create(nil);
    with ZQryTabelaPrecoItens do
    begin
      Connection := zcoConnection;
      SQL.Clear;
      SQL.Add('UPDATE tbTabelaPrecoItens SET npreco = :npreco, sstatus = :sstatus');
      SQL.Add('WHERE icodigo = :icodigo');
      ParamByName('npreco').AsFloat := nPreco;
      ParamByName('icodigo').AsInteger := iCodigo;
      ParamByName('sstatus').AsString := sStatus;
      ExecSQL;
    end;
    FreeAndNil(ZQryTabelaPrecoItens);
  end;
end;

function TTabelaPrecoItens.bPesquisaTabelaPrecoItens(piTabela, piProduto: Integer): Boolean;
var
  ZQryTabelaPrecoItens: TZQuery;
begin
  ZQryTabelaPrecoItens := TZQuery.Create(nil);
  Result := False;
  with ZQryTabelaPrecoItens do
  begin
    Connection := zcoConnection;
    SQL.Clear;
    SQL.Add('SELECT * FROM tbTabelaPrecoItens WHERE itabela = :itabela and iproduto = :iproduto');
    ParamByName('itabela').AsInteger := piTabela;
    ParamByName('iproduto').AsInteger := piProduto;
    Open;
    if not IsEmpty then
    begin
      Result := True;
      SetCodigo(FieldByName('icodigo').AsInteger);
      oTabelaPreco.bPesquisaTabelaPreco(FieldByName('itabela').AsInteger);
      oProduto.bPesquisaProduto(FieldByName('iproduto').AsInteger);
      SetPreco(FieldByName('npreco').AsFloat);
      SetStatus(FieldByName('sstatus').AsString);
      if sGetStatus = 'I' then
        if Application.MessageBox('Esta composição de preços está Inativa! Deseja Reativar?', 'Reativar composição de preços', MB_YESNO) = IDYES then
        begin
          SetStatus('A');
          AlteraTabelaPrecoItens;
          SetStatus('A');
        end;
    end
    else
    begin
      SetCodigo(0);
      SetPreco(0);
      oTabelaPreco.SetCodigo(0);
      oProduto.SetCodigo(0);
      oTabelaPreco.bPesquisaTabelaPreco(0);
    end;
  end;
  FreeAndNil(ZQryTabelaPrecoItens);
end;

function TTabelaPrecoItens.bPesquisaTabelaPrecoItensCodigo(piCodigo: Integer): Boolean;
var
  ZQryTabelaPrecoItens: TZQuery;
begin
  ZQryTabelaPrecoItens := TZQuery.Create(nil);
  Result := False;
  with ZQryTabelaPrecoItens do
  begin
    Connection := zcoConnection;
    SQL.Clear;
    SQL.Add('SELECT * FROM tbTabelaPrecoItens WHERE icodigo = :icodigo');
    ParamByName('icodigo').AsInteger := piCodigo;
    Open;
    if not IsEmpty then
    begin
      Result := True;
      SetCodigo(FieldByName('icodigo').AsInteger);
      oTabelaPreco.bPesquisaTabelaPreco(FieldByName('itabela').AsInteger);
      oProduto.bPesquisaProduto(FieldByName('iproduto').AsInteger);
      SetPreco(FieldByName('npreco').AsFloat);
      SetStatus(FieldByName('sstatus').AsString);
      if sGetStatus = 'I' then
        if Application.MessageBox('Esta composição de preços está Inativa! Deseja Reativar?', 'Reativar composição de preços', MB_YESNO) = IDYES then
        begin
          SetStatus('A');
          AlteraTabelaPrecoItens;
          SetStatus('A');
        end;
    end
    else
    begin
      SetCodigo(0);
      SetPreco(0);
      oTabelaPreco.SetCodigo(0);
      oProduto.SetCodigo(0);
    end;
  end;
  FreeAndNil(ZQryTabelaPrecoItens);
end;

procedure TTabelaPrecoItens.CadastraTabelaPrecoItens;
var
  ZQryTabelaPrecoItens: TZQuery;
begin
  if iCamposConsistentes = 0 then
  begin
    ZQryTabelaPrecoItens := TZQuery.Create(nil);
    with ZQryTabelaPrecoItens do
    begin
      Connection := zcoConnection;
      SQL.Clear;
      SQL.Add('INSERT INTO tbTabelaPrecoItens(icodigo, itabela, iproduto, npreco)');
      SQL.Add('VALUES(:icodigo, :itabela, :iproduto, :npreco)');
      ParamByName('icodigo').AsInteger := iGetCodigo;
      ParamByName('itabela').AsInteger := oTabelaPreco.iGetCodigo;
      ParamByName('iproduto').AsInteger := oProduto.GetiCodigo;
      ParamByName('npreco').AsFloat := nGetPreco;
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
    FreeAndNil(ZQryTabelaPrecoItens);
  end;
end;

constructor TTabelaPrecoItens.Create(pzcoConnection: TZConnection);
begin
  inherited Create;
  zcoConnection := pzcoConnection;
  oTabelaPreco := TTabelaPreco.Create(pzcoConnection);
  oProduto := TProduto.Create(pzcoConnection);
end;

procedure TTabelaPrecoItens.DeletaTabelaPrecoItens;
var
  ZQryTabelaPrecoItens: TZQuery;
begin
  ZQryTabelaPrecoItens := TZQuery.Create(nil);
  with ZQryTabelaPrecoItens do
  begin
    Connection := zcoConnection;
    SQL.Clear;
    SQL.Add('UPDATE tbTabelaPrecoItens SET sstatus = ' + QuotedStr('I') + ' ');
    SQL.Add('WHERE icodigo = :icodigo');
    ParamByName('icodigo').AsInteger := iGetCodigo;
    ExecSQL;
  end;
  FreeAndNil(ZQryTabelaPrecoItens);
end;

destructor TTabelaPrecoItens.Destroy;
begin
  FreeAndNil(oTabelaPreco);
  FreeAndNil(oProduto);
  inherited;
end;

function TTabelaPrecoItens.iCamposConsistentes: Integer;
var
  iCont: SmallInt;
  slCampos: TStringList;
begin
  Result := 0;
  slCampos := TStringList.Create;
  slCampos.CommaText := sCamposObrigatorios('tbtabelaprecoitens', zcoConnection);

  for iCont := 0 to slCampos.Count - 1 do
  begin
    if AnsiLowerCase(slCampos.Strings[iCont]) = 'npreco' then
    begin
      if (nGetPreco = 0) then
      begin
        Result := c_CampoVazio;
        eCampoNaoPreenchido.Create(StringReplace(asMensagemErro[c_CampoVazio], '%', 'Preço', [rfReplaceAll]));
      end;
    end;
    if AnsiLowerCase(slCampos.Strings[iCont]) = 'icodigo' then
    begin
      if (IntToStr(iGetCodigo) = '') or (iGetCodigo <= 0) then
      begin
        Result := c_CampoVazio;
        eCampoNaoPreenchido.Create(StringReplace(asMensagemErro[c_CampoVazio], '%', 'Código', [rfReplaceAll]));
      end;
    end;
    if AnsiLowerCase(slCampos.Strings[iCont]) = 'itabela' then
    begin
      if (IntToStr(oTabelaPreco.iGetCodigo) = '') or (oTabelaPreco.iGetCodigo <= 0) then
      begin
        Result := c_CampoVazio;
        eCampoNaoPreenchido.Create(StringReplace(asMensagemErro[c_CampoVazio], '%', 'Tabela', [rfReplaceAll]));
      end;
    end;
    if AnsiLowerCase(slCampos.Strings[iCont]) = 'iproduto' then
    begin
      if (IntToStr(oProduto.GetiCodigo) = '') or (oProduto.GetiCodigo <= 0) then
      begin
        Result := c_CampoVazio;
        eCampoNaoPreenchido.Create(StringReplace(asMensagemErro[c_CampoVazio], '%', 'Produto', [rfReplaceAll]));
      end;
    end;
  end;
end;

function TTabelaPrecoItens.iGetCodigo: Integer;
begin
  Result := iCodigo;
end;

function TTabelaPrecoItens.iRetornaUltimoCodigo: Integer;
var
  ZQryTabelaPrecoItens: TZQuery;
begin
  ZQryTabelaPrecoItens := TZQuery.Create(nil);
  with ZQryTabelaPrecoItens do
  begin
    Connection := zcoConnection;
    SQL.Clear;
    SQL.Add('SELECT COALESCE(MAX(icodigo),0) AS ULTIMO FROM tbTabelaPrecoItens');
    Open;
    Result := FieldByName('ULTIMO').AsInteger;
  end;
  FreeAndNil(ZQryTabelaPrecoItens);
end;

function TTabelaPrecoItens.nGetPreco: Real;
begin
  Result := nPreco;
end;

procedure TTabelaPrecoItens.SetCodigo(piCodigo: Integer);
begin
  iCodigo := piCodigo;
end;

procedure TTabelaPrecoItens.SetPreco(pnPreco: Real);
begin
  nPreco := pnPreco;
end;

procedure TTabelaPrecoItens.SetStatus(psStatus: string);
begin
  sStatus := psStatus;
end;

function TTabelaPrecoItens.sGetStatus: string;
begin
  Result := sStatus;
end;

end.
