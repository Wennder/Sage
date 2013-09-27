inherited frmCadastroNaturezaOperacao: TfrmCadastroNaturezaOperacao
  Caption = 'Cadastro de Natureza de Opera'#231#227'o'
  ClientHeight = 119
  ClientWidth = 450
  OnShow = FormShow
  ExplicitWidth = 456
  ExplicitHeight = 147
  PixelsPerInch = 96
  TextHeight = 13
  inherited JvNavPaneToolPanel1: TJvNavPaneToolPanel
    Width = 450
    Height = 119
    ExplicitWidth = 450
    ExplicitHeight = 136
    inherited pn: TPanel
      Top = 84
      Width = 446
      TabOrder = 2
      ExplicitTop = 84
      ExplicitWidth = 446
      inherited btnGrava: TcxButton
        Left = 44
        OnClick = btnGravaClick
        ExplicitLeft = 63
      end
      inherited btnCancela: TcxButton
        Left = 145
        OnClick = btnCancelaClick
        ExplicitLeft = 44
      end
      inherited brnDeleta: TcxButton
        Left = 246
        OnClick = brnDeletaClick
        ExplicitLeft = 246
      end
      inherited BtnSair: TcxButton
        Left = 347
        ExplicitLeft = 347
      end
      inherited btnExportar: TcxButton
        Left = -57
        ExplicitLeft = -2
        ExplicitTop = -9
      end
      inherited btnImprimir: TcxButton
        Left = -158
        ExplicitLeft = -158
      end
    end
    object edtCodigo: TcxTextEdit
      Tag = 11
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
      Left = 54
      Top = 48
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
      Left = 54
      Top = 32
      Caption = 'Descri'#231#227'o'
      Transparent = True
    end
  end
end
