inherited frmCadastroControleAcesso: TfrmCadastroControleAcesso
  Caption = 'Cadastro do Controle de Acesso'
  ClientHeight = 473
  ClientWidth = 687
  OldCreateOrder = True
  OnShow = FormShow
  ExplicitWidth = 693
  ExplicitHeight = 501
  PixelsPerInch = 96
  TextHeight = 13
  inherited JvNavPaneToolPanel1: TJvNavPaneToolPanel
    Width = 687
    Height = 473
    ExplicitWidth = 687
    ExplicitHeight = 420
    inherited pn: TPanel
      Top = 438
      Width = 683
      TabOrder = 2
      ExplicitTop = 438
      ExplicitWidth = 683
      inherited btnGrava: TcxButton
        Left = 79
        OnClick = btnGravaClick
        ExplicitLeft = 281
      end
      inherited btnCancela: TcxButton
        Left = 483
        OnClick = btnCancelaClick
        ExplicitLeft = 382
      end
      inherited brnDeleta: TcxButton
        Left = 382
        Enabled = False
        Visible = False
        ExplicitLeft = 473
        ExplicitTop = 6
      end
      inherited BtnSair: TcxButton
        Left = 584
        ExplicitLeft = 584
      end
      inherited btnExportar: TcxButton
        Left = 281
        ExplicitLeft = 372
        ExplicitTop = 6
      end
      inherited btnImprimir: TcxButton
        Left = 180
        ExplicitLeft = 271
        ExplicitTop = 6
      end
    end
    object stDescricaoGrupo: TStaticText
      Left = 50
      Top = 38
      Width = 622
      Height = 20
      AutoSize = False
      BevelKind = bkFlat
      BorderStyle = sbsSingle
      Color = clBtnFace
      ParentColor = False
      TabOrder = 1
      Transparent = False
    end
    object edtGrupoUsuario: TcxTextEdit
      Tag = 16
      Left = 3
      Top = 38
      Hint = 
        'Informe o c'#243'digo do t'#233'cnico ou pressione F2 para pesquisar o t'#233'c' +
        'nico por nome.'
      TabOrder = 0
      OnEnter = edtGrupoUsuarioEnter
      OnExit = edtGrupoUsuarioExit
      OnKeyDown = edtGrupoUsuarioKeyDown
      OnKeyPress = edtGrupoUsuarioKeyPress
      Width = 45
    end
    object Label2: TcxLabel
      Left = 3
      Top = 24
      Caption = 'Grupo de usu'#225'rio'
      Transparent = True
    end
  end
  object cxGrid: TcxGrid [1]
    Left = 0
    Top = 62
    Width = 681
    Height = 376
    TabOrder = 1
    object cxGridDBTableView1: TcxGridDBTableView
      Navigator.Buttons.CustomButtons = <>
      DataController.DataModeController.GridMode = True
      DataController.DataSource = dsAcesso
      DataController.Options = [dcoAssignGroupingValues, dcoAssignMasterDetailKeys, dcoSaveExpanding, dcoGroupsAlwaysExpanded]
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      OptionsBehavior.FocusFirstCellOnNewRecord = True
      OptionsData.Deleting = False
      OptionsData.DeletingConfirmation = False
      OptionsData.Inserting = False
      OptionsView.GroupByBox = False
      object cxGridDBTableView1Marca: TcxGridDBColumn
        DataBinding.FieldName = 'Marca'
        PropertiesClassName = 'TcxCheckBoxProperties'
        Properties.ImmediatePost = True
        Options.Filtering = False
        Options.Sorting = False
        Width = 20
        IsCaptionAssigned = True
      end
      object cxGridDBTableView1CodigoRotina: TcxGridDBColumn
        Caption = 'C'#243'digo'
        DataBinding.FieldName = 'CodigoRotina'
        Visible = False
        Options.Editing = False
        Options.Filtering = False
        VisibleForCustomization = False
        Width = 86
      end
      object cxGridDBTableView1DescricaoRotina: TcxGridDBColumn
        Caption = 'Descri'#231#227'o'
        DataBinding.FieldName = 'DescricaoRotina'
        Options.Editing = False
        Options.Filtering = False
        Width = 634
      end
      object cxGridDBTableView1Tipo: TcxGridDBColumn
        DataBinding.FieldName = 'Tipo'
        Visible = False
        GroupIndex = 0
        VisibleForCustomization = False
        IsCaptionAssigned = True
      end
    end
    object cxGridLevel1: TcxGridLevel
      GridView = cxGridDBTableView1
    end
  end
  object dsAcesso: TDataSource
    DataSet = cdsAcesso
    Left = 40
    Top = 293
  end
  object cdsAcesso: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 40
    Top = 232
    object cdsAcessoMarca: TBooleanField
      FieldName = 'Marca'
    end
    object cdsAcessoCodigoRotina: TIntegerField
      FieldName = 'CodigoRotina'
    end
    object cdsAcessoDescricaoRotina: TStringField
      FieldName = 'DescricaoRotina'
      Size = 100
    end
    object cdsAcessoTipo: TStringField
      FieldName = 'Tipo'
    end
  end
end
