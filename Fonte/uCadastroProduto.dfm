inherited frmCadastroProduto: TfrmCadastroProduto
  Caption = 'Cadastro de Produto'
  ClientHeight = 425
  ClientWidth = 528
  OldCreateOrder = True
  OnShow = FormShow
  ExplicitWidth = 534
  ExplicitHeight = 453
  PixelsPerInch = 96
  TextHeight = 13
  inherited JvNavPaneToolPanel1: TJvNavPaneToolPanel
    Width = 528
    Height = 425
    ExplicitLeft = -80
    ExplicitTop = -40
    ExplicitWidth = 710
    ExplicitHeight = 454
    inherited pn: TPanel
      Top = 390
      Width = 524
      TabOrder = 20
      ExplicitTop = 390
      ExplicitWidth = 524
      inherited btnGrava: TcxButton
        Left = 182
        OnClick = btnGravaClick
        ExplicitLeft = 182
      end
      inherited btnCancela: TcxButton
        Left = 268
        OnClick = btnCancelaClick
        ExplicitLeft = 268
      end
      inherited brnDeleta: TcxButton
        Left = 354
        OnClick = brnDeletaClick
        ExplicitLeft = 354
      end
      inherited BtnSair: TcxButton
        Left = 440
        ExplicitLeft = 440
      end
      inherited btnExportar: TcxButton
        Left = 96
        ExplicitLeft = 96
      end
      inherited btnImprimir: TcxButton
        Left = 10
        ExplicitLeft = 10
      end
    end
    object edtCusto: TJvValidateEdit
      Left = 16
      Top = 363
      Width = 97
      Height = 21
      CriticalPoints.MaxValueIncluded = False
      CriticalPoints.MinValueIncluded = False
      DisplayFormat = dfFloat
      DecimalPlaces = 4
      EditText = '0,0000'
      HasMaxValue = True
      HasMinValue = True
      MaxValue = 999999.999900000000000000
      TabOrder = 19
    end
    object chkServico: TCheckBox
      Left = 436
      Top = 57
      Width = 77
      Height = 17
      Caption = #201' Servi'#231'o?'
      TabOrder = 3
    end
    object edtCodigo: TcxTextEdit
      Tag = 8
      Left = 16
      Top = 55
      TabOrder = 0
      OnEnter = edtCodigoEnter
      OnExit = edtCodigoExit
      OnKeyDown = edtCodigoKeyDown
      OnKeyPress = edtCodigoKeyPress
      Width = 65
    end
    object edtGrupo: TcxTextEdit
      Tag = 2
      Left = 16
      Top = 133
      TabOrder = 5
      OnExit = edtGrupoExit
      OnKeyDown = edtGrupoKeyDown
      OnKeyPress = edtCodigoKeyPress
      Width = 55
    end
    object edtDescGrupo: TcxTextEdit
      Left = 70
      Top = 133
      TabStop = False
      Enabled = False
      StyleDisabled.TextColor = clBlack
      TabOrder = 6
      Width = 443
    end
    object edtSubGrupo: TcxTextEdit
      Tag = 5
      Left = 16
      Top = 171
      TabOrder = 7
      OnExit = edtSubGrupoExit
      OnKeyDown = edtSubGrupoKeyDown
      OnKeyPress = edtCodigoKeyPress
      Width = 55
    end
    object edtDescSubGrupo: TcxTextEdit
      Left = 70
      Top = 171
      TabStop = False
      Enabled = False
      StyleDisabled.TextColor = clBlack
      TabOrder = 8
      Width = 443
    end
    object edtMarca: TcxTextEdit
      Tag = 3
      Left = 16
      Top = 206
      TabOrder = 9
      OnExit = edtMarcaExit
      OnKeyDown = edtMarcaKeyDown
      OnKeyPress = edtCodigoKeyPress
      Width = 55
    end
    object edtDescMarca: TcxTextEdit
      Left = 70
      Top = 206
      TabStop = False
      Enabled = False
      StyleDisabled.TextColor = clBlack
      TabOrder = 10
      Width = 443
    end
    object edtUndEntrada: TcxTextEdit
      Tag = 4
      Left = 16
      Top = 245
      TabOrder = 11
      OnExit = edtUndEntradaExit
      OnKeyDown = edtUndEntradaKeyDown
      OnKeyPress = edtCodigoKeyPress
      Width = 55
    end
    object edtDescUndEntrada: TcxTextEdit
      Left = 70
      Top = 245
      TabStop = False
      Enabled = False
      StyleDisabled.TextColor = clBlack
      TabOrder = 12
      Width = 344
    end
    object edtQtdEntrada: TcxTextEdit
      Left = 415
      Top = 245
      TabOrder = 13
      OnKeyPress = edtCodigoKeyPress
      Width = 98
    end
    object edtUndSaida: TcxTextEdit
      Tag = 4
      Left = 16
      Top = 287
      TabOrder = 14
      OnExit = edtUndSaidaExit
      OnKeyDown = edtUndSaidaKeyDown
      OnKeyPress = edtCodigoKeyPress
      Width = 55
    end
    object edtDescUndSaida: TcxTextEdit
      Left = 70
      Top = 287
      TabStop = False
      Enabled = False
      StyleDisabled.TextColor = clBlack
      TabOrder = 15
      Width = 344
    end
    object edtQtdSaida: TcxTextEdit
      Left = 415
      Top = 287
      TabOrder = 16
      OnKeyPress = edtCodigoKeyPress
      Width = 98
    end
    object Label1: TcxLabel
      Left = 16
      Top = 39
      Caption = 'C'#243'digo'
      Transparent = True
    end
    object Label2: TcxLabel
      Left = 16
      Top = 79
      Caption = 'Descri'#231#227'o'
      Transparent = True
    end
    object Label5: TcxLabel
      Left = 16
      Top = 117
      Caption = 'Grupo'
      Transparent = True
    end
    object Label6: TcxLabel
      Left = 16
      Top = 155
      Caption = 'SubGrupo'
      Transparent = True
    end
    object Label7: TcxLabel
      Left = 16
      Top = 193
      Caption = 'Marca'
      Transparent = True
    end
    object Label8: TcxLabel
      Left = 16
      Top = 347
      Caption = 'Custo'
      Transparent = True
    end
    object Label9: TcxLabel
      Left = 16
      Top = 231
      Caption = 'Unidade de Entrada'
      Transparent = True
    end
    object Label10: TcxLabel
      Left = 16
      Top = 271
      Caption = 'Unidade de Sa'#237'da'
      Transparent = True
    end
    object Label11: TcxLabel
      Left = 415
      Top = 231
      Caption = 'Qtd. Entrada'
      Transparent = True
    end
    object Label12: TcxLabel
      Left = 415
      Top = 271
      Caption = 'Qtd. Sa'#237'da'
      Transparent = True
    end
    object edtReferencia: TcxTextEdit
      Left = 81
      Top = 55
      Properties.CharCase = ecUpperCase
      TabOrder = 1
      Width = 153
    end
    object Label3: TcxLabel
      Left = 81
      Top = 39
      Caption = 'C'#243'd. Refer'#234'ncia'
      Transparent = True
    end
    object Label4: TcxLabel
      Left = 234
      Top = 39
      Caption = 'C'#243'd. Fabrica'#231#227'o'
      Transparent = True
    end
    object edtFabricacao: TcxTextEdit
      Left = 234
      Top = 55
      Properties.CharCase = ecUpperCase
      TabOrder = 2
      Width = 153
    end
    object edtDescricao: TcxTextEdit
      Left = 16
      Top = 95
      Properties.CharCase = ecUpperCase
      TabOrder = 4
      Width = 497
    end
    object EditNCMCodigo: TcxTextEdit
      Tag = 17
      Left = 16
      Top = 325
      TabOrder = 17
      OnExit = EditNCMCodigoExit
      OnKeyDown = EditNCMCodigoKeyDown
      OnKeyPress = EditNCMCodigoKeyPress
      Width = 98
    end
    object EditNCMDescricao: TcxTextEdit
      Left = 113
      Top = 325
      TabStop = False
      Enabled = False
      StyleDisabled.TextColor = clBlack
      TabOrder = 18
      Width = 400
    end
    object Label13: TcxLabel
      Left = 16
      Top = 311
      Caption = 'NCM/SH:'
      Transparent = True
    end
  end
end
