inherited frmCadastroConta: TfrmCadastroConta
  Caption = 'Cadastro de Contas'
  ClientHeight = 394
  ClientWidth = 489
  OldCreateOrder = True
  OnShow = FormShow
  ExplicitWidth = 495
  ExplicitHeight = 422
  PixelsPerInch = 96
  TextHeight = 13
  inherited JvNavPaneToolPanel1: TJvNavPaneToolPanel
    Width = 489
    Height = 394
    inherited pn: TPanel
      Top = 359
      Width = 485
      TabOrder = 8
      ExplicitTop = 381
      ExplicitWidth = 774
      inherited btnGrava: TcxButton
        Left = 83
        OnClick = btnGravaClick
        ExplicitLeft = 380
        ExplicitTop = -4
      end
      inherited btnCancela: TcxButton
        Left = 184
        ExplicitLeft = 473
      end
      inherited brnDeleta: TcxButton
        Left = 285
        ExplicitLeft = 574
      end
      inherited BtnSair: TcxButton
        Left = 386
        ExplicitLeft = 675
      end
      inherited btnExportar: TcxButton
        Left = -18
        ExplicitLeft = 372
      end
      inherited btnImprimir: TcxButton
        Left = -119
        ExplicitLeft = 271
      end
    end
    object stCliente: TStaticText
      Left = 69
      Top = 46
      Width = 412
      Height = 21
      AutoSize = False
      BevelKind = bkFlat
      BorderStyle = sbsSingle
      Color = clBtnFace
      ParentColor = False
      TabOrder = 1
      Transparent = False
    end
    object edtDataEmissao: TMaskEdit
      Left = 166
      Top = 85
      Width = 90
      Height = 21
      CharCase = ecUpperCase
      EditMask = '99/99/9999;1; '
      MaxLength = 10
      TabOrder = 4
      Text = '  /  /    '
      OnExit = edtDataEmissaoExit
    end
    object cxCurrencyEditValor: TcxCurrencyEdit
      Left = 259
      Top = 85
      TabOrder = 5
      Width = 121
    end
    object cxGrid1: TcxGrid
      Left = 8
      Top = 112
      Width = 472
      Height = 238
      TabOrder = 7
      object cxGrid1DBTableView1: TcxGridDBTableView
        Navigator.Buttons.CustomButtons = <>
        DataController.DataSource = DataSource
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <
          item
            Format = '#,##0.00'
            Kind = skSum
            FieldName = 'Valor'
            Column = cxGrid1DBTableView1Valor
          end>
        DataController.Summary.SummaryGroups = <>
        OptionsData.Appending = True
        OptionsData.Deleting = False
        OptionsData.Editing = False
        OptionsData.Inserting = False
        OptionsView.Footer = True
        object cxGrid1DBTableView1Parcela: TcxGridDBColumn
          DataBinding.FieldName = 'Parcela'
          Options.Editing = False
          Options.Filtering = False
          Options.Sorting = False
          SortIndex = 0
          SortOrder = soAscending
          Width = 70
        end
        object cxGrid1DBTableView1Vencimento: TcxGridDBColumn
          DataBinding.FieldName = 'Vencimento'
          Options.Filtering = False
          Options.Sorting = False
          Width = 99
        end
        object cxGrid1DBTableView1Valor: TcxGridDBColumn
          DataBinding.FieldName = 'Valor'
          Options.Filtering = False
          Options.Sorting = False
          Width = 94
        end
      end
      object cxGrid1Level1: TcxGridLevel
        GridView = cxGrid1DBTableView1
      end
    end
    object edtCliente: TcxTextEdit
      Tag = 9
      Left = 8
      Top = 46
      TabOrder = 0
      OnEnter = edtClienteEnter
      OnExit = edtClienteExit
      OnKeyDown = edtClienteKeyDown
      OnKeyPress = edtClienteKeyPress
      Width = 60
    end
    object EditSerie: TcxTextEdit
      Tag = 9
      Left = 8
      Top = 86
      TabOrder = 2
      Width = 60
    end
    object EditNumero: TcxTextEdit
      Tag = 9
      Left = 72
      Top = 86
      TabOrder = 3
      Width = 89
    end
    object EditParcelas: TcxTextEdit
      Tag = 9
      Left = 399
      Top = 85
      TabOrder = 6
      Text = '1'
      OnExit = EditParcelasExit
      OnKeyPress = EditParcelasKeyPress
      Width = 76
    end
    object lblCliente: TcxLabel
      Left = 8
      Top = 33
      Caption = 'Cliente'
      Transparent = True
    end
    object LabelSerie: TcxLabel
      Left = 9
      Top = 70
      Caption = 'S'#233'rie'
      Transparent = True
    end
    object LabelNumero: TcxLabel
      Left = 73
      Top = 70
      Caption = 'N'#250'mero'
      Transparent = True
    end
    object LabelEmissao: TcxLabel
      Left = 168
      Top = 70
      Caption = 'Emiss'#227'o'
      Transparent = True
    end
    object LabelQtdParcelas: TcxLabel
      Left = 399
      Top = 70
      Caption = 'Qtd. Parcelas'
      Transparent = True
    end
    object LabelValor: TcxLabel
      Left = 347
      Top = 70
      Caption = 'Valor'
      Transparent = True
    end
  end
  object SQLMemTable: TSQLMemTable
    CurrentVersion = '6.00 '
    DatabaseName = 'MEMORY'
    ReadOnly = False
    CaseInsensitive = False
    TableName = 'tbparcela'
    Exclusive = False
    MemoryTableAllocBy = 1000
    Left = 232
    Top = 200
    object SQLMemTableParcela: TIntegerField
      FieldName = 'Parcela'
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
end
