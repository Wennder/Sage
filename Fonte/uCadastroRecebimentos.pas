unit uCadastroRecebimentos;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uCadastroGenerico, cxGraphics,
  cxLookAndFeels, cxLookAndFeelPainters, Vcl.Menus, dxSkinsCore,
  dxSkinOffice2010Silver, Vcl.StdCtrls, cxButtons, Vcl.ExtCtrls, JvExControls,
  JvNavigationPane, cxControls, cxStyles, dxSkinscxPCPainter, cxCustomData,
  cxFilter, cxData, cxDataStorage, cxEdit, cxNavigator, Data.DB, cxDBData,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, SQLMemMain,
  cxGridCustomView, cxClasses, cxGridLevel, cxGrid, Datasnap.DBClient;

type
  TfrmCadastroRecebimentos = class(TfrmCadastroGenerico)
    cxGrid1Level1: TcxGridLevel;
    cxGrid1: TcxGrid;
    cxStyleRepository1: TcxStyleRepository;
    cxStyle1: TcxStyle;
    DataSource1: TDataSource;
    cxStyle2: TcxStyle;
    cxGrid1DBTableView1: TcxGridDBTableView;
    ClientDataSet1: TClientDataSet;
    ClientDataSet1FormaRecebimento: TStringField;
    ClientDataSet1Valor: TFloatField;
    cxGrid1DBTableView1FormaRecebimento: TcxGridDBColumn;
    cxGrid1DBTableView1Valor: TcxGridDBColumn;
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmCadastroRecebimentos: TfrmCadastroRecebimentos;

implementation

{$R *.dfm}

procedure TfrmCadastroRecebimentos.FormShow(Sender: TObject);
begin
  inherited;
  with ClientDataSet1 do
  begin
    Open;

    Insert;
    FieldByName('FormaRecebimento').Value := 'Dinheiro';
    FieldByName('Valor').Value := 0;
    Post;

    Insert;
    FieldByName('FormaRecebimento').Value := 'Cheque';
    FieldByName('Valor').Value := 0;
    Post;

    Insert;
    FieldByName('FormaRecebimento').Value := 'Cart�o';
    FieldByName('Valor').Value := 0;
    Post;

    Insert;
    FieldByName('FormaRecebimento').Value := 'Credi�rio';
    FieldByName('Valor').Value := 0;
    Post;

  end;
end;

end.
