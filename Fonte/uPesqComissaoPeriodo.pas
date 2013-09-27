unit uPesqComissaoPeriodo;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uCadastroGenerico, JvExControls, UsoGeral, cxGridExportLink,
  JvComponent, JvNavigationPane, cxStyles, cxCustomData, uProcedimentosBanco,
  cxGraphics, cxFilter, cxData, cxDataStorage, cxEdit, DB, cxDBData,
  ZAbstractRODataset, ZAbstractDataset, ZDataset, Mask, StdCtrls,
  cxGridLevel, cxClasses, cxControls, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid,
  ZConnection, uComissionado, cxLookAndFeels, cxLookAndFeelPainters,
  dxSkinsCore, dxSkinBlack, dxSkinBlue, dxSkinCaramel, dxSkinCoffee,
  dxSkinDarkRoom, dxSkinDarkSide, dxSkinFoggy, dxSkinGlassOceans,
  dxSkiniMaginary, dxSkinLilian, dxSkinLiquidSky, dxSkinLondonLiquidSky,
  dxSkinMcSkin, dxSkinMoneyTwins, dxSkinOffice2007Black, dxSkinOffice2007Blue,
  dxSkinOffice2007Green, dxSkinOffice2007Pink, dxSkinOffice2007Silver,
  dxSkinOffice2010Black, dxSkinOffice2010Blue, dxSkinOffice2010Silver,
  dxSkinPumpkin, dxSkinSeven, dxSkinSharp, dxSkinSilver, dxSkinSpringTime,
  dxSkinStardust, dxSkinSummer2008, dxSkinsDefaultPainters, dxSkinValentine,
  dxSkinXmas2008Blue, dxSkinscxPCPainter, Menus, cxButtons, ExtCtrls,
  cxContainer, cxTextEdit, cxLabel, cxCurrencyEdit, cxMaskEdit, cxDropDownEdit,
  cxCalendar, Vcl.ComCtrls, dxCore, cxDateUtils, cxNavigator;

type
  TfrmPesqComissaoPeriodo = class(TfrmCadastroGenerico)
    cxGrid1DBTableView1: TcxGridDBTableView;
    cxGrid1Level1: TcxGridLevel;
    cxGrid1: TcxGrid;
    ZQuery: TZQuery;
    DataSource: TDataSource;
    cxGrid1DBTableView1tecnico: TcxGridDBColumn;
    cxGrid1DBTableView1ipedido: TcxGridDBColumn;
    cxGrid1DBTableView1ddatapedido: TcxGridDBColumn;
    cxGrid1DBTableView1ntotalpedido: TcxGridDBColumn;
    cxGrid1DBTableView1sveiculo: TcxGridDBColumn;
    cxGrid1DBTableView1splaca: TcxGridDBColumn;
    cxGrid1DBTableView1cliente: TcxGridDBColumn;
    cxGrid1DBTableView1servico: TcxGridDBColumn;
    cxGrid1DBTableView1ncomissao: TcxGridDBColumn;
    cxGrid1DBTableView1nvalorservico: TcxGridDBColumn;
    cxGrid1DBTableView1nvalorcomissao: TcxGridDBColumn;
    edtTecnicoNome: TStaticText;
    btnPesquisar: TcxButton;
    edtTecnico: TcxTextEdit;
    Label1: TcxLabel;
    Label2: TcxLabel;
    Label3: TcxLabel;
    edtDataInicio: TcxDateEdit;
    edtDataFinal: TcxDateEdit;
    procedure btnPesquisarClick(Sender: TObject);
    procedure edtTecnicoEnter(Sender: TObject);
    procedure edtTecnicoExit(Sender: TObject);
    procedure edtTecnicoKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edtTecnicoKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
    procedure FormDeactivate(Sender: TObject);
    procedure btnExportarClick(Sender: TObject);
  private
    { Private declarations }
    oComissionado: TComissionado;
  public
    { Public declarations }
  end;

var
  frmPesqComissaoPeriodo: TfrmPesqComissaoPeriodo;

implementation

uses uPrincipal;

{$R *.dfm}

procedure TfrmPesqComissaoPeriodo.btnExportarClick(Sender: TObject);
var
  nNMArquivo: string;
begin
  inherited;
  inherited;
  if ZQuery.IsEmpty then
  begin
    pMsgAtencao('A grid esta vazia! É preciso ter dados para exportar.');
    btnExportar.SetFocus;
    Abort;
  end;

  SaveDlg.FileName := Self.Caption + ' (' + FormatDateTime('dd-MM-yyyy', Date) + ')';

  if SaveDlg.Execute then
  begin
    nNMArquivo := SaveDlg.FileName;
    if FileExists(SaveDlg.FileName) then
      DeleteFile(SaveDlg.FileName);
    if FileExists(SaveDlg.FileName) then
    begin
      pMsgAtencao('O arquivo já existe ou esta sendo utilizado!');
      Abort;
    end;
    // -> Salvar em Formato .xls Excel
    if SaveDlg.FilterIndex = 1 then
      ExportGridToExcel(SaveDlg.FileName, cxGrid1, True, True, True);
    // -> Salvar em Formato .html
    if SaveDlg.FilterIndex = 2 then
      ExportGridToHTML(SaveDlg.FileName, cxGrid1, True, True);
  end;
end;

