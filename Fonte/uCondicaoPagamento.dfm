inherited frmFormaRecebimento: TfrmFormaRecebimento
  Left = 366
  Top = 161
  Caption = 'Condi'#231#227'o de Pagamento'
  ClientHeight = 175
  ClientWidth = 251
  ExplicitWidth = 257
  ExplicitHeight = 203
  PixelsPerInch = 96
  TextHeight = 13
  inherited JvNavPaneToolPanel1: TJvNavPaneToolPanel
    Width = 251
    Height = 175
    ExplicitWidth = 251
    ExplicitHeight = 194
    object Label2: TLabel [0]
      Left = 8
      Top = 40
      Width = 131
      Height = 13
      Caption = 'Forma de Recebimento'
      Transparent = True
    end
    object Label3: TLabel [1]
      Left = 8
      Top = 82
      Width = 188
      Height = 13
      Caption = 'Bandeira Cart'#227'o (Cr'#233'dito/D'#233'bito)'
      Transparent = True
    end
    inherited pn: TPanel
      Top = 140
      Width = 247
      TabOrder = 2
      ExplicitTop = 140
      ExplicitWidth = 247
      inherited btnGrava: TcxButton
        Left = 77
        ModalResult = 1
        OnClick = btnGravaClick
        ExplicitLeft = 77
      end
      inherited btnCancela: TcxButton
        Left = 163
        ModalResult = 2
        ExplicitLeft = 163
      end
      inherited brnDeleta: TcxButton
        Left = -267
        Enabled = False
        Visible = False
        ExplicitLeft = -267
      end
      inherited BtnSair: TcxButton
        Left = -95
        Enabled = False
        Visible = False
        ExplicitLeft = -95
      end
      inherited btnExportar: TcxButton
        Left = -9
        ExplicitLeft = -9
      end
      inherited btnImprimir: TcxButton
        Left = -181
        ExplicitLeft = -181
      end
    end
    object ComboBoxFormaRecebimento: TcxComboBox
      Left = 12
      Top = 55
      Properties.DropDownListStyle = lsFixedList
      Properties.Items.Strings = (
        'Dinheiro'
        'Cart'#227'o D'#233'bito'
        'Cart'#227'o Cr'#233'dito'
        'Cheque')
      Properties.OnChange = ComboBoxFormaRecebimentoChange
      TabOrder = 0
      Text = 'Dinheiro'
      Width = 236
    end
    object ComboBoxBandeira: TcxComboBox
      Left = 9
      Top = 99
      Enabled = False
      Properties.DropDownListStyle = lsFixedList
      Properties.Items.Strings = (
        'Visa'
        'Master'
        'Amex'
        'Dinners'
        'RedeShop')
      TabOrder = 1
      Width = 236
    end
  end
end
