unit uCadastroCliente;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uCadastroGenerico, JvExControls,
  JvComponent, JvNavigationPane, JvPageList, ComCtrls,
  JvExComCtrls, JvComCtrls, StdCtrls, Mask, uCliente, ExtCtrls, uFornecedor,
  cxGraphics, cxLookAndFeels, cxLookAndFeelPainters, Menus, cxButtons,
  cxControls, cxContainer, cxEdit, cxTextEdit, cxLabel, dxSkinsCore,
  dxSkinBlack, dxSkinBlue, dxSkinBlueprint, dxSkinCaramel, dxSkinCoffee,
  dxSkinDarkRoom, dxSkinDarkSide, dxSkinDevExpressDarkStyle,
  dxSkinDevExpressStyle, dxSkinFoggy, dxSkinGlassOceans, dxSkinHighContrast,
  dxSkiniMaginary, dxSkinLilian, dxSkinLiquidSky, dxSkinLondonLiquidSky,
  dxSkinMcSkin, dxSkinMoneyTwins, dxSkinOffice2007Black, dxSkinOffice2007Blue,
  dxSkinOffice2007Green, dxSkinOffice2007Pink, dxSkinOffice2007Silver,
  dxSkinOffice2010Black, dxSkinOffice2010Blue, dxSkinOffice2010Silver,
  dxSkinPumpkin, dxSkinSeven, dxSkinSevenClassic, dxSkinSharp, dxSkinSharpPlus,
  dxSkinSilver, dxSkinSpringTime, dxSkinStardust, dxSkinSummer2008,
  dxSkinTheAsphaltWorld, dxSkinsDefaultPainters, dxSkinValentine, dxSkinVS2010,
  dxSkinWhiteprint, dxSkinXmas2008Blue;

type
  TfrmCadastroCliente = class(TfrmCadastroGenerico)
    pcDadosCliente: TJvPageControl;
    tsGerais: TTabSheet;
    tsFisica: TTabSheet;
    tsJuridica: TTabSheet;
    edtCEP: TMaskEdit;
    edtFone: TMaskEdit;
    edtFax: TMaskEdit;
    edtCelular: TMaskEdit;
    edtCPF: TMaskEdit;
    edtDataNascimento: TMaskEdit;
    edtCNPJ: TMaskEdit;
    edtDataCadastro: TMaskEdit;
    tsCobranca: TTabSheet;
    edtCEPCobr: TMaskEdit;
    rgPessoa: TRadioGroup;
    MemoObservacao: TMemo;
    edtCodigo: TcxTextEdit;
    edtNome: TcxTextEdit;
    edtEndereco: TcxTextEdit;
    edtBairro: TcxTextEdit;
    edtCidade: TcxTextEdit;
    edtCidadeNome: TcxTextEdit;
    edtEmail: TcxTextEdit;
    edtRamoAtividade: TcxTextEdit;
    edtRamoAtividadeDescricao: TcxTextEdit;
    edtComissionado: TcxTextEdit;
    edtComissionadoNome: TcxTextEdit;
    edtRG: TcxTextEdit;
    edtRazaoSocial: TcxTextEdit;
    edtInscEstadual: TcxTextEdit;
    edtInscMunicipal: TcxTextEdit;
    edtEnderecoCobr: TcxTextEdit;
    edtBairroCobr: TcxTextEdit;
    edtCidadeCobr: TcxTextEdit;
    edtCidadeCobrNome: TcxTextEdit;
    lblCodigo: TcxLabel;
    lblNome: TcxLabel;
    lblEndereco: TcxLabel;
    lblBairro: TcxLabel;
    lblCidade: TcxLabel;
    lblCEP: TcxLabel;
    lblFone: TcxLabel;
    lblFax: TcxLabel;
    lblCelular: TcxLabel;
    lblEmail: TcxLabel;
    lblRamoAtividade: TcxLabel;
    lblComissionado: TcxLabel;
    lblDataCadastro: TcxLabel;
    Label1: TcxLabel;
    lblRG: TcxLabel;
    lblCPF: TcxLabel;
    lblDataNascimento: TcxLabel;
    lblRazaoSocial: TcxLabel;
    lblCNPJ: TcxLabel;
    lblInscEstadual: TcxLabel;
    lblInscMunicipal: TcxLabel;
    lblEnderecoCobr: TcxLabel;
    lblBairroCobr: TcxLabel;
    lblCidadeCobr: TcxLabel;
    lblCEPCobr: TcxLabel;
    procedure FormShow(Sender: TObject);
    procedure btnGravaClick(Sender: TObject);
    procedure edtDataCadastroExit(Sender: TObject);
    procedure edtDataNascimentoExit(Sender: TObject);
    procedure btnCancelaClick(Sender: TObject);
    procedure edtCodigoEnter(Sender: TObject);
    procedure edtCodigoKeyPress(Sender: TObject; var Key: Char);
    procedure brnDeletaClick(Sender: TObject);
    procedure edtCodigoExit(Sender: TObject);
    procedure edtCidadeEnter(Sender: TObject);
    procedure edtCidadeExit(Sender: TObject);
    procedure edtCidadeKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure edtRamoAtividadeEnter(Sender: TObject);
    procedure edtRamoAtividadeExit(Sender: TObject);
    procedure edtRamoAtividadeKeyPress(Sender: TObject; var Key: Char);
    procedure edtCidadeCobrEnter(Sender: TObject);
    procedure edtCidadeCobrExit(Sender: TObject);
    procedure edtCidadeCobrKeyPress(Sender: TObject; var Key: Char);
    procedure rgPessoaClick(Sender: TObject);
    procedure edtComissionadoEnter(Sender: TObject);
    procedure edtComissionadoExit(Sender: TObject);
    procedure edtComissionadoKeyPress(Sender: TObject; var Key: Char);
    procedure edtDataCadastroEnter(Sender: TObject);
    procedure tsFisicaShow(Sender: TObject);
    procedure tsJuridicaShow(Sender: TObject);
    procedure tsCobrancaShow(Sender: TObject);
    procedure edtCidadeKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edtRamoAtividadeKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edtComissionadoKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure tsCobrancaEnter(Sender: TObject);
    procedure edtCidadeCobrKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edtCodigoKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    oCliente: TCliente;
    bRegistroNovo: Boolean;
    oFornecedor: TFornecedor;
    procedure InicializaForm;
  public
    bRegistroCarregado: Boolean;
    bCadastroFornecedor: Boolean;
  end;

