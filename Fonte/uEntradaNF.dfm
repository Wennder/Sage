inherited frmEntradaNF: TfrmEntradaNF
  Left = 0
  Top = 46
  Caption = 'Entrada de Nota Fiscal'
  ClientHeight = 429
  ClientWidth = 815
  OldCreateOrder = True
  OnShow = FormShow
  ExplicitWidth = 821
  ExplicitHeight = 457
  PixelsPerInch = 96
  TextHeight = 13
  inherited JvNavPaneToolPanel1: TJvNavPaneToolPanel
    Width = 815
    Height = 429
    ExplicitWidth = 632
    ExplicitHeight = 384
    object Bevel1: TBevel [0]
      Left = 3
      Top = 26
      Width = 806
      Height = 49
    end
    inherited pn: TPanel
      Top = 394
      Width = 811
      TabOrder = 14
      ExplicitTop = 394
      ExplicitWidth = 811
      inherited btnGrava: TcxButton
        Left = 555
        OnClick = btnGravaClick
        ExplicitLeft = 555
      end
      inherited btnCancela: TcxButton
        Left = 641
        OnClick = edtFornecedorEnter
        ExplicitLeft = 641
      end
      inherited brnDeleta: TcxButton
        Left = 469
        Enabled = False
        Visible = False
        ExplicitLeft = 469
      end
      inherited BtnSair: TcxButton
        Left = 727
        ExplicitLeft = 727
      end
      inherited btnExportar: TcxButton
        Left = 383
        ExplicitLeft = 383
      end
      inherited btnImprimir: TcxButton
        Left = 297
        ExplicitLeft = 297
      end
    end
    object edtValor: TJvValidateEdit
      Left = 604
      Top = 91
      Width = 70
      Height = 21
      CriticalPoints.MaxValueIncluded = False
      CriticalPoints.MinValueIncluded = False
      DisplayFormat = dfFloat
      DecimalPlaces = 2
      EditText = '0,00'
      HasMaxValue = True
      HasMinValue = True
      MaxValue = 999999.990000000000000000
      TabOrder = 10
    end
    object edtQuantidade: TJvValidateEdit
      Left = 533
      Top = 91
      Width = 70
      Height = 21
      CriticalPoints.MaxValueIncluded = False
      CriticalPoints.MinValueIncluded = False
      DisplayFormat = dfFloat
      DecimalPlaces = 2
      EditText = '0,00'
      HasMaxValue = True
      HasMinValue = True
      MaxValue = 999999.990000000000000000
      TabOrder = 9
    end
    object edtFornecedor: TcxTextEdit
      Tag = 19
      Left = 6
      Top = 43
      Properties.UseLeftAlignmentOnEditing = False
      TabOrder = 0
      OnEnter = edtFornecedorEnter
      OnExit = edtFornecedorExit
      OnKeyDown = edtFornecedorKeyDown
      OnKeyPress = edtFornecedorKeyPress
      Width = 75
    end
    object EditSerie: TcxTextEdit
      Tag = 8
      Left = 386
      Top = 43
      Properties.CharCase = ecUpperCase
      Properties.UseLeftAlignmentOnEditing = False
      TabOrder = 2
      OnExit = EditSerieExit
      Width = 75
    end
    object EditNumeroNF: TcxTextEdit
      Tag = 8
      Left = 461
      Top = 43
      Properties.UseLeftAlignmentOnEditing = False
      TabOrder = 3
      OnExit = EditNumeroNFExit
      OnKeyPress = edtFornecedorKeyPress
      Width = 75
    end
    object edtProduto: TcxTextEdit
      Tag = 8
      Left = 6
      Top = 91
      Properties.UseLeftAlignmentOnEditing = False
      TabOrder = 6
      OnEnter = edtProdutoEnter
      OnExit = edtProdutoExit
      OnKeyDown = edtProdutoKeyDown
      OnKeyPress = edtProdutoKeyPress
      Width = 75
    end
    object lblProduto: TcxLabel
      Left = 6
      Top = 28
      Caption = 'Fornecedor:'
      Transparent = True
    end
    object Label1: TcxLabel
      Left = 386
      Top = 28
      Caption = 'S'#233'rie:'
      Transparent = True
    end
    object Label2: TcxLabel
      Left = 461
      Top = 28
      Caption = 'N'#250'mero:'
      Transparent = True
    end
    object Label3: TcxLabel
      Left = 536
      Top = 28
      Caption = 'Data Entrada:'
      Transparent = True
    end
    object Label4: TcxLabel
      Left = 636
      Top = 28
      Caption = 'Data Emiss'#227'o:'
      Transparent = True
    end
    object Label5: TcxLabel
      Left = 6
      Top = 76
      Caption = 'Produto:'
      Transparent = True
    end
    object lblPreco: TcxLabel
      Left = 623
      Top = 76
      Caption = 'Vlr. Unit.'
      Transparent = True
    end
    object Label6: TcxLabel
      Left = 576
      Top = 74
      Caption = 'Qtd.'
      Transparent = True
    end
    object Label7: TcxLabel
      Left = 386
      Top = 76
      Caption = 'Unidade:'
      Transparent = True
    end
    object stFornecedor: TcxTextEdit
      Left = 80
      Top = 43
      TabStop = False
      AutoSize = False
      Enabled = False
      StyleDisabled.TextColor = clBlack
      TabOrder = 1
      Height = 21
      Width = 307
    end
    object stProduto: TcxTextEdit
      Left = 81
      Top = 91
      TabStop = False
      AutoSize = False
      Enabled = False
      StyleDisabled.TextColor = clBlack
      TabOrder = 7
      Height = 21
      Width = 306
    end
    object stUnidade: TcxTextEdit
      Left = 386
      Top = 91
      TabStop = False
      AutoSize = False
      Enabled = False
      StyleDisabled.TextColor = clBlack
      TabOrder = 8
      Height = 21
      Width = 147
    end
    object edtDataEmissao: TcxDateEdit
      Left = 636
      Top = 43
      Properties.SaveTime = False
      Properties.ShowTime = False
      Properties.UseLeftAlignmentOnEditing = False
      TabOrder = 5
      Width = 100
    end
    object edtDataEntrada: TcxDateEdit
      Left = 536
      Top = 43
      Properties.SaveTime = False
      Properties.ShowTime = False
      Properties.UseLeftAlignmentOnEditing = False
      TabOrder = 4
      Width = 100
    end
    object btnInsere: TcxButton
      Left = 675
      Top = 89
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
      TabOrder = 11
      WordWrap = True
      OnClick = btnInsereClick
    end
    object btnDeleta: TcxButton
      Left = 743
      Top = 89
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
      TabOrder = 12
      WordWrap = True
      OnClick = btnDeletaClick
    end
    object cxGrid1: TcxGrid
      Left = 6
      Top = 120
      Width = 803
      Height = 272
      TabOrder = 13
      object cxGrid1DBBandedTableView1: TcxGridDBBandedTableView
        Navigator.Buttons.CustomButtons = <>
        DataController.DataSource = DataSourceEntrada
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <
          item
            Kind = skSum
            Column = cxGrid1DBBandedTableView1ValorTotal
          end>
        DataController.Summary.SummaryGroups = <>
        OptionsData.Deleting = False
        OptionsData.DeletingConfirmation = False
        OptionsData.Editing = False
        OptionsData.Inserting = False
        OptionsView.CellAutoHeight = True
        OptionsView.ColumnAutoWidth = True
        OptionsView.Footer = True
        OptionsView.GroupByBox = False
        Bands = <
          item
            Caption = 'Entrada de Nota Fiscal'
          end>
        object cxGrid1DBBandedTableView1Produto: TcxGridDBBandedColumn
          DataBinding.FieldName = 'Produto'
          Width = 54
          Position.BandIndex = 0
          Position.ColIndex = 0
          Position.RowIndex = 0
        end
        object cxGrid1DBBandedTableView1CodigoPreferencial: TcxGridDBBandedColumn
          Caption = 'C'#243'd. Preferencial'
          DataBinding.FieldName = 'CodigoPreferencial'
          Width = 135
          Position.BandIndex = 0
          Position.ColIndex = 2
          Position.RowIndex = 0
        end
        object cxGrid1DBBandedTableView1Quantidade: TcxGridDBBandedColumn
          Caption = 'Qtd.'
          DataBinding.FieldName = 'Quantidade'
          HeaderAlignmentHorz = taRightJustify
          Width = 66
          Position.BandIndex = 0
          Position.ColIndex = 3
          Position.RowIndex = 0
        end
        object cxGrid1DBBandedTableView1ValorUnitario: TcxGridDBBandedColumn
          Caption = 'Vl. Unit.'
          DataBinding.FieldName = 'ValorUnitario'
          HeaderAlignmentHorz = taRightJustify
          Width = 63
          Position.BandIndex = 0
          Position.ColIndex = 4
          Position.RowIndex = 0
        end
        object cxGrid1DBBandedTableView1Descricao: TcxGridDBBandedColumn
          Caption = 'Descri'#231#227'o'
          DataBinding.FieldName = 'Descricao'
          Width = 244
          Position.BandIndex = 0
          Position.ColIndex = 1
          Position.RowIndex = 0
        end
        object cxGrid1DBBandedTableView1ValorTotal: TcxGridDBBandedColumn
          Caption = 'Total'
          DataBinding.FieldName = 'ValorTotal'
          HeaderAlignmentHorz = taRightJustify
          Width = 65
          Position.BandIndex = 0
          Position.ColIndex = 5
          Position.RowIndex = 0
        end
      end
      object cxGrid1Level1: TcxGridLevel
        GridView = cxGrid1DBBandedTableView1
      end
    end
  end
  inherited SaveDlg: TSaveDialog
    Left = 256
    Top = 312
  end
  object SQLMemTableEntrada: TSQLMemTable
    CurrentVersion = '6.00 '
    DatabaseName = 'MEMORY'
    ReadOnly = False
    CaseInsensitive = False
    TableName = 'TableEntradaNF'
    Exclusive = False
    MemoryTableAllocBy = 1000
    Left = 112
    Top = 264
    object SQLMemTableEntradaProduto: TIntegerField
      FieldName = 'Produto'
    end
    object SQLMemTableEntradaQuantidade: TFloatField
      FieldName = 'Quantidade'
      DisplayFormat = '#,##0.00'
    end
    object SQLMemTableEntradaValorUnitario: TFloatField
      FieldName = 'ValorUnitario'
      DisplayFormat = '#,##0.00'
    end
    object SQLMemTableEntradaDescricao: TStringField
      FieldName = 'Descricao'
      Size = 80
    end
    object SQLMemTableEntradaCodigoPreferencial: TStringField
      FieldName = 'CodigoPreferencial'
      Size = 30
    end
    object SQLMemTableEntradaValorTotal: TFloatField
      FieldName = 'ValorTotal'
      DisplayFormat = '#,##0.00'
    end
  end
  object DataSourceEntrada: TDataSource
    DataSet = SQLMemTableEntrada
    Left = 312
    Top = 248
  end
  object SQLMemQuery: TSQLMemQuery
    CurrentVersion = '6.00 '
    DatabaseName = 'MEMORY'
    ReadOnly = False
    CaseInsensitive = False
    Left = 224
    Top = 256
  end
end
