inherited frmDadosConsumidor: TfrmDadosConsumidor
  Left = 268
  Top = 204
  Caption = 'Dados do Consumidor'
  ClientHeight = 228
  OldCreateOrder = True
  ExplicitWidth = 496
  ExplicitHeight = 256
  PixelsPerInch = 96
  TextHeight = 13
  inherited JvNavPaneToolPanel1: TJvNavPaneToolPanel
    Height = 228
    ExplicitHeight = 228
    inherited pn: TPanel
      Top = 193
      TabOrder = 7
      ExplicitTop = 193
      inherited btnGrava: TcxButton
        Left = 316
        OnClick = btnGravaClick
        ExplicitLeft = 316
      end
      inherited btnCancela: TcxButton
        Left = 144
        Enabled = False
        Visible = False
        ExplicitLeft = 144
      end
      inherited brnDeleta: TcxButton
        Left = -28
        Enabled = False
        Visible = False
        ExplicitLeft = -28
      end
      inherited btnExportar: TcxButton
        Left = 230
        ExplicitLeft = 230
      end
    end
    object edtCEP: TMaskEdit
      Left = 8
      Top = 152
      Width = 110
      Height = 21
      CharCase = ecUpperCase
      EditMask = '99999-999;0; '
      MaxLength = 9
      TabOrder = 5
      Text = ''
    end
    object edtFone: TMaskEdit
      Left = 355
      Top = 152
      Width = 115
      Height = 21
      CharCase = ecUpperCase
      EditMask = '99 9999-9999;0; '
      MaxLength = 12
      TabOrder = 6
      Text = ''
    end
    object edtNome: TcxTextEdit
      Left = 5
      Top = 45
      Properties.CharCase = ecUpperCase
      TabOrder = 0
      Width = 465
    end
    object edtEndereco: TcxTextEdit
      Left = 6
      Top = 79
      Properties.CharCase = ecUpperCase
      TabOrder = 1
      Width = 463
    end
    object edtBairro: TcxTextEdit
      Left = 7
      Top = 115
      Properties.CharCase = ecUpperCase
      TabOrder = 2
      Width = 168
    end
    object edtCidade: TcxTextEdit
      Tag = 1
      Left = 177
      Top = 114
      TabOrder = 3
      OnEnter = edtCidadeEnter
      OnExit = edtCidadeExit
      OnKeyDown = edtCidadeKeyDown
      OnKeyPress = edtCidadeKeyPress
      Width = 49
    end
    object edtCidadeNome: TcxTextEdit
      Left = 226
      Top = 114
      TabStop = False
      TabOrder = 4
      Width = 243
    end
    object lblNome: TcxLabel
      Left = 6
      Top = 32
      Caption = 'Nome:'
      Transparent = True
    end
    object Label1: TcxLabel
      Left = 6
      Top = 65
      Caption = 'Endere'#231'o:'
      Transparent = True
    end
    object Label2: TcxLabel
      Left = 178
      Top = 99
      Caption = 'Cidade:'
      Transparent = True
    end
    object Label3: TcxLabel
      Left = 356
      Top = 138
      Caption = 'Fone:'
      Transparent = True
    end
    object Label4: TcxLabel
      Left = 8
      Top = 136
      Caption = 'CEP:'
      Transparent = True
    end
    object Label5: TcxLabel
      Left = 7
      Top = 101
      Caption = 'Bairro:'
      Transparent = True
    end
  end
end
