inherited frmFaturaPedido: TfrmFaturaPedido
  Caption = 'Fatura Pedido'
  ClientHeight = 450
  ClientWidth = 420
  OldCreateOrder = True
  OnShow = FormShow
  ExplicitTop = -57
  ExplicitWidth = 426
  ExplicitHeight = 478
  PixelsPerInch = 96
  TextHeight = 13
  inherited JvNavPaneToolPanel1: TJvNavPaneToolPanel
    Width = 420
    Height = 450
    ExplicitWidth = 420
    ExplicitHeight = 459
    inherited pn: TPanel
      Top = 415
      Width = 416
      TabOrder = 9
      ExplicitTop = 424
      ExplicitWidth = 416
      inherited btnGrava: TcxButton
        Left = 94
        OnClick = btnGravaClick
        ExplicitLeft = 94
      end
      inherited btnCancela: TcxButton
        Left = 175
        OnClick = btnCancelaClick
        ExplicitLeft = 175
      end
      inherited brnDeleta: TcxButton
        Left = 256
        ExplicitLeft = 256
      end
      inherited BtnSair: TcxButton
        Left = 337
        ExplicitLeft = 337
      end
    end
    object edtDataPedido: TStaticText
      Left = 280
      Top = 54
      Width = 129
      Height = 21
      AutoSize = False
      BevelKind = bkFlat
      BorderStyle = sbsSingle
      Color = clBtnFace
      ParentColor = False
      TabOrder = 1
      Transparent = False
    end
    object edtCliente: TStaticText
      Left = 10
      Top = 94
      Width = 399
      Height = 21
      AutoSize = False
      BevelKind = bkFlat
      BorderStyle = sbsSingle
      Color = clBtnFace
      ParentColor = False
      TabOrder = 2
      Transparent = False
    end
    object cxGrid1: TcxGrid
      Left = 11
      Top = 171
      Width = 396
      Height = 238
      TabOrder = 6
      TabStop = False
      object cxGrid1DBTableView1: TcxGridDBTableView
        NavigatorButtons.ConfirmDelete = False
        DataController.DataSource = DataSource
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <
          item
            Format = '#,##0.00'
            Kind = skSum
            FieldName = 'Valor'
          end>
        DataController.Summary.SummaryGroups = <>
        OptionsData.Appending = True
        OptionsData.Deleting = False
        OptionsData.Editing = False
        OptionsData.Inserting = False
        OptionsView.Footer = True
        object cxGrid1DBTableView1Fatura: TcxGridDBColumn
          DataBinding.FieldName = 'Fatura'
          Width = 156
        end
        object cxGrid1DBTableView1Vencimento: TcxGridDBColumn
          DataBinding.FieldName = 'Vencimento'
          Width = 95
        end
        object cxGrid1DBTableView1Valor: TcxGridDBColumn
          DataBinding.FieldName = 'Valor'
          Width = 93
        end
      end
      object cxGrid1Level1: TcxGridLevel
        GridView = cxGrid1DBTableView1
      end
    end
    object edtDataEmissao: TMaskEdit
      Left = 157
      Top = 140
      Width = 90
      Height = 21
      CharCase = ecUpperCase
      EditMask = '99/99/9999;1; '
      MaxLength = 10
      TabOrder = 4
      Text = '  /  /    '
    end
    object cxCurrencyEditValor: TcxCurrencyEdit
      Left = 248
      Top = 140
      TabOrder = 5
      Width = 91
    end
    object btnInsere: TcxButton
      Left = 341
      Top = 123
      Width = 66
      Height = 21
      Caption = '&Insere'
      Spacing = 3
      TabOrder = 7
      WordWrap = True
      OnClick = btnInsereClick
    end
    object btnDeleta: TcxButton
      Left = 341
      Top = 149
      Width = 65
      Height = 21
      Caption = '&Deleta'
      Spacing = 3
      TabOrder = 8
      WordWrap = True
      OnClick = btnDeletaClick
    end
    object edtPedido: TcxTextEdit
      Tag = 13
      Left = 8
      Top = 56
      TabOrder = 0
      OnEnter = edtPedidoEnter
      OnExit = edtPedidoExit
      OnKeyDown = edtPedidoKeyDown
      OnKeyPress = edtPedidoKeyPress
      Width = 81
    end
    object EditFatura: TcxTextEdit
      Tag = 13
      Left = 12
      Top = 141
      TabOrder = 3
      Width = 141
    end
    object Label1: TcxLabel
      Left = 8
      Top = 40
      Caption = 'Pedido:'
      Transparent = True
    end
    object Label3: TcxLabel
      Left = 282
      Top = 40
      Caption = 'Data do Pedido:'
      Transparent = True
    end
    object LabelFatura: TcxLabel
      Left = 12
      Top = 125
      Caption = 'Fatura'
      Transparent = True
    end
    object LabelVencimento: TcxLabel
      Left = 159
      Top = 125
      Caption = 'Vencimento:'
      Transparent = True
    end
    object LabelValor: TcxLabel
      Left = 304
      Top = 124
      Caption = 'Valor'
      Transparent = True
    end
  end
  object SQLMemTable: TSQLMemTable
    CurrentVersion = '4.50 '
    DatabaseName = 'MEMORY'
    ReadOnly = False
    TableName = 'tbfatura'
    Exclusive = False
    MemoryTableAllocBy = 1000
    Left = 232
    Top = 200
    object SQLMemTableFatura: TStringField
      FieldName = 'Fatura'
      Size = 100
    end
    object SQLMemTableVencimento: TDateField
      FieldName = 'Vencimento'
      DisplayFormat = 'dd/mm/yyyy'
    end
    object SQLMemTableValor: TFloatField
      FieldName = 'Valor'
      DisplayFormat = '#,##0.00'
    end
  end
  object DataSource: TDataSource
    DataSet = SQLMemTable
    Left = 264
    Top = 200
  end
  object Query: TZQuery
    Params = <>
    Left = 279
    Top = 231
  end
end
