unit uGrupoUsuario;

interface

uses ZConnection, ZDataset, SysUtils, uConstantes, Classes, uProcedimentosBanco,
  uExceptions, Variants, Forms, Dialogs, Windows, usogeral;

type

  TGrupoUsuario = class
  public
    procedure SetCodigo(piCodigo: Integer);
    procedure SetNome(psNome: string);
    procedure SetStatus(psStatus: string);

    function GetiCodigo: Integer;
    function GetsNome: string;
    function GetsStatus: string;

    function iRetornaUltimoCodigo: Integer;
    constructor Create(pzcoConnection: TZConnection);
    destructor Destroy; override;
    procedure CadastraGrupoUsuario;
    procedure AlteraGrupoUsuario;
    procedure DeletaGrupoUsuario;
    function bPesquisaGrupoUsuario(piCodigo: Integer): Boolean;
  private
    zcoConnection: TZConnection;
    iCodigo: Integer;
    sNome: string;
    sStatus: string;
  end;

implementation

{ TGrupoUsuario }

procedure TGrupoUsuario.AlteraGrupoUsuario;
var
  ZQryUsuario: TZQuery;
begin
  ZQryUsuario := TZQuery.Create(nil);
  with ZQryUsuario do
  begin
    Connection := zcoConnection;
    SQL.Clear;
    SQL.Add('UPDATE tbgrupousuario SET ');
    SQL.Add(' snome = :ssnome,');
    SQL.Add(' sstatus = :sstatus');
    SQL.Add('WHERE icodigo = :icodigo');
    ParamByName('ssnome').AsString := GetsNome;
    ParamByName('sstatus').AsString := GetsStatus;
    ParamByName('iCodigo').AsInteger := GetiCodigo;
    ExecSQL;
  end;
  FreeAndNil(ZQryUsuario);
end;

function TGrupoUsuario.bPesquisaGrupoUsuario(piCodigo: Integer): Boolean;
var
  ZQryUsuario: TZQuery;
begin
  ZQryUsuario := TZQuery.Create(nil);
  Result := False;
  with ZQryUsuario do
  begin
    Connection := zcoConnection;
    SQL.Clear;
    SQL.Add('SELECT * FROM tbgrupousuario WHERE icodigo = :icodigo and icodigo > 0');
    ParamByName('icodigo').AsInteger := piCodigo;
    Open;
    if not IsEmpty then
    begin
      Result := True;
      SetCodigo(FieldByName('iCodigo').AsInteger);
      SetNome(FieldByName('sNome').AsString);
      SetStatus(FieldByName('sStatus').AsString);
      if GetsStatus = 'I' then
        if fPergunta('Este Grupo de Usuário está Inativo! Deseja Reativar?') then
        begin
          SetStatus('A');
          AlteraGrupoUsuario;
          SetStatus('A');
        end;
    end
    else
    begin
      SetNome('');
      SetStatus('');
    end;
  end;
  FreeAndNil(ZQryUsuario);
end;

procedure TGrupoUsuario.CadastraGrupoUsuario;
var
  ZQryUsuario: TZQuery;
begin
  ZQryUsuario := TZQuery.Create(nil);
  with ZQryUsuario do
  begin
    Connection := zcoConnection;
    SQL.Clear;
    SQL.Add('INSERT INTO tbgrupousuario(');
    SQL.Add(' iCodigo,');
    SQL.Add(' snome)');
    SQL.Add('VALUES(');
    SQL.Add(' :iCodigo,');
    SQL.Add(' :sNome)');
    ParamByName('iCodigo').AsInteger := GetiCodigo;
    ParamByName('sNome').AsString := GetsNome;
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
  FreeAndNil(ZQryUsuario);
end;

constructor TGrupoUsuario.Create(pzcoConnection: TZConnection);
begin
  zcoConnection := pzcoConnection;
end;

procedure TGrupoUsuario.DeletaGrupoUsuario;
var
  ZQryUsuario: TZQuery;
begin
  ZQryUsuario := TZQuery.Create(nil);
  with ZQryUsuario do
  begin
    Connection := zcoConnection;
    if fPergunta('Todos os usuários vinculados a este grupo também serão inativados.' + #13 + 'Deseja prosseguir com a exclusão?') then
    begin
      SQL.Clear;
      SQL.Add('UPDATE tbusuario SET sstatus = ' + QuotedStr('I') + ' ');
      SQL.Add('WHERE igrupousuario = :icodigo');
      ParamByName('icodigo').AsInteger := GetiCodigo;
      ExecSQL;

      SQL.Clear;
      SQL.Add('UPDATE tbgrupousuario SET sstatus = ' + QuotedStr('I') + ' ');
      SQL.Add('WHERE icodigo = :icodigo');
      ParamByName('icodigo').AsInteger := GetiCodigo;
      ExecSQL;
    end
    else
      Abort;
  end;
  FreeAndNil(ZQryUsuario);
end;

destructor TGrupoUsuario.Destroy;
begin

  inherited;
end;

function TGrupoUsuario.GetiCodigo: Integer;
begin
  Result := iCodigo;
end;

function TGrupoUsuario.GetsNome: string;
begin
  Result := sNome;
end;

function TGrupoUsuario.GetsStatus: string;
begin
  Result := sStatus;
end;

function TGrupoUsuario.iRetornaUltimoCodigo: Integer;
var
  ZQryUsuario: TZQuery;
begin
  ZQryUsuario := TZQuery.Create(nil);
  with ZQryUsuario do
  begin
    Connection := zcoConnection;
    SQL.Clear;
    SQL.Add('SELECT COALESCE(MAX(icodigo),0) AS ULTIMO FROM tbgrupousuario');
    Open;
    Result := FieldByName('ULTIMO').AsInteger;
  end;
  FreeAndNil(ZQryUsuario);
end;

procedure TGrupoUsuario.SetCodigo(piCodigo: Integer);
begin
  iCodigo := piCodigo;
end;

procedure TGrupoUsuario.SetNome(psNome: string);
begin
  sNome := psNome;
end;

procedure TGrupoUsuario.SetStatus(psStatus: string);
begin
  sStatus := psStatus;
end;

end.
