unit uPesquisaGeral;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, JvExControls, JvComponent, JvNavigationPane, Grids,
  DBGrids, StdCtrls, DB, ZAbstractRODataset, ZAbstractDataset, ZDataset,
  ZConnection, cxGraphics, cxLookAndFeels,
  cxLookAndFeelPainters, Menus, cxButtons, cxControls, cxContainer, cxEdit,
  cxTextEdit, dxSkinsCore, dxSkinOffice2010Silver, Vcl.ExtCtrls, Datasnap.Provider,
  Datasnap.DBClient, cxStyles, dxSkinscxPCPainter, cxCustomData, cxFilter, cxData, cxDataStorage,
  cxNavigator, cxDBData, cxGridLevel, cxClasses, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGrid;

type
  TResultArray = array of string;

function Pesquisar(iCodigoPesquisa: integer; sTextoPesquisa: string; pzcoConnection: TZConnection; sParametroExt: string = '';
  pExibeBtnCad: Boolean = False; pExibeBtnOk: Boolean = True): TResultArray;

type

  TfrmPesquisaGeral = class(TForm)
    dsPesquisa: TDataSource;
    ZQueryPesquisa: TZQuery;
    pnRodape: TPanel;
    dbgPesquisa: TDBGrid;
    pnlTexto: TPanel;
    edtPesquisa: TcxTextEdit;
    pnlTopo: TJvNavPanelHeader;
    cdsPesquisa: TClientDataSet;
    dspPesquisa: TDataSetProvider;
    btnsair: TcxButton;
    btnOk: TcxButton;
    btnCadastro: TcxButton;
    procedure edtPesquisaChange(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure BtnSairClick(Sender: TObject);
    procedure dbgPesquisaDblClick(Sender: TObject);
    procedure btnOkClick(Sender: TObject);
    procedure btnCadastroClick(Sender: TObject);
  private
    { Private declarations }
    sDescricao: string;
    sComando: string;
    sCampo: string;
    sParametro: string;
    sCampoRetorno: string;
    sTexto: string;
    sfrmCadastro: string;
    procedure MontaPesquisa(pAll: Boolean = False);
  public
    { Public declarations }
  end;

var
  frmPesquisaGeral: TfrmPesquisaGeral;

implementation

Uses usoGeral, uPrincipal;

{$R *.dfm}

function Pesquisar(iCodigoPesquisa: integer; sTextoPesquisa: string; pzcoConnection: TZConnection; sParametroExt: string = '';
  pExibeBtnCad: Boolean = False; pExibeBtnOk: Boolean = True): TResultArray;
var
  zQryPesquisa: TZQuery;
  i: integer;
  vLista: TStringList;
begin
  zQryPesquisa := TZQuery.Create(nil);
  zQryPesquisa.Connection := pzcoConnection;
  with zQryPesquisa do
  begin
    SQL.Clear;
    SQL.Add('SELECT * FROM TBPESQUISA');
    SQL.Add('WHERE iCODIGO = ' + IntToStr(iCodigoPesquisa));
    Open;

    if IsEmpty then
    begin
      pMsgAtencao('Item de Pesquisa não definido. Entre em contato com o suporte.');
      Abort;
    end;

    frmPesquisaGeral := TfrmPesquisaGeral.Create(nil);
    with frmPesquisaGeral do
    begin
      Caption := FieldByName('sDescricao').AsString;
      sDescricao := FieldByName('sDescricao').AsString;
      sComando := FieldByName('sComando').AsString;
      sCampo := FieldByName('sCampo').AsString;

      sParametro := FieldByName('sParametroComplementar').AsString + ' ' + sParametroExt;

      sCampoRetorno := FieldByName('sCampoRetorno').AsString;
      sTexto := sTextoPesquisa;
      sfrmCadastro := FieldByName('frmCadastro').AsString;

      ZQueryPesquisa.Connection := pzcoConnection;
      MontaPesquisa;

      btnCadastro.Visible := ((pExibeBtnCad) and (Trim(sfrmCadastro) <> ''));
      btnOk.Visible := pExibeBtnOk;
      btnOk.Enabled := pExibeBtnOk;

      frmPesquisaGeral.ShowModal;

      if frmPesquisaGeral.ModalResult = mrOk then
      begin
        vLista := TStringList.Create;
        ExtractStrings([';'], [], PChar(sCampoRetorno), vLista);

        SetLength(Result, vLista.Count);
        for i := 0 to vLista.Count - 1 do
          Result[i] := cdsPesquisa.FieldByName(Trim(vLista.Strings[i])).AsString;

        FreeAndNil(vLista);
        Close;
      end
      else
        Abort;
    end;
  end;
end;

{ TfrmPesquisaGeral }

procedure TfrmPesquisaGeral.MontaPesquisa(pAll: Boolean = False);
begin
  with ZQueryPesquisa do
  begin
    SQL.Clear;
    SQL.Add(sComando);
    SQL.Add(sParametro);

    if not pAll then
      if Trim(edtPesquisa.Text) <> '' then
        SQL.Add('and ' + sCampo + ' LIKE ' + QuotedSTr(edtPesquisa.Text + '%'));

    SQL.Add('ORDER BY ' + sCampo);
    Open;

    cdsPesquisa.Close;
    cdsPesquisa.Open;;
  end;
end;

procedure TfrmPesquisaGeral.btnCadastroClick(Sender: TObject);
begin
  with frmPrincipal do
  begin
    if sfrmCadastro = 'frmCadastroCidade' then
      uCadastroCidade.OnClick(uCadastroCidade)
    else if sfrmCadastro = 'frmCadastroGrupo' then
      uCadastroGrupo.OnClick(uCadastroGrupo)
    else if sfrmCadastro = 'frmCadastroMarca' then
      uCadastroMarca.OnClick(uCadastroMarca)
    else if sfrmCadastro = 'frmCadastroUnidade' then
      uCadastroUnidade.OnClick(uCadastroUnidade)
    else if sfrmCadastro = 'frmCadastroSubGrupo' then
      uCadastroSubGrupo.OnClick(uCadastroSubGrupo)
    else if sfrmCadastro = 'frmCadastroRamoAtividade' then
      uCadastroRamoAtividade.OnClick(uCadastroRamoAtividade)
    else if sfrmCadastro = 'frmCadastroComissionado' then
      uCadastroComissionado.OnClick(uCadastroComissionado)
    else if sfrmCadastro = 'frmCadastroProduto' then
      uCadastroProduto.OnClick(uCadastroProduto)
    else if sfrmCadastro = 'frmCadastroCliente' then
      uCadastroCliente.OnClick(uCadastroCliente)
    else if sfrmCadastro = 'frmCadastroTabelaPreco' then
      uCadastroTabelaPreco.OnClick(uCadastroTabelaPreco)
    else if sfrmCadastro = 'frmCadastroNaturezaOperacao' then
      uCadastroNaturezaOperacao.OnClick(uCadastroNaturezaOperacao)
    else if sfrmCadastro = 'frmCadastroCodigoFiscal' then
      uCadastroCodigoFiscal.OnClick(uCadastroCodigoFiscal)
    else if sfrmCadastro = 'frmPlacas' then
      uCadastroPlacas.OnClick(uCadastroPlacas)
    else if sfrmCadastro = 'frmCadastroUsuarios' then
      uCadastroUsuario.OnClick(uCadastroUsuario)
    else if sfrmCadastro = 'frmCadastroGrupoUsuario' then
      uCadastroGrupoUsuario.OnClick(uCadastroGrupoUsuario)
    else if sfrmCadastro = 'frmCadastroNCM' then
      uCadastroNCM.OnClick(uCadastroNCM)
    else if sfrmCadastro = 'frmCadastroFornecedor' then
      uCadastroClienteFornecedor.OnClick(uCadastroClienteFornecedor)
    else if sfrmCadastro = 'frmCadastroCor' then
      uCadastroCor.OnClick(uCadastroCor);
  end;
  Self.ModalResult := mrNone;
  MontaPesquisa(True);
  if Trim(edtPesquisa.Text) <> '' then
    edtPesquisa.Properties.OnChange(edtPesquisa);
end;

procedure TfrmPesquisaGeral.btnOkClick(Sender: TObject);
begin
  Self.ModalResult := mrOk;
end;

procedure TfrmPesquisaGeral.BtnSairClick(Sender: TObject);
begin
  Self.Close;
end;

procedure TfrmPesquisaGeral.dbgPesquisaDblClick(Sender: TObject);
begin
  btnOk.OnClick(btnOk);
end;

procedure TfrmPesquisaGeral.edtPesquisaChange(Sender: TObject);
var
  vFiltros: string;
  vResult, vContador: integer;
begin
  if Trim(edtPesquisa.Text) <> '' then
  begin
    vContador := 0;
    vFiltros := '';
    cdsPesquisa.Filtered := False;

    for vContador := 0 to cdsPesquisa.FieldCount - 1 do
    begin
      if vContador = 0 then
      begin
        if not((cdsPesquisa.Fields[vContador].DataType = ftDateTime) or (cdsPesquisa.Fields[vContador].DataType = ftDate)) then
        begin
          if (cdsPesquisa.Fields[vContador].DataType = ftInteger) or (cdsPesquisa.Fields[vContador].DataType = ftLargeint) or
            (cdsPesquisa.Fields[vContador].DataType = ftSmallint) or (cdsPesquisa.Fields[vContador] is TAutoIncField) then
          begin
            if TryStrToInt(edtPesquisa.Text, vResult) then
              vFiltros := cdsPesquisa.Fields[vContador].FieldName + '=' + QuotedSTr(edtPesquisa.Text)
            else
              vFiltros := cdsPesquisa.Fields[vContador].FieldName + '=' + '-1';
          end
          else
            vFiltros := 'lower(' + cdsPesquisa.Fields[vContador].FieldName + ')' + ' like ' + QuotedSTr('%' + lowercase(edtPesquisa.Text) + '%');
        end;
      end
      else if vContador <= cdsPesquisa.FieldCount - 1 then
      begin
        if vFiltros <> '' then
        begin
          if not((cdsPesquisa.Fields[vContador].DataType = ftDateTime) or (cdsPesquisa.Fields[vContador].DataType = ftDate)) then
          begin
            if (cdsPesquisa.Fields[vContador].DataType = ftInteger) or (cdsPesquisa.Fields[vContador].DataType = ftLargeint) or
              (cdsPesquisa.Fields[vContador].DataType = ftSmallint) or (cdsPesquisa.Fields[vContador] is TAutoIncField) then
            begin
              if TryStrToInt(edtPesquisa.Text, vResult) then
                vFiltros := vFiltros + ' OR ' + cdsPesquisa.Fields[vContador].FieldName + '=' + QuotedSTr(edtPesquisa.Text)
              else
                vFiltros := vFiltros + ' OR ' + cdsPesquisa.Fields[vContador].FieldName + '=' + '-1';
            end
            else
              vFiltros := vFiltros + ' OR ' + 'lower(' + cdsPesquisa.Fields[vContador].FieldName + ')' + ' like ' +
                QuotedSTr('%' + lowercase(edtPesquisa.Text) + '%');
          end;
        end
        else
        begin
          if not((cdsPesquisa.Fields[vContador].DataType = ftDateTime) or (cdsPesquisa.Fields[vContador].DataType = ftDate)) then
          begin
            if (cdsPesquisa.Fields[vContador].DataType = ftInteger) or (cdsPesquisa.Fields[vContador].DataType = ftLargeint) or
              (cdsPesquisa.Fields[vContador].DataType = ftSmallint) or (cdsPesquisa.Fields[vContador] is TAutoIncField) then
            begin
              if TryStrToInt(edtPesquisa.Text, vResult) then
                vFiltros := vFiltros + cdsPesquisa.Fields[vContador].FieldName + '=' + QuotedSTr(edtPesquisa.Text)
              else
                vFiltros := vFiltros + cdsPesquisa.Fields[vContador].FieldName + '=' + '-1';
            end
            else
              vFiltros := vFiltros + 'lower(' + cdsPesquisa.Fields[vContador].FieldName + ')' + ' like ' +
                QuotedSTr('%' + lowercase(edtPesquisa.Text) + '%');
          end;
        end;
      end;
    end;
    cdsPesquisa.Filter := vFiltros;
    cdsPesquisa.Filtered := True;
  end
  else
  begin
    cdsPesquisa.Filter := '';
    cdsPesquisa.Filtered := True;
  end;
end;

procedure TfrmPesquisaGeral.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = vk_Up then
  begin
    dbgPesquisa.DataSource.DataSet.Prior;
    Key := 0;
  end;
  if Key = vk_Down then
  begin
    dbgPesquisa.DataSource.DataSet.Next;
    Key := 0;
  end;
  if Key = vk_Next then
  begin
    dbgPesquisa.DataSource.DataSet.MoveBy(5);
    Key := 0;
  end;
  if Key = vk_Prior then
  begin
    dbgPesquisa.DataSource.DataSet.MoveBy(-5);
    Key := 0;
  end;
end;

procedure TfrmPesquisaGeral.FormShow(Sender: TObject);
begin
  MontaPesquisa;
  edtPesquisa.SetFocus;
end;

end.
