inherited frmCadastroComissionado: TfrmCadastroComissionado
  Left = 301
  Top = 197
  Caption = 'Cadastro de Comissionado'
  ClientHeight = 237
  ClientWidth = 515
  OldCreateOrder = True
  OnShow = FormShow
  ExplicitWidth = 521
  ExplicitHeight = 265
  PixelsPerInch = 96
  TextHeight = 13
  inherited JvNavPaneToolPanel1: TJvNavPaneToolPanel
    Width = 515
    Height = 237
    ExplicitWidth = 510
    ExplicitHeight = 252
    inherited pn: TPanel
      Top = 202
      Width = 511
      TabOrder = 11
      ExplicitTop = 200
      ExplicitWidth = 506
      inherited btnGrava: TcxButton
        Left = 109
        OnClick = btnGravaClick
        ExplicitLeft = 296
        ExplicitTop = -4
      end
      inherited btnCancela: TcxButton
        Left = 210
        OnClick = btnCancelaClick
        ExplicitLeft = 3
      end
      inherited brnDeleta: TcxButton
        Left = 311
        OnClick = brnDeletaClick
        ExplicitLeft = 205
      end
      inherited BtnSair: TcxButton
        Left = 412
        ExplicitLeft = 407
      end
      inherited btnExportar: TcxButton
        Left = 8
        ExplicitLeft = 74
        ExplicitTop = 12
      end
      inherited btnImprimir: TcxButton
        Left = -93
        ExplicitLeft = -32
        ExplicitTop = 12
      end
    end
    object edtComissao: TJvValidateEdit
      Left = 399
      Top = 48
      Width = 105
      Height = 21
      CriticalPoints.MaxValueIncluded = False
      CriticalPoints.MinValueIncluded = False
      DisplayFormat = dfFloat
      DecimalPlaces = 4
      DisplayPrefix = '% '
      EditText = '0,0000'
      HasMaxValue = True
      HasMinValue = True
      MaxValue = 999999.999900000000000000
      TabOrder = 2
    end
    object edtCEP: TMaskEdit
      Left = 312
      Top = 128
      Width = 96
      Height = 21
      EditMask = '99999-999;0; '
      MaxLength = 9
      TabOrder = 6
      Text = ''
    end
    object edtFone: TMaskEdit
      Left = 414
      Top = 128
      Width = 91
      Height = 21
      EditMask = '99 9999-9999;0; '
      MaxLength = 12
      TabOrder = 7
      Text = ''
    end
    object edtFax: TMaskEdit
      Left = 9
      Top = 168
      Width = 103
      Height = 21
      EditMask = '99 9999-9999;0; '
      MaxLength = 12
      TabOrder = 8
      Text = ''
    end
    object edtCelular: TMaskEdit
      Left = 120
      Top = 168
      Width = 104
      Height = 21
      EditMask = '99 9999-9999;0; '
      MaxLength = 12
      TabOrder = 9
      Text = ''
    end
    object edtCodigo: TcxTextEdit
      Tag = 7
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
      TabOrder = 1
      Width = 337
    end
    object edtEndereco: TcxTextEdit
      Left = 8
      Top = 88
      TabOrder = 3
      Width = 313
    end
    object edtBairro: TcxTextEdit
      Left = 328
      Top = 88
      TabOrder = 4
      Width = 177
    end
    object edtCidade: TcxTextEdit
      Tag = 1
      Left = 9
      Top = 128
      TabOrder = 5
      OnEnter = edtCidadeEnter
      OnExit = edtCidadeExit
      OnKeyDown = edtCidadeKeyDown
      OnKeyPress = edtCidadeKeyPress
      Width = 48
    end
    object edtEmail: TcxTextEdit
      Left = 233
      Top = 168
      TabOrder = 10
      Width = 272
    end
    object edtCidadeNome: TcxTextEdit
      Left = 58
      Top = 128
      TabStop = False
      TabOrder = 12
      Width = 247
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
    object lblComissao: TcxLabel
      Left = 448
      Top = 32
      Caption = 'Comiss'#227'o'
      Transparent = True
    end
    object lblEndereco: TcxLabel
      Left = 9
      Top = 72
      Caption = 'Endere'#231'o'
      Transparent = True
    end
    object lblBairro: TcxLabel
      Left = 329
      Top = 72
      Caption = 'Bairro'
      Transparent = True
    end
    object lblCidade: TcxLabel
      Left = 9
      Top = 112
      Caption = 'Cidade'
      Transparent = True
    end
    object lblCEP: TcxLabel
      Left = 312
      Top = 112
      Caption = 'CEP'
      Transparent = True
    end
    object lblFone: TcxLabel
      Left = 414
      Top = 112
      Caption = 'Telefone'
      Transparent = True
    end
    object lblFax: TcxLabel
      Left = 9
      Top = 152
      Caption = 'Fax'
      Transparent = True
    end
    object lblCelular: TcxLabel
      Left = 121
      Top = 152
      Caption = 'Celular'
      Transparent = True
    end
    object lblEmail: TcxLabel
      Left = 233
      Top = 152
      Caption = 'Email'
      Transparent = True
    end
  end
end
