inherited frmNotaFiscal: TfrmNotaFiscal
  Left = 286
  Top = 19
  Caption = 'Emiss'#227'o de Nota Fiscal'
  ClientHeight = 398
  ClientWidth = 927
  OldCreateOrder = True
  OnShow = FormShow
  ExplicitWidth = 933
  ExplicitHeight = 426
  PixelsPerInch = 96
  TextHeight = 13
  inherited JvNavPaneToolPanel1: TJvNavPaneToolPanel
    Width = 927
    Height = 398
    ExplicitWidth = 421
    ExplicitHeight = 233
    inherited pn: TPanel
      Top = 363
      Width = 923
      TabOrder = 15
      ExplicitTop = 221
      ExplicitWidth = 417
      inherited btnGrava: TcxButton
        Left = 723
        Caption = '&Confirma'
        OnClick = btnGravaClick
        ExplicitLeft = 217
      end
      inherited btnCancela: TcxButton
        Left = 420
        Enabled = False
        Visible = False
        ExplicitLeft = -86
      end
      inherited brnDeleta: TcxButton
        Left = 622
        Enabled = False
        Visible = False
        ExplicitLeft = 116
      end
      inherited BtnSair: TcxButton
        Left = 824
        ExplicitLeft = 318
      end
      inherited btnExportar: TcxButton
        Left = 521
        ExplicitLeft = 15
      end
      inherited btnImprimir: TcxButton
        Left = 319
        ExplicitLeft = -187
      end
    end
    object RadioGroupTipo: TRadioGroup
      Left = 8
      Top = 65
      Width = 401
      Height = 35
      Caption = 'Tipo:'
      Color = 16642538
      Columns = 2
      ItemIndex = 0
      Items.Strings = (
        'Pe'#231'as'
        'Servi'#231'os')
      ParentColor = False
      TabOrder = 2
    end
    object edtCliente: TStaticText
      Left = 8
      Top = 118
      Width = 401
      Height = 21
      AutoSize = False
      BevelKind = bkFlat
      BorderStyle = sbsSingle
      Color = clBtnFace
      ParentColor = False
      TabOrder = 3
      Transparent = False
    end
    object edtDataPedido: TStaticText
      Left = 280
      Top = 42
      Width = 129
      Height = 21
      AutoSize = False
      BevelKind = bkFlat
      BorderStyle = sbsSingle
      Color = clBtnFace
      ParentColor = False
      TabOrder = 1
      Transparent = False
    end
    object Memo: TMemo
      Left = 24
      Top = 225
      Width = 17
      Height = 34
      TabOrder = 9
      Visible = False
    end
    object ButtonAssinar: TButton
      Left = 5
      Top = 177
      Width = 75
      Height = 25
      Caption = 'Assinar'
      TabOrder = 4
      OnClick = ButtonAssinarClick
    end
    object ButtonValidar: TButton
      Left = 86
      Top = 178
      Width = 75
      Height = 25
      Caption = 'Validar'
      TabOrder = 5
      OnClick = ButtonValidarClick
    end
    object ButtonEnviar: TButton
      Left = 167
      Top = 178
      Width = 75
      Height = 25
      Caption = 'Enviar'
      TabOrder = 6
      OnClick = ButtonEnviarClick
    end
    object ButtonConsultar: TButton
      Left = 250
      Top = 178
      Width = 75
      Height = 25
      Caption = 'Consultar'
      TabOrder = 7
      OnClick = ButtonConsultarClick
    end
    object ButtonImprimir: TButton
      Left = 336
      Top = 178
      Width = 75
      Height = 25
      Caption = 'Imprimir'
      TabOrder = 8
      OnClick = ButtonImprimirClick
    end
    object edtPedido: TcxTextEdit
      Tag = 13
      Left = 8
      Top = 42
      TabOrder = 0
      OnExit = edtPedidoExit
      OnKeyDown = edtPedidoKeyDown
      OnKeyPress = edtPedidoKeyPress
      Width = 81
    end
    object Label1: TcxLabel
      Left = 8
      Top = 26
      Caption = 'Pedido:'
      Transparent = True
    end
    object Label2: TcxLabel
      Left = 8
      Top = 103
      Caption = 'Cliente:'
      Transparent = True
    end
    object Label3: TcxLabel
      Left = 280
      Top = 26
      Caption = 'Data do Pedido:'
      Transparent = True
    end
    object LblUltimoPedido: TcxLabel
      Left = 8
      Top = 147
      Caption = #218'ltimo Pedido:'
      Transparent = True
    end
    object LabelStatus: TcxLabel
      Left = 91
      Top = 44
      AutoSize = False
      ParentFont = False
      Transparent = True
      Height = 17
      Width = 78
    end
    object mmLog: TcxMemo
      Left = 415
      Top = 42
      TabOrder = 16
      Height = 160
      Width = 509
    end
  end
  inherited SaveDlg: TSaveDialog
    Left = 288
    Top = 216
  end
  object ppReport: TppReport
    AutoStop = False
    DataPipeline = ppDBPipeline1
    PassSetting = psTwoPass
    PrinterSetup.BinName = 'Default'
    PrinterSetup.DocumentName = 'Or'#231'amento'
    PrinterSetup.PaperName = 'A4'
    PrinterSetup.PrinterName = 'Default'
    PrinterSetup.SaveDeviceSettings = False
    PrinterSetup.mmMarginBottom = 6350
    PrinterSetup.mmMarginLeft = 6350
    PrinterSetup.mmMarginRight = 6350
    PrinterSetup.mmMarginTop = 6350
    PrinterSetup.mmPaperHeight = 297000
    PrinterSetup.mmPaperWidth = 210000
    PrinterSetup.PaperSize = 9
    Template.FileName = 'D:\Projetos de Software\SAGE\Fonte\Rtm\Orcamento_Pedido_v2.rtm'
    AllowPrintToArchive = True
    AllowPrintToFile = True
    ArchiveFileName = '($MyDocuments)\ReportArchive.raf'
    DeviceType = 'Screen'
    DefaultFileDeviceType = 'PDF'
    EmailSettings.ReportFormat = 'PDF'
    LanguageID = 'Default'
    OutlineSettings.CreateNode = False
    OutlineSettings.CreatePageNodes = False
    OutlineSettings.Enabled = False
    OutlineSettings.Visible = False
    PDFSettings.EmbedFontOptions = [efUseSubset]
    PDFSettings.EncryptSettings.AllowCopy = True
    PDFSettings.EncryptSettings.AllowInteract = True
    PDFSettings.EncryptSettings.AllowModify = True
    PDFSettings.EncryptSettings.AllowPrint = True
    PDFSettings.EncryptSettings.Enabled = False
    PDFSettings.FontEncoding = feAnsi
    PDFSettings.ImageCompressionLevel = 25
    PreviewFormSettings.PageIncrement = 0
    PreviewFormSettings.WindowState = wsMaximized
    PreviewFormSettings.ZoomSetting = zs100Percent
    RTFSettings.DefaultFont.Charset = DEFAULT_CHARSET
    RTFSettings.DefaultFont.Color = clWindowText
    RTFSettings.DefaultFont.Height = -13
    RTFSettings.DefaultFont.Name = 'Arial'
    RTFSettings.DefaultFont.Style = []
    TextFileName = '($MyDocuments)\Report.pdf'
    TextSearchSettings.DefaultString = '<Texto a localizar>'
    TextSearchSettings.Enabled = True
    XLSSettings.AppName = 'ReportBuilder'
    XLSSettings.Author = 'ReportBuilder'
    XLSSettings.Subject = 'Report'
    XLSSettings.Title = 'Report'
    Left = 232
    Top = 32
    Version = '14.07'
    mmColumnWidth = 197300
    DataPipelineName = 'ppDBPipeline1'
    object ppHeaderBand2: TppHeaderBand
      Background.Brush.Style = bsClear
      mmBottomOffset = 0
      mmHeight = 57150
      mmPrintPosition = 0
      object ppShape4: TppShape
        UserName = 'Shape4'
        Brush.Color = clSilver
        Gradient.EndColor = clSilver
        Gradient.StartColor = clSilver
        ParentWidth = True
        mmHeight = 11642
        mmLeft = 0
        mmTop = 22490
        mmWidth = 197300
        BandType = 0
        LayerName = Foreground1
      end
      object ppShape1: TppShape
        UserName = 'Shape1'
        ParentWidth = True
        mmHeight = 22754
        mmLeft = 0
        mmTop = 0
        mmWidth = 197300
        BandType = 0
        LayerName = Foreground1
      end
      object ppImage1: TppImage
        UserName = 'Image1'
        AlignHorizontal = ahCenter
        AlignVertical = avCenter
        AutoSize = True
        MaintainAspectRatio = False
        Stretch = True
        Transparent = True
        Picture.Data = {
          0B546478504E47496D61676589504E470D0A1A0A0000000D4948445200000050
          00000070080600000089BDF79B000000206348524D00007A25000080830000F9
          FF000080E9000075300000EA6000003A980000176F925FC54600000009704859
          7300000F5E00000F5E0105CD382D00001BDB49444154785EED9D7B7057D5B5C7
          BDADD77AAFBD576F7B2F16B4AD56AC8F5B141FA020A208777868C1FAA8205AC4
          02E53160D102E5118840096F088410421202214002E1F123EF07796D02212124
          2180A0953AED14A733ED4CAB4EFFE9C85D9FFD3B2B6E8EBF5F1242A824F09D59
          73CEF99D73F6E37BD65E6BEDC739BFEBCACBCBB7949595658A04548C31810307
          0E64555454249E3B77AED37597097FFCE31F7B485E696EFEA5A5A58DB26AD52A
          2BDBB76F0F646666060A0A0A02454545942D505C5CDC789DDEDB9CE8F5070F1E
          0C48BD3325BDB4868686FBBDE2B40E9270B62466548064D278FCF1C71FF7F72E
          6D53C883B9E3C89123E92525258D79B24F9E870E1D32BB77EF3673E7CE351B36
          6CB0FB393939A6B0B0D00881F63A847BDCB236277ABDA6535A5A6E8E5655A555
          55554DA8ABAB7B5C14E6DFBCE2B51C52769E4A63066E8614F2CC9933CBBD4BDB
          0CA74E9DFA8FA3478FAE53C2C817B8FB4B962C31F3E7CF37DBB66D338140A091
          40D1BC561388ECDFBFDF6CDEBCD96CD9B2C5ECCED86DB233336D9A82A29AEA9A
          2421738C946F686565E5B7BDE2360D9A03776B065A20C0BE6843D9679F7DF6A2
          77F925E3F7BFFFFDED42DE22973CDD22870F1F3629292966FAF4E9263636D6EC
          DCB9D36467671B696E974C201A979F9F6F357ADBF66D96C8E4E4642133C564EC
          CC3099FB21B3C4B6002150C8ACF9996866B7B367CFDEE815FFCB90C25A02819B
          991E53D0FAFAFAB2BFFDED6FE3CE9F3FFFAFDE6D170DB9F7FADFFDEE77CF5657
          57EFD4CA6B1E8063B14D9624C85BB46891494D4D357BF7EE6DD43E6D7A4AE0C5
          9318BC16292A2E32B9B9B966CF9E3D56CB2D994989F6E1F1D0C8938725F76589
          A9592BDBFFF5AA722130D2DC00EBE10A42429CFFE8A38FE6FFE94F7FFAA19011
          FE893890EBBE26F2BDBFFCE52F3F3E71E2C472D2A2D24A98A6CFBE62E1C285E6
          EDB7DF36090909263D3DDD88F3B0155502439117AEDC7E71AF77A558D2823025
          13AD4C4A4E12ADDCE969BC94AFB474A457AD0B111F1F1F58BE7CB9B50D688016
          CC9FB9165A543BFBFDF7DF8F1352267EF2C927FDFEFEF7BFDFF1F9E79F7711B9
          DD93CEF2DB5D7FFEF39F9F15B2A34E9E3CB90762F47E374DF2E13720E99A152B
          5698F1E3C71B79A8262D2DCD9649C9739B2EA29577D3BB18D1FBAD906669304D
          F2C9CECE3181BD019B2FBFB13D7CF0F0EB1E6517429E72202626C61A6D6C0D24
          721399007FC614DE536D2306B75C9AF73E216997909A210E2743346DE7B163C7
          F663CBF47A847D4D577FE71870EDDAB56BCDE8D1A34D545454D0C07B9E3794ED
          D37B35ADD608F7DB34C42EEABE8A9657152A2B2BEB80D4A99F47D985D8B76F5F
          00B5450B693E783CADBCC266E4CBD8AD8C568E6D281B05FCF7239805F242E35E
          7BED3513191969929292AC0D52ED83407F9A6EDA9AAE3F6D3DE71E730F84B9F7
          A8E8F59A36E4011E5E5656E6565194FFF228BB10F29403186A0C3624CE9933C7
          EE53391271136F8DB8F7EA3EA0C952B859B36699E1C3875BF2D4EE419E3A8E70
          E421CD958BF35C07C4F39B4A795840EFD76B4A3DE7E2FE4EFD01E5C8CBCB9B8A
          3DF728BB10E2D689F2AD015512A74D9B66ED111A8086004DF862C5AD24FBA487
          D04C69B290B760C10293989868C9D3988F7003F2FC4DD71537ED70C27590515F
          576FC4BC9886FA064B26BF71BE546C9FDD8AA35012C1A183725E8E8583626905
          033CBABE0C3919A0B0D83F25117B0489784362312A21AEBC914CB780CD094093
          D13809616C1EA4FBECB3CF9AB163C7DA0786D7D366ABE4A9DD5302A99C2BA108
          F483F380724318C44953B4448ADD966D904CCE733F6922DA7C8BA40C529E1D52
          EEFFF6E8FA3208A4B133681B85A782D2F7B41A8166E015274C986056AF5E6DCF
          012513D166EE82DF218CEBD8923ECD73F2E4C996B8975F7ED936DD75EBD6D9B8
          0B87E19277299AC779B64AF4A143C172F25BB057B3D796A9B6B6D648906CA42F
          6C098558D5CC208107A52CB9C80C69195FF7E8FA322090A78D50782A41653232
          32AC36E2A167CF9E6D9BDB8811232CA1D82B08C676728F5B682A8E3653589CC3
          942953CCF3CF3F6F9E79E619BB45FBF81D6741A8C2435187A1E5688A3CA42902
          55B806E843248FBE7DFB9ADEBD7B9B2993A7D83E367942584D6D8D2553898470
          9093955522640EF4A80A0D292C231BF6A95378D54632A472D825B4242E2ECE6A
          E4C48913CD4B2FBD64060E1C6865E8D0A19698E79E7BCEEEA3619045419F78E2
          097B3C66CC183B30101D1D6D9B2B1ACE03220FC8E621906F73E4A956A98422CD
          DD421C0221F4ABBBDC769BB9E5965BCCADB7DE6ABADE7DB72D3F0F343E3E4826
          64436475F5519B86F8869D12AA75F6A80A0DB9D0124801D9AA166893A692681A
          364AA374EC22B66BDEBC79B6003471EC198286F21B5ABB78F162ABC1682B0F81
          87A11A47DA8812A7CDD625904A34252E792E71DC8B66A9A9A1FC3CC8010306E4
          0D1B362CFEC1871EDC7BDF7DF7993BEEB8C3DCDDB5ABE9F1E8A366983CFCE962
          F71312134CBED71AC4FB4688FD6BBAFB2A9906B4C0145E3511A172DAACF1D44A
          26DA0319104A3347F0AA084471CC399A28C4431ADE5589739BAB8A4B1CE21215
          4EFCE4897B6B3CC66169D882C9A15544CC9AF5A23CF41BC414DDFB13C1C30F3F
          FCABEE0F76DFD1AD5B3773EFBDF71A48EDD9B3A7915328489990FFBC47537848
          C68D04227E1211974815C850811C4852A2942C159A29F7908E6A9C4A530EC325
          0B710943005BCEE93E3F57561EB604A27DA9F240878F1869DE7AEBADA494E8E8
          FFF4AAADF85A8F1E3DBE3364C89041FDFBF78F1093B3EBA1EE0F99BBA5798BED
          0E48B96FF7AE0B0FC9DC8E07AA50702AE412C9369466A249BA5562D957E11CA2
          C4693A2AE1885371CB85B8E4B9A2E7D8425A4D4D8DDD528677DE79C7FC7CCC98
          42711A83BD2A878444065F1F3468D0EDD2CC87F6E9DB779968EA2C69653778A7
          C34332FD1281AE6845FDA43627A134ADA5C42194C54F945FB4CCBA4FF8515323
          719D380EB042BCFDB871E3706011D293F817AFCACD62D4A851374A47A265A3D3
          92F10504AA84AA14E227D33DD6DFFCBF874A472554DE2A7EC2C209D7421EB11D
          8E83FD24715C93264D323367FE3A5D1CD9F7BDEAB63D24F39004AA84AAB42B2E
          51A1C80A4760A8BC42899F28BF9016E768B2472A835E1707472430F597538B37
          6DDAF4B257D5CB0329C42511184E42DDEFA6DB1271C90B25A4C9161381032342
          900E848D12E88AC6C5C62D125B167A10A0AD2005FDA710E8A6D994F8496A4A80
          DE87034B4B0F0EC282BCBC8292AAAA8A9E5E352F1F24F3161118EA5C73422543
          FDAE122A5D3F49E1C4BD16704CB844F3CDC9C9A60752565D5DF913AF9A970F4C
          38FB0BA6E256B03544B6E69E50E22F9B5B5E05FBE485060649CC3115151579B5
          B5C79BEECB5E2A4211A85B57948CE6C47FDFA58ABF5C4A961F7A1D731B7BBCAE
          6741618125F1F8F1E3A187E3DB02E108D47D572E07414D8996817C01618A8E96
          70CE0FFD0DCF8F53D9BD3BC31415168977AECC7AAFE1BD3E5E95DB164D11D81A
          710970A5A9737E694C8B07561EEC5DD4D7379806218FD112E450887148A0BF11
          8B6AF7B24808ADAEAEDA77F6ECD9C7BD6AB71DA4C09640C093D6C23725FECABA
          95F68B7BAD5F38AFF0DFE36A1DE3747575B5C1018223958D241E3C189CB770E1
          A64978C3602D2496941493D69E3FFCE10FDDBDAAB70DD0406D9A6E259A123F09
          4DDDEB5EDB12B1652929B5643578039C3535B5560B19EDC14930720C810C8436
          05F2A74BB97F7F708ED70EEB1F3BB63C2D2DEDE217118583143040F7472BEB56
          3E9CB815D663FF352AEEB5E1441F20A02C0CB337349CB0DA0759549EB147869C
          860C1922CEA13038BFD1101C8657D085435C901E830B6C2170FBF6EDA522A127
          C95B0379920112C6F052897024F88F55429D77C5BDD62F7A8DD50C2182A67AC2
          23AE468EB17FB17171E6C5175FB4434C0C8076EFDE7DC7BBEFBE9BC57DDC03D9
          5C6B21AD57096473B45A34D59BEB4083933727DB7537ABD7AC8EF0AA7FE9C8CD
          CDB5D39A3C657FC5749FAD6A896E8312B4377ABD8A6B12BEB8F6CBC747C49E31
          CD189C8B10224453A82CE7180C6084BB67CFC7CC8F7EF423D3AB57AFB2818307
          4F7AFDF5D7BF1D1111F144C2C68DB9929CBDFEA4DC4F93571C3CC4A84C8D6DFE
          9C078C8AD33F967B37A5A6A6F6F2AA7FE910F202049D545A2BE81201285CB5D7
          04809E535142745F7FD774F41E84F380F368BD750C872BADE03999A96302ABD7
          638F99071EE866E7565EFAE94FD74F9D3AF582582E2A2A6AC0A64D9BF2D1AC5A
          71303C84C39206C0E170ACE4310521F73336F81BC1FF7849B40D2090414F9708
          ADA856B6B6B6CE9C3A75CA9B4B956626629B993C65D51A57F80D23AF1570D305
          6CC98F0787E673BC6CC9123B29F59810F7D0430F99679EE9675E78E185F8575E
          7965F0B871E3FEDD2BEE0558B870E1E06DDBB6154022F9A1716C837957DB3C56
          4747ABE62D153BFA2DEFD6B643565616EB8E6D664AA212C831C0AE30BBA585C4
          EE402672EAE4A9A008C1A7BCDF9464EEF1A7194C57B6223A520D017366CF16E2
          1E363D7AF4C8EFDBB7EF2C69BE03264E9CF84DAF9861B178F1E2E18CC268F9EA
          EAEAAD56A3DDACAE600A73C1C2852B65BFEDC903A2058D618C92A8C78836DBFD
          81809D30426B8A8B8A2DA914142DAB9530439F7CAD681F1E4FA1E9202E8908DA
          A7043209357BF69CDC050B16F4F68AD6220851B7ECD8B62336333BD3E64B7948
          77715494993C658A59B3664D8C34F5EF7897B73DA4F97E31A92495B2E21D0325
          8A30E29E7BEE31F7DF7FBFE9D7EF1933F4B9A1767E187BC5B4E6A44993EDF0F9
          F0E1AF3081D3783FF013C81641F3311FFCC644D4FAB8B85D1F7CF0C145BF1590
          BF37BF8B90B411E2486F7E64A42D434242C20679E04DCFEB5E2A5899A0846945
          751F40200B705896017977DE7967F16DB7DD36A3F36D9D7FF9F8E38FEFECDCA5
          F3AE6FDCF88D9DD75F7F7DDA0D37DC9073F3CD375B1B86A6A259C09FBE4B2013
          3F9CA3F2C9C9C9E5A241C3BDA25D1412B6267C3F2131319907CD6A08F1B431A2
          91DFF54E5F3E48852C8154A8B1A2DE4A25C8A30933B24148C1E4F4881123121F
          79E4113BD92C85ED2446FFD64E9D3ADD7AD34D37751A3C787037E9298C4D4F4F
          FF8590B387D1613F81E403D8729C9B9F6BED1560C582103ADA16AC15888E8EBE
          4BCA94B064C9A2F19266B3F6B34D2019D90155A991AD9056D605CB3A20F0F5D7
          5E67C2395AEEB9DEBB3D2CA4D9AFB0E90AD822AA794009A4C9A17D803E6B5ADA
          AE57BD245A8555AB56DD220F30FC62A0B68654A25103DD8AA27934C1C2A2C2C6
          555A537F39B57463D2C61F7BB7360921F0797D104A9C8A827DB55B80669F9D9D
          3B4FEE6DF5DB00FF7448B9BF70229E002590D18CD9B36699B724108D8898BB79
          C3860D377BB736092161A03064D352F8C943D40E8292A212939999BD6B774141
          CB5E72B91220315D80C017B2A44A8D0462FF404242A299316386ED43AE5CBE72
          7A4B27A8DFAB7FEF81431515C1191E0F7E02D176F2CBC9959E90B752342B272B
          3D2F2FEFB2BD9FD7E690D82D60036209844F48804C1C05991058585068962D5B
          2604FEDA2C98BFA04C6C618B87C66986151515319015F4E4413BAB200F8DDB00
          443278505458542CDA3FD44BE6CA47415181752254864058FB908CF8F22E9910
          6766CF9963962D5DB62D23634B8B35A3F86CF18D924E3CE4402084912E3D0586
          AA4E9E94DE8AD76B61FD323D0904D321A1D5282F992B1F8C07DA662406BC4034
          8E21212A0B5896CBAA7D622BE990CF916D8B27A9D3CFA77FFDF8F11373F4E140
          145D3D4B98D767AD391A341DBC29C440296B0FC953F6DFBC98B52C5F2984B8C0
          FBEF9FE1352EA94C703D3364EED9BBC7C4AC8BB1CB715928298169F895EA6170
          B0B272209A1CD43C567E565B6DCC2F2C907065BB5D778D7DA537438CD9B3670F
          D3F7E9BEC5D26F9D2BCEAA7D78E27EFDFA05C68C79D36AC63FFEF10FF3D7BFFE
          D57CF8E18796C4ED6969267D67BA5D2829B1DF646962DF6E490CA8A8ADAD1D88
          76334F1B171B67224593C78E1D6797044BBE254F3FFD74719F3E4F6CEDDDBB77
          D4ABAFBEBA54E48D4183063D2E61D377DB8D068E1C3932C0D347E33EFFFCF346
          F9E4934FAD616731F6BA987534AD322132E950E5A1259999FB5E888A8A0AFDE6
          8E03714E9D45CBE60D1B3634EFC927FB963FF5D453654256469F3E7D163CFAD8
          A3D27119FC84F4A7EFA46723E6A1F9B5785722A64DFB55E08D37DEB0133668A0
          1278EEDCC71293EDB7EB4DF6ECDE63CF4326B64AB665111111F16217473517F5
          43CCC8913FED3160D080FE6FBFFD767FB1A9F76957B04320323232307EC20413
          1DBDDA7CF6D9A7963C88AC3F516F9B1E2412EC32CB5F585864B273B21B17988B
          6D5C376EDCB88E43466B101B1313983777AE898959CBF7112C819F7E1A6CBE10
          48378B7DBA7478D49D6213712A0B7FB3B05C3AEFA1DFA1BD9AB07DFBF6C0E6CD
          5BEC626CB48BB0E270E561FBBEAC9DD517EDE33578711E96C8E4E4241315B518
          EF5C9E9292F2A497CCD58BB56BD7069874613287B02228C11762F0C490565414
          9CF2CCCF2FB0E7D1C0D8B8B8ADF2DBE51F6FBBD251909F6F2795E88F42586676
          B61D40608458B58E11133AFCACBF637A90D870EFDEDDCBFDA1C6A64D9B6E5CBA
          74E95DED26866B0B88167D6934C6150657D140E643366C88331919C10F325455
          55ED966ED7035E32D7415A724AF25BD16BD766AE5FBFFEE7ED268EBB544020CD
          B39130D977457F474B09AA1344030969D04A39BFADA6A666C2B163C7C60AC191
          1BE2E2CAF85083F45ACA1213935FBB98AE5FBB8590107689AF4E30D963D1449A
          3444A6A46C31F1F1F1F6F52FCE31E41F9F906867EE4AE41A34744B4A4A8990DA
          7E46555A0B21A0E926AC647AC79088E0A1B1872AEA7082E7D9CABDC5A5A92B57
          AE1C357DE6CCB112F25CBE55A25F252050490A272E99BA8FE0685253534CAE90
          673F1DE25DC3BB6A0CD26E96A63E71E2243B4B3673E6CC97BC2C3B16A4C24D12
          A864B1AFA3C8AEE828B35EC7880BE4D1C4794F58C82B9350E992268AAE680809
          174D205B15F77786AD18AE5AB56AB51DA29A3A752AC176FB191C6D0DA4E2CD36
          61BFB8045A110DC406E260B08D8CF1CD9933BB4CE2C6715E361D17428875224A
          8EBBEF8A92E507BF958AF081063B312E24D225CC2BC82B3C7EFCF85D5E361D17
          424E238190C13EFDDF601F38D813E15C535092712AF46298D790FB4A24BD8B1E
          C56E778040FF977B10EDBE31C4CF315ED6AF811C5B0DF4EEE51E6242B67CB8E6
          F0E1C3EBCE9D3B779397954593DFE26B8FA8ACAC0C300283F1B74479DAC43E1A
          886D43D048F7BC4B1ED07B187065BD9E4ECC7FF0C107734F9F3EFDA41CF7913C
          46D7D5D6C649CF65AAC81D5E11DA37860C79AE60D8B06176F90624BA44022585
          81046DD2EE792512E1773436F85E86686441A1BD372D2DAD3C7EE3C672421B7E
          67F2AAAAAA668A5784F68D2E5DBA4475EDDA75F49B6FBEF9A868CA63757575FD
          2B2A2AEC572615DAF34013699E9C435CF2540399A2E45A86FFD7AE8DB19F3DE1
          BB2C5B366FB65FF3E07E086C6868D82C7279568D7ED53875EA54370986AD7381
          1C8006E220B08B6E73F61388148827D60FEB10DAA8E6EEDF9F69BD344D5B62C6
          2CD936FF558CF68A8F3EFAE811A9A08D11010430C48FA7458BDCE6AC042A892E
          B17A0DA413DE648B1643E09123477285C4C6E1B00E8993274F8E5532005AC51C
          B1EB549430153E1927370409E43D12D9F24E5B6565701D0CBFE360D8AFAFAFEF
          1876301C7EFBDBDF7E4FB465B712C897CF180BA439FBB51028D9843C38235623
          E84A7E08530793989494B32B2323A5B6B6B655CB79DB15A4A9CD5402737373EC
          D015610AB6CD1F6C2B811C4330A0D92F5BB6AC4C243D32323262F2E4C9C3962E
          5DDA5D1EC44D67CE9CF986974DC7455555D50C8840A32005EF4AB0ACCDD84F20
          83B0C525C1F81127327DFA34F3CEB46905E28DBB5F35C3FC2EAAABABAD064260
          6E6EBE9DBD533BE86FC62AFC8686E2B197AF584E2853B06FDFBEAE5E92571784
          C05FA1591088EDE31B800C1AF863423F81D83B484463939393F37372F6DEE325
          79F5409CC8CD120FC6A181784E9A2E539AC1251F999624D71B23900D8190CB77
          F8B099727D81D8D2AB8F40E929DC2FBD9242488140BA624CAC43A47AE25004AA
          6D444BE98508D9791F7EF8E1E5FB7ED5958ACACACA294248B93A10BE76CE3B23
          F448B4098723D02E4692BE305FCEC8CBCB2D919066E299BABADB593BED25DFB1
          C1A7CFA5E9E6420A4B7489FF5891C596DE080EC26F0375620902B98EE64BDCC7
          F121E97D1C3F7E7CCFD9B367174B57F111D1D06F4AD3FEE7BD1073B970FAF4E9
          07FD1591D0A51F1FAC419B54FBE6CD8BB4AF8F62FFB233BFF87F8F0B0894EB11
          9A2F210C6F60B29A213636CE12CA6FCCD815161414E6E666C7C8FDB77A59B65F
          1C3870609FC86CD1B2A1D2FF1D2A4D6D8E847DD6EE69FC077173E7CEB30B8EDC
          E60B512E81564A835B3D07D10109BC2150BDF7860DF13C88DF7488E62C4D318B
          E64865210B8FABE4E13888FB78E39B155C681F5AA4CDB72902AD38E70BA5194B
          EF38D8954B4C2A15223BC6AA0521CB7E7807D2A828FBBCAFC1312B519914C7F3
          D21CB17DAEF37009E47A5623801327F9504E9D7D00A4C7B57C3D88FD2D5B1817
          DCB65FBC78C718CAE2C33B549A21260410A630350979345FC84373085D42699F
          928F00FE7A87097656FE43A4A64B73F6BC78FB7AA1B029402084304080D7C4D3
          F2063A2FD8D07C953C0267250F8D52C25C020123D223468EB4CD5E9CD16A09C4
          37D4D6D696F0C926421AE999E46EDDBAB56D3FBFF45542080BF0D5715E2644F8
          6835C3F0187DB579AEE6F9C95381C4A3476B2CE9BD7AF732F3E7CF9FC9688B68
          DACDE2A07A575655456465652D4D4D4D7DCAEFF5DB35D6AC5913E0EF2FBC3EAB
          D5389A301AA95AA7218BDFEE217A4CACC8B5E3C78F2F1F3E7CF83C69FA177C9F
          EAFCF9F35FEB50C429C41E05084D68A690A61A87B36030C025CF254E05CD0BDA
          B88376666FD4E8D16BF90EB3977CC707DF8D812C040D724973B5CEAF792A5C03
          79C478381EE9EEADB82A56A62A84ACC6FF13F11317AAC9BA82F6A1B129A92956
          6B253C311B376E2C154D9E2AF7B5F89DBA760D3E7BE292A5848522CE0D57F498
          7F08CCC8D86D6D27BF41283654D29DD8216D9E1F4254934B7C1BC5238FD991A3
          BCB62A41B29EE3153046A9F1DAC4809E06F30D985F48FA1DDB1E3645A0AB712C
          61C359101833C3C62A54C82C91DE07E70BA5F9A7A4A44AACB7C77A6420F71748
          D3EED84BDC5AA28110C76BF97C31122D4B4A4ACAACAE3E520C917A0D2640ED27
          2FEDAC5FBFFE80C83049BF63DB426CA04B96AB7556E3EAEBEDABFABC6C23C46D
          95F8EE67D263F9819C7F4134AD987E33D7D2CFE5BB7D78F1254B96162F5EBCF8
          052F8B8E0DE9F0DBFFC10CC6725F2C96C423337A221A64962F5B66264D9CC407
          BD2EF82AB868E022B49026CBF70471204B972D2D114FDC711795FBD1D0D090C7
          472020C08E9C08614102837F0144FF78F8F01166F41B6FF09FBF43BCDB2C4E9F
          3EFD03E9AA6D410B5938B43A3A3A579CC96B57D5FCAFD8AC97848031A2895BD5
          8ED124AD2D1302F9F4C90CE923F339B9D875EB564A97EF82511421FE87A2B849
          D2779E9FB6756B37EFE7AB0FC78E1D9B6609148140F6D12A48B46FA847CE63A0
          20D64F20A8A8A8F8963897F6F9CD83B68284276F411A0281D8BEE0284C8EFDB7
          E7152B96D39CF748BFF987DE2DD7E0429AE2046DBAAC6DD1FD7CB185F42C1808
          95FE2EC3FF0F7AB75C830BF1A66FE23C004132DF75AEC3B11C3C589695955D2A
          1E76AF34D3CBF38F081D0112B68C14EEE87EE54948B3B5ACAC6C91C864D1C2FF
          93E6FCB4389A97AFAA51968B853888FB76ECD835646F5ADAFDB1B1B19DAE9175
          0DD7700DD7700D4DE3BAEBFE1FFBDF5D202DE87C120000000049454E44AE4260
          82}
        mmHeight = 21431
        mmLeft = 529
        mmTop = 529
        mmWidth = 14288
        BandType = 0
        LayerName = Foreground1
      end
      object ppDBText11: TppDBText
        UserName = 'DBText11'
        DataField = 'srazaosocial'
        DataPipeline = ppDBPipeline1
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Calibri'
        Font.Size = 15
        Font.Style = [fsBold]
        ParentDataPipeline = False
        Transparent = True
        DataPipelineName = 'ppDBPipeline1'
        mmHeight = 6350
        mmLeft = 11906
        mmTop = 3704
        mmWidth = 173302
        BandType = 0
        LayerName = Foreground1
      end
      object ppVariable3: TppVariable
        UserName = 'Variable3'
        AutoSize = False
        BlankWhenZero = False
        CalcOrder = 0
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Calibri'
        Font.Size = 9
        Font.Style = []
        Transparent = True
        mmHeight = 3969
        mmLeft = 11906
        mmTop = 10319
        mmWidth = 173302
        BandType = 0
        LayerName = Foreground1
      end
      object ppLabel10: TppLabel
        UserName = 'Label10'
        Caption = 'FONE:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Calibri'
        Font.Size = 9
        Font.Style = []
        Transparent = True
        mmHeight = 3852
        mmLeft = 11906
        mmTop = 14552
        mmWidth = 7959
        BandType = 0
        LayerName = Foreground1
      end
      object ppDBText19: TppDBText
        UserName = 'DBText19'
        AutoSize = True
        DataField = 'sfoneempresa'
        DataPipeline = ppDBPipeline1
        DisplayFormat = '!\(99\)\ 0000\-0000;0; '
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Calibri'
        Font.Size = 9
        Font.Style = []
        ParentDataPipeline = False
        Transparent = True
        DataPipelineName = 'ppDBPipeline1'
        mmHeight = 3852
        mmLeft = 20373
        mmTop = 14552
        mmWidth = 19727
        BandType = 0
        LayerName = Foreground1
      end
      object ppLabel12: TppLabel
        UserName = 'Label101'
        Caption = 'E-MAIL:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Calibri'
        Font.Size = 9
        Font.Style = []
        Transparent = True
        mmHeight = 3852
        mmLeft = 44450
        mmTop = 14552
        mmWidth = 10033
        BandType = 0
        LayerName = Foreground1
      end
      object ppDBText21: TppDBText
        UserName = 'DBText21'
        DataField = 'semailempresa'
        DataPipeline = ppDBPipeline1
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Calibri'
        Font.Size = 9
        Font.Style = []
        ParentDataPipeline = False
        Transparent = True
        DataPipelineName = 'ppDBPipeline1'
        mmHeight = 3852
        mmLeft = 54769
        mmTop = 14552
        mmWidth = 115623
        BandType = 0
        LayerName = Foreground1
      end
      object ppShape5: TppShape
        UserName = 'Shape5'
        ParentWidth = True
        mmHeight = 18256
        mmLeft = 0
        mmTop = 33867
        mmWidth = 197300
        BandType = 0
        LayerName = Foreground1
      end
      object ppLabel13: TppLabel
        UserName = 'Label13'
        AutoSize = False
        Caption = 'CLIENTE:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Calibri'
        Font.Size = 10
        Font.Style = [fsBold]
        TextAlignment = taRightJustified
        Transparent = True
        mmHeight = 4276
        mmLeft = 2910
        mmTop = 36248
        mmWidth = 12700
        BandType = 0
        LayerName = Foreground1
      end
      object ppDBText23: TppDBText
        UserName = 'DBText23'
        DataField = 'nome'
        DataPipeline = ppDBPipeline1
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Calibri'
        Font.Size = 10
        Font.Style = [fsBold]
        ParentDataPipeline = False
        Transparent = True
        DataPipelineName = 'ppDBPipeline1'
        mmHeight = 4233
        mmLeft = 16404
        mmTop = 36248
        mmWidth = 94721
        BandType = 0
        LayerName = Foreground1
      end
      object ppVariable4: TppVariable
        UserName = 'Variable4'
        AutoSize = False
        BlankWhenZero = False
        CalcOrder = 1
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Calibri'
        Font.Size = 10
        Font.Style = [fsBold]
        Transparent = True
        mmHeight = 4233
        mmLeft = 16404
        mmTop = 41010
        mmWidth = 94721
        BandType = 0
        LayerName = Foreground1
      end
      object ppLabel14: TppLabel
        UserName = 'Label14'
        AutoSize = False
        Caption = 'END.:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Calibri'
        Font.Size = 10
        Font.Style = [fsBold]
        TextAlignment = taRightJustified
        Transparent = True
        mmHeight = 4276
        mmLeft = 2910
        mmTop = 41010
        mmWidth = 12700
        BandType = 0
        LayerName = Foreground1
      end
      object ppLabel8: TppLabel
        UserName = 'Label8'
        AutoSize = False
        Caption = 'TEL.:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Calibri'
        Font.Size = 10
        Font.Style = [fsBold]
        TextAlignment = taRightJustified
        Transparent = True
        mmHeight = 4233
        mmLeft = 2910
        mmTop = 45508
        mmWidth = 12700
        BandType = 0
        LayerName = Foreground1
      end
      object ppDBText18: TppDBText
        UserName = 'DBText18'
        AutoSize = True
        DataField = 'sfone'
        DataPipeline = ppDBPipeline1
        DisplayFormat = '!\(99\)\ 0000\-0000;0; '
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Calibri'
        Font.Size = 10
        Font.Style = [fsBold]
        ParentDataPipeline = False
        Transparent = True
        DataPipelineName = 'ppDBPipeline1'
        mmHeight = 4276
        mmLeft = 16404
        mmTop = 45508
        mmWidth = 21844
        BandType = 0
        LayerName = Foreground1
      end
      object ppLabel9: TppLabel
        UserName = 'Label9'
        AutoSize = False
        Caption = 'CPF - CNPJ:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Calibri'
        Font.Size = 10
        Font.Style = [fsBold]
        TextAlignment = taRightJustified
        Transparent = True
        mmHeight = 4233
        mmLeft = 112448
        mmTop = 36248
        mmWidth = 20638
        BandType = 0
        LayerName = Foreground1
      end
      object ppDBText22: TppDBText
        UserName = 'DBText22'
        DataField = 'cpf_cnpj'
        DataPipeline = ppDBPipeline1
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Calibri'
        Font.Size = 10
        Font.Style = [fsBold]
        ParentDataPipeline = False
        Transparent = True
        DataPipelineName = 'ppDBPipeline1'
        mmHeight = 4233
        mmLeft = 133615
        mmTop = 36248
        mmWidth = 47890
        BandType = 0
        LayerName = Foreground1
      end
      object ppLabel15: TppLabel
        UserName = 'Label15'
        AutoSize = False
        Caption = 'CIDADE - UF:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Calibri'
        Font.Size = 10
        Font.Style = [fsBold]
        TextAlignment = taRightJustified
        Transparent = True
        mmHeight = 4233
        mmLeft = 112448
        mmTop = 41010
        mmWidth = 20638
        BandType = 0
        LayerName = Foreground1
      end
      object ppVariable2: TppVariable
        UserName = 'Variable2'
        AutoSize = False
        BlankWhenZero = False
        CalcOrder = 2
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Calibri'
        Font.Size = 10
        Font.Style = [fsBold]
        Transparent = True
        mmHeight = 4233
        mmLeft = 133615
        mmTop = 41010
        mmWidth = 61648
        BandType = 0
        LayerName = Foreground1
      end
      object ppShape6: TppShape
        UserName = 'Shape6'
        Brush.Color = clSilver
        Gradient.EndColor = clSilver
        Gradient.StartColor = clSilver
        Gradient.Style = gsHorizontal
        ParentWidth = True
        mmHeight = 5556
        mmLeft = 0
        mmTop = 51858
        mmWidth = 197300
        BandType = 0
        LayerName = Foreground1
      end
      object ppLabel17: TppLabel
        UserName = 'Label17'
        AutoSize = False
        Caption = 'PRODUTO'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Calibri'
        Font.Size = 8
        Font.Style = [fsBold]
        Transparent = True
        mmHeight = 3471
        mmLeft = 2910
        mmTop = 52652
        mmWidth = 93398
        BandType = 0
        LayerName = Foreground1
      end
      object ppLabel18: TppLabel
        UserName = 'Label18'
        AutoSize = False
        Caption = 'MARCA'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Calibri'
        Font.Size = 8
        Font.Style = [fsBold]
        Transparent = True
        mmHeight = 3471
        mmLeft = 97896
        mmTop = 52652
        mmWidth = 31221
        BandType = 0
        LayerName = Foreground1
      end
      object ppLabel16: TppLabel
        UserName = 'Label16'
        AutoSize = False
        Caption = 'QTD.'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Calibri'
        Font.Size = 8
        Font.Style = [fsBold]
        TextAlignment = taRightJustified
        Transparent = True
        mmHeight = 3471
        mmLeft = 130704
        mmTop = 52652
        mmWidth = 20902
        BandType = 0
        LayerName = Foreground1
      end
      object ppLabel19: TppLabel
        UserName = 'Label19'
        AutoSize = False
        Caption = 'VL. UNIT.'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Calibri'
        Font.Size = 8
        Font.Style = [fsBold]
        TextAlignment = taRightJustified
        Transparent = True
        mmHeight = 3471
        mmLeft = 152929
        mmTop = 52652
        mmWidth = 20902
        BandType = 0
        LayerName = Foreground1
      end
      object ppLabel20: TppLabel
        UserName = 'Label20'
        AutoSize = False
        Caption = 'TOTAL'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Calibri'
        Font.Size = 8
        Font.Style = [fsBold]
        TextAlignment = taRightJustified
        Transparent = True
        mmHeight = 3471
        mmLeft = 174890
        mmTop = 52652
        mmWidth = 20902
        BandType = 0
        LayerName = Foreground1
      end
      object ppLabel11: TppLabel
        UserName = 'Label11'
        AutoSize = False
        Caption = 'DATA:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Calibri'
        Font.Size = 10
        Font.Style = [fsBold]
        TextAlignment = taRightJustified
        Transparent = True
        mmHeight = 4233
        mmLeft = 112448
        mmTop = 45508
        mmWidth = 20638
        BandType = 0
        LayerName = Foreground1
      end
      object ppDBText30: TppDBText
        UserName = 'DBText30'
        DataField = 'ddatapedido'
        DataPipeline = ppDBPipeline1
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Calibri'
        Font.Size = 10
        Font.Style = [fsBold]
        ParentDataPipeline = False
        Transparent = True
        DataPipelineName = 'ppDBPipeline1'
        mmHeight = 4233
        mmLeft = 133615
        mmTop = 45508
        mmWidth = 47361
        BandType = 0
        LayerName = Foreground1
      end
      object ppVariable5: TppVariable
        UserName = 'Variable5'
        BlankWhenZero = False
        CalcOrder = 3
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Calibri'
        Font.Size = 18
        Font.Style = [fsBold]
        Transparent = True
        mmHeight = 7747
        mmLeft = 2910
        mmTop = 24606
        mmWidth = 24934
        BandType = 0
        LayerName = Foreground1
      end
    end
    object ppDetailBand2: TppDetailBand
      Background1.Brush.Style = bsClear
      Background2.Brush.Style = bsClear
      PrintCount = 45
      mmBottomOffset = 0
      mmHeight = 5027
      mmPrintPosition = 0
      object ppShape2: TppShape
        UserName = 'Shape2'
        ParentWidth = True
        mmHeight = 5292
        mmLeft = 0
        mmTop = 0
        mmWidth = 197300
        BandType = 4
        LayerName = Foreground1
      end
      object ppDBText24: TppDBText
        UserName = 'DBText24'
        DataField = 'icodigo'
        DataPipeline = ppDBPipeline1
        DisplayFormat = '0000000'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Calibri'
        Font.Size = 8
        Font.Style = []
        ParentDataPipeline = False
        Transparent = True
        DataPipelineName = 'ppDBPipeline1'
        mmHeight = 3471
        mmLeft = 2910
        mmTop = 529
        mmWidth = 13758
        BandType = 4
        LayerName = Foreground1
      end
      object ppDBText25: TppDBText
        UserName = 'DBText25'
        DataField = 'sdescricao'
        DataPipeline = ppDBPipeline1
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Calibri'
        Font.Size = 8
        Font.Style = []
        ParentDataPipeline = False
        Transparent = True
        DataPipelineName = 'ppDBPipeline1'
        mmHeight = 3471
        mmLeft = 18785
        mmTop = 529
        mmWidth = 77523
        BandType = 4
        LayerName = Foreground1
      end
      object ppDBText26: TppDBText
        UserName = 'DBText26'
        DataField = 'marca'
        DataPipeline = ppDBPipeline1
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Calibri'
        Font.Size = 8
        Font.Style = []
        ParentDataPipeline = False
        Transparent = True
        DataPipelineName = 'ppDBPipeline1'
        mmHeight = 3471
        mmLeft = 97896
        mmTop = 529
        mmWidth = 31221
        BandType = 4
        LayerName = Foreground1
      end
      object ppDBText27: TppDBText
        UserName = 'DBText27'
        DataField = 'nquantidade'
        DataPipeline = ppDBPipeline1
        DisplayFormat = '#,0.00;-#,0.00'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Calibri'
        Font.Size = 8
        Font.Style = []
        ParentDataPipeline = False
        TextAlignment = taRightJustified
        Transparent = True
        DataPipelineName = 'ppDBPipeline1'
        mmHeight = 3471
        mmLeft = 130704
        mmTop = 529
        mmWidth = 20902
        BandType = 4
        LayerName = Foreground1
      end
      object ppDBText28: TppDBText
        UserName = 'DBText28'
        DataField = 'nvalor'
        DataPipeline = ppDBPipeline1
        DisplayFormat = '#,0.00;(#,0.00)'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Calibri'
        Font.Size = 8
        Font.Style = []
        ParentDataPipeline = False
        TextAlignment = taRightJustified
        Transparent = True
        DataPipelineName = 'ppDBPipeline1'
        mmHeight = 3471
        mmLeft = 152929
        mmTop = 529
        mmWidth = 20902
        BandType = 4
        LayerName = Foreground1
      end
      object ppDBText29: TppDBText
        UserName = 'DBText29'
        DataField = 'totalitem'
        DataPipeline = ppDBPipeline1
        DisplayFormat = '#,0.00;(#,0.00)'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Calibri'
        Font.Size = 8
        Font.Style = []
        ParentDataPipeline = False
        TextAlignment = taRightJustified
        Transparent = True
        DataPipelineName = 'ppDBPipeline1'
        mmHeight = 3471
        mmLeft = 174890
        mmTop = 529
        mmWidth = 20902
        BandType = 4
        LayerName = Foreground1
      end
    end
    object ppFooterBand2: TppFooterBand
      Background.Brush.Style = bsClear
      mmBottomOffset = 0
      mmHeight = 9790
      mmPrintPosition = 0
      object ppShape8: TppShape
        UserName = 'Shape8'
        ParentWidth = True
        StretchWithParent = True
        mmHeight = 9790
        mmLeft = 0
        mmTop = 0
        mmWidth = 197300
        BandType = 8
        LayerName = Foreground1
      end
      object ppLabel24: TppLabel
        UserName = 'Label24'
        Caption = 'SAGE - Sistema de Automa'#231#227'o e Gerenciamento de Empresas'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Calibri'
        Font.Size = 9
        Font.Style = [fsBold]
        Transparent = True
        mmHeight = 3969
        mmLeft = 2910
        mmTop = 794
        mmWidth = 83608
        BandType = 8
        LayerName = Foreground1
      end
      object ppSystemVariable1: TppSystemVariable
        UserName = 'SystemVariable1'
        VarType = vtDateTime
        DisplayFormat = #39'Emitido em: '#39' dd/mm/yyyy h:nn:ss'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Calibri'
        Font.Size = 9
        Font.Style = [fsBold]
        TextAlignment = taRightJustified
        Transparent = True
        mmHeight = 3969
        mmLeft = 147373
        mmTop = 794
        mmWidth = 48419
        BandType = 8
        LayerName = Foreground1
      end
      object ppLabel25: TppLabel
        UserName = 'Label25'
        Caption = 'sage.sis@uol.com.br'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Calibri'
        Font.Size = 9
        Font.Style = [fsBold]
        Transparent = True
        mmHeight = 3852
        mmLeft = 2910
        mmTop = 5027
        mmWidth = 27178
        BandType = 8
        LayerName = Foreground1
      end
      object ppLabel26: TppLabel
        UserName = 'Label26'
        Caption = '(65) 9229-1443 / (65) 9299-4654'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Calibri'
        Font.Size = 9
        Font.Style = [fsBold]
        Transparent = True
        mmHeight = 3969
        mmLeft = 31221
        mmTop = 4763
        mmWidth = 55298
        BandType = 8
        LayerName = Foreground1
      end
      object ppSystemVariable2: TppSystemVariable
        UserName = 'SystemVariable2'
        VarType = vtPageSetDesc
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Calibri'
        Font.Size = 9
        Font.Style = [fsBold]
        TextAlignment = taRightJustified
        Transparent = True
        mmHeight = 3852
        mmLeft = 177821
        mmTop = 4763
        mmWidth = 17441
        BandType = 8
        LayerName = Foreground1
      end
    end
    object ppSummaryBand1: TppSummaryBand
      Background.Brush.Style = bsClear
      mmBottomOffset = 0
      mmHeight = 76200
      mmPrintPosition = 0
      object ppShape7: TppShape
        UserName = 'Shape7'
        Brush.Color = clSilver
        ParentWidth = True
        StretchWithParent = True
        mmHeight = 15346
        mmLeft = 0
        mmTop = 0
        mmWidth = 197300
        BandType = 7
        LayerName = Foreground1
      end
      object ppLabel21: TppLabel
        UserName = 'Label21'
        Caption = 'QTD. ITENS:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Calibri'
        Font.Size = 10
        Font.Style = [fsBold]
        TextAlignment = taRightJustified
        Transparent = True
        mmHeight = 4276
        mmLeft = 156073
        mmTop = 5821
        mmWidth = 17230
        BandType = 7
        LayerName = Foreground1
      end
      object ppLabel22: TppLabel
        UserName = 'Label22'
        Caption = 'TOTAL:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Calibri'
        Font.Size = 10
        Font.Style = [fsBold]
        TextAlignment = taRightJustified
        Transparent = True
        mmHeight = 4276
        mmLeft = 163354
        mmTop = 10319
        mmWidth = 9948
        BandType = 7
        LayerName = Foreground1
      end
      object ppDBCalc2: TppDBCalc
        UserName = 'DBCalc2'
        DataField = 'totalitem'
        DataPipeline = ppDBPipeline1
        DisplayFormat = '$#,0.00;($#,0.00)'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Calibri'
        Font.Size = 10
        Font.Style = [fsBold]
        ParentDataPipeline = False
        TextAlignment = taRightJustified
        Transparent = True
        DataPipelineName = 'ppDBPipeline1'
        mmHeight = 4233
        mmLeft = 174890
        mmTop = 10319
        mmWidth = 20902
        BandType = 7
        LayerName = Foreground1
      end
      object ppDBCalc1: TppDBCalc
        UserName = 'DBCalc1'
        DataField = 'icodigo'
        DataPipeline = ppDBPipeline1
        DisplayFormat = '0'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Calibri'
        Font.Size = 10
        Font.Style = [fsBold]
        ParentDataPipeline = False
        TextAlignment = taRightJustified
        Transparent = True
        DBCalcType = dcCount
        DataPipelineName = 'ppDBPipeline1'
        mmHeight = 4233
        mmLeft = 174890
        mmTop = 5821
        mmWidth = 20902
        BandType = 7
        LayerName = Foreground1
      end
      object ppShape3: TppShape
        UserName = 'Shape3'
        ParentWidth = True
        StretchWithParent = True
        mmHeight = 61119
        mmLeft = 0
        mmTop = 15081
        mmWidth = 197300
        BandType = 7
        LayerName = Foreground1
      end
      object ppLabel23: TppLabel
        UserName = 'Label23'
        Caption = 'Observa'#231#227'o:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Calibri'
        Font.Size = 9
        Font.Style = [fsBold]
        Transparent = True
        mmHeight = 3969
        mmLeft = 2910
        mmTop = 15610
        mmWidth = 16404
        BandType = 7
        LayerName = Foreground1
      end
      object ppVariable6: TppVariable
        UserName = 'Variable6'
        BlankWhenZero = True
        CalcOrder = 0
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Calibri'
        Font.Size = 9
        Font.Style = []
        Transparent = True
        mmHeight = 3969
        mmLeft = 2910
        mmTop = 38894
        mmWidth = 192352
        BandType = 7
        LayerName = Foreground1
      end
      object ppDBMemo1: TppDBMemo
        UserName = 'DBMemo1'
        ForceJustifyLastLine = True
        CharWrap = False
        DataField = 'sobservacao'
        DataPipeline = ppDBPipeline1
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Calibri'
        Font.Size = 9
        Font.Style = []
        ParentDataPipeline = False
        Transparent = True
        DataPipelineName = 'ppDBPipeline1'
        mmHeight = 18785
        mmLeft = 2910
        mmTop = 19844
        mmWidth = 192352
        BandType = 7
        LayerName = Foreground1
        mmBottomOffset = 0
        mmOverFlowOffset = 0
        mmStopPosition = 0
        mmMinHeight = 0
        mmLeading = 0
      end
      object ppVariable7: TppVariable
        UserName = 'Variable7'
        BlankWhenZero = True
        CalcOrder = 1
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Calibri'
        Font.Size = 9
        Font.Style = []
        Transparent = True
        mmHeight = 3969
        mmLeft = 2910
        mmTop = 43392
        mmWidth = 192352
        BandType = 7
        LayerName = Foreground1
      end
      object ppLine1: TppLine
        UserName = 'Line1'
        Weight = 0.750000000000000000
        mmHeight = 3969
        mmLeft = 6350
        mmTop = 64823
        mmWidth = 84138
        BandType = 7
        LayerName = Foreground1
      end
      object ppVariable8: TppVariable
        UserName = 'Variable8'
        AutoSize = False
        BlankWhenZero = False
        CalcOrder = 2
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Calibri'
        Font.Size = 8
        Font.Style = [fsBold]
        TextAlignment = taCentered
        Transparent = True
        mmHeight = 3440
        mmLeft = 6350
        mmTop = 65881
        mmWidth = 83608
        BandType = 7
        LayerName = Foreground1
      end
      object ppLine4: TppLine
        UserName = 'Line4'
        Weight = 0.750000000000000000
        mmHeight = 3969
        mmLeft = 106363
        mmTop = 64823
        mmWidth = 84138
        BandType = 7
        LayerName = Foreground1
      end
      object ppLabel1: TppLabel
        UserName = 'Label1'
        AutoSize = False
        Caption = 'Ass. Cliente'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Calibri'
        Font.Size = 8
        Font.Style = [fsBold]
        TextAlignment = taCentered
        Transparent = True
        mmHeight = 3440
        mmLeft = 106363
        mmTop = 65881
        mmWidth = 84138
        BandType = 7
        LayerName = Foreground1
      end
    end
    object raCodeModule2: TraCodeModule
      ProgramStream = {
        01060F5472614576656E7448616E646C65720B50726F6772616D4E616D65060F
        5661726961626C65334F6E43616C630B50726F6772616D54797065070B747450
        726F63656475726506536F7572636506DA70726F636564757265205661726961
        626C65334F6E43616C63287661722056616C75653A2056617269616E74293B0D
        0A626567696E0D0A0D0A202056616C7565203A3D204442506970656C696E6531
        5B2773656E64657265636F656D7072657361275D202B2027202D2027202B2044
        42506970656C696E65315B277362616972726F656D7072657361275D202B2027
        202D2027202B204442506970656C696E65315B2773636964616465656D70275D
        202B2027202D2027202B204442506970656C696E65315B27737566656D70275D
        3B0D0A0D0A656E643B0D0A0D436F6D706F6E656E744E616D6506095661726961
        626C6533094576656E744E616D6506064F6E43616C63074576656E7449440221
        0001060F5472614576656E7448616E646C65720B50726F6772616D4E616D6506
        0F5661726961626C65344F6E43616C630B50726F6772616D54797065070B7474
        50726F63656475726506536F75726365068770726F6365647572652056617269
        61626C65344F6E43616C63287661722056616C75653A2056617269616E74293B
        0D0A626567696E0D0A0D0A202056616C7565203A3D204442506970656C696E65
        315B2773656E64657265636F275D202B2027202D20272B4442506970656C696E
        65315B277362616972726F275D3B200D0A0D0A656E643B0D0A0D436F6D706F6E
        656E744E616D6506095661726961626C6534094576656E744E616D6506064F6E
        43616C63074576656E74494402210001060F5472614576656E7448616E646C65
        720B50726F6772616D4E616D65060F5661726961626C65324F6E43616C630B50
        726F6772616D54797065070B747450726F63656475726506536F75726365067D
        70726F636564757265205661726961626C65324F6E43616C6328766172205661
        6C75653A2056617269616E74293B0D0A626567696E0D0A0D0A202056616C7565
        203A3D204442506970656C696E65315B27636964616465275D2B27202D20272B
        4442506970656C696E65315B27737566275D3B0D0A0D0A656E643B0D0A0D436F
        6D706F6E656E744E616D6506095661726961626C6532094576656E744E616D65
        06064F6E43616C63074576656E74494402210001060F5472614576656E744861
        6E646C65720B50726F6772616D4E616D65060F5661726961626C65364F6E4361
        6C630B50726F6772616D54797065070B747450726F63656475726506536F7572
        636506F270726F636564757265205661726961626C65364F6E43616C63287661
        722056616C75653A2056617269616E74293B0D0A626567696E0D0A0D0A202069
        6620285472696D284442506970656C696E65315B2773706C616361275D29203C
        3E2027272920616E6420285472696D284442506970656C696E65315B2773706C
        616361275D29203C3E20272D2729207468656E20202020202020202020202020
        20200D0A2020202056616C7565203A3D2027504C4143413A20272B4442506970
        656C696E65315B2773706C616361275D0D0A2020656C73650D0A202020205661
        6C7565203A3D2027273B20200D0A0D0A656E643B0D0A0D436F6D706F6E656E74
        4E616D6506095661726961626C6536094576656E744E616D6506064F6E43616C
        63074576656E74494402210001060F5472614576656E7448616E646C65720B50
        726F6772616D4E616D65060F5661726961626C65374F6E43616C630B50726F67
        72616D54797065070B747450726F63656475726506536F7572636514D0000000
        70726F636564757265205661726961626C65374F6E43616C6328766172205661
        6C75653A2056617269616E74293B0D0A626567696E0D0A0D0A0D0A2020696620
        5472696D284442506970656C696E65315B277376656963756C6F275D29203C3E
        202727207468656E2020202020202020202020202020200D0A2020202056616C
        7565203A3D20275645C38D43554C4F3A20272B4442506970656C696E65315B27
        7376656963756C6F275D0D0A2020656C73650D0A2020202056616C7565203A3D
        2027273B20200D0A0D0A656E643B0D0A0D436F6D706F6E656E744E616D650609
        5661726961626C6537094576656E744E616D6506064F6E43616C63074576656E
        74494402210001060F5472614576656E7448616E646C65720B50726F6772616D
        4E616D65060F5661726961626C65354F6E43616C630B50726F6772616D547970
        65070B747450726F63656475726506536F75726365147900000070726F636564
        757265205661726961626C65354F6E43616C63287661722056616C75653A2056
        617269616E74293B0D0A626567696E0D0A0D0A202056616C7565203A3D20274F
        72C3A7616D656E746F204E2EC2BA2027202B4442506970656C696E65315B2750
        656469646F275D3B200D0A0D0A656E643B0D0A0D436F6D706F6E656E744E616D
        6506095661726961626C6535094576656E744E616D6506064F6E43616C630745
        76656E74494402210001060F5472614576656E7448616E646C65720B50726F67
        72616D4E616D65060F5661726961626C65384F6E43616C630B50726F6772616D
        54797065070B747450726F63656475726506536F7572636514BA00000070726F
        636564757265205661726961626C65384F6E43616C63287661722056616C7565
        3A2056617269616E74293B0D0A626567696E0D0A0D0A202056616C7565203A3D
        202753616D756361204175746F20456CC3A97472696361272B2027202D20434E
        504A3A2027202B20466F726D61744D61736B5465787428272139392E3939392E
        3939392F393939392D30303B303B272C4442506970656C696E65315B2773636E
        706A656D7072657361275D293B0D0A0D0A656E643B0D0A0D436F6D706F6E656E
        744E616D6506095661726961626C6538094576656E744E616D6506064F6E4361
        6C63074576656E74494402210000}
    end
    object ppDesignLayers2: TppDesignLayers
      object ppDesignLayer2: TppDesignLayer
        UserName = 'Foreground1'
        LayerType = ltBanded
        Index = 0
      end
    end
    object ppParameterList1: TppParameterList
    end
  end
  object DataSource1: TDataSource
    DataSet = ZQuery1
    Left = 72
    Top = 328
  end
  object ppDBPipeline1: TppDBPipeline
    DataSource = DataSource1
    UserName = 'DBPipeline1'
    Left = 129
    Top = 216
  end
  object ZQuery1: TZQuery
    Params = <>
    Left = 72
    Top = 216
  end
  object Query: TZQuery
    Params = <>
    Left = 72
    Top = 272
  end
end
