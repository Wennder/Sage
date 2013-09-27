inherited frmEntradaItens: TfrmEntradaItens
  Left = 358
  Top = 86
  Caption = 'Adiciona Produtos'
  ClientHeight = 150
  ClientWidth = 441
  ExplicitWidth = 447
  ExplicitHeight = 178
  PixelsPerInch = 96
  TextHeight = 13
  inherited JvNavPaneToolPanel1: TJvNavPaneToolPanel
    Width = 441
    Height = 150
    ExplicitLeft = -144
    ExplicitTop = -48
    ExplicitWidth = 447
    ExplicitHeight = 252
    inherited pn: TPanel
      Top = 115
      Width = 437
      ExplicitTop = 126
      ExplicitWidth = 434
      inherited btnGrava: TcxButton
        Left = 35
        ExplicitLeft = 32
      end
      inherited btnCancela: TcxButton
        Left = 136
        ExplicitLeft = 133
      end
      inherited brnDeleta: TcxButton
        Left = 237
        Visible = False
        ExplicitLeft = 234
      end
      inherited BtnSair: TcxButton
        Left = 338
        Visible = False
        ExplicitLeft = 335
      end
      inherited btnExportar: TcxButton
        Left = -66
        ExplicitLeft = 29
        ExplicitTop = 12
      end
      inherited btnImprimir: TcxButton
        Left = -167
        ExplicitLeft = -72
        ExplicitTop = 12
      end
    end
    object edtProduto: TEdit
      Tag = 8
      Left = 6
      Top = 41
      Width = 75
      Height = 21
      TabOrder = 3
    end
    object stProduto: TStaticText
      Left = 83
      Top = 41
      Width = 350
      Height = 21
      AutoSize = False
      BevelKind = bkFlat
      BorderStyle = sbsSingle
      Color = clBtnFace
      ParentColor = False
      TabOrder = 5
      Transparent = False
    end
    object edtPreco: TJvValidateEdit
      Left = 6
      Top = 81
      Width = 75
      Height = 21
      CriticalPoints.MaxValueIncluded = False
      CriticalPoints.MinValueIncluded = False
      DisplayFormat = dfFloat
      DecimalPlaces = 2
      EditText = '0,00'
      HasMaxValue = True
      HasMinValue = True
      MaxValue = 999999.990000000000000000
      TabOrder = 1
    end
    object edtQuantidade: TJvValidateEdit
      Left = 82
      Top = 81
      Width = 77
      Height = 21
      CriticalPoints.MaxValueIncluded = False
      CriticalPoints.MinValueIncluded = False
      DisplayFormat = dfFloat
      DecimalPlaces = 2
      EditText = '0,00'
      HasMaxValue = True
      HasMinValue = True
      MaxValue = 999999.990000000000000000
      TabOrder = 2
    end
    object stUnidade: TStaticText
      Left = 161
      Top = 81
      Width = 147
      Height = 21
      AutoSize = False
      BevelKind = bkFlat
      BorderStyle = sbsSingle
      Color = clBtnFace
      ParentColor = False
      TabOrder = 4
      Transparent = False
    end
    object lblProduto: TcxLabel
      Left = 6
      Top = 25
      Caption = 'Produto:'
      Transparent = True
    end
    object lblPreco: TcxLabel
      Left = 6
      Top = 64
      Caption = 'Pre'#231'o:'
      Transparent = True
    end
    object Label1: TcxLabel
      Left = 82
      Top = 64
      Caption = 'Quantidade:'
      Transparent = True
    end
    object Label2: TcxLabel
      Left = 161
      Top = 64
      Caption = 'Unidade:'
      Transparent = True
    end
  end
end
