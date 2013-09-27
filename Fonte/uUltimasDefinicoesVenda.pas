unit uUltimasDefinicoesVenda;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uCadastroGenerico, JvExControls, uPesquisaGeral,
  JvComponent, JvNavigationPane, StdCtrls, uNaturezaOperacao, UsoGeral,
  uCodigoFiscal, uCliente, Mask, JvExStdCtrls, JvEdit, JvValidateEdit,
  uStrings, uComissionado, cxGraphics, cxLookAndFeels, cxLookAndFeelPainters,
  Menus, cxButtons, ExtCtrls, cxControls, cxContainer, cxEdit, cxTextEdit,
  cxLabel, dxSkinsCore, dxSkinOffice2010Silver, cxMaskEdit, cxCurrencyEdit, cxMemo, cxDropDownEdit,
  dxSkinBlack, dxSkinBlue, dxSkinBlueprint, dxSkinCaramel, dxSkinCoffee,
  dxSkinDarkRoom, dxSkinDarkSide, dxSkinDevExpressDarkStyle,
  dxSkinDevExpressStyle, dxSkinFoggy, dxSkinGlassOceans, dxSkinHighContrast,
  dxSkiniMaginary, dxSkinLilian, dxSkinLiquidSky, dxSkinLondonLiquidSky,
  dxSkinMcSkin, dxSkinMoneyTwins, dxSkinOffice2007Black, dxSkinOffice2007Blue,
  dxSkinOffice2007Green, dxSkinOffice2007Pink, dxSkinOffice2007Silver,
  dxSkinOffice2010Black, dxSkinOffice2010Blue, dxSkinPumpkin, dxSkinSeven,
  dxSkinSevenClassic, dxSkinSharp, dxSkinSharpPlus, dxSkinSilver,
  dxSkinSpringTime, dxSkinStardust, dxSkinSummer2008, dxSkinTheAsphaltWorld,
  dxSkinsDefaultPainters, dxSkinValentine, dxSkinVS2010, dxSkinWhiteprint,
  dxSkinXmas2008Blue;

type
  TfrmUltimasDefinicoes = class(TfrmCadastroGenerico)
    edtCPF: TMaskEdit;
    edtCNPJ: TMaskEdit;
    edtCEP: TMaskEdit;
    btnCadAux: TcxButton;
    edtNaturezaOperacao: TcxTextEdit;
    edtCFOP: TcxTextEdit;
    edtCliente: TcxTextEdit;
    edtVeiculo: TcxTextEdit;
    edtVendedor: TcxTextEdit;
    lblNaturezaOperacao: TcxLabel;
    lblCFOP: TcxLabel;
    lblCliente: TcxLabel;
    lblObservacao: TcxLabel;
    lblEndereco: TcxLabel;
    lblBairro: TcxLabel;
    lblCEP: TcxLabel;
    lblMunicipio: TcxLabel;
    lblUF: TcxLabel;
    lblCPFCNPJ: TcxLabel;
    lclInscEstadual: TcxLabel;
    Label1: TcxLabel;
    Label2: TcxLabel;
    Label3: TcxLabel;
    Label4: TcxLabel;
    stNaturezaOperacao: TcxTextEdit;
    stCFOP: TcxTextEdit;
    stCliente: TcxTextEdit;
    stEndereco: TcxTextEdit;
    stBairro: TcxTextEdit;
    stCEP: TcxTextEdit;
    stMunicipio: TcxTextEdit;
    stUF: TcxTextEdit;
    stCPFCNPJ: TcxTextEdit;
    stInscEstadual: TcxTextEdit;
    stVendedor: TcxTextEdit;
    ComboBoxOperacao: TcxComboBox;
    EdtObservacao: TcxMemo;
    edtKM: TcxCurrencyEdit;
    edtPlaca: TcxMaskEdit;
    procedure FormShow(Sender: TObject);
    procedure edtNaturezaOperacaoExit(Sender: TObject);
    procedure edtNaturezaOperacaoKeyPress(Sender: TObject; var Key: Char);
    procedure edtNaturezaOperacaoKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edtCFOPKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edtCFOPExit(Sender: TObject);
    procedure edtClienteKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edtClienteExit(Sender: TObject);
    procedure btnGravaClick(Sender: TObject);
    procedure btnCancelaClick(Sender: TObject);
    procedure ComboBoxOperacaoChange(Sender: TObject);
    procedure edtPlacaKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edtPlacaExit(Sender: TObject);
    procedure btnCadAuxClick(Sender: TObject);
    procedure edtVendedorKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edtVendedorExit(Sender: TObject);
  private
    { Private declarations }
    oNaturezaOperacao: TNaturezaOperacao;
    oCodigoFiscal: TCodigoFiscal;
    oCliente: TCliente;
    oComissionado: TComissionado;
  public
    { Public declarations }
  end;

