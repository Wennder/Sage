unit uRelContagemInventario;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uRelGenerico, cxGraphics, cxLookAndFeels, UsoGeral, uPesquisaGeral,
  cxLookAndFeelPainters, Vcl.Menus, Data.DB, ZAbstractRODataset, ZAbstractDataset, ZDataset, ppDB,
  ppDBPipe, ppParameter, ppDesignLayer, ppBands, ppVar, ppCtrls, dxGDIPlusClasses, ppPrnabl,
  ppClass, ppCache, ppComm, ppRelatv, ppProd, ppReport, Vcl.StdCtrls, cxButtons, Vcl.ExtCtrls,
  JvExControls, JvNavigationPane, cxControls, cxContainer, cxEdit, cxLabel, cxTextEdit, uPrincipal,
  Vcl.ComCtrls, dxCore, cxDateUtils, cxDropDownEdit, cxImageComboBox, cxMaskEdit, cxCalendar, uInventario;

type
  TfrmRelContagemInventario = class(TfrmRelGenerico)
    qrRelatorioicodigo: TIntegerField;
    qrRelatorioiinventario: TIntegerField;
    qrRelatorioddataoperacao: TDateTimeField;
    qrRelatoriosstatus: TWideStringField;
    qrRelatorionmstatus: TWideStringField;
    qrRelatorioidusuariocad: TIntegerField;
    qrRelatorioidusuarioultalt: TIntegerField;
    qrRelatoriodatahoraultalt: TDateTimeField;
    qrRelatorioiproduto: TIntegerField;
    qrRelatoriosreferencia: TWideStringField;
    qrRelatoriosfabricacao: TWideStringField;
    qrRelatorionmproduto: TWideStringField;
    qrRelatorionmprodutocommarca: TWideMemoField;
    qrRelatorioisubgrupo: TIntegerField;
    qrRelatorionmsubgrupo: TWideStringField;
    qrRelatorioigrupo: TIntegerField;
    qrRelatorionmgrupo: TWideStringField;
    qrRelatorioimarca: TIntegerField;
    qrRelatorionmmarca: TWideStringField;
    qrRelatorionqtdcontada: TFloatField;
    qrRelatoriondiferenca: TFloatField;
    ppLine1: TppLine;
    ppLabel1: TppLabel;
    ppLabel2: TppLabel;
    ppLabel3: TppLabel;
    ppDBText1: TppDBText;
    ppDBText2: TppDBText;
    ppDBText3: TppDBText;
    ppGroup1: TppGroup;
    ppGroupHeaderBand1: TppGroupHeaderBand;
    ppGroupFooterBand1: TppGroupFooterBand;
    ppLabel4: TppLabel;
    ppLabel5: TppLabel;
    ppLabel7: TppLabel;
    ppDBText4: TppDBText;
    qrRelatorioddatafechamento: TDateTimeField;
    ppDBText5: TppDBText;
    ppDBText6: TppDBText;
    ppShape1: TppShape;
    edtInventario: TcxTextEdit;
    lbCod: TcxLabel;
    lbDtOperacao: TcxLabel;
    edtDataOperacao: TcxDateEdit;
    edtStatus: TcxImageComboBox;
    lbStatus: TcxLabel;
    edtDataFechamento: TcxDateEdit;
    cxLabel1: TcxLabel;
    procedure btnImprimirClick(Sender: TObject);
    procedure edtInventarioKeyPress(Sender: TObject; var Key: Char);
    procedure edtInventarioKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edtInventarioExit(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    oInventario: TInventario;
  public
    { Public declarations }
  end;

var
  frmRelContagemInventario: TfrmRelContagemInventario;

implementation

{$R *.dfm}

procedure TfrmRelContagemInventario.btnImprimirClick(Sender: TObject);
begin
  inherited;
  if edtStatus.EditValue <> 'F' then
  begin
    pMsgAtencao('Este inventario ainda não foi fechado. Para realizar a análise é preciso que o inventário seja fechado.');
    edtInventario.SetFocus;
    Abort;
  end;
  with qrRelatorio do
  begin
    Close;
    if Trim(edtInventario.text) <> '' then
      ParamByName('iinventario').Value := edtInventario.text;
    Open;
    if isEmpty then
    begin
      pMsgAtencao('Não há registros de inventario para exibição.');
      edtInventario.SetFocus;
      Abort;
    end;
    ppRelatorio.Print;
  end;
end;

procedure TfrmRelContagemInventario.edtInventarioExit(Sender: TObject);
Var
  Query: TZQuery;
begin
  inherited;
  if Trim(edtInventario.text) = '' then
    Exit;

  with oInventario do
  begin
    if not(ConsultaInventario(StrToInt(edtInventario.text))) then
    begin
      pMsgAtencao('Código do Inventário não encontrado!');
      edtInventario.SetFocus;
      Abort;
    end
    else
    begin
      edtStatus.EditValue := Getsstatus;
      edtDataOperacao.text := Getddataoperacao;
      edtDataFechamento.text := Getdatafechamento;
    end;
  end;
end;

procedure TfrmRelContagemInventario.edtInventarioKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
Var
  Resultado: TResultArray;
begin
  inherited;
  if Key = vk_F2 then
  begin
    Resultado := ChamaPesquisa(TEdit(Sender), frmPrincipal.zcoConexaoBanco);
    SetLength(Resultado, Length(Resultado));

    edtInventario.text := Resultado[0];
    edtStatus.EditValue := Resultado[1];
    edtDataOperacao.text := Resultado[2];
    edtDataFechamento.text := Resultado[3];

    Perform(WM_NEXTDLGCTL, 0, 0);
  end;
end;

procedure TfrmRelContagemInventario.edtInventarioKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  pKeyPressNumerico(Key);
end;

procedure TfrmRelContagemInventario.FormShow(Sender: TObject);
begin
  inherited;
  oInventario := TInventario.Create(frmPrincipal.zcoConexaoBanco);
end;

end.
