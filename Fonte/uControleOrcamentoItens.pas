unit uControleOrcamentoItens;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uCadastroGenerico, cxGraphics, cxLookAndFeels,
  cxLookAndFeelPainters, Vcl.Menus, dxSkinsCore, dxSkinOffice2010Silver, Vcl.StdCtrls, cxButtons,
  Vcl.ExtCtrls, JvExControls, JvNavigationPane, cxControls, cxStyles, dxSkinscxPCPainter,
  cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit, cxNavigator, Data.DB, cxDBData,
  cxGridLevel, cxClasses, cxGridCustomView, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxGrid, Datasnap.DBClient, Datasnap.Provider, ZAbstractRODataset, ZAbstractDataset, ZDataset,
  cxCurrencyEdit;

type
  TfrmControleOrcamentoItens = class(TfrmCadastroGenerico)
    cxGrid1DBTableView1: TcxGridDBTableView;
    cxGrid1Level1: TcxGridLevel;
    cxGrid1: TcxGrid;
    dspItens: TDataSetProvider;
    cdsItens: TClientDataSet;
    dsItens: TDataSource;
    qrItens: TZQuery;
    cdsItensiCodigo: TIntegerField;
    cdsItensiPedido: TIntegerField;
    cdsItensiProduto: TIntegerField;
    cdsItensiMarca: TIntegerField;
    cdsItensiGrupo: TIntegerField;
    cdsItensiSubGrupo: TIntegerField;
    cdsItensnQuantidade: TFloatField;
    cdsItensnValor: TFloatField;
    cxGrid1DBTableView1sProduto: TcxGridDBColumn;
    cxGrid1DBTableView1sMarca: TcxGridDBColumn;
    cxGrid1DBTableView1sGrupo: TcxGridDBColumn;
    cxGrid1DBTableView1sSubGrupo: TcxGridDBColumn;
    cxGrid1DBTableView1nQuantidade: TcxGridDBColumn;
    cxGrid1DBTableView1nValor: TcxGridDBColumn;
    cdsItenssProduto: TWideStringField;
    cdsItenssMarca: TWideStringField;
    cdsItenssGrupo: TWideStringField;
    cdsItenssSubGrupo: TWideStringField;
    cdsItenstotalItem: TFloatField;
    cxGrid1DBTableView1totalItem: TcxGridDBColumn;
    cdsItensnajustevalor: TFloatField;
    cdsItenstotalpedidobruto: TFloatField;
    cdsItenstotalpedidoliquido: TFloatField;
    cxGrid1DBTableView1najustevalor: TcxGridDBColumn;
    cxGrid1DBTableView1totalpedidobruto: TcxGridDBColumn;
    cxGrid1DBTableView1totalpedidoliquido: TcxGridDBColumn;
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmControleOrcamentoItens: TfrmControleOrcamentoItens;

implementation

Uses uPrincipal, uControleOrcamentos;

{$R *.dfm}

procedure TfrmControleOrcamentoItens.FormShow(Sender: TObject);
begin
  inherited;
  with qrItens do
  begin
    Close;
    Connection := frmPrincipal.zcoConexaoBanco;
    SQL.Clear;

    SQL.Add('SELECT PI.icodigo');
    SQL.Add('      ,PI.ipedido');
    SQL.Add('      ,PI.iproduto');
    SQL.Add('      ,p.sdescricao AS "sproduto"');
    SQL.Add('      ,p.imarca');
    SQL.Add('      ,m.sdescricao AS "smarca"');
    SQL.Add('      ,p.igrupo');
    SQL.Add('      ,g.sdescricao AS "sgrupo"');
    SQL.Add('      ,p.isubgrupo');
    SQL.Add('      ,sg.sdescricao AS "ssubgrupo"');
    SQL.Add('      ,PI.nquantidade');
    SQL.Add('      ,PI.nvalor');
    SQL.Add('      ,(PI.nquantidade * PI.nvalor) AS "totalitem"');
    SQL.Add('      ,(pd.najustevalor)');
    SQL.Add('      ,(');
    SQL.Add('           SELECT (SUM((pi2.nquantidade * pi2.nvalor)))');
    SQL.Add('           FROM   tbpedidoitens pi2');
    SQL.Add('           WHERE  pi2.ipedido = PI.ipedido');
    SQL.Add('       ) AS "totalpedidobruto"');
    SQL.Add('      ,(');
    SQL.Add('           SELECT (SUM((pi2.nquantidade * pi2.nvalor)) + (pd.najustevalor))');
    SQL.Add('           FROM   tbpedidoitens pi2');
    SQL.Add('           WHERE  pi2.ipedido = PI.ipedido');
    SQL.Add('       ) AS "totalpedidoliquido"');
    SQL.Add('FROM   tbpedidoitens PI');
    SQL.Add('INNER JOIN tbpedido pd ON pd.icodigo = PI.ipedido');
    SQL.Add('INNER JOIN tbproduto p ON p.icodigo = PI.iproduto');
    SQL.Add('INNER JOIN tbmarca m ON m.icodigo = p.imarca');
    SQL.Add('INNER JOIN tbsubgrupo sg ON sg.icodigo = p.isubgrupo AND sg.igrupo = p.igrupo');
    SQL.Add('INNER JOIN tbgrupo g ON g.icodigo = sg.igrupo');
    SQL.Add('WHERE  PI.ipedido = :pedido');
    SQL.Add('GROUP BY PI.icodigo');
    SQL.Add('      	,p.sDescricao');
    SQL.Add('      	,p.imarca');
    SQL.Add('      	,m.sdescricao');
    SQL.Add('      	,p.igrupo');
    SQL.Add('      	,g.sdescricao');
    SQL.Add('      	,p.isubgrupo');
    SQL.Add('      	,sg.sdescricao');
    SQL.Add('      	,(pd.najustevalor)');
    SQL.Add('ORDER BY PI.icodigo');

    ParamByName('pedido').AsInteger := frmControleOrcamentos.cdsOrcamentoOrcamento.AsInteger;

    Open;
    cdsItens.Close;
    cdsItens.Open;
  end;
end;

end.
