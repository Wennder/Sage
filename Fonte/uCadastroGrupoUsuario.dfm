inherited frmCadastroGrupoUsuario: TfrmCadastroGrupoUsuario
  Caption = 'Cadastro de Grupo de Usu'#225'rios'
  ClientHeight = 120
  ClientWidth = 447
  OnShow = FormShow
  ExplicitWidth = 453
  ExplicitHeight = 148
  PixelsPerInch = 96
  TextHeight = 13
  inherited JvNavPaneToolPanel1: TJvNavPaneToolPanel
    Width = 447
    Height = 120
    ExplicitWidth = 447
    ExplicitHeight = 142
    inherited pn: TPanel
      Top = 85
      Width = 443
      TabOrder = 2
      ExplicitTop = 85
      ExplicitWidth = 443
      inherited btnGrava: TcxButton
        Left = 15
        OnClick = btnGravaClick
        ExplicitLeft = 15
      end
      inherited btnCancela: TcxButton
        Left = 187
        OnClick = btnCancelaClick
        ExplicitLeft = 187
      end
      inherited brnDeleta: TcxButton
        Left = 273
        OnClick = brnDeletaClick
        ExplicitLeft = 273
      end
      inherited BtnSair: TcxButton
        Left = 359
        ExplicitLeft = 359
      end
      inherited btnExportar: TcxButton
        Left = 101
        ExplicitLeft = 101
      end
      inherited btnImprimir: TcxButton
        Left = -71
        ExplicitLeft = -71
      end
    end
    object edtCodigo: TcxTextEdit
      Tag = 16
      Left = 8
      Top = 47
      TabOrder = 0
      OnEnter = edtCodigoEnter
      OnExit = edtCodigoExit
      OnKeyDown = edtCodigoKeyDown
      OnKeyPress = edtCodigoKeyPress
      Width = 46
    end
    object edtNome: TcxTextEdit
      Left = 53
      Top = 47
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
    object lblNome: TcxLabel
      Left = 53
      Top = 32
      Caption = 'Descri'#231#227'o'
      Transparent = True
    end
  end
end
