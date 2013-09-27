inherited frmCadastroSubGrupo: TfrmCadastroSubGrupo
  Caption = 'Cadastro de SubGrupos'
  ClientHeight = 157
  ClientWidth = 446
  OldCreateOrder = True
  ExplicitWidth = 452
  ExplicitHeight = 185
  PixelsPerInch = 96
  TextHeight = 13
  inherited JvNavPaneToolPanel1: TJvNavPaneToolPanel
    Width = 446
    Height = 157
    ExplicitWidth = 446
    ExplicitHeight = 174
    inherited pn: TPanel
      Top = 122
      Width = 442
      TabOrder = 4
      ExplicitTop = 122
      ExplicitWidth = 442
      inherited btnGrava: TcxButton
        Left = 14
        OnClick = btnGravaClick
        ExplicitLeft = 14
      end
      inherited btnCancela: TcxButton
        Left = 186
        OnClick = btnCancelaClick
        ExplicitLeft = 186
      end
      inherited brnDeleta: TcxButton
        Left = 272
        OnClick = brnDeletaClick
        ExplicitLeft = 272
      end
      inherited BtnSair: TcxButton
        Left = 358
        ExplicitLeft = 358
      end
      inherited btnExportar: TcxButton
        Left = 100
        ExplicitLeft = 100
      end
      inherited btnImprimir: TcxButton
        Left = -72
        ExplicitLeft = -72
      end
    end
    object edtCodigo: TcxTextEdit
      Tag = 5
      Left = 5
      Top = 88
      TabOrder = 2
      OnEnter = edtCodigoEnter
      OnExit = edtCodigoExit
      OnKeyDown = edtCodigoKeyDown
      OnKeyPress = edtCodigoKeyPress
      Width = 47
    end
    object edtDescricao: TcxTextEdit
      Left = 52
      Top = 88
      Properties.CharCase = ecUpperCase
      TabOrder = 3
      Width = 387
    end
    object edtGrupo: TcxTextEdit
      Tag = 2
      Left = 5
      Top = 49
      TabOrder = 0
      OnEnter = edtGrupoEnter
      OnExit = edtGrupoExit
      OnKeyDown = edtGrupoKeyDown
      OnKeyPress = edtGrupoKeyPress
      Width = 47
    end
    object edtDescGrupo: TcxTextEdit
      Left = 52
      Top = 49
      TabStop = False
      Enabled = False
      StyleDisabled.TextColor = clBlack
      TabOrder = 1
      Width = 387
    end
    object lblCodigo: TcxLabel
      Left = 5
      Top = 73
      Caption = 'Subgrupo'
      Transparent = True
    end
    object lblGrupo: TcxLabel
      Left = 5
      Top = 34
      Caption = 'Grupo'
      Transparent = True
    end
  end
end