var
  frmCadastroCliente: TfrmCadastroCliente;

implementation

uses uPrincipal, uPessoa, uPessoaFisica, uPessoaJuridica, usoGeral;

{$R *.dfm}

procedure TfrmCadastroCliente.FormShow(Sender: TObject);
begin
  inherited;
  oCliente := TCliente.Create(frmPrincipal.zcoConexaoBanco);
  edtCodigo.SetFocus;
  if bCadastroFornecedor then
  begin
    oFornecedor := TFornecedor.Create(frmPrincipal.zcoConexaoBanco);
    Self.Caption := 'Cadastro de fornecedores';
  end;
  if edtDataCadastro.Text = '  /  /    ' then
    edtDataCadastro.Text := FormatDateTime('dd/mm/yyyy', Date);
end;

procedure TfrmCadastroCliente.InicializaForm;
begin
  LimpaCampos(Self, []);
  pcDadosCliente.ActivePageIndex := 0;
  edtCodigo.SetFocus;
  bRegistroCarregado := False;
end;

procedure TfrmCadastroCliente.btnGravaClick(Sender: TObject);
begin
  inherited;
  if bCadastroFornecedor then
  begin
    with oFornecedor do
    begin
      // PESSOA
      SetCodigo(edtCodigo.Text);
      SetNome(edtNome.Text);
      SetEndereco(edtEndereco.Text);
      SetBairro(edtBairro.Text);
      oCidade.SetCodigo(edtCidade.Text);
      SetCep(edtCEP.Text);
      SetFone(edtFone.Text);
      SetFax(edtFax.Text);
      SetCelular(edtCelular.Text);
      SetEmail(edtEmail.Text);
      SetObservacao(MemoObservacao.Text);
      if rgPessoa.ItemIndex = 0 then // PESSOA FÍSICA
      begin
        with oFisica do
        begin
          SetRG(edtRG.Text);
          SetCPF(edtCPF.Text);
          oRamoAtividade.SetCodigo(edtRamoAtividade.Text);
          SetDataNascimento(edtDataNascimento.Text);
        end;
      end
      else // PESSOA JURÍDICA
      begin
        with oJuridica do
        begin
          SetCNPJ(edtCNPJ.Text);
          SetInscEstadual(edtInscEstadual.Text);
          SetInscMunicipal(edtInscMunicipal.Text);
          SetRazaoSocial(edtRazaoSocial.Text);
          oRamoAtividade.SetCodigo(edtRamoAtividade.Text);
        end;
      end;
      if iCamposConsistentes = 0 then
      begin
        if bRegistroNovo then
          CadastraFornecedor
        else
          AlteraFornecedor;
        InicializaForm;
        pcDadosCliente.ActivePageIndex := 0;
        edtCodigo.SetFocus;
      end;
    end;
  end
  else
  begin
    with oCliente do
    begin
      // PESSOA
      SetCodigo(edtCodigo.Text);
      SetNome(edtNome.Text);
      SetEndereco(edtEndereco.Text);
      SetBairro(edtBairro.Text);
      oCidade.SetCodigo(edtCidade.Text);
      SetCep(edtCEP.Text);
      SetFone(edtFone.Text);
      SetFax(edtFax.Text);
      SetCelular(edtCelular.Text);
      SetEmail(edtEmail.Text);
      SetObservacao(MemoObservacao.Text);

      // CLIENTE
      SetEnderecoCobr(edtEnderecoCobr.Text);
      SetBairroCobr(edtBairroCobr.Text);
      if Trim(edtCidadeCobr.Text) <> '' then
        oCidadeCobr.SetCodigo(edtCidadeCobr.Text)
      else
        oCidadeCobr.SetCodigo('');
      SetCepCobr(edtCEPCobr.Text);
      SetDataCadastro(edtDataCadastro.Text);
      if Trim(edtComissionado.Text) <> '' then
        oComissionado.SetCodigo(edtComissionado.Text)
      else
        oComissionado.SetCodigo('');

      if rgPessoa.ItemIndex = 0 then // PESSOA FÍSICA
      begin
        with oFisica do
        begin
          if edtCPF.Text = '' then
          begin
            pMsgInfo('Campo CPF não informado.');
            pcDadosCliente.ActivePageIndex := 1;
            edtCPF.SetFocus;
            Abort;
          end;
          if edtDataNascimento.Text = '  /  /    ' then
          begin
            pMsgInfo('Data de nascimento não informada.');
            pcDadosCliente.ActivePageIndex := 1;
            edtDataNascimento.SetFocus;
            Abort;
          end;
          if edtRamoAtividade.Text = '' then
          begin
            pMsgInfo('Ramo de atividade não informado.');
            pcDadosCliente.ActivePageIndex := 0;
            edtRamoAtividade.SetFocus;
            Abort;
          end;
          SetRG(edtRG.Text);
          SetCPF(edtCPF.Text);
          oRamoAtividade.SetCodigo(edtRamoAtividade.Text);
          SetDataNascimento(edtDataNascimento.Text);
        end;
      end
      else // PESSOA JURÍDICA
      begin
        if edtCNPJ.Text = '' then
        begin
          pMsgInfo('Campo CNPJ não informado.');
          pcDadosCliente.ActivePageIndex := 2;
          edtCNPJ.SetFocus;
          Abort;
        end;
        if edtRamoAtividade.Text = '' then
        begin
          pMsgInfo('Ramo de atividade não informado.');
          pcDadosCliente.ActivePageIndex := 0;
          edtRamoAtividade.SetFocus;
          Abort;
        end;
        if edtRazaoSocial.Text = '' then
        begin
          pMsgInfo('Ramo de atividade não informado.');
          pcDadosCliente.ActivePageIndex := 2;
          edtRazaoSocial.SetFocus;
          Abort;
        end;
        with oJuridica do
        begin
          SetCNPJ(edtCNPJ.Text);
          SetInscEstadual(edtInscEstadual.Text);
          SetInscMunicipal(edtInscMunicipal.Text);
          SetRazaoSocial(edtRazaoSocial.Text);
          oRamoAtividade.SetCodigo(edtRamoAtividade.Text);
        end;
      end;
      if iCamposConsistentes = 0 then
      begin
        if bRegistroNovo then
          CadastraCliente
        else
          AlteraCliente;
        InicializaForm;
        pcDadosCliente.ActivePageIndex := 0;
        edtCodigo.SetFocus;
      end;
    end;
  end;
