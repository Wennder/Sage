inherited frmCadastroGrupo: TfrmCadastroGrupo
  Top = 459
  Caption = 'Cadastro de Grupos'
  ClientHeight = 115
  ClientWidth = 448
  OnShow = FormShow
  ExplicitWidth = 454
  ExplicitHeight = 143
  PixelsPerInch = 96
  TextHeight = 13
  inherited JvNavPaneToolPanel1: TJvNavPaneToolPanel
    Width = 448
    Height = 115
    ExplicitWidth = 448
    ExplicitHeight = 130
    inherited pn: TPanel
      Top = 80
      Width = 444
      TabOrder = 2
      ExplicitTop = 80
      ExplicitWidth = 444
      inherited btnGrava: TcxButton
        Left = 16
        OnClick = btnGravaClick
        ExplicitLeft = 16
      end
      inherited btnCancela: TcxButton
        Left = 188
        OnClick = btnCancelaClick
        ExplicitLeft = 188
      end
      inherited brnDeleta: TcxButton
        Left = 274
        OnClick = brnDeletaClick
        ExplicitLeft = 274
      end
      inherited BtnSair: TcxButton
        Left = 360
        ExplicitLeft = 360
      end
      inherited btnExportar: TcxButton
        Left = 102
        ExplicitLeft = 102
      end
      inherited btnImprimir: TcxButton
        Left = -70
        ExplicitLeft = -70
      end
    end
    object edtCodigo: TcxTextEdit
      Tag = 2
      Left = 8
      Top = 48
      TabOrder = 0
      OnEnter = edtCodigoEnter
      OnExit = edtCodigoExit
      OnKeyDown = edtCodigoKeyDown
      OnKeyPress = edtCodigoKeyPress
      Width = 46
    end
    object edtDescricao: TcxTextEdit
      Left = 53
      Top = 48
      Properties.CharCase = ecUpperCase
      TabOrder = 1
      Width = 387
    end
    object lblCodigo: TcxLabel
      Left = 8
      Top = 32
      Caption = 'C'#243'digo'
      Transparent = True
    end
    object lblDescricao: TcxLabel
      Left = 53
      Top = 32
      Caption = 'Descri'#231#227'o'
      Transparent = True
    end
  end
end
