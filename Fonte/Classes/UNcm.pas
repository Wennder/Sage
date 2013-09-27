unit UNcm;

interface

uses ZConnection, ZDataset, SysUtils, uConstantes, Classes, uProcedimentosBanco, uExceptions, Variants, Forms,
  Dialogs, Windows, uCliente, JvMemoryDataset;

type
  TNCM = class
  public

    procedure SetCodigo(piCodigo: Integer);
    procedure SetDescricao(psDescricao: string);
    procedure SetsStatus(psStatus: string);

    function GetiCodigo: Integer;
    function GetsDescricao: string;
    function GetsStatus: string;

    function iRetornaUltimoCodigo: Integer;
    constructor Create(pzcoConnection: TZConnection);
    destructor Destroy; override;
    procedure CadastraNCM;
    procedure AlteraNCM;
    procedure DeletaNCM;
    function bPesquisaNCMCodigo(piCodigo: Integer): Boolean;

  private
    iCodigo: Integer;
    sDescricao: string;
    sStatus: string;
    zcoConnection: TZConnection;
    function iCamposConsistentes: Integer;
  end;

implementation

{ TNCM }

procedure TNCM.AlteraNCM;
var
  ZQryNCM: TZQuery;
begin
  if iCamposConsistentes = 0 then
  begin
    ZQryNCM := TZQuery.Create(nil);
    with ZQryNCM do
    begin
      Connection := zcoConnection;
      SQL.Clear;
      SQL.Add('UPDATE tbncm SET ');
      SQL.Add(' sdescricao = :sdescricao');
      SQL.Add('WHERE icodigo = :icodigo');
      ParamByName('sdescricao').AsString := GetsDescricao;
      ParamByName('iCodigo').AsInteger := GetiCodigo;
      ExecSQL;
    end;
    FreeAndNil(ZQryNCM);
  end;
end;

procedure TNCM.CadastraNCM;
var
  ZQryNCM: TZQuery;
begin
  if iCamposConsistentes = 0 then
  begin
    ZQryNCM := TZQuery.Create(nil);
    with ZQryNCM do
    begin
      Connection := zcoConnection;
      SQL.Clear;
      SQL.Add('INSERT INTO tbncm(');
      SQL.Add(' iCodigo,');
      SQL.Add(' sdescricao)');
      SQL.Add('VALUES(');
      SQL.Add(' :iCodigo,');
      SQL.Add(' :sdescricao)');
      ParamByName('sDescricao').AsString := GetsDescricao;
      ParamByName('icodigo').AsInteger := GetiCodigo;
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
    FreeAndNil(ZQryNCM);
  end;
end;

constructor TNCM.Create(pzcoConnection: TZConnection);
begin
  zcoConnection := pzcoConnection;
end;

procedure TNCM.DeletaNCM;
var
  ZQryNCM: TZQuery;
begin
  ZQryNCM := TZQuery.Create(nil);
  with ZQryNCM do
  begin
    Connection := zcoConnection;
    SQL.Clear;
    SQL.Add('UPDATE tbNCM SET sstatus = ' + QuotedStr('I') + ' ');
    SQL.Add('WHERE icodigo = :icodigo');
    ParamByName('icodigo').AsInteger := GetiCodigo;
    ExecSQL;
  end;
  FreeAndNil(ZQryNCM);
end;

destructor TNCM.Destroy;
begin
  inherited;
end;

function TNCM.GetiCodigo: Integer;
begin
  Result := iCodigo;
end;

function TNCM.GetsDescricao: string;
begin
  Result := sDescricao;
end;

function TNCM.iCamposConsistentes: Integer;
var
  iCont: SmallInt;
  slCampos: TStringList;
begin
  Result := 0;
  slCampos := TStringList.Create;
  slCampos.CommaText := sCamposObrigatorios('tbncm', zcoConnection);
  for iCont := 0 to slCampos.Count - 1 do
  begin
    if AnsiLowerCase(slCampos.Strings[iCont]) = 'sdescricao' then
    begin
      if Trim(GetsDescricao) = '' then
      begin
        Result := c_CampoVazio;
        eCampoNaoPreenchido.Create(StringReplace(asMensagemErro[c_CampoVazio], '%', 'Descrição', [rfReplaceAll]));
      end;
    end;
    if AnsiLowerCase(slCampos.Strings[iCont]) = 'icodigo' then
    begin
      if (IntToStr(GetiCodigo) = '') or (GetiCodigo <= 0) then
      begin
        Result := c_CampoVazio;
        eCampoNaoPreenchido.Create(StringReplace(asMensagemErro[c_CampoVazio], '%', 'Código', [rfReplaceAll]));
      end;
    end;
  end;
end;

function TNCM.iRetornaUltimoCodigo: Integer;
var
  ZQryNCM: TZQuery;
begin
  ZQryNCM := TZQuery.Create(nil);
  with ZQryNCM do
  begin
    Connection := zcoConnection;
    SQL.Clear;
    SQL.Add('SELECT COALESCE(MAX(icodigo),0) AS ULTIMO FROM tbNCM');
    Open;
    Result := FieldByName('ULTIMO').AsInteger;
  end;
  FreeAndNil(ZQryNCM);
end;

procedure TNCM.SetCodigo(piCodigo: Integer);
begin
  iCodigo := piCodigo;
end;

procedure TNCM.SetDescricao(psDescricao: string);
begin
  sDescricao := psDescricao;
end;

function TNCM.bPesquisaNCMCodigo(piCodigo: Integer): Boolean;
var
  ZQryNCM: TZQuery;
begin
  Result := False;
  if piCodigo <> 0 then
  begin
    ZQryNCM := TZQuery.Create(nil);
    with ZQryNCM do
    begin
      Connection := zcoConnection;
      SQL.Clear;
      SQL.Add('SELECT * FROM tbncm WHERE icodigo = :icodigo');
      ParamByName('icodigo').AsInteger := piCodigo;
      Open;
      if not IsEmpty then
      begin
        Result := True;
        SetCodigo(FieldByName('icodigo').AsInteger);
        SetDescricao(FieldByName('sdescricao').AsString);
        SetsStatus(FieldByName('sstatus').AsString);

        if GetsStatus = 'I' then
          if Application.MessageBox('Esta NCM está Inativo! Deseja Reativar?', 'Reativar NCM', MB_YESNO) = IDYES then
          begin
            SetsStatus('A');
            AlteraNCM;
          end;
      end
      else
      begin
        SetCodigo(0);
        SetDescricao('');
        SetsStatus('');
      end;
    end;
    FreeAndNil(ZQryNCM);
  end;
end;

function TNCM.GetsStatus: string;
begin
  Result := sStatus;
end;

procedure TNCM.SetsStatus(psStatus: string);
begin
  sStatus := psStatus;
end;

end.