procedure TfrmPesqComissaoPeriodo.btnPesquisarClick(Sender: TObject);
begin
  inherited;
  if (Trim(edtDataInicio.Text) <> '') and (Trim(edtDataFinal.Text) <> '') then
  begin
    with ZQuery do
    begin
      Connection := frmPrincipal.zcoConexaoBanco;
      SQL.Clear;
      Close;
      SQL.Add('select');
      SQL.Add('cast(tbservicotecnico.itecnico as varchar(100)) || '' - '' || tbpessoa.snome as Tecnico, tbservicotecnico.ipedido, tbpedido.ddatapedido,');
      SQL.Add('tbpedido.ntotalprodutos + tbpedido.najustevalor as ntotalpedido, tbpedido.sveiculo, tbpedido.splaca,');
      SQL.Add('cast(coalesce(tbpedido.icliente, 0) as varchar(100)) || '' - '' || coalesce(tbpessoacliente.snome, tbconsumidor.snome,''CONSUMIDOR'') as cliente,');
      SQL.Add('cast(tbservicotecnico.iservico as varchar(100)) || '' - '' || tbproduto.sdescricao as Servico, tbservicotecnico.ncomissao, tbservicotecnico.nvalorservico, tbservicotecnico.nvalorcomissao');
      SQL.Add('from tbservicotecnico');
      SQL.Add('join tbpedido on tbpedido.icodigo = tbservicotecnico.ipedido');
      SQL.Add('join tbcomissionado on tbcomissionado.icodigo = tbservicotecnico.itecnico');
      SQL.Add('join tbpessoa on tbpessoa.icodigo = tbcomissionado.icodigo');
      SQL.Add('join tbproduto on tbproduto.icodigo = tbservicotecnico.iservico');
      SQL.Add('left outer join tbcliente on tbcliente.icodigo = tbpedido.icliente');
      SQL.Add('left outer join tbpessoa as tbpessoacliente on tbpessoacliente.icodigo = tbcliente.icodigo');
      SQL.Add('left outer join tbconsumidor on tbconsumidor.ipedido = tbpedido.icodigo');
      SQL.Add('where tbpedido.sstatus = ''A'' and tbcomissionado.sstatus = ''A'' and tbproduto.sstatus = ''A''');
      if edtTecnico.Text <> '' then
      begin
        SQL.Add('and tbservicotecnico.itecnico = :itecnico');
        ParamByName('itecnico').AsInteger := StrToInt(edtTecnico.Text);
      end;
      SQL.Add('and tbpedido.ddatapedido Between :dataInicial and :dataFinal');
      ParamByName('dataInicial').AsDateTime := edtDataInicio.Date;
      ParamByName('dataFinal').AsDateTime := edtDataFinal.Date;
      SQL.Add('order by tbservicotecnico.itecnico, tbpedido.ddatapedido, tbservicotecnico.ipedido, tbservicotecnico.nvalorcomissao');
      Open;
      if IsEmpty then
      begin
        Application.MessageBox('Não há registros a serem exibidos.', 'Informação', MB_OK + MB_ICONINFORMATION)
      end;
    end;
  end;
end;

procedure TfrmPesqComissaoPeriodo.edtTecnicoEnter(Sender: TObject);
begin
  inherited;
  edtTecnico.SelectAll;
end;

procedure TfrmPesqComissaoPeriodo.edtTecnicoExit(Sender: TObject);
var
  bTecnicoNaoEncontrado: boolean;
begin
  inherited;
  bTecnicoNaoEncontrado := False;

  if ActiveControl = BtnSair then
    Exit;

  if (edtTecnico.Text = '') or (edtTecnico.Text = '0') then
  begin
    edtTecnicoNome.Caption := '';
    Exit;
  end;

  if oComissionado.bPesquisaComissionado(edtTecnico.Text) then
  begin
    if oComissionado.sGetStatus = 'A' then
      edtTecnicoNome.Caption := oComissionado.sGetNome
    else
      bTecnicoNaoEncontrado := True;
  end
  else
    bTecnicoNaoEncontrado := True;
  if bTecnicoNaoEncontrado then
  begin
    Application.MessageBox(PChar('Tecnico não cadastrado!'), 'Aviso', MB_OK);
  end;
end;

procedure TfrmPesqComissaoPeriodo.edtTecnicoKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  if Key = vk_F2 then
  begin
    edtTecnico.Text := ChamaPesquisa(TEdit(Sender), frmPrincipal.zcoConexaoBanco)[0];
    edtTecnicoExit(Sender);
  end;
end;

procedure TfrmPesqComissaoPeriodo.edtTecnicoKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  KeyPressNumerico(Key);
end;

procedure TfrmPesqComissaoPeriodo.FormShow(Sender: TObject);
begin
  inherited;
  oComissionado := TComissionado.Create(frmPrincipal.zcoConexaoBanco);
  edtDataInicio.Text := FormatDateTime('dd/mm/yyyy', fDataHoraSrv(frmPrincipal.zcoConexaoBanco));
  edtDataFinal.Text := FormatDateTime('dd/mm/yyyy', fDataHoraSrv(frmPrincipal.zcoConexaoBanco));
end;

procedure TfrmPesqComissaoPeriodo.FormDeactivate(Sender: TObject);
begin
  FreeAndNil(oComissionado);
  inherited;

end;

end.
