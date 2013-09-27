inherited frmEntradaNFCancela: TfrmEntradaNFCancela
  Caption = 'Cancelamento de NF de Entrada'
  ClientHeight = 156
  ClientWidth = 369
  OnShow = FormShow
  ExplicitWidth = 375
  ExplicitHeight = 184
  PixelsPerInch = 96
  TextHeight = 13
  inherited JvNavPaneToolPanel1: TJvNavPaneToolPanel
    Width = 369
    Height = 156
    ExplicitWidth = 369
    ExplicitHeight = 156
    object Bevel1: TBevel [0]
      Left = 3
      Top = 26
      Width = 364
      Height = 90
    end
    inherited pn: TPanel
      Top = 121
      Width = 365
      TabOrder = 10
      ExplicitTop = 121
      ExplicitWidth = 365
      inherited btnGrava: TcxButton
        Left = 195
        OnClick = btnGravaClick
        ExplicitLeft = 195
      end
      inherited btnCancela: TcxButton
        Left = 23
        Enabled = False
        Visible = False
        ExplicitLeft = 23
      end
      inherited brnDeleta: TcxButton
        Left = 109
        Enabled = False
        Visible = False
        ExplicitLeft = 109
      end
      inherited BtnSair: TcxButton
        Left = 281
        ExplicitLeft = 281
      end
      inherited btnExportar: TcxButton
        Left = -63
        ExplicitLeft = -63
      end
      inherited btnImprimir: TcxButton
        Left = -149
        ExplicitLeft = -149
      end
    end
    object edtFornecedor: TcxTextEdit
      Tag = 19
      Left = 6
      Top = 43
      Properties.UseLeftAlignmentOnEditing = False
      TabOrder = 0
      OnExit = edtFornecedorExit
      OnKeyDown = edtFornecedorKeyDown
      OnKeyPress = edtFornecedorKeyPress
      Width = 75
    end
    object EditSerie: TcxTextEdit
      Left = 81
      Top = 82
      Enabled = False
      Properties.UseLeftAlignmentOnEditing = False
      StyleDisabled.TextColor = clBlack
      TabOrder = 3
      Width = 75
    end
    object lblProduto: TcxLabel
      Left = 6
      Top = 28
      Caption = 'Fornecedor:'
      Transparent = True
    end
    object Label1: TcxLabel
      Left = 81
      Top = 67
      Caption = 'S'#233'rie:'
      Transparent = True
    end
    object Label3: TcxLabel
      Left = 156
      Top = 67
      Caption = 'Data Entrada:'
      Transparent = True
    end
    object Label4: TcxLabel
      Left = 256
      Top = 67
      Caption = 'Data Emiss'#227'o:'
      Transparent = True
    end
    object stFornecedor: TcxTextEdit
      Left = 80
      Top = 43
      TabStop = False
      AutoSize = False
      Enabled = False
      StyleDisabled.TextColor = clBlack
      TabOrder = 1
      Height = 21
      Width = 276
    end
    object edtDataEmissao: TcxDateEdit
      Left = 256
      Top = 82
      Enabled = False
      Properties.SaveTime = False
      Properties.ShowTime = False
      Properties.UseLeftAlignmentOnEditing = False
      StyleDisabled.TextColor = clBlack
      TabOrder = 5
      Width = 100
    end
    object edtDataEntrada: TcxDateEdit
      Left = 156
      Top = 82
      Enabled = False
      Properties.SaveTime = False
      Properties.ShowTime = False
      Properties.UseLeftAlignmentOnEditing = False
      StyleDisabled.TextColor = clBlack
      TabOrder = 4
      Width = 100
    end
    object EditNumeroNF: TcxTextEdit
      Tag = 21
      Left = 6
      Top = 82
      Properties.UseLeftAlignmentOnEditing = False
      StyleDisabled.TextColor = clBlack
      TabOrder = 2
      OnKeyDown = EditNumeroNFKeyDown
      Width = 75
    end
    object Label2: TcxLabel
      Left = 6
      Top = 67
      Caption = 'N'#250'mero:'
      Transparent = True
    end
  end
  inherited SaveDlg: TSaveDialog
    Left = 168
    Top = 320
  end
end
