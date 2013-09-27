inherited frmControleOrcamentoItens: TfrmControleOrcamentoItens
  Caption = 'frmControleOrcamentoItens'
  ClientHeight = 348
  ClientWidth = 881
  OnShow = FormShow
  ExplicitWidth = 887
  ExplicitHeight = 376
  PixelsPerInch = 96
  TextHeight = 13
  inherited JvNavPaneToolPanel1: TJvNavPaneToolPanel
    Width = 881
    Height = 348
    ExplicitWidth = 532
    ExplicitHeight = 280
    inherited pn: TPanel
      Top = 313
      Width = 877
      ExplicitTop = 245
      ExplicitWidth = 528
      inherited btnGrava: TcxButton
        Left = 363
        Enabled = False
        Visible = False
        ExplicitLeft = 14
      end
      inherited btnCancela: TcxButton
        Left = 621
        Enabled = False
        Visible = False
        ExplicitLeft = 272
      end
      inherited brnDeleta: TcxButton
        Left = 707
        Enabled = False
        Visible = False
        ExplicitLeft = 358
      end
      inherited BtnSair: TcxButton
        Left = 793
        ExplicitLeft = 444
      end
      inherited btnExportar: TcxButton
        Left = 535
        ExplicitLeft = 186
      end
      inherited btnImprimir: TcxButton
        Left = 449
        ExplicitLeft = 100
      end
    end
    object cxGrid1: TcxGrid
      AlignWithMargins = True
      Left = 5
      Top = 36
      Width = 871
      Height = 274
      Align = alClient
      TabOrder = 1
      ExplicitLeft = 7
      ExplicitTop = 37
      ExplicitWidth = 681
      object cxGrid1DBTableView1: TcxGridDBTableView
        Navigator.Buttons.CustomButtons = <>
        DataController.DataSource = dsItens
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <
          item
            Format = ',0.00;-,0.00'
            Kind = skSum
            FieldName = 'totalItem'
            Column = cxGrid1DBTableView1totalItem
          end
          item
            Format = ',0.00;-,0.00'
            Kind = skMax
            FieldName = 'totalpedidobruto'
            Column = cxGrid1DBTableView1totalpedidobruto
          end
          item
            Format = ',0.00;-,0.00'
            Kind = skMax
            FieldName = 'totalpedidoliquido'
            Column = cxGrid1DBTableView1totalpedidoliquido
          end
          item
            Format = ',0.00;-,0.00'
            Kind = skMax
            FieldName = 'najustevalor'
            Column = cxGrid1DBTableView1najustevalor
          end>
        DataController.Summary.SummaryGroups = <>
        OptionsCustomize.ColumnsQuickCustomization = True
        OptionsData.CancelOnExit = False
        OptionsData.Deleting = False
        OptionsData.DeletingConfirmation = False
        OptionsData.Editing = False
        OptionsData.Inserting = False
        OptionsSelection.CellSelect = False
        OptionsView.Footer = True
        object cxGrid1DBTableView1sProduto: TcxGridDBColumn
          Caption = 'Produto'
          DataBinding.FieldName = 'sProduto'
          Width = 176
        end
        object cxGrid1DBTableView1sMarca: TcxGridDBColumn
          Caption = 'Marca'
          DataBinding.FieldName = 'sMarca'
          Width = 100
        end
        object cxGrid1DBTableView1sGrupo: TcxGridDBColumn
          Caption = 'Grupo'
          DataBinding.FieldName = 'sGrupo'
          Visible = False
          Width = 100
        end
        object cxGrid1DBTableView1sSubGrupo: TcxGridDBColumn
          Caption = 'SubGrupo'
          DataBinding.FieldName = 'sSubGrupo'
          Visible = False
          Width = 100
        end
        object cxGrid1DBTableView1nQuantidade: TcxGridDBColumn
          Caption = 'Quantidade'
          DataBinding.FieldName = 'nQuantidade'
          PropertiesClassName = 'TcxCurrencyEditProperties'
          Properties.Alignment.Horz = taRightJustify
          Properties.DisplayFormat = ',0.00;-,0.00'
          HeaderAlignmentHorz = taRightJustify
        end
        object cxGrid1DBTableView1nValor: TcxGridDBColumn
          Caption = 'Valor'
          DataBinding.FieldName = 'nValor'
          PropertiesClassName = 'TcxCurrencyEditProperties'
          Properties.Alignment.Horz = taRightJustify
          Properties.DisplayFormat = ',0.00;-,0.00'
          HeaderAlignmentHorz = taRightJustify
          Width = 87
        end
        object cxGrid1DBTableView1totalItem: TcxGridDBColumn
          Caption = 'Vlr. Bruto Item'
          DataBinding.FieldName = 'totalItem'
          PropertiesClassName = 'TcxCurrencyEditProperties'
          Properties.DisplayFormat = ',0.00;-,0.00'
          HeaderAlignmentHorz = taRightJustify
          Width = 88
        end
        object cxGrid1DBTableView1najustevalor: TcxGridDBColumn
          Caption = 'Ajuste/Desconto'
          DataBinding.FieldName = 'najustevalor'
          PropertiesClassName = 'TcxCurrencyEditProperties'
          Properties.Alignment.Vert = taVCenter
          Properties.DisplayFormat = ',0.00;-,0.00'
          HeaderAlignmentHorz = taRightJustify
          Options.CellMerging = True
          Width = 112
        end
        object cxGrid1DBTableView1totalpedidobruto: TcxGridDBColumn
          Caption = 'Total Or'#231'. Bruto'
          DataBinding.FieldName = 'totalpedidobruto'
          PropertiesClassName = 'TcxCurrencyEditProperties'
          Properties.Alignment.Vert = taVCenter
          Properties.DisplayFormat = ',0.00;-,0.00'
          HeaderAlignmentHorz = taRightJustify
          Options.CellMerging = True
          Width = 104
        end
        object cxGrid1DBTableView1totalpedidoliquido: TcxGridDBColumn
          Caption = 'Total Or'#231'. Liquido'
          DataBinding.FieldName = 'totalpedidoliquido'
          PropertiesClassName = 'TcxCurrencyEditProperties'
          Properties.Alignment.Vert = taVCenter
          Properties.DisplayFormat = ',0.00;-,0.00'
          HeaderAlignmentHorz = taRightJustify
          Options.CellMerging = True
          Width = 102
        end
      end
      object cxGrid1Level1: TcxGridLevel
        GridView = cxGrid1DBTableView1
      end
    end
  end
  inherited SaveDlg: TSaveDialog
    Left = 112
    Top = 320
  end
  object dspItens: TDataSetProvider
    DataSet = qrItens
    Left = 184
    Top = 136
  end
  object cdsItens: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspItens'
    Left = 248
    Top = 136
    object cdsItensiCodigo: TIntegerField
      FieldName = 'iCodigo'
    end
    object cdsItensiPedido: TIntegerField
      FieldName = 'iPedido'
    end
    object cdsItensiProduto: TIntegerField
      FieldName = 'iProduto'
    end
    object cdsItenssProduto: TWideStringField
      FieldName = 'sProduto'
      Size = 100
    end
    object cdsItensiMarca: TIntegerField
      FieldName = 'iMarca'
    end
    object cdsItensiGrupo: TIntegerField
      FieldName = 'iGrupo'
    end
    object cdsItensiSubGrupo: TIntegerField
      FieldName = 'iSubGrupo'
    end
    object cdsItensnQuantidade: TFloatField
      FieldName = 'nQuantidade'
    end
    object cdsItensnValor: TFloatField
      FieldName = 'nValor'
    end
    object cdsItenssMarca: TWideStringField
      FieldName = 'sMarca'
      Size = 100
    end
    object cdsItenssGrupo: TWideStringField
      FieldName = 'sGrupo'
      Size = 100
    end
    object cdsItenssSubGrupo: TWideStringField
      FieldName = 'sSubGrupo'
      Size = 100
    end
    object cdsItenstotalItem: TFloatField
      FieldName = 'totalItem'
    end
    object cdsItensnajustevalor: TFloatField
      FieldName = 'najustevalor'
    end
    object cdsItenstotalpedidobruto: TFloatField
      FieldName = 'totalpedidobruto'
    end
    object cdsItenstotalpedidoliquido: TFloatField
      FieldName = 'totalpedidoliquido'
    end
  end
  object dsItens: TDataSource
    DataSet = cdsItens
    Left = 312
    Top = 136
  end
  object qrItens: TZQuery
    Params = <>
    Left = 120
    Top = 136
  end
end