end;

procedure TfrmCadastroCliente.edtDataCadastroExit(Sender: TObject);
var
  dData: TDateTime;
begin
  inherited;
  if edtDataCadastro.Text <> '  /  /    ' then
  begin
    try
      dData := StrToDate(edtDataCadastro.Text);
      edtDataCadastro.Text := FormatDateTime('dd/mm/yyyy', dData);
    except
      ShowMessage('Data Inválida!');
      edtDataCadastro.SetFocus;
    end;
  end;
end;

procedure TfrmCadastroCliente.edtDataNascimentoExit(Sender: TObject);
var
  dData: TDateTime;
begin
  inherited;
  if edtDataNascimento.Text <> '  /  /    ' then
  begin
    try
      dData := StrToDate(edtDataNascimento.Text);
      edtDataNascimento.Text := FormatDateTime('dd/mm/yyyy', dData);
    except
      ShowMessage('Data Inválida!');
      edtDataNascimento.SetFocus;
    end;
  end;
end;

procedure TfrmCadastroCliente.btnCancelaClick(Sender: TObject);
begin
  inherited;
  InicializaForm;
end;

procedure TfrmCadastroCliente.edtCodigoEnter(Sender: TObject);
begin
  inherited;
  if Trim(edtNome.Text) = '' then
  begin
    InicializaForm;
    edtCodigo.Text := IntToStr(oCliente.iRetornaUltimoCodigo + 1);
    edtCodigo.SelectAll;
  end;
