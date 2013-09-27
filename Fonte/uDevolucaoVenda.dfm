inherited frmDevolucaoVenda: TfrmDevolucaoVenda
  Caption = 'Devolu'#231#227'o de Venda'
  ClientHeight = 501
  ClientWidth = 781
  OnShow = FormShow
  ExplicitWidth = 787
  ExplicitHeight = 529
  PixelsPerInch = 96
  TextHeight = 13
  inherited JvNavPaneToolPanel1: TJvNavPaneToolPanel
    Width = 781
    Height = 501
    ExplicitLeft = 8
    ExplicitWidth = 617
    ExplicitHeight = 416
    object Bevel1: TBevel [0]
      Left = 3
      Top = 27
      Width = 771
      Height = 119
    end
    inherited pn: TPanel
      Top = 466
      Width = 777
      TabOrder = 7
      ExplicitTop = 466
      ExplicitWidth = 777
      inherited btnGrava: TcxButton
        Left = 173
        OnClick = btnGravaClick
        ExplicitLeft = 173
      end
      inherited btnCancela: TcxButton
        Left = 476
        OnClick = btnCancelaClick
        ExplicitLeft = 476
      end
      inherited brnDeleta: TcxButton
        Left = 577
        Enabled = False
        Visible = False
        ExplicitLeft = 577
      end
      inherited BtnSair: TcxButton
        Left = 678
        ExplicitLeft = 678
      end
      inherited btnExportar: TcxButton
        Left = 375
        ExplicitLeft = 375
      end
      inherited btnImprimir: TcxButton
        Left = 274
        ExplicitLeft = 274
      end
    end
    object lbPedido: TcxLabel
      Left = 6
      Top = 29
      Caption = 'Pedido:'
      Transparent = True
    end
    object edtPedido: TcxTextEdit
      Tag = 13
      Left = 6
      Top = 45
      TabOrder = 0
      OnExit = edtPedidoExit
      OnKeyDown = edtPedidoKeyDown
      OnKeyPress = edtPedidoKeyPress
      Width = 67
    end
    object lbDtOperacao: TcxLabel
      Left = 73
      Top = 29
      Caption = 'Data Pedido:'
      Transparent = True
    end
    object stCliente: TcxTextEdit
      Left = 194
      Top = 45
      TabStop = False
      AutoSize = False
      Enabled = False
      StyleDisabled.TextColor = clBlack
      TabOrder = 2
      Height = 21
      Width = 574
    end
    object lbCliente: TcxLabel
      Left = 194
      Top = 29
      Caption = 'Cliente:'
      Transparent = True
    end
    object grdProduto: TcxGrid
      Left = 3
      Top = 148
      Width = 771
      Height = 292
      TabOrder = 6
      object grdProdutoDBTableView1: TcxGridDBTableView
        Navigator.Buttons.CustomButtons = <>
        DataController.DataSource = dsItens
        DataController.DetailKeyFieldNames = 'DML'
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        OptionsData.CancelOnExit = False
        OptionsData.Deleting = False
        OptionsData.DeletingConfirmation = False
        OptionsData.Inserting = False
        OptionsView.GroupByBox = False
        object grdProdutoDBTableView1DML: TcxGridDBColumn
          DataBinding.FieldName = 'DML'
          Visible = False
          Options.Editing = False
          Options.Focusing = False
          VisibleForCustomization = False
        end
        object grdProdutoDBTableView1icodigo: TcxGridDBColumn
          DataBinding.FieldName = 'icodigo'
          PropertiesClassName = 'TcxTextEditProperties'
          Properties.Alignment.Horz = taLeftJustify
          Visible = False
          Options.Editing = False
          Options.Focusing = False
          Width = 70
        end
        object grdProdutoDBTableView1iDevVenda: TcxGridDBColumn
          DataBinding.FieldName = 'iDevVenda'
          Visible = False
          Options.Editing = False
          Options.Focusing = False
        end
        object grdProdutoDBTableView1iproduto: TcxGridDBColumn
          Caption = 'C'#243'd. Produto'
          DataBinding.FieldName = 'iproduto'
          PropertiesClassName = 'TcxTextEditProperties'
          Properties.Alignment.Horz = taLeftJustify
          Options.Editing = False
          Options.Focusing = False
          Width = 78
        end
        object grdProdutoDBTableView1sproduto: TcxGridDBColumn
          Caption = 'Descri'#231#227'o do Produto'
          DataBinding.FieldName = 'sproduto'
          Options.Editing = False
          Options.Focusing = False
          SortIndex = 0
          SortOrder = soAscending
          Width = 382
        end
        object grdProdutoDBTableView1nqtdVendida: TcxGridDBColumn
          Caption = 'Qtd. Vendido'
          DataBinding.FieldName = 'nqtdVendida'
          PropertiesClassName = 'TcxCurrencyEditProperties'
          Properties.DisplayFormat = '0.00;-0.00'
          Properties.UseLeftAlignmentOnEditing = False
          HeaderAlignmentHorz = taRightJustify
          Options.Editing = False
          Options.Focusing = False
          Width = 100
        end
        object grdProdutoDBTableView1nqtddevolvida: TcxGridDBColumn
          Caption = 'Qtd. Devolvida'
          DataBinding.FieldName = 'nqtddevolvida'
          PropertiesClassName = 'TcxCurrencyEditProperties'
          Properties.DisplayFormat = '0.00;-0.00'
          Properties.UseLeftAlignmentOnEditing = False
          HeaderAlignmentHorz = taRightJustify
          Options.Editing = False
          Options.Focusing = False
          Width = 100
        end
        object grdProdutoDBTableView1qtdDevolver: TcxGridDBColumn
          Caption = 'Qtd. a Devolver'
          DataBinding.FieldName = 'qtdDevolver'
          PropertiesClassName = 'TcxCurrencyEditProperties'
          Properties.DisplayFormat = '0.00;-0.00'
          Properties.UseDisplayFormatWhenEditing = True
          Properties.UseLeftAlignmentOnEditing = False
          HeaderAlignmentHorz = taRightJustify
          Width = 100
        end
      end
      object grdProdutoLevel: TcxGridLevel
        GridView = grdProdutoDBTableView1
      end
    end
    object edtDataPedido: TcxDateEdit
      Left = 73
      Top = 45
      Enabled = False
      Properties.InputKind = ikRegExpr
      Properties.Kind = ckDateTime
      Properties.SaveTime = False
      Properties.ShowTime = False
      StyleDisabled.TextColor = clBlack
      TabOrder = 1
      Width = 121
    end
    object cxLabel1: TcxLabel
      Left = 6
      Top = 67
      Caption = 'Nat. de Opera'#231#227'o:'
      Transparent = True
    end
    object edtNatOp: TcxLookupComboBox
      Tag = 13
      Left = 6
      Top = 83
      Properties.KeyFieldNames = 'icodigo'
      Properties.ListColumns = <
        item
          Caption = 'Natureza'
          FieldName = 'sdescricao'
        end
        item
          Caption = 'C'#243'd.'
          FieldName = 'icodigo'
        end>
      Properties.ListOptions.SyncMode = True
      Properties.ListSource = dsNatOp
      Properties.UseLeftAlignmentOnEditing = False
      TabOrder = 3
      Width = 367
    end
    object edtCFOP: TcxLookupComboBox
      Tag = 13
      Left = 373
      Top = 83
      Properties.KeyFieldNames = 'icodigo'
      Properties.ListColumns = <
        item
          Caption = 'Descri'#231#227'o'
          FieldName = 'sdescricao'
        end
        item
          Caption = 'CFOP'
          FieldName = 'icodigo'
        end>
      Properties.ListOptions.SyncMode = True
      Properties.ListSource = dsCfop
      Properties.UseLeftAlignmentOnEditing = False
      TabOrder = 4
      Width = 395
    end
    object cxLabel2: TcxLabel
      Left = 373
      Top = 67
      Caption = 'CFOP:'
      Transparent = True
    end
    object edtObservacao: TcxTextEdit
      Left = 6
      Top = 121
      TabOrder = 5
      Width = 762
    end
    object cxLabel3: TcxLabel
      Left = 6
      Top = 105
      Caption = 'Observa'#231#227'o:'
      Transparent = True
    end
    object edtTexto: TcxTextEdit
      Left = 2
      Top = 439
      Enabled = False
      StyleDisabled.TextColor = clRed
      StyleDisabled.TextStyle = [fsBold]
      TabOrder = 14
      Visible = False
      Width = 773
    end
  end
  inherited SaveDlg: TSaveDialog
    Left = 64
    Top = 472
  end
  object cdsItens: TClientDataSet
    Aggregates = <>
    Params = <>
    AfterScroll = cdsItensAfterScroll
    Left = 48
    Top = 240
    object cdsItensDML: TStringField
      FieldName = 'DML'
    end
    object cdsItensicodigo: TIntegerField
      FieldName = 'icodigo'
    end
    object cdsItensiinventario: TIntegerField
      FieldName = 'iDevVenda'
    end
    object cdsItensiproduto: TIntegerField
      FieldName = 'iproduto'
    end
    object cdsItenssproduto: TStringField
      FieldName = 'sproduto'
      Size = 255
    end
    object cdsItensnqtdVendida: TFloatField
      FieldName = 'nqtdVendida'
    end
    object cdsItensnqtdcontada: TFloatField
      FieldName = 'nqtddevolvida'
    end
    object cdsItensqtdDevolver: TFloatField
      FieldName = 'qtdDevolver'
      OnChange = cdsItensqtdDevolverChange
    end
  end
  object dsItens: TDataSource
    DataSet = cdsItens
    Left = 104
    Top = 240
  end
  object qrNatOp: TZQuery
    Connection = frmPrincipal.conexaodesenv
    SQL.Strings = (
      
        'select icodigo, sdescricao, sdescricao||'#39'('#39'||icodigo||'#39')'#39' as sde' +
        'scricaocomcodigo from tbnatureza'
      'order by sdescricao')
    Params = <>
    Left = 376
    Top = 248
    object qrNatOpicodigo: TIntegerField
      FieldName = 'icodigo'
      Required = True
    end
    object qrNatOpsdescricao: TWideStringField
      FieldName = 'sdescricao'
      Required = True
      Size = 30
    end
    object qrNatOpsdescricaocomcodigo: TWideMemoField
      FieldName = 'sdescricaocomcodigo'
      ReadOnly = True
      BlobType = ftWideMemo
    end
  end
  object dsNatOp: TDataSource
    DataSet = qrNatOp
    Left = 376
    Top = 296
  end
  object dsCfop: TDataSource
    DataSet = qrCfop
    Left = 440
    Top = 296
  end
  object qrCfop: TZQuery
    Connection = frmPrincipal.conexaodesenv
    SQL.Strings = (
      'select '
      #9'icodigo,'
      #9'sdescricao'
      'from tbcodigofiscal'
      'order by sdescricao')
    Params = <>
    Left = 440
    Top = 248
    object qrCfopicodigo: TIntegerField
      FieldName = 'icodigo'
      Required = True
    end
    object qrCfopsdescricao: TWideStringField
      FieldName = 'sdescricao'
      Required = True
      Size = 30
    end
  end
end
