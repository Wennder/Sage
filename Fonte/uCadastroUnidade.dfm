inherited frmCadastroUnidade: TfrmCadastroUnidade
  Top = 449
  Caption = 'Cadastro de Unidades'
  ClientHeight = 115
  ClientWidth = 452
  OldCreateOrder = True
  OnShow = FormShow
  ExplicitWidth = 458
  ExplicitHeight = 143
  PixelsPerInch = 96
  TextHeight = 13
  inherited JvNavPaneToolPanel1: TJvNavPaneToolPanel
    Width = 452
    Height = 115
    ExplicitWidth = 450
    ExplicitHeight = 125
    inherited pn: TPanel
      Top = 80
      Width = 448
      TabOrder = 2
      ExplicitTop = 80
      ExplicitWidth = 446
      inherited btnGrava: TcxButton
        Left = 46
        OnClick = btnGravaClick
        ExplicitLeft = 71
      end
      inherited btnCancela: TcxButton
        Left = 147
        OnClick = btnCancelaClick
        ExplicitLeft = 145
      end
      inherited brnDeleta: TcxButton
        Left = 248
        OnClick = brnDeletaClick
        ExplicitLeft = 246
      end
      inherited BtnSair: TcxButton
        Left = 349
        ExplicitLeft = 347
      end
      inherited btnExportar: TcxButton
        Left = -55
        ExplicitLeft = 44
      end
      inherited btnImprimir: TcxButton
        Left = -156
        ExplicitLeft = -158
      end
    end
    object edtCodigo: TcxTextEdit
      Tag = 4
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
      Left = 55
      Top = 32
      Caption = 'Descri'#231#227'o:'
      Transparent = True
    end
  end
  inherited SaveDlg: TSaveDialog
    Left = 392
  end
end
