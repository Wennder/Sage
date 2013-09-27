unit uStrings;

interface

uses
sysUtils;

function Desmascara(Conteudo: String): String;
Function SubstituiString(Texto,TextoASubstituir,NovoTexto : String) : String;
implementation


function Desmascara(Conteudo: String): String;
var
	 C: ShortInt;
begin
	 for C := 1 to length(Conteudo) do begin
			if not (Conteudo[C] in ['0'..'9']) then begin
				 Delete(Conteudo,C,1);
				 Conteudo := ' ' + Conteudo;
			end;
	 end;
	 Result := Trim(Conteudo);
end;

Function SubstituiString(Texto,TextoASubstituir,NovoTexto : String) : String;
begin
     Result := StringReplace(Texto,TextoASubstituir,NovoTexto,[rfReplaceAll]);
end;



end.
