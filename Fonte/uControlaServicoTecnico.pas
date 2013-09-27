unit uControlaServicoTecnico;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uCadastroGenerico, JvExControls,
  JvComponent,  JvNavigationPane, cxStyles, cxCustomData,
  cxGraphics, cxFilter, cxData, cxDataStorage, cxEdit, DB, cxDBData,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView,
  JvMemoryDataset, cxGridLevel, cxClasses, cxControls, cxGridCustomView,
  cxGrid, StdCtrls, uServicoTecnico, uPrincipal, uComissionado, cxLookAndFeels,
  cxLookAndFeelPainters, Menus, dxSkinsCore, dxSkinOffice2010Silver,
  dxSkinscxPCPainter, cxButtons, cxContainer, cxTextEdit, ExtCtrls, cxLabel;

type
  TfrmControlaServicoTecnico = class(TfrmCadastroGenerico)
    cxGrid1DBTableView1: TcxGridDBTableView;
    cxGrid1Level1: TcxGridLevel;
    cxGrid1: TcxGrid;
    MData: TJvMemoryData;
    MDataCodigoServico: TIntegerField;
    MDataDescricaoServico: TStringField;
    MDataCodigoTecnico: TIntegerField;
    MDataNomeTecnico: TStringField;
    DSTemp: TDataSource;
    MDataPercComissao: TFloatField;
    MDataValorServico: TFloatField;
    MDataValorComissao: TFloatField;
    cxGrid1DBTableView1DescricaoServico: TcxGridDBColumn;
    cxGrid1DBTableView1NomeTecnico: TcxGridDBColumn;
    cxGrid1DBTableView1PercComissao: TcxGridDBColumn;
    cxGrid1DBTableView1ValorServico: TcxGridDBColumn;
    cxGrid1DBTableView1ValorComissao: TcxGridDBColumn;
    edtServico: TStaticText;
    edtTecnicoNome: TStaticText;
    cxGrid1DBTableView1CodServico: TcxGridDBColumn;
    MDataIndice: TIntegerField;
    stCliente: TStaticText;
    stPedido: TStaticText;
    btnInsere: TcxButton;
    edtTecnico: TcxTextEdit;
    Label1: TcxLabel;
    Label2: TcxLabel;
    Label3: TcxLabel;
    Label4: TcxLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure MDataAfterScroll(DataSet: TDataSet);
    procedure edtTecnicoEnter(Sender: TObject);
    procedure edtTecnicoKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtTecnicoKeyPress(Sender: TObject; var Key: Char);
    procedure edtTecnicoExit(Sender: TObject);
    procedure btnInsereClick(Sender: TObject);
    procedure btnGravaClick(Sender: TObject);
    procedure btnCancelaClick(Sender: TObject);
  private
    { Private declarations }
    oListaServicoTecnico: TListaServicoTecnico;
    oComissionado: TComissionado;
    function bCadastroPreenchido: Boolean;
  public
    { Public declarations }
    iPedido:Integer;
    sCliente: String;
  end;

var
  frmControlaServicoTecnico: TfrmControlaServicoTecnico;

implementation

uses uProduto, uPessoa, Contnrs;

{$R *.dfm}

procedure TfrmControlaServicoTecnico.FormCreate(Sender: TObject);
begin
  inherited;
  oListaServicoTecnico := TListaServicoTecnico.Create(frmPrincipal.zcoConexaoBanco);
  oComissionado := TComissionado.Create(frmPrincipal.zcoConexaoBanco);
end;

procedure TfrmControlaServicoTecnico.FormShow(Sender: TObject);
var
  C, iServico: Integer;
begin
  inherited;
  oListaServicoTecnico.AlimentaLista(iPedido);
  if MData.Active then
    Close;
  with MData do
  begin
    Open;
    for C:= 0 to oListaServicoTecnico.Count -1 do
    begin
      Insert;
      iServico := TServicoTecnico(oListaServicoTecnico.oServicoTecnico.Items[C]).GetiServico;
      TServicoTecnico(oListaServicoTecnico.oServicoTecnico.Items[C]).oProduto.bPesquisaProduto(iServico);
      FieldByName('Indice').AsInteger := C;
      FieldByName('CodigoServico').AsInteger := iServico;
      FieldByName('DescricaoServico').AsString := TServicoTecnico(oListaServicoTecnico.oServicoTecnico.Items[C]).oProduto.GetsDescricao;
      FieldByName('ValorServico').AsFloat := TServicoTecnico(oListaServicoTecnico.oServicoTecnico.Items[C]).GetnValorServico;
      Post;
    end;
  end;
  stPedido.Caption := IntToStr(iPedido);
  stCliente.Caption := sCliente;
