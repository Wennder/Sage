unit uCadastroProduto;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uCadastroGenerico, JvExControls, UsoGeral,
  JvComponent, JvNavigationPane, StdCtrls, JvExStdCtrls,
  JvEdit, JvValidateEdit, uProduto, cxGraphics, cxLookAndFeels,
  cxLookAndFeelPainters, Menus, cxButtons, ExtCtrls, cxControls, cxContainer,
  cxEdit, cxTextEdit, cxLabel;

type
  TfrmCadastroProduto = class(TfrmCadastroGenerico)
    edtCusto: TJvValidateEdit;
    chkServico: TCheckBox;
    edtCodigo: TcxTextEdit;
    edtGrupo: TcxTextEdit;
    edtDescGrupo: TcxTextEdit;
    edtSubGrupo: TcxTextEdit;
    edtDescSubGrupo: TcxTextEdit;
    edtMarca: TcxTextEdit;
    edtDescMarca: TcxTextEdit;
    edtUndEntrada: TcxTextEdit;
    edtDescUndEntrada: TcxTextEdit;
    edtQtdEntrada: TcxTextEdit;
    edtUndSaida: TcxTextEdit;
    edtDescUndSaida: TcxTextEdit;
    edtQtdSaida: TcxTextEdit;
    Label1: TcxLabel;
    Label2: TcxLabel;
    Label5: TcxLabel;
    Label6: TcxLabel;
    Label7: TcxLabel;
    Label8: TcxLabel;
    Label9: TcxLabel;
    Label10: TcxLabel;
    Label11: TcxLabel;
    Label12: TcxLabel;
    edtReferencia: TcxTextEdit;
    Label3: TcxLabel;
    Label4: TcxLabel;
    edtFabricacao: TcxTextEdit;
    edtDescricao: TcxTextEdit;
    EditNCMCodigo: TcxTextEdit;
    EditNCMDescricao: TcxTextEdit;
    Label13: TcxLabel;
    procedure edtCodigoKeyPress(Sender: TObject; var Key: Char);
    procedure edtGrupoExit(Sender: TObject);
    procedure edtSubGrupoExit(Sender: TObject);
    procedure edtMarcaExit(Sender: TObject);
    procedure edtUndEntradaExit(Sender: TObject);
    procedure edtUndSaidaExit(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure edtCodigoExit(Sender: TObject);
    procedure btnGravaClick(Sender: TObject);
    procedure edtCodigoEnter(Sender: TObject);
    procedure edtGrupoKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edtMarcaKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edtUndEntradaKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edtUndSaidaKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edtSubGrupoKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnCancelaClick(Sender: TObject);
    procedure edtCodigoKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure EditNCMCodigoExit(Sender: TObject);
    procedure EditNCMCodigoKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure EditNCMCodigoKeyPress(Sender: TObject; var Key: Char);
    procedure brnDeletaClick(Sender: TObject);
  private
    { Private declarations }
    oProduto: TProduto;
    bRegistroNovo: Boolean;
  public
    { Public declarations }
    procedure InicializaForm;
  end;

var
  frmCadastroProduto: TfrmCadastroProduto;

implementation

uses uSubGrupo, uMarca, uUnidade, uPrincipal, uGrupo;

{$R *.dfm}

procedure TfrmCadastroProduto.edtCodigoKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  KeyPressNumerico(Key);
end;

procedure TfrmCadastroProduto.edtGrupoExit(Sender: TObject);
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
      bGrupoNaoEncontrado := true;
  end
  else
    bGrupoNaoEncontrado := true;
  if bGrupoNaoEncontrado then
  begin
    Application.MessageBox(PChar('Grupo não cadastrado!'), 'Aviso', MB_OK);
    edtGrupo.SetFocus;
  end;
end;

procedure TfrmCadastroProduto.edtSubGrupoExit(Sender: TObject);
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
      bsubGrupoNaoEncontrado := true;
  end
  else
    bsubGrupoNaoEncontrado := true;
  if bsubGrupoNaoEncontrado then
  begin
    Application.MessageBox(PChar('SubGrupo não cadastrado!'), 'Aviso', MB_OK);
    edtSubGrupo.SetFocus;
  end;
end;

procedure TfrmCadastroProduto.edtMarcaExit(Sender: TObject);
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
      bMarcaNaoEncontrada := true;
  end
  else
    bMarcaNaoEncontrada := true;
  if bMarcaNaoEncontrada then
  begin
    Application.MessageBox(PChar('Marca não cadastrada!'), 'Aviso', MB_OK);
    edtMarca.SetFocus;
  end;
end;

procedure TfrmCadastroProduto.edtUndEntradaExit(Sender: TObject);
var
  bUnidadeNaoEncontrada: Boolean;
begin
  inherited;
  bUnidadeNaoEncontrada := False;
  if ActiveControl = BtnSair then
    Exit;
  if (edtUndEntrada.Text = '') or (edtUndEntrada.Text = '0') then
  begin
    Exit;
  end;
  oProduto.oUndEntrada.SetCodigo(StrToInt(edtUndEntrada.Text));
  if oProduto.oUndEntrada.bPesquisaUnidade(StrToInt(edtUndEntrada.Text)) then
  begin
    if oProduto.oUndEntrada.sGetStatus = 'A' then
      edtDescUndEntrada.Text := oProduto.oUndEntrada.sGetDescricao
    else
      bUnidadeNaoEncontrada := true;
  end
  else
    bUnidadeNaoEncontrada := true;
  if bUnidadeNaoEncontrada then
  begin
    Application.MessageBox(PChar('Unidade não cadastrada!'), 'Aviso', MB_OK);
    edtUndEntrada.SetFocus;
  end;
end;

procedure TfrmCadastroProduto.edtUndSaidaExit(Sender: TObject);
var
  bUnidadeNaoEncontrada: Boolean;
begin
  inherited;
  bUnidadeNaoEncontrada := False;
  if ActiveControl = BtnSair then
    Exit;
  if (edtUndSaida.Text = '') or (edtUndSaida.Text = '0') then
  begin
    Exit;
  end;
  oProduto.oUndSaida.SetCodigo(StrToInt(edtUndSaida.Text));
  if oProduto.oUndSaida.bPesquisaUnidade(StrToInt(edtUndSaida.Text)) then
  begin
    if oProduto.oUndSaida.sGetStatus = 'A' then
      edtDescUndSaida.Text := oProduto.oUndSaida.sGetDescricao
    else
      bUnidadeNaoEncontrada := true;
  end
  else
    bUnidadeNaoEncontrada := true;
  if bUnidadeNaoEncontrada then
  begin
    Application.MessageBox(PChar('Unidade não cadastrada!'), 'Aviso', MB_OK);
    edtUndSaida.SetFocus;
  end;
end;

procedure TfrmCadastroProduto.FormShow(Sender: TObject);
begin
  inherited;
  oProduto := TProduto.Create(frmPrincipal.zcoConexaoBanco);
end;

procedure TfrmCadastroProduto.edtCodigoExit(Sender: TObject);
begin
  inherited;
  if (edtCodigo.Text = '') or (edtCodigo.Text = '0') then
    edtCodigo.SetFocus;
  oProduto.SetCodigo(StrToInt(edtCodigo.Text));
  if oProduto.bPesquisaProduto(oProduto.GetiCodigo) then
  begin
    edtDescricao.Text := oProduto.GetsDescricao;
    edtReferencia.Text := oProduto.GetsReferencia;
    edtFabricacao.Text := oProduto.GetsFabricacao;
    edtGrupo.Text := IntToStr(oProduto.oSubGrupo.oGrupo.iGetCodigo);
    edtDescGrupo.Text := oProduto.oSubGrupo.oGrupo.sGetDescricao;
    edtSubGrupo.Text := IntToStr(oProduto.oSubGrupo.iGetCodigo);
    edtDescSubGrupo.Text := oProduto.oSubGrupo.sGetDescricao;
    edtMarca.Text := IntToStr(oProduto.oMarca.iGetCodigo);
    edtDescMarca.Text := oProduto.oMarca.sGetDescricao;
    edtCusto.AsFloat := oProduto.GetnCusto;
    edtUndEntrada.Text := IntToStr(oProduto.oUndEntrada.iGetCodigo);
    edtDescUndEntrada.Text := oProduto.oUndEntrada.sGetDescricao;
    edtQtdEntrada.Text := IntToStr(oProduto.GetiQtdEntrada);
    edtUndSaida.Text := IntToStr(oProduto.oUndSaida.iGetCodigo);
    edtDescUndSaida.Text := oProduto.oUndSaida.sGetDescricao;
    edtQtdSaida.Text := IntToStr(oProduto.GetiQtdSaida);
    chkServico.Checked := oProduto.GetsServico = 'S';
    EditNCMCodigo.Text := IntToStr(oProduto.oNCM.GetiCodigo);
    EditNCMDescricao.Text := oProduto.oNCM.GetsDescricao;
    bRegistroNovo := False;
  end
  else
    bRegistroNovo := true;
end;

procedure TfrmCadastroProduto.InicializaForm;
begin
  LimpaCampos(self, [nil]);
  edtCodigo.SetFocus;
end;

procedure TfrmCadastroProduto.btnGravaClick(Sender: TObject);
begin
  inherited;
  oProduto.SetDescricao(edtDescricao.Text);
  oProduto.SetReferencia(edtReferencia.Text);
  oProduto.SetFabricacao(edtFabricacao.Text);
  if chkServico.Checked then
    oProduto.SetServico('S')
  else
    oProduto.SetServico('N');
  if Trim(edtGrupo.Text) <> '' then
    oProduto.oSubGrupo.oGrupo.SetCodigo(StrToInt(edtGrupo.Text));
  if Trim(edtSubGrupo.Text) <> '' then
    oProduto.oSubGrupo.SetCodigo(StrToInt(edtSubGrupo.Text));
  if Trim(edtMarca.Text) <> '' then
    oProduto.oMarca.SetCodigo(StrToInt(edtMarca.Text));;
  oProduto.SetCusto(edtCusto.AsFloat);
  if Trim(edtUndEntrada.Text) <> '' then
    oProduto.oUndEntrada.SetCodigo(StrToInt(edtUndEntrada.Text));;
  if Trim(edtQtdEntrada.Text) <> '' then
    oProduto.SetQtdEntrada(StrToInt(edtQtdEntrada.Text));
  if Trim(edtUndSaida.Text) <> '' then
    oProduto.oUndSaida.SetCodigo(StrToInt(edtUndSaida.Text));
  if Trim(edtQtdSaida.Text) <> '' then
    oProduto.SetQtdSaida(StrToInt(edtQtdSaida.Text));
  if Trim(EditNCMCodigo.Text) <> '' then
    oProduto.oNCM.SetCodigo(StrToInt(EditNCMCodigo.Text));;
  if bRegistroNovo then
    oProduto.CadastraProduto
  else
    oProduto.AlteraProduto;
  InicializaForm;
end;

procedure TfrmCadastroProduto.edtCodigoEnter(Sender: TObject);
begin
  inherited;
  LimpaCampos(self, []);
  edtCodigo.Text := IntToStr(oProduto.iRetornaUltimoCodigo + 1);
  edtCodigo.SelectAll;
end;

procedure TfrmCadastroProduto.edtGrupoKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  if Key = vk_F2 then
  begin
    edtGrupo.Text := ChamaPesquisa(TEdit(Sender), frmPrincipal.zcoConexaoBanco, '', true)[0];
    edtGrupoExit(Sender);
  end;
end;

procedure TfrmCadastroProduto.edtMarcaKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  if Key = vk_F2 then
  begin
    edtMarca.Text := ChamaPesquisa(TEdit(Sender), frmPrincipal.zcoConexaoBanco, '', true)[0];
    edtMarcaExit(Sender);
  end;
end;

procedure TfrmCadastroProduto.edtUndEntradaKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  if Key = vk_F2 then
  begin
    edtUndEntrada.Text := ChamaPesquisa(TEdit(Sender), frmPrincipal.zcoConexaoBanco, '', true)[0];
    edtUndEntradaExit(Sender);
  end;
end;

procedure TfrmCadastroProduto.edtUndSaidaKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  if Key = vk_F2 then
  begin
    edtUndSaida.Text := ChamaPesquisa(TEdit(Sender), frmPrincipal.zcoConexaoBanco, '', true)[0];
    edtUndSaidaExit(Sender);
  end;
end;

procedure TfrmCadastroProduto.edtSubGrupoKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  if Key = vk_F2 then
  begin
    edtSubGrupo.Text := ChamaPesquisa(TEdit(Sender), frmPrincipal.zcoConexaoBanco, ' and iGrupo ' + iif(Trim(edtGrupo.Text) = '', 'is Null',
      ' = ' + Trim(edtGrupo.Text)), true)[0];
    edtSubGrupoExit(Sender);
  end;
end;

procedure TfrmCadastroProduto.brnDeletaClick(Sender: TObject);
begin
  inherited;
  oProduto.SetCodigo(StrToInt(edtCodigo.Text));
  oProduto.DeletaProduto;
  InicializaForm;
end;

procedure TfrmCadastroProduto.btnCancelaClick(Sender: TObject);
begin
  inherited;
  LimpaCampos(self, []);
  edtCodigo.Text := IntToStr(oProduto.iRetornaUltimoCodigo + 1);
  edtCodigo.SelectAll;
end;

procedure TfrmCadastroProduto.edtCodigoKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  if Key = vk_F2 then
  begin
    edtCodigo.Text := ChamaPesquisa(TEdit(Sender), frmPrincipal.zcoConexaoBanco)[0];
    edtCodigoExit(Sender);
  end;
end;

procedure TfrmCadastroProduto.EditNCMCodigoExit(Sender: TObject);
var
  bNMCNaoEncontrada: Boolean;
begin
  inherited;
  bNMCNaoEncontrada := False;
  if ActiveControl = BtnSair then
    Exit;
  if (EditNCMCodigo.Text = '') or (EditNCMCodigo.Text = '0') then
  begin
    Exit;
  end;
  oProduto.oNCM.SetCodigo(StrToInt(EditNCMCodigo.Text));
  if oProduto.oNCM.bPesquisaNCMCodigo(StrToInt(EditNCMCodigo.Text)) then
  begin
    if oProduto.oNCM.GetsStatus = 'A' then
      EditNCMDescricao.Text := oProduto.oNCM.GetsDescricao
    else
      bNMCNaoEncontrada := true;
  end
  else
    bNMCNaoEncontrada := true;
  if bNMCNaoEncontrada then
  begin
    Application.MessageBox(PChar('NCM não cadastrado!'), 'Aviso', MB_OK);
    EditNCMCodigo.SetFocus;
  end;
end;

procedure TfrmCadastroProduto.EditNCMCodigoKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  if Key = vk_F2 then
  begin
    EditNCMCodigo.Text := ChamaPesquisa(TEdit(Sender), frmPrincipal.zcoConexaoBanco, '', true)[0];
    EditNCMCodigoExit(Sender);
  end;
end;

procedure TfrmCadastroProduto.EditNCMCodigoKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  KeyPressNumerico(Key);
end;

end.
