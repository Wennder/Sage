inherited frmConsultaNFe: TfrmConsultaNFe
  Caption = 'Consulta NFe'
  ClientHeight = 161
  ClientWidth = 414
  OnShow = FormShow
  ExplicitWidth = 420
  ExplicitHeight = 189
  PixelsPerInch = 96
  TextHeight = 13
  inherited JvNavPaneToolPanel1: TJvNavPaneToolPanel
    Width = 414
    Height = 161
    ExplicitWidth = 414
    ExplicitHeight = 178
    inherited pn: TPanel
      Top = 126
      Width = 410
      TabOrder = 6
      ExplicitTop = 126
      ExplicitWidth = 410
      inherited btnGrava: TcxButton
        Left = 240
        Caption = '&Confirma'
        OnClick = btnGravaClick
        ExplicitLeft = 240
      end
      inherited btnCancela: TcxButton
        Left = -104
        Visible = False
        ExplicitLeft = -104
      end
      inherited brnDeleta: TcxButton
        Left = 154
        Visible = False
        ExplicitLeft = 154
      end
      inherited BtnSair: TcxButton
        Left = 326
        ExplicitLeft = 326
      end
      inherited btnExportar: TcxButton
        Left = 68
        ExplicitLeft = 68
      end
      inherited btnImprimir: TcxButton
        Left = -18
      end
    end
    object edtDataPedido: TStaticText
      Left = 271
      Top = 52
      Width = 130
      Height = 21
      AutoSize = False
      BevelKind = bkFlat
      BorderStyle = sbsSingle
      Color = clBtnFace
      ParentColor = False
      TabOrder = 2
      Transparent = False
    end
    object Memo: TMemo
      Left = 138
      Top = 194
      Width = 57
      Height = 34
      TabOrder = 9
      Visible = False
    end
    object edtNotaFiscal: TcxTextEdit
      Tag = 13
      Left = 8
      Top = 52
      TabOrder = 0
      OnExit = edtNotaFiscalExit
      OnKeyDown = edtNotaFiscalKeyDown
      OnKeyPress = edtNotaFiscalKeyPress
      Width = 130
    end
    object Label1: TcxLabel
      Left = 8
      Top = 36
      Caption = 'Nota Fiscal:'
      Transparent = True
    end
    object Label3: TcxLabel
      Left = 271
      Top = 37
      Caption = 'Data do Pedido:'
      Transparent = True
    end
    object lblPedido: TStaticText
      Left = 139
      Top = 52
      Width = 130
      Height = 21
      AutoSize = False
      BevelKind = bkFlat
      BorderStyle = sbsSingle
      Color = clBtnFace
      ParentColor = False
      TabOrder = 1
      Transparent = False
    end
    object cxLabel1: TcxLabel
      Left = 139
      Top = 37
      Caption = 'Pedido:'
      Transparent = True
    end
    object Label2: TcxLabel
      Left = 8
      Top = 79
      Caption = 'Cliente:'
      Transparent = True
    end
    object edtCliente: TStaticText
      Left = 8
      Top = 94
      Width = 393
      Height = 21
      AutoSize = False
      BevelKind = bkFlat
      BorderStyle = sbsSingle
      Color = clBtnFace
      ParentColor = False
      TabOrder = 3
      Transparent = False
    end
  end
  object Query: TZQuery
    Params = <>
    Left = 279
    Top = 231
  end
end
