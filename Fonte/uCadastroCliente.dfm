inherited frmCadastroCliente: TfrmCadastroCliente
  Left = 309
  Top = 87
  Caption = 'Cadastro de Cliente'
  ClientHeight = 438
  ClientWidth = 498
  OldCreateOrder = True
  OnShow = FormShow
  ExplicitWidth = 504
  ExplicitHeight = 466
  PixelsPerInch = 96
  TextHeight = 13
  inherited JvNavPaneToolPanel1: TJvNavPaneToolPanel
    Width = 498
    Height = 438
    ExplicitWidth = 498
    ExplicitHeight = 448
    inherited pn: TPanel
      Top = 403
      Width = 494
      ExplicitTop = 403
      ExplicitWidth = 494
      inherited btnGrava: TcxButton
        Left = 152
        OnClick = btnGravaClick
        ExplicitLeft = 152
      end
      inherited btnCancela: TcxButton
        Left = 238
        OnClick = btnCancelaClick
        ExplicitLeft = 238
      end
      inherited brnDeleta: TcxButton
        Left = 324
        OnClick = brnDeletaClick
        ExplicitLeft = 324
      end
      inherited BtnSair: TcxButton
        Left = 410
        ExplicitLeft = 410
      end
      inherited btnExportar: TcxButton
        Left = 66
        ExplicitLeft = 66
      end
      inherited btnImprimir: TcxButton
        Left = -20
        ExplicitLeft = -20
      end
    end
    object pcDadosCliente: TJvPageControl
      Left = 4
      Top = 33
      Width = 481
      Height = 360
      ActivePage = tsGerais
      Style = tsFlatButtons
      TabOrder = 1
      object tsGerais: TTabSheet
        Caption = 'D&ados Gerais'
        object edtCEP: TMaskEdit
          Left = 1
          Top = 136
          Width = 110
          Height = 21
          CharCase = ecUpperCase
          EditMask = '99999-999;0; '
          MaxLength = 9
          TabOrder = 6
          Text = ''
        end
        object edtFone: TMaskEdit
          Left = 118
          Top = 136
          Width = 115
          Height = 21
          CharCase = ecUpperCase
          EditMask = '99 9999-9999;0; '
          MaxLength = 12
          TabOrder = 7
          Text = ''
        end
        object edtFax: TMaskEdit
          Left = 241
          Top = 136
          Width = 104
          Height = 21
          CharCase = ecUpperCase
          EditMask = '99 9999-9999;0; '
          MaxLength = 12
          TabOrder = 8
          Text = ''
        end
        object edtCelular: TMaskEdit
          Left = 353
          Top = 136
          Width = 118
          Height = 21
          CharCase = ecUpperCase
          EditMask = '99 9999-9999;0; '
          MaxLength = 12
          TabOrder = 9
          Text = ''
        end
        object edtDataCadastro: TMaskEdit
          Left = 285
          Top = 216
          Width = 90
          Height = 21
          CharCase = ecUpperCase
          EditMask = '99/99/9999;1; '
          MaxLength = 10
          TabOrder = 15
          Text = '  /  /    '
          OnEnter = edtDataCadastroEnter
          OnExit = edtDataCadastroExit
        end
        object rgPessoa: TRadioGroup
          Left = 384
          Top = 199
          Width = 88
          Height = 39
          Hint = 'PF = Pessoa F'#237'sica - PJ = Pessoa Jur'#237'dica'
          Caption = 'Pessoa'
          Columns = 2
          ItemIndex = 0
          Items.Strings = (
            'PF'
            'PJ')
          TabOrder = 16
          OnClick = rgPessoaClick
        end
        object MemoObservacao: TMemo
          Left = 1
          Top = 254
          Width = 472
          Height = 72
          TabOrder = 17
        end
        object edtCodigo: TcxTextEdit
          Tag = 9
          Left = 1
          Top = 16
          TabOrder = 0
          OnEnter = edtCodigoEnter
          OnExit = edtCodigoExit
          OnKeyDown = edtCodigoKeyDown
          OnKeyPress = edtCodigoKeyPress
          Width = 73
        end
        object edtNome: TcxTextEdit
          Left = 81
          Top = 16
          Properties.CharCase = ecUpperCase
          TabOrder = 1
          Width = 390
        end
        object edtEndereco: TcxTextEdit
          Left = 1
          Top = 56
          Properties.CharCase = ecUpperCase
          TabOrder = 2
          Width = 470
        end
        object edtBairro: TcxTextEdit
          Left = 1
          Top = 96
          Properties.CharCase = ecUpperCase
          TabOrder = 3
          Width = 168
        end
        object edtCidade: TcxTextEdit
          Tag = 1
          Left = 177
          Top = 96
          TabOrder = 4
          OnEnter = edtCidadeEnter
          OnExit = edtCidadeExit
          OnKeyDown = edtCidadeKeyDown
          OnKeyPress = edtCidadeKeyPress
          Width = 49
        end
        object edtCidadeNome: TcxTextEdit
          Left = 226
          Top = 96
          TabStop = False
          TabOrder = 5
          Width = 245
        end
        object edtEmail: TcxTextEdit
          Left = 1
          Top = 176
          TabOrder = 10
          Width = 230
        end
        object edtRamoAtividade: TcxTextEdit
          Tag = 6
          Left = 238
          Top = 176
          TabOrder = 11
          OnEnter = edtRamoAtividadeEnter
          OnExit = edtRamoAtividadeExit
          OnKeyDown = edtRamoAtividadeKeyDown
          OnKeyPress = edtRamoAtividadeKeyPress
          Width = 40
        end
        object edtRamoAtividadeDescricao: TcxTextEdit
          Left = 278
          Top = 176
          TabStop = False
          TabOrder = 12
          Width = 195
        end
        object edtComissionado: TcxTextEdit
          Tag = 7
          Left = 1
          Top = 216
          TabOrder = 13
          OnEnter = edtComissionadoEnter
          OnExit = edtComissionadoExit
          OnKeyDown = edtComissionadoKeyDown
          OnKeyPress = edtComissionadoKeyPress
          Width = 48
        end
        object edtComissionadoNome: TcxTextEdit
          Left = 49
          Top = 216
          TabStop = False
          TabOrder = 14
          Width = 232
        end
        object lblCodigo: TcxLabel
          Left = 1
          Top = 0
          Caption = 'C'#243'digo'
          Transparent = True
        end
        object lblNome: TcxLabel
          Left = 81
          Top = 0
          Caption = 'Nome'
          Transparent = True
        end
        object lblEndereco: TcxLabel
          Left = 1
          Top = 40
          Caption = 'Endere'#231'o'
          Transparent = True
        end
        object lblBairro: TcxLabel
          Left = 1
          Top = 80
          Caption = 'Bairro'
          Transparent = True
        end
        object lblCidade: TcxLabel
          Left = 177
          Top = 80
          Caption = 'Cidade'
          Transparent = True
        end
        object lblCEP: TcxLabel
          Left = 1
          Top = 120
          Caption = 'CEP'
          Transparent = True
        end
        object lblFone: TcxLabel
          Left = 118
          Top = 120
          Caption = 'Telefone'
          Transparent = True
        end
        object lblFax: TcxLabel
          Left = 241
          Top = 120
          Caption = 'Fax'
          Transparent = True
        end
        object lblCelular: TcxLabel
          Left = 353
          Top = 120
          Caption = 'Celular'
          Transparent = True
        end
        object lblEmail: TcxLabel
          Left = 1
          Top = 160
          Caption = 'Email'
          Transparent = True
        end
        object lblRamoAtividade: TcxLabel
          Left = 238
          Top = 160
          Caption = 'Ramo de Atividade'
          Transparent = True
        end
        object lblComissionado: TcxLabel
          Left = 1
          Top = 200
          Caption = 'Comissionado'
          Transparent = True
        end
        object lblDataCadastro: TcxLabel
          Left = 285
          Top = 200
          Caption = 'Data Cadastro'
          Transparent = True
        end
        object Label1: TcxLabel
          Left = 1
          Top = 240
          Caption = 'Observa'#231#227'o:'
          Transparent = True
        end
      end
      object tsFisica: TTabSheet
        Caption = 'Pessoa &F'#237'sica'
        ImageIndex = 1
        OnShow = tsFisicaShow
        object edtCPF: TMaskEdit
          Left = 0
          Top = 16
          Width = 102
          Height = 21
          CharCase = ecUpperCase
          EditMask = '999.999.999-99;0; '
          MaxLength = 14
          TabOrder = 0
          Text = ''
        end
        object edtDataNascimento: TMaskEdit
          Left = 213
          Top = 16
          Width = 84
          Height = 21
          CharCase = ecUpperCase
          EditMask = '99/99/9999;1; '
          MaxLength = 10
          TabOrder = 2
          Text = '  /  /    '
          OnExit = edtDataNascimentoExit
        end
        object edtRG: TcxTextEdit
          Left = 110
          Top = 16
          TabOrder = 1
          Width = 96
        end
        object lblRG: TcxLabel
          Left = 110
          Top = 0
          Caption = 'RG'
          Transparent = True
        end
        object lblCPF: TcxLabel
          Left = 1
          Top = 0
          Caption = 'CPF'
          Transparent = True
        end
        object lblDataNascimento: TcxLabel
          Left = 213
          Top = 0
          Caption = 'Nascimento'
          Transparent = True
        end
      end
      object tsJuridica: TTabSheet
        Caption = 'Pessoa &Jur'#237'dica'
        Enabled = False
        ImageIndex = 2
        OnShow = tsJuridicaShow
        object edtCNPJ: TMaskEdit
          Left = 1
          Top = 16
          Width = 127
          Height = 21
          CharCase = ecUpperCase
          EditMask = '99.999.999/9999-99;0; '
          MaxLength = 18
          TabOrder = 0
          Text = ''
        end
        object edtRazaoSocial: TcxTextEdit
          Left = 1
          Top = 56
          Properties.CharCase = ecUpperCase
          TabOrder = 3
          Width = 470
        end
        object edtInscEstadual: TcxTextEdit
          Left = 136
          Top = 16
          TabOrder = 1
          Width = 209
        end
        object edtInscMunicipal: TcxTextEdit
          Left = 352
          Top = 16
          TabOrder = 2
          Width = 119
        end
        object lblRazaoSocial: TcxLabel
          Left = 1
          Top = 40
          Caption = 'Raz'#227'o Social'
          Transparent = True
        end
        object lblCNPJ: TcxLabel
          Left = 2
          Top = 0
          Caption = 'CNPJ'
          Transparent = True
        end
        object lblInscEstadual: TcxLabel
          Left = 136
          Top = 0
          Caption = 'Insc. Estadual'
          Transparent = True
        end
        object lblInscMunicipal: TcxLabel
          Left = 352
          Top = 0
          Caption = 'Insc. Municipal'
          Transparent = True
        end
      end
      object tsCobranca: TTabSheet
        Caption = 'Dad&os de Cobran'#231'a'
        ImageIndex = 3
        OnEnter = tsCobrancaEnter
        OnShow = tsCobrancaShow
        object edtCEPCobr: TMaskEdit
          Left = 1
          Top = 96
          Width = 96
          Height = 21
          CharCase = ecUpperCase
          EditMask = '99999-999;0; '
          MaxLength = 9
          TabOrder = 4
          Text = ''
        end
        object edtEnderecoCobr: TcxTextEdit
          Left = 1
          Top = 16
          Properties.CharCase = ecUpperCase
          TabOrder = 0
          Width = 469
        end
        object edtBairroCobr: TcxTextEdit
          Left = 1
          Top = 56
          Properties.CharCase = ecUpperCase
          TabOrder = 1
          Width = 167
        end
        object edtCidadeCobr: TcxTextEdit
          Tag = 1
          Left = 177
          Top = 56
          TabOrder = 2
          OnEnter = edtCidadeCobrEnter
          OnExit = edtCidadeCobrExit
          OnKeyDown = edtCidadeCobrKeyDown
          OnKeyPress = edtCidadeCobrKeyPress
          Width = 48
        end
        object edtCidadeCobrNome: TcxTextEdit
          Left = 226
          Top = 56
          TabStop = False
          TabOrder = 3
          Width = 244
        end
        object lblEnderecoCobr: TcxLabel
          Left = 1
          Top = 0
          Caption = 'Endere'#231'o'
          Transparent = True
        end
        object lblBairroCobr: TcxLabel
          Left = 1
          Top = 40
          Caption = 'Bairro'
          Transparent = True
        end
        object lblCidadeCobr: TcxLabel
          Left = 177
          Top = 40
          Caption = 'Cidade'
          Transparent = True
        end
        object lblCEPCobr: TcxLabel
          Left = 1
          Top = 80
          Caption = 'CEP'
          Transparent = True
        end
      end
    end
  end
end
