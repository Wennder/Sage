unit uCancelaOrcamento;

interface

uses Sysutils, ZConnection;

procedure CancelaOrcamento(iPedido: Integer; pzcoConnection: TZConnection);

implementation

uses uPedido;

procedure CancelaOrcamento(iPedido: Integer; pzcoConnection: TZConnection);
var
  oPedido: TPedido;
begin
  try
    oPedido := TPedido.Create(pzcoConnection);
    oPedido.SetCodigo(iPedido);
    oPedido.CancelaPedido;
  finally
    FreeandNil(oPedido);
  end;
end;

end.
