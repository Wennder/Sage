inherited frmUltimasDefinicoes: TfrmUltimasDefinicoes
  Left = 258
  Top = 117
  Caption = #218'ltimas Defini'#231#245'es'
  ClientHeight = 520
  ClientWidth = 493
  OldCreateOrder = True
  OnShow = FormShow
  ExplicitWidth = 499
  ExplicitHeight = 548
  PixelsPerInch = 96
  TextHeight = 13
  inherited JvNavPaneToolPanel1: TJvNavPaneToolPanel
    Width = 493
    Height = 520
    ExplicitWidth = 493
    ExplicitHeight = 514
    inherited pn: TPanel
      Top = 485
      Width = 489
      TabOrder = 38
      ExplicitTop = 485
      ExplicitWidth = 489
      inherited btnGrava: TcxButton
        Left = 233
        TabOrder = 1
        OnClick = btnGravaClick
        ExplicitLeft = 233
      end
      inherited btnCancela: TcxButton
        Left = 319
        TabOrder = 2
        OnClick = btnCancelaClick
        ExplicitLeft = 319
      end
      inherited brnDeleta: TcxButton
        Left = -111
        Enabled = False
        TabOrder = 6
        Visible = False
        ExplicitLeft = -111
      end
      inherited BtnSair: TcxButton
        Left = 405
        TabOrder = 3
        Visible = False
        ExplicitLeft = 405
      end
      inherited btnExportar: TcxButton
        Left = -25
        TabOrder = 5
        ExplicitLeft = -25
      end
      inherited btnImprimir: TcxButton
        Left = 61
        TabOrder = 4
        ExplicitLeft = 61
      end
      object btnCadAux: TcxButton
        AlignWithMargins = True
        Left = 147
        Top = 4
        Width = 80
        Height = 25
        Align = alRight
        Caption = '&Placas'
        OptionsImage.Glyph.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          00000000000000000000000000000000000000000000000000001A1A1A332321
          204022201EF51F1E1DFF0504041A000000000000000000000000000000000000
          00001E1D1CD7201F1EFF05050525242321F5222120FF070606205E5C5BFFACA4
          9EFF21201FFF1F1E1DFF8A837EEC857C75BF887F78BF918984BF968F8BBF8F88
          82BF383633F9272624FF7E7975DF3A3835FF312F2DFF827972CF5E5C5BFFBBB1
          A9FFA09993FF9B9590FFABA19BEF9A8F7BFF978C78FF958B77FF928875FF8C81
          6EFF867B67FF837865FF7F7462FF796D5AFF716552FF6C604DFF716C6AFFC0B6
          AFFFC3BAB4FFC9C0BAFFC7BEB8FF248FD7FF238FD6FF218DD5FF1F8AD1FF1E84
          CCFF1C7CC3FF1B71B8FF1964ABFF1861A8FF165FA6FF155EA5FFC4BCB5FFC5BC
          B6FFC9BFBAFFC9C0BAFFC3B9B3FF0097FEFF0198FFFF0198FFFF0097FEFF0094
          FBFF008EF5FF0084EBFF0073DAFF0066CDFF0065CCFF0065CCFFB9B1ADFFB5AD
          A8FFB4ABA6FFB2AAA3FFAFA6A0FF0CA1FFFF11A5FFFF10A4FFFF099FFFFF0199
          FFFF0095FCFF008EF5FF0080E7FF006DD4FF0065CCFF0065CCFFA49E99FF2727
          27FF1F1D1CFF272524FF9C948DFF20B2FFFF29B9FFFF26B7FFFF1AAEFFFF0CA2
          FFFF0198FFFF0093FAFF0088EFFF0076DDFF0065CCFF0065CCFF8A837DCF847F
          7AFF2D2B29FF2A2826FFA29992FF32C0FEFF42CEFEFF3DCAFEFF2ABAFFFF15A9
          FFFF049BFFFF0096FDFF008CF3FF007BE2FF0067CEFF0065CCFF0B0B0A10918A
          85BA8A857FD68A857ED6746E69BA37C4FEFF4BD5FEFF44CFFEFF2DBCFEFF17AB
          FFFF059CFFFF0096FDFF008DF4FF007BE2FF0067CEFF0065CCFF000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000}
        OptionsImage.Spacing = 3
        TabOrder = 0
        WordWrap = True
        OnClick = btnCadAuxClick
      end
    end
    object edtCPF: TMaskEdit
      Left = 608
      Top = 404
      Width = 102
      Height = 21
      CharCase = ecUpperCase
      EditMask = '999.999.999-99;0; '
      MaxLength = 14
      TabOrder = 22
      Text = ''
      Visible = False
    end
    object edtCNPJ: TMaskEdit
      Left = 608
      Top = 431
      Width = 127
      Height = 21
      CharCase = ecUpperCase
      EditMask = '99.999.999/9999-99;0; '
      MaxLength = 18
      TabOrder = 20
      Text = ''
      Visible = False
    end
    object edtCEP: TMaskEdit
      Left = 608
      Top = 458
      Width = 110
      Height = 21
      CharCase = ecUpperCase
      EditMask = '99999-999;0; '
      MaxLength = 9
      TabOrder = 21
      Text = ''
      Visible = False
    end
    object edtNaturezaOperacao: TcxTextEdit
      Tag = 11
      Left = 9
      Top = 108
      TabOrder = 3
      OnExit = edtNaturezaOperacaoExit
      OnKeyDown = edtNaturezaOperacaoKeyDown
      OnKeyPress = edtNaturezaOperacaoKeyPress
      Width = 65
    end
    object edtCFOP: TcxTextEdit
      Tag = 12
      Left = 9
      Top = 145
      TabOrder = 5
      OnExit = edtCFOPExit
      OnKeyDown = edtCFOPKeyDown
      OnKeyPress = edtNaturezaOperacaoKeyPress
      Width = 65
    end
    object edtCliente: TcxTextEdit
      Tag = 9
      Left = 9
      Top = 182
      TabOrder = 7
      OnExit = edtClienteExit
      OnKeyDown = edtClienteKeyDown
      OnKeyPress = edtNaturezaOperacaoKeyPress
      Width = 65
    end
    object edtVeiculo: TcxTextEdit
      Left = 146
      Top = 370
      TabOrder = 15
      Width = 265
    end
    object edtVendedor: TcxTextEdit
      Tag = 7
      Left = 9
      Top = 72
      TabOrder = 1
      OnExit = edtVendedorExit
      OnKeyDown = edtVendedorKeyDown
      OnKeyPress = edtNaturezaOperacaoKeyPress
      Width = 65
    end
    object lblNaturezaOperacao: TcxLabel
      Left = 8
      Top = 92
      Caption = 'Natureza de Opera'#231#227'o:'
      Transparent = True
    end
    object lblCFOP: TcxLabel
      Left = 8
      Top = 129
      Caption = 'CFOP:'
      Transparent = True
    end
    object lblCliente: TcxLabel
      Left = 8
      Top = 167
      Caption = 'Cliente:'
      Transparent = True
    end
    object lblObservacao: TcxLabel
      Left = 9
      Top = 394
      Caption = 'Observa'#231#227'o:'
      Transparent = True
    end
    object lblEndereco: TcxLabel
      Left = 8
      Top = 242
      Caption = 'Endere'#231'o:'
      Transparent = True
    end
    object lblBairro: TcxLabel
      Left = 9
      Top = 278
      Caption = 'Bairro:'
      Transparent = True
    end
    object lblCEP: TcxLabel
      Left = 354
      Top = 278
      Caption = 'CEP:'
      Transparent = True
    end
    object lblMunicipio: TcxLabel
      Left = 8
      Top = 317
      Caption = 'Munic'#237'pio:'
      Transparent = True
    end
    object lblUF: TcxLabel
      Left = 231
      Top = 318
      Caption = 'UF:'
      Transparent = True
    end
    object lblCPFCNPJ: TcxLabel
      Left = 8
      Top = 206
      Caption = 'CNPJ/CPF:'
      Transparent = True
    end
    object lclInscEstadual: TcxLabel
      Left = 220
      Top = 206
      Caption = 'Inscri'#231#227'o Estadual:'
      Transparent = True
    end
    object Label1: TcxLabel
      Left = 146
      Top = 355
      Caption = 'Ve'#237'culo:'
      Transparent = True
    end
    object Label2: TcxLabel
      Left = 9
      Top = 355
      Caption = 'Placa:'
      Transparent = True
    end
    object Label3: TcxLabel
      Left = 458
      Top = 355
      Caption = 'Km:'
      Transparent = True
    end
    object Label4: TcxLabel
      Left = 8
      Top = 55
      Caption = 'Vendedor (Usu'#225'rio):'
      Transparent = True
    end
    object stNaturezaOperacao: TcxTextEdit
      Left = 73
      Top = 108
      TabStop = False
      AutoSize = False
      Enabled = False
      StyleDisabled.TextColor = clBlack
      TabOrder = 4
      Height = 21
      Width = 410
    end
    object stCFOP: TcxTextEdit
      Left = 73
      Top = 145
      TabStop = False
      AutoSize = False
      Enabled = False
      StyleDisabled.TextColor = clBlack
      TabOrder = 6
      Height = 21
      Width = 410
    end
    object stCliente: TcxTextEdit
      Left = 73
      Top = 182
      TabStop = False
      AutoSize = False
      Enabled = False
      StyleDisabled.TextColor = clBlack
      TabOrder = 8
      Height = 21
      Width = 410
    end
    object stEndereco: TcxTextEdit
      Left = 9
      Top = 258
      TabStop = False
      AutoSize = False
      Enabled = False
      StyleDisabled.TextColor = clBlack
      TabOrder = 9
      Height = 21
      Width = 475
    end
    object stBairro: TcxTextEdit
      Left = 9
      Top = 294
      TabStop = False
      AutoSize = False
      Enabled = False
      StyleDisabled.TextColor = clBlack
      TabOrder = 10
      Height = 21
      Width = 344
    end
    object stCEP: TcxTextEdit
      Left = 352
      Top = 294
      TabStop = False
      AutoSize = False
      Enabled = False
      StyleDisabled.TextColor = clBlack
      TabOrder = 11
      Height = 21
      Width = 131
    end
    object stMunicipio: TcxTextEdit
      Left = 9
      Top = 331
      TabStop = False
      AutoSize = False
      Enabled = False
      StyleDisabled.TextColor = clBlack
      TabOrder = 12
      Height = 21
      Width = 223
    end
    object stUF: TcxTextEdit
      Left = 231
      Top = 331
      TabStop = False
      AutoSize = False
      Enabled = False
      StyleDisabled.TextColor = clBlack
      TabOrder = 13
      Height = 21
      Width = 33
    end
    object stCPFCNPJ: TcxTextEdit
      Left = 9
      Top = 222
      TabStop = False
      AutoSize = False
      Enabled = False
      StyleDisabled.TextColor = clBlack
      TabOrder = 17
      Height = 21
      Width = 213
    end
    object stInscEstadual: TcxTextEdit
      Left = 220
      Top = 222
      TabStop = False
      AutoSize = False
      Enabled = False
      StyleDisabled.TextColor = clBlack
      TabOrder = 18
      Height = 21
      Width = 263
    end
    object stVendedor: TcxTextEdit
      Left = 73
      Top = 72
      TabStop = False
      AutoSize = False
      Enabled = False
      StyleDisabled.TextColor = clBlack
      TabOrder = 2
      Height = 21
      Width = 410
    end
    object ComboBoxOperacao: TcxComboBox
      Left = 9
      Top = 30
      Properties.DropDownListStyle = lsFixedList
      Properties.Items.Strings = (
        'Or'#231'amento'
        'Pedido'
        'Cupom Fiscal')
      Properties.OnChange = ComboBoxOperacaoChange
      TabOrder = 0
      Text = 'Or'#231'amento'
      Width = 183
    end
    object EdtObservacao: TcxMemo
      Left = 9
      Top = 410
      TabOrder = 19
      Height = 63
      Width = 475
    end
    object edtKM: TcxCurrencyEdit
      Left = 411
      Top = 370
      EditValue = 0.000000000000000000
      Properties.Alignment.Horz = taRightJustify
      Properties.DisplayFormat = ',0.00;-,0.00'
      Properties.EditFormat = ',0.00;-,0.00'
      Properties.UseLeftAlignmentOnEditing = False
      TabOrder = 16
      Width = 72
    end
    object edtPlaca: TcxMaskEdit
      Tag = 14
      Left = 9
      Top = 370
      Properties.CharCase = ecUpperCase
      Properties.EditMask = 'LLL-9999'
      Properties.UseLeftAlignmentOnEditing = False
      Properties.ValidateOnEnter = False
      TabOrder = 14
      Text = '   -    '
      OnExit = edtPlacaExit
      OnKeyDown = edtPlacaKeyDown
      Width = 136
    end
  end
  inherited SaveDlg: TSaveDialog
    Left = 744
    Top = 72
  end
end
