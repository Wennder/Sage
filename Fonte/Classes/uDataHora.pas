unit uDataHora;

interface

uses SysUtils;

function bDataValida(psData: String): Boolean;

implementation

function bDataValida(psData: String): Boolean;
begin
  Result:=False;
  try
    StrToDate(psData);
    Result:=True;
  except
    raise Exception.Create('Data Invalida');
  end;
end;

end.
