unit uRelProdutosCadastrados;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uCadastroGenerico, JvExControls, uProduto,
  JvComponent, JvNavigationPane, DB, ppDB, ppDBPipe,
  ZAbstractRODataset, ZAbstractDataset, ZDataset, ppParameter, ppModule,
  raCodMod, ppCtrls, ppVar, ppBands, ppPrnabl, ppClass, ppCache, ppComm,
  ppRelatv, ppProd, ppReport, ZConnection, cxGraphics, cxLookAndFeels,
  cxLookAndFeelPainters, Menus, StdCtrls, cxButtons, ExtCtrls, cxControls,
  cxContainer, cxEdit, cxLabel, cxTextEdit, UsoGeral, ppDesignLayer,
  dxGDIPlusClasses;

type
  TfrmRelProdutosCadastrados = class(TfrmCadastroGenerico)
    Report: TppReport;
    ppHeaderBand1: TppHeaderBand;
    ppDetailBand1: TppDetailBand;
    ppDBText7: TppDBText;
    ppDBText8: TppDBText;
    ppDBText9: TppDBText;
    ppFooterBand1: TppFooterBand;
    raCodeModule1: TraCodeModule;
    ppParameterList1: TppParameterList;
    ppDBPipeline1: TppDBPipeline;
    dsProdutos: TDataSource;
    QryProdutos: TZQuery;
    edtGrupo: TcxTextEdit;
    edtDescGrupo: TcxTextEdit;
    edtSubGrupo: TcxTextEdit;
    edtDescSubGrupo: TcxTextEdit;
    edtMarca: TcxTextEdit;
    edtDescMarca: TcxTextEdit;
    Label5: TcxLabel;
    Label6: TcxLabel;
    Label7: TcxLabel;
    ppDesignLayers1: TppDesignLayers;
    ppDesignLayer1: TppDesignLayer;
    ppImage1: TppImage;
    LabelTitulo: TppLabel;
    ppLbDetalhe: TppLabel;
    ppLbSage: TppLabel;
    ppLine3: TppLine;
    ppLabel1: TppLabel;
    ppLabel2: TppLabel;
    ppLabel13: TppLabel;
    ppLabel4: TppLabel;
    ppLabel5: TppLabel;
    ppLabel7: TppLabel;
    ppLine2: TppLine;
    ppSystemVariable1: TppSystemVariable;
    ppSystemVariable2: TppSystemVariable;
    ppDBText2: TppDBText;
    ppDBText3: TppDBText;
    ppDBText4: TppDBText;
    ppSummaryBand1: TppSummaryBand;
    ppLabel3: TppLabel;
    ppDBCalc1: TppDBCalc;
    procedure btnImprimirClick(Sender: TObject);
    procedure edtGrupoKeyPress(Sender: TObject; var Key: Char);
    procedure edtGrupoKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edtGrupoExit(Sender: TObject);
    procedure edtSubGrupoExit(Sender: TObject);
    procedure edtMarcaExit(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure ReportBeforePrint(Sender: TObject);
    procedure edtSubGrupoKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edtMarcaKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }
    oProduto: TProduto;
  public
    { Public declarations }
  end;

var
  frmRelProdutosCadastrados: TfrmRelProdutosCadastrados;
  vTopLabels: Array [1 .. 2] Of Single;

implementation

uses uPrincipal;

{$R *.dfm}

procedure TfrmRelProdutosCadastrados.btnImprimirClick(Sender: TObject);
begin
  inherited;
  with QryProdutos do
  begin
    Connection := frmPrincipal.zcoConexaoBanco;
    Close;
    ppLbDetalhe.Caption := '';
    Sql.Clear;
    Sql.Add('SELECT p.*');
    Sql.Add('      ,m.sdescricao AS "marca"');
    Sql.Add('      ,ue.sdescricao AS "undentrada"');
    Sql.Add('      ,us.sdescricao AS "undsaida"');
    Sql.Add('      ,s.sdescricao AS "subgrupo"');
    Sql.Add('      ,g.sdescricao "grupo"');
    Sql.Add('FROM   tbproduto p');
    Sql.Add('LEFT JOIN tbmarca m ON m.icodigo = p.imarca');
    Sql.Add('LEFT JOIN tbunidade ue ON ue.icodigo = p.iundentrada');
    Sql.Add('LEFT JOIN tbunidade us ON us.icodigo = p.iundsaida');
    Sql.Add('LEFT JOIN tbsubgrupo s ON s.igrupo = p.igrupo AND s.icodigo = p.isubgrupo');
    Sql.Add('LEFT JOIN tbgrupo g ON g.icodigo = s.igrupo');
    Sql.Add('WHERE p.sstatus = ''A''');

    if Trim(edtGrupo.Text) <> '' then
    begin
      Sql.Add(' AND p.igrupo = :grupo');
      ParamByName('grupo').AsInteger := StrToInt(edtGrupo.Text);

      ppLbDetalhe.Caption := 'GRUPO: ' + edtDescGrupo.Text + ' ';
    end;

    if Trim(edtSubGrupo.Text) <> '' then
    begin
      Sql.Add(' AND p.isubgrupo = :subgrupo');
      ParamByName('subgrupo').AsInteger := StrToInt(edtSubGrupo.Text);

      ppLbDetalhe.Caption := ppLbDetalhe.Caption + 'SUBGRUPO: ' + edtDescSubGrupo.Text + ' ';
    end;

    if Trim(edtMarca.Text) <> '' then
    begin
      Sql.Add(' AND p.imarca = :marca');
      ParamByName('marca').AsInteger := StrToInt(edtMarca.Text);

      ppLbDetalhe.Caption := ppLbDetalhe.Caption + 'MARCA: ' + edtDescMarca.Text;
    end;

    Open;
    if isEmpty then
    begin
      pMsgInfo('Não existe(m) registro(s) para emissão do relatório.');
      edtGrupo.SetFocus;
      Abort;
    end;
  end;
  Report.Print;
