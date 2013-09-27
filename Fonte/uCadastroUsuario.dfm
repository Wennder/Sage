inherited frmCadastroUsuarios: TfrmCadastroUsuarios
  Caption = 'Cadastro de Usu'#225'rios'
  ClientHeight = 189
  ClientWidth = 466
  OldCreateOrder = True
  OnShow = FormShow
  ExplicitWidth = 472
  ExplicitHeight = 217
  PixelsPerInch = 96
  TextHeight = 13
  inherited JvNavPaneToolPanel1: TJvNavPaneToolPanel
    Width = 466
    Height = 189
    ExplicitWidth = 466
    ExplicitHeight = 207
    inherited pn: TPanel
      Top = 154
      Width = 462
      TabOrder = 6
      ExplicitTop = 154
      ExplicitWidth = 462
      inherited btnGrava: TcxButton
        Left = -41
        OnClick = btnGravaClick
        ExplicitLeft = -41
      end
      inherited btnCancela: TcxButton
        Left = 161
        OnClick = btnCancelaClick
        ExplicitLeft = 161
      end
      inherited brnDeleta: TcxButton
        Left = 262
        OnClick = brnDeletaClick
        ExplicitLeft = 262
      end
      inherited BtnSair: TcxButton
        Left = 363
        ExplicitLeft = 363
      end
      inherited btnExportar: TcxButton
        Left = 60
        ExplicitLeft = 60
      end
      inherited btnImprimir: TcxButton
        Left = -142
        ExplicitLeft = -142
      end
    end
    object edtSenha: TMaskEdit
      Left = 284
      Top = 88
      Width = 172
      Height = 21
      PasswordChar = '*'
      TabOrder = 3
      Text = ''
    end
    object stDescricaoGrupo: TStaticText
      Left = 50
      Top = 125
      Width = 405
      Height = 20
      AutoSize = False
      BevelKind = bkFlat
      BorderStyle = sbsSingle
      Color = clBtnFace
      ParentColor = False
      TabOrder = 5
      Transparent = False
    end
    object edtCodigo: TcxTextEdit
      Tag = 15
      Left = 8
      Top = 48
      TabOrder = 0
      OnEnter = edtCodigoEnter
      OnExit = edtCodigoExit
      OnKeyDown = edtCodigoKeyDown
      OnKeyPress = edtCodigoKeyPress
      Width = 48
    end
    object edtNome: TcxTextEdit
      Left = 56
      Top = 48
      TabOrder = 1
      Width = 401
    end
    object edtLogin: TcxTextEdit
      Left = 8
      Top = 88
      TabOrder = 2
      Width = 273
    end
    object edtGrupoUsuario: TcxTextEdit
      Tag = 16
      Left = 9
      Top = 125
      Hint = 
        'Informe o c'#243'digo do t'#233'cnico ou pressione F2 para pesquisar o t'#233'c' +
        'nico por nome.'
      TabOrder = 4
      OnEnter = edtGrupoUsuarioEnter
      OnExit = edtGrupoUsuarioExit
      OnKeyDown = edtGrupoUsuarioKeyDown
      OnKeyPress = edtGrupoUsuarioKeyPress
      Width = 40
    end
    object lblCodigo: TcxLabel
      Left = 8
      Top = 32
      Caption = 'C'#243'digo'
      Transparent = True
    end
    object lblNome: TcxLabel
      Left = 57
      Top = 32
      Caption = 'Nome'
      Transparent = True
    end
    object lblLogin: TcxLabel
      Left = 9
      Top = 72
      Caption = 'Login'
      Transparent = True
    end
    object lblSenha: TcxLabel
      Left = 285
      Top = 72
      Caption = 'Senha'
      Transparent = True
    end
    object Label2: TcxLabel
      Left = 8
      Top = 111
      Caption = 'Grupo de usu'#225'rios:'
      Transparent = True
    end
  end
  inherited SaveDlg: TSaveDialog
    Left = 296
  end
end
