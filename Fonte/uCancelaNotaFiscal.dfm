inherited frmCancelaNotaFiscal: TfrmCancelaNotaFiscal
  Caption = 'Cancela Nota Fiscal (NF-e)'
  ClientHeight = 185
  ClientWidth = 413
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 13
  inherited JvNavPaneToolPanel1: TJvNavPaneToolPanel
    Width = 413
    Height = 185
    ExplicitWidth = 413
    ExplicitHeight = 185
    inherited pn: TPanel
      Top = 150
      Width = 409
      TabOrder = 3
      ExplicitTop = 150
      ExplicitWidth = 409
      inherited btnGrava: TcxButton
        Left = 239
        Caption = '&Confirma'
        OnClick = btnGravaClick
        ExplicitLeft = 239
      end
      inherited btnCancela: TcxButton
        Left = 153
        Visible = False
        ExplicitLeft = 153
      end
      inherited brnDeleta: TcxButton
        Left = -105
        Visible = False
        ExplicitLeft = -19
      end
      inherited BtnSair: TcxButton
        Left = 325
        ExplicitLeft = 325
      end
      inherited btnExportar: TcxButton
        Left = 67
      end
      inherited btnImprimir: TcxButton
        Left = -19
      end
    end
    object edtDataPedido: TStaticText
      Left = 280
      Top = 54
      Width = 129
      Height = 21
      AutoSize = False
      BevelKind = bkFlat
      BorderStyle = sbsSingle
      Color = clBtnFace
      ParentColor = False
      TabOrder = 1
      Transparent = False
    end
    object edtCliente: TStaticText
      Left = 10
      Top = 94
      Width = 399
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
      Left = 352
      Top = 113
      Width = 57
      Height = 34
      TabOrder = 4
      Visible = False
    end
    object edtPedido: TcxTextEdit
      Tag = 13
      Left = 8
      Top = 56
      TabOrder = 0
      OnExit = edtPedidoExit
      OnKeyDown = edtPedidoKeyDown
      OnKeyPress = edtPedidoKeyPress
      Width = 81
    end
    object Label1: TcxLabel
      Left = 8
      Top = 40
      Caption = 'Pedido:'
      Transparent = True
    end
    object Label3: TcxLabel
      Left = 282
      Top = 40
      Caption = 'Data do Pedido:'
      Transparent = True
    end
  end
  object Query: TZQuery
    Params = <>
    Left = 279
    Top = 231
  end
end
