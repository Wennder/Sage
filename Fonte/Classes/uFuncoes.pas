unit uFuncoes;

interface

uses SQLMemMain;

function Iif(Condicao: Boolean; Verdadeiro, Falso: Variant): Variant;
procedure InicializaSqlMemTable(SQLMemTable: TSQLMemTable; DeletaRegistros: Boolean = false);

implementation

function Iif(Condicao: Boolean; Verdadeiro, Falso: Variant): Variant;
begin
  if Condicao then
    Result := Verdadeiro
  else
    Result := false;
end;

procedure InicializaSqlMemTable(SQLMemTable: TSQLMemTable; DeletaRegistros: Boolean = false);
var
  C: Integer;
begin
  if (SQLMemTable.Active) and (DeletaRegistros) then
    if not SQLMemTable.IsEmpty then
    begin
      with SQLMemTable do
      begin
        First;
        while not IsEmpty do
        begin
          Delete;
        end;
      end;
    end;
  try
    if SQLMemTable.Exists then
    begin
      SQLMemTable.Close;
      SQLMemTable.DeleteTable(True);
    end;
  except
  end;
  SQLMemTable.CreateTable;
  SQLMemTable.Open;
end;

end.