end;

procedure TfrmControlaServicoTecnico.MDataAfterScroll(DataSet: TDataSet);
begin
  inherited;
  edtServico.Caption := MDataDescricaoServico.AsString;
  edtTecnico.Text := MDataCodigoTecnico.AsString;
  edtTecnicoNome.Caption := MDataNomeTecnico.AsString;
end;

procedure TfrmControlaServicoTecnico.edtTecnicoEnter(Sender: TObject);
begin
  inherited;
  edtTecnico.SelectAll;
end;

procedure TfrmControlaServicoTecnico.edtTecnicoKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  if Key = vk_F2 then begin
     edtTecnico.Text := ChamaPesquisa(TEdit(Sender), frmPrincipal.zcoConexaoBanco)[0];
     edtTecnicoExit(Sender);
  end;
end;

procedure TfrmControlaServicoTecnico.edtTecnicoKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  KeyPressNumerico(Key);
end;

procedure TfrmControlaServicoTecnico.edtTecnicoExit(Sender: TObject);
var
  bTecnicoNaoEncontrado: boolean;
begin
  inherited;
  bTecnicoNaoEncontrado := False;

  if ActiveControl = BtnSair then Exit;

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
    Application.MessageBox(PChar('Tecnico não cadastrado!'),'Aviso',MB_OK);
  end;
end;
procedure TfrmControlaServicoTecnico.btnInsereClick(Sender: TObject);
begin
  inherited;
  if edtTecnicoNome.Caption = '' then Exit;
  with MData do begin
    Edit;
    MDataCodigoTecnico.AsString := edtTecnico.Text;
    MDataNomeTecnico.AsString := edtTecnicoNome.Caption;
    oComissionado.bPesquisaComissionado(edtTecnico.Text);
    MDataPercComissao.AsString :=  oComissionado.sGetComissao;
    MDataValorComissao.Value := (MDataPercComissao.Value/100)*MDataValorServico.Value;
    Post;
  end;
end;

procedure TfrmControlaServicoTecnico.btnGravaClick(Sender: TObject);
var
  C: Integer;
begin
  inherited;
  if not bCadastroPreenchido then begin
    if Application.MessageBox('O controle não foi preenchido totalmente.'+#13+
      'Deseja gravar os dados já informados?', 'Confirmação', MB_YESNO + MB_ICONQUESTION) = mrNo then begin
      Close;
      Exit;
    end;
  end;
  for C:= 0 to oListaServicoTecnico.Count -1 do
  begin
    if MData.Locate('Indice',C,[loCaseInsensitive]) then
    begin
      if not MDataCodigoTecnico.IsNull then begin
        TServicoTecnico(oListaServicoTecnico.oServicoTecnico.Items[C]).SetTecnico(MDataCodigoTecnico.Value);
        TServicoTecnico(oListaServicoTecnico.oServicoTecnico.Items[C]).SetComissao(MDataPercComissao.Value);
        TServicoTecnico(oListaServicoTecnico.oServicoTecnico.Items[C]).SetValorComissao(MDataValorComissao.Value);
        TServicoTecnico(oListaServicoTecnico.oServicoTecnico.Items[C]).Cadastra;
      end;
    end;
  end;
  Close;
end;

function TfrmControlaServicoTecnico.bCadastroPreenchido: Boolean;
begin
  Result := True;
  with MData do
  begin
    First;
    while not Eof do
    begin
      if MDataCodigoTecnico.IsNull then
      begin
        result := False;
        break;
      end;
      Next;
    end;
  end;
end;

procedure TfrmControlaServicoTecnico.btnCancelaClick(Sender: TObject);
begin
  inherited;
  Close;
end;

end.
