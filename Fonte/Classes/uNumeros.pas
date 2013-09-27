unit uNumeros;

interface

uses SysUtils;

function bFloatValido(psValor: String): Boolean;
function bInteiroValido(psValor: String): Boolean;

implementation

function bFloatValido(psValor: String): Boolean;
begin
  Result:=False;
  try
    StrToFloat(psValor);
    Result:=True;
  except
  end;
end;

function bInteiroValido(psValor: String): Boolean;
begin
  Result:=False;
  try
    StrToInt(psValor);
    Result:=True;
  except
  end;
end;

end.

