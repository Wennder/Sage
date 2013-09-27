inherited frmCadastroAnaliseCredito: TfrmCadastroAnaliseCredito
  Caption = 'An'#225'lise de Cr'#233'dito'
  ClientHeight = 156
  ClientWidth = 481
  OnShow = FormShow
  ExplicitWidth = 487
  ExplicitHeight = 184
  PixelsPerInch = 96
  TextHeight = 13
  inherited JvNavPaneToolPanel1: TJvNavPaneToolPanel
    Width = 481
    Height = 156
    ExplicitWidth = 487
    ExplicitHeight = 165
    inherited pn: TPanel
      Top = 121
      Width = 477
      TabOrder = 4
      ExplicitTop = 118
      ExplicitWidth = 483
      inherited btnGrava: TcxButton
        Left = 75
        OnClick = btnGravaClick
        ExplicitLeft = -121
      end
      inherited btnCancela: TcxButton
        Left = 176
        OnClick = btnCancelaClick
        ExplicitLeft = -20
      end
      inherited brnDeleta: TcxButton
        Left = 277
        OnClick = brnDeletaClick
        ExplicitLeft = 182
      end
      inherited BtnSair: TcxButton
        Left = 378
        ExplicitLeft = 384
      end
      inherited btnExportar: TcxButton
        Left = -26
        ExplicitLeft = 162
        ExplicitTop = 12
      end
      inherited btnImprimir: TcxButton
        Left = -127
        ExplicitLeft = 64
        ExplicitTop = 12
      end
    end
    object stCliente: TStaticText
      Left = 65
      Top = 45
      Width = 412
      Height = 20
      AutoSize = False
      BevelKind = bkFlat
      BorderStyle = sbsSingle
      Color = clBtnFace
      ParentColor = False
      TabOrder = 1
      Transparent = False
    end
    object edtLimiteCredito: TJvValidateEdit
      Left = 8
      Top = 88
      Width = 153
      Height = 21
      Hint = 
        'Informe o valor m'#225'ximo de cr'#233'dito que o cliente selecionado pode' +
        ' possuir.'
      CriticalPoints.MaxValueIncluded = False
      CriticalPoints.MinValueIncluded = False
      DisplayFormat = dfFloat
      DecimalPlaces = 2
      EditText = '0,00'
      HasMaxValue = True
      HasMinValue = True
      MaxValue = 999999.990000000000000000
      TabOrder = 2
    end
    object edtCliente: TcxTextEdit
      Tag = 9
      Left = 8
      Top = 45
      Hint = 
        'Informe o c'#243'digo do cliente ou pressione F2 para pesquisar o cli' +
        'ente por nome.'
      Style.Color = clWindow
      TabOrder = 0
      OnEnter = edtClienteEnter
      OnExit = edtClienteExit
      OnKeyDown = edtClienteKeyDown
      OnKeyPress = edtClienteKeyPress
      Width = 57
    end
    object Label1: TcxLabel
      Left = 8
      Top = 31
      Caption = 'Cliente'
      Transparent = True
    end
    object Label2: TcxLabel
      Left = 8
      Top = 72
      Caption = 'Limite de Cr'#233'dito:'
      Transparent = True
    end
    object Label3: TcxLabel
      Left = 164
      Top = 72
      Caption = 'V'#225'lido at'#233':'
      Transparent = True
    end
    object edtValidade: TcxDateEdit
      Left = 164
      Top = 88
      Hint = 
        'Informe a validade do cr'#233'dito descrito para o cliente selecionad' +
        'o.'
      EditValue = 38904d
      TabOrder = 3
      Width = 109
    end
  end
end
