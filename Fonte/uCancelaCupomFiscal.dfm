inherited frmCancelaCupomFiscal: TfrmCancelaCupomFiscal
  Caption = 'Cancela Cupom Fiscal'
  ClientHeight = 159
  ClientWidth = 417
  OldCreateOrder = True
  OnShow = FormShow
  ExplicitWidth = 423
  ExplicitHeight = 187
  PixelsPerInch = 96
  TextHeight = 13
  inherited JvNavPaneToolPanel1: TJvNavPaneToolPanel
    Width = 417
    Height = 159
    ExplicitWidth = 417
    ExplicitHeight = 171
    inherited pn: TPanel
      Top = 124
      Width = 413
      TabOrder = 3
      ExplicitTop = 136
      ExplicitWidth = 413
      inherited btnGrava: TcxButton
        Left = 253
        Caption = '&Confirma'
        OnClick = btnGravaClick
        ExplicitLeft = 253
      end
      inherited btnCancela: TcxButton
        Left = 91
        Visible = False
        ExplicitLeft = 91
      end
      inherited brnDeleta: TcxButton
        Left = 172
        Visible = False
        ExplicitLeft = 172
      end
      inherited BtnSair: TcxButton
        Left = 334
        ExplicitLeft = 334
      end
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
      TabOrder = 1
      Transparent = False
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
      TabOrder = 2
      Transparent = False
    end
    object edtPedido: TcxTextEdit
      Tag = 18
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
    object Label2: TcxLabel
      Left = 10
      Top = 79
      Caption = 'Cliente:'
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
    Left = 368
    Top = 232
  end
end
