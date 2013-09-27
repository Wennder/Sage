unit uRelListagemPrecos;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uCadastroGenerico, StdCtrls, JvXPCore, JvXPButtons,
  JvExControls, JvComponent, JvNavigationPane, ppDB, ppDBPipe,
  ppCtrls, ppBands, ppVar, ppPrnabl, ppClass, ppCache, ppComm, ppRelatv,
  ppProd, ppReport, DB, ZAbstractRODataset, ZAbstractDataset, ZDataset,
  ZConnection, uTabelaPreco, ppParameter, cxGraphics, cxLookAndFeels,
  cxLookAndFeelPainters, Menus, cxButtons, ExtCtrls, cxControls, cxContainer,
  cxEdit, cxTextEdit, cxLabel, UsoGeral, dxGDIPlusClasses, ppDesignLayer;

type
  TfrmListagemPrecos = class(TfrmCadastroGenerico)
    stTabela: TStaticText;
    dsListagem: TDataSource;
    Report: TppReport;
    ppHeaderBand1: TppHeaderBand;
    ppLabel1: TppLabel;
    ppLabel2: TppLabel;
    ppLabel4: TppLabel;
    ppLine1: TppLine;
    LabelTitulo: TppLabel;
    ppDetailBand1: TppDetailBand;
    ppDBText1: TppDBText;
    ppDBText2: TppDBText;
    ppDBText5: TppDBText;
    ppFooterBand1: TppFooterBand;
    ppLine2: TppLine;
    ppSystemVariable1: TppSystemVariable;
    ppLabel6: TppLabel;
    ppDBPipeline1: TppDBPipeline;
    QryListagem: TZQuery;
    edtTabela: TcxTextEdit;
    lblTabela: TcxLabel;
    ppDesignLayers1: TppDesignLayers;
    ppDesignLayer1: TppDesignLayer;
    ppImage1: TppImage;
    ppLbDetalhe: TppLabel;
    ppSystemVariable2: TppSystemVariable;
    procedure edtTabelaEnter(Sender: TObject);
    procedure edtTabelaExit(Sender: TObject);
    procedure edtTabelaKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edtTabelaKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure btnImprimirClick(Sender: TObject);
  private
    { Private declarations }
    oTabelaPreco: TTabelaPreco;
  public
    { Public declarations }
  end;

var
  frmListagemPrecos: TfrmListagemPrecos;

implementation

uses uPrincipal;

{$R *.dfm}

procedure TfrmListagemPrecos.btnImprimirClick(Sender: TObject);
begin
  inherited;
  ppLbDetalhe.Caption := 'TABELA: ' + stTabela.Caption;
  with QryListagem do
  begin
    Connection := frmPrincipal.zcoConexaoBanco;
    Close;
    Sql.Clear;

    Sql.Add('SELECT tbtabelaprecoitens.iProduto');
    Sql.Add('      ,sDescricao');
    Sql.Add('      ,tbtabelaprecoitens.nPreco');
    Sql.Add('FROM   tbtabelaprecoitens');
    Sql.Add('JOIN tbproduto ON tbproduto.icodigo = tbtabelaprecoitens.iproduto');
    Sql.Add('WHERE  tbtabelaprecoitens.iTabela = :itabela');
    Sql.Add('  AND tbtabelaprecoitens.sstatus = ''A''');

    ParamByName('itabela').AsString := edtTabela.Text;
    Open;
    if isEmpty then
    begin
      pMsgInfo('Não existe(m) registro(s) para emissão do relatório.');
      edtTabela.SetFocus;
      Abort;
    end;
  end;
  Report.Print;
end;

procedure TfrmListagemPrecos.edtTabelaEnter(Sender: TObject);
begin
  inherited;
  edtTabela.SelectAll;
end;

procedure TfrmListagemPrecos.edtTabelaExit(Sender: TObject);
begin
  inherited;
  if (edtTabela.Text = '') or (edtTabela.Text = '0') then
  begin
    edtTabela.SetFocus;
    Exit;
  end;
  oTabelaPreco.SetCodigo(StrToInt(edtTabela.Text));
  if oTabelaPreco.bPesquisaTabelaPreco(oTabelaPreco.iGetCodigo) then
  begin
    stTabela.Caption := oTabelaPreco.sGetDescricao;
  end
  else
  begin
    Application.MessageBox('Tabela de Preço não encontrada', 'Alerta', MB_OK + MB_ICONEXCLAMATION);
    edtTabela.SetFocus;
  end;
end;

procedure TfrmListagemPrecos.edtTabelaKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  if Key = vk_F2 then
  begin
    edtTabela.Text := ChamaPesquisa(TEdit(Sender), frmPrincipal.zcoConexaoBanco)[0];
  end;
end;

procedure TfrmListagemPrecos.edtTabelaKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  KeyPressNumerico(Key);
end;

procedure TfrmListagemPrecos.FormCreate(Sender: TObject);
begin
  inherited;
  oTabelaPreco := TTabelaPreco.Create(frmPrincipal.zcoConexaoBanco);
end;

end.
