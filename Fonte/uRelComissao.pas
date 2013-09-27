unit uRelComissao;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uCadastroGenerico, JvExControls, uProcedimentosBanco,
  JvComponent, JvNavigationPane, DB, ppParameter, ppVar,
  ppBands, ppCtrls, ppPrnabl, ppClass, ppCache, ppProd, ppReport,
  ZAbstractRODataset, ZAbstractDataset, ZDataset, ppComm, ppRelatv, ppDB,
  ppDBPipe, Mask, StdCtrls, ppModule, raCodMod, uComissionado, cxGraphics,
  cxLookAndFeels, cxLookAndFeelPainters, Menus, cxButtons, ExtCtrls, cxControls,
  cxContainer, cxEdit, cxTextEdit, cxLabel, Vcl.ComCtrls, dxCore, cxDateUtils,
  cxMaskEdit, cxDropDownEdit, cxCalendar, UsoGeral, ppDesignLayer,
  dxGDIPlusClasses, dxSkinsCore, dxSkinOffice2010Silver;

type
  TfrmRelComissaoPeriodo = class(TfrmCadastroGenerico)
    ppDBPipeline1: TppDBPipeline;
    Report: TppReport;
    ppParameterList1: TppParameterList;
    dsListagem: TDataSource;
    edtTecnicoNome: TStaticText;
    ppHeaderBand1: TppHeaderBand;
    ppLabel8: TppLabel;
    ppLabel9: TppLabel;
    ppDetailBand1: TppDetailBand;
    ppDBText2: TppDBText;
    ppDBText3: TppDBText;
    ppDBText4: TppDBText;
    ppDBText5: TppDBText;
    ppDBText6: TppDBText;
    ppDBText7: TppDBText;
    ppDBText8: TppDBText;
    ppDBText9: TppDBText;
    ppFooterBand1: TppFooterBand;
    ppGroup1: TppGroup;
    ppGroupHeaderBand1: TppGroupHeaderBand;
    ppLabel1: TppLabel;
    ppDBText1: TppDBText;
    ppGroupFooterBand1: TppGroupFooterBand;
    ppDBCalc1: TppDBCalc;
    ppDBCalc2: TppDBCalc;
    ppLabel13: TppLabel;
    raCodeModule1: TraCodeModule;
    QryComissao: TZQuery;
    edtTecnico: TcxTextEdit;
    Label1: TcxLabel;
    Label2: TcxLabel;
    Label3: TcxLabel;
    edtDataInicio: TcxDateEdit;
    edtDataFinal: TcxDateEdit;
    ppDesignLayers1: TppDesignLayers;
    ppDesignLayer1: TppDesignLayer;
    ppImage1: TppImage;
    LabelTitulo: TppLabel;
    ppLbDetalhe: TppLabel;
    ppLabel15: TppLabel;
    ppLine1: TppLine;
    ppLabel14: TppLabel;
    ppLabel16: TppLabel;
    ppLabel17: TppLabel;
    ppLabel18: TppLabel;
    ppLabel20: TppLabel;
    ppLabel2: TppLabel;
    ppLine2: TppLine;
    ppSystemVariable1: TppSystemVariable;
    ppSystemVariable2: TppSystemVariable;
    procedure edtTecnicoEnter(Sender: TObject);
    procedure edtTecnicoExit(Sender: TObject);
    procedure edtTecnicoKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edtTecnicoKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
    procedure FormDeactivate(Sender: TObject);
    procedure btnImprimirClick(Sender: TObject);
  private
    { Private declarations }
    oComissionado: TComissionado;
  public
    { Public declarations }
  end;

var
  frmRelComissaoPeriodo: TfrmRelComissaoPeriodo;

implementation

uses uPrincipal;

{$R *.dfm}

procedure TfrmRelComissaoPeriodo.btnImprimirClick(Sender: TObject);
begin
  inherited;
  if (Trim(edtDataInicio.Text) <> '') and (Trim(edtDataFinal.Text) <> '') then
  begin
    if edtDataFinal.Date < edtDataInicio.Date then
    begin
      pMsgAtencao('Data final não pode ser menor que a data inicial.');
      edtDataFinal.SetFocus;
      Abort;
    end;

    ppLbDetalhe.Caption := 'Período de: ' + edtDataInicio.Text + ' à ' + edtDataFinal.Text;
    with QryComissao do
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
      ParamByName('dataInicial').AsDate := edtDataInicio.Date;
      ParamByName('dataFinal').AsDate := edtDataFinal.Date;
      SQL.Add('order by tbservicotecnico.itecnico, tbpedido.ddatapedido, tbservicotecnico.ipedido, tbservicotecnico.nvalorcomissao');
      Open;
      if isEmpty then
      begin
        pMsgInfo('Não há registros a serem exibidos.');
        edtTecnicoNome.SetFocus;
        Abort;
      end;
    end;
    Report.Print;
  end;
end;

procedure TfrmRelComissaoPeriodo.edtTecnicoEnter(Sender: TObject);
begin
  inherited;
  edtTecnico.SelectAll;
end;

procedure TfrmRelComissaoPeriodo.edtTecnicoExit(Sender: TObject);
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
      bTecnicoNaoEncontrado := true;
  end
  else
    bTecnicoNaoEncontrado := true;
  if bTecnicoNaoEncontrado then
  begin
    Application.MessageBox(PChar('Tecnico não cadastrado!'), 'Aviso', MB_OK);
  end;
end;

procedure TfrmRelComissaoPeriodo.edtTecnicoKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  if Key = vk_F2 then
  begin
    edtTecnico.Text := ChamaPesquisa(TEdit(Sender), frmPrincipal.zcoConexaoBanco)[0];
    edtTecnicoExit(Sender);
  end;
end;

procedure TfrmRelComissaoPeriodo.edtTecnicoKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  KeyPressNumerico(Key);
end;

procedure TfrmRelComissaoPeriodo.FormShow(Sender: TObject);
begin
  inherited;
  oComissionado := TComissionado.Create(frmPrincipal.zcoConexaoBanco);
  edtDataInicio.Text := DateToStr(fDataHoraSrv(frmprincipal.zcoConexaoBanco));
  edtDataFinal.Text := DateToStr(fDataHoraSrv(frmprincipal.zcoConexaoBanco));
end;

procedure TfrmRelComissaoPeriodo.FormDeactivate(Sender: TObject);
begin
  FreeAndNil(oComissionado);
  inherited;
end;

end.
