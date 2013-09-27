inherited frmCadastroNCM: TfrmCadastroNCM
  Caption = 'Cadastro de NCM (Nomenclatura Comum do Mercosul)'
  ClientHeight = 126
  ClientWidth = 496
  OldCreateOrder = True
  OnShow = FormShow
  ExplicitWidth = 502
  ExplicitHeight = 154
  PixelsPerInch = 96
  TextHeight = 13
  inherited JvNavPaneToolPanel1: TJvNavPaneToolPanel
    Width = 496
    Height = 126
    ExplicitWidth = 496
    ExplicitHeight = 188
    inherited pn: TPanel
      Top = 91
      Width = 492
      TabOrder = 2
      ExplicitTop = 91
      ExplicitWidth = 492
      inherited btnGrava: TcxButton
        Left = 150
        OnClick = btnGravaClick
        ExplicitLeft = 150
      end
      inherited btnCancela: TcxButton
        Left = 236
        ExplicitLeft = 236
      end
      inherited brnDeleta: TcxButton
        Left = 322
        OnClick = brnDeletaClick
        ExplicitLeft = 322
      end
      inherited BtnSair: TcxButton
        Left = 408
        ExplicitLeft = 408
      end
      inherited btnExportar: TcxButton
        Left = 64
        ExplicitLeft = 64
      end
      inherited btnImprimir: TcxButton
        Left = -22
        ExplicitLeft = -22
      end
    end
    object edtCodigo: TcxTextEdit
      Tag = 17
      Left = 3
      Top = 54
      TabOrder = 0
      OnEnter = edtCodigoEnter
      OnExit = edtCodigoExit
      OnKeyDown = edtCodigoKeyDown
      OnKeyPress = edtCodigoKeyPress
      Width = 100
    end
    object edtDescricao: TcxTextEdit
      Left = 103
      Top = 54
      Properties.CharCase = ecUpperCase
      TabOrder = 1
      Width = 387
    end
    object lblCodigo: TcxLabel
      Left = 3
      Top = 38
      Caption = 'C'#243'digo'
      Transparent = True
    end
    object lblNome: TcxLabel
      Left = 103
      Top = 37
      Caption = 'Descri'#231#227'o'
      Transparent = True
    end
  end
end
