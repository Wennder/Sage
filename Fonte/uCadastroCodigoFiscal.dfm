inherited frmCadastroCodigoFiscal: TfrmCadastroCodigoFiscal
  Caption = 'Cadastro de C'#243'digos Fiscais'
  ClientHeight = 154
  ClientWidth = 486
  OldCreateOrder = True
  OnShow = FormShow
  ExplicitWidth = 492
  ExplicitHeight = 182
  PixelsPerInch = 96
  TextHeight = 13
  inherited JvNavPaneToolPanel1: TJvNavPaneToolPanel
    Width = 486
    Height = 154
    ExplicitHeight = 169
    inherited pn: TPanel
      Top = 119
      Width = 482
      TabOrder = 4
      ExplicitTop = 117
      ExplicitWidth = 774
      inherited btnGrava: TcxButton
        Left = 80
        OnClick = btnGravaClick
        ExplicitLeft = 372
        ExplicitTop = 12
      end
      inherited btnCancela: TcxButton
        Left = 181
        OnClick = btnCancelaClick
        ExplicitLeft = 473
      end
      inherited brnDeleta: TcxButton
        Left = 282
        OnClick = brnDeletaClick
        ExplicitLeft = 574
      end
      inherited BtnSair: TcxButton
        Left = 383
        ExplicitLeft = 675
      end
      inherited btnExportar: TcxButton
        Left = -122
        ExplicitLeft = 116
        ExplicitTop = 12
      end
      inherited btnImprimir: TcxButton
        Left = -21
        ExplicitLeft = 271
      end
    end
    object edtIcmsPF: TJvValidateEdit
      Left = 8
      Top = 85
      Width = 97
      Height = 21
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
    object edtIcmsPJ: TJvValidateEdit
      Left = 377
      Top = 86
      Width = 97
      Height = 21
      CriticalPoints.MaxValueIncluded = False
      CriticalPoints.MinValueIncluded = False
      DisplayFormat = dfFloat
      DecimalPlaces = 2
      EditText = '0,00'
      HasMaxValue = True
      HasMinValue = True
      MaxValue = 999999.990000000000000000
      TabOrder = 3
    end
    object edtCodigo: TcxTextEdit
      Tag = 12
      Left = 8
      Top = 48
      TabOrder = 0
      OnEnter = edtCodigoEnter
      OnExit = edtCodigoExit
      OnKeyDown = edtCodigoKeyDown
      OnKeyPress = edtCodigoKeyPress
      Width = 41
    end
    object edtDescricao: TcxTextEdit
      Left = 49
      Top = 48
      TabOrder = 1
      Width = 428
    end
    object lblCodigo: TcxLabel
      Left = 8
      Top = 32
      Caption = 'C'#243'digo:'
      Transparent = True
    end
    object lblDescricao: TcxLabel
      Left = 55
      Top = 32
      Caption = 'Descri'#231#227'o:'
      Transparent = True
    end
    object Label1: TcxLabel
      Left = 9
      Top = 72
      Caption = 'ICMS Pessoa F'#237'sica (%):'
      Transparent = True
    end
    object Label2: TcxLabel
      Left = 331
      Top = 70
      Caption = 'ICMS Pessoa Jur'#237'dica (%)'
      Transparent = True
    end
  end
end
