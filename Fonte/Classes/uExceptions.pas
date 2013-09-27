unit uExceptions;

interface

uses SysUtils, uConstantes;

type
 eCampoNaoPreenchido = class(Exception);
 eViolacaoDeChave = class(Exception);
 eDataMenorAtual = class(Exception);

var
 asMensagemErro: array [1..4] of String;

procedure TrataErro(sMensagem: String);

implementation

procedure TrataErro(sMensagem: String);
begin
  if Pos('duplicate key',AnsiLowerCase(sMensagem)) > 0 then
  begin
    raise eViolacaoDeChave.Create(StringReplace(asMensagemErro[c_ViolacaoChave],'%','Código',[rfReplaceAll]));
  end;
end;

initialization

asMensagemErro[1]:='Campo % não pode estar Vazio!';
asMensagemErro[2]:='O Campo % está em um Formato Inválido!';
asMensagemErro[3]:='Houve uma Violação de Chave!';
asMensagemErro[4]:='O Campo % está com data menor que a atual!';

end.