var
  frmUltimasDefinicoes: TfrmUltimasDefinicoes;

implementation

uses uPrincipal, uPessoa, uPessoaJuridica, uPessoaFisica, uCidade,
  uDadosConsumidor, uPlaca, uCadastroPlacas;
{$R *.dfm}

procedure TfrmUltimasDefinicoes.FormShow(Sender: TObject);
begin
  inherited;
  oNaturezaOperacao := TNaturezaOperacao.Create(frmPrincipal.zcoConexaoBanco);
  oCodigoFiscal := TCodigoFiscal.Create(frmPrincipal.zcoConexaoBanco);
  oCliente := TCliente.Create(frmPrincipal.zcoConexaoBanco);
  oComissionado := TComissionado.Create(frmPrincipal.zcoConexaoBanco);

  ComboBoxOperacaoChange(Sender);
end;

procedure TfrmUltimasDefinicoes.edtNaturezaOperacaoExit(Sender: TObject);
begin
  inherited;
  if edtNaturezaOperacao.Text = '' then
  begin
    edtNaturezaOperacao.SetFocus;
    exit;
  end;
  oNaturezaOperacao.bPesquisaNaturezaOperacao(StrtoInt(edtNaturezaOperacao.Text));
  stNaturezaOperacao.Text := oNaturezaOperacao.sGetDescricao;
end;

procedure TfrmUltimasDefinicoes.edtNaturezaOperacaoKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  KeyPressNumerico(Key);
end;

procedure TfrmUltimasDefinicoes.edtNaturezaOperacaoKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  if Key = vk_F2 then
  begin
    edtNaturezaOperacao.Text := ChamaPesquisa(TEdit(Sender), frmPrincipal.zcoConexaoBanco)[0];
    Perform(WM_NEXTDLGCTL, 0, 0);
  end;
end;

procedure TfrmUltimasDefinicoes.edtCFOPKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  if Key = vk_F2 then
  begin
    edtCFOP.Text := ChamaPesquisa(TEdit(Sender), frmPrincipal.zcoConexaoBanco)[0];
    Perform(WM_NEXTDLGCTL, 0, 0);
  end;
end;

procedure TfrmUltimasDefinicoes.edtCFOPExit(Sender: TObject);
begin
  inherited;
  if edtCFOP.Text = '' then
  begin
    edtCFOP.SetFocus;
    exit;
  end;
  oCodigoFiscal.bPesquisaCodigoFiscal(StrtoInt(edtCFOP.Text));
  stCFOP.Text := oCodigoFiscal.sGetDescricao;
end;

procedure TfrmUltimasDefinicoes.edtClienteKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  if Key = vk_F2 then
  begin
    edtCliente.Text := ChamaPesquisa(TEdit(Sender), frmPrincipal.zcoConexaoBanco)[0];
    Perform(WM_NEXTDLGCTL, 0, 0);
  end;
end;

