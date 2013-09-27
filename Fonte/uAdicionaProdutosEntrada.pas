unit uAdicionaProdutosEntrada;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uCadastroGenerico, JvExStdCtrls, JvEdit, JvValidateEdit,
  StdCtrls, ExtCtrls, JvXPCore, JvXPButtons, JvExControls, JvComponent, JvNavigationPane,
  cxGraphics, cxLookAndFeels, cxLookAndFeelPainters, Menus, cxButtons,
  cxControls, cxContainer, cxEdit, cxLabel;

type
  TfrmEntradaItens = class(TfrmCadastroGenerico)
    edtProduto: TEdit;
    stProduto: TStaticText;
    edtPreco: TJvValidateEdit;
    edtQuantidade: TJvValidateEdit;
    stUnidade: TStaticText;
    lblProduto: TcxLabel;
    lblPreco: TcxLabel;
    Label1: TcxLabel;
    Label2: TcxLabel;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmEntradaItens: TfrmEntradaItens;

implementation

{$R *.dfm}

end.
