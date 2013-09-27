inherited frmCadastroMarca: TfrmCadastroMarca
  Caption = 'Cadastro de Marca'
  ClientHeight = 119
  ClientWidth = 488
  OldCreateOrder = True
  OnShow = FormShow
  ExplicitWidth = 494
  ExplicitHeight = 147
  PixelsPerInch = 96
  TextHeight = 13
  inherited JvNavPaneToolPanel1: TJvNavPaneToolPanel
    Width = 488
    Height = 119
    ExplicitHeight = 131
    inherited pn: TPanel
      Top = 84
      Width = 484
      TabOrder = 2
      ExplicitTop = 84
      inherited btnGrava: TcxButton
        Left = -120
        OnClick = btnGravaClick
      end
      inherited btnCancela: TcxButton
        Left = 183
        OnClick = btnCancelaClick
      end
      inherited brnDeleta: TcxButton
        Left = 284
        OnClick = brnDeletaClick
      end
      inherited BtnSair: TcxButton
        Left = 385
      end
      inherited btnExportar: TcxButton
        Left = 82
      end
      inherited btnImprimir: TcxButton
        Left = -19
      end
    end
    object edtCodigo: TcxTextEdit
      Tag = 3
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
      Width = 428
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