procedure TfrmUltimasDefinicoes.edtClienteExit(Sender: TObject);
begin
  inherited;
  if edtCliente.Text = '' then
  begin
    stCliente.Text := 'CONSUMIDOR';
    stCPFCNPJ.Text := '';
    stInscEstadual.Text := '';
    stBairro.Text := '';
    stEndereco.Text := '';
    edtCEP.Text := '';
    stCEP.Text := '';
    stMunicipio.Text := '';
    stUF.Text := '';
    exit;
  end;

  oCliente.bPesquisaCliente(edtCliente.Text);
  stCliente.Text := oCliente.sGetNome;

  if trim(oCliente.sGetNome) = '' then
  begin
    if fpergunta('Cliente não encontrado, deseja realizar venda Consumidor?') then
    begin
      edtCliente.Clear;
      stCliente.Text := 'CONSUMIDOR';
      stCPFCNPJ.Text := '';
      stInscEstadual.Text := '';
      stBairro.Text := '';
      stEndereco.Text := '';
      edtCEP.Text := '';
      stCEP.Text := '';
      stMunicipio.Text := '';
      stUF.Text := '';
    end
    else
    begin
      edtCliente.SetFocus;
      stCPFCNPJ.Text := '';
      stInscEstadual.Text := '';
      stBairro.Text := '';
      stEndereco.Text := '';
      edtCEP.Text := '';
      stCEP.Text := '';
      stMunicipio.Text := '';
      stUF.Text := '';
    end;
  end;

  if oCliente.oJuridica.sGetCNPJ <> '' then
  begin
    edtCNPJ.Text := oCliente.oJuridica.sGetCNPJ;
    stCPFCNPJ.Text := edtCNPJ.EditText;
    stInscEstadual.Text := oCliente.oJuridica.sGetInscEstadual;
  end
  else
  begin
    edtCPF.Text := oCliente.oFisica.sGetCPF;
    stCPFCNPJ.Text := edtCPF.EditText;
    stInscEstadual.Text := '';
  end;
  stBairro.Text := oCliente.sGetBairro;
  stEndereco.Text := oCliente.sGetEndereco;
  edtCEP.Text := oCliente.sGetCep;
  stCEP.Text := edtCEP.EditText;
  stMunicipio.Text := oCliente.oCidade.sGetNome;
  stUF.Text := oCliente.oCidade.sGetUF;
end;

procedure TfrmUltimasDefinicoes.btnGravaClick(Sender: TObject);
begin
  inherited;
  if stVendedor.Text = '' then
  begin
    Application.MessageBox('Campo vendedor informado incorretamente!', 'Alerta', MB_OK + MB_ICONWARNING);
    exit;
  end;

  if ComboBoxOperacao.ItemIndex = 1 then
  begin
    if stNaturezaOperacao.Text = '' then
    begin
      Application.MessageBox('Campo natureza de operação informado incorretamente!', 'Alerta', MB_OK + MB_ICONWARNING);
      exit;
    end
    else if stCFOP.Text = '' then
    begin
      Application.MessageBox('Campo CFOP informado incorretamente!', 'Alerta', MB_OK + MB_ICONWARNING);
      exit;
    end
    else
    begin
      ModalResult := mrOk;
    end;
  end
  else
  begin
    edtNaturezaOperacao.Text := frmPrincipal.fGetParams('CodNaturezaVenda');
    edtCFOP.Text := frmPrincipal.fGetParams('CodCFOPVenda');
    ModalResult := mrOk;
  end;
end;

procedure TfrmUltimasDefinicoes.btnCancelaClick(Sender: TObject);
begin
  inherited;
  ModalResult := mrCancel;
end;

