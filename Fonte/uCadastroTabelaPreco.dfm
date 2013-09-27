inherited frmCadastroTabelaPreco: TfrmCadastroTabelaPreco
  Caption = 'Cadastro de Tabela de Pre'#231'os'
  ClientHeight = 115
  ClientWidth = 451
  OnShow = FormShow
  ExplicitWidth = 457
  ExplicitHeight = 143
  PixelsPerInch = 96
  TextHeight = 13
  inherited JvNavPaneToolPanel1: TJvNavPaneToolPanel
    Width = 451
    Height = 115
    ExplicitHeight = 127
    inherited pn: TPanel
      Top = 80
      Width = 447
      TabOrder = 2
      ExplicitTop = 80
      inherited btnGrava: TcxButton
        Left = 125
        OnClick = btnGravaClick
      end
      inherited btnCancela: TcxButton
        Left = 206
        OnClick = btnCancelaClick
      end
      inherited brnDeleta: TcxButton
        Left = 287
        OnClick = brnDeletaClick
      end
      inherited BtnSair: TcxButton
        Left = 368
      end
    end
    object edtCodigo: TcxTextEdit
      Tag = 10
      Left = 8
      Top = 48
      TabOrder = 0
      OnEnter = edtCodigoEnter
      OnExit = edtCodigoExit
      OnKeyDown = edtCodigoKeyDown
      OnKeyPress = edtCodigoKeyPress
      Width = 47
    end
    object edtDescricao: TcxTextEdit
      Left = 55
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
      Left = 55
      Top = 32
      Caption = 'Descri'#231#227'o'
      Transparent = True
    end
  end
end
