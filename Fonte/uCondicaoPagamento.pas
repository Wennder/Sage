unit uCondicaoPagamento;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uCadastroGenerico, JvXPCore, JvXPButtons, JvExControls,
  JvComponent, JvGradient, JvNavigationPane, StdCtrls, cxGraphics, cxLookAndFeels,
  cxLookAndFeelPainters, Vcl.Menus, dxSkinsCore, dxSkinOffice2010Silver, cxButtons, Vcl.ExtCtrls,
  cxControls, cxContainer, cxEdit, cxTextEdit, cxMaskEdit, cxDropDownEdit;

type
  TfrmFormaRecebimento = class(TfrmCadastroGenerico)
    Label2: TLabel;
    Label3: TLabel;
    ComboBoxFormaRecebimento: TcxComboBox;
    ComboBoxBandeira: TcxComboBox;
    procedure ComboBoxFormaRecebimentoChange(Sender: TObject);
    procedure btnGravaClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmFormaRecebimento: TfrmFormaRecebimento;

implementation

Uses UsoGeral;

{$R *.dfm}

procedure TfrmFormaRecebimento.btnGravaClick(Sender: TObject);
begin
  inherited;
  if Trim(ComboBoxFormaRecebimento.Text) = '' then
  begin
    pMsgAtencao('Forma de Recebimento não pode ser vazio.');
    ComboBoxFormaRecebimento.SetFocus;
    Abort;
  end;

  if ComboBoxFormaRecebimento.ItemIndex in [1, 2] then
  begin
    if Trim(ComboBoxBandeira.Text) = '' then
    begin
      pMsgAtencao('A Bandeira do Cartão não pode ser vazio.');
      ComboBoxBandeira.SetFocus;
      Abort;
    end;
  end;
end;

procedure TfrmFormaRecebimento.ComboBoxFormaRecebimentoChange(Sender: TObject);
begin
  inherited;
  if ComboBoxFormaRecebimento.ItemIndex in [1, 2] then
  begin
    ComboBoxBandeira.Enabled := True;
    ComboBoxBandeira.ItemIndex := 0;
  end
  else
    ComboBoxBandeira.Enabled := False;
end;

end.
