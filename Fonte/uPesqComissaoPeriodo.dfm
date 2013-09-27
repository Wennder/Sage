inherited frmPesqComissaoPeriodo: TfrmPesqComissaoPeriodo
  Left = 207
  Caption = 'Comiss'#227'o por per'#237'odo'
  ClientHeight = 505
  ClientWidth = 859
  OldCreateOrder = True
  OnDeactivate = FormDeactivate
  OnShow = FormShow
  ExplicitWidth = 865
  ExplicitHeight = 533
  PixelsPerInch = 96
  TextHeight = 13
  inherited JvNavPaneToolPanel1: TJvNavPaneToolPanel
    Width = 859
    Height = 505
    ExplicitTop = -1
    ExplicitWidth = 776
    ExplicitHeight = 464
    inherited pn: TPanel
      Top = 470
      Width = 855
      TabOrder = 5
      ExplicitLeft = 3
      ExplicitTop = 469
      ExplicitWidth = 855
      inherited btnGrava: TcxButton
        Left = 427
        Visible = False
        ExplicitLeft = 518
      end
      inherited btnCancela: TcxButton
        Left = 599
        Visible = False
        ExplicitLeft = 604
      end
      inherited brnDeleta: TcxButton
        Left = 685
        Visible = False
        ExplicitLeft = 690
      end
      inherited BtnSair: TcxButton
        Left = 771
        ExplicitLeft = 776
      end
      inherited btnExportar: TcxButton
        Left = 513
        Enabled = True
        Visible = True
        OnClick = btnExportarClick
        ExplicitLeft = 427
      end
    end
    object edtTecnicoNome: TStaticText
      Left = 49
      Top = 48
      Width = 432
      Height = 20
      AutoSize = False
      BevelKind = bkFlat
      BorderStyle = sbsSingle
      Color = clBtnFace
      ParentColor = False
      TabOrder = 1
      Transparent = False
    end
    object btnPesquisar: TcxButton
      Left = 712
      Top = 45
      Width = 26
      Height = 26
      OptionsImage.Glyph.Data = {
        36090000424D3609000000000000360000002800000018000000180000000100
        20000000000000090000000000000000000000000000000000003C9F00FF3C9F
        00FF3C9F00FF3C9F00FF3C9F00FF3C9F00FF3C9F00FF3C9F00FF3C9F00FF3C9F
        00FF3C9F00FF3C9F00FF3C9F00FF3C9F00FF3C9F00FF3C9F00FF3C9F00FF3C9F
        00FF3C9F00FF3C9F00FF3C9F00FF3C9F00FF3C9F00FF3C9F00FF3C9F00FF3C9F
        00FF3C9F00FF3C9F00FF3C9F00FF3C9F00FF3C9F00FF3C9F00FF3C9F00FF3C9F
        00FF3C9F00FF3C9F00FF3C9F00FF3C9F00FF3C9F00FF3C9F00FF3C9F00FF3C9F
        00FF3C9F00FF3C9F00FF3C9F00FF3C9F00FF3C9F00FF3C9F00FF3C9F00FF3C9F
        00FF3C9F00FF3C9F00FF3B9F00FF3A9E00FF3B9F00FF3C9F00FF3C9F00FF3C9F
        00FF3C9F00FF3C9F00FF3C9F00FF3C9F00FF3C9F00FF3C9F00FF3C9F00FF3C9F
        00FF3C9F00FF3C9F00FF3C9F00FF3C9F00FF3C9F00FF3C9F00FF3C9F00FF3C9F
        00FF3C9F00FF3C9F00FF40A106FF49A514FF3FA005FF3B9F00FF3C9F00FF3C9F
        00FF3C9F00FF3C9F00FF3C9F00FF3C9F00FF3C9F00FF3C9F00FF3C9F00FF3C9F
        00FF3C9F00FF3C9F00FF3C9F00FF3C9F00FF3C9F00FF3C9F00FF3C9F00FF3C9F
        00FF3B9F00FF3EA105FF7FC057FFBFDFABFF85C360FF42A20AFF3B9E00FF3C9F
        00FF3C9F00FF3C9F00FF3C9F00FF3C9F00FF3C9F00FF3C9F00FF3C9F00FF3C9F
        00FF3C9F00FF3C9F00FF3C9F00FF3C9F00FF3C9F00FF3C9F00FF3C9F00FF3C9F
        00FF3B9E00FF43A20BFFAED795FFFFFFFFFFE9F4E2FF89C566FF41A209FF3B9F
        00FF3C9F00FF3C9F00FF3C9F00FF3C9F00FF3C9F00FF3C9F00FF3C9F00FF3C9F
        00FF3C9F00FF3C9F00FF3C9F00FF3C9F00FF3C9F00FF3C9F00FF3C9F00FF3C9F
        00FF3C9F00FF3C9F01FF6EB742FFD7EBCAFFFFFFFFFFEAF4E3FF8BC668FF41A1
        08FF3B9F00FF3C9F00FF3C9F00FF3C9F00FF3C9F00FF3C9F00FF3C9F00FF3C9F
        00FF3C9F00FF3C9F00FF3C9F00FF3C9F00FF3C9F00FF3C9F00FF3C9F00FF3C9F
        00FF3C9F00FF3B9F00FF3D9F03FF70B845FFD8ECCCFFFFFFFFFFEAF4E3FF89C4
        66FF42A20AFF3B9E00FF3C9F00FF3C9F00FF3C9F00FF3C9F00FF3C9F00FF3C9F
        00FF3C9F00FF3C9F00FF3C9F00FF3C9F00FF3C9F00FF3C9F00FF3C9F00FF3C9F
        00FF3C9F00FF3C9F00FF3C9F00FF3C9F02FF71B946FFD8ECCCFFFFFFFFFFE8F4
        E2FF88C564FF3FA106FF3B9E00FF3FA106FF41A209FF3EA005FF3B9E00FF3B9E
        00FF3C9F00FF3C9F00FF3C9F00FF3C9F00FF3C9F00FF3C9F00FF3C9F00FF3C9F
        00FF3C9F00FF3C9F00FF3C9F00FF3C9F00FF3C9F01FF70B945FFD7ECCAFFFFFF
        FFFFE0F0D6FF78BD4FFF7CBE54FFA5D38AFFB2D99AFFA0D083FF75BB4AFF48A5
        12FF3B9E00FF3C9F00FF3C9F00FF3C9F00FF3C9F00FF3C9F00FF3C9F00FF3C9F
        00FF3C9F00FF3C9F00FF3C9F00FF3C9F00FF3B9F00FF3D9F03FF6FB843FFCBE6
        BCFFF5FAF1FFE5F2DCFFF1F8ECFFF3F9EFFFEBF5E5FFF5FAF2FFECF6E6FFADD7
        94FF54AA20FF3B9E00FF3C9F00FF3C9F00FF3C9F00FF3C9F00FF3C9F00FF3C9F
        00FF3C9F00FF3C9F00FF3C9F00FF3C9F00FF3C9F00FF3C9F00FF3B9F02FF6DB7
        41FFE1F0D8FFFAFCF9FFBCDEA8FF7DBF55FF6BB63EFF84C25EFFCAE5B9FFF6FA
        F3FFAED795FF49A512FF3B9E00FF3C9F00FF3C9F00FF3C9F00FF3C9F00FF3C9F
        00FF3C9F00FF3C9F00FF3C9F00FF3C9F00FF3C9F00FF3C9F00FF3C9F02FF8BC6
        68FFF3F9F0FFB4DA9EFF4DA718FF3A9E00FF399E00FF3A9E01FF59AD26FFC8E3
        B7FFEDF6E7FF7ABD51FF3A9E00FF3C9F00FF3C9F00FF3C9F00FF3C9F00FF3C9F
        00FF3C9F00FF3C9F00FF3C9F00FF3C9F00FF3C9F00FF3C9F00FF45A30CFFBDDF
        A9FFE9F4E2FF6DB740FF3A9E00FF3C9F00FF3C9F00FF3C9F00FF3B9E00FF80C0
        5AFFF4FAF0FFA5D389FF40A107FF3B9F00FF3C9F00FF3C9F00FF3C9F00FF3C9F
        00FF3C9F00FF3C9F00FF3C9F00FF3C9F00FF3C9F00FF3C9F00FF4BA614FFCFE8
        C1FFD7EBCBFF57AD25FF3A9E00FF3C9F00FF3C9F00FF3C9F00FF3B9E00FF65B3
        37FFEFF7EAFFB6DB9FFF44A30DFF3B9E00FF3C9F00FF3C9F00FF3C9F00FF3C9F
        00FF3C9F00FF3C9F00FF3C9F00FF3C9F00FF3C9F00FF3C9F00FF47A40FFFC4E2
        B2FFE3F1DAFF64B334FF3A9E00FF3C9F00FF3C9F00FF3C9F00FF3A9E00FF76BC
        4CFFF3F9EFFFACD692FF41A109FF3B9E00FF3C9F00FF3C9F00FF3C9F00FF3C9F
        00FF3C9F00FF3C9F00FF3C9F00FF3C9F00FF3C9F00FF3C9F00FF3EA004FF9ACE
        7BFFF6FBF2FFA0D183FF43A20BFF3B9E00FF3B9F00FF3A9E00FF4BA615FFB5DB
        9FFFF1F8EDFF86C461FF3B9E01FF3B9F00FF3C9F00FF3C9F00FF3C9F00FF3C9F
        00FF3C9F00FF3C9F00FF3C9F00FF3C9F00FF3C9F00FF3C9F00FF3A9E00FF5FB1
        2FFFD4EAC7FFEFF8EAFF9DCF81FF5FB02FFF50A91BFF65B338FFADD795FFF3FA
        F0FFC4E2B2FF52AA1EFF3A9E00FF3C9F00FF3C9F00FF3C9F00FF3C9F00FF3C9F
        00FF3C9F00FF3C9F00FF3C9F00FF3C9F00FF3C9F00FF3C9F00FF3C9F00FF3DA0
        02FF74BB4AFFD4EAC8FFF6FBF3FFE7F3DFFFDAEDCFFFEBF5E4FFF4FAF1FFC8E4
        B8FF64B335FF3C9E00FF3C9F00FF3C9F00FF3C9F00FF3C9F00FF3C9F00FF3C9F
        00FF3C9F00FF3C9F00FF3C9F00FF3C9F00FF3C9F00FF3C9F00FF3C9F00FF3B9F
        00FF3DA003FF60B130FF9ECF81FFC5E3B3FFCFE8C1FFC0E0ADFF94CB74FF57AD
        26FF3C9F01FF3C9F00FF3C9F00FF3C9F00FF3C9F00FF3C9F00FF3C9F00FF3C9F
        00FF3C9F00FF3C9F00FF3C9F00FF3C9F00FF3C9F00FF3C9F00FF3C9F00FF3C9F
        00FF3C9F00FF3A9E00FF40A006FF4CA718FF53AA1FFF4AA615FF3EA003FF3A9E
        00FF3C9F00FF3C9F00FF3C9F00FF3C9F00FF3C9F00FF3C9F00FF3C9F00FF3C9F
        00FF3C9F00FF3C9F00FF3C9F00FF3C9F00FF3C9F00FF3C9F00FF3C9F00FF3C9F
        00FF3C9F00FF3C9F00FF3B9F00FF3A9E00FF3A9E00FF3A9E00FF3B9F00FF3C9F
        00FF3C9F00FF3C9F00FF3C9F00FF3C9F00FF3C9F00FF3C9F00FF3C9F00FF3C9F
        00FF3C9F00FF3C9F00FF3C9F00FF3C9F00FF3C9F00FF3C9F00FF3C9F00FF3C9F
        00FF3C9F00FF3C9F00FF3C9F00FF3C9F00FF3C9F00FF3C9F00FF3C9F00FF3C9F
        00FF3C9F00FF3C9F00FF3C9F00FF3C9F00FF3C9F00FF3C9F00FF3C9F00FF3C9F
        00FF3C9F00FF3C9F00FF3C9F00FF3C9F00FF3C9F00FF3C9F00FF3C9F00FF3C9F
        00FF3C9F00FF3C9F00FF3C9F00FF3C9F00FF3C9F00FF3C9F00FF3C9F00FF3C9F
        00FF3C9F00FF3C9F00FF3C9F00FF3C9F00FF3C9F00FF3C9F00FF}
      OptionsImage.Spacing = 3
      TabOrder = 4
      WordWrap = True
      OnClick = btnPesquisarClick
    end
    object edtTecnico: TcxTextEdit
      Tag = 7
      Left = 8
      Top = 48
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
      Left = 8
      Top = 32
      Caption = 'T'#233'cnico:'
      Transparent = True
    end
    object Label2: TcxLabel
      Left = 484
      Top = 32
      Caption = 'Per'#237'odo:'
      Transparent = True
    end
    object Label3: TcxLabel
      Left = 592
      Top = 48
      Caption = #224
      Transparent = True
    end
    object edtDataInicio: TcxDateEdit
      Left = 484
      Top = 48
      TabOrder = 2
      Width = 105
    end
    object edtDataFinal: TcxDateEdit
      Left = 605
      Top = 48
      TabOrder = 3
      Width = 105
    end
  end
  object cxGrid1: TcxGrid [1]
    Left = 0
    Top = 75
    Width = 858
    Height = 392
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
    object cxGrid1DBTableView1: TcxGridDBTableView
      Navigator.Buttons.CustomButtons = <>
      DataController.DataSource = DataSource
      DataController.Options = [dcoAssignGroupingValues, dcoAssignMasterDetailKeys, dcoSaveExpanding, dcoSortByDisplayText]
      DataController.Summary.DefaultGroupSummaryItems = <
        item
          Format = '#,##0.00'
          Kind = skSum
          Position = spFooter
          Column = cxGrid1DBTableView1nvalorservico
        end
        item
          Format = '#,##0.00'
          Kind = skSum
          Position = spFooter
          Column = cxGrid1DBTableView1nvalorcomissao
        end
        item
          Format = '#,##0.00'
          Kind = skSum
          Position = spFooter
          Column = cxGrid1DBTableView1ntotalpedido
        end>
      DataController.Summary.FooterSummaryItems = <
        item
          Format = '#,##0.00'
          Kind = skSum
          FieldName = 'nvalorservico'
          Column = cxGrid1DBTableView1nvalorservico
        end
        item
          Format = '#,##0.00'
          Kind = skSum
          FieldName = 'nvalorcomissao'
          Column = cxGrid1DBTableView1nvalorcomissao
        end
        item
          Format = '#,##0.00'
          Kind = skSum
          FieldName = 'ntotalpedido'
          Column = cxGrid1DBTableView1ntotalpedido
        end>
      DataController.Summary.SummaryGroups = <>
      OptionsData.CancelOnExit = False
      OptionsData.Deleting = False
      OptionsData.DeletingConfirmation = False
      OptionsData.Editing = False
      OptionsData.Inserting = False
      OptionsSelection.CellSelect = False
      OptionsView.Footer = True
      OptionsView.GroupFooters = gfAlwaysVisible
      object cxGrid1DBTableView1tecnico: TcxGridDBColumn
        Caption = 'T'#233'cnico'
        DataBinding.FieldName = 'tecnico'
        Visible = False
        GroupIndex = 0
        Width = 253
      end
      object cxGrid1DBTableView1ipedido: TcxGridDBColumn
        Caption = 'Pedido'
        DataBinding.FieldName = 'ipedido'
        Width = 57
      end
      object cxGrid1DBTableView1ddatapedido: TcxGridDBColumn
        Caption = 'Data Pedido'
        DataBinding.FieldName = 'ddatapedido'
        Width = 68
      end
      object cxGrid1DBTableView1ntotalpedido: TcxGridDBColumn
        Caption = 'Total Pedido'
        DataBinding.FieldName = 'ntotalpedido'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        HeaderAlignmentHorz = taRightJustify
        Width = 76
      end
      object cxGrid1DBTableView1sveiculo: TcxGridDBColumn
        DataBinding.FieldName = 'sveiculo'
        Visible = False
      end
      object cxGrid1DBTableView1splaca: TcxGridDBColumn
        DataBinding.FieldName = 'splaca'
        Visible = False
      end
      object cxGrid1DBTableView1ncomissao: TcxGridDBColumn
        Caption = '% Comiss'#227'o'
        DataBinding.FieldName = 'ncomissao'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00;-0.00'
        HeaderAlignmentHorz = taRightJustify
        HeaderGlyphAlignmentHorz = taRightJustify
      end
      object cxGrid1DBTableView1nvalorservico: TcxGridDBColumn
        Caption = 'Vl. Servi'#231'o'
        DataBinding.FieldName = 'nvalorservico'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        HeaderAlignmentHorz = taRightJustify
        Width = 70
      end
      object cxGrid1DBTableView1nvalorcomissao: TcxGridDBColumn
        Caption = 'Vl. Comiss'#227'o'
        DataBinding.FieldName = 'nvalorcomissao'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        HeaderAlignmentHorz = taRightJustify
        Width = 84
      end
      object cxGrid1DBTableView1servico: TcxGridDBColumn
        Caption = 'Servi'#231'o'
        DataBinding.FieldName = 'servico'
        Width = 206
      end
      object cxGrid1DBTableView1cliente: TcxGridDBColumn
        Caption = 'Cliente'
        DataBinding.FieldName = 'cliente'
        Width = 188
      end
    end
    object cxGrid1Level1: TcxGridLevel
      GridView = cxGrid1DBTableView1
    end
  end
  object ZQuery: TZQuery [2]
    SQL.Strings = (
      'select '
      
        'cast(tbservicotecnico.itecnico as varchar(100)) || '#39' - '#39' || tbpe' +
        'ssoa.snome as Tecnico, tbservicotecnico.ipedido, tbpedido.ddatap' +
        'edido,'
      
        'tbpedido.ntotalprodutos + tbpedido.najustevalor as ntotalpedido,' +
        ' tbpedido.sveiculo, tbpedido.splaca,'
      
        'cast(coalesce(tbpedido.icliente, 0) as varchar(100)) || '#39' - '#39' ||' +
        ' coalesce(tbpessoacliente.snome, tbconsumidor.snome,'#39'CONSUMIDOR'#39 +
        ') as cliente,'
      
        'cast(tbservicotecnico.iservico as varchar(100)) || '#39' - '#39' || tbpr' +
        'oduto.sdescricao as Servico, tbservicotecnico.ncomissao, tbservi' +
        'cotecnico.nvalorservico, tbservicotecnico.nvalorcomissao'
      'from tbservicotecnico'
      'join tbpedido on tbpedido.icodigo = tbservicotecnico.ipedido'
      
        'join tbcomissionado on tbcomissionado.icodigo = tbservicotecnico' +
        '.itecnico'
      'join tbpessoa on tbpessoa.icodigo = tbcomissionado.icodigo'
      'join tbproduto on tbproduto.icodigo = tbservicotecnico.iservico'
      
        'left outer join tbcliente on tbcliente.icodigo = tbpedido.iclien' +
        'te'
      
        'left outer join tbpessoa as tbpessoacliente on tbpessoacliente.i' +
        'codigo = tbcliente.icodigo'
      
        'left outer join tbconsumidor on tbconsumidor.ipedido = tbpedido.' +
        'icodigo'
      
        'where tbpedido.sstatus = '#39'A'#39' and tbcomissionado.sstatus = '#39'A'#39' an' +
        'd tbproduto.sstatus = '#39'A'#39
      
        'order by tbservicotecnico.itecnico, tbpedido.ddatapedido, tbserv' +
        'icotecnico.ipedido, tbservicotecnico.nvalorcomissao')
    Params = <>
    Properties.Strings = (
      'select '
      
        'cast(tbservicotecnico.itecnico as varchar(100)) || '#39' - '#39' || tbpe' +
        'ssoa.snome as Tecnico, tbservicotecnico.ipedido, tbpedido.ddatap' +
        'edido,'
      
        'tbpedido.ntotalprodutos + tbpedido.najustevalor as ntotalpedido,' +
        ' tbpedido.sveiculo, tbpedido.splaca,'
      
        'cast(coalesce(tbpedido.icliente, 0) as varchar(100)) || '#39' - '#39' ||' +
        ' coalesce(tbpessoacliente.snome, tbconsumidor.snome,'#39'CONSUMIDOR'#39 +
        ') as cliente,'
      
        'cast(tbservicotecnico.iservico as varchar(100)) || '#39' - '#39' || tbpr' +
        'oduto.sdescricao as Servico, tbservicotecnico.ncomissao, tbservi' +
        'cotecnico.nvalorservico, tbservicotecnico.nvalorcomissao'
      'from tbservicotecnico'
      'join tbpedido on tbpedido.icodigo = tbservicotecnico.ipedido'
      
        'join tbcomissionado on tbcomissionado.icodigo = tbservicotecnico' +
        '.itecnico'
      'join tbpessoa on tbpessoa.icodigo = tbcomissionado.icodigo'
      'join tbproduto on tbproduto.icodigo = tbservicotecnico.iservico'
      
        'left outer join tbcliente on tbcliente.icodigo = tbpedido.iclien' +
        'te'
      
        'left outer join tbpessoa as tbpessoacliente on tbpessoacliente.i' +
        'codigo = tbcliente.icodigo'
      
        'left outer join tbconsumidor on tbconsumidor.ipedido = tbpedido.' +
        'icodigo'
      
        'where tbpedido.sstatus = '#39'A'#39' and tbcomissionado.sstatus = '#39'A'#39' an' +
        'd tbproduto.sstatus = '#39'A'#39
      
        'order by tbservicotecnico.itecnico, tbpedido.ddatapedido, tbserv' +
        'icotecnico.ipedido, tbservicotecnico.nvalorcomissao')
    Left = 280
    Top = 168
  end
  object DataSource: TDataSource [3]
    DataSet = ZQuery
    Left = 360
    Top = 168
  end
end