end;

procedure TfrmCadastroCliente.edtCodigoKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  KeyPressNumerico(Key);
end;

procedure TfrmCadastroCliente.brnDeletaClick(Sender: TObject);
begin
  inherited;
  if bCadastroFornecedor then
  begin
    // oFornecedor.SetCodigo(edtCodigo.Text);
    // oFornecedor.DeletaFornecedor;
    InicializaForm;
  end
  else
  begin
    oCliente.SetCodigo(edtCodigo.Text);
    oCliente.DeletaCliente;
    InicializaForm;
  end;
end;

procedure TfrmCadastroCliente.edtCodigoExit(Sender: TObject);
begin
  inherited;
  if Trim(edtNome.Text) = '' then
  begin
    if (Trim(edtCodigo.Text) <> '') and (not bRegistroCarregado) then
    begin
      if edtDataCadastro.Text = '  /  /    ' then
        edtDataCadastro.Text := FormatDateTime('dd/mm/yyyy', Date);

      if bCadastroFornecedor then
      begin
        oFornecedor.SetCodigo(edtCodigo.Text);
        if oFornecedor.bPesquisaFornecedor(edtCodigo.Text) then
        begin
          with oFornecedor do
          begin
            edtNome.Text := sGetNome;
            edtEndereco.Text := sGetEndereco;
            edtBairro.Text := sGetBairro;
            edtCidade.Text := oCidade.sGetCodigo;
            edtCidadeNome.Text := oCidade.sGetNome;
            edtCEP.Text := sGetCep;
            edtFone.Text := sGetFone;
            edtFax.Text := sGetFax;
            edtCelular.Text := sGetCelular;
            edtEmail.Text := sGetEmail;
            MemoObservacao.Text := sGetObservacao;
            if oFisica.bPesquisaPessoaFisica(edtCodigo.Text) then
            begin
              with oFisica do
              begin
                rgPessoa.ItemIndex := 0;
                edtRG.Text := sGetRG;
                edtCPF.Text := sGetCPF;
                edtDataNascimento.Text := sGetDataNascimento;
                edtRamoAtividade.Text := oRamoAtividade.sGetCodigo;
                edtRamoAtividadeDescricao.Text := oRamoAtividade.sGetDescricao;
              end;
            end
            else if oJuridica.bPesquisaPessoaJuridica(edtCodigo.Text) then
            begin
              with oJuridica do
              begin
                rgPessoa.ItemIndex := 1;
                edtCNPJ.Text := sGetCNPJ;
                edtInscEstadual.Text := sGetInscEstadual;
                edtInscMunicipal.Text := sGetInscMunicipal;
                edtRazaoSocial.Text := sGetRazaoSocial;
                edtRamoAtividade.Text := oRamoAtividade.sGetCodigo;
                edtRamoAtividadeDescricao.Text := oRamoAtividade.sGetDescricao;
              end;
            end
            else
              rgPessoa.ItemIndex := 0;
          end;
          rgPessoaClick(Self);
          bRegistroNovo := False;
          bRegistroCarregado := true;
        end
        else
        begin
          if oFornecedor.bPesquisaPessoa(edtCodigo.Text) then
          begin
            ShowMessage('Código já utilizado para outra Pessoa!');
            btnCancelaClick(Self);
          end
          else
          begin
            LimpaCampos(Self, [edtCodigo]);
            bRegistroNovo := true;
          end;
        end;
      end
      else
      begin
        oCliente.SetCodigo(edtCodigo.Text);
        if oCliente.bPesquisaCliente(edtCodigo.Text) then
        begin
          with oCliente do
          begin
            edtNome.Text := sGetNome;
            edtEndereco.Text := sGetEndereco;
            edtBairro.Text := sGetBairro;
            edtCidade.Text := oCidade.sGetCodigo;
            edtCidadeNome.Text := oCidade.sGetNome;
            edtCEP.Text := sGetCep;
            edtFone.Text := sGetFone;
            edtFax.Text := sGetFax;
            edtCelular.Text := sGetCelular;
            edtEmail.Text := sGetEmail;
            edtEnderecoCobr.Text := sGetEnderecoCobr;
            edtBairroCobr.Text := sGetBairroCobr;
            edtCidadeCobr.Text := oCidadeCobr.sGetCodigo;
            edtCidadeCobrNome.Text := oCidadeCobr.sGetNome;
            edtCEPCobr.Text := sGetCepCobr;
            edtComissionado.Text := oComissionado.sGetCodigo;
            edtComissionadoNome.Text := oComissionado.sGetNome;
            edtDataCadastro.Text := sGetDataCadastro;
            MemoObservacao.Text := sGetObservacao;
            if oFisica.bPesquisaPessoaFisica(edtCodigo.Text) then
            begin
              with oFisica do
              begin
                rgPessoa.ItemIndex := 0;
                edtRG.Text := sGetRG;
                edtCPF.Text := sGetCPF;
                edtDataNascimento.Text := sGetDataNascimento;
                edtRamoAtividade.Text := oRamoAtividade.sGetCodigo;
                edtRamoAtividadeDescricao.Text := oRamoAtividade.sGetDescricao;
              end;
            end
            else if oJuridica.bPesquisaPessoaJuridica(edtCodigo.Text) then
            begin
              with oJuridica do
              begin
                rgPessoa.ItemIndex := 1;
                edtCNPJ.Text := sGetCNPJ;
                edtInscEstadual.Text := sGetInscEstadual;
                edtInscMunicipal.Text := sGetInscMunicipal;
                edtRazaoSocial.Text := sGetRazaoSocial;
                edtRamoAtividade.Text := oRamoAtividade.sGetCodigo;
                edtRamoAtividadeDescricao.Text := oRamoAtividade.sGetDescricao;
              end;
            end
            else
              rgPessoa.ItemIndex := 0;
          end;
          rgPessoaClick(Self);
          bRegistroNovo := False;
          bRegistroCarregado := true;
        end
        else
        begin
          if oCliente.bPesquisaPessoa(edtCodigo.Text) then
          begin
            ShowMessage('Código já utilizado para outra Pessoa!');
            btnCancelaClick(Self);
          end
          else
          begin
            LimpaCampos(Self, [edtCodigo]);
            bRegistroNovo := true;

            if edtDataCadastro.Text = '  /  /    ' then
              edtDataCadastro.Text := FormatDateTime('dd/mm/yyyy', Date);
          end;
        end;
      end;
    end;
  end;
