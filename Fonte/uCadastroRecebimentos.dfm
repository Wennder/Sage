inherited frmCadastroRecebimentos: TfrmCadastroRecebimentos
  Caption = 'Recebimentos'
  OnShow = FormShow
  ExplicitWidth = 623
  ExplicitHeight = 445
  PixelsPerInch = 96
  TextHeight = 13
  inherited JvNavPaneToolPanel1: TJvNavPaneToolPanel
    inherited pn: TPanel
      ExplicitWidth = 613
      inherited btnGrava: TcxButton
        ExplicitLeft = 9
      end
      inherited btnCancela: TcxButton
        ExplicitLeft = 312
      end
      inherited brnDeleta: TcxButton
        ExplicitLeft = 413
      end
      inherited BtnSair: TcxButton
        ExplicitLeft = 514
      end
      inherited btnExportar: TcxButton
        ExplicitLeft = 211
      end
      inherited btnImprimir: TcxButton
        ExplicitLeft = 110
      end
    end
    object cxGrid1: TcxGrid
      Left = 2
      Top = 33
      Width = 613
      Height = 348
      Align = alClient
      TabOrder = 1
      object cxGrid1DBTableView1: TcxGridDBTableView
        Navigator.Buttons.CustomButtons = <>
        DataController.DataSource = DataSource1
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        OptionsData.Deleting = False
        OptionsData.Inserting = False
        OptionsView.ColumnAutoWidth = True
        OptionsView.GroupByBox = False
        Styles.Content = cxStyle1
        Styles.Header = cxStyle2
        object cxGrid1DBTableView1FormaRecebimento: TcxGridDBColumn
          DataBinding.FieldName = 'FormaRecebimento'
          Options.Editing = False
        end
        object cxGrid1DBTableView1Valor: TcxGridDBColumn
          DataBinding.FieldName = 'Valor'
        end
      end
      object cxGrid1Level1: TcxGridLevel
        GridView = cxGrid1DBTableView1
      end
    end
  end
  inherited SaveDlg: TSaveDialog
    Left = 568
    Top = 352
  end
  object cxStyleRepository1: TcxStyleRepository
    Left = 56
    Top = 328
    PixelsPerInch = 96
    object cxStyle1: TcxStyle
      AssignedValues = [svFont]
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -40
      Font.Name = 'Segoe UI'
      Font.Style = []
    end
    object cxStyle2: TcxStyle
      AssignedValues = [svFont]
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Segoe UI'
      Font.Style = []
    end
  end
  object DataSource1: TDataSource
    DataSet = ClientDataSet1
    Left = 208
    Top = 336
  end
  object ClientDataSet1: TClientDataSet
    Active = True
    Aggregates = <>
    Params = <>
    Left = 296
    Top = 208
    Data = {
      4D0000009619E0BD0100000018000000020000000000030000004D0010466F72
      6D615265636562696D656E746F0100490000000100055749445448020002001E
      000556616C6F7208000400000000000000}
    object ClientDataSet1FormaRecebimento: TStringField
      FieldName = 'FormaRecebimento'
      Size = 30
    end
    object ClientDataSet1Valor: TFloatField
      FieldName = 'Valor'
      DisplayFormat = '#,##0.00'
    end
  end
end
