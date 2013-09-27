inherited frmRelContagemInventario: TfrmRelContagemInventario
  Caption = 'An'#225'lise de Contagem de Invent'#225'rio'
  ClientHeight = 147
  ClientWidth = 308
  OnShow = FormShow
  ExplicitWidth = 314
  ExplicitHeight = 175
  PixelsPerInch = 96
  TextHeight = 13
  inherited JvNavPaneToolPanel1: TJvNavPaneToolPanel
    Width = 308
    Height = 147
    ExplicitWidth = 308
    ExplicitHeight = 147
    inherited Panel1: TPanel
      Top = 112
      Width = 304
      TabOrder = 2
      ExplicitTop = 112
      ExplicitWidth = 304
      inherited btnSair: TcxButton
        Left = 205
        ExplicitLeft = 205
      end
      inherited btnImprimir: TcxButton
        Left = 104
        OnClick = btnImprimirClick
        ExplicitLeft = 104
      end
    end
    object edtInventario: TcxTextEdit
      Tag = 23
      Left = 6
      Top = 43
      TabOrder = 0
      OnExit = edtInventarioExit
      OnKeyDown = edtInventarioKeyDown
      OnKeyPress = edtInventarioKeyPress
      Width = 141
    end
    object lbCod: TcxLabel
      Left = 6
      Top = 27
      Caption = 'C'#243'd. Invent'#225'rio:'
      Transparent = True
    end
    object lbDtOperacao: TcxLabel
      Left = 150
      Top = 27
      Caption = 'Data Abertura:'
      Transparent = True
    end
    object edtDataOperacao: TcxDateEdit
      Left = 150
      Top = 43
      Enabled = False
      Properties.InputKind = ikRegExpr
      Properties.Kind = ckDateTime
      Properties.SaveTime = False
      Properties.ShowTime = False
      StyleDisabled.TextColor = clBlack
      TabOrder = 4
      Width = 150
    end
    object edtStatus: TcxImageComboBox
      Left = 6
      Top = 82
      Enabled = False
      Properties.Items = <
        item
          Description = 'Aberto'
          ImageIndex = 0
          Value = 'A'
        end
        item
          Description = 'Fechado'
          Value = 'F'
        end
        item
          Description = 'Inativo'
          Value = 'I'
        end>
      StyleDisabled.TextColor = clBlack
      TabOrder = 5
      Width = 141
    end
    object lbStatus: TcxLabel
      Left = 6
      Top = 66
      Caption = 'Situa'#231#227'o:'
      Transparent = True
    end
    object edtDataFechamento: TcxDateEdit
      Left = 150
      Top = 82
      Enabled = False
      Properties.InputKind = ikRegExpr
      Properties.Kind = ckDateTime
      Properties.SaveTime = False
      Properties.ShowTime = False
      StyleDisabled.TextColor = clBlack
      TabOrder = 7
      Width = 150
    end
    object cxLabel1: TcxLabel
      Left = 150
      Top = 66
      Caption = 'Data Fechamento:'
      Transparent = True
    end
  end
  inherited ppRelatorio: TppReport
    Left = 105
    Top = 111
    DataPipelineName = 'ppDBPipeline'
    inherited ppHeaderBand1: TppHeaderBand
      mmHeight = 16140
      inherited ppImgSage: TppImage
        LayerName = Foreground
      end
      inherited LabelTitulo: TppLabel
        SaveOrder = -1
        Caption = 'RELAT'#211'RIO DE CONTAGEM DE INVENT'#193'RIO'
        mmTop = 4233
        LayerName = Foreground
      end
      inherited ppLbDetalhe: TppLabel
        SaveOrder = -1
        Caption = '     '
        Visible = False
        LayerName = Foreground
      end
      inherited pplbSistema: TppLabel
        SaveOrder = -1
        mmTop = 9525
        LayerName = Foreground
      end
    end
    inherited ppDetailBand1: TppDetailBand
      mmHeight = 4233
      object ppDBText1: TppDBText
        UserName = 'DBText1'
        DataField = 'nmprodutocommarca'
        DataPipeline = ppDBPipeline
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Calibri'
        Font.Size = 9
        Font.Style = []
        Transparent = True
        DataPipelineName = 'ppDBPipeline'
        mmHeight = 3969
        mmLeft = 6350
        mmTop = 0
        mmWidth = 66146
        BandType = 4
        LayerName = Foreground
      end
      object ppDBText2: TppDBText
        UserName = 'DBText2'
        DataField = 'nqtdcontada'
        DataPipeline = ppDBPipeline
        DisplayFormat = '#,0.00;-#,0.00'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Calibri'
        Font.Size = 9
        Font.Style = []
        TextAlignment = taRightJustified
        Transparent = True
        DataPipelineName = 'ppDBPipeline'
        mmHeight = 3852
        mmLeft = 73025
        mmTop = 0
        mmWidth = 22225
        BandType = 4
        LayerName = Foreground
      end
      object ppDBText3: TppDBText
        UserName = 'DBText3'
        DataField = 'ndiferenca'
        DataPipeline = ppDBPipeline
        DisplayFormat = '#,0.00;-#,0.00'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Calibri'
        Font.Size = 9
        Font.Style = []
        TextAlignment = taRightJustified
        Transparent = True
        DataPipelineName = 'ppDBPipeline'
        mmHeight = 3852
        mmLeft = 96573
        mmTop = 0
        mmWidth = 16404
        BandType = 4
        LayerName = Foreground
      end
    end
    inherited ppFooterBand1: TppFooterBand
      inherited pplineRodape: TppLine
        LayerName = Foreground
      end
      inherited pplbPaginas: TppSystemVariable
        SaveOrder = -1
        LayerName = Foreground
      end
      inherited pplbDataHora: TppSystemVariable
        SaveOrder = -1
        LayerName = Foreground
      end
    end
    object ppGroup1: TppGroup [4]
      BreakName = 'iinventario'
      DataPipeline = ppDBPipeline
      GroupFileSettings.NewFile = False
      GroupFileSettings.EmailFile = False
      KeepTogether = True
      OutlineSettings.CreateNode = True
      StartOnOddPage = False
      UserName = 'Group1'
      mmNewColumnThreshold = 0
      mmNewPageThreshold = 0
      DataPipelineName = 'ppDBPipeline'
      NewFile = False
      object ppGroupHeaderBand1: TppGroupHeaderBand
        Background.Brush.Style = bsClear
        mmBottomOffset = 0
        mmHeight = 11906
        mmPrintPosition = 0
        object ppShape1: TppShape
          UserName = 'Shape1'
          mmHeight = 4763
          mmLeft = 1058
          mmTop = 0
          mmWidth = 206640
          BandType = 3
          GroupNo = 0
          LayerName = Foreground
        end
        object ppLabel4: TppLabel
          UserName = 'Label4'
          Border.Weight = 1.000000000000000000
          Caption = 'Intent'#225'rio:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Name = 'Calibri'
          Font.Size = 10
          Font.Style = [fsBold]
          Transparent = True
          mmHeight = 4276
          mmLeft = 3704
          mmTop = 265
          mmWidth = 15536
          BandType = 3
          GroupNo = 0
          LayerName = Foreground
        end
        object ppLabel5: TppLabel
          UserName = 'Label5'
          Border.Weight = 1.000000000000000000
          Caption = 'Dt. Hr. Abertura:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Name = 'Calibri'
          Font.Size = 10
          Font.Style = [fsBold]
          Transparent = True
          mmHeight = 4233
          mmLeft = 35719
          mmTop = 265
          mmWidth = 24077
          BandType = 3
          GroupNo = 0
          LayerName = Foreground
        end
        object ppLabel7: TppLabel
          UserName = 'Label7'
          Border.Weight = 1.000000000000000000
          Caption = 'Dt. Hr. Fechamento:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Name = 'Calibri'
          Font.Size = 10
          Font.Style = [fsBold]
          Transparent = True
          mmHeight = 4233
          mmLeft = 94721
          mmTop = 265
          mmWidth = 29104
          BandType = 3
          GroupNo = 0
          LayerName = Foreground
        end
        object ppDBText4: TppDBText
          UserName = 'DBText4'
          AutoSize = True
          DataField = 'ddatafechamento'
          DataPipeline = ppDBPipeline
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Name = 'Calibri'
          Font.Size = 10
          Font.Style = []
          Transparent = True
          DataPipelineName = 'ppDBPipeline'
          mmHeight = 4233
          mmLeft = 124619
          mmTop = 265
          mmWidth = 30163
          BandType = 3
          GroupNo = 0
          LayerName = Foreground
        end
        object ppDBText5: TppDBText
          UserName = 'DBText5'
          AutoSize = True
          DataField = 'ddataoperacao'
          DataPipeline = ppDBPipeline
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Name = 'Calibri'
          Font.Size = 10
          Font.Style = []
          Transparent = True
          DataPipelineName = 'ppDBPipeline'
          mmHeight = 4233
          mmLeft = 60061
          mmTop = 265
          mmWidth = 30163
          BandType = 3
          GroupNo = 0
          LayerName = Foreground
        end
        object ppDBText6: TppDBText
          UserName = 'DBText6'
          DataField = 'iinventario'
          DataPipeline = ppDBPipeline
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Name = 'Calibri'
          Font.Size = 10
          Font.Style = []
          Transparent = True
          DataPipelineName = 'ppDBPipeline'
          mmHeight = 4233
          mmLeft = 20108
          mmTop = 265
          mmWidth = 14288
          BandType = 3
          GroupNo = 0
          LayerName = Foreground
        end
        object ppLine1: TppLine
          UserName = 'lineRodape1'
          Border.Weight = 1.000000000000000000
          Visible = False
          Weight = 0.750000000000000000
          mmHeight = 1058
          mmLeft = 1058
          mmTop = 10848
          mmWidth = 206640
          BandType = 3
          GroupNo = 0
          LayerName = Foreground
        end
        object ppLabel1: TppLabel
          UserName = 'Label1'
          Caption = 'PRODUTO'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Name = 'Calibri'
          Font.Size = 10
          Font.Style = [fsBold]
          Transparent = True
          mmHeight = 4233
          mmLeft = 6350
          mmTop = 6350
          mmWidth = 14817
          BandType = 3
          GroupNo = 0
          LayerName = Foreground
        end
        object ppLabel2: TppLabel
          UserName = 'Label2'
          Caption = 'QTD. CONTADA'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Name = 'Calibri'
          Font.Size = 10
          Font.Style = [fsBold]
          TextAlignment = taRightJustified
          Transparent = True
          mmHeight = 4233
          mmLeft = 73025
          mmTop = 6350
          mmWidth = 22225
          BandType = 3
          GroupNo = 0
          LayerName = Foreground
        end
        object ppLabel3: TppLabel
          UserName = 'Label3'
          Caption = 'DIFEREN'#199'A'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Name = 'Calibri'
          Font.Size = 10
          Font.Style = [fsBold]
          TextAlignment = taRightJustified
          Transparent = True
          mmHeight = 4233
          mmLeft = 96573
          mmTop = 6350
          mmWidth = 16404
          BandType = 3
          GroupNo = 0
          LayerName = Foreground
        end
      end
      object ppGroupFooterBand1: TppGroupFooterBand
        Background.Brush.Style = bsClear
        HideWhenOneDetail = False
        mmBottomOffset = 0
        mmHeight = 4233
        mmPrintPosition = 0
      end
    end
  end
  inherited ppDBPipeline: TppDBPipeline
    Left = 72
    Top = 111
    object ppDBPipelineppField1: TppField
      Alignment = taRightJustify
      FieldAlias = 'icodigo'
      FieldName = 'icodigo'
      FieldLength = 0
      DataType = dtInteger
      DisplayWidth = 0
      Position = 0
    end
    object ppDBPipelineppField2: TppField
      Alignment = taRightJustify
      FieldAlias = 'iinventario'
      FieldName = 'iinventario'
      FieldLength = 0
      DataType = dtInteger
      DisplayWidth = 10
      Position = 1
    end
    object ppDBPipelineppField3: TppField
      FieldAlias = 'ddataoperacao'
      FieldName = 'ddataoperacao'
      FieldLength = 0
      DataType = dtDateTime
      DisplayWidth = 18
      Position = 2
    end
    object ppDBPipelineppField4: TppField
      FieldAlias = 'sstatus'
      FieldName = 'sstatus'
      FieldLength = 1
      DisplayWidth = 1
      Position = 3
    end
    object ppDBPipelineppField5: TppField
      FieldAlias = 'nmstatus'
      FieldName = 'nmstatus'
      FieldLength = 10
      DisplayWidth = 10
      Position = 4
    end
    object ppDBPipelineppField6: TppField
      Alignment = taRightJustify
      FieldAlias = 'idusuariocad'
      FieldName = 'idusuariocad'
      FieldLength = 0
      DataType = dtInteger
      DisplayWidth = 10
      Position = 5
    end
    object ppDBPipelineppField7: TppField
      Alignment = taRightJustify
      FieldAlias = 'idusuarioultalt'
      FieldName = 'idusuarioultalt'
      FieldLength = 0
      DataType = dtInteger
      DisplayWidth = 10
      Position = 6
    end
    object ppDBPipelineppField8: TppField
      FieldAlias = 'datahoraultalt'
      FieldName = 'datahoraultalt'
      FieldLength = 0
      DataType = dtDateTime
      DisplayWidth = 18
      Position = 7
    end
    object ppDBPipelineppField9: TppField
      Alignment = taRightJustify
      FieldAlias = 'iproduto'
      FieldName = 'iproduto'
      FieldLength = 0
      DataType = dtInteger
      DisplayWidth = 10
      Position = 8
    end
    object ppDBPipelineppField10: TppField
      FieldAlias = 'sreferencia'
      FieldName = 'sreferencia'
      FieldLength = 15
      DisplayWidth = 15
      Position = 9
    end
    object ppDBPipelineppField11: TppField
      FieldAlias = 'sfabricacao'
      FieldName = 'sfabricacao'
      FieldLength = 15
      DisplayWidth = 15
      Position = 10
    end
    object ppDBPipelineppField12: TppField
      FieldAlias = 'nmproduto'
      FieldName = 'nmproduto'
      FieldLength = 50
      DisplayWidth = 50
      Position = 11
    end
    object ppDBPipelineppField13: TppField
      FieldAlias = 'nmprodutocommarca'
      FieldName = 'nmprodutocommarca'
      FieldLength = 0
      DataType = dtMemo
      DisplayWidth = 10
      Position = 12
      Searchable = False
      Sortable = False
    end
    object ppDBPipelineppField14: TppField
      Alignment = taRightJustify
      FieldAlias = 'isubgrupo'
      FieldName = 'isubgrupo'
      FieldLength = 0
      DataType = dtInteger
      DisplayWidth = 10
      Position = 13
    end
    object ppDBPipelineppField15: TppField
      FieldAlias = 'nmsubgrupo'
      FieldName = 'nmsubgrupo'
      FieldLength = 30
      DisplayWidth = 30
      Position = 14
    end
    object ppDBPipelineppField16: TppField
      Alignment = taRightJustify
      FieldAlias = 'igrupo'
      FieldName = 'igrupo'
      FieldLength = 0
      DataType = dtInteger
      DisplayWidth = 10
      Position = 15
    end
    object ppDBPipelineppField17: TppField
      FieldAlias = 'nmgrupo'
      FieldName = 'nmgrupo'
      FieldLength = 30
      DisplayWidth = 30
      Position = 16
    end
    object ppDBPipelineppField18: TppField
      Alignment = taRightJustify
      FieldAlias = 'imarca'
      FieldName = 'imarca'
      FieldLength = 0
      DataType = dtInteger
      DisplayWidth = 10
      Position = 17
    end
    object ppDBPipelineppField19: TppField
      FieldAlias = 'nmmarca'
      FieldName = 'nmmarca'
      FieldLength = 30
      DisplayWidth = 30
      Position = 18
    end
    object ppDBPipelineppField20: TppField
      Alignment = taRightJustify
      FieldAlias = 'nqtdcontada'
      FieldName = 'nqtdcontada'
      FieldLength = 0
      DataType = dtDouble
      DisplayWidth = 10
      Position = 19
    end
    object ppDBPipelineppField21: TppField
      Alignment = taRightJustify
      FieldAlias = 'ndiferenca'
      FieldName = 'ndiferenca'
      FieldLength = 0
      DataType = dtDouble
      DisplayWidth = 10
      Position = 20
    end
    object ppDBPipelineppField22: TppField
      FieldAlias = 'ddatafechamento'
      FieldName = 'ddatafechamento'
      FieldLength = 0
      DataType = dtDateTime
      DisplayWidth = 18
      Position = 21
    end
  end
  inherited dsRelatorio: TDataSource
    Left = 40
    Top = 111
  end
  inherited qrRelatorio: TZQuery
    Active = True
    SQL.Strings = (
      'select * from vwinventarioitens'
      'where iinventario = coalesce(:iinventario, iinventario)'
      'order by iinventario')
    Params = <
      item
        DataType = ftUnknown
        Name = 'iinventario'
        ParamType = ptUnknown
      end>
    Left = 7
    Top = 111
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'iinventario'
        ParamType = ptUnknown
      end>
    object qrRelatorioicodigo: TIntegerField
      FieldName = 'icodigo'
    end
    object qrRelatorioiinventario: TIntegerField
      FieldName = 'iinventario'
    end
    object qrRelatorioddataoperacao: TDateTimeField
      FieldName = 'ddataoperacao'
    end
    object qrRelatoriosstatus: TWideStringField
      FieldName = 'sstatus'
      Size = 1
    end
    object qrRelatorionmstatus: TWideStringField
      FieldName = 'nmstatus'
      Size = 10
    end
    object qrRelatorioidusuariocad: TIntegerField
      FieldName = 'idusuariocad'
    end
    object qrRelatorioidusuarioultalt: TIntegerField
      FieldName = 'idusuarioultalt'
    end
    object qrRelatoriodatahoraultalt: TDateTimeField
      FieldName = 'datahoraultalt'
    end
    object qrRelatorioiproduto: TIntegerField
      FieldName = 'iproduto'
    end
    object qrRelatoriosreferencia: TWideStringField
      FieldName = 'sreferencia'
      Size = 15
    end
    object qrRelatoriosfabricacao: TWideStringField
      FieldName = 'sfabricacao'
      Size = 15
    end
    object qrRelatorionmproduto: TWideStringField
      FieldName = 'nmproduto'
      Size = 50
    end
    object qrRelatorionmprodutocommarca: TWideMemoField
      FieldName = 'nmprodutocommarca'
      BlobType = ftWideMemo
    end
    object qrRelatorioisubgrupo: TIntegerField
      FieldName = 'isubgrupo'
    end
    object qrRelatorionmsubgrupo: TWideStringField
      FieldName = 'nmsubgrupo'
      Size = 30
    end
    object qrRelatorioigrupo: TIntegerField
      FieldName = 'igrupo'
    end
    object qrRelatorionmgrupo: TWideStringField
      FieldName = 'nmgrupo'
      Size = 30
    end
    object qrRelatorioimarca: TIntegerField
      FieldName = 'imarca'
    end
    object qrRelatorionmmarca: TWideStringField
      FieldName = 'nmmarca'
      Size = 30
    end
    object qrRelatorionqtdcontada: TFloatField
      FieldName = 'nqtdcontada'
    end
    object qrRelatoriondiferenca: TFloatField
      FieldName = 'ndiferenca'
    end
    object qrRelatorioddatafechamento: TDateTimeField
      FieldName = 'ddatafechamento'
      ReadOnly = True
    end
  end
end