procedure TfrmUltimasDefinicoes.ComboBoxOperacaoChange(Sender: TObject);
begin
  inherited;
  if (ComboBoxOperacao.ItemIndex = 0) or (ComboBoxOperacao.ItemIndex = 2) then
  begin
    edtNaturezaOperacao.Enabled := False;
    edtNaturezaOperacao.Style.Color := clBtnFace;
    edtCFOP.Enabled := False;
    edtCFOP.Style.Color := clBtnFace;
  end
  else
  begin
    edtNaturezaOperacao.Enabled := True;
    edtCFOP.Enabled := True;
    edtNaturezaOperacao.Style.Color := clWindow;
    edtCFOP.Style.Color := clWindow;

    // Natureza Padrão
    edtNaturezaOperacao.EditValue := frmPrincipal.fGetParams('CodNaturezaVenda');
    edtNaturezaOperacao.OnExit(edtNaturezaOperacao);

    // CFOP Padrão
    edtCFOP.EditValue := frmPrincipal.fGetParams('CodCFOPVenda');
    edtCFOP.OnExit(edtCFOP);
  end;
end;

procedure TfrmUltimasDefinicoes.edtPlacaKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
Var
  Resultado: TResultArray;
begin
  inherited;
  if edtCliente.Text = '' then
    exit;
  if Key = vk_F2 then
  begin
    Resultado := ChamaPesquisa(TEdit(Sender), frmPrincipal.zcoConexaoBanco, ' and iCliente = ' + edtCliente.Text);
    SetLength(Resultado, Length(Resultado));

    edtPlaca.Text := Resultado[0];
    edtVeiculo.Text := Resultado[1];
    edtKM.Text := Resultado[2];

    Perform(WM_NEXTDLGCTL, 0, 0);
  end;
end;

procedure TfrmUltimasDefinicoes.edtPlacaExit(Sender: TObject);
var
  oPlaca: TPlaca;
begin
  inherited;
  if edtCliente.Text <> '' then
  begin
    oPlaca := TPlaca.Create(frmPrincipal.zcoConexaoBanco);
    if oPlaca.bPesquisaPlacaCliente(uStrings.SubstituiString(edtPlaca.Text, '-', ''), StrtoInt(edtCliente.Text)) then
    begin
      edtVeiculo.Text := oPlaca.GetsVeiculo;
      edtKM.Value := oPlaca.GetiKm;
    end;
    FreeAndNil(oPlaca);
  end;
end;

procedure TfrmUltimasDefinicoes.btnCadAuxClick(Sender: TObject);
begin
  inherited;
  frmPlacas := TfrmPlacas.Create(Self);
  with frmPlacas do
  begin
    if trim(Self.edtCliente.Text) <> '' then
    begin
      edtCliente.EditValue := Self.edtCliente.Text;
      edtCliente.OnExit(edtCliente);
      edtCliente.Enabled := False;
      edtPlaca.EditValue := Self.edtPlaca.EditValue;
      edtVeiculo.EditValue := Self.edtVeiculo.EditValue;
      edtKM.EditValue := Self.edtKM.EditValue;
    end;
    ShowModal;
    FreeAndNil(frmPlacas);
  end;
end;

procedure TfrmUltimasDefinicoes.edtVendedorKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  if Key = vk_F2 then
  begin
    edtVendedor.Text := ChamaPesquisa(TEdit(Sender), frmPrincipal.zcoConexaoBanco)[0];
    Perform(WM_NEXTDLGCTL, 0, 0);
  end;
end;

procedure TfrmUltimasDefinicoes.edtVendedorExit(Sender: TObject);
var
  bTecnicoNaoEncontrado: boolean;
begin
  inherited;
  bTecnicoNaoEncontrado := False;

  if ActiveControl = BtnSair then
    exit;

  if (edtVendedor.Text = '') or (edtVendedor.Text = '0') then
  begin
    stVendedor.Text := '';
    exit;
  end;

  if oComissionado.bPesquisaComissionado(edtVendedor.Text) then
  begin
    if oComissionado.sGetStatus = 'A' then
      stVendedor.Text := oComissionado.sGetNome
    else
      bTecnicoNaoEncontrado := True;
  end
  else
    bTecnicoNaoEncontrado := True;
  if bTecnicoNaoEncontrado then
  begin
    Application.MessageBox(PChar('Vendedor não cadastrado!'), 'Aviso', MB_OK);
  end;
end;

end.
