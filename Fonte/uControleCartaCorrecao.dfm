inherited frmControleCartaCorrecao: TfrmControleCartaCorrecao
  Caption = 'Carta de Corre'#231#227'o'
  ClientHeight = 214
  ClientWidth = 442
  ExplicitWidth = 448
  ExplicitHeight = 243
  PixelsPerInch = 96
  TextHeight = 13
  inherited JvNavPaneToolPanel1: TJvNavPaneToolPanel
    Width = 442
    Height = 214
    ExplicitHeight = 192
    inherited pn: TPanel
      Top = 179
      Width = 438
      ExplicitTop = 157
      ExplicitWidth = 613
      inherited btnGrava: TcxButton
        Left = 238
        OnClick = btnGravaClick
        ExplicitLeft = 224
      end
      inherited btnCancela: TcxButton
        Left = 36
        Visible = False
        ExplicitLeft = 312
      end
      inherited brnDeleta: TcxButton
        Left = 137
        Visible = False
        ExplicitLeft = 157
        ExplicitTop = -12
      end
      inherited BtnSair: TcxButton
        Left = 339
        ExplicitLeft = 514
      end
      inherited btnExportar: TcxButton
        Left = -65
        ExplicitLeft = 211
      end
      inherited btnImprimir: TcxButton
        Left = -166
        ExplicitLeft = 110
      end
    end
    object cxLabelMsg: TcxLabel
      Left = 3
      Top = 159
      AutoSize = False
      Caption = 'Clique em confirma para enviar a carta de corre'#231#227'o'
      Properties.Alignment.Horz = taCenter
      Transparent = True
      Height = 17
      Width = 436
      AnchorX = 221
    end
    object Memo: TMemo
      Left = 375
      Top = 62
      Width = 63
      Height = 45
      TabOrder = 2
      Visible = False
    end
    object cxTextEditCorrecao: TcxTextEdit
      Left = 3
      Top = 116
      TabOrder = 3
      Width = 436
    end
    object cxLabel1: TcxLabel
      Left = 3
      Top = 100
      Caption = 'Corre'#231#227'o:'
      Transparent = True
    end
    object cxLabel2: TcxLabel
      Left = 3
      Top = 63
      Caption = 'Chave NF-e'
      Transparent = True
    end
    object cxTextEditChaveNFe: TcxTextEdit
      Left = 3
      Top = 79
      TabOrder = 6
      Width = 436
    end
    object cxLabel3: TcxLabel
      Left = 3
      Top = 24
      Caption = 'CNPJ Empresa:'
      Transparent = True
    end
    object cxTextEditCNPJEmpresa: TcxTextEdit
      Left = 3
      Top = 43
      TabOrder = 8
      Width = 142
    end
  end
  inherited SaveDlg: TSaveDialog
    Left = 480
    Top = 312
  end
  object OpenDialog1: TOpenDialog
    Left = 24
    Top = 112
  end
end
