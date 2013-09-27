inherited frmPlacas: TfrmPlacas
  Caption = 'Cadastro de Placas por Cliente'
  ClientHeight = 398
  ClientWidth = 542
  OldCreateOrder = True
  OnShow = FormShow
  ExplicitWidth = 548
  ExplicitHeight = 426
  PixelsPerInch = 96
  TextHeight = 13
  inherited JvNavPaneToolPanel1: TJvNavPaneToolPanel
    Width = 542
    Height = 398
    ExplicitWidth = 489
    ExplicitHeight = 462
    inherited pn: TPanel
      Top = 363
      Width = 538
      TabOrder = 8
      ExplicitTop = 363
      ExplicitWidth = 538
      inherited btnGrava: TcxButton
        Left = 282
        OnClick = btnGravaClick
        ExplicitLeft = 282
      end
      inherited btnCancela: TcxButton
        Left = 368
        ExplicitLeft = 368
      end
      inherited brnDeleta: TcxButton
        Left = 24
        Enabled = False
        Visible = False
        ExplicitLeft = 24
      end
      inherited BtnSair: TcxButton
        Left = 454
        ExplicitLeft = 454
      end
      inherited btnExportar: TcxButton
        Left = 196
        ExplicitLeft = 196
      end
      inherited btnImprimir: TcxButton
        Left = 110
        ExplicitLeft = 110
      end
    end
    object cxGrid: TcxGrid
      Left = 8
      Top = 113
      Width = 526
      Height = 247
      TabOrder = 7
      object cxGridDBTableView: TcxGridDBTableView
        Navigator.Buttons.CustomButtons = <>
        DataController.DataSource = dsCadastro
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        OptionsData.CancelOnExit = False
        OptionsData.Deleting = False
        OptionsData.DeletingConfirmation = False
        OptionsData.Editing = False
        OptionsData.Inserting = False
        OptionsView.GroupByBox = False
        object cxGridDBTableViewPlaca: TcxGridDBColumn
          DataBinding.FieldName = 'Placa'
          PropertiesClassName = 'TcxMaskEditProperties'
          Properties.CharCase = ecUpperCase
          Properties.EditMask = 'LLL-9999'
          Properties.UseLeftAlignmentOnEditing = False
          Properties.ValidateOnEnter = False
          Options.Filtering = False
        end
        object cxGridDBTableViewVeiculo: TcxGridDBColumn
          DataBinding.FieldName = 'Veiculo'
          Options.Filtering = False
          Width = 320
        end
        object cxGridDBTableViewKm: TcxGridDBColumn
          DataBinding.FieldName = 'Km'
          Options.Filtering = False
          Width = 82
        end
      end
      object cxGridLevel: TcxGridLevel
        GridView = cxGridDBTableView
      end
    end
    object edtCliente: TcxTextEdit
      Tag = 9
      Left = 8
      Top = 45
      Hint = 
        'Informe o c'#243'digo do cliente ou pressione F2 para pesquisar o cli' +
        'ente por nome.'
      TabOrder = 0
      OnExit = edtClienteExit
      OnKeyDown = edtClienteKeyDown
      OnKeyPress = edtClienteKeyPress
      Width = 57
    end
    object edtVeiculo: TcxTextEdit
      Tag = 8
      Left = 84
      Top = 87
      Hint = 'Informe a marca e modelo do ve'#237'culo'
      TabOrder = 3
      Width = 325
    end
    object lblCliente: TcxLabel
      Left = 8
      Top = 31
      Caption = 'Cliente:'
      Transparent = True
    end
    object lblPlaca: TcxLabel
      Left = 8
      Top = 72
      Caption = 'Placa:'
      Transparent = True
    end
    object lblKm: TcxLabel
      Left = 455
      Top = 72
      Caption = 'Km:'
      Transparent = True
    end
    object lblVeiculo: TcxLabel
      Left = 84
      Top = 72
      Caption = 'Ve'#237'culo:'
      Transparent = True
    end
    object edtPlaca: TcxMaskEdit
      Tag = 14
      Left = 8
      Top = 87
      Properties.CharCase = ecUpperCase
      Properties.IgnoreMaskBlank = True
      Properties.EditMask = 'LLL-9999'
      Properties.UseLeftAlignmentOnEditing = False
      Properties.ValidateOnEnter = False
      TabOrder = 2
      Text = '   -    '
      Width = 77
    end
    object edtKM: TcxCurrencyEdit
      Left = 408
      Top = 87
      EditValue = 0.000000000000000000
      Properties.Alignment.Horz = taRightJustify
      Properties.DisplayFormat = ',0.00;-,0.00'
      Properties.EditFormat = ',0.00;-,0.00'
      Properties.UseLeftAlignmentOnEditing = False
      TabOrder = 4
      Width = 72
    end
    object stCliente: TcxTextEdit
      Left = 64
      Top = 45
      TabStop = False
      AutoSize = False
      Enabled = False
      StyleDisabled.TextColor = clBlack
      TabOrder = 1
      Height = 21
      Width = 470
    end
    object btnInsere: TcxButton
      Left = 481
      Top = 85
      Width = 26
      Height = 24
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
      TabOrder = 5
      WordWrap = True
      OnClick = btnInsereClick
    end
    object btnDeleta: TcxButton
      Left = 508
      Top = 85
      Width = 26
      Height = 24
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
      TabOrder = 6
      WordWrap = True
      OnClick = btnDeletaClick
    end
  end
  inherited SaveDlg: TSaveDialog
    Left = 88
    Top = 432
  end
  object dsCadastro: TDataSource
    DataSet = cdsCadastro
    Left = 112
    Top = 200
  end
  object cdsCadastro: TClientDataSet
    Aggregates = <>
    Filter = 'DML <> '#39'E'#39
    Filtered = True
    Params = <>
    AfterEdit = cdsCadastroAfterEdit
    OnNewRecord = cdsCadastroNewRecord
    Left = 112
    Top = 144
    object cdsCadastroDML: TStringField
      FieldName = 'DML'
      Size = 1
    end
    object cdsCadastroPlaca: TStringField
      FieldName = 'Placa'
      Size = 15
    end
    object cdsCadastroVeiculo: TStringField
      FieldName = 'Veiculo'
      Size = 30
    end
    object cdsCadastroKM: TIntegerField
      FieldName = 'KM'
    end
  end
end
