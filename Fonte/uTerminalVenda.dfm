inherited frmTerminalVenda: TfrmTerminalVenda
  Left = 162
  Top = 123
  Caption = 'Terminal de Vendas'
  ClientHeight = 498
  ClientWidth = 859
  OldCreateOrder = True
  OnShow = FormShow
  ExplicitWidth = 865
  ExplicitHeight = 526
  PixelsPerInch = 96
  TextHeight = 13
  inherited JvNavPaneToolPanel1: TJvNavPaneToolPanel
    Width = 859
    Height = 498
    ExplicitLeft = 248
    ExplicitTop = -8
    ExplicitWidth = 859
    ExplicitHeight = 498
    inherited pn: TPanel
      Top = 463
      Width = 855
      TabOrder = 27
      ExplicitTop = 463
      ExplicitWidth = 855
      inherited btnGrava: TcxButton
        Left = 599
        OnClick = btnGravaClick
        ExplicitLeft = 599
      end
      inherited btnCancela: TcxButton
        Left = 685
        OnClick = btnCancelaClick
        ExplicitLeft = 685
      end
      inherited brnDeleta: TcxButton
        Left = 513
        Enabled = False
        Visible = False
        ExplicitLeft = 513
      end
      inherited BtnSair: TcxButton
        Left = 771
        ExplicitLeft = 771
      end
      inherited btnExportar: TcxButton
        Left = 427
        ExplicitLeft = 427
      end
      inherited btnImprimir: TcxButton
        Left = 341
        ExplicitLeft = 341
      end
    end
    object edtValidador: TJvValidateEdit
      Left = 16
      Top = 354
      Width = 75
      Height = 21
      CriticalPoints.MaxValueIncluded = False
      CriticalPoints.MinValueIncluded = False
      DisplayFormat = dfFloat
      DecimalPlaces = 2
      EditText = '0,00'
      HasMaxValue = True
      HasMinValue = True
      MaxValue = 999999.990000000000000000
      TabOrder = 19
      Visible = False
    end
    object lbTotal: TcxLabel
      Left = 512
      Top = 430
      Caption = 'Total:'
      ParentFont = False
      Style.Font.Charset = DEFAULT_CHARSET
      Style.Font.Color = clWindowText
      Style.Font.Height = -13
      Style.Font.Name = 'Tahoma'
      Style.Font.Style = []
      Style.TextStyle = [fsBold]
      Style.IsFontAssigned = True
      Transparent = True
    end
    object lbDesconto: TcxLabel
      Left = 483
      Top = 402
      Caption = '&Desconto:'
      FocusControl = edtDesconto
      ParentFont = False
      Style.Font.Charset = DEFAULT_CHARSET
      Style.Font.Color = clWindowText
      Style.Font.Height = -13
      Style.Font.Name = 'Tahoma'
      Style.Font.Style = []
      Style.TextStyle = [fsBold]
      Style.IsFontAssigned = True
      Transparent = True
    end
    object lbAcrescimo: TcxLabel
      Left = 477
      Top = 374
      Caption = '&Acr'#233'scimo:'
      FocusControl = edtAcrescimo
      ParentFont = False
      Style.Font.Charset = DEFAULT_CHARSET
      Style.Font.Color = clWindowText
      Style.Font.Height = -13
      Style.Font.Name = 'Tahoma'
      Style.Font.Style = []
      Style.TextStyle = [fsBold]
      Style.IsFontAssigned = True
      Transparent = True
    end
    object lbSubTotal: TcxLabel
      Left = 488
      Top = 346
      Caption = 'SubTotal:'
      ParentFont = False
      Style.Font.Charset = DEFAULT_CHARSET
      Style.Font.Color = clWindowText
      Style.Font.Height = -13
      Style.Font.Name = 'Tahoma'
      Style.Font.Style = []
      Style.TextStyle = [fsBold]
      Style.IsFontAssigned = True
      Transparent = True
    end
    object LabelNCM: TcxLabel
      Left = 4
      Top = 98
      Caption = 'Produto com NCM'
      ParentFont = False
      Transparent = True
      Visible = False
    end
    object grdItens: TcxGrid
      Left = 4
      Top = 117
      Width = 846
      Height = 227
      TabOrder = 9
      object grdItensDBTableView: TcxGridDBTableView
        Navigator.Buttons.CustomButtons = <>
        OnCellClick = grdItensDBTableViewCellClick
        DataController.DataSource = dsItens
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        OptionsData.CancelOnExit = False
        OptionsData.Deleting = False
        OptionsData.DeletingConfirmation = False
        OptionsData.Editing = False
        OptionsData.Inserting = False
        OptionsSelection.CellSelect = False
        OptionsView.FooterAutoHeight = True
        OptionsView.GroupByBox = False
        object grdItensDBTableViewCodigo: TcxGridDBColumn
          DataBinding.FieldName = 'Codigo'
          Width = 85
        end
        object grdItensDBTableViewDescricao: TcxGridDBColumn
          DataBinding.FieldName = 'Descricao'
          Width = 357
        end
        object grdItensDBTableViewQuantidade: TcxGridDBColumn
          DataBinding.FieldName = 'Quantidade'
          PropertiesClassName = 'TcxCurrencyEditProperties'
          Properties.Alignment.Horz = taRightJustify
          Properties.DisplayFormat = '0.00;-0.00'
          HeaderAlignmentHorz = taRightJustify
          Width = 90
        end
        object grdItensDBTableViewPreco: TcxGridDBColumn
          DataBinding.FieldName = 'Preco'
          PropertiesClassName = 'TcxCurrencyEditProperties'
          Properties.Alignment.Horz = taRightJustify
          Properties.DisplayFormat = ',0.00;-,0.00'
          HeaderAlignmentHorz = taRightJustify
          Width = 140
        end
        object grdItensDBTableViewTotal: TcxGridDBColumn
          DataBinding.FieldName = 'Total'
          PropertiesClassName = 'TcxCurrencyEditProperties'
          Properties.Alignment.Horz = taRightJustify
          Properties.DisplayFormat = ',0.00;-,0.00'
          HeaderAlignmentHorz = taRightJustify
          Width = 140
        end
      end
      object grdItensLevel: TcxGridLevel
        GridView = grdItensDBTableView
      end
    end
    object edtTotal: TcxCurrencyEdit
      Left = 556
      Top = 429
      TabStop = False
      EditValue = 0.000000000000000000
      Enabled = False
      ParentFont = False
      Properties.Alignment.Horz = taRightJustify
      Properties.DisplayFormat = ',0.00;-,0.00'
      Properties.UseDisplayFormatWhenEditing = True
      Properties.UseLeftAlignmentOnEditing = False
      Style.Font.Charset = DEFAULT_CHARSET
      Style.Font.Color = clWindowText
      Style.Font.Height = -13
      Style.Font.Name = 'Tahoma'
      Style.Font.Style = [fsBold]
      Style.IsFontAssigned = True
      StyleDisabled.TextColor = clBlack
      TabOrder = 15
      Width = 294
    end
    object edtDesconto: TcxCurrencyEdit
      Left = 703
      Top = 401
      EditValue = 0.000000000000000000
      ParentFont = False
      Properties.Alignment.Horz = taRightJustify
      Properties.DisplayFormat = ',0.00;-,0.00'
      Properties.UseDisplayFormatWhenEditing = True
      Properties.UseLeftAlignmentOnEditing = False
      Style.Font.Charset = DEFAULT_CHARSET
      Style.Font.Color = clWindowText
      Style.Font.Height = -13
      Style.Font.Name = 'Tahoma'
      Style.Font.Style = [fsBold]
      Style.IsFontAssigned = True
      TabOrder = 14
      OnExit = edtDescontoExit
      Width = 147
    end
    object edtAcrescimo: TcxCurrencyEdit
      Left = 703
      Top = 373
      EditValue = 0.000000000000000000
      ParentFont = False
      Properties.Alignment.Horz = taRightJustify
      Properties.DisplayFormat = ',0.00;-,0.00'
      Properties.UseDisplayFormatWhenEditing = True
      Properties.UseLeftAlignmentOnEditing = False
      Style.Font.Charset = DEFAULT_CHARSET
      Style.Font.Color = clWindowText
      Style.Font.Height = -13
      Style.Font.Name = 'Tahoma'
      Style.Font.Style = [fsBold]
      Style.IsFontAssigned = True
      TabOrder = 12
      OnExit = edtAcrescimoExit
      Width = 147
    end
    object edtSubtotal: TcxCurrencyEdit
      Left = 556
      Top = 345
      TabStop = False
      EditValue = 0.000000000000000000
      Enabled = False
      ParentFont = False
      Properties.Alignment.Horz = taRightJustify
      Properties.DisplayFormat = ',0.00;-,0.00'
      Properties.UseDisplayFormatWhenEditing = True
      Properties.UseLeftAlignmentOnEditing = False
      Style.Font.Charset = DEFAULT_CHARSET
      Style.Font.Color = clWindowText
      Style.Font.Height = -13
      Style.Font.Name = 'Tahoma'
      Style.Font.Style = [fsBold]
      Style.IsFontAssigned = True
      StyleDisabled.TextColor = clBlack
      TabOrder = 10
      Width = 293
    end
    object lblPreco: TcxLabel
      Left = 326
      Top = 61
      ParentCustomHint = False
      Caption = 'Pre'#231'o:'
      ParentColor = False
      ParentShowHint = False
      ShowHint = True
      Transparent = True
    end
    object edtPreco: TcxCurrencyEdit
      Left = 326
      Top = 76
      EditValue = 0.000000000000000000
      Properties.Alignment.Horz = taRightJustify
      Properties.DisplayFormat = ',0.00;-,0.00'
      Properties.UseDisplayFormatWhenEditing = True
      Properties.UseLeftAlignmentOnEditing = False
      TabOrder = 4
      Width = 121
    end
    object lbQuantidade: TcxLabel
      Left = 447
      Top = 61
      ParentCustomHint = False
      Caption = 'Quantidade:'
      ParentColor = False
      ParentShowHint = False
      ShowHint = True
      Transparent = True
    end
    object edtQuantidade: TcxCurrencyEdit
      Left = 447
      Top = 76
      EditValue = 0.000000000000000000
      Properties.Alignment.Horz = taRightJustify
      Properties.DisplayFormat = ',0.00;-,0.00'
      Properties.UseDisplayFormatWhenEditing = True
      Properties.UseLeftAlignmentOnEditing = False
      TabOrder = 5
      Width = 121
    end
    object lbUnidade: TcxLabel
      Left = 568
      Top = 61
      ParentCustomHint = False
      Caption = 'Unidade:'
      ParentColor = False
      ParentShowHint = False
      ShowHint = True
      Transparent = True
    end
    object btnInsere: TcxButton
      Left = 716
      Top = 75
      Width = 67
      Height = 24
      Caption = '&Insere'
      OptionsImage.Glyph.Data = {
        36040000424D3604000000000000360000002800000010000000100000000100
        2000000000000004000000000000000000000000000000000000000000000000
        00050101000D020201150403011C060502261F13075F21150861211508611F13
        075F060402260403011C020201150101000D0000000400000000000000000000
        000000000002000000040100000607040218AB611BFFAB611BFFAB611BFFAB61
        1BFF070502180100000600000004000000020000000000000000000000000000
        00000000000000000000000000000503010FB26A22FFB26A22FFB26A22FFB26A
        22FF0603010F0000000000000000000000000000000000000000000000000000
        00000000000000000000000000000503010FBA7429FFBA7429FFBA7429FFBA74
        29FF0604010F0000000000000000000000000000000000000000000000000000
        00000000000000000000000000000604010FC27E30FFC27E30FFC27E30FFC27E
        30FF0604020F0000000000000000000000000000000000000000030201090E0A
        041F0E0A041F0E0A041F0E0A041F1C13082DCA8939FFCA8939FFCA8939FFCA89
        39FF1D14082D0E0A041F0E0A041F0E0A041F0E0A041F0302010931220F4FD294
        42FFD29442FFD29442FFD29442FFD29442FFD29442FFD29442FFD29442FFD294
        42FFD29442FFD29442FFD29442FFD29442FFD29442FF3525104F3225114FDEAC
        64FFDCA65AFFDAA251FFD99F4CFFD99F4BFFD99F4BFFD99F4BFFD99F4BFFD99F
        4BFFD99F4BFFD99F4BFFD99F4BFFD99F4BFFD99F4BFF3728134F3427144FE7BF
        83FFE7BD7FFFE6BB7AFFE5B875FFE3B56EFFE2B167FFE1AF62FFE0AD5FFFE0AC
        5CFFE0AB5AFFDFAA59FFDFA958FFDFA957FFDFA956FF382A154F3529174FEBC7
        8DFFEBC88EFFEBC78DFFEAC487FFE9C181FFEAC386FFEAC385FFE9C181FFE8BD
        7AFFE6B972FFE6B971FFE7BA73FFE6B76DFFE5B569FF392D184F0D0A05165E48
        246F63583B6F67655B6F6254346F69512A78EFCE96FFF1D3A0FFF0D19CFFEDC9
        8DFF695129785E4B276F635A436F604E2C6F5D47226F0E0B0616000000000000
        00000000000000000000000000000706040FF3D9ABFFF5E0BAFFF5DEB5FFF3D5
        A2FF0806040F0000000000000000000000000000000000000000000000000000
        00000000000000000000000000000706040FF7E3BEFFF9EBD0FFF9E9CCFFF7E0
        B6FF0807040F0000000000000000000000000000000000000000000000000000
        00000000000000000000000000000706040FFAEACCFFFCF3E1FFFCF1DEFFF9E8
        C6FF0807050F0000000000000000000000000000000000000000000000000000
        00000000000000000000000000000706040FFBEDD2FFFDF5E6FFFDF5E4FFFBEC
        CEFF0807050F0000000000000000000000000000000000000000000000000000
        000000000000000000000000000003020106977945A59A7B45A89A7B45A8987A
        45A6030302060000000000000000000000000000000000000000}
      OptionsImage.Spacing = 3
      TabOrder = 7
      WordWrap = True
      OnClick = btnInsereClick
    end
    object btnDeleta: TcxButton
      Left = 784
      Top = 75
      Width = 66
      Height = 24
      Caption = '&Deleta'
      OptionsImage.Glyph.Data = {
        36040000424D3604000000000000360000002800000010000000100000000100
        2000000000000004000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000406
        162F161E73EF161E73EF0406162F000000000000000000000000000000000000
        00000406162F161F72EF151D6FEF0406162F00000000000000000406162F1922
        74EF4F57C5FF313BBCFF161E73EF0406162F0000000000000000000000000406
        162F161F72EF343CAEFF343CAEFF161F72EF0406162F000000001A2375EF5B63
        CCFF696BDEFF5A5DDAFF2B35BBFF161E73EF0406162F000000000406162F161F
        73EF323AB1FF393FD8FF393FD7FF343CAEFF161F72EF00000000151D6FEF535C
        C1FF6D70E0FF6A69DFFF4B4ED7FF2A34BCFF161E73EF03040E1F161F73EF2F38
        B5FF373DD9FF383DE8FF383ED8FF2D35A1FF151D6FEF000000000406162F1A23
        75EF5D66CFFF6B6FE0FF6968DFFF3F42D5FF2934BDFF192280FF2C36BAFF363B
        D7FF383BE4FF373DD9FF2B33A4FF151D6FEF0406162F00000000000000000406
        162F192275EF5C64CFFF6A6DE0FF6261DDFF3639D4FF2D38CFFF3439D6FF3739
        DFFF353BD8FF2832A8FF151D6FEF0406162F0000000000000000000000000000
        00000406162F192275EF5A63D0FF686CE0FF5857DBFF3536D6FF3737D9FF3338
        D7FF2630ABFF151D6FEF0406162F000000000000000000000000000000000000
        000000000000080C2C5F212A84FF6972E6FF676ADFFF4C4BD8FF3536D6FF2A35
        CCFF17207BFF080C2C5F00000000000000000000000000000000000000000000
        00000406162F1A2376EF636CD6FF6875E3FF656EDEFF6265DEFF3F3ED6FF3236
        D5FF2732C2FF161E74EF0406162F000000000000000000000000000000000406
        162F1B2476EF6E76DAFF7081E6FF6578DFFF6773E3FF646DE3FF5A5EDEFF3938
        D4FF3235D5FF2631C3FF161E74EF0406162F00000000000000000406162F1C25
        76EF7981DEFF7F8FEAFF7186E2FF6E7FE6FF5F68CAFF283185FF5C65D7FF4C50
        DCFF3635D4FF3135D6FF2531C4FF161E74EF0406162F000000001D2576EF848C
        E1FF909DEEFF8295E6FF7E8DEAFF6A72CFFF1A2371EF05081D3F161E66CF515B
        D3FF3E43D9FF3635D4FF3135D6FF2430C5FF161E74EF000000001D2576EF8990
        E2FF97A4F0FF8E9CEEFF767DCCFF1B2472EF0406162F0000000003040E1F1922
        75EF4C56D3FF2F35D8FF2F34D7FF232FC7FF161E74EF000000000406162F1D25
        76EF878FE3FF8288CAFF1C2572EF0406162F0000000000000000000000000406
        162F182275EF404BD2FF1F2DCCFF151E74EF0406162F00000000000000000406
        162F1D2573EF1D2573EF0406162F000000000000000000000000000000000000
        00000406162F182175EF182175EF0406162F0000000000000000}
      OptionsImage.Spacing = 3
      TabOrder = 8
      WordWrap = True
      OnClick = btnDeletaClick
    end
    object edtTabela: TcxTextEdit
      Tag = 10
      Left = 4
      Top = 76
      Properties.UseLeftAlignmentOnEditing = False
      TabOrder = 2
      OnExit = edtTabelaExit
      OnKeyDown = edtTabelaKeyDown
      OnKeyPress = edtProdutoKeyPress
      Width = 75
    end
    object lblTabela: TcxLabel
      Left = 4
      Top = 61
      ParentCustomHint = False
      Caption = 'Tabela de Pre'#231'o:'
      ParentColor = False
      ParentShowHint = False
      ShowHint = True
      Transparent = True
    end
    object edtProduto: TcxTextEdit
      Tag = 8
      Left = 4
      Top = 40
      Properties.UseLeftAlignmentOnEditing = False
      TabOrder = 0
      OnEnter = edtProdutoEnter
      OnExit = edtProdutoExit
      OnKeyDown = edtProdutoKeyDown
      OnKeyPress = edtProdutoKeyPress
      Width = 75
    end
    object lblProduto: TcxLabel
      Left = 4
      Top = 26
      ParentCustomHint = False
      Caption = 'Produto:'
      ParentColor = False
      ParentShowHint = False
      ShowHint = True
      Transparent = True
    end
    object stUnidade: TcxTextEdit
      Left = 568
      Top = 76
      TabStop = False
      AutoSize = False
      Enabled = False
      StyleDisabled.TextColor = clBlack
      TabOrder = 6
      Height = 21
      Width = 147
    end
    object stTabela: TcxTextEdit
      Left = 78
      Top = 76
      TabStop = False
      AutoSize = False
      Enabled = False
      StyleDisabled.TextColor = clBlack
      TabOrder = 3
      Height = 21
      Width = 248
    end
    object stProduto: TcxTextEdit
      Left = 78
      Top = 40
      TabStop = False
      AutoSize = False
      Enabled = False
      StyleDisabled.TextColor = clBlack
      TabOrder = 1
      Height = 21
      Width = 637
    end
    object edtAcrescimoPercentual: TcxCurrencyEdit
      Left = 556
      Top = 373
      EditValue = '0'
      ParentFont = False
      Properties.Alignment.Horz = taRightJustify
      Properties.DisplayFormat = ',0.00%;-,0.00%'
      Properties.EditFormat = ',0.00%;-,0.00%'
      Properties.UseDisplayFormatWhenEditing = True
      Properties.UseLeftAlignmentOnEditing = False
      Style.Font.Charset = DEFAULT_CHARSET
      Style.Font.Color = clWindowText
      Style.Font.Height = -13
      Style.Font.Name = 'Tahoma'
      Style.Font.Style = [fsBold]
      Style.IsFontAssigned = True
      TabOrder = 11
      OnExit = edtAcrescimoPercentualExit
      Width = 147
    end
    object edtDescontoPercentual: TcxCurrencyEdit
      Left = 556
      Top = 401
      EditValue = '0'
      ParentFont = False
      Properties.Alignment.Horz = taRightJustify
      Properties.DisplayFormat = ',0.00%;-,0.00%'
      Properties.EditFormat = ',0.00%;-,0.00%'
      Properties.UseDisplayFormatWhenEditing = True
      Properties.UseLeftAlignmentOnEditing = False
      Style.Font.Charset = DEFAULT_CHARSET
      Style.Font.Color = clWindowText
      Style.Font.Height = -13
      Style.Font.Name = 'Tahoma'
      Style.Font.Style = [fsBold]
      Style.IsFontAssigned = True
      TabOrder = 13
      OnExit = edtDescontoPercentualExit
      Width = 147
    end
  end
  inherited SaveDlg: TSaveDialog
    Left = 16
    Top = 480
  end
  object dsItens: TDataSource
    DataSet = cdsItens
    Left = 112
    Top = 184
  end
  object cdsItens: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 112
    Top = 240
    object cdsItensCodigo: TStringField
      FieldName = 'Codigo'
    end
    object cdsItensDescricao: TStringField
      FieldName = 'Descricao'
    end
    object cdsItensQuantidade: TStringField
      FieldName = 'Quantidade'
    end
    object cdsItensPreco: TStringField
      FieldName = 'Preco'
    end
    object cdsItensTotal: TStringField
      FieldName = 'Total'
    end
    object cdsItensTabela: TStringField
      FieldName = 'Tabela'
    end
  end
end
