inherited frmInutilizaNumeroNF: TfrmInutilizaNumeroNF
  Caption = 'Inutiliza N'#250'mero de NF'
  ClientHeight = 122
  ClientWidth = 287
  OldCreateOrder = True
  ExplicitWidth = 293
  ExplicitHeight = 150
  PixelsPerInch = 96
  TextHeight = 13
  inherited JvNavPaneToolPanel1: TJvNavPaneToolPanel
    Width = 287
    Height = 122
    ExplicitWidth = 287
    ExplicitHeight = 142
    inherited pn: TPanel
      Top = 87
      Width = 283
      TabOrder = 2
      ExplicitTop = 87
      ExplicitWidth = 283
      inherited btnGrava: TcxButton
        Left = 83
        Caption = '&Confirma'
        OnClick = btnGravaClick
        ExplicitLeft = -18
      end
      inherited btnCancela: TcxButton
        Left = -220
        Visible = False
        ExplicitLeft = -220
      end
      inherited brnDeleta: TcxButton
        Left = -321
        Visible = False
        ExplicitLeft = -321
      end
      inherited BtnSair: TcxButton
        Left = 184
        ExplicitLeft = 83
      end
      inherited btnExportar: TcxButton
        Left = -18
        ExplicitLeft = -40
        ExplicitTop = 12
      end
      inherited btnImprimir: TcxButton
        Left = -119
        ExplicitLeft = -119
      end
    end
    object Memo: TMemo
      Left = 198
      Top = 132
      Width = 57
      Height = 34
      TabOrder = 3
      Visible = False
    end
    object edtNumeroInicial: TcxTextEdit
      Left = 8
      Top = 53
      TabOrder = 0
      OnKeyPress = edtNumeroInicialKeyPress
      Width = 81
    end
    object edtNumeroFinal: TcxTextEdit
      Left = 177
      Top = 53
      TabOrder = 1
      OnKeyPress = edtNumeroFinalKeyPress
      Width = 81
    end
    object Label1: TcxLabel
      Left = 8
      Top = 37
      Caption = 'N'#250'mero Inicial:'
      Transparent = True
    end
    object Label2: TcxLabel
      Left = 177
      Top = 37
      Caption = 'N'#250'mero Final:'
      Transparent = True
    end
  end
  object Query: TZQuery
    Params = <>
    Left = 279
    Top = 231
  end
end
