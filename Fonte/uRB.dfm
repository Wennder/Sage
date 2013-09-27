object fRB: TfRB
  Left = 192
  Top = 114
  ClientHeight = 251
  ClientWidth = 201
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Button1: TButton
    Left = 56
    Top = 56
    Width = 75
    Height = 25
    Caption = 'Button1'
    TabOrder = 0
    OnClick = Button1Click
  end
  object ppDesigner1: TppDesigner
    AllowDataSettingsChange = True
    Caption = 'ReportBuilder'
    DataSettings.DatabaseName = 'PostgreSQL'
    DataSettings.SessionType = 'BDESession'
    DataSettings.AllowEditSQL = True
    DataSettings.DatabaseType = dtPostgreSQL
    DataSettings.GuidCollationType = gcString
    DataSettings.IsCaseSensitive = True
    DataSettings.SQLType = sqBDELocal
    Position = poScreenCenter
    Report = ppReport1
    IniStorageType = 'IniFile'
    IniStorageName = '($WINSYS)\RBuilder.ini'
    WindowHeight = 400
    WindowLeft = 100
    WindowTop = 50
    WindowWidth = 600
    Left = 56
    Top = 16
  end
  object ppReport1: TppReport
    AutoStop = False
    DataPipeline = ppDBPipeline1
    PrinterSetup.BinName = 'Default'
    PrinterSetup.DocumentName = 'Report'
    PrinterSetup.PaperName = 'ISO A0'
    PrinterSetup.PrinterName = 'Default'
    PrinterSetup.SaveDeviceSettings = False
    PrinterSetup.mmMarginBottom = 0
    PrinterSetup.mmMarginLeft = 0
    PrinterSetup.mmMarginRight = 0
    PrinterSetup.mmMarginTop = 0
    PrinterSetup.mmPaperHeight = 140000
    PrinterSetup.mmPaperWidth = 210000
    PrinterSetup.PaperSize = 124
    Template.FileName = 'D:\SAGE Project\ProjetosSVN\SRC\Orcamento.rtm'
    Units = utMillimeters
    DeviceType = 'Screen'
    EmailSettings.ReportFormat = 'PDF'
    LanguageID = 'Default'
    OutlineSettings.CreateNode = True
    OutlineSettings.CreatePageNodes = True
    OutlineSettings.Enabled = True
    OutlineSettings.Visible = True
    PDFSettings.EmbedFontOptions = [efUseSubset]
    PDFSettings.EncryptSettings.AllowCopy = True
    PDFSettings.EncryptSettings.AllowInteract = True
    PDFSettings.EncryptSettings.AllowModify = True
    PDFSettings.EncryptSettings.AllowPrint = True
    PDFSettings.EncryptSettings.Enabled = False
    PDFSettings.FontEncoding = feAnsi
    RTFSettings.DefaultFont.Charset = DEFAULT_CHARSET
    RTFSettings.DefaultFont.Color = clWindowText
    RTFSettings.DefaultFont.Height = -13
    RTFSettings.DefaultFont.Name = 'Arial'
    RTFSettings.DefaultFont.Style = []
    TextSearchSettings.DefaultString = '<Texto a localizar>'
    TextSearchSettings.Enabled = True
    Left = 128
    Top = 136
    Version = '12.03'
    mmColumnWidth = 240000
    DataPipelineName = 'ppDBPipeline1'
    object ppHeaderBand1: TppHeaderBand
      mmBottomOffset = 0
      mmHeight = 52123
      mmPrintPosition = 0
      object ppLabel2: TppLabel
        UserName = 'lblCPFCNPJ'
        HyperlinkColor = clBlue
        AutoSize = False
        Border.BorderPositions = []
        Border.Color = clBlack
        Border.Style = psSolid
        Border.Visible = False
        Border.Weight = 1.000000000000000000
        Ellipsis = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Courier New'
        Font.Size = 10
        Font.Style = []
        Transparent = True
        mmHeight = 4586
        mmLeft = 12965
        mmTop = 36248
        mmWidth = 75142
        BandType = 0
      end
      object ppDBText1: TppDBText
        UserName = 'DBText1'
        HyperlinkColor = clBlue
        Border.BorderPositions = []
        Border.Color = clBlack
        Border.Style = psSolid
        Border.Visible = False
        Border.Weight = 1.000000000000000000
        DataField = 'nome'
        DataPipeline = ppDBPipeline1
        Ellipsis = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Courier New'
        Font.Size = 10
        Font.Style = []
        Transparent = True
        DataPipelineName = 'ppDBPipeline1'
        mmHeight = 4022
        mmLeft = 14817
        mmTop = 23813
        mmWidth = 105834
        BandType = 0
      end
      object ppDBText2: TppDBText
        UserName = 'DBText2'
        HyperlinkColor = clBlue
        Border.BorderPositions = []
        Border.Color = clBlack
        Border.Style = psSolid
        Border.Visible = False
        Border.Weight = 1.000000000000000000
        DataField = 'sendereco'
        DataPipeline = ppDBPipeline1
        Ellipsis = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Courier New'
        Font.Size = 10
        Font.Style = []
        Transparent = True
        DataPipelineName = 'ppDBPipeline1'
        mmHeight = 4022
        mmLeft = 19315
        mmTop = 28046
        mmWidth = 98954
        BandType = 0
      end
      object ppDBText3: TppDBText
        UserName = 'DBText3'
        HyperlinkColor = clBlue
        Border.BorderPositions = []
        Border.Color = clBlack
        Border.Style = psSolid
        Border.Visible = False
        Border.Weight = 1.000000000000000000
        DataField = 'cidade'
        DataPipeline = ppDBPipeline1
        Ellipsis = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Courier New'
        Font.Size = 10
        Font.Style = []
        Transparent = True
        DataPipelineName = 'ppDBPipeline1'
        mmHeight = 4022
        mmLeft = 12965
        mmTop = 32015
        mmWidth = 75406
        BandType = 0
      end
      object ppDBText5: TppDBText
        UserName = 'DBText5'
        HyperlinkColor = clBlue
        Border.BorderPositions = []
        Border.Color = clBlack
        Border.Style = psSolid
        Border.Visible = False
        Border.Weight = 1.000000000000000000
        DataField = 'sveiculo'
        DataPipeline = ppDBPipeline1
        Ellipsis = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Courier New'
        Font.Size = 10
        Font.Style = []
        Transparent = True
        DataPipelineName = 'ppDBPipeline1'
        mmHeight = 3969
        mmLeft = 17463
        mmTop = 41540
        mmWidth = 69056
        BandType = 0
      end
      object ppDBText6: TppDBText
        UserName = 'DBText6'
        HyperlinkColor = clBlue
        Border.BorderPositions = []
        Border.Color = clBlack
        Border.Style = psSolid
        Border.Visible = False
        Border.Weight = 1.000000000000000000
        DataPipeline = ppDBPipeline1
        Ellipsis = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Courier New'
        Font.Size = 10
        Font.Style = []
        TextAlignment = taRightJustified
        Transparent = True
        DataPipelineName = 'ppDBPipeline1'
        mmHeight = 4586
        mmLeft = 145000
        mmTop = 23813
        mmWidth = 25000
        BandType = 0
      end
      object ppDBText7: TppDBText
        UserName = 'DBText7'
        HyperlinkColor = clBlue
        Border.BorderPositions = []
        Border.Color = clBlack
        Border.Style = psSolid
        Border.Visible = False
        Border.Weight = 1.000000000000000000
        DataField = 'ddatapedido'
        DataPipeline = ppDBPipeline1
        DisplayFormat = 'dd/mm/yyyy'
        Ellipsis = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Courier New'
        Font.Size = 10
        Font.Style = []
        TextAlignment = taRightJustified
        Transparent = True
        DataPipelineName = 'ppDBPipeline1'
        mmHeight = 4498
        mmLeft = 174890
        mmTop = 23813
        mmWidth = 27517
        BandType = 0
      end
      object ppDBText8: TppDBText
        UserName = 'DBText8'
        HyperlinkColor = clBlue
        Border.BorderPositions = []
        Border.Color = clBlack
        Border.Style = psSolid
        Border.Visible = False
        Border.Weight = 1.000000000000000000
        DataField = 'sfone'
        DataPipeline = ppDBPipeline1
        DisplayFormat = '(00)0000-0000;0; '
        Ellipsis = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Courier New'
        Font.Size = 10
        Font.Style = []
        Transparent = True
        DataPipelineName = 'ppDBPipeline1'
        mmHeight = 4498
        mmLeft = 145257
        mmTop = 27781
        mmWidth = 28575
        BandType = 0
      end
      object ppDBText9: TppDBText
        UserName = 'DBText9'
        HyperlinkColor = clBlue
        Border.BorderPositions = []
        Border.Color = clBlack
        Border.Style = psSolid
        Border.Visible = False
        Border.Weight = 1.000000000000000000
        DataField = 'suf'
        DataPipeline = ppDBPipeline1
        Ellipsis = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Courier New'
        Font.Size = 10
        Font.Style = []
        Transparent = True
        DataPipelineName = 'ppDBPipeline1'
        mmHeight = 4498
        mmLeft = 96573
        mmTop = 32015
        mmWidth = 46302
        BandType = 0
      end
      object ppDBText10: TppDBText
        UserName = 'DBText10'
        HyperlinkColor = clBlue
        Border.BorderPositions = []
        Border.Color = clBlack
        Border.Style = psSolid
        Border.Visible = False
        Border.Weight = 1.000000000000000000
        DataField = 'scep'
        DataPipeline = ppDBPipeline1
        DisplayFormat = '00000\-9999;0; '
        Ellipsis = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Courier New'
        Font.Size = 10
        Font.Style = []
        Transparent = True
        DataPipelineName = 'ppDBPipeline1'
        mmHeight = 4498
        mmLeft = 145521
        mmTop = 32015
        mmWidth = 24606
        BandType = 0
      end
      object ppDBText11: TppDBText
        UserName = 'DBText11'
        HyperlinkColor = clBlue
        Border.BorderPositions = []
        Border.Color = clBlack
        Border.Style = psSolid
        Border.Visible = False
        Border.Weight = 1.000000000000000000
        DataField = 'sinscestadual'
        DataPipeline = ppDBPipeline1
        Ellipsis = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Courier New'
        Font.Size = 10
        Font.Style = []
        Transparent = True
        DataPipelineName = 'ppDBPipeline1'
        mmHeight = 4498
        mmLeft = 107421
        mmTop = 36248
        mmWidth = 61648
        BandType = 0
      end
      object ppDBText12: TppDBText
        UserName = 'DBText12'
        HyperlinkColor = clBlue
        Border.BorderPositions = []
        Border.Color = clBlack
        Border.Style = psSolid
        Border.Visible = False
        Border.Weight = 1.000000000000000000
        DataField = 'splaca'
        DataPipeline = ppDBPipeline1
        DisplayFormat = 'LLL-9999;0;'
        Ellipsis = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Courier New'
        Font.Size = 10
        Font.Style = []
        Transparent = True
        DataPipelineName = 'ppDBPipeline1'
        mmHeight = 3969
        mmLeft = 106098
        mmTop = 41540
        mmWidth = 35719
        BandType = 0
      end
      object ppDBText13: TppDBText
        UserName = 'DBText13'
        HyperlinkColor = clBlue
        Border.BorderPositions = []
        Border.Color = clBlack
        Border.Style = psSolid
        Border.Visible = False
        Border.Weight = 1.000000000000000000
        DataField = 'nkm'
        DataPipeline = ppDBPipeline1
        Ellipsis = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Courier New'
        Font.Size = 10
        Font.Style = []
        Transparent = True
        DataPipelineName = 'ppDBPipeline1'
        mmHeight = 3969
        mmLeft = 145257
        mmTop = 41540
        mmWidth = 24871
        BandType = 0
      end
      object ppDBText14: TppDBText
        UserName = 'DBText14'
        HyperlinkColor = clBlue
        Border.BorderPositions = []
        Border.Color = clBlack
        Border.Style = psSolid
        Border.Visible = False
        Border.Weight = 1.000000000000000000
        DataPipeline = ppDBPipeline1
        Ellipsis = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Courier New'
        Font.Size = 10
        Font.Style = []
        Transparent = True
        DataPipelineName = 'ppDBPipeline1'
        mmHeight = 3969
        mmLeft = 176477
        mmTop = 40481
        mmWidth = 27252
        BandType = 0
      end
    end
    object ppDetailBand1: TppDetailBand
      Background1.Brush.Style = bsClear
      Background1.Gradient.EndColor = clWhite
      Background1.Gradient.StartColor = clWhite
      Background1.Gradient.Style = gsNone
      Background2.Brush.Style = bsClear
      Background2.Gradient.EndColor = clWhite
      Background2.Gradient.StartColor = clWhite
      Background2.Gradient.Style = gsNone
      PrintCount = 14
      mmBottomOffset = 0
      mmHeight = 4498
      mmPrintPosition = 0
      object ppDBText15: TppDBText
        UserName = 'DBText15'
        HyperlinkColor = clBlue
        Border.BorderPositions = []
        Border.Color = clBlack
        Border.Style = psSolid
        Border.Visible = False
        Border.Weight = 1.000000000000000000
        DataField = 'icodigo'
        DataPipeline = ppDBPipeline1
        DisplayFormat = '000000'
        Ellipsis = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Courier New'
        Font.Size = 10
        Font.Style = []
        Transparent = True
        DataPipelineName = 'ppDBPipeline1'
        mmHeight = 4586
        mmLeft = 2910
        mmTop = 0
        mmWidth = 13229
        BandType = 4
      end
      object ppDBText16: TppDBText
        UserName = 'DBText16'
        HyperlinkColor = clBlue
        Border.BorderPositions = []
        Border.Color = clBlack
        Border.Style = psSolid
        Border.Visible = False
        Border.Weight = 1.000000000000000000
        DataField = 'sdescricao'
        DataPipeline = ppDBPipeline1
        Ellipsis = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Courier New'
        Font.Size = 10
        Font.Style = []
        Transparent = True
        DataPipelineName = 'ppDBPipeline1'
        mmHeight = 4498
        mmLeft = 16404
        mmTop = 0
        mmWidth = 113506
        BandType = 4
      end
      object ppDBText17: TppDBText
        UserName = 'DBText17'
        HyperlinkColor = clBlue
        Border.BorderPositions = []
        Border.Color = clBlack
        Border.Style = psSolid
        Border.Visible = False
        Border.Weight = 1.000000000000000000
        DataField = 'unidade'
        DataPipeline = ppDBPipeline1
        Ellipsis = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Courier New'
        Font.Size = 10
        Font.Style = []
        Transparent = True
        DataPipelineName = 'ppDBPipeline1'
        mmHeight = 4498
        mmLeft = 148961
        mmTop = 0
        mmWidth = 6615
        BandType = 4
      end
      object ppDBText18: TppDBText
        UserName = 'DBText18'
        HyperlinkColor = clBlue
        Border.BorderPositions = []
        Border.Color = clBlack
        Border.Style = psSolid
        Border.Visible = False
        Border.Weight = 1.000000000000000000
        DataField = 'nquantidade'
        DataPipeline = ppDBPipeline1
        DisplayFormat = '#,0.00;-#,0.00'
        Ellipsis = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Courier New'
        Font.Size = 10
        Font.Style = []
        TextAlignment = taRightJustified
        Transparent = True
        DataPipelineName = 'ppDBPipeline1'
        mmHeight = 4586
        mmLeft = 155840
        mmTop = 0
        mmWidth = 10848
        BandType = 4
      end
      object ppDBText19: TppDBText
        UserName = 'DBText19'
        HyperlinkColor = clBlue
        Border.BorderPositions = []
        Border.Color = clBlack
        Border.Style = psSolid
        Border.Visible = False
        Border.Weight = 1.000000000000000000
        DataField = 'nvalor'
        DataPipeline = ppDBPipeline1
        DisplayFormat = '#,0.00;-#,0.00'
        Ellipsis = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Courier New'
        Font.Size = 10
        Font.Style = []
        TextAlignment = taRightJustified
        Transparent = True
        DataPipelineName = 'ppDBPipeline1'
        mmHeight = 4586
        mmLeft = 167217
        mmTop = 0
        mmWidth = 16140
        BandType = 4
      end
      object ppDBText20: TppDBText
        UserName = 'DBText20'
        HyperlinkColor = clBlue
        Border.BorderPositions = []
        Border.Color = clBlack
        Border.Style = psSolid
        Border.Visible = False
        Border.Weight = 1.000000000000000000
        DataField = 'totalitem'
        DataPipeline = ppDBPipeline1
        DisplayFormat = '#,0.00;-#,0.00'
        Ellipsis = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Courier New'
        Font.Size = 10
        Font.Style = []
        TextAlignment = taRightJustified
        Transparent = True
        DataPipelineName = 'ppDBPipeline1'
        mmHeight = 4498
        mmLeft = 184415
        mmTop = 0
        mmWidth = 18521
        BandType = 4
      end
      object ppDBText21: TppDBText
        UserName = 'DBText21'
        HyperlinkColor = clBlue
        Border.BorderPositions = []
        Border.Color = clBlack
        Border.Style = psSolid
        Border.Visible = False
        Border.Weight = 1.000000000000000000
        DataField = 'marca'
        DataPipeline = ppDBPipeline1
        Ellipsis = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Courier New'
        Font.Size = 10
        Font.Style = []
        Transparent = True
        DataPipelineName = 'ppDBPipeline1'
        mmHeight = 4586
        mmLeft = 131234
        mmTop = 0
        mmWidth = 17198
        BandType = 4
      end
    end
    object ppFooterBand1: TppFooterBand
      mmBottomOffset = 0
      mmHeight = 23000
      mmPrintPosition = 0
      object ppLabel1: TppLabel
        UserName = 'lblTotal'
        HyperlinkColor = clBlue
        AutoSize = False
        Border.BorderPositions = []
        Border.Color = clBlack
        Border.Style = psSolid
        Border.Visible = False
        Border.Weight = 1.000000000000000000
        Caption = 'lblTotal'
        Ellipsis = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Courier New'
        Font.Size = 10
        Font.Style = []
        TextAlignment = taRightJustified
        Transparent = True
        mmHeight = 4498
        mmLeft = 184415
        mmTop = 0
        mmWidth = 18521
        BandType = 8
      end
      object ppLabel3: TppLabel
        UserName = 'lblDesconto'
        HyperlinkColor = clBlue
        Border.BorderPositions = []
        Border.Color = clBlack
        Border.Style = psSolid
        Border.Visible = False
        Border.Weight = 1.000000000000000000
        Caption = 'lblDesconto'
        Ellipsis = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Courier New'
        Font.Size = 10
        Font.Style = []
        Transparent = True
        mmHeight = 3725
        mmLeft = 2910
        mmTop = 0
        mmWidth = 23283
        BandType = 8
      end
    end
    object raCodeModule1: TraCodeModule
      ProgramStream = {
        01060D54726156617250726F6772616D094368696C645479706502110B50726F
        6772616D4E616D6506095661726961626C65730B50726F6772616D5479706507
        0B747450726F63656475726506536F75726365065C70726F6365647572652056
        61726961626C65733B0D0A7661720D0A20202020546F74616C3A446F75626C65
        3B0D0A20202020444553434F4E544F5F56414C4F523A20446F75626C653B0D0A
        0D0A626567696E0D0A0D0A656E643B0D0A0001060F5472614576656E7448616E
        646C65720B50726F6772616D4E616D6506104865616465724166746572507269
        6E740B50726F6772616D54797065070B747450726F63656475726506536F7572
        6365063A70726F6365647572652048656164657241667465725072696E743B0D
        0A626567696E0D0A202020546F74616C203A3D20303B0D0A656E643B0D0A0D43
        6F6D706F6E656E744E616D650606486561646572094576656E744E616D65060A
        41667465725072696E74074576656E74494402170001060F5472614576656E74
        48616E646C65720B50726F6772616D4E616D65060F44425465787431354F6E50
        72696E740B50726F6772616D54797065070B747450726F63656475726506536F
        75726365065870726F6365647572652044425465787431354F6E5072696E743B
        0D0A626567696E0D0A202020546F74616C203A3D20546F74616C202B20444250
        6970656C696E65315B27746F74616C6974656D275D3B0D0A656E643B0D0A0D43
        6F6D706F6E656E744E616D6506084442546578743135094576656E744E616D65
        06074F6E5072696E74074576656E74494402200001060F5472614576656E7448
        616E646C65720B50726F6772616D4E616D65060F6C626C546F74616C4F6E5072
        696E740B50726F6772616D54797065070B747450726F63656475726506536F75
        72636506B570726F636564757265206C626C546F74616C4F6E5072696E743B0D
        0A626567696E0D0A202020444553434F4E544F5F56414C4F52203A3D20284442
        506970656C696E65315B276E616A7573746570657263656E7475616C275D2F31
        3030292A546F74616C3B0D0A2020204C626C546F74616C2E43617074696F6E20
        3A3D20466F726D6174466C6F61742827232C2323302E3030272C546F74616C20
        2B20444553434F4E544F5F56414C4F52293B0D0A656E643B0D0A0D436F6D706F
        6E656E744E616D6506086C626C546F74616C094576656E744E616D6506074F6E
        5072696E74074576656E74494402200001060F5472614576656E7448616E646C
        65720B50726F6772616D4E616D6506116C626C435046434E504A4F6E5072696E
        740B50726F6772616D54797065070B747450726F63656475726506536F757263
        650C5401000070726F636564757265206C626C435046434E504A4F6E5072696E
        743B0D0A626567696E0D0A2020206966204442506970656C696E65315B276370
        665F636E706A275D203C3E202727207468656E20626567696E0D0A2020206966
        204C656E677468284442506970656C696E65315B276370665F636E706A275D29
        203D203131207468656E0D0A2020202020206C626C637066636E706A2E636170
        74696F6E203A3D2020466F726D6174537472696E6728273939392E3939392E39
        39392D39393B303B272C4442506970656C696E65315B276370665F636E706A27
        5D290D0A202020656C73650D0A2020202020206C626C637066636E706A2E6361
        7074696F6E203A3D2020466F726D6174537472696E67282739392E3939392E39
        39392F393939392D39393B303B272C204442506970656C696E65315B27637066
        5F636E706A275D293B0D0A202020656E643B0D0A656E643B0D0A0D436F6D706F
        6E656E744E616D65060A6C626C435046434E504A094576656E744E616D650607
        4F6E5072696E74074576656E74494402200001060F5472614576656E7448616E
        646C65720B50726F6772616D4E616D6506126C626C446573636F6E746F4F6E50
        72696E740B50726F6772616D54797065070B747450726F63656475726506536F
        7572636514AB01000070726F636564757265206C626C446573636F6E746F4F6E
        5072696E743B0D0A626567696E0D0A20494620444553434F4E544F5F56414C4F
        52203E20302020205448454E0D0A202020204C424C444553434F4E544F2E4341
        5054494F4E203A3D2027414352C3895343494D4F2028272B20464F524D415446
        4C4F41542827232C2323302E303025272C4442506970656C696E65315B276E61
        6A7573746570657263656E7475616C275D292B27293A2027202B20464F524D41
        54464C4F41542827232C2323302E3030272C444553434F4E544F5F56414C4F52
        290D0A20454C53450D0A202020204C424C444553434F4E544F2E43415054494F
        4E203A3D2027444553434F4E544F2028272B20464F524D4154464C4F41542827
        232C2323302E303025272C4442506970656C696E65315B276E616A7573746570
        657263656E7475616C275D292B27293A2027202B20464F524D4154464C4F4154
        2827232C2323302E3030272C444553434F4E544F5F56414C4F52293B0D0A2020
        20204C424C444553434F4E544F2E56495349424C45203A3D20444553434F4E54
        4F5F56414C4F52203C3E20300D0A656E643B0D0A0D436F6D706F6E656E744E61
        6D65060B6C626C446573636F6E746F094576656E744E616D6506074F6E507269
        6E74074576656E74494402200000}
    end
    object ppParameterList1: TppParameterList
    end
  end
  object ppDBPipeline1: TppDBPipeline
    DataSource = DataSource1
    UserName = 'DBPipeline1'
    Left = 88
    Top = 152
  end
  object ZQuery1: TZQuery
    SQL.Strings = (
      'select * '
      'from tbpedido'
      'join tbpedidoitens on tbpedidoitens.icodigo = tbpedido.icodigo'
      'join tbproduto on tbproduto.icodigo = tbpedidoitens.iproduto'
      'join tbcliente on tbcliente.icodigo = tbpedido.icliente'
      'where tbpedido.icodigo = 1')
    Params = <>
    Left = 48
    Top = 128
  end
  object DataSource1: TDataSource
    DataSet = ZQuery1
    Left = 48
    Top = 168
  end
end
