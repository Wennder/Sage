unit uCadastroControleAcesso;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uCadastroGenerico, JvExControls,
  JvComponent, JvNavigationPane, cxStyles, cxCustomData,
  cxGraphics, cxFilter, cxData, cxDataStorage, cxEdit, DB, cxDBData,
  StdCtrls, cxGridLevel, cxClasses, cxControls, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid,
  JvMemoryDataset, uControleAcesso, uGrupoUsuario, cxCheckBox, cxLookAndFeels,
  cxLookAndFeelPainters, Menus, cxButtons, ExtCtrls, cxContainer, cxTextEdit,
  cxLabel, dxSkinsCore, dxSkinOffice2010Silver, dxSkinscxPCPainter, cxNavigator, Datasnap.DBClient;

type
  TfrmCadastroControleAcesso = class(TfrmCadastroGenerico)
    cxGrid: TcxGrid;
    cxGridDBTableView1: TcxGridDBTableView;
    cxGridLevel1: TcxGridLevel;
    stDescricaoGrupo: TStaticText;
    dsAcesso: TDataSource;
    cxGridDBTableView1Marca: TcxGridDBColumn;
    cxGridDBTableView1CodigoRotina: TcxGridDBColumn;
    cxGridDBTableView1DescricaoRotina: TcxGridDBColumn;
    cxGridDBTableView1Tipo: TcxGridDBColumn;
    edtGrupoUsuario: TcxTextEdit;
    Label2: TcxLabel;
    cdsAcesso: TClientDataSet;
    cdsAcessoMarca: TBooleanField;
    cdsAcessoCodigoRotina: TIntegerField;
    cdsAcessoDescricaoRotina: TStringField;
    cdsAcessoTipo: TStringField;
    procedure FormShow(Sender: TObject);
    procedure edtGrupoUsuarioEnter(Sender: TObject);
    procedure edtGrupoUsuarioExit(Sender: TObject);
    procedure edtGrupoUsuarioKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edtGrupoUsuarioKeyPress(Sender: TObject; var Key: Char);
    procedure btnGravaClick(Sender: TObject);
    procedure btnCancelaClick(Sender: TObject);
  private
    { Private declarations }
    procedure InicializaForm;
  public
    { Public declarations }
    oAcesso: TAcesso;
    oGrupoUsuario: TGrupoUsuario;
    oControleAcesso: TControleAcesso;
  end;

var
  frmCadastroControleAcesso: TfrmCadastroControleAcesso;

implementation

uses uPrincipal, UsoGeral;

{$R *.dfm}

procedure TfrmCadastroControleAcesso.FormShow(Sender: TObject);
begin
  inherited;
  oAcesso := TAcesso.Create(frmPrincipal.zcoConexaoBanco);
  oControleAcesso := TControleAcesso.Create(frmPrincipal.zcoConexaoBanco);
  oGrupoUsuario := TGrupoUsuario.Create(frmPrincipal.zcoConexaoBanco);
end;

procedure TfrmCadastroControleAcesso.InicializaForm;
begin
  LimpaCampos(self, [nil]);
  edtGrupoUsuario.SetFocus;
end;

procedure TfrmCadastroControleAcesso.btnCancelaClick(Sender: TObject);
begin
  inherited;
  cdsAcesso.EmptyDataSet;
  cdsAcesso.Close;
  InicializaForm;
end;

procedure TfrmCadastroControleAcesso.btnGravaClick(Sender: TObject);
begin
  inherited;
  if Trim(edtGrupoUsuario.Text) = '' then
  begin
    pMsgAtencao('Nenhum grupo foi informado para configuração dos acessos.');
    edtGrupoUsuario.SetFocus;
    Abort;
  end;

  with cdsAcesso do
  begin
    First;
    while not Eof do
    begin
      oControleAcesso.SetCodigoMenu(FieldByName('CodigoRotina').AsInteger);
      if FieldByName('Marca').AsBoolean then
        oControleAcesso.CadastraAcesso
      else
        oControleAcesso.DeletaAcesso;
      Next;
    end;
    pMsgInfo('Acessos configurados com sucesso!');
    btnCancela.OnClick(btnCancela);
  end;
end;

procedure TfrmCadastroControleAcesso.edtGrupoUsuarioEnter(Sender: TObject);
begin
  inherited;
  edtGrupoUsuario.SelectAll;
end;

procedure TfrmCadastroControleAcesso.edtGrupoUsuarioExit(Sender: TObject);
var
  Iindice: string;
  oListaRotina: TListaRotinas;
  bGrupoUsuarioNaoEncontrado: Boolean;

  procedure InsereRotinasGrid;
  var
    i: Integer;
  begin
    oListaRotina := TListaRotinas.Create(frmPrincipal.zcoConexaoBanco);
    oListaRotina.ListaRotinas(StrToInt(edtGrupoUsuario.Text));

    with cdsAcesso do
    begin
      Close;
      CreateDataSet;
      EmptyDataSet;
      Open;
      for i := 0 to oListaRotina.oListaRotinas.Count - 1 do
      begin
        Append;
        FieldByName('CodigoRotina').AsInteger := TRotina(oListaRotina.oListaRotinas.Items[i]).GetiCodigo;
        FieldByName('DescricaoRotina').AsString := TRotina(oListaRotina.oListaRotinas.Items[i]).GetsDescricao;
        FieldByName('Tipo').AsString := TRotina(oListaRotina.oListaRotinas.Items[i]).GetsTipo;
        FieldByName('Marca').AsBoolean := TRotina(oListaRotina.oListaRotinas.Items[i]).GetTemAcesso;
        Post;
      end;
      cdsAcesso.First;
      cxGrid.SetFocus;
    end;
    FreeAndNil(oListaRotina);
  end;

begin
  inherited;
  bGrupoUsuarioNaoEncontrado := False;
  if ActiveControl = BtnSair then
    Exit;

  if (edtGrupoUsuario.Text = '') or (edtGrupoUsuario.Text = '0') then
  begin
    stDescricaoGrupo.Caption := '';
    edtGrupoUsuario.Clear;
    cdsAcesso.Close;
    Exit;
  end;

  if oGrupoUsuario.bPesquisaGrupoUsuario(StrToInt(edtGrupoUsuario.Text)) then
  begin
    if oGrupoUsuario.GetsStatus = 'A' then
    begin
      oControleAcesso.SetCodigoGrupo(oGrupoUsuario.GetiCodigo);
      stDescricaoGrupo.Caption := oGrupoUsuario.GetsNome;
      stDescricaoGrupo.Caption := oGrupoUsuario.GetsNome;
      InsereRotinasGrid;
    end
    else
      bGrupoUsuarioNaoEncontrado := True;
  end
  else
    bGrupoUsuarioNaoEncontrado := True;
end;

procedure TfrmCadastroControleAcesso.edtGrupoUsuarioKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  if Key = vk_F2 then
  begin
    edtGrupoUsuario.Text := ChamaPesquisa(TEdit(Sender), frmPrincipal.zcoConexaoBanco)[0];
    edtGrupoUsuarioExit(Sender);
  end;
end;

procedure TfrmCadastroControleAcesso.edtGrupoUsuarioKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  KeyPressNumerico(Key);
end;

end.
