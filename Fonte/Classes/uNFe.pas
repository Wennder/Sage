unit uNFe;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs,
  ComCtrls, StdCtrls, ExtCtrls, Buttons, Db, DBTables, Printers, CheckLst,
  NFeXML, InvokeRegistry, Rio, uEmpresa, uprincipal,
  SOAPHTTPClient, Types, Math, OleCtrls, SHDocVw, StrUtils, ZAbstractRODataset, ZAbstractDataset, ZDataset;

function ExportarNFe(pPedido: String): String;
procedure PesquisaDadosNF(pPedido: STring);
function CriarChaveNfei(_codUf: integer; _anoMesEmissao, _cnpjEmitente, _modelo: string; _serie, _numero: integer; _codigoNumerico: Int64;
  _TipoNota: String): string;
function Modulo11(Numero: String): String;
function Alinha_esq(preenche: char; str: String; tamanho: integer): String;
function Alinha_dir(preenche: char; str: String; tamanho: integer): String;
// function  Iif(Condicao: Boolean; Verdadeiro, Falso: Variant): Variant; // IF em forma de função, se o primeiro parametro for verdadeiro, retorna o segundo, caso contrário retorna o terceiro.
function modulo11v2(str: string): String;
function GravaChaveNFe(_pedido: String; _chaveNFe: String; lote: string): Boolean;
function retirar_caracteres_especiais(valor: string): string;
function retirar_mascara(valor: string): string;
function retirar_aspas_duplas(valor: string): string;
function retirar_quebra_linha(texto: string): string;
function VerificaNumeroNF(pPedido: String): integer;
function LimpaCaracteresNumero(texto: string): string;
function TrocaNumeroNF(pPedido: String; piNumeroNF: integer): Boolean;
function GeraCodigoAleatorio: integer;

var
  Query: TZQuery;
  TOTAL_ICMS_VBC, TOTAL_ICMS_VICMS, TOTAL_ICMS_VBCST, TOTAL_ICMS_VICMSST, TOTAL_ICMS_VPROD, TOTAL_ICMS_VFRETE, TOTAL_ICMS_VSEG, TOTAL_ICMS_VDESC,
    TOTAL_ICMS_VII, TOTAL_ICMS_VIPI, TOTAL_ICMS_VPIS, TOTAL_ICMS_VCOFINS, TOTAL_ICMS_VOUTRO, TOTAL_ICMS_VNF, VTotalItens: Currency;

implementation

function ExportarNFe(pPedido: String): String;
var
  Memo1: TMemo;
  sNomeArquivo: String;
  Linha: string;
  CPF_CGC_CLI: string;
  NOTA_FISCAL: string;
  item: integer;
  ICMS_CST: string;
  PIS_CST: string;
  COFINS_CST: string;

  anoMesEmissao, modelo, sano, smes: string;
  cnpjEmitente, chave: string;
  codUF, Numero, numerolote, iserie: integer;
  codaletorio: Int64;
  sb, sdia: string;
  StrLote: String;
  dia: integer;
  Present: TDateTime;
  Year, Month, Day, Hour, Min, Sec, MSec: Word;
  REGIME_TRIBUTARIO: String;

  NFeXML1: TNFeXML;
  NumeroNF: integer;

  QueryDup: TZQuery;
  CondPagtoAvista: Boolean;
  Q, QEmpresa: TZQuery;
  TipoNota: String;
  ICMS_CSOSN, VersaoNfe_: String;

