inherited frmCadastroCor: TfrmCadastroCor
  Top = 459
  Caption = 'Cadastro de Cores'
  ClientHeight = 121
  ClientWidth = 446
  OnShow = FormShow
  ExplicitWidth = 452
  ExplicitHeight = 149
  PixelsPerInch = 96
  TextHeight = 13
  inherited JvNavPaneToolPanel1: TJvNavPaneToolPanel
    Width = 446
    Height = 121
    ExplicitWidth = 480
    ExplicitHeight = 129
    inherited pn: TPanel
      Top = 86
      Width = 442
      TabOrder = 2
      ExplicitTop = 82
      ExplicitWidth = 445
      inherited btnGrava: TcxButton
        Left = 40
        OnClick = btnGravaClick
        ExplicitLeft = 280
      end
      inherited btnCancela: TcxButton
        Left = 141
        OnClick = btnCancelaClick
        ExplicitLeft = 144
      end
      inherited brnDeleta: TcxButton
        Left = 242
        OnClick = brnDeletaClick
        ExplicitLeft = 245
      end
      inherited BtnSair: TcxButton
        Left = 343
        ExplicitLeft = 346
      end
      inherited btnExportar: TcxButton
        Left = -61
        ExplicitLeft = 144
      end
      inherited btnImprimir: TcxButton
        Left = -162
        ExplicitLeft = -58
      end
    end
    object edtCodigo: TcxTextEdit
      Tag = 20
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
  inherited SaveDlg: TSaveDialog
    Left = 464
  end
end
