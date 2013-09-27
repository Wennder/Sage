inherited frmCadastroCidade: TfrmCadastroCidade
  Left = 288
  Top = 243
  Caption = 'Cadastro de Cidade'
  ClientHeight = 145
  ClientWidth = 480
  OldCreateOrder = True
  OnShow = FormShow
  ExplicitWidth = 486
  ExplicitHeight = 173
  PixelsPerInch = 96
  TextHeight = 13
  inherited JvNavPaneToolPanel1: TJvNavPaneToolPanel
    Width = 480
    Height = 145
    ExplicitWidth = 481
    ExplicitHeight = 164
    inherited pn: TPanel
      Top = 110
      Width = 476
      TabOrder = 4
      ExplicitTop = 118
      ExplicitWidth = 477
      inherited btnGrava: TcxButton
        Left = 74
        OnClick = btnGravaClick
        ExplicitLeft = -26
      end
      inherited btnCancela: TcxButton
        Left = 175
        OnClick = btnCancelaClick
        ExplicitLeft = 176
      end
      inherited brnDeleta: TcxButton
        Left = 276
        OnClick = brnDeletaClick
        ExplicitLeft = 277
      end
      inherited BtnSair: TcxButton
        Left = 377
        ExplicitLeft = 378
      end
      inherited btnExportar: TcxButton
        Left = -27
        ExplicitLeft = 134
      end
      inherited btnImprimir: TcxButton
        Left = -128
        ExplicitLeft = -127
      end
    end
    object cboUF: TComboBox
      Left = 424
      Top = 48
      Width = 49
      Height = 22
      BevelInner = bvNone
      Style = csOwnerDrawFixed
      CharCase = ecUpperCase
      Sorted = True
      TabOrder = 2
      Items.Strings = (
        'AC'
        'AL'
        'AM'
        'AP'
        'BA'
        'CE'
        'DF'
        'ES'
        'GO'
        'MA'
        'MG'
        'MS'
        'MT'
        'PA'
        'PB'
        'PE'
        'PI'
        'PR'
        'RJ'
        'RN'
        'RO'
        'RR'
        'RS'
        'SC'
        'SE'
        'SP'
        'TO')
    end
    object edtCodigo: TcxTextEdit
      Tag = 1
      Left = 8
      Top = 48
      TabOrder = 0
      OnEnter = edtCodigoEnter
      OnExit = edtCodigoExit
      OnKeyDown = edtCodigoKeyDown
      OnKeyPress = edtCodigoKeyPress
      Width = 48
    end
    object edtNome: TcxTextEdit
      Left = 56
      Top = 48
      Properties.CharCase = ecUpperCase
      TabOrder = 1
      Width = 361
    end
    object EditCodIbge: TcxTextEdit
      Left = 9
      Top = 87
      TabOrder = 3
      Width = 64
    end
    object lblCodigo: TcxLabel
      Left = 8
      Top = 32
      Caption = 'C'#243'digo'
      Transparent = True
    end
    object lblNome: TcxLabel
      Left = 57
      Top = 32
      Caption = 'Nome'
      Transparent = True
    end
    object lblUF: TcxLabel
      Left = 425
      Top = 32
      Caption = 'UF'
      Transparent = True
    end
    object Label1: TcxLabel
      Left = 10
      Top = 72
      Caption = 'Cod. IBGE'
      Transparent = True
    end
  end
end
