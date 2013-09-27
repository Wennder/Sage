inherited frmControlaServicoTecnico: TfrmControlaServicoTecnico
  Left = 201
  Top = 146
  Caption = 'Controle de Servi'#231'os por T'#233'cnicos'
  ClientHeight = 502
  ClientWidth = 744
  OldCreateOrder = True
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  inherited JvNavPaneToolPanel1: TJvNavPaneToolPanel
    Width = 744
    Height = 502
    ExplicitWidth = 744
    ExplicitHeight = 502
    inherited pn: TPanel
      Top = 467
      Width = 740
      TabOrder = 5
      ExplicitTop = 467
      ExplicitWidth = 740
      inherited btnGrava: TcxButton
        Left = 573
        Top = 465
        OnClick = btnGravaClick
        ExplicitLeft = 573
        ExplicitTop = 465
      end
      inherited btnCancela: TcxButton
        Left = 657
        Top = 465
        OnClick = btnCancelaClick
        ExplicitLeft = 657
        ExplicitTop = 465
      end
      inherited brnDeleta: TcxButton
        Left = 396
        Top = 417
        Visible = False
        ExplicitLeft = 396
        ExplicitTop = 417
      end
      inherited BtnSair: TcxButton
        Left = 396
        Top = 401
        Visible = False
        ExplicitLeft = 396
        ExplicitTop = 401
      end
    end
    object cxGrid1: TcxGrid
      Left = 0
      Top = 111
      Width = 745
      Height = 342
      TabOrder = 4
      object cxGrid1DBTableView1: TcxGridDBTableView
        NavigatorButtons.ConfirmDelete = False
        DataController.DataSource = DSTemp
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        OptionsData.Deleting = False
        OptionsData.Editing = False
        OptionsData.Inserting = False
        object cxGrid1DBTableView1CodServico: TcxGridDBColumn
          Caption = 'Servi'#231'o'
          DataBinding.FieldName = 'CodigoServico'
          Options.Filtering = False
          Width = 47
        end
        object cxGrid1DBTableView1DescricaoServico: TcxGridDBColumn
          Caption = 'Descri'#231#227'o do Servi'#231'o'
          DataBinding.FieldName = 'DescricaoServico'
          Options.Filtering = False
          Width = 222
        end
        object cxGrid1DBTableView1NomeTecnico: TcxGridDBColumn
          Caption = 'T'#233'cnico'
          DataBinding.FieldName = 'NomeTecnico'
          Options.Filtering = False
          Width = 210
        end
        object cxGrid1DBTableView1PercComissao: TcxGridDBColumn
          Caption = '% Comiss'#227'o'
          DataBinding.FieldName = 'PercComissao'
          Options.Filtering = False
          Width = 82
        end
        object cxGrid1DBTableView1ValorServico: TcxGridDBColumn
          Caption = 'R$ Servi'#231'o'
          DataBinding.FieldName = 'ValorServico'
          Options.Filtering = False
        end
        object cxGrid1DBTableView1ValorComissao: TcxGridDBColumn
          Caption = 'R$ Comiss'#227'o'
          DataBinding.FieldName = 'ValorComissao'
          Options.Filtering = False
          Width = 87
        end
      end
      object cxGrid1Level1: TcxGridLevel
        GridView = cxGrid1DBTableView1
      end
    end
    object edtServico: TStaticText
      Left = 6
      Top = 86
      Width = 331
      Height = 21
      AutoSize = False
      BevelKind = bkFlat
      BorderStyle = sbsSingle
      Color = clBtnFace
      ParentColor = False
      TabOrder = 2
      Transparent = False
    end
    object edtTecnicoNome: TStaticText
      Left = 379
      Top = 86
      Width = 276
      Height = 20
      AutoSize = False
      BevelKind = bkFlat
      BorderStyle = sbsSingle
      Color = clBtnFace
      ParentColor = False
      TabOrder = 1
      Transparent = False
    end
    object stCliente: TStaticText
      Left = 6
      Top = 51
      Width = 579
      Height = 21
      AutoSize = False
      BevelKind = bkFlat
      BorderStyle = sbsSingle
      Color = clBtnFace
      ParentColor = False
      TabOrder = 6
      Transparent = False
    end
    object stPedido: TStaticText
      Left = 590
      Top = 51
      Width = 147
      Height = 21
      AutoSize = False
      BevelKind = bkFlat
      BorderStyle = sbsSingle
      Color = clBtnFace
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
      TabOrder = 7
      Transparent = False
    end
    object btnInsere: TcxButton
      Left = 659
      Top = 85
      Width = 81
      Height = 21
      Caption = 'Confirma'
      Spacing = 3
      TabOrder = 3
      WordWrap = True
      OnClick = btnInsereClick
    end
    object edtTecnico: TcxTextEdit
      Tag = 7
      Left = 338
      Top = 86
      Hint = 
        'Informe o c'#243'digo do t'#233'cnico ou pressione F2 para pesquisar o t'#233'c' +
        'nico por nome.'
      TabOrder = 0
      OnEnter = edtTecnicoEnter
      OnExit = edtTecnicoExit
      OnKeyDown = edtTecnicoKeyDown
      OnKeyPress = edtTecnicoKeyPress
      Width = 40
    end
    object Label1: TcxLabel
      Left = 5
      Top = 72
      Caption = 'Servi'#231'o:'
      Transparent = True
    end
    object Label2: TcxLabel
      Left = 338
      Top = 72
      Caption = 'T'#233'cnico:'
      Transparent = True
    end
    object Label3: TcxLabel
      Left = 5
      Top = 37
      Caption = 'Cliente:'
      Transparent = True
    end
    object Label4: TcxLabel
      Left = 592
      Top = 37
      Caption = 'Pedido:'
      Transparent = True
    end
  end
  object MData: TJvMemoryData
    FieldDefs = <>
    AfterScroll = MDataAfterScroll
    Left = 80
    Top = 416
    object MDataCodigoServico: TIntegerField
      FieldName = 'CodigoServico'
    end
    object MDataDescricaoServico: TStringField
      FieldName = 'DescricaoServico'
      Size = 50
    end
    object MDataCodigoTecnico: TIntegerField
      FieldName = 'CodigoTecnico'
    end
    object MDataNomeTecnico: TStringField
      FieldName = 'NomeTecnico'
      Size = 50
    end
    object MDataPercComissao: TFloatField
      FieldName = 'PercComissao'
      DisplayFormat = '#,##0.00%'
    end
    object MDataValorServico: TFloatField
      FieldName = 'ValorServico'
      DisplayFormat = '#,##0.00'
    end
    object MDataValorComissao: TFloatField
      FieldName = 'ValorComissao'
      DisplayFormat = '#,##0.00'
    end
    object MDataIndice: TIntegerField
      FieldName = 'Indice'
    end
  end
  object DSTemp: TDataSource
    DataSet = MData
    Left = 40
    Top = 416
  end
end
