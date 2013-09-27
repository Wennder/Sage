inherited frmCadastroTabelaPrecoItens: TfrmCadastroTabelaPrecoItens
  Caption = 'Composi'#231#227'o de Pre'#231'os'
  ClientHeight = 184
  ClientWidth = 487
  OldCreateOrder = True
  OnShow = FormShow
  ExplicitWidth = 493
  ExplicitHeight = 212
  PixelsPerInch = 96
  TextHeight = 13
  inherited JvNavPaneToolPanel1: TJvNavPaneToolPanel
    Width = 487
    Height = 184
    ExplicitHeight = 198
    inherited pn: TPanel
      Top = 149
      Width = 483
      TabOrder = 5
      ExplicitTop = 149
      inherited btnGrava: TcxButton
        Left = 81
        OnClick = btnGravaClick
      end
      inherited btnCancela: TcxButton
        Left = 182
        OnClick = btnCancelaClick
      end
      inherited brnDeleta: TcxButton
        Left = 283
        OnClick = brnDeletaClick
      end
      inherited BtnSair: TcxButton
        Left = 384
      end
      inherited btnExportar: TcxButton
        Left = -121
        ExplicitLeft = 34
        ExplicitTop = -2
      end
      inherited btnImprimir: TcxButton
        Left = -20
        ExplicitLeft = 79
        ExplicitTop = -2
      end
    end
    object stTabela: TStaticText
      Left = 67
      Top = 45
      Width = 412
      Height = 20
      AutoSize = False
      BevelKind = bkFlat
      BorderStyle = sbsSingle
      Color = clBtnFace
      ParentColor = False
      TabOrder = 1
      Transparent = False
    end
    object stProduto: TStaticText
      Left = 67
      Top = 81
      Width = 412
      Height = 20
      AutoSize = False
      BevelKind = bkFlat
      BorderStyle = sbsSingle
      Color = clBtnFace
      ParentColor = False
      TabOrder = 3
      Transparent = False
    end
    object edtPreco: TJvValidateEdit
      Left = 8
      Top = 120
      Width = 97
      Height = 21
      Hint = 
        'Informe o valor m'#225'ximo de cr'#233'dito que o cliente selecionado pode' +
        ' possuir.'
      CriticalPoints.MaxValueIncluded = False
      CriticalPoints.MinValueIncluded = False
      DisplayFormat = dfFloat
      DecimalPlaces = 2
      EditText = '0,00'
      HasMaxValue = True
      HasMinValue = True
      MaxValue = 999999.990000000000000000
      TabOrder = 4
    end
    object edtTabela: TcxTextEdit
      Tag = 10
      Left = 8
      Top = 45
      Hint = 
        'Informe o c'#243'digo do cliente ou pressione F2 para pesquisar o cli' +
        'ente por nome.'
      TabOrder = 0
      OnEnter = edtTabelaEnter
      OnExit = edtTabelaExit
      OnKeyDown = edtTabelaKeyDown
      OnKeyPress = edtTabelaKeyPress
      Width = 57
    end
    object edtProduto: TcxTextEdit
      Tag = 8
      Left = 8
      Top = 81
      Hint = 
        'Informe o c'#243'digo do cliente ou pressione F2 para pesquisar o cli' +
        'ente por nome.'
      TabOrder = 2
      OnExit = edtProdutoExit
      OnKeyDown = edtProdutoKeyDown
      OnKeyPress = edtTabelaKeyPress
      Width = 57
    end
    object lblTabela: TcxLabel
      Left = 8
      Top = 32
      Caption = 'Tabela:'
      Transparent = True
    end
    object lblProduto: TcxLabel
      Left = 8
      Top = 68
      Caption = 'Produto:'
      Transparent = True
    end
    object lblPreco: TcxLabel
      Left = 9
      Top = 106
      Caption = 'Pre'#231'o:'
      Transparent = True
    end
  end
end