end;

procedure TfrmRelProdutosCadastrados.edtGrupoExit(Sender: TObject);
var
  bGrupoNaoEncontrado: Boolean;
begin
  inherited;
  bGrupoNaoEncontrado := False;
  if ActiveControl = BtnSair then
    Exit;
  if (edtGrupo.Text = '') or (edtGrupo.Text = '0') then
  begin
    Exit;
  end;
  oProduto.oSubGrupo.oGrupo.SetCodigo(StrToInt(edtGrupo.Text));
  if oProduto.oSubGrupo.oGrupo.bPesquisaGrupo(StrToInt(edtGrupo.Text)) then
  begin
    if oProduto.oSubGrupo.oGrupo.sGetStatus = 'A' then
      edtDescGrupo.Text := oProduto.oSubGrupo.oGrupo.sGetDescricao
    else
      bGrupoNaoEncontrado := True;
  end
  else
    bGrupoNaoEncontrado := True;
  if bGrupoNaoEncontrado then
  begin
    pMsgAtencao('Grupo não cadastrado!');
    edtGrupo.SetFocus;
  end;
end;

procedure TfrmRelProdutosCadastrados.edtGrupoKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  if Key = vk_F2 then
  begin
    edtGrupo.Text := ChamaPesquisa(TEdit(Sender), frmPrincipal.zcoConexaoBanco)[0];
    Perform(WM_NEXTDLGCTL, 0, 0);
  end;
end;

procedure TfrmRelProdutosCadastrados.edtGrupoKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  KeyPressNumerico(Key);
end;

procedure TfrmRelProdutosCadastrados.edtMarcaExit(Sender: TObject);
var
  bMarcaNaoEncontrada: Boolean;
begin
  inherited;
  bMarcaNaoEncontrada := False;
  if ActiveControl = BtnSair then
    Exit;
  if (edtMarca.Text = '') or (edtMarca.Text = '0') then
  begin
    Exit;
  end;
  oProduto.oMarca.SetCodigo(StrToInt(edtMarca.Text));
  if oProduto.oMarca.bPesquisaMarca(StrToInt(edtMarca.Text)) then
  begin
    if oProduto.oMarca.sGetStatus = 'A' then
      edtDescMarca.Text := oProduto.oMarca.sGetDescricao
    else
      bMarcaNaoEncontrada := True;
  end
  else
    bMarcaNaoEncontrada := True;
  if bMarcaNaoEncontrada then
  begin
    pMsgAtencao('Marca não cadastrada!');
    edtMarca.SetFocus;
  end;
end;

procedure TfrmRelProdutosCadastrados.edtMarcaKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  if Key = vk_F2 then
  begin
    edtMarca.Text := ChamaPesquisa(TEdit(Sender), frmPrincipal.zcoConexaoBanco)[0];
    Perform(WM_NEXTDLGCTL, 0, 0);
  end;
end;

procedure TfrmRelProdutosCadastrados.edtSubGrupoExit(Sender: TObject);
var
  bsubGrupoNaoEncontrado: Boolean;
begin
  inherited;
  bsubGrupoNaoEncontrado := False;
  if ActiveControl = BtnSair then
    Exit;
  if (edtSubGrupo.Text = '') or (edtSubGrupo.Text = '0') or (edtGrupo.Text = '') or (edtGrupo.Text = '0') then
  begin
    Exit;
  end;
  oProduto.oSubGrupo.oGrupo.SetCodigo(StrToInt(edtGrupo.Text));
  oProduto.oSubGrupo.SetCodigo(StrToInt(edtSubGrupo.Text));
  if oProduto.oSubGrupo.bPesquisaSubGrupo(StrToInt(edtSubGrupo.Text), StrToInt(edtGrupo.Text)) then
  begin
    if oProduto.oSubGrupo.sGetStatus = 'A' then
      edtDescSubGrupo.Text := oProduto.oSubGrupo.sGetDescricao
    else
      bsubGrupoNaoEncontrado := True;
  end
  else
    bsubGrupoNaoEncontrado := True;
  if bsubGrupoNaoEncontrado then
  begin
    pMsgAtencao('SubGrupo não cadastrado!');
    edtSubGrupo.SetFocus;
  end;
end;

procedure TfrmRelProdutosCadastrados.edtSubGrupoKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  if Key = vk_F2 then
  begin
    edtSubGrupo.Text := ChamaPesquisa(TEdit(Sender), frmPrincipal.zcoConexaoBanco)[0];
    Perform(WM_NEXTDLGCTL, 0, 0);
  end;
end;

procedure TfrmRelProdutosCadastrados.FormShow(Sender: TObject);
begin
  inherited;
  oProduto := TProduto.Create(frmPrincipal.zcoConexaoBanco);
  vTopLabels[1] := ppLbDetalhe.Top;
  vTopLabels[2] := ppLbSage.Top;
end;

procedure TfrmRelProdutosCadastrados.ReportBeforePrint(Sender: TObject);
begin
  inherited;
  // Esconde Label do Relatório
  if Trim(ppLbDetalhe.Caption) = '' then
  begin
    ppLbSage.Top := vTopLabels[1];
    ppLbDetalhe.Visible := False;
  end
  else
  begin
    ppLbSage.Top := vTopLabels[2];;
    ppLbDetalhe.Top := vTopLabels[1];
    ppLbDetalhe.Visible := True;
  end;

end;

end.