end;

procedure TfrmCadastroCliente.edtCidadeEnter(Sender: TObject);
begin
  inherited;
  edtCidade.SelectAll;
end;

procedure TfrmCadastroCliente.edtCidadeExit(Sender: TObject);
var
  bCidadeNaoEncontrada: Boolean;
begin
  inherited;
  bCidadeNaoEncontrada := False;

  if ActiveControl = BtnSair then
    Exit;

  if (edtCidade.Text = '') or (edtCidade.Text = '0') then
  begin
    edtCidadeNome.Clear;
    Exit;
  end;

  if oCliente.oCidade.bPesquisaCidade(edtCidade.Text) then
  begin
    if oCliente.oCidade.sGetStatus = 'A' then
      edtCidadeNome.Text := oCliente.oCidade.sGetNome
    else
      bCidadeNaoEncontrada := true;
  end
  else
    bCidadeNaoEncontrada := true;
  if bCidadeNaoEncontrada then
  begin
    Application.MessageBox(PChar('Cidade não cadastrada!'), 'Aviso', MB_OK);
    edtCidade.SetFocus;
  end;
end;

procedure TfrmCadastroCliente.edtCidadeKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  KeyPressNumerico(Key);
end;

procedure TfrmCadastroCliente.FormCreate(Sender: TObject);
begin
  inherited;
  pcDadosCliente.ActivePageIndex := 0;
