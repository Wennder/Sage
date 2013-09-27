object FRelatorioProduto: TFRelatorioProduto
  Left = 245
  Top = 316
  Caption = 'Produtos Cadastrados'
  ClientHeight = 213
  ClientWidth = 239
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object DataSource1: TDataSource
    DataSet = ZQuery1
    Left = 64
    Top = 40
  end
  object ppDBPipeline1: TppDBPipeline
    DataSource = DataSource1
    UserName = 'DBPipeline1'
    Left = 65
    Top = 104
  end
  object ppReport1: TppReport
    AutoStop = False
    DataPipeline = ppDBPipeline1
    PrinterSetup.BinName = 'Tractor'
    PrinterSetup.DocumentName = 'Report'
    PrinterSetup.PaperName = 'Tamanho da p'#225'gina personalizada PostScript'
    PrinterSetup.PrinterName = 'Default'
    PrinterSetup.SaveDeviceSettings = False
    PrinterSetup.mmMarginBottom = 0
    PrinterSetup.mmMarginLeft = 0
    PrinterSetup.mmMarginRight = 0
    PrinterSetup.mmMarginTop = 0
    PrinterSetup.mmPaperHeight = 306000
    PrinterSetup.mmPaperWidth = 212000
    PrinterSetup.PaperSize = 32767
    Template.FileName = 'D:\SAGE Project\ProjetosSVN\SRC\ComissaoPeriodo.rtm'
    Units = utMillimeters
    ArchiveFileName = '($MyDocuments)\ReportArchive.raf'
    DeviceType = 'Screen'
    DefaultFileDeviceType = 'PDF'
    EmailSettings.ReportFormat = 'PDF'
    LanguageID = 'Default'
    OutlineSettings.CreateNode = True
    OutlineSettings.CreatePageNodes = True
    OutlineSettings.Enabled = True
    OutlineSettings.Visible = True
    PDFSettings.EmbedFontOptions = []
    PDFSettings.EncryptSettings.AllowCopy = True
    PDFSettings.EncryptSettings.AllowInteract = True
    PDFSettings.EncryptSettings.AllowModify = True
    PDFSettings.EncryptSettings.AllowPrint = True
    PDFSettings.EncryptSettings.Enabled = False
    PDFSettings.FontEncoding = feAnsi
    PDFSettings.ImageCompressionLevel = 25
    RTFSettings.DefaultFont.Charset = DEFAULT_CHARSET
    RTFSettings.DefaultFont.Color = clWindowText
    RTFSettings.DefaultFont.Height = -13
    RTFSettings.DefaultFont.Name = 'Arial'
    RTFSettings.DefaultFont.Style = []
    TextFileName = '($MyDocuments)\Report.pdf'
    TextSearchSettings.DefaultString = '<FindText>'
    TextSearchSettings.Enabled = True
    XLSSettings.AppName = 'ReportBuilder'
    XLSSettings.Author = 'ReportBuilder'
    XLSSettings.Subject = 'Report'
    XLSSettings.Title = 'Report'
    Left = 144
    Top = 40
    Version = '14.07'
    mmColumnWidth = 212000
    DataPipelineName = 'ppDBPipeline1'
    object ppHeaderBand1: TppHeaderBand
      Background.Brush.Style = bsClear
      mmBottomOffset = 0
      mmHeight = 16140
      mmPrintPosition = 0
      object ppLabel2: TppLabel
        UserName = 'Label2'
        AutoSize = False
        Border.Weight = 1.000000000000000000
        Caption = 'COMISS'#195'O POR PER'#205'ODO'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = '17CPI'
        Font.Size = 8
        Font.Style = []
        TextAlignment = taCentered
        Transparent = True
        mmHeight = 3175
        mmLeft = 0
        mmTop = 1588
        mmWidth = 207169
        BandType = 0
        LayerName = Foreground
      end
      object ppLabel3: TppLabel
        UserName = 'Label3'
        AutoSize = False
        Border.Weight = 1.000000000000000000
        Caption = 'Pedido'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = '17CPI'
        Font.Size = 8
        Font.Style = [fsBold]
        Transparent = True
        mmHeight = 3323
        mmLeft = 1165
        mmTop = 8996
        mmWidth = 9790
        BandType = 0
        LayerName = Foreground
      end
      object ppLabel4: TppLabel
        UserName = 'Label4'
        AutoSize = False
        Border.Weight = 1.000000000000000000
        Caption = 'Data Pedido'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = '17CPI'
        Font.Size = 8
        Font.Style = [fsBold]
        Transparent = True
        mmHeight = 3323
        mmLeft = 11642
        mmTop = 8996
        mmWidth = 16933
        BandType = 0
        LayerName = Foreground
      end
      object ppLabel5: TppLabel
        UserName = 'Label5'
        AutoSize = False
        Border.Weight = 1.000000000000000000
        Caption = 'Total Pedido'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = '17CPI'
        Font.Size = 8
        Font.Style = [fsBold]
        TextAlignment = taRightJustified
        Transparent = True
        mmHeight = 3323
        mmLeft = 29104
        mmTop = 8996
        mmWidth = 18521
        BandType = 0
        LayerName = Foreground
      end
      object ppLabel6: TppLabel
        UserName = 'Label6'
        AutoSize = False
        Border.Weight = 1.000000000000000000
        Caption = '% Comiss'#227'o'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = '17CPI'
        Font.Size = 8
        Font.Style = [fsBold]
        TextAlignment = taRightJustified
        Transparent = True
        mmHeight = 3323
        mmLeft = 48154
        mmTop = 8996
        mmWidth = 19050
        BandType = 0
        LayerName = Foreground
      end
      object ppLabel7: TppLabel
        UserName = 'Label7'
        AutoSize = False
        Border.Weight = 1.000000000000000000
        Caption = 'Vl. Servi'#231'o'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = '17CPI'
        Font.Size = 8
        Font.Style = [fsBold]
        TextAlignment = taRightJustified
        Transparent = True
        mmHeight = 3323
        mmLeft = 67733
        mmTop = 8996
        mmWidth = 15875
        BandType = 0
        LayerName = Foreground
      end
      object ppLabel8: TppLabel
        UserName = 'Label8'
        AutoSize = False
        Border.Weight = 1.000000000000000000
        Caption = 'Vl. Comiss'#227'o'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = '17CPI'
        Font.Size = 8
        Font.Style = [fsBold]
        TextAlignment = taRightJustified
        Transparent = True
        mmHeight = 3323
        mmLeft = 84138
        mmTop = 8996
        mmWidth = 20373
        BandType = 0
        LayerName = Foreground
      end
      object ppLabel9: TppLabel
        UserName = 'Label9'
        AutoSize = False
        Border.Weight = 1.000000000000000000
        Caption = 'Servi'#231'o'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = '17CPI'
        Font.Size = 8
        Font.Style = [fsBold]
        Transparent = True
        mmHeight = 3323
        mmLeft = 106098
        mmTop = 8996
        mmWidth = 51329
        BandType = 0
        LayerName = Foreground
      end
      object ppLabel10: TppLabel
        UserName = 'Label10'
        Border.Weight = 1.000000000000000000
        Caption = 'Cliente'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = '17CPI'
        Font.Size = 8
        Font.Style = [fsBold]
        Transparent = True
        mmHeight = 3323
        mmLeft = 159544
        mmTop = 8996
        mmWidth = 47625
        BandType = 0
        LayerName = Foreground
      end
      object ppLabel11: TppLabel
        UserName = 'Label11'
        Border.Weight = 1.000000000000000000
        Caption = 
          '----------------------------------------------------------------' +
          '----------------------------------------------------------------' +
          '----------------------------------------------------------------' +
          '------------------------------'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = '17CPI'
        Font.Size = 8
        Font.Style = []
        Transparent = True
        mmHeight = 3239
        mmLeft = 0
        mmTop = 12171
        mmWidth = 206756
        BandType = 0
        LayerName = Foreground
      end
      object ppLabel12: TppLabel
        UserName = 'Label12'
        Border.Weight = 1.000000000000000000
        Caption = 
          '----------------------------------------------------------------' +
          '----------------------------------------------------------------' +
          '----------------------------------------------------------------' +
          '------------------------------'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = '17CPI'
        Font.Size = 8
        Font.Style = []
        Transparent = True
        mmHeight = 3239
        mmLeft = 0
        mmTop = 5027
        mmWidth = 206756
        BandType = 0
        LayerName = Foreground
      end
    end
    object ppDetailBand1: TppDetailBand
      Background1.Brush.Style = bsClear
      Background2.Brush.Style = bsClear
      mmBottomOffset = 0
      mmHeight = 3969
      mmPrintPosition = 0
      object ppDBText2: TppDBText
        UserName = 'DBText2'
        Border.Weight = 1.000000000000000000
        DataField = 'ipedido'
        DataPipeline = ppDBPipeline1
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = '17CPI'
        Font.Size = 8
        Font.Style = []
        TextAlignment = taRightJustified
        Transparent = True
        DataPipelineName = 'ppDBPipeline1'
        mmHeight = 3239
        mmLeft = 1058
        mmTop = 0
        mmWidth = 9790
        BandType = 4
        LayerName = Foreground
      end
      object ppDBText3: TppDBText
        UserName = 'DBText3'
        Border.Weight = 1.000000000000000000
        DataField = 'ddatapedido'
        DataPipeline = ppDBPipeline1
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = '17CPI'
        Font.Size = 8
        Font.Style = []
        Transparent = True
        DataPipelineName = 'ppDBPipeline1'
        mmHeight = 3239
        mmLeft = 11642
        mmTop = 0
        mmWidth = 16933
        BandType = 4
        LayerName = Foreground
      end
      object ppDBText4: TppDBText
        UserName = 'DBText4'
        Border.Weight = 1.000000000000000000
        DataField = 'ntotalpedido'
        DataPipeline = ppDBPipeline1
        DisplayFormat = '#,0.00;-#,0.00'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = '17CPI'
        Font.Size = 8
        Font.Style = []
        TextAlignment = taRightJustified
        Transparent = True
        DataPipelineName = 'ppDBPipeline1'
        mmHeight = 3239
        mmLeft = 29104
        mmTop = 0
        mmWidth = 18521
        BandType = 4
        LayerName = Foreground
      end
      object ppDBText5: TppDBText
        UserName = 'DBText5'
        Border.Weight = 1.000000000000000000
        DataField = 'ncomissao'
        DataPipeline = ppDBPipeline1
        DisplayFormat = '#,0.00;-#,0.00'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = '17CPI'
        Font.Size = 8
        Font.Style = []
        TextAlignment = taRightJustified
        Transparent = True
        DataPipelineName = 'ppDBPipeline1'
        mmHeight = 3239
        mmLeft = 48154
        mmTop = 0
        mmWidth = 19050
        BandType = 4
        LayerName = Foreground
      end
      object ppDBText6: TppDBText
        UserName = 'DBText6'
        Border.Weight = 1.000000000000000000
        DataField = 'nvalorservico'
        DataPipeline = ppDBPipeline1
        DisplayFormat = '#,0.00;-#,0.00'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = '17CPI'
        Font.Size = 8
        Font.Style = []
        TextAlignment = taRightJustified
        Transparent = True
        DataPipelineName = 'ppDBPipeline1'
        mmHeight = 3239
        mmLeft = 67469
        mmTop = 0
        mmWidth = 16404
        BandType = 4
        LayerName = Foreground
      end
      object ppDBText7: TppDBText
        UserName = 'DBText7'
        Border.Weight = 1.000000000000000000
        DataField = 'nvalorcomissao'
        DataPipeline = ppDBPipeline1
        DisplayFormat = '#,0.00;-#,0.00'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = '17CPI'
        Font.Size = 8
        Font.Style = []
        TextAlignment = taRightJustified
        Transparent = True
        DataPipelineName = 'ppDBPipeline1'
        mmHeight = 3239
        mmLeft = 84138
        mmTop = 0
        mmWidth = 20373
        BandType = 4
        LayerName = Foreground
      end
      object ppDBText8: TppDBText
        UserName = 'DBText8'
        Border.Weight = 1.000000000000000000
        DataField = 'servico'
        DataPipeline = ppDBPipeline1
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = '17CPI'
        Font.Size = 8
        Font.Style = []
        Transparent = True
        DataPipelineName = 'ppDBPipeline1'
        mmHeight = 3239
        mmLeft = 106098
        mmTop = 0
        mmWidth = 51329
        BandType = 4
        LayerName = Foreground
      end
      object ppDBText9: TppDBText
        UserName = 'DBText9'
        Border.Weight = 1.000000000000000000
        DataField = 'cliente'
        DataPipeline = ppDBPipeline1
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = '17CPI'
        Font.Size = 8
        Font.Style = []
        Transparent = True
        DataPipelineName = 'ppDBPipeline1'
        mmHeight = 3239
        mmLeft = 159544
        mmTop = 0
        mmWidth = 47625
        BandType = 4
        LayerName = Foreground
      end
    end
    object ppFooterBand1: TppFooterBand
      Background.Brush.Style = bsClear
      mmBottomOffset = 0
      mmHeight = 13229
      mmPrintPosition = 0
    end
    object ppGroup1: TppGroup
      BreakName = 'tecnico'
      DataPipeline = ppDBPipeline1
      GroupFileSettings.NewFile = False
      GroupFileSettings.EmailFile = False
      KeepTogether = True
      OutlineSettings.CreateNode = True
      StartOnOddPage = False
      UserName = 'Group1'
      mmNewColumnThreshold = 0
      mmNewPageThreshold = 0
      DataPipelineName = 'ppDBPipeline1'
      NewFile = False
      object ppGroupHeaderBand1: TppGroupHeaderBand
        Background.Brush.Style = bsClear
        mmBottomOffset = 0
        mmHeight = 6085
        mmPrintPosition = 0
        object ppLabel1: TppLabel
          UserName = 'Label1'
          Border.Weight = 1.000000000000000000
          Caption = 'T'#233'cnico:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Name = '17CPI'
          Font.Size = 8
          Font.Style = [fsBold]
          Transparent = True
          mmHeight = 3323
          mmLeft = 2646
          mmTop = 1588
          mmWidth = 11557
          BandType = 3
          GroupNo = 0
          LayerName = Foreground
        end
        object ppDBText1: TppDBText
          UserName = 'DBText1'
          AutoSize = True
          Border.Weight = 1.000000000000000000
          DataField = 'tecnico'
          DataPipeline = ppDBPipeline1
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Name = '17CPI'
          Font.Size = 8
          Font.Style = [fsBold]
          Transparent = True
          DataPipelineName = 'ppDBPipeline1'
          mmHeight = 3323
          mmLeft = 16140
          mmTop = 1588
          mmWidth = 24469
          BandType = 3
          GroupNo = 0
          LayerName = Foreground
        end
      end
      object ppGroupFooterBand1: TppGroupFooterBand
        Background.Brush.Style = bsClear
        HideWhenOneDetail = False
        mmBottomOffset = 0
        mmHeight = 7408
        mmPrintPosition = 0
        object ppDBCalc1: TppDBCalc
          UserName = 'DBCalc1'
          Border.Weight = 1.000000000000000000
          DataField = 'nvalorservico'
          DataPipeline = ppDBPipeline1
          DisplayFormat = '#,0.00;-#,0.00'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Name = '17CPI'
          Font.Size = 8
          Font.Style = [fsBold]
          ResetGroup = ppGroup1
          TextAlignment = taRightJustified
          Transparent = True
          DataPipelineName = 'ppDBPipeline1'
          mmHeight = 3323
          mmLeft = 67469
          mmTop = 794
          mmWidth = 16404
          BandType = 5
          GroupNo = 0
          LayerName = Foreground
        end
        object ppDBCalc2: TppDBCalc
          UserName = 'DBCalc2'
          Border.Weight = 1.000000000000000000
          DataField = 'nvalorcomissao'
          DataPipeline = ppDBPipeline1
          DisplayFormat = '#,0.00;-#,0.00'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Name = '17CPI'
          Font.Size = 8
          Font.Style = [fsBold]
          ResetGroup = ppGroup1
          TextAlignment = taRightJustified
          Transparent = True
          DataPipelineName = 'ppDBPipeline1'
          mmHeight = 3323
          mmLeft = 84138
          mmTop = 794
          mmWidth = 20373
          BandType = 5
          GroupNo = 0
          LayerName = Foreground
        end
        object ppLabel13: TppLabel
          UserName = 'Label13'
          Border.Weight = 1.000000000000000000
          Caption = 'Total Geral:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Name = '17CPI'
          Font.Size = 8
          Font.Style = [fsBold]
          Transparent = True
          mmHeight = 3323
          mmLeft = 2646
          mmTop = 794
          mmWidth = 15621
          BandType = 5
          GroupNo = 0
          LayerName = Foreground
        end
      end
    end
    object raCodeModule1: TraCodeModule
      ProgramStream = {
        01060D54726156617250726F6772616D094368696C645479706502110B50726F
        6772616D4E616D6506095661726961626C65730B50726F6772616D5479706507
        0B747450726F63656475726506536F75726365065A70726F6365647572652056
        61726961626C65733B0D0A7661720D0A544F54414C5F4E4F54413A20444F5542
        4C453B0D0A444553434F4E544F5F56414C4F523A20444F55424C453B0D0A0D0A
        626567696E0D0A0D0A656E643B0D0A0000}
    end
    object ppDesignLayers1: TppDesignLayers
      object ppDesignLayer1: TppDesignLayer
        UserName = 'Foreground'
        LayerType = ltBanded
        Index = 0
      end
    end
    object ppParameterList1: TppParameterList
    end
  end
  object ZQuery1: TZQuery
    Params = <>
    Properties.Strings = (
      
        'select       cast(tbservicotecnico.itecnico as varchar(100)) || ' +
        #39#39' - '#39#39' || tbpessoa.snome as Tecnico, tbservicotecnico.ipedido, ' +
        'tbpedido.ddatapedido,      tbpedido.ntotalprodutos + tbpedido.na' +
        'justevalor as ntotalpedido, tbpedido.sveiculo, tbpedido.splaca, ' +
        'cast(coalesce(tbpedido.icliente, 0) as varchar(100)) || '#39#39' - '#39#39' ' +
        '|| coalesce(tbpessoacliente.snome, tbconsumidor.snome,'#39#39'CONSUMID' +
        'OR'#39#39#39') as cliente,   cast(tbservicotecnico.iservico as varchar(1' +
        '00)) || '#39#39' - '#39#39' || tbproduto.sdescricao as Servico, tbservicotec' +
        'nico.ncomissao, tbservicotecnico.nvalorservico, tbservicotecnico' +
        '.nvalorcomissao from tbservicotecnico  join tbpedido on tbpedido' +
        '.icodigo = tbservicotecnico.ipedido join tbcomissionado on tbcom' +
        'issionado.icodigo = tbservicotecnico.itecnico join tbpessoa on t' +
        'bpessoa.icodigo = tbcomissionado.icodigo join tbproduto on tbpro' +
        'duto.icodigo = tbservicotecnico.iservico left outer join tbclien' +
        'te on tbcliente.icodigo = tbpedido.icliente       left outer joi' +
        'n tbpessoa as tbpessoacliente on tbpessoacliente.icodigo = tbcli' +
        'ente.icodigo left outer join tbconsumidor on tbconsumidor.ipedid' +
        'o = tbpedidoicodigo')
    Left = 144
    Top = 104
  end
end
