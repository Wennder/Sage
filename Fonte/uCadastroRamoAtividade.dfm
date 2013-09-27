inherited frmCadastroRamoAtividade: TfrmCadastroRamoAtividade
  Top = 213
  Caption = 'Cadastro de Ramo de Atividade'
  ClientHeight = 113
  ClientWidth = 428
  OldCreateOrder = True
  OnShow = FormShow
  ExplicitWidth = 434
  ExplicitHeight = 141
  PixelsPerInch = 96
  TextHeight = 13
  inherited JvNavPaneToolPanel1: TJvNavPaneToolPanel
    Width = 428
    Height = 113
    ExplicitWidth = 425
    ExplicitHeight = 128
    inherited pn: TPanel
      Top = 78
      Width = 424
      ExplicitTop = 78
      ExplicitWidth = 424
      inherited btnGrava: TcxButton
        Left = -4
        OnClick = btnGravaClick
        ExplicitLeft = -4
      end
      inherited btnCancela: TcxButton
        Left = 168
        OnClick = btnCancelaClick
        ExplicitLeft = 168
      end
      inherited brnDeleta: TcxButton
        Left = 254
        OnClick = brnDeletaClick
        ExplicitLeft = 254
      end
      inherited BtnSair: TcxButton
        Left = 340
        ExplicitLeft = 340
      end
      inherited btnExportar: TcxButton
        Left = 82
        ExplicitLeft = 82
      end
      inherited btnImprimir: TcxButton
        Left = -90
        ExplicitLeft = -90
      end
    end
    object edtCodigo: TcxTextEdit
      Tag = 6
      Left = 8
      Top = 48
      TabOrder = 1
      OnEnter = edtCodigoEnter
      OnExit = edtCodigoExit
      OnKeyDown = edtCodigoKeyDown
      OnKeyPress = edtCodigoKeyPress
      Width = 46
    end
    object edtDescricao: TcxTextEdit
      Left = 54
      Top = 48
      Properties.CharCase = ecUpperCase
      TabOrder = 2
      Width = 367
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