end;

procedure TfrmCadastroCliente.edtRamoAtividadeEnter(Sender: TObject);
begin
  inherited;
  edtRamoAtividade.SelectAll;
end;

procedure TfrmCadastroCliente.edtRamoAtividadeExit(Sender: TObject);
var
  bRamoAtividadeNaoEncontrada: Boolean;
begin
  inherited;
  bRamoAtividadeNaoEncontrada := False;

  if ActiveControl = BtnSair then
    Exit;

  if (edtRamoAtividade.Text = '') or (edtRamoAtividade.Text = '0') then
  begin
    edtRamoAtividadeDescricao.Clear;
    Exit;
  end;

  if oCliente.oFisica.oRamoAtividade.bPesquisaRamoAtividade(edtRamoAtividade.Text) then
  begin
    if oCliente.oFisica.oRamoAtividade.sGetStatus = 'A' then
      edtRamoAtividadeDescricao.Text := oCliente.oFisica.oRamoAtividade.sGetDescricao
    else
      bRamoAtividadeNaoEncontrada := true;
  end
  else
    bRamoAtividadeNaoEncontrada := true;
  if bRamoAtividadeNaoEncontrada then
  begin
    Application.MessageBox(PChar('Ramo de Atividade não cadastrado!'), 'Aviso', MB_OK);
    edtRamoAtividade.SetFocus;
  end;
end;

procedure TfrmCadastroCliente.edtRamoAtividadeKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  KeyPressNumerico(Key);
end;

procedure TfrmCadastroCliente.edtCidadeCobrEnter(Sender: TObject);
begin
  inherited;
  edtCidade.SelectAll;
end;

procedure TfrmCadastroCliente.edtCidadeCobrExit(Sender: TObject);
var
  bCidadeCobrNaoEncontrada: Boolean;
begin
  inherited;
  bCidadeCobrNaoEncontrada := False;

  if ActiveControl = BtnSair then
    Exit;

  if (edtCidadeCobr.Text = '') or (edtCidadeCobr.Text = '0') then
  begin
    edtCidadeCobrNome.Clear;
    Exit;
  end;

  if oCliente.oCidadeCobr.bPesquisaCidade(edtCidadeCobr.Text) then
  begin
    if oCliente.oCidadeCobr.sGetStatus = 'A' then
      edtCidadeCobrNome.Text := oCliente.oCidadeCobr.sGetNome
    else
      bCidadeCobrNaoEncontrada := true;
  end
  else
    bCidadeCobrNaoEncontrada := true;
  if bCidadeCobrNaoEncontrada then
  begin
    Application.MessageBox(PChar('Cidade de Cobrança não cadastrada!'), 'Aviso', MB_OK);
    edtCidadeCobr.SetFocus;
  end;
end;

procedure TfrmCadastroCliente.edtCidadeCobrKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  KeyPressNumerico(Key);
end;

procedure TfrmCadastroCliente.rgPessoaClick(Sender: TObject);
begin
  inherited;
  tsFisica.Enabled := rgPessoa.ItemIndex = 0;
  tsJuridica.Enabled := rgPessoa.ItemIndex = 1;

  if not tsFisica.Enabled then
  begin
    edtCPF.Clear;
    edtRG.Clear;
    edtDataNascimento.Clear;
    oCliente.oFisica.bPesquisaPessoaFisica('-1');
  end
  else
  begin
    edtCNPJ.Clear;
    edtRazaoSocial.Clear;
    edtInscEstadual.Clear;
    edtInscMunicipal.Clear;
    oCliente.oJuridica.bPesquisaPessoaJuridica('-1');
  end;
end;