begin
  try
    try
      NumeroNF := VerificaNumeroNF(pPedido);
      if Application.MessageBox(PChar('Será gerada a NF: ' + IntToStr(NumeroNF) + '. Deseja informar outra numeração?'), 'Confirmação',
        MB_YESNO + MB_ICONQUESTION + MB_DEFBUTTON2) = ID_YES then
      begin
        NumeroNF := StrToInt(InputBox('Confirmação', 'Informe o número da NF:', IntToStr(NumeroNF)));
        TrocaNumeroNF(pPedido, NumeroNF);
      end;
      PesquisaDadosNF(pPedido);

      // Busca dados da Empresa
      QEmpresa := TZQuery.Create(nil);
      with QEmpresa do
      begin
        Connection := frmPrincipal.zcoConexaoBanco;
        SQL.Clear;
        SQL.Add('select e.*, c.scodibge, c.suf, c.snome as scidade from tbempresa e');
        SQL.Add('inner join tbcidade c on e.icidade = c.icodigo');
        SQL.Add('where iempresa = :iempresa');
        ParamByName('iempresa').Value := oEmpresaPrincipal.Getiempresa;
        Open;
      end;

      with Query do
      begin
        NFeXML1 := TNFeXML.Create(nil);
        NFeXML1.VersaoNfe := '2';
        Present := Now;
        DecodeDate(FieldByName('ddatapedido').AsDateTime, Year, Month, Day);
        sano := IntToStr(Year);
        sano := Copy(sano, 3, 2);
        smes := IntToStr(Month);
        if (Length(smes) = 1) then
          smes := '0' + smes;

        anoMesEmissao := sano + smes;
        modelo := '55';
        iserie := 1;
        cnpjEmitente := QEmpresa.FieldByName('scnpj').Value;
        Numero := FieldByName('B_NNF').AsInteger;
        codUF := 51;
        codaletorio := 61868128;
        TipoNota := '1';
        VersaoNfe_ := '2';
        chave := CriarChaveNfei(codUF, anoMesEmissao, cnpjEmitente, modelo, iserie, Numero, codaletorio, TipoNota);
        StrLote := anoMesEmissao;
        StrLote := StrLote + IntToStr(Numero);
        NFeXML1.IdLote := StrLote;
        NFeXML1.IniciaNF;

        while not(eof) do
        begin
          Present := FieldByName('ddatapedido').AsDateTime;
          DecodeDate(Present, Year, Month, Day);
          sano := IntToStr(Year);
          sano := Copy(sano, 3, 2);
          smes := IntToStr(Month);
          if (Length(smes) = 1) then
            smes := '0' + smes;

          anoMesEmissao := sano + smes;
          modelo := '55';
          iserie := 1;
          cnpjEmitente := QEmpresa.FieldByName('scnpj').Value;;
          Numero := FieldByName('B_NNF').AsInteger;
          codUF := 51;
          chave := CriarChaveNfei(codUF, anoMesEmissao, cnpjEmitente, modelo, iserie, Numero, codaletorio, TipoNota);
          StrLote := anoMesEmissao;
          StrLote := StrLote + IntToStr(Numero);
          NFeXML1.IdLote := StrLote;
          NFeXML1.IdentificadorNF := chave;

          GravaChaveNFe(pPedido, chave, NFeXML1.IdLote);

          CondPagtoAvista := True;
          QueryDup := TZQuery.Create(nil);
          with QueryDup do
          begin
            Connection := frmPrincipal.zcoConexaoBanco;
            SQL.Clear;
            SQL.Add('SELECT');
            SQL.Add('(sFatura) AS FATURA,');
            SQL.Add('dvencimento,');
            SQL.Add('nvalor');
            SQL.Add('FROM tbpedidoparcela');
            SQL.Add('WHERE tbpedidoparcela.ipedido = :ipedido');
            SQL.Add('ORDER BY dvencimento');
            ParamByName('iPedido').AsString := pPedido;
            Open;
            if not(Bof and eof) then
            begin
              CondPagtoAvista := False;
            end;
            SQL.Clear;
            SQL.Add('select sum(tbpedidoitens.nquantidade*tbpedidoitens.nvalor) as total_itens ' + ' from tbpedidoitens' +
              ' join tbproduto on tbproduto.icodigo = tbpedidoitens.iproduto' + ' where  tbproduto.sservico = ''N'' ' +
              ' and tbpedidoitens.ipedido = :iPedido ');
            ParamByName('iPedido').AsString := pPedido;
            Open;
            VTotalItens := FieldByName('total_itens').AsCurrency;
          end;
          FreeAndNil(QueryDup);

          NFeXML1.Cabecalho.codUF := '51';
          NFeXML1.Cabecalho.ChaveAcesso := IntToStr(codaletorio); // FieldByName('B_CNF').AsString;
          NFeXML1.Cabecalho.NaturezaOp := FieldByName('Natureza_Operacao').AsString;
          if CondPagtoAvista then
            NFeXML1.Cabecalho.FormaPagamento := '0'
          else
            NFeXML1.Cabecalho.FormaPagamento := '1';
          NFeXML1.Cabecalho.ModeloNota := '55';
          NFeXML1.Cabecalho.Serie := '1';
          NFeXML1.Cabecalho.NumeroNF := IntToStr(FieldByName('B_NNF').AsInteger);
          NFeXML1.Cabecalho.Emissao := FieldByName('ddatapedido').AsDateTime;
          NFeXML1.Cabecalho.DataEntSai := FieldByName('ddatapedido').AsDateTime;
          NFeXML1.Cabecalho.TipoNF := '1';
          NFeXML1.Cabecalho.CodMunicipio := '5108402';
          NFeXML1.Cabecalho.FormatoDanfe := '1';
          NFeXML1.Cabecalho.FormaEmissao := '1';
          NFeXML1.Cabecalho.DigitoChave := RightStr(chave, 1); // FieldByName('B_cDV').AsString;
          NFeXML1.Cabecalho.Ambiente := '1'; // 1 = producao 2 = homologacao
          NFeXML1.Cabecalho.Finalidade := '1';
          NFeXML1.Cabecalho.VersaoApp := '2.00';

          NFeXML1.AdicionaCabecalho;

          if Length(QEmpresa.FieldByName('scnpj').Value) = 14 then
            NFeXML1.Emitente.CNPJ := QEmpresa.FieldByName('scnpj').Value
          else
            NFeXML1.Emitente.CPF := QEmpresa.FieldByName('scnpj').Value;

          NFeXML1.Emitente.Nome := Trim(retirar_caracteres_especiais(QEmpresa.FieldByName('srazaosocial').Value));
          NFeXML1.Emitente.Fantasia := Trim(retirar_caracteres_especiais(QEmpresa.FieldByName('sfantasia').Value));
          NFeXML1.Emitente.InscEstadual := QEmpresa.FieldByName('sinscestadual').Value;
          NFeXML1.Emitente.InscMunicipal := QEmpresa.FieldByName('sinscmunicipal').Value;
          NFeXML1.Emitente.InscSubstituto := QEmpresa.FieldByName('sinscsubstituto').Value;
          NFeXML1.Emitente.CNAE := QEmpresa.FieldByName('scnae').Value;
          NFeXML1.Emitente.CRT := QEmpresa.FieldByName('scrt').Value;

          NFeXML1.Emitente.Endereco.Logradouro := retirar_caracteres_especiais(QEmpresa.FieldByName('sendereco').Value);
          NFeXML1.Emitente.Endereco.Numero := QEmpresa.FieldByName('snumero').Value;
          NFeXML1.Emitente.Endereco.Complemento := QEmpresa.FieldByName('scomplemento').Value;
          NFeXML1.Emitente.Endereco.Bairro := retirar_caracteres_especiais(QEmpresa.FieldByName('sbairro').Value);
          NFeXML1.Emitente.Endereco.CodMunicipio := QEmpresa.FieldByName('sCodibge').Value;
          NFeXML1.Emitente.Endereco.Municipio := retirar_caracteres_especiais(QEmpresa.FieldByName('scidade').Value);
          NFeXML1.Emitente.Endereco.UF := QEmpresa.FieldByName('suf').Value;
          NFeXML1.Emitente.Endereco.CEP := retirar_mascara(QEmpresa.FieldByName('scep').Value);
          NFeXML1.Emitente.Endereco.CodPais := '1058';
          NFeXML1.Emitente.Endereco.Pais := 'BRASIL';
          NFeXML1.Emitente.Endereco.Telefone := QEmpresa.FieldByName('sfone').Value;

          NFeXML1.AdicionaEmitente;

          CPF_CGC_CLI := retirar_mascara(FieldByName('cpf_cnpj').AsString);
          if (Length(CPF_CGC_CLI) = 14) then
          begin
            NFeXML1.Destinatario.CNPJ := CPF_CGC_CLI;
            NFeXML1.Destinatario.Nome := Trim(retirar_caracteres_especiais(FieldByName('nome').AsString));
            NFeXML1.Destinatario.InscEstadual := retirar_mascara(FieldByName('sinscestadual').AsString);
            NFeXML1.Destinatario.InscSuframa := '';
            NFeXML1.Destinatario.CPF := '';
          end
          else
          begin
            NFeXML1.Destinatario.CPF := CPF_CGC_CLI;
            NFeXML1.Destinatario.Nome := Trim(retirar_caracteres_especiais(FieldByName('nome').AsString));
            if (retirar_mascara(FieldByName('sinscestadual').AsString) = '') then
              NFeXML1.Destinatario.InscEstadual := 'ISENTO'
            else
              NFeXML1.Destinatario.InscEstadual := retirar_mascara(FieldByName('sinscestadual').AsString);
            NFeXML1.Destinatario.InscSuframa := '';
            NFeXML1.Destinatario.CNPJ := '';
          end;

          NFeXML1.Destinatario.Endereco.Logradouro := Trim(retirar_caracteres_especiais(FieldByName('sendereco').AsString));
          NFeXML1.Destinatario.Endereco.Numero := 'S/N';
          NFeXML1.Destinatario.Endereco.Complemento := '';
          NFeXML1.Destinatario.Endereco.Bairro := Trim(retirar_caracteres_especiais(FieldByName('sbairro').AsString));
          NFeXML1.Destinatario.Endereco.CodMunicipio := FieldByName('scodibge').AsString;
          NFeXML1.Destinatario.Endereco.Municipio := retirar_caracteres_especiais(FieldByName('cidade').AsString);
          NFeXML1.Destinatario.Endereco.UF := FieldByName('suf').AsString;
          NFeXML1.Destinatario.Endereco.CEP := FieldByName('scep').AsString;
          NFeXML1.Destinatario.Endereco.CodPais := '1058';
          NFeXML1.Destinatario.Endereco.Pais := retirar_caracteres_especiais('BRASIL');
          NFeXML1.Destinatario.Endereco.Telefone := Copy(FieldByName('sfone').AsString, 2, Length(FieldByName('sfone').AsString));
          NFeXML1.Destinatario.Email := '';

          NFeXML1.AdicionaDestinatario;

          // DETALHAMENTO DE PRODUTOS E SERVIÇOS - MÁXIMO = 990
          NOTA_FISCAL := FieldByName('PEDIDO').AsString;
          item := 0;
          //
          TOTAL_ICMS_VBC := 0;
          TOTAL_ICMS_VICMS := 0;
          TOTAL_ICMS_VBCST := 0;
          TOTAL_ICMS_VICMSST := 0;
          TOTAL_ICMS_VPROD := 0;
          TOTAL_ICMS_VFRETE := 0;
          TOTAL_ICMS_VSEG := 0;
          if FieldByName('najustevalor').AsCurrency < 0 then
            TOTAL_ICMS_VDESC := Abs(FieldByName('najustevalor').AsCurrency)
          else
            TOTAL_ICMS_VDESC := 0;
          TOTAL_ICMS_VII := 0;
          TOTAL_ICMS_VIPI := 0;
          TOTAL_ICMS_VPIS := 0;
          TOTAL_ICMS_VCOFINS := 0;
          TOTAL_ICMS_VOUTRO := 0;
          TOTAL_ICMS_VNF := 0;
          //
          while ((NOTA_FISCAL = FieldByName('PEDIDO').AsString) and (not(eof))) do
          begin
            inc(item);
            NFeXML1.ItemNota.NumeroItem := FormatFloat('##0', item);
            NFeXML1.ItemNota.CodProduto := FieldByName('icodigo').AsString;
            NFeXML1.ItemNota.CodEan := '';
            NFeXML1.ItemNota.Descricao := Trim(retirar_caracteres_especiais(FieldByName('sDescricao').AsString));
            if LimpaCaracteresNumero(FieldByName('incm').AsString) <> '' then
              NFeXML1.ItemNota.CodMercosul := LimpaCaracteresNumero(FieldByName('incm').AsString)
            else
              NFeXML1.ItemNota.CodMercosul := '';
            NFeXML1.ItemNota.ExTipi := '';
            NFeXML1.ItemNota.Genero := '';
            NFeXML1.ItemNota.CFOP := FieldByName('CFOP').AsString;
            NFeXML1.ItemNota.Unidade := FieldByName('Unidade').AsString;
            NFeXML1.ItemNota.Quantidade := StringReplace(FormatFloat('#######0.00', FieldByName('nQuantidade').AsCurrency), ',', '.', [rfIgnoreCase]);
            NFeXML1.ItemNota.ValorUnitario := StringReplace(FormatFloat('###########0.00', FieldByName('nValor').AsCurrency), ',', '.',
              [rfIgnoreCase]);
            NFeXML1.ItemNota.ValorTotalProd := StringReplace(FormatFloat('###########0.00', FieldByName('totalitem').AsCurrency), ',', '.',
              [rfIgnoreCase]);
            NFeXML1.ItemNota.CodEANTrib := ''; // FieldByName('I_cEANTrib').AsString;
            NFeXML1.ItemNota.UnidadeTrib := FieldByName('unidade').AsString;
            NFeXML1.ItemNota.QuantTrib := StringReplace(FormatFloat('######0.00', FieldByName('nQuantidade').AsCurrency), ',', '.', [rfIgnoreCase]);
            NFeXML1.ItemNota.ValorUniTrib := StringReplace(FormatFloat('###########0.00', FieldByName('nValor').AsCurrency), ',', '.',
              [rfIgnoreCase]);
            NFeXML1.ItemNota.Frete := '';
            NFeXML1.ItemNota.Seguro := '';
            // NFeXML1.ItemNota.Desconto := '';
            NFeXML1.ItemNota.Desconto :=
              StringReplace(FormatFloat('###########0.00', TOTAL_ICMS_VDESC * (FieldByName('totalitem').AsCurrency / VTotalItens)), ',', '.',
              [rfIgnoreCase]);
            NFeXML1.ItemNota.IndTot := '1';
            TOTAL_ICMS_VBC := TOTAL_ICMS_VBC + 0;
            TOTAL_ICMS_VICMS := TOTAL_ICMS_VICMS + 0;
            TOTAL_ICMS_VBCST := TOTAL_ICMS_VBCST + 0;
            TOTAL_ICMS_VICMSST := TOTAL_ICMS_VICMSST + 0;
            TOTAL_ICMS_VPROD := TOTAL_ICMS_VPROD + FieldByName('totalitem').AsCurrency;
            TOTAL_ICMS_VIPI := TOTAL_ICMS_VIPI + 0;
            TOTAL_ICMS_VPIS := TOTAL_ICMS_VPIS + 0;
            TOTAL_ICMS_VCOFINS := TOTAL_ICMS_VCOFINS + 0;
            TOTAL_ICMS_VNF := TOTAL_ICMS_VNF + FieldByName('totalitem').AsCurrency;

            ICMS_CSOSN := '400';
            ICMS_CST := '';
            REGIME_TRIBUTARIO := '1';
            if (ICMS_CST = '00') then
            begin
              // CST - 00 - TRIBUTADA INTEGRALMENTE
              NFeXML1.ItemNota.ICMS00.Origem := FieldByName('ICMS_ORIG').AsString;
              NFeXML1.ItemNota.ICMS00.CST := ICMS_CST;
              NFeXML1.ItemNota.ICMS00.Modalidade := FieldByName('ICMS_MODBC').AsString;
              NFeXML1.ItemNota.ICMS00.BaseCalculo := StringReplace(FormatFloat('###########0.00', FieldByName('ICMS_VBC').AsCurrency), ',', '.',
                [rfIgnoreCase]);
              NFeXML1.ItemNota.ICMS00.Aliquota := StringReplace(FormatFloat('##0.00', FieldByName('ICMS_PICMS').AsCurrency), ',', '.',
                [rfIgnoreCase]);
              NFeXML1.ItemNota.ICMS00.ICMS := StringReplace(FormatFloat('###########0.00', FieldByName('ICMS_VICMS').AsCurrency), ',', '.',
                [rfIgnoreCase]);
            end
            else if (ICMS_CST = '10') then
            begin
              NFeXML1.ItemNota.ICMS10.Origem := FieldByName('ICMS_ORIG').AsString;
              NFeXML1.ItemNota.ICMS10.CST := ICMS_CST;
              NFeXML1.ItemNota.ICMS10.Modalidade := FieldByName('ICMS_MODBC').AsString;
              NFeXML1.ItemNota.ICMS10.BaseCalculo := StringReplace(FormatFloat('###########0.00', FieldByName('ICMS_VBC').AsCurrency), ',', '.',
                [rfIgnoreCase]);
              NFeXML1.ItemNota.ICMS10.Aliquota := StringReplace(FormatFloat('##0.00', FieldByName('ICMS_PICMS').AsCurrency), ',', '.',
                [rfIgnoreCase]);
              NFeXML1.ItemNota.ICMS10.ICMS := StringReplace(FormatFloat('###########0.00', FieldByName('ICMS_VICMS').AsCurrency), ',', '.',
                [rfIgnoreCase]);
              NFeXML1.ItemNota.ICMS10.Modalidade10 := FieldByName('ICMS_MODBCST').AsString;
              NFeXML1.ItemNota.ICMS10.PercentualMargem := StringReplace(FormatFloat('##0.00', FieldByName('ICMS_PMVAST').AsCurrency), ',', '.',
                [rfIgnoreCase]);
              NFeXML1.ItemNota.ICMS10.PercentualReducao10 := StringReplace(FormatFloat('##0.00', FieldByName('ICMS_PREDBCST').AsCurrency), ',', '.',
                [rfIgnoreCase]);
              NFeXML1.ItemNota.ICMS10.BaseSubstituicao := StringReplace(FormatFloat('###########0.00', FieldByName('ICMS_VBCST').AsCurrency), ',',
                '.', [rfIgnoreCase]);
              NFeXML1.ItemNota.ICMS10.AliquotaSubstituicao := StringReplace(FormatFloat('##0.00', FieldByName('ICMS_PICMSST').AsCurrency), ',', '.',
                [rfIgnoreCase]);
              NFeXML1.ItemNota.ICMS10.ICMSSubstituicao := StringReplace(FormatFloat('###########0.00', FieldByName('ICMS_VICMSST').AsCurrency), ',',
                '.', [rfIgnoreCase]);
            end
            else if (ICMS_CST = '20') then
            begin
              NFeXML1.ItemNota.ICMS20.Origem := FieldByName('ICMS_ORIG').AsString;
              NFeXML1.ItemNota.ICMS20.CST := ICMS_CST;
              NFeXML1.ItemNota.ICMS20.Modalidade20 := FieldByName('ICMS_MODBC').AsString;
              NFeXML1.ItemNota.ICMS20.PercentualReducao := StringReplace(FormatFloat('##0.00', FieldByName('ICMS_PREDBC').AsCurrency), ',', '.',
                [rfIgnoreCase]);
              NFeXML1.ItemNota.ICMS20.BaseCalculo := StringReplace(FormatFloat('###########0.00', FieldByName('ICMS_VBC').AsCurrency), ',', '.',
                [rfIgnoreCase]);
              NFeXML1.ItemNota.ICMS20.Aliquota := StringReplace(FormatFloat('##0.00', FieldByName('ICMS_PICMS').AsCurrency), ',', '.',
                [rfIgnoreCase]);
              NFeXML1.ItemNota.ICMS20.ICMS := StringReplace(FormatFloat('###########0.00', FieldByName('ICMS_VICMS').AsCurrency), ',', '.',
                [rfIgnoreCase]);
            end
            else if (ICMS_CST = '30') then
            begin
              NFeXML1.ItemNota.ICMS30.Origem := FieldByName('ICMS_ORIG').AsString;
              NFeXML1.ItemNota.ICMS30.CST := ICMS_CST;
              NFeXML1.ItemNota.ICMS30.Modalidade := FieldByName('ICMS_MODBCST').AsString;
              NFeXML1.ItemNota.ICMS30.BaseSubstituicao := StringReplace(FormatFloat('###########0.00', FieldByName('ICMS_VBCST').AsCurrency), ',',
                '.', [rfIgnoreCase]);

              NFeXML1.ItemNota.ICMS30.ICMSSubstituicao := StringReplace(FormatFloat('###########0.00', FieldByName('ICMS_VICMSST').AsCurrency), ',',
                '.', [rfIgnoreCase]);
            end
            else if (ICMS_CST = '40') or (ICMS_CST = '41') or (ICMS_CST = '50') then
            begin
              NFeXML1.ItemNota.ICMS40.Origem := FieldByName('ICMS_ORIG').AsString;
              NFeXML1.ItemNota.ICMS40.CST := ICMS_CST;
            end
            else if (ICMS_CST = '51') then
            begin
              // CST - 51 - DIFERIMENTO - A EXIGÊNCIA DO PREENCHIMENTO DAS INFORMAÇÕES DO ICMS DIFERIDO FICA A CRITÉRIO DE CADA UF
              NFeXML1.ItemNota.ICMS51.Origem := FieldByName('ICMS_ORIG').AsString;
              NFeXML1.ItemNota.ICMS51.CST := ICMS_CST;
              NFeXML1.ItemNota.ICMS51.Modalidade := FieldByName('ICMS_MODBC').AsString;
              NFeXML1.ItemNota.ICMS51.PercentualReducao := '0.00';
              NFeXML1.ItemNota.ICMS51.BaseCalculo := StringReplace(FormatFloat('###########0.00', FieldByName('ICMS_VBC').AsCurrency), ',', '.',
                [rfIgnoreCase]);
              NFeXML1.ItemNota.ICMS51.Aliquota := StringReplace(FormatFloat('##0.00', FieldByName('ICMS_PICMS').AsCurrency), ',', '.',
                [rfIgnoreCase]);
              NFeXML1.ItemNota.ICMS51.ICMS := StringReplace(FormatFloat('###########0.00', FieldByName('ICMS_PICMS').AsCurrency), ',', '.',
                [rfIgnoreCase]);
            end
            else if (ICMS_CST = '60') then
            begin
              // CST - 60 - ICMS COBRADO ANTERIORMENTE POR SUBSTITUIÇÃO TRIBUITÁRIA
              if (VersaoNfe_ = '2') then
              begin
                NFeXML1.ItemNota.ICMS60.Origem := FieldByName('ICMS_ORIG').AsString;
                NFeXML1.ItemNota.ICMS60.CST := ICMS_CST;
                NFeXML1.ItemNota.ICMS60.BaseSubstituicao := StringReplace(FormatFloat('###########0.00', FieldByName('ICMS_VBCSTRet').AsCurrency),
                  ',', '.', [rfIgnoreCase]);
                NFeXML1.ItemNota.ICMS60.ICMSSubstituicao := StringReplace(FormatFloat('###########0.00', FieldByName('ICMS_VICMSSTRet').AsCurrency),
                  ',', '.', [rfIgnoreCase]);
              end
              else
              begin
                NFeXML1.ItemNota.ICMS60.Origem := FieldByName('ICMS_ORIG').AsString;
                NFeXML1.ItemNota.ICMS60.CST := ICMS_CST;
                NFeXML1.ItemNota.ICMS60.BaseSubstituicao := StringReplace(FormatFloat('###########0.00', FieldByName('ICMS_VBCST').AsCurrency), ',',
                  '.', [rfIgnoreCase]);
                NFeXML1.ItemNota.ICMS60.ICMSSubstituicao := StringReplace(FormatFloat('###########0.00', FieldByName('ICMS_VICMSST').AsCurrency), ',',
                  '.', [rfIgnoreCase]);
              end;
            end
            else if (ICMS_CST = '70') then
            begin
              // CST - 70 - COM REDUÇÃO DE BASE DE CÁLCULO E COBRANÇA DO ICMS POR SUBSTITUIÇÃO TRIBUITÁRIA
              NFeXML1.ItemNota.ICMS70.Origem := FieldByName('ICMS_ORIG').AsString;
              NFeXML1.ItemNota.ICMS70.CST := ICMS_CST;
              NFeXML1.ItemNota.ICMS70.Modalidade := FieldByName('ICMS_MODBC').AsString;
              NFeXML1.ItemNota.ICMS70.PercentualReducao := StringReplace(FormatFloat('##0.00', FieldByName('ICMS_PREDBC').AsCurrency), ',', '.',
                [rfIgnoreCase]);
              NFeXML1.ItemNota.ICMS70.BaseCalculo := StringReplace(FormatFloat('###########0.00', FieldByName('ICMS_VBC').AsCurrency), ',', '.',
                [rfIgnoreCase]);
              NFeXML1.ItemNota.ICMS70.Aliquota := StringReplace(FormatFloat('##0.00', FieldByName('ICMS_PICMS').AsCurrency), ',', '.',
                [rfIgnoreCase]);
              NFeXML1.ItemNota.ICMS70.ICMS := StringReplace(FormatFloat('###########0.00', FieldByName('ICMS_VICMS').AsCurrency), ',', '.',
                [rfIgnoreCase]);
              NFeXML1.ItemNota.ICMS70.ModalidadeSubstituicao := FieldByName('ICMS_MODBCST').AsString;
              NFeXML1.ItemNota.ICMS70.PercentualMargem := StringReplace(FormatFloat('##0.00', FieldByName('ICMS_PMVAST').AsCurrency), ',', '.',
                [rfIgnoreCase]);
              NFeXML1.ItemNota.ICMS70.PercentualReducao70 := StringReplace(FormatFloat('##0.00', FieldByName('ICMS_PREDBCST').AsCurrency), ',', '.',
                [rfIgnoreCase]);
              NFeXML1.ItemNota.ICMS70.BaseSubstituicao := StringReplace(FormatFloat('###########0.00', FieldByName('ICMS_VBCST').AsCurrency), ',',
                '.', [rfIgnoreCase]);
              NFeXML1.ItemNota.ICMS70.AliquotaSubstituicao := StringReplace(FormatFloat('##0.00', FieldByName('ICMS_PICMSST').AsCurrency), ',', '.',
                [rfIgnoreCase]);
              NFeXML1.ItemNota.ICMS70.ICMSSubstituicao := StringReplace(FormatFloat('###########0.00', FieldByName('ICMS_VICMSST').AsCurrency), ',',
                '.', [rfIgnoreCase]);
            end
            else if (ICMS_CST = '90') then
            begin
              // CST - 90 - OUTROS
              NFeXML1.ItemNota.ICMS90.Origem := FieldByName('ICMS_ORIG').AsString;
              NFeXML1.ItemNota.ICMS90.CST := ICMS_CST;
              NFeXML1.ItemNota.ICMS90.Modalidade := FieldByName('ICMS_MODBC').AsString;
              NFeXML1.ItemNota.ICMS90.PercentualReducao := StringReplace(FormatFloat('##0.00', FieldByName('ICMS_PREDBC').AsCurrency), ',', '.',
                [rfIgnoreCase]);
              NFeXML1.ItemNota.ICMS90.BaseCalculo := StringReplace(FormatFloat('###########0.00', FieldByName('ICMS_VBC').AsCurrency), ',', '.',
                [rfIgnoreCase]);
              NFeXML1.ItemNota.ICMS90.Aliquota := StringReplace(FormatFloat('##0.00', FieldByName('ICMS_PICMS').AsCurrency), ',', '.',
                [rfIgnoreCase]);
              NFeXML1.ItemNota.ICMS90.ICMS := StringReplace(FormatFloat('###########0.00', FieldByName('ICMS_VICMS').AsCurrency), ',', '.',
                [rfIgnoreCase]);
              NFeXML1.ItemNota.ICMS90.ModalidadeSubstituicao := FieldByName('ICMS_MODBCST').AsString;
              NFeXML1.ItemNota.ICMS90.PercentualMargem := StringReplace(FormatFloat('###0.00', FieldByName('ICMS_PMVAST').AsCurrency), ',', '.',
                [rfIgnoreCase]);
              NFeXML1.ItemNota.ICMS90.PercentualReducao90 := StringReplace(FormatFloat('##0.00', FieldByName('ICMS_PREDBCST').AsCurrency), ',', '.',
                [rfIgnoreCase]);
              NFeXML1.ItemNota.ICMS90.BaseSubstituicao := StringReplace(FormatFloat('###########0.00', FieldByName('ICMS_VBCST').AsCurrency), ',',
                '.', [rfIgnoreCase]);
              NFeXML1.ItemNota.ICMS90.AliquotaSubstituicao := StringReplace(FormatFloat('##0.00', FieldByName('ICMS_PICMSST').AsCurrency), ',', '.',
                [rfIgnoreCase]);
              NFeXML1.ItemNota.ICMS90.ICMSSubstituicao := StringReplace(FormatFloat('###########0.00', FieldByName('ICMS_VICMSST').AsCurrency), ',',
                '.', [rfIgnoreCase]);
            end;
            if (REGIME_TRIBUTARIO = '1') or (REGIME_TRIBUTARIO = '2') then
            begin
              if (ICMS_CSOSN = '101') then
              begin
                NFeXML1.ItemNota.ICMSSN101.Origem := FieldByName('ICMS_ORIG').AsString;
                NFeXML1.ItemNota.ICMSSN101.CSOSN := FieldByName('CSOSN').AsString;
                NFeXML1.ItemNota.ICMSSN101.pCredSN := StringReplace(FormatFloat('##0.00', FieldByName('ICMS_PICMS').AsCurrency), ',', '.',
                  [rfIgnoreCase]);
                NFeXML1.ItemNota.ICMSSN101.vCredICMSSN := StringReplace(FormatFloat('###########0.00', FieldByName('ICMS_VICMS').AsCurrency), ',',
                  '.', [rfIgnoreCase]);
              end
              else if ((ICMS_CSOSN = '102') or (ICMS_CSOSN = '103') or // situação 103 é utilizado tambem para regime tributário 2
                (ICMS_CSOSN = '300') or (ICMS_CSOSN = '400')) then
              begin
                NFeXML1.ItemNota.ICMSSN102.Origem := '0';
                NFeXML1.ItemNota.ICMSSN102.CSOSN := ICMS_CSOSN;
              end
              else if (ICMS_CSOSN = '201') then
              begin
                NFeXML1.ItemNota.ICMSSN201.Origem := FieldByName('ICMS_ORIG').AsString;;
                NFeXML1.ItemNota.ICMSSN201.CSOSN := FieldByName('CSOSN').AsString;;
                NFeXML1.ItemNota.ICMSSN201.modBCST := FieldByName('ICMS_MODBCST').AsString;;
                NFeXML1.ItemNota.ICMSSN201.pMVAST := StringReplace(FormatFloat('###0.00', FieldByName('ICMS_PMVAST').AsCurrency), ',', '.',
                  [rfIgnoreCase]);
                NFeXML1.ItemNota.ICMSSN201.pRedBCST := StringReplace(FormatFloat('##0.00', FieldByName('ICMS_PREDBCST').AsCurrency), ',', '.',
                  [rfIgnoreCase]);
                NFeXML1.ItemNota.ICMSSN201.vBCST := StringReplace(FormatFloat('###########0.00', FieldByName('ICMS_VBCST').AsCurrency), ',', '.',
                  [rfIgnoreCase]);
                NFeXML1.ItemNota.ICMSSN201.pICMSST := StringReplace(FormatFloat('##0.00', FieldByName('ICMS_PICMSST').AsCurrency), ',', '.',
                  [rfIgnoreCase]);
                NFeXML1.ItemNota.ICMSSN201.vICMSST := StringReplace(FormatFloat('###########0.00', FieldByName('ICMS_VICMSST').AsCurrency), ',', '.',
                  [rfIgnoreCase]);
                NFeXML1.ItemNota.ICMSSN201.pCredSN := StringReplace(FormatFloat('##0.00', FieldByName('ICMS_PICMS').AsCurrency), ',', '.',
                  [rfIgnoreCase]);
                NFeXML1.ItemNota.ICMSSN201.vCredICMSSN := StringReplace(FormatFloat('###########0.00', FieldByName('ICMS_VICMS').AsCurrency), ',',
                  '.', [rfIgnoreCase]);
              end
              else if ((ICMS_CSOSN = '202') or (ICMS_CSOSN = '203')) then
              begin // situação 203 é utilizado tambem para regime tributário 2
                NFeXML1.ItemNota.ICMSSN202.Origem := FieldByName('ICMS_ORIG').AsString;;
                NFeXML1.ItemNota.ICMSSN202.CSOSN := FieldByName('CSOSN').AsString;;
                NFeXML1.ItemNota.ICMSSN202.modBCST := FieldByName('ICMS_MODBCST').AsString;;
                NFeXML1.ItemNota.ICMSSN202.pMVAST := StringReplace(FormatFloat('###0.00', FieldByName('ICMS_PMVAST').AsCurrency), ',', '.',
                  [rfIgnoreCase]);
                NFeXML1.ItemNota.ICMSSN202.pRedBCST := StringReplace(FormatFloat('##0.00', FieldByName('ICMS_PREDBCST').AsCurrency), ',', '.',
                  [rfIgnoreCase]);
                NFeXML1.ItemNota.ICMSSN202.vBCST := StringReplace(FormatFloat('###########0.00', FieldByName('ICMS_VBCST').AsCurrency), ',', '.',
                  [rfIgnoreCase]);
                NFeXML1.ItemNota.ICMSSN202.pICMSST := StringReplace(FormatFloat('##0.00', FieldByName('ICMS_PICMSST').AsCurrency), ',', '.',
                  [rfIgnoreCase]);
                NFeXML1.ItemNota.ICMSSN202.vICMSST := StringReplace(FormatFloat('###########0.00', FieldByName('ICMS_VICMSST').AsCurrency), ',', '.',
                  [rfIgnoreCase]);
              end
              else if (ICMS_CSOSN = '500') then
              begin
                NFeXML1.ItemNota.ICMSSN500.Origem := '0';
                NFeXML1.ItemNota.ICMSSN500.CSOSN := '500';
                NFeXML1.ItemNota.ICMSSN500.vBCSTRet := StringReplace(FormatFloat('###########0.00', 0), ',', '.', [rfIgnoreCase]);
                NFeXML1.ItemNota.ICMSSN500.vICMSSTRet := StringReplace(FormatFloat('###########0.00', 0), ',', '.', [rfIgnoreCase]);
              end
              else if (ICMS_CSOSN = '900') then
              begin
                NFeXML1.ItemNota.ICMSSN900.Origem := FieldByName('ICMS_ORIG').AsString;;
                NFeXML1.ItemNota.ICMSSN900.CSOSN := FieldByName('CSOSN').AsString;
                NFeXML1.ItemNota.ICMSSN900.modBC := FieldByName('ICMS_MODBC').AsString;
                NFeXML1.ItemNota.ICMSSN900.vBC := StringReplace(FormatFloat('###########0.00', FieldByName('ICMS_VBC').AsCurrency), ',', '.',
                  [rfIgnoreCase]);
                NFeXML1.ItemNota.ICMSSN900.pRedBC := StringReplace(FormatFloat('##0.00', FieldByName('ICMS_PREDBC').AsCurrency), ',', '.',
                  [rfIgnoreCase]);
                NFeXML1.ItemNota.ICMSSN900.pICMS := StringReplace(FormatFloat('##0.00', FieldByName('ICMS_PICMS').AsCurrency), ',', '.',
                  [rfIgnoreCase]);
                NFeXML1.ItemNota.ICMSSN900.vICMS := StringReplace(FormatFloat('###########0.00', FieldByName('ICMS_VICMS').AsCurrency), ',', '.',
                  [rfIgnoreCase]);
                NFeXML1.ItemNota.ICMSSN900.modBCST := FieldByName('ICMS_MODBCST').AsString;;
                NFeXML1.ItemNota.ICMSSN900.pMVAST := StringReplace(FormatFloat('###0.00', FieldByName('ICMS_PMVAST').AsCurrency), ',', '.',
                  [rfIgnoreCase]);
                NFeXML1.ItemNota.ICMSSN900.pRedBCST := StringReplace(FormatFloat('##0.00', FieldByName('ICMS_PREDBCST').AsCurrency), ',', '.',
                  [rfIgnoreCase]);
                NFeXML1.ItemNota.ICMSSN900.vBCST := StringReplace(FormatFloat('###########0.00', FieldByName('ICMS_VBCST').AsCurrency), ',', '.',
                  [rfIgnoreCase]);
                NFeXML1.ItemNota.ICMSSN900.pICMSST := StringReplace(FormatFloat('##0.00', FieldByName('ICMS_PICMSST').AsCurrency), ',', '.',
                  [rfIgnoreCase]);
                NFeXML1.ItemNota.ICMSSN900.vICMSST := StringReplace(FormatFloat('###########0.00', FieldByName('ICMS_VICMSST').AsCurrency), ',', '.',
                  [rfIgnoreCase]);
                NFeXML1.ItemNota.ICMSSN900.pCredSN := StringReplace(FormatFloat('##0.00', FieldByName('ICMS_PICMS').AsCurrency), ',', '.',
                  [rfIgnoreCase]);
                NFeXML1.ItemNota.ICMSSN900.vCredICMSSN := StringReplace(FormatFloat('###########0.00', FieldByName('ICMS_VICMS').AsCurrency), ',',
                  '.', [rfIgnoreCase]);
              end;
            end;
            // IPI NÃO TRIBUTÁVEL: 01-02-03-04-05-51-52-53-54-55
            NFeXML1.ItemNota.IPINaoTributavel.CST := '03';

            PIS_CST := '08';
            if (PIS_CST = '01') // 01 - OPERAÇÃO TRIBUTÁVEL (BASE DE CÁLCULO = VALOR DA OPERAÇÃO ALÍQUOTA NORMAL (CUMULATIVO/NÃO CUMULATIVO))
              or (PIS_CST = '02') then
            begin // 02 - OPERAÇÃO TRIBUTÁVEL (BASE DE CALCULO = VALOR OPERACAO (ALIQUOTA DIFERENCIADA))
              NFeXML1.ItemNota.PISTributavelAliquota.CST := PIS_CST;
              NFeXML1.ItemNota.PISTributavelAliquota.BaseCalculo := StringReplace(FormatFloat('###########0.00', FieldByName('PIS_VBC').AsCurrency),
                ',', '.', [rfIgnoreCase]);
              NFeXML1.ItemNota.PISTributavelAliquota.Aliquota := StringReplace(FormatFloat('##0.00', FieldByName('PIS_PPIS').AsCurrency), ',', '.',
                [rfIgnoreCase]);
              NFeXML1.ItemNota.PISTributavelAliquota.valor := StringReplace(FormatFloat('###########0.00', FieldByName('PIS_VPIS').AsCurrency), ',',
                '.', [rfIgnoreCase]);

            end
            else if (PIS_CST = '04') // OPERACAO TRIBUTAVEL (TRIBUTACAO MONOFASICA (ALIQUOTA ZERO))
              or (PIS_CST = '06') // OPERACAO TRIBUTAVEL (ALIQUOTA ZERO)
              or (PIS_CST = '07') // OPERACAO ISENTA DA CONTRIBUICAO
              or (PIS_CST = '08') // OPERACAO SEM INCIDENCIA DA CONTRIBUICAO
              or (PIS_CST = '09') then
            begin // OPERACAO COM SUSPENSAO DA CONTRIBUICAO

              NFeXML1.ItemNota.PISNaoTributavel.CST := PIS_CST;
            end;
            //
            // COFINS

            COFINS_CST := '08';
            if (COFINS_CST = '01') or (COFINS_CST = '02') then
            begin
              // COFINS - GRUPO DE COFINS TRIBUTADO PELA LÍQUOTA
              NFeXML1.ItemNota.COFINSTributadoAliquota.CST := COFINS_CST;
              NFeXML1.ItemNota.COFINSTributadoAliquota.BaseCalculo :=
                StringReplace(FormatFloat('###########0.00', FieldByName('COFINS_VBC').AsCurrency), ',', '.', [rfIgnoreCase]);
              NFeXML1.ItemNota.COFINSTributadoAliquota.Aliquota := StringReplace(FormatFloat('##0.00', FieldByName('COFINS_PCOFINS').AsCurrency), ',',
                '.', [rfIgnoreCase]);
              NFeXML1.ItemNota.COFINSTributadoAliquota.valor :=
                StringReplace(FormatFloat('###########0.00', FieldByName('COFINS_VCOFINS').AsCurrency), ',', '.', [rfIgnoreCase]);
            end
            else if (COFINS_CST = '04') or (COFINS_CST = '06') or (COFINS_CST = '07') or (COFINS_CST = '08') or (COFINS_CST = '09') then
            begin
              // COFINS - GRUPO DE COFINS NÃO TRIBUTADO
              NFeXML1.ItemNota.CofinsNaoTributavel.CST := COFINS_CST;
            end;

            NFeXML1.AdicionaItemNota;
            NEXT;
          end;
          // TOTAIS
          NFeXML1.Total.BaseICMS := StringReplace(FormatFloat('###########0.00', TOTAL_ICMS_VBC), ',', '.', [rfIgnoreCase]);
          NFeXML1.Total.ICMS := StringReplace(FormatFloat('###########0.00', TOTAL_ICMS_VICMS), ',', '.', [rfIgnoreCase]);
          NFeXML1.Total.BaseSubstituicao := StringReplace(FormatFloat('###########0.00', TOTAL_ICMS_VBCST), ',', '.', [rfIgnoreCase]);
          NFeXML1.Total.Substituicao := StringReplace(FormatFloat('###########0.00', TOTAL_ICMS_VICMSST), ',', '.', [rfIgnoreCase]);
          NFeXML1.Total.TotalProdutos := StringReplace(FormatFloat('###########0.00', TOTAL_ICMS_VPROD), ',', '.', [rfIgnoreCase]);
          NFeXML1.Total.Frete := StringReplace(FormatFloat('###########0.00', TOTAL_ICMS_VFRETE), ',', '.', [rfIgnoreCase]);
          NFeXML1.Total.Seguro := StringReplace(FormatFloat('###########0.00', TOTAL_ICMS_VSEG), ',', '.', [rfIgnoreCase]);
          NFeXML1.Total.Desconto := StringReplace(FormatFloat('###########0.00', TOTAL_ICMS_VDESC), ',', '.', [rfIgnoreCase]);
          NFeXML1.Total.II := StringReplace(FormatFloat('###########0.00', TOTAL_ICMS_VII), ',', '.', [rfIgnoreCase]);
          NFeXML1.Total.IPI := StringReplace(FormatFloat('###########0.00', TOTAL_ICMS_VIPI), ',', '.', [rfIgnoreCase]);
          NFeXML1.Total.Pis := StringReplace(FormatFloat('###########0.00', TOTAL_ICMS_VPIS), ',', '.', [rfIgnoreCase]);
          NFeXML1.Total.COFINS := StringReplace(FormatFloat('###########0.00', TOTAL_ICMS_VCOFINS), ',', '.', [rfIgnoreCase]);
          NFeXML1.Total.Outro := StringReplace(FormatFloat('###########0.00', TOTAL_ICMS_VOUTRO), ',', '.', [rfIgnoreCase]);
          NFeXML1.Total.TotalNF := StringReplace(FormatFloat('###########0.00', TOTAL_ICMS_VNF // TOTAL DOS PRODUTOS
            + TOTAL_ICMS_VFRETE // TOTAL DO FRETE
            + TOTAL_ICMS_VSEG // TOTAL DO SEGURDO
            - TOTAL_ICMS_VDESC), ',', '.', [rfIgnoreCase]); // TOTAL DO DESCONTO
          NFeXML1.AdicionaTotal;
          // TRANSPORTE
          NFeXML1.Transportadora.Modalidade := '1'; // 0 - POR CONTA DO EMITENTE, 1 - POR CONTA DO DESTINATÁRIO
          // X03|
          // TRANSPORTADOR
          NFeXML1.Transportadora.Nome := Trim(retirar_caracteres_especiais(FieldByName('nome').AsString));
          NFeXML1.Transportadora.InscEstadual := retirar_mascara(FieldByName('sinscestadual').AsString);
          NFeXML1.Transportadora.Endereco := Trim(retirar_caracteres_especiais(FieldByName('sendereco').AsString));
          NFeXML1.Transportadora.Municpio := retirar_caracteres_especiais(FieldByName('cidade').AsString);
          NFeXML1.Transportadora.UF := FieldByName('suf').AsString;
          if (Length(FieldByName('cpf_cnpj').AsString) = 14) then
          begin
            NFeXML1.Transportadora.CNPJ := FieldByName('cpf_cnpj').AsString;
          end
          else
          begin
            NFeXML1.Transportadora.CPF := FieldByName('cpf_cnpj').AsString;
          end;

          NFeXML1.AdicionaTransportadora;
          QueryDup := TZQuery.Create(nil);
          with QueryDup do
          begin
            Connection := frmPrincipal.zcoConexaoBanco;
            SQL.Clear;
            SQL.Add('SELECT');
            SQL.Add('(sFatura) AS FATURA,');
            SQL.Add('dvencimento,');
            SQL.Add('nvalor');
            SQL.Add('FROM tbpedidoparcela');
            SQL.Add('WHERE tbpedidoparcela.ipedido = :ipedido');
            SQL.Add('ORDER BY dvencimento');
            ParamByName('iPedido').AsString := pPedido;
            Open;
            if not(Bof and eof) then
            begin
              NFeXML1.AdicionaCobranca('A');
              while not eof do
              begin
                NFeXML1.Cobranca.Duplicata := FieldByName('FATURA').AsString;
                NFeXML1.Cobranca.VencDup := FormatDateTime('yyyy-mm-dd', FieldByName('dVencimento').AsDateTime);
                NFeXML1.Cobranca.ValorDup := StringReplace(FormatFloat('###########0.00', FieldByName('nvalor').AsCurrency), ',', '.',
                  [rfIgnoreCase]);
                NFeXML1.AdicionaCobranca('M');
                NEXT;
              end;
              NFeXML1.AdicionaCobranca('F');
            end;
          end;
          FreeAndNil(QueryDup);
          NFeXML1.Informacoes.InfComplementar :=
            'ICMS RECOLHIDO INTEGRAL. DOCUMENTO EMITIDO POR ME OU EPP OPTANTE PELO SIMPLES NACIONAL. NÃO GERA DIREITO A CREDITO FISCAL DE ICMS. ' +
            FieldByName('SOBSERVACAO').AsString;
          // Trim('Pedido: '+ FieldByName('PEDIDO').AsString + ' ' + trim(retirar_caracteres_especiais(retirar_quebra_linha( Copy(FieldByName('Z_INFCPL').AsString,1,5000)))));
          NFeXML1.AdicionaInformacoes;
        end;
      end;

      NFeXML1.NomeArquivo := ExtractFilePath(Application.ExeName) + 'NFE\XML\NOTA-SEFAZ-' + NFeXML1.IdLote + '-[' +
        FormatDateTime('yyyy-mm-dd-hh-nn-ss', Now) + '][' + retirar_mascara('36963452000116') + '].XML';
      Result := NFeXML1.NomeArquivo;
      NFeXML1.FinalizaNF;
    except
      on e: exception do
      begin
        Application.MessageBox(PChar('Ocorreu o seguinte erro ao gerar uma NF-e:' + #13 + e.Message), 'Erro', mb_ok + MB_ICONERROR);
      end;
    end;
  finally
    Query.Close;
  end;
end;

function CriarChaveNfei(_codUf: integer; _anoMesEmissao, _cnpjEmitente, _modelo: string; _serie, _numero: integer; _codigoNumerico: Int64;
  _TipoNota: String): string;
var
  chave, dig, sserie, snumero, scodigo: string;
begin
  {
    //uf 2 caracteres
    //periodo 4 caracteres
    //cnpj 14
    //modelo 2
    //serie 3
    //numero 9
    //Tipo Nota 1
    //codigo numero 8
    //dv 1
  }
  sserie := Alinha_dir('0', IntToStr(_serie), 3);
  snumero := Alinha_dir('0', IntToStr(_numero), 9);
  scodigo := Alinha_dir('0', IntToStr(_codigoNumerico), 8);
  chave := IntToStr(_codUf) + _anoMesEmissao + _cnpjEmitente + _modelo + sserie + snumero + _TipoNota + scodigo;
  dig := modulo11v2(chave);
  if (UpperCase(dig) = 'X') then
    dig := '0';
  chave := chave + dig;
  Result := 'NFe' + chave;
end;

function Modulo11(Numero: String): String;
var
  i, j, k: integer;
  Soma: integer;
  Digito: integer;
begin
  Result := '';
  Try
    Soma := 0;
    k := 2;
    for i := Length(Numero) downto 1 do
    begin
      Soma := Soma + (StrToInt(Numero[i]) * k);
      inc(k);
      if k > 9 then
        k := 2;
    end;
    Digito := 11 - Soma mod 11;
    if Digito >= 10 then
      Digito := 0;
    Result := Result + Chr(Digito + Ord('0'));
  except
    Result := 'X';
  end;
end;

function modulo11v2(str: string): String;
var
  mult: integer;
  Digito: integer;
  i: integer;
begin
  Digito := 0;
  mult := 9;
  for i := Length(str) downto 1 do
  begin
    Digito := Digito + (StrToInt(str[i]) * mult);
    If mult = 2 then
      mult := 9
    else
      dec(mult);
  end;
  Digito := Digito mod 11;
  If Digito = 10 then
    Result := 'X'
  else
    Result := IntToStr(Digito);
end;

function GravaChaveNFe(_pedido: String; _chaveNFe: String; lote: string): Boolean;
var
  Q: TZQuery;
begin
  Q := TZQuery.Create(nil);
  with Q do
  begin
    Connection := frmPrincipal.zcoConexaoBanco;
    SQL.Clear;
    SQL.Add('update tbpedido set chave = :chave, lote = :lote where icodigo = :pedido');
    ParamByName('Pedido').AsString := _pedido;
    ParamByName('chave').AsString := _chaveNFe;
    ParamByName('lote').AsString := lote;
    ExecSQL;
  end;
end;

procedure PesquisaDadosNF(pPedido: STring);
begin
  Query := TZQuery.Create(nil);
  Query.Connection := frmPrincipal.zcoConexaoBanco;
  Query.SQL.LoadFromFile(ExtractFilePath(Application.ExeName) + 'SQL\select_NF.txt');
  Query.ParamByName('Pedido').AsString := pPedido;
  Query.Open;
end;

function retirar_caracteres_especiais(valor: string): string;
var
  i: integer;
  s: char;
begin
  for i := 1 to Length(valor) do
  begin
    s := valor[i];
    if (s = 'Á') then
      s := 'A'
    else if (s = 'É') then
      s := 'E'
    else if (s = 'Í') then
      s := 'I'
    else if (s = 'Ó') then
      s := 'O'
    else if (s = 'Ú') then
      s := 'U'
    else if (s = 'á') then
      s := 'a'
    else if (s = 'é') then
      s := 'e'
    else if (s = 'í') then
      s := 'i'
    else if (s = 'ó') then
      s := 'o'
    else if (s = 'ú') then
      s := 'u'
    else if (s = 'À') then
      s := 'A'
    else if (s = 'È') then
      s := 'E'
    else if (s = 'Ì') then
      s := 'I'
    else if (s = 'Ò') then
      s := 'O'
    else if (s = 'Ù') then
      s := 'U'
    else if (s = 'à') then
      s := 'a'
    else if (s = 'è') then
      s := 'e'
    else if (s = 'ì') then
      s := 'i'
    else if (s = 'ò') then
      s := 'o'
    else if (s = 'ù') then
      s := 'u'
    else if (s = 'Â') then
      s := 'A'
    else if (s = 'Ê') then
      s := 'E'
    else if (s = 'Î') then
      s := 'I'
    else if (s = 'Ô') then
      s := 'O'
    else if (s = 'Û') then
      s := 'U'
    else if (s = 'â') then
      s := 'a'
    else if (s = 'ê') then
      s := 'e'
    else if (s = 'î') then
      s := 'i'
    else if (s = 'ô') then
      s := 'o'
    else if (s = 'û') then
      s := 'u'
    else if (s = 'Ã') then
      s := 'A'
    else if (s = 'Õ') then
      s := 'O'
    else if (s = 'ã') then
      s := 'a'
    else if (s = 'õ') then
      s := 'o'
    else if (s = 'Ä') then
      s := 'A'
    else if (s = 'Ë') then
      s := 'E'
    else if (s = 'Ï') then
      s := 'I'
    else if (s = 'Ö') then
      s := 'O'
    else if (s = 'Ü') then
      s := 'U'
    else if (s = 'ä') then
      s := 'a'
    else if (s = 'ë') then
      s := 'e'
    else if (s = 'ï') then
      s := 'i'
    else if (s = 'ö') then
      s := 'o'
    else if (s = 'ü') then
      s := 'u'
    else if (s = 'ç') then
      s := 'c'
    else if (s = 'Ç') then
      s := 'C'
    else if (s = 'å') then
      s := 'O'
    else if (s = '€') then
      s := 'C'
    else if not(s in ['a' .. 'z', 'A' .. 'Z', '0' .. '9', #13, #10, ' ', ',', '.', '|', '-', ':']) then
      s := ' ';
    valor[i] := s;
  end;
  Result := Trim(valor);
end;

function retirar_mascara(valor: string): string;
begin
  while (pos('.', valor) <> 0) do
  begin
    delete(valor, pos('.', valor), 1);
  end;
  while (pos('/', valor) <> 0) do
  begin
    delete(valor, pos('/', valor), 1);
  end;
  while (pos('-', valor) <> 0) do
  begin
    delete(valor, pos('-', valor), 1);
  end;
  Result := valor;
end;

function retirar_aspas_duplas(valor: string): string;
begin
  while (pos('''', valor) <> 0) do
  begin
    delete(valor, pos('''', valor), 1);
  end;
  Result := valor;
end;

function retirar_quebra_linha(texto: string): string;
var
  p: integer;
begin
  while (pos(#13, texto) <> 0) do
  begin
    p := pos(#13, texto);
    delete(texto, p, 1);
    insert(' ', texto, 1);
  end;
  while (pos(#10, texto) <> 0) do
  begin
    p := pos(#10, texto);
    delete(texto, p, 1);
    insert(' ', texto, 1);
  end;
  Result := Trim(texto);
end;

function Alinha_esq(preenche: char; str: string; tamanho: integer): string;
begin
  str := Trim(str);
  Result := str + StringOfChar(preenche, tamanho - Length(str));
  Result := Copy(Result, 1, tamanho);
end;

function Alinha_dir(preenche: char; str: string; tamanho: integer): string;
begin
  str := Trim(str);
  Result := StringOfChar(preenche, tamanho - Length(str)) + str;
  Result := Copy(Result, 1, tamanho);
end;

function VerificaNumeroNF(pPedido: String): integer;
var
  Q: TZQuery;
begin
  Q := TZQuery.Create(nil);
  with Q do
  begin
    Connection := frmPrincipal.zcoConexaoBanco;
    SQL.Clear;
    SQL.Add('SELECT inotafiscal FROM TBPEDIDO WHERE icodigo = :pedido');
    ParamByName('Pedido').AsString := pPedido;
    Open;
    if (FieldByName('inotafiscal').AsInteger = 0) or (FieldByName('inotafiscal').IsNull) then
    begin
      SQL.Clear;
      SQL.Add('update tbpedido set inotafiscal = coalesce((select max(inotafiscal)+1 from tbpedido where chave is not null),1) where icodigo = :pedido');
      ParamByName('Pedido').AsString := pPedido;
      ExecSQL;

      SQL.Clear;
      SQL.Add('select max(inotafiscal) as inotafiscal from tbpedido where icodigo = :pedido');
      ParamByName('Pedido').AsString := pPedido;
      Open;
      Result := FieldByName('inotafiscal').AsInteger;
    end
    else
    begin
      Result := FieldByName('inotafiscal').AsInteger;
    end;
  end;
  FreeAndNil(Q);
end;

function LimpaCaracteresNumero(texto: string): string;
var
  i: integer;
  s: char;
begin
  Result := '';
  if texto = '' then
    Exit;
  For i := 0 to Length(texto) do
  begin
    if (texto[i] in ['0' .. '9']) then
    begin
      Result := Result + texto[i]
    end;
  end;
end;

function TrocaNumeroNF(pPedido: String; piNumeroNF: integer): Boolean;
var
  Q: TZQuery;
begin
  Q := TZQuery.Create(nil);
  with Q do
  begin
    Connection := frmPrincipal.zcoConexaoBanco;
    SQL.Clear;
    SQL.Add('update tbpedido set inotafiscal = :NumeroNF where icodigo = :pedido');
    ParamByName('Pedido').AsString := pPedido;
    ParamByName('NumeroNF').AsInteger := piNumeroNF;
    ExecSQL;
    Result := True;
  end;
  FreeAndNil(Q);
end;

function GeraCodigoAleatorio: integer;
var
  codaletorio: integer;
begin
  codaletorio := 0;
  while Length(IntToStr(codaletorio)) <> 8 do
  begin
    RandSeed := 100046678;
    Randomize;
    // codaletorio := Random(907446678);
    codaletorio := Random(97446678);
  end;
  // ShowMessage(IntToStr(codaletorio) + #13 + IntToStr(Length(IntToStr(codaletorio))));
  Result := codaletorio;
end;

end.