procedure TfrmCadastroCliente.edtComissionadoEnter(Sender: TObject);
begin
  inherited;
  edtComissionado.SelectAll;
end;

procedure TfrmCadastroCliente.edtComissionadoExit(Sender: TObject);
var
  bComissionadoNaoEncontrado: Boolean;
begin
  inherited;
  bComissionadoNaoEncontrado := False;

  if ActiveControl = BtnSair then
    Exit;

  if (edtComissionado.Text = '') or (edtComissionado.Text = '0') then
  begin
    edtComissionadoNome.Clear;
    Exit;
  end;

  if oCliente.oComissionado.bPesquisaComissionado(edtComissionado.Text) then
  begin
    if oCliente.oComissionado.sGetStatus = 'A' then
      edtComissionadoNome.Text := oCliente.oComissionado.sGetNome
    else
      bComissionadoNaoEncontrado := true;
  end
  else
    bComissionadoNaoEncontrado := true;
  if bComissionadoNaoEncontrado then
  begin
    Application.MessageBox(PChar('Comissionado não cadastrado!'), 'Aviso', MB_OK);
    edtComissionado.SetFocus;
  end;
end;

procedure TfrmCadastroCliente.edtComissionadoKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  KeyPressNumerico(Key);
end;

procedure TfrmCadastroCliente.edtDataCadastroEnter(Sender: TObject);
begin
  inherited;
  if edtDataCadastro.Text = '  /  /    ' then
    edtDataCadastro.Text := FormatDateTime('dd/mm/yyyy', Date);
end;

procedure TfrmCadastroCliente.tsFisicaShow(Sender: TObject);
begin
  inherited;
  if tsFisica.Enabled then
    edtCPF.SetFocus;
end;

procedure TfrmCadastroCliente.tsJuridicaShow(Sender: TObject);
begin
  inherited;
  if tsJuridica.Enabled then
    edtCNPJ.SetFocus;
end;

procedure TfrmCadastroCliente.tsCobrancaShow(Sender: TObject);
begin
  inherited;
  if tsCobranca.Enabled then
    edtEnderecoCobr.SetFocus;
end;

procedure TfrmCadastroCliente.edtCidadeKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  if Key = vk_F2 then
  begin
    edtCidade.Text := ChamaPesquisa(TEdit(Sender), frmPrincipal.zcoConexaoBanco)[0];
    edtCidadeExit(Sender);
  end;
end;

procedure TfrmCadastroCliente.edtRamoAtividadeKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  if Key = vk_F2 then
  begin
    edtRamoAtividade.Text := ChamaPesquisa(TEdit(Sender), frmPrincipal.zcoConexaoBanco)[0];
    edtRamoAtividadeExit(Sender);
  end;
end;

procedure TfrmCadastroCliente.edtComissionadoKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  if Key = vk_F2 then
  begin
    edtComissionado.Text := ChamaPesquisa(TEdit(Sender), frmPrincipal.zcoConexaoBanco)[0];
    edtComissionadoExit(Sender);
  end;
end;

procedure TfrmCadastroCliente.tsCobrancaEnter(Sender: TObject);
begin
  if bRegistroNovo then
  begin
    if edtEnderecoCobr.Text = '' then
      edtEnderecoCobr.Text := edtEndereco.Text;
    if edtBairroCobr.Text = '' then
      edtBairro.Text;
    if edtCEPCobr.Text = '' then
      edtCEPCobr.Text := edtCEP.Text;
    if edtCidadeCobr.Text <> '' then
    begin
      edtCidadeCobr.Text := edtCidade.Text;
      edtCidadeCobrNome.Text := edtCidadeNome.Text;
    end;
  end;
end;

procedure TfrmCadastroCliente.edtCidadeCobrKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  if Key = vk_F2 then
  begin
    edtCidadeCobr.Text := ChamaPesquisa(TEdit(Sender), frmPrincipal.zcoConexaoBanco)[0];
    edtCidadeCobrExit(Sender);
  end;
end;

procedure TfrmCadastroCliente.edtCodigoKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  if Key = vk_F2 then
  begin
    if bCadastroFornecedor then
      TEdit(Sender).Tag := 19;
    edtCodigo.Text := ChamaPesquisa(TEdit(Sender), frmPrincipal.zcoConexaoBanco)[0];
    Perform(WM_NEXTDLGCTL, 0, 0);
  end;
end;

end.
