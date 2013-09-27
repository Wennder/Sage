unit NFeXML;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs;

type
  { Tipo para endereco da nota }
  TEndereco = record
    Logradouro: string[60];
    Numero: string[60];
    Complemento: string[60];
    Bairro: string[60];
    CodMunicipio: string[07];
    Municipio: string[60];
    UF: string[02];
    CEP: string[08];
    CodPais: string[10];
    Pais: string[60];
    Telefone: string[20];
  end;

  { Tipo contendo as informacoes de identificação da nota }
  TCabecalho = record
    CodUF: string[02];
    ChaveAcesso: string[09];
    NaturezaOp: string[60];
    FormaPagamento: string[01];
    ModeloNota: string[02];
    Serie: string[03];
    NumeroNF: string[09];
    Emissao: TDate;
    DataEntSai: TDate;
    HoraEntSai: TDate;
    TipoNF: string[01];
    CodMunicipio: string[07];
    FormatoDanfe: string[01];
    FormaEmissao: string[01];
    DigitoChave: string[01];
    Ambiente: string[01];
    Finalidade: string[01];
    VersaoApp: string[20];
  end;

  { Emitente da Nota }
  TEmitente = record
    CNPJ: string[14];
    CPF: string[11];
    Nome: string[60];
    Fantasia: string[60];
    Endereco: TEndereco;
    InscEstadual: string[14];
    InscMunicipal: string[15];
    InscSubstituto: string[14];
    CNAE: string[07];
    CRT: string[01];
  end;

  { Destinatario da Nota }
  TDestinatario = record
    CNPJ: string[14];
    CPF: string[11];
    Nome: string[60];
    Endereco: TEndereco;
    InscEstadual: string[14];
    InscSuframa: string[09];
    Email: string[90];
  end;

  { Local de entrega }
  TEntrega = record
    CNPJ: string[14];
    Endereco: TEndereco;
  end;

  { Tipo para produtos com cod. de tributação de ICMS 00 - Tributada integralmente }
  TICMS00 = record
    Origem: string[01];
    CST: string[02];
    Modalidade: string[01];
    BaseCalculo: string[15];
    Aliquota: string[05];
    ICMS: string[15];
  end;

  { Tipo para produtos com cod. de tributação de ICMS 10 - Tributada e com cobrança do ICMS por substituicao tributária }
  TICMS10 = record
    Origem: string[01];
    CST: string[02];
    Modalidade: string[01];
    BaseCalculo: string[15];
    Aliquota: string[05];
    ICMS: string[15];
    Modalidade10: string[01];
    PercentualMargem: string[06];
    PercentualReducao10: string[06];
    BaseSubstituicao: string[15];
    AliquotaSubstituicao: string[05];
    ICMSSubstituicao: string[15];
  end;

  { Tipo para produtos com cod. de tributação de ICMS 20 - Com redução de base de calculo }
  TICMS20 = record
    Origem: string[01];
    CST: string[02];
    Modalidade20: string[01];
    PercentualReducao: string[06];
    BaseCalculo: string[15];
    Aliquota: string[15];
    ICMS: string[15];
  end;

  { Tipo para produtos com cod. de tributação de ICMS 30 - Isenta ou não tributada e com cobrança do ICMS por substituicao tributaria }
  TICMS30 = record
    Origem: string[01];
    CST: string[02];
    Modalidade: string[01];
    PercentualMargem: string[06];
    PercentualReducao: string[06];
    BaseSubstituicao: string[15];
    AliquotaSubstituicao: string[05];
    ICMSSubstituicao: string[15];
  end;

  { Tipo para produtos com cod. de tributação de ICMS 40 - Isenta ou não tributada }
  TICMS40 = record
    Origem: string[01];
    CST: string[02];
  end;

  { Tipo para produtos com cod. de tributação de ICMS 51 - Diferimento }
  TICMS51 = record
    Origem: string[01];
    CST: string[02];
    Modalidade: string[01];
    PercentualReducao: string[06];
    BaseCalculo: string[15];
    Aliquota: string[05];
    ICMS: string[15];
  end;

  { Tipo para produtos com cod. de tributação de ICMS 60 - ICMS cobrado anteriormente por substituicao }
  TICMS60 = record
    Origem: string[01];
    CST: string[02];
    BaseSubstituicao: string[15];
    ICMSSubstituicao: string[15];
  end;

  { Tipo para produtos com cod. de tributação de ICMS 70 - Com redução de base de calculo e cobranca do ICMS por substituição tributaria }
  TICMS70 = record
    Origem: string[01];
    CST: string[02];
    Modalidade: string[01];
    PercentualReducao: string[06];
    BaseCalculo: string[15];
    Aliquota: string[05];
    ICMS: string[15];
    ModalidadeSubstituicao: string[01];
    PercentualMargem: string[06];
    PercentualReducao70: string[06];
    BaseSubstituicao: string[15];
    AliquotaSubstituicao: string[05];
    ICMSSubstituicao: string[15];
  end;

  { Tipo para produtos com cod. de tributação de ICMS 90- Outros }
  TICMS90 = record
    Origem: string[01];
    CST: string[02];
    Modalidade: string[01];
    PercentualReducao: string[06];
    BaseCalculo: string[15];
    Aliquota: string[05];
    ICMS: string[15];
    ModalidadeSubstituicao: string[01];
    PercentualMargem: string[06];
    PercentualReducao90: string[06];
    BaseSubstituicao: string[15];
    AliquotaSubstituicao: string[05];
    ICMSSubstituicao: string[15];
  end;

  { Tipo "TICMSSN101" para produtos com cod. de tributação de ICMS SIMPLES NACIONAL:
    101-Tributado poli Simples Nacional com Permissão de Crédito }
  TICMSSN101 = record
    Origem: string[01]; { 0 – Nacional; 1 – Estrangeira – Importação direta;2 – Estrangeira – Adquirida no mercado interno. }
    CSOSN: string[03];
    pCredSN: string[05];
    vCredICMSSN: string[15];
  end;

  { Tipo "TICMSSN102" para produtos com cod. de tributação de ICMS SIMPLES NACIONAL:
    102-Tributada pelo Simples Nacional sem permissão de crédito.
    103–Isenção do ICMS no Simples Nacional para faixa de receita bruta.
    300–Imune.
    400–Não tributada pelo Simples Nacional }
  TICMSSN102 = record
    Origem: string[01];
    CSOSN: string[03];
  end;

  { Tipo "TICMSSN201" para produtos com cod. de tributação de ICMS SIMPLES NACIONAL:
    201-Tributada pelo Simples Nacional com permissão de crédito e com cobrança do ICMS por Substituição Tributária }
  TICMSSN201 = record
    Origem: string[01];
    CSOSN: string[03];
    modBCST: string[01];
    pMVAST: string[05];
    pRedBCST: string[05];
    vBCST: string[15];
    pICMSST: string[05];
    vICMSST: string[15];
    pCredSN: string[05];
    vCredICMSSN: string[15];
  end;

  { Tipo "TICMSSN202" para produtos com cod. de tributação de ICMS SIMPLES NACIONAL:
    202-Tributada pelo Simples Nacional sem permissão de crédito e com cobrança do ICMS por Substituição Tributária
    203-Isenção do ICMS nos Simples Nacional para faixa de receita bruta e com cobrança do ICMS por Substituição Tributária }
  TICMSSN202 = record
    Origem: string[01];
    CSOSN: string[03];
    modBCST: string[01];
    pMVAST: string[05];
    pRedBCST: string[05];
    vBCST: string[15];
    pICMSST: string[05];
    vICMSST: string[15];
  end;

  { Tipo "TICMSSN500" para produtos com cod. de tributação de ICMS SIMPLES NACIONAL:
    500–ICMS cobrado anteriormente por substituição tributária (substituído) ou por antecipação }
  TICMSSN500 = record
    Origem: string[01];
    CSOSN: string[03];
    vBCSTRet: string[15];
    vICMSSTRet: string[15];
  end;

  { Tipo "TICMSSN900" para produtos com cod. de tributação de ICMS SIMPLES NACIONAL:
    900-Outros }
  TICMSSN900 = record
    Origem: string[01];
    CSOSN: string[03];
    modBC: string[01];
    vBC: string[15];
    pRedBC: string[05];
    pICMS: string[05];
    vICMS: string[15];
    modBCST: string[01];
    pMVAST: string[05];
    pRedBCST: string[05];
    vBCST: string[15];
    pICMSST: string[05];
    vICMSST: string[15];
    pCredSN: string[05];
    vCredICMSSN: string[15];
  end;

  { IPI }
  TIPI = record
    ClasseEnquadramento: string[05];
    CNPJProduto: string[14];
    Selo: string;
    QuantidadeSelo: string[12];
    CodigoEnquadramento: string[03];
  end;

  { IPI Imposto }
  TIPITributavel = record
    CST: string[02];
    IPI: string[15];
    BaseCalculo: string[15];
    Aliquota: string[05];
    ValorUnidade: string[15];
    Quantidade: string[16];
  end;

  { IPI Não tributavel }
  TIPINaoTributavel = record
    CST: string[02];
  end;

  TPISTributavelAliquota = record
    CST: string[02];
    BaseCalculo: string[15];
    Aliquota: string[05];
    Valor: string[15];
  end;

  TPISOutros = record
    CST: string[02];
    BaseCalculo: string[15];
    Aliquota: string[05];
    QtdBcProd: string[16];
    AliquotaPisValor: string[15];
    Valor: string[15];
  end;

  TPisNaoTributavel = record
    CST: String[02];
  end;

  TCOFINSOutros = record
    CST: string[02];
    BaseCalculo: string[15];
    Aliquota: string[05];
    QtdBcProd: string[16];
    AliquotaCofinsValor: string[15];
    Valor: string[15];
  end;

  TCOFINSTributadoAliquota = record
    CST: string[02];
    BaseCalculo: string[15];
    Aliquota: string[05];
    Valor: string[15];
  end;

  TCofinsNaoTributavel = record
    CST: String[02];
  end;

  { Item da nota fiscal }
  TItemNota = record
    NumeroItem: string[03];
    CodProduto: string[60];
    CodEan: string[14];
    Descricao: string[120];
    CodMercosul: string[08];
    ExTipi: string[03];
    Genero: string[02];
    CFOP: string[04];
    Unidade: string[06];
    Quantidade: string[12];
    ValorUnitario: string[16];
    ValorTotalProd: string[15];
    CodEANTrib: string[14];
    UnidadeTrib: string[06];
    QuantTrib: string[12];
    ValorUniTrib: string[16];
    Frete: string[15];
    Seguro: string[15];
    Desconto: string[15];
    ICMS00: TICMS00;
    ICMS10: TICMS10;
    ICMS20: TICMS20;
    ICMS30: TICMS30;
    ICMS40: TICMS40;
    ICMS41: TICMS40;
    ICMS50: TICMS40;
    ICMS51: TICMS51;
    ICMS60: TICMS60;
    ICMS70: TICMS70;
    ICMS90: TICMS90;
    ICMSSN101: TICMSSN101;
    ICMSSN102: TICMSSN102;
    ICMSSN201: TICMSSN201;
    ICMSSN202: TICMSSN202;
    ICMSSN500: TICMSSN500;
    ICMSSN900: TICMSSN900;
    IPI: TIPI;
    IPITributavel: TIPITributavel;
    IPINaoTributavel: TIPINaoTributavel;
    PisNaoTributavel: TPisNaoTributavel;
    PisOutros: TPISOutros;
    COFINSOutros: TCOFINSOutros;
    CofinsNaoTributavel: TCofinsNaoTributavel;
    PISTributavelAliquota: TPISTributavelAliquota;
    COFINSTributadoAliquota: TCOFINSTributadoAliquota;
    IndTot: String[01];
  end;

  { Total da nota }
  TTotal = record
    BaseICMS: string[15];
    ICMS: string[15];
    BaseSubstituicao: string[15];
    Substituicao: string[15];
    TotalProdutos: string[15];
    Frete: string[15];
    Seguro: string[15];
    Desconto: string[15];
    II: string[15];
    IPI: string[15];
    Pis: string[15];
    COFINS: string[15];
    Outro: string[15];
    TotalNF: string[15];
  end;

  { Informacoes Transportadora }
  TTransporte = record
    Modalidade: string[01];
    Nome: string[60];
    InscEstadual: string[14];
    Endereco: string[60];
    Municpio: string[60];
    UF: string[02];
    CNPJ: string[14];
    CPF: string[11];
    Placa: string[08];
    UFTransp: string[02];
    RegistroTransp: string[20];
    QuantidadeVolume: string[15];
    EspecieVolume: string[60];
    MarcaVaolume: string[60];
    NumeracaoVolume: string[60];
    PesoLiquido: string[15];
    PesoBruto: string[15];
    Email: string[90];
  end;

  { Informacoes de Cobranca }
  TCobranca = record
    NumFatura: string;
    Valor: string;
    Desconto: string;
    VlLiquido: string;
    Duplicata: string;
    VencDup: string;
    ValorDup: string;
    Desc: String;
  end;

  { Informações adicionais }
  TInformacoes = record
    InfFisco: string[100];
    InfComplementar: string;
  end;

  TNFeXML = class(Tcomponent)
  private
    { Private declarations }

    procedure AdicionaEndereco(Ender: TEndereco);
  protected
    { Protected declarations }
    strNomeArquivo: string;
  public
    { Public declarations }
    Emitente: TEmitente;
    Destinatario: TDestinatario;
    Cabecalho: TCabecalho;
    Entrega: TEntrega;
    ItemNota: TItemNota;
    Total: TTotal;
    Transportadora: TTransporte;
    Cobranca: TCobranca;
    Informacoes: TInformacoes;
    Arquivo: TStrings;
    IdentificadorNF: string;
    IdLote: string;
    VersaoNfe: String;

    constructor Create(Aowner: Tcomponent); override;
    destructor Destroy; override;

    { Procedure e Functions publicas }
    procedure IniciaNF;
    procedure AdicionaCabecalho;
    procedure AdicionaEmitente;
    procedure AdicionaDestinatario;
    procedure AdicionaItemNota;
    procedure AdicionaTotal;
    procedure AdicionaTransportadora;
    procedure AdicionaCobranca(Tipo: string);
    procedure AdicionaInformacoes;
    procedure FinalizaNF;

    { Propriedades do componente }
    { property Cabecalho      : TCabecalho     read pCabecalho     write pCabecalho;
      property Emitente       : TEmitente      read pEmitente      write pEmitente;
      property Destinatario   : TDestinatario  read pDestinatario  write pDestinatario;
      property Entrega        : TEntrega       read pEntrega       write pEntrega;
      property ItemNota       : TItemNota      read pItemNota      write pItemNota;
      property Total          : TTotal         read pTotal         write pTotal;
      property Transportadora : TTransporte    read pTransporte    write pTransporte;
      property Cobranca       : TCobranca      read pCobranca      write pCobranca;
      property Informacoes    : TInformacoes   read pInformacoes   write pInformacoes; }

  published
    property NomeArquivo: string read strNomeArquivo write strNomeArquivo;
  end;

function retirar_quebra_linha(texto: string): string;
function CellToFloat(Valor: String): Real;
function DesmascaraNumero(StringNum: String): String;
function Numerico(S: String): Boolean;
Function SubstituiString(texto, TextoASubstituir, NovoTexto: String): String;

procedure Register;
function Empty(Variable: Variant): Boolean;

implementation

uses Variants;

{ ****************************************************************************** }

procedure Register;
begin
  RegisterComponents('NFe', [TNFeXML]);
end;

{ ****************************************************************************** }

Function SubstituiString(texto, TextoASubstituir, NovoTexto: String): String;
begin
  Result := StringReplace(texto, TextoASubstituir, NovoTexto, [rfReplaceAll]);
end;

function Numerico(S: String): Boolean;
var
  C: Byte;
begin
  Result := true;
  if S = '' then
  begin
    Result := false;
    exit;
  end;
  for C := 1 to Length(S) do
  begin
    if not(S[C] in ['0' .. '9']) then
    begin
      if (S[C] <> ',') and (S[C] <> '-') then
      begin
        Result := false;
        break;
      end;
    end;
  end;
end;

function DesmascaraNumero(StringNum: String): String;
var
  C: Byte;
begin
  for C := 1 to Length(StringNum) do
  begin
    if not(StringNum[C] in ['0' .. '9', '-', SysUtils.FormatSettings.DecimalSeparator]) then
    begin
      Delete(StringNum, C, 1);
      StringNum := ' ' + StringNum;
    end;
  end;
  if StringNum = '-' then
  begin // no caso de o número contiver somente um sinal de menos.
    StringNum := StringNum + '0';
  end;
  Result := Trim(StringNum);
end;

function CellToFloat(Valor: String): Real;
begin
  if Valor = '' then
    Valor := '0';
  if Numerico(DesmascaraNumero(Valor)) then
  begin
    Result := StrToFloat(DesmascaraNumero(Valor));
  end
  else
    Result := StrToFloat(DesmascaraNumero('0'));
end;

function Empty(Variable: Variant): Boolean;
var
  Indice: Word;
begin
  Result := false;

  case (VarType(Variable)) of
    varEmpty, varNull:
      Result := true;
    varInteger:
      Result := (Variable = 0);
    varDouble:
      Result := (Variable = 0.00);
    varDate:
      Result := (Variable = 0);
    varString:
      begin
        Result := true;

        for Indice := 1 to Length(Variable) do
        begin
          if (Copy(Variable, Indice, 1) <> ' ') then
          begin
            Result := false;
            break;
          end;
        end;
      end;
  end;
end;

{ ****************************************************************************** }
{ TNFeXML }
{ ****************************************************************************** }
constructor TNFeXML.Create(Aowner: Tcomponent);
begin
  inherited Create(Aowner);;

end;

destructor TNFeXML.Destroy;
begin
  inherited;

end;

{ ****************************************************************************** }
{ Rotina que inicia o arquivo XML }
procedure TNFeXML.IniciaNF;
begin
  Arquivo := TStringList.Create;
  Arquivo.Add('<?xml version="1.0" encoding="UTF-8"?>');
  if (VersaoNfe = '2') then
  begin
    Arquivo.Add('<enviNFe xmlns="http://www.portalfiscal.inf.br/nfe" versao="2.00">');
  end
  else
  begin
    Arquivo.Add('<enviNFe xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns="http://www.portalfiscal.inf.br/nfe" versao="1.10">');
  end;
  Arquivo.Add('<idLote>' + IdLote + '</idLote>');
  // Arquivo.Add('<NFe xmlns="http://www.portalfiscal.inf.br/nfe">');
  // Arquivo.Add('<infNFe versao='+'"1.10"' + ' Id="' + IdentificadorNF+ '">');
  // Arquivo.Add('<infNFe xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" Id="' + IdentificadorNF + '" versao="1.10">');

  // Arquivo.Add('<NFe xmlns="http://www.portalfiscal.inf.br/nfe" xmlns:ds="http://www.w3.org/2000/09/xmldsig#" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://www.portalfiscal.inf.br/nfe enviNFe.xsd">');
  // Arquivo.Add('<enviNFe xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns="http://www.portalfiscal.inf.br/nfe" versao="1.10">');
  // Arquivo.Add('<NFe xmlns="http://www.portalfiscal.inf.br/nfe">');
  // Arquivo.Add('<infNFe versao="1.10" Id="'+ IdentificadorNF+'">');
  // Arquivo.Add('<infNFe Id="NFe4306039266561101315555099000006992000705547" versao="1.02">');
end;

{ ****************************************************************************** }
{ Monta a identificacao da NF eletronica }
{ ****************************************************************************** }
procedure TNFeXML.AdicionaCabecalho;
begin
  Arquivo.Add('<NFe xmlns="http://www.portalfiscal.inf.br/nfe">');
  if (VersaoNfe = '2') then
  begin // VERSAO NFE 2.00
    Arquivo.Add('<infNFe versao="2.00" Id="' + IdentificadorNF + '">');
  end
  else
  begin
    Arquivo.Add('<infNFe versao="1.10" Id="' + IdentificadorNF + '">');
  end;

  Arquivo.Add('<ide>');

  if not Empty(Cabecalho.CodUF) then
    Arquivo.Add('<cUF>' + Cabecalho.CodUF + '</cUF>');

  if not Empty(Cabecalho.ChaveAcesso) then
    Arquivo.Add('<cNF>' + Cabecalho.ChaveAcesso + '</cNF>');

  if not Empty(Cabecalho.NaturezaOp) then
    Arquivo.Add('<natOp>' + Cabecalho.NaturezaOp + '</natOp>');

  if not Empty(Cabecalho.FormaPagamento) then
    Arquivo.Add('<indPag>' + Cabecalho.FormaPagamento + '</indPag>');

  if not Empty(Cabecalho.ModeloNota) then
    Arquivo.Add('<mod>' + Cabecalho.ModeloNota + '</mod>');

  if not Empty(Cabecalho.Serie) then
    Arquivo.Add('<serie>' + Cabecalho.Serie + '</serie>');

  if not Empty(Cabecalho.NumeroNF) then
    Arquivo.Add('<nNF>' + Cabecalho.NumeroNF + '</nNF>');

  if not Empty(Cabecalho.Emissao) then
    Arquivo.Add('<dEmi>' + FormatDateTime('yyyy-mm-dd', Cabecalho.Emissao) + '</dEmi>');

  if not Empty(Cabecalho.DataEntSai) then
    Arquivo.Add('<dSaiEnt>' + FormatDateTime('yyyy-mm-dd', Cabecalho.DataEntSai) + '</dSaiEnt>');

  if (VersaoNfe = '2') then
  begin // VERSAO NFE 2.00
    if not Empty(Cabecalho.HoraEntSai) then
      Arquivo.Add('<hSaiEnt>' + FormatDateTime('HH:MM:SS', Cabecalho.HoraEntSai) + '</hSaiEnt>');
  end;

  if not Empty(Cabecalho.TipoNF) then
    Arquivo.Add('<tpNF>' + Cabecalho.TipoNF + '</tpNF>');

  if not Empty(Cabecalho.CodMunicipio) then
    Arquivo.Add('<cMunFG>' + Cabecalho.CodMunicipio + '</cMunFG>');

  if not Empty(Cabecalho.FormatoDanfe) then
    Arquivo.Add('<tpImp>' + Cabecalho.FormatoDanfe + '</tpImp>');

  if not Empty(Cabecalho.FormaEmissao) then
    Arquivo.Add('<tpEmis>' + Cabecalho.FormaEmissao + '</tpEmis>');

  if not Empty(Cabecalho.DigitoChave) then
    Arquivo.Add('<cDV>' + Cabecalho.DigitoChave + '</cDV>');

  if not Empty(Cabecalho.Ambiente) then
    Arquivo.Add('<tpAmb>' + Cabecalho.Ambiente + '</tpAmb>');

  if not Empty(Cabecalho.Finalidade) then
    Arquivo.Add('<finNFe>' + Cabecalho.Finalidade + '</finNFe>');

  Arquivo.Add('<procEmi>0</procEmi>');

  if not Empty(Cabecalho.VersaoApp) then
    Arquivo.Add('<verProc>' + Cabecalho.VersaoApp + '</verProc>');

  Arquivo.Add('</ide>');
end;

{ ****************************************************************************** }
{ Monta o emitente }
{ ****************************************************************************** }
procedure TNFeXML.AdicionaEmitente;
begin
  Arquivo.Add('<emit>');

  if not Empty(Emitente.CNPJ) then
    Arquivo.Add('<CNPJ>' + Emitente.CNPJ + '</CNPJ>');

  if not Empty(Emitente.CPF) then
    Arquivo.Add('<CPF>' + Emitente.CPF + '</CPF>');

  if not Empty(Emitente.Nome) then
    Arquivo.Add('<xNome>' + Emitente.Nome + '</xNome>');

  Arquivo.Add('<enderEmit>');
  AdicionaEndereco(Emitente.Endereco);
  Arquivo.Add('</enderEmit>');

  if not Empty(Emitente.InscEstadual) then
    Arquivo.Add('<IE>' + Emitente.InscEstadual + '</IE>');

  if not Empty(Emitente.InscSubstituto) then
    Arquivo.Add('<IEST>' + Emitente.InscSubstituto + '</IEST>');

  if not Empty(Emitente.InscMunicipal) then
    Arquivo.Add('<IM>' + Emitente.InscMunicipal + '</IM>');

  if not Empty(Emitente.CNAE) then
    Arquivo.Add('<CNAE>' + Emitente.CNAE + '</CNAE>');

  if (VersaoNfe = '2') then
  begin // VERSAO NFE 2.00
    if not Empty(Emitente.CRT) then
      Arquivo.Add('<CRT>' + Emitente.CRT + '</CRT>');
  end;

  Arquivo.Add('</emit>');
end;

{ ****************************************************************************** }
{ Monta Endereco }
{ ****************************************************************************** }
procedure TNFeXML.AdicionaEndereco(Ender: TEndereco);
begin
  if not Empty(Ender.Logradouro) then
    Arquivo.Add('<xLgr>' + Ender.Logradouro + '</xLgr>');

  if not Empty(Ender.Numero) then
    Arquivo.Add('<nro>' + Ender.Numero + '</nro>')
  else
    Arquivo.Add('<nro>' + 'S/N' + '</nro>');

  if not Empty(Ender.Complemento) then
    Arquivo.Add('<xCpl>' + Ender.Complemento + '</xCpl>');

  if not Empty(Ender.Bairro) then
    Arquivo.Add('<xBairro>' + Ender.Bairro + '</xBairro>');

  if not Empty(Ender.CodMunicipio) then
    Arquivo.Add('<cMun>' + Ender.CodMunicipio + '</cMun>');

  if not Empty(Ender.Municipio) then
    Arquivo.Add('<xMun>' + Ender.Municipio + '</xMun>');

  if not Empty(Ender.UF) then
    Arquivo.Add('<UF>' + Ender.UF + '</UF>');

  if not Empty(Ender.CEP) then
    Arquivo.Add('<CEP>' + Ender.CEP + '</CEP>');

  if not Empty(Ender.CodPais) then
    Arquivo.Add('<cPais>' + Ender.CodPais + '</cPais>');

  if not Empty(Ender.Pais) then
    Arquivo.Add('<xPais>' + Ender.Pais + '</xPais>');

  if not Empty(Ender.Telefone) then
    Arquivo.Add('<fone>' + Ender.Telefone + '</fone>');

end;

{ ****************************************************************************** }
{ Adiciona destinatario }
{ ****************************************************************************** }

procedure TNFeXML.AdicionaDestinatario;
begin
  Arquivo.Add('<dest>');

  if not Empty(Destinatario.CNPJ) then
    Arquivo.Add('<CNPJ>' + Destinatario.CNPJ + '</CNPJ>');

  if not Empty(Destinatario.CPF) then
    Arquivo.Add('<CPF>' + Destinatario.CPF + '</CPF>');

  if not Empty(Destinatario.Nome) then
    Arquivo.Add('<xNome>' + Destinatario.Nome + '</xNome>');

  Arquivo.Add('<enderDest>');
  AdicionaEndereco(Destinatario.Endereco);
  Arquivo.Add('</enderDest>');

  if not Empty(Destinatario.InscEstadual) then
    Arquivo.Add('<IE>' + Destinatario.InscEstadual + '</IE>');

  if not Empty(Destinatario.InscSuframa) then
    Arquivo.Add('<ISUF>' + Destinatario.InscSuframa + '</ISUF>');

  Arquivo.Add('</dest>');
end;

{ ****************************************************************************** }
{ Adiciona Item ao NF }
{ ****************************************************************************** }
procedure TNFeXML.AdicionaItemNota;
begin
  if not Empty(ItemNota.NumeroItem) then
  begin
    Arquivo.Add('<det nItem="' + ItemNota.NumeroItem + '">');
    ItemNota.NumeroItem := '';
  end;

  Arquivo.Add('<prod>');

  if not Empty(ItemNota.CodProduto) then
  begin
    Arquivo.Add('<cProd>' + ItemNota.CodProduto + '</cProd>');
    ItemNota.CodProduto := '';
  end;

  if not Empty(ItemNota.CodEan) then
  begin
    Arquivo.Add('<cEAN>' + ItemNota.CodEan + '</cEAN>');
    ItemNota.CodEan := '';
  end
  else
    Arquivo.Add('<cEAN/>');

  if not Empty(ItemNota.Descricao) then
  begin
    Arquivo.Add('<xProd>' + ItemNota.Descricao + '</xProd>');
    ItemNota.Descricao := '';
  end;

  if not Empty(ItemNota.CodMercosul) then
  begin
    Arquivo.Add('<NCM>' + ItemNota.CodMercosul + '</NCM>');
    ItemNota.CodMercosul := '';
  end;

  if not Empty(ItemNota.ExTipi) then
  begin
    Arquivo.Add('<EXTIPI>' + ItemNota.ExTipi + '</EXTIPI>');
    ItemNota.ExTipi := '';
  end;

  if not Empty(ItemNota.Genero) then
  begin
    Arquivo.Add('<genero>' + ItemNota.Genero + '</genero>');
    ItemNota.Genero := '';
  end;

  if not Empty(ItemNota.CFOP) then
  begin
    Arquivo.Add('<CFOP>' + ItemNota.CFOP + '</CFOP>');
    ItemNota.CFOP := '';
  end;

  if not Empty(ItemNota.Unidade) then
  begin
    Arquivo.Add('<uCom>' + ItemNota.Unidade + '</uCom>');
    ItemNota.Unidade := '';
  end;

  if not Empty(ItemNota.Quantidade) then
  begin
    Arquivo.Add('<qCom>' + ItemNota.Quantidade + '</qCom>');
    ItemNota.Quantidade := '';
  end;

  if not Empty(ItemNota.ValorUnitario) then
  begin
    Arquivo.Add('<vUnCom>' + ItemNota.ValorUnitario + '</vUnCom>');
    ItemNota.ValorUnitario := '';
  end;

  if not Empty(ItemNota.ValorTotalProd) then
  begin
    Arquivo.Add('<vProd>' + ItemNota.ValorTotalProd + '</vProd>');
    ItemNota.ValorTotalProd := '';
  end;

  if not Empty(ItemNota.CodEANTrib) then
  begin
    Arquivo.Add('<cEANTrib>' + ItemNota.CodEANTrib + '</cEANTrib>');
    ItemNota.CodEANTrib := '';
  end
  else
    Arquivo.Add('<cEANTrib/>');

  if not Empty(ItemNota.UnidadeTrib) then
  begin
    Arquivo.Add('<uTrib>' + ItemNota.UnidadeTrib + '</uTrib>');
    ItemNota.UnidadeTrib := '';
  end;

  if not Empty(ItemNota.QuantTrib) then
  begin
    Arquivo.Add('<qTrib>' + ItemNota.QuantTrib + '</qTrib>');
    ItemNota.QuantTrib := '';
  end;

  if not Empty(ItemNota.ValorUniTrib) then
  begin
    Arquivo.Add('<vUnTrib>' + ItemNota.ValorUniTrib + '</vUnTrib>');
    ItemNota.ValorUniTrib := '';
  end;

  if not Empty(ItemNota.Frete) then
  begin
    Arquivo.Add('<vFrete>' + ItemNota.Frete + '</vFrete>');
    ItemNota.Frete := '';
  end;

  if not Empty(ItemNota.Seguro) then
  begin
    Arquivo.Add('<vSeg>' + ItemNota.Seguro + '</vSeg>');
    ItemNota.Seguro := '';
  end;

  if not Empty(ItemNota.Desconto) then
  begin
    if CellToFloat(ItemNota.Desconto) > 0 then
    begin
      Arquivo.Add('<vDesc>' + ItemNota.Desconto + '</vDesc>');
      ItemNota.Desconto := '';
    end;
  end;

  if (VersaoNfe = '2') then
  begin // VERSAO NFE 2.00
    if not Empty(ItemNota.IndTot) then
    begin
      Arquivo.Add('<indTot>' + ItemNota.IndTot + '</indTot>');
      ItemNota.IndTot := '';
    end;
  end;

  Arquivo.Add('</prod>');

  if (not Empty(ItemNota.ICMS00.Origem)) or (not Empty(ItemNota.ICMS10.Origem)) or (not Empty(ItemNota.ICMS20.Origem)) or
    (not Empty(ItemNota.ICMS30.Origem)) or (not Empty(ItemNota.ICMS40.Origem)) or (not Empty(ItemNota.ICMS50.Origem)) or
    (not Empty(ItemNota.ICMS51.Origem)) or (not Empty(ItemNota.ICMS70.Origem)) or (not Empty(ItemNota.ICMS90.Origem)) or
    (not Empty(ItemNota.PISTributavelAliquota.CST)) or (not Empty(ItemNota.PisOutros.CST)) or (not Empty(ItemNota.COFINSOutros.CST)) or
    (not Empty(ItemNota.COFINSTributadoAliquota.CST)) or (not Empty(ItemNota.PisNaoTributavel.CST)) or (not Empty(ItemNota.CofinsNaoTributavel.CST))
    or (not Empty(ItemNota.ICMSSN101.Origem)) or (not Empty(ItemNota.ICMSSN102.Origem)) or (not Empty(ItemNota.ICMSSN201.Origem)) or
    (not Empty(ItemNota.ICMSSN202.Origem)) or (not Empty(ItemNota.ICMSSN500.Origem)) or (not Empty(ItemNota.ICMSSN900.Origem))

  then
    Arquivo.Add('<imposto>');

  { 00 - Tributada Integralmente }
  if not Empty(ItemNota.ICMS00.Origem) then
  begin
    Arquivo.Add('<ICMS>');
    Arquivo.Add('<ICMS00>');

    Arquivo.Add('<orig>' + ItemNota.ICMS00.Origem + '</orig>');
    Arquivo.Add('<CST>' + ItemNota.ICMS00.CST + '</CST>');
    Arquivo.Add('<modBC>' + ItemNota.ICMS00.Modalidade + '</modBC>');
    Arquivo.Add('<vBC>' + ItemNota.ICMS00.BaseCalculo + '</vBC>');
    Arquivo.Add('<pICMS>' + ItemNota.ICMS00.Aliquota + '</pICMS>');
    Arquivo.Add('<vICMS>' + ItemNota.ICMS00.ICMS + '</vICMS>');

    Arquivo.Add('</ICMS00>');
    Arquivo.Add('</ICMS>');

  end;

  { 10  Tributada e com cobranca do ICMS }
  if not Empty(ItemNota.ICMS10.Origem) then
  begin
    Arquivo.Add('<ICMS>');
    Arquivo.Add('<ICMS10>');
    Arquivo.Add('<orig>' + ItemNota.ICMS10.Origem + '</orig>');
    Arquivo.Add('<CST>' + ItemNota.ICMS10.CST + '</CST>');
    Arquivo.Add('<modBC>' + ItemNota.ICMS10.Modalidade + '</modBC>');
    Arquivo.Add('<vBC>' + ItemNota.ICMS10.BaseCalculo + '</vBC>');
    Arquivo.Add('<pICMS>' + ItemNota.ICMS10.Aliquota + '</pICMS>');
    Arquivo.Add('<vICMS>' + ItemNota.ICMS10.ICMS + '</vICMS>');
    Arquivo.Add('<modBCST>' + ItemNota.ICMS10.Modalidade10 + '</modBCST>');

    if ItemNota.ICMS10.PercentualMargem <> '00.00' then
      if not Empty(ItemNota.ICMS10.PercentualMargem) then
        if CellToFloat(SubstituiString(ItemNota.ICMS10.PercentualMargem, '.', ',')) <> 0 then
          Arquivo.Add('<pMVAST>' + ItemNota.ICMS10.PercentualMargem + '</pMVAST>');

    if ItemNota.ICMS10.PercentualReducao10 <> '00.00' then
      if not Empty(ItemNota.ICMS10.PercentualReducao10) then
        if CellToFloat(SubstituiString(ItemNota.ICMS10.PercentualReducao10, '.', ',')) <> 0 then
          Arquivo.Add('<pRedBCST>' + ItemNota.ICMS10.PercentualReducao10 + '</pRedBCST>');

    Arquivo.Add('<vBCST>' + ItemNota.ICMS10.BaseSubstituicao + '</vBCST>');
    Arquivo.Add('<pICMSST>' + ItemNota.ICMS10.AliquotaSubstituicao + '</pICMSST>');
    Arquivo.Add('<vICMSST>' + ItemNota.ICMS10.ICMSSubstituicao + '</vICMSST>');

    Arquivo.Add('</ICMS10>');
    Arquivo.Add('</ICMS>');

  end;

  { 20 Tributada com redução de base de calculo }
  if not Empty(ItemNota.ICMS20.Origem) then
  begin
    Arquivo.Add('<ICMS>');
    Arquivo.Add('<ICMS20>');
    Arquivo.Add('<orig>' + ItemNota.ICMS20.Origem + '</orig>');
    Arquivo.Add('<CST>' + ItemNota.ICMS20.CST + '</CST>');
    Arquivo.Add('<modBC>' + ItemNota.ICMS20.Modalidade20 + '</modBC>');
    Arquivo.Add('<pRedBC>' + ItemNota.ICMS20.PercentualReducao + '</pRedBC>');
    Arquivo.Add('<vBC>' + ItemNota.ICMS20.BaseCalculo + '</vBC>');
    Arquivo.Add('<pICMS>' + ItemNota.ICMS20.Aliquota + '</pICMS>');
    Arquivo.Add('<vICMS>' + ItemNota.ICMS20.ICMS + '</vICMS>');
    Arquivo.Add('</ICMS20>');
    Arquivo.Add('</ICMS>');

  end;

  { 30 Isenta ou não tributada }
  if not Empty(ItemNota.ICMS30.Origem) then
  begin
    Arquivo.Add('<ICMS>');
    Arquivo.Add('<ICMS30>');
    Arquivo.Add('<orig>' + ItemNota.ICMS30.Origem + '</orig>');
    Arquivo.Add('<CST>' + ItemNota.ICMS30.CST + '</CST>');
    Arquivo.Add('<modBCST>' + ItemNota.ICMS30.Modalidade + '</modBCST>');

    if not Empty(ItemNota.ICMS30.PercentualMargem) then
      if ItemNota.ICMS30.PercentualMargem <> '00.00' then
        if CellToFloat(SubstituiString(ItemNota.ICMS30.PercentualMargem, '.', ',')) <> 0 then
          Arquivo.Add('<pMVAST>' + ItemNota.ICMS30.PercentualMargem + '</pMVAST>');

    if not Empty(ItemNota.ICMS30.PercentualReducao) then
      if ItemNota.ICMS30.PercentualReducao <> '00.00' then
        if CellToFloat(SubstituiString(ItemNota.ICMS30.PercentualReducao, '.', ',')) <> 0 then
          Arquivo.Add('<pRedBCST>' + ItemNota.ICMS30.PercentualReducao + '</pRedBCST>');

    Arquivo.Add('<vBCST>' + ItemNota.ICMS30.BaseSubstituicao + '</vBCST>');
    Arquivo.Add('<pICMSST>' + ItemNota.ICMS30.AliquotaSubstituicao + '</pICMSST>');
    Arquivo.Add('<vICMSST>' + ItemNota.ICMS30.ICMSSubstituicao + '</vICMSST>');
    Arquivo.Add('</ICMS30>');
    Arquivo.Add('</ICMS>');

  end;

  { 40 isenta }
  if not Empty(ItemNota.ICMS40.Origem) then
  begin
    Arquivo.Add('<ICMS>');
    Arquivo.Add('<ICMS40>');
    Arquivo.Add('<orig>' + ItemNota.ICMS40.Origem + '</orig>');
    Arquivo.Add('<CST>' + ItemNota.ICMS40.CST + '</CST>');
    Arquivo.Add('</ICMS40>');
    Arquivo.Add('</ICMS>');

  end;

  { 41 Não tributada }
  if not Empty(ItemNota.ICMS41.Origem) then
  begin
    Arquivo.Add('<ICMS>');
    Arquivo.Add('<ICMS41>');
    Arquivo.Add('<orig>' + ItemNota.ICMS41.Origem + '</orig>');
    Arquivo.Add('<CST>' + ItemNota.ICMS41.CST + '</CST>');
    Arquivo.Add('</ICMS41>');
    Arquivo.Add('</ICMS>');

  end;

  { 50 Suspensão }
  if not Empty(ItemNota.ICMS50.Origem) then
  begin
    Arquivo.Add('<ICMS>');
    Arquivo.Add('<ICMS50>');
    Arquivo.Add('<orig>' + ItemNota.ICMS50.Origem + '</orig>');
    Arquivo.Add('<CST>' + ItemNota.ICMS50.CST + '</CST>');
    Arquivo.Add('</ICMS50>');
    Arquivo.Add('</ICMS>');

  end;

  { 51 Diferimento }
  if not Empty(ItemNota.ICMS51.Origem) then
  begin
    Arquivo.Add('<ICMS>');
    Arquivo.Add('<ICMS51>');
    Arquivo.Add('<orig>' + ItemNota.ICMS51.Origem + '</orig>');
    Arquivo.Add('<CST>' + ItemNota.ICMS51.CST + '</CST>');
    Arquivo.Add('<modBC>' + ItemNota.ICMS51.Modalidade + '</modBC>');
    Arquivo.Add('<pRedBC>' + ItemNota.ICMS51.PercentualReducao + '</pRedBC>');
    Arquivo.Add('<vBC>' + ItemNota.ICMS51.BaseCalculo + '</vBC>');
    Arquivo.Add('<pICMS>' + ItemNota.ICMS51.Aliquota + '</pICMS>');
    Arquivo.Add('<vICMS>' + ItemNota.ICMS51.ICMS + '</vICMS>');
    Arquivo.Add('</ICMS51>');
    Arquivo.Add('</ICMS>');

  end;

  { 60 ICMS cobrado anteriormente por substituicao tributaria }
  if (VersaoNfe = '2') then
  begin
    if not Empty(ItemNota.ICMS60.Origem) then
    begin
      Arquivo.Add('<ICMS>');
      Arquivo.Add('<ICMS60>');
      Arquivo.Add('<orig>' + ItemNota.ICMS60.Origem + '</orig>');
      Arquivo.Add('<CST>' + ItemNota.ICMS60.CST + '</CST>');
      Arquivo.Add('<vBCSTRet>' + ItemNota.ICMS60.BaseSubstituicao + '</vBCSTRet>');
      Arquivo.Add('<vICMSSTRet>' + ItemNota.ICMS60.ICMSSubstituicao + '</vICMSSTRet>');
      Arquivo.Add('</ICMS60>');
      Arquivo.Add('</ICMS>');
    end;
  end
  else
  begin
    if not Empty(ItemNota.ICMS60.Origem) then
    begin
      Arquivo.Add('<ICMS>');
      Arquivo.Add('<ICMS60>');
      Arquivo.Add('<orig>' + ItemNota.ICMS60.Origem + '</orig>');
      Arquivo.Add('<CST>' + ItemNota.ICMS60.CST + '</CST>');
      Arquivo.Add('<vBCST>' + ItemNota.ICMS60.BaseSubstituicao + '</vBCST>');
      Arquivo.Add('<vICMSST>' + ItemNota.ICMS60.ICMSSubstituicao + '</vICMSST>');
      Arquivo.Add('</ICMS60>');
      Arquivo.Add('</ICMS>');
    end;
  end;

  { 70 Com redução da base de calculo e do icms por substituicao tributaria }
  if not Empty(ItemNota.ICMS70.Origem) then
  begin
    Arquivo.Add('<ICMS>');
    Arquivo.Add('<ICMS70>');
    Arquivo.Add('<orig>' + ItemNota.ICMS70.Origem + '</orig>');
    Arquivo.Add('<CST>' + ItemNota.ICMS70.CST + '</CST>');
    Arquivo.Add('<modBC>' + ItemNota.ICMS70.Modalidade + '</modBC>');
    Arquivo.Add('<pRedBC>' + ItemNota.ICMS70.PercentualReducao + '</pRedBC>');
    Arquivo.Add('<vBC>' + ItemNota.ICMS70.BaseCalculo + '</vBC>');
    Arquivo.Add('<pICMS>' + ItemNota.ICMS70.Aliquota + '</pICMS>');
    Arquivo.Add('<vICMS>' + ItemNota.ICMS70.ICMS + '</vICMS>');
    Arquivo.Add('<modBCST>' + ItemNota.ICMS70.ModalidadeSubstituicao + '</modBCST>');

    if ItemNota.ICMS70.PercentualMargem <> '00.00' then
      if ((not Empty(ItemNota.ICMS70.PercentualMargem)) and (CellToFloat(SubstituiString(ItemNota.ICMS70.PercentualMargem, '.', ',')) <> 0)) then
        Arquivo.Add('<pMVAST>' + ItemNota.ICMS70.PercentualMargem + '</pMVAST>');
    if ItemNota.ICMS70.PercentualReducao70 <> '00.00' then
      if ((not Empty(ItemNota.ICMS70.PercentualReducao70)) and (CellToFloat(SubstituiString(ItemNota.ICMS70.PercentualReducao70, '.', ',')) <> 0))
      then
        Arquivo.Add('<pRedBCST>' + ItemNota.ICMS70.PercentualReducao70 + '</pRedBCST>');

    Arquivo.Add('<vBCST>' + ItemNota.ICMS70.BaseSubstituicao + '</vBCST>');
    Arquivo.Add('<pICMSST>' + ItemNota.ICMS70.AliquotaSubstituicao + '</pICMSST>');
    Arquivo.Add('<vICMSST>' + ItemNota.ICMS70.ICMSSubstituicao + '</vICMSST>');
    Arquivo.Add('</ICMS70>');
    Arquivo.Add('</ICMS>');

  end;

  { 90 Outros }
  if not Empty(ItemNota.ICMS90.Origem) then
  begin
    Arquivo.Add('<ICMS>');
    Arquivo.Add('<ICMS90>');
    Arquivo.Add('<orig>' + ItemNota.ICMS90.Origem + '</orig>');
    Arquivo.Add('<CST>' + ItemNota.ICMS90.CST + '</CST>');
    Arquivo.Add('<modBC>' + ItemNota.ICMS90.Modalidade + '</modBC>');
    Arquivo.Add('<vBC>' + ItemNota.ICMS90.BaseCalculo + '</vBC>');

    if ItemNota.ICMS90.PercentualReducao <> '00.00' then
      if not Empty(ItemNota.ICMS90.PercentualReducao) then
        if CellToFloat(SubstituiString(ItemNota.ICMS90.PercentualReducao, '.', ',')) <> 0 then
          Arquivo.Add('<pRedBC>' + ItemNota.ICMS90.PercentualReducao + '</pRedBC>');

    if Empty(ItemNota.ICMS90.Aliquota) then
      ItemNota.ICMS90.Aliquota := '0.00';
    Arquivo.Add('<pICMS>' + ItemNota.ICMS90.Aliquota + '</pICMS>');

    if Empty(ItemNota.ICMS90.ICMS) then
      ItemNota.ICMS90.ICMS := '0.00';
    Arquivo.Add('<vICMS>' + ItemNota.ICMS90.ICMS + '</vICMS>');

    if (ItemNota.ICMS90.ModalidadeSubstituicao = '') then
    begin
      // Arquivo.Add('<modBCST></modBCST>');
      // Arquivo.Add('<pMVAST></pMVAST>');
      // Arquivo.Add('<pRedBCST></pRedBCST>');
      // Arquivo.Add('<vBCST></vBCST>');
      // Arquivo.Add('<pICMSST></pICMSST>');
      // Arquivo.Add('<vICMSST></vICMSST>');
    end
    else
    begin
      Arquivo.Add('<modBCST>' + ItemNota.ICMS90.ModalidadeSubstituicao + '</modBCST>');
      if ItemNota.ICMS90.PercentualMargem <> '00.00' then
        if not Empty(ItemNota.ICMS90.PercentualMargem) then
          if CellToFloat(SubstituiString(ItemNota.ICMS90.PercentualMargem, '.', ',')) <> 0 then
            Arquivo.Add('<pMVAST>' + ItemNota.ICMS90.PercentualMargem + '</pMVAST>');

      if ItemNota.ICMS90.PercentualReducao <> '00.00' then
        if not Empty(ItemNota.ICMS90.PercentualReducao) then
          if CellToFloat(SubstituiString(ItemNota.ICMS90.PercentualReducao, '.', ',')) <> 0 then
            Arquivo.Add('<pRedBCST>' + ItemNota.ICMS90.PercentualReducao + '</pRedBCST>');

      if Empty(ItemNota.ICMS90.BaseSubstituicao) then
        ItemNota.ICMS90.BaseSubstituicao := '0.00';
      Arquivo.Add('<vBCST>' + ItemNota.ICMS90.BaseSubstituicao + '</vBCST>');

      if Empty(ItemNota.ICMS90.AliquotaSubstituicao) then
        ItemNota.ICMS90.AliquotaSubstituicao := '0.00';
      Arquivo.Add('<pICMSST>' + ItemNota.ICMS90.AliquotaSubstituicao + '</pICMSST>');

      if Empty(ItemNota.ICMS90.ICMSSubstituicao) then
        ItemNota.ICMS90.ICMSSubstituicao := '0.00';
      Arquivo.Add('<vICMSST>' + ItemNota.ICMS90.ICMSSubstituicao + '</vICMSST>');
    end;

    Arquivo.Add('</ICMS90>');
    Arquivo.Add('</ICMS>');
  end;

  { ICMS - SIMPLES NACIONAL }
  if not Empty(ItemNota.ICMSSN101.Origem) then
  begin
    Arquivo.Add('<ICMS>');
    Arquivo.Add('<ICMSSN101>');
    Arquivo.Add('<orig>' + ItemNota.ICMSSN101.Origem + '</orig>');
    Arquivo.Add('<CSOSN>' + ItemNota.ICMSSN101.CSOSN + '</CSOSN>');
    Arquivo.Add('<pCredSN>' + ItemNota.ICMSSN101.pCredSN + '</pCredSN>');
    Arquivo.Add('<vCredICMSSN>' + ItemNota.ICMSSN101.vCredICMSSN + '</vCredICMSSN>');
    Arquivo.Add('</ICMSSN101>');
    Arquivo.Add('</ICMS>');
  end;

  if not Empty(ItemNota.ICMSSN102.Origem) then
  begin
    Arquivo.Add('<ICMS>');
    Arquivo.Add('<ICMSSN102>');
    Arquivo.Add('<orig>' + ItemNota.ICMSSN102.Origem + '</orig>');
    Arquivo.Add('<CSOSN>' + ItemNota.ICMSSN102.CSOSN + '</CSOSN>');
    Arquivo.Add('</ICMSSN102>');
    Arquivo.Add('</ICMS>');
  end;
  if not Empty(ItemNota.ICMSSN201.Origem) then
  begin
    Arquivo.Add('<ICMS>');
    Arquivo.Add('<ICMSSN201>');
    Arquivo.Add('<orig>' + ItemNota.ICMSSN201.Origem + '</orig>');
    Arquivo.Add('<CSOSN>' + ItemNota.ICMSSN201.CSOSN + '</CSOSN>');
    Arquivo.Add('<modBCST>' + ItemNota.ICMSSN201.modBCST + '</modBCST>');
    Arquivo.Add('<pMVAST>' + ItemNota.ICMSSN201.pMVAST + '</pMVAST>');
    Arquivo.Add('<pRedBCST>' + ItemNota.ICMSSN201.pRedBCST + '</pRedBCST>');
    Arquivo.Add('<vBCST>' + ItemNota.ICMSSN201.vBCST + '</vBCST>');
    Arquivo.Add('<pICMSST>' + ItemNota.ICMSSN201.pICMSST + '</pICMSST>');
    Arquivo.Add('<vICMSST>' + ItemNota.ICMSSN201.vICMSST + '</vICMSST>');
    Arquivo.Add('<pCredSN>' + ItemNota.ICMSSN201.pCredSN + '</pCredSN>');
    Arquivo.Add('<vCredICMSSN>' + ItemNota.ICMSSN201.vCredICMSSN + '</vCredICMSSN>');
    Arquivo.Add('</ICMSSN201>');
    Arquivo.Add('</ICMS>');
  end;
  if not Empty(ItemNota.ICMSSN202.Origem) then
  begin
    Arquivo.Add('<ICMS>');
    Arquivo.Add('<ICMSSN202>');
    Arquivo.Add('<orig>' + ItemNota.ICMSSN202.Origem + '</orig>');
    Arquivo.Add('<CSOSN>' + ItemNota.ICMSSN202.CSOSN + '</CSOSN>');
    Arquivo.Add('<modBCST>' + ItemNota.ICMSSN202.modBCST + '</modBCST>');
    Arquivo.Add('<pMVAST>' + ItemNota.ICMSSN202.pMVAST + '</pMVAST>');
    Arquivo.Add('<pRedBCST>' + ItemNota.ICMSSN202.pRedBCST + '</pRedBCST>');
    Arquivo.Add('<vBCST>' + ItemNota.ICMSSN202.vBCST + '</vBCST>');
    Arquivo.Add('<pICMSST>' + ItemNota.ICMSSN202.pICMSST + '</pICMSST>');
    Arquivo.Add('<vICMSST>' + ItemNota.ICMSSN202.vICMSST + '</vICMSST>');
    Arquivo.Add('</ICMSSN202>');
    Arquivo.Add('</ICMS>');
  end;
  if not Empty(ItemNota.ICMSSN500.Origem) then
  begin
    Arquivo.Add('<ICMS>');
    Arquivo.Add('<ICMSSN500>');
    Arquivo.Add('<orig>' + ItemNota.ICMSSN500.Origem + '</orig>');
    Arquivo.Add('<CSOSN>' + ItemNota.ICMSSN500.CSOSN + '</CSOSN>');
    Arquivo.Add('<vBCSTRet>' + ItemNota.ICMSSN500.vBCSTRet + '</vBCSTRet>');
    Arquivo.Add('<vICMSSTRet>' + ItemNota.ICMSSN500.vICMSSTRet + '</vICMSSTRet>');
    Arquivo.Add('</ICMSSN500>');
    Arquivo.Add('</ICMS>');
  end;
  if not Empty(ItemNota.ICMSSN900.Origem) then
  begin
    Arquivo.Add('<ICMS>');
    Arquivo.Add('<ICMSSN900>');
    Arquivo.Add('<orig>' + ItemNota.ICMSSN900.Origem + '</orig>');
    Arquivo.Add('<CSOSN>' + ItemNota.ICMSSN900.CSOSN + '</CSOSN>');
    Arquivo.Add('<modBC>' + ItemNota.ICMSSN900.modBC + '</modBC>');
    Arquivo.Add('<vBC>' + ItemNota.ICMSSN900.vBC + '</vBC>');
    Arquivo.Add('<pRedBC>' + ItemNota.ICMSSN900.pRedBC + '</pRedBC>');
    Arquivo.Add('<pICMS>' + ItemNota.ICMSSN900.pICMS + '</pICMS>');
    Arquivo.Add('<vICMS>' + ItemNota.ICMSSN900.vICMS + '</vICMS>');
    Arquivo.Add('<modBCST>' + ItemNota.ICMSSN900.modBCST + '</modBCST>');
    Arquivo.Add('<pMVAST>' + ItemNota.ICMSSN900.pMVAST + '</pMVAST>');
    Arquivo.Add('<pRedBCST>' + ItemNota.ICMSSN900.pRedBCST + '</pRedBCST>');
    Arquivo.Add('<vBCST>' + ItemNota.ICMSSN900.vBCST + '</vBCST>');
    Arquivo.Add('<pICMSST>' + ItemNota.ICMSSN900.pICMSST + '</pICMSST>');
    Arquivo.Add('<vICMSST>' + ItemNota.ICMSSN900.vICMSST + '</vICMSST>');
    Arquivo.Add('<pCredSN>' + ItemNota.ICMSSN900.pCredSN + '</pCredSN>');
    Arquivo.Add('<vCredICMSSN>' + ItemNota.ICMSSN900.vCredICMSSN + '</vCredICMSSN>');
    Arquivo.Add('</ICMSSN900>');
    Arquivo.Add('</ICMS>');
  end;

  { IPI }
  if not Empty(ItemNota.IPITributavel.CST) then
  begin
    if (ItemNota.IPITributavel.CST = '00') or (ItemNota.IPITributavel.CST = '49') or (ItemNota.IPITributavel.CST = '50') or
      (ItemNota.IPITributavel.CST = '99') then
    begin
      Arquivo.Add('<IPI>');
      Arquivo.Add('<cEnq>' + '999' + '</cEnq>');
      Arquivo.Add('<IPITrib>');
      Arquivo.Add('<CST>' + ItemNota.IPITributavel.CST + '</CST>');
      if not Empty(ItemNota.IPITributavel.BaseCalculo) then
      begin
        Arquivo.Add('<vBC>' + ItemNota.IPITributavel.BaseCalculo + '</vBC>');
        Arquivo.Add('<pIPI>' + ItemNota.IPITributavel.Aliquota + '</pIPI>');
        Arquivo.Add('<vIPI>' + ItemNota.IPITributavel.IPI + '</vIPI>');
      end;
      Arquivo.Add('</IPITrib>');
      Arquivo.Add('</IPI>')
    end;
  end;

  { PIS }
  if not Empty(ItemNota.PISTributavelAliquota.CST) then
  begin
    Arquivo.Add('<PIS>');
    Arquivo.Add('<PISAliq>');
    Arquivo.Add('<CST>' + ItemNota.PISTributavelAliquota.CST + '</CST>');
    Arquivo.Add('<vBC>' + ItemNota.PISTributavelAliquota.BaseCalculo + '</vBC>');
    Arquivo.Add('<pPIS>' + ItemNota.PISTributavelAliquota.Aliquota + '</pPIS>');
    Arquivo.Add('<vPIS>' + ItemNota.PISTributavelAliquota.Valor + '</vPIS>');
    Arquivo.Add('</PISAliq>');
    Arquivo.Add('</PIS>');
  end;

  { PIS Não-Tributável }
  if not Empty(ItemNota.PisNaoTributavel.CST) then
  begin
    Arquivo.Add('<PIS>');
    Arquivo.Add('<PISNT>');
    Arquivo.Add('<CST>' + ItemNota.PisNaoTributavel.CST + '</CST>');
    Arquivo.Add('</PISNT>');
    Arquivo.Add('</PIS>');
  end;

  { PIS - Outros }
  if not Empty(ItemNota.PisOutros.CST) then
  begin
    Arquivo.Add('<PIS>');
    Arquivo.Add('<PISOutr>');
    Arquivo.Add('<CST>' + ItemNota.PisOutros.CST + '</CST>');
    Arquivo.Add('<vBC>' + ItemNota.PisOutros.BaseCalculo + '</vBC>');
    Arquivo.Add('<pPIS>' + ItemNota.PisOutros.Aliquota + '</pPIS>');
    // Arquivo.Add('<qBCProd>'   + ItemNota.PisOutros.QtdBcProd + '</qBCProd>');
    // Arquivo.Add('<vAliqProd>' + ItemNota.PisOutros.AliquotaPisValor + '</vAliqProd>');
    Arquivo.Add('<vPIS>' + ItemNota.PisOutros.Valor + '</vPIS>');
    Arquivo.Add('</PISOutr>');
    Arquivo.Add('</PIS>');
  end;

  { COFINS }
  if not Empty(ItemNota.COFINSTributadoAliquota.CST) then
  begin
    if Copy(ItemNota.COFINSTributadoAliquota.BaseCalculo, 1, 1) = '-' then
      ItemNota.COFINSTributadoAliquota.BaseCalculo := Copy(ItemNota.COFINSTributadoAliquota.BaseCalculo, 2,
        Length(ItemNota.COFINSTributadoAliquota.BaseCalculo) - 1);
    Arquivo.Add('<COFINS>');
    Arquivo.Add('<COFINSAliq>');
    Arquivo.Add('<CST>' + ItemNota.COFINSTributadoAliquota.CST + '</CST>');
    Arquivo.Add('<vBC>' + ItemNota.COFINSTributadoAliquota.BaseCalculo + '</vBC>');
    Arquivo.Add('<pCOFINS>' + ItemNota.COFINSTributadoAliquota.Aliquota + '</pCOFINS>');
    Arquivo.Add('<vCOFINS>' + ItemNota.COFINSTributadoAliquota.Valor + '</vCOFINS>');
    Arquivo.Add('</COFINSAliq>');
    Arquivo.Add('</COFINS>');
  end;

  { COFINS }
  if not Empty(ItemNota.CofinsNaoTributavel.CST) then
  begin
    Arquivo.Add('<COFINS>');
    Arquivo.Add('<COFINSNT>');
    Arquivo.Add('<CST>' + ItemNota.CofinsNaoTributavel.CST + '</CST>');
    Arquivo.Add('</COFINSNT>');
    Arquivo.Add('</COFINS>');
  end;

  { COFINS - OUTROS }
  if not Empty(ItemNota.COFINSOutros.CST) then
  begin
    Arquivo.Add('<COFINS>');
    Arquivo.Add('<COFINSOutr>');
    Arquivo.Add('<CST>' + ItemNota.COFINSOutros.CST + '</CST>');
    Arquivo.Add('<vBC>' + ItemNota.COFINSOutros.BaseCalculo + '</vBC>');
    Arquivo.Add('<pCOFINS>' + ItemNota.COFINSOutros.Aliquota + '</pCOFINS>');
    // Arquivo.Add('<qBCProd>'   + ItemNota.CofinsOutros.QtdBcProd + '</qBCProd>');
    // Arquivo.Add('<vAliqProd>' + ItemNota.CofinsOutros.AliquotaCofinsValor + '</vAliqProd>');
    Arquivo.Add('<vCOFINS>' + ItemNota.COFINSOutros.Valor + '</vCOFINS>');
    Arquivo.Add('</COFINSOutr>');
    Arquivo.Add('</COFINS>');
  end;

  if (not Empty(ItemNota.ICMS00.Origem)) or (not Empty(ItemNota.ICMS10.Origem)) or (not Empty(ItemNota.ICMS20.Origem)) or
    (not Empty(ItemNota.ICMS30.Origem)) or (not Empty(ItemNota.ICMS40.Origem)) or (not Empty(ItemNota.ICMS50.Origem)) or
    (not Empty(ItemNota.ICMS51.Origem)) or (not Empty(ItemNota.ICMS70.Origem)) or (not Empty(ItemNota.ICMS90.Origem)) or
    (not Empty(ItemNota.PISTributavelAliquota.CST)) or (not Empty(ItemNota.COFINSTributadoAliquota.CST)) or (not Empty(ItemNota.PisNaoTributavel.CST))
    or (not Empty(ItemNota.PisOutros.CST)) or (not Empty(ItemNota.COFINSOutros.CST)) or (not Empty(ItemNota.CofinsNaoTributavel.CST)) or
    (not Empty(ItemNota.IPITributavel.CST))

  then

    Arquivo.Add('</imposto>');
  Arquivo.Add('</det>');

  ItemNota.ICMS00.Origem := '';
  ItemNota.ICMS00.CST := '';
  ItemNota.ICMS00.Modalidade := '';
  ItemNota.ICMS00.BaseCalculo := '';
  ItemNota.ICMS00.Aliquota := '';
  ItemNota.ICMS00.ICMS := '';

  ItemNota.ICMS10.Origem := '';
  ItemNota.ICMS10.CST := '';
  ItemNota.ICMS10.Modalidade := '';
  ItemNota.ICMS10.BaseCalculo := '';
  ItemNota.ICMS00.Aliquota := '';
  ItemNota.ICMS00.ICMS := '';
  ItemNota.ICMS10.Modalidade10 := '';
  ItemNota.ICMS10.PercentualMargem := '';
  ItemNota.ICMS10.PercentualReducao10 := '';
  ItemNota.ICMS10.BaseSubstituicao := '';
  ItemNota.ICMS10.AliquotaSubstituicao := '';
  ItemNota.ICMS10.ICMSSubstituicao := '';

  ItemNota.ICMS20.Origem := '';
  ItemNota.ICMS20.CST := '';
  ItemNota.ICMS20.Modalidade20 := '';
  ItemNota.ICMS20.PercentualReducao := '';
  ItemNota.ICMS20.BaseCalculo := '';
  ItemNota.ICMS20.Aliquota := '';
  ItemNota.ICMS20.ICMS := '';

  ItemNota.ICMS30.Origem := '';
  ItemNota.ICMS30.CST := '';
  ItemNota.ICMS30.Modalidade := '';
  ItemNota.ICMS30.PercentualMargem := '';
  ItemNota.ICMS30.PercentualReducao := '';
  ItemNota.ICMS30.BaseSubstituicao := '';
  ItemNota.ICMS30.AliquotaSubstituicao := '';
  ItemNota.ICMS30.ICMSSubstituicao := '';

  ItemNota.ICMS40.Origem := '';
  ItemNota.ICMS40.CST := '';

  ItemNota.ICMS41.Origem := '';
  ItemNota.ICMS41.CST := '';

  ItemNota.ICMS50.Origem := '';
  ItemNota.ICMS50.CST := '';

  ItemNota.ICMS51.Origem := '';
  ItemNota.ICMS51.CST := '';
  ItemNota.ICMS51.Modalidade := '';
  ItemNota.ICMS51.PercentualReducao := '';
  ItemNota.ICMS51.BaseCalculo := '';
  ItemNota.ICMS51.Aliquota := '';
  ItemNota.ICMS51.ICMS := '';
  ItemNota.ICMS60.Origem := '';

  ItemNota.ICMS60.CST := '';
  ItemNota.ICMS60.BaseSubstituicao := '';
  ItemNota.ICMS60.ICMSSubstituicao := '';

  ItemNota.ICMS70.Origem := '';
  ItemNota.ICMS70.CST := '';
  ItemNota.ICMS70.Modalidade := '';
  ItemNota.ICMS70.PercentualReducao := '';
  ItemNota.ICMS70.BaseCalculo := '';
  ItemNota.ICMS70.Aliquota := '';
  ItemNota.ICMS70.ICMS := '';
  ItemNota.ICMS70.ModalidadeSubstituicao := '';
  ItemNota.ICMS30.PercentualMargem := '';
  ItemNota.ICMS70.PercentualReducao70 := '';
  ItemNota.ICMS70.BaseSubstituicao := '';
  ItemNota.ICMS70.AliquotaSubstituicao := '';
  ItemNota.ICMS70.ICMSSubstituicao := '';

  ItemNota.CofinsNaoTributavel.CST := '';
  ItemNota.COFINSTributadoAliquota.CST := '';
  ItemNota.COFINSTributadoAliquota.BaseCalculo := '';
  ItemNota.COFINSTributadoAliquota.Aliquota := '';
  ItemNota.COFINSTributadoAliquota.Valor := '';
  ItemNota.PisNaoTributavel.CST := '';
  ItemNota.PISTributavelAliquota.CST := '';
  ItemNota.PISTributavelAliquota.BaseCalculo := '';
  ItemNota.PISTributavelAliquota.Aliquota := '';
  ItemNota.PISTributavelAliquota.Valor := '';

  ItemNota.PisOutros.CST := '';
  ItemNota.PisOutros.BaseCalculo := '';
  ItemNota.PisOutros.Aliquota := '';
  ItemNota.PisOutros.QtdBcProd := '';
  ItemNota.PisOutros.AliquotaPisValor := '';
  ItemNota.PisOutros.Valor := '';

  ItemNota.COFINSOutros.CST := '';
  ItemNota.COFINSOutros.BaseCalculo := '';
  ItemNota.COFINSOutros.Aliquota := '';
  ItemNota.COFINSOutros.QtdBcProd := '';
  ItemNota.COFINSOutros.AliquotaCofinsValor := '';
  ItemNota.COFINSOutros.Valor := '';

  ItemNota.ICMS90.Origem := '';
  ItemNota.ICMS90.CST := '';
  ItemNota.ICMS90.Modalidade := '';
  ItemNota.ICMS90.BaseCalculo := '';
  ItemNota.ICMS90.PercentualReducao := '';
  ItemNota.ICMS90.Aliquota := '';
  ItemNota.ICMS90.ICMS := '';
  ItemNota.ICMS90.PercentualMargem := '';
  ItemNota.ICMS90.PercentualReducao := '';
  ItemNota.ICMS90.BaseSubstituicao := '';
  ItemNota.ICMS90.AliquotaSubstituicao := '';
  ItemNota.ICMS90.ICMSSubstituicao := '';

  ItemNota.ICMSSN101.Origem := '';
  ItemNota.ICMSSN101.CSOSN := '';
  ItemNota.ICMSSN101.pCredSN := '';
  ItemNota.ICMSSN101.vCredICMSSN := '';

  ItemNota.ICMSSN102.Origem := '';
  ItemNota.ICMSSN102.CSOSN := '';

  ItemNota.ICMSSN201.Origem := '';
  ItemNota.ICMSSN201.CSOSN := '';
  ItemNota.ICMSSN201.modBCST := '';
  ItemNota.ICMSSN201.pMVAST := '';
  ItemNota.ICMSSN201.pRedBCST := '';
  ItemNota.ICMSSN201.vBCST := '';
  ItemNota.ICMSSN201.pICMSST := '';
  ItemNota.ICMSSN201.vICMSST := '';
  ItemNota.ICMSSN201.pCredSN := '';
  ItemNota.ICMSSN201.vCredICMSSN := '';

  ItemNota.ICMSSN202.Origem := '';
  ItemNota.ICMSSN202.CSOSN := '';
  ItemNota.ICMSSN202.modBCST := '';
  ItemNota.ICMSSN202.pMVAST := '';
  ItemNota.ICMSSN202.pRedBCST := '';
  ItemNota.ICMSSN202.vBCST := '';
  ItemNota.ICMSSN202.pICMSST := '';
  ItemNota.ICMSSN202.vICMSST := '';

  ItemNota.ICMSSN500.Origem := '';
  ItemNota.ICMSSN500.CSOSN := '';
  ItemNota.ICMSSN500.vBCSTRet := '';
  ItemNota.ICMSSN500.vICMSSTRet := '';

  ItemNota.ICMSSN900.Origem := '';
  ItemNota.ICMSSN900.CSOSN := '';
  ItemNota.ICMSSN900.modBC := '';
  ItemNota.ICMSSN900.vBC := '';
  ItemNota.ICMSSN900.pRedBC := '';
  ItemNota.ICMSSN900.pICMS := '';
  ItemNota.ICMSSN900.vICMS := '';
  ItemNota.ICMSSN900.modBCST := '';
  ItemNota.ICMSSN900.pMVAST := '';
  ItemNota.ICMSSN900.pRedBCST := '';
  ItemNota.ICMSSN900.vBCST := '';
  ItemNota.ICMSSN900.pICMSST := '';
  ItemNota.ICMSSN900.vICMSST := '';
  ItemNota.ICMSSN900.pCredSN := '';
  ItemNota.ICMSSN900.vCredICMSSN := '';

  ItemNota.IPITributavel.CST := '';
  ItemNota.IPITributavel.BaseCalculo := '';
  ItemNota.IPITributavel.Aliquota := '';
  ItemNota.IPITributavel.IPI := '';

end;

{ ****************************************************************************** }
{ Adiciona o total }
{ ****************************************************************************** }
procedure TNFeXML.AdicionaTotal;
begin
  Arquivo.Add('<total>');
  Arquivo.Add('<ICMSTot>');

  Arquivo.Add('<vBC>' + Total.BaseICMS + '</vBC>');
  Arquivo.Add('<vICMS>' + Total.ICMS + '</vICMS>');
  Arquivo.Add('<vBCST>' + Total.BaseSubstituicao + '</vBCST>');
  Arquivo.Add('<vST>' + Total.Substituicao + '</vST>');
  Arquivo.Add('<vProd>' + Total.TotalProdutos + '</vProd>');
  Arquivo.Add('<vFrete>' + Total.Frete + '</vFrete>');
  Arquivo.Add('<vSeg>' + Total.Seguro + '</vSeg>');
  Arquivo.Add('<vDesc>' + Total.Desconto + '</vDesc>');
  Arquivo.Add('<vII>' + Total.II + '</vII>');
  Arquivo.Add('<vIPI>' + Total.IPI + '</vIPI>');
  Arquivo.Add('<vPIS>' + Total.Pis + '</vPIS>');
  Arquivo.Add('<vCOFINS>' + Total.COFINS + '</vCOFINS>');
  Arquivo.Add('<vOutro>' + Total.Outro + '</vOutro>');
  Arquivo.Add('<vNF>' + Total.TotalNF + '</vNF>');

  Arquivo.Add('</ICMSTot>');
  Arquivo.Add('</total>');

  Total.BaseICMS := '';
  Total.ICMS := '';
  Total.BaseSubstituicao := '';
  Total.Substituicao := '';
  Total.TotalProdutos := '';
  Total.Frete := '';
  Total.Seguro := '';
  Total.Desconto := '';
  Total.II := '';
  Total.IPI := '';
  Total.Pis := '';
  Total.COFINS := '';
  Total.Outro := '';
  Total.TotalNF := '';
end;

{ ****************************************************************************** }
{ Adiciona a transportadora }
{ ****************************************************************************** }

procedure TNFeXML.AdicionaTransportadora;
begin
  Arquivo.Add('<transp>');
  Arquivo.Add('<modFrete>' + Transportadora.Modalidade + '</modFrete>');

  if not Empty(Transportadora.Nome) then
  begin
    Arquivo.Add('<transporta>');
    if not Empty(Transportadora.CNPJ) then
      Arquivo.Add('<CNPJ>' + Transportadora.CNPJ + '</CNPJ>')
    else
      Arquivo.Add('<CPF>' + Transportadora.CPF + '</CPF>');
    Arquivo.Add('<xNome>' + Transportadora.Nome + '</xNome>');
    // Arquivo.Add('<IE>'      + Transportadora.InscEstadual + '</IE>');
    Arquivo.Add('<xEnder>' + Transportadora.Endereco + '</xEnder>');
    Arquivo.Add('<xMun>' + Transportadora.Municpio + '</xMun>');
    Arquivo.Add('<UF>' + Transportadora.UF + '</UF>');

    Arquivo.Add('</transporta>');

    if not Empty(Transportadora.Placa) then
    begin
      Arquivo.Add('<veicTransp>');
      Arquivo.Add('<placa>' + Transportadora.Placa + '</placa>');
      Arquivo.Add('<UF>' + Transportadora.UFTransp + '</UF>');
      Arquivo.Add('</veicTransp>');
    end;
  end;

  if ((not Empty(Transportadora.QuantidadeVolume)) or (not Empty(Transportadora.PesoLiquido)) or (not Empty(Transportadora.PesoBruto))) then
  begin
    Arquivo.Add('<vol>');

    if not Empty(Transportadora.QuantidadeVolume) then
      Arquivo.Add('<qVol>' + Transportadora.QuantidadeVolume + '</qVol>');

    if not Empty(Transportadora.EspecieVolume) then
      Arquivo.Add('<esp>' + Transportadora.EspecieVolume + '</esp>');

    if not Empty(Transportadora.MarcaVaolume) then
      Arquivo.Add('<marca>' + Transportadora.MarcaVaolume + '</marca>');

    if not Empty(Transportadora.NumeracaoVolume) then
      Arquivo.Add('<nVol>' + Transportadora.NumeracaoVolume + '</nVol>');

    if not Empty(Transportadora.PesoLiquido) then
      Arquivo.Add('<pesoL>' + Transportadora.PesoLiquido + '</pesoL>');

    if not Empty(Transportadora.PesoBruto) then
      Arquivo.Add('<pesoB>' + Transportadora.PesoBruto + '</pesoB>');

    Arquivo.Add('</vol>');
  end;

  Arquivo.Add('</transp>');

  Transportadora.Nome := '';
  Transportadora.InscEstadual := '';
  Transportadora.Endereco := '';
  Transportadora.Municpio := '';
  Transportadora.UF := '';
  Transportadora.CNPJ := '';
  Transportadora.CPF := '';
  Transportadora.QuantidadeVolume := '';
  Transportadora.EspecieVolume := '';
  Transportadora.PesoLiquido := '';
  Transportadora.PesoBruto := '';

end;

{ ****************************************************************************** }
{ Adiciona Cobranca }
{ ****************************************************************************** }

procedure TNFeXML.AdicionaCobranca(Tipo: string);
begin
  if Tipo = 'A' then
    Arquivo.Add('<cobr>')
  else if Tipo = 'M' then
  begin
    if not Empty(Cobranca.Duplicata) then
    begin
      Arquivo.Add('<dup>');
      Arquivo.Add('<nDup>' + Cobranca.Duplicata + '</nDup>');
      Arquivo.Add('<dVenc>' + Cobranca.VencDup + '</dVenc>');
      Arquivo.Add('<vDup>' + Cobranca.ValorDup + '</vDup>');
      Arquivo.Add('</dup>');
    end;

    if not Empty(Cobranca.NumFatura) then
    begin
      Arquivo.Add('<fat>');
      Arquivo.Add('<nFat>' + Cobranca.NumFatura + '</nFat>');
      Arquivo.Add('<vOrig>' + Cobranca.Valor + '</vOrig>');
      Arquivo.Add('<vDesc>' + Cobranca.Desc + '</vDesc>');
      Arquivo.Add('<vLiq>' + Cobranca.VlLiquido + '</vLiq>');
      Arquivo.Add('</fat>');
    end;
  end
  else if Tipo = 'F' then
    Arquivo.Add('</cobr>');

  Cobranca.Duplicata := '';
  Cobranca.VencDup := '';
  Cobranca.ValorDup := '';
  Cobranca.NumFatura := '';
  Cobranca.Valor := '';
  Cobranca.VlLiquido := '';
end;

{ ****************************************************************************** }
{ Adiciona Informacoes }
{ ****************************************************************************** }

procedure TNFeXML.AdicionaInformacoes;
begin
  if not Empty(Informacoes.InfFisco) or (not Empty(Informacoes.InfComplementar)) then
  begin
    Arquivo.Add('<infAdic>');

    if not Empty(Informacoes.InfFisco) then
      Arquivo.Add('<infAdFisco>' + Informacoes.InfFisco + '</infAdFisco>');

    if not Empty(Informacoes.InfComplementar) then
      Arquivo.Add('<infCpl>' + Informacoes.InfComplementar + '</infCpl>');

    if not Empty(Destinatario.Email) then
    begin
      Arquivo.Add('<obsCont xCampo="email">');
      Arquivo.Add('<xTexto>' + Trim(Destinatario.Email) + '</xTexto>');
      Arquivo.Add('</obsCont>');
    end;

    if not Empty(Transportadora.Email) then
    begin
      Arquivo.Add('<obsCont xCampo="email">');
      Arquivo.Add('<xTexto>' + Trim(Transportadora.Email) + '</xTexto>');
      Arquivo.Add('</obsCont>');
    end;

    Arquivo.Add('</infAdic>');

    Informacoes.InfFisco := '';
    Informacoes.InfComplementar := '';
  end;
  Arquivo.Add('</infNFe>');
  Arquivo.Add('</NFe>');
end;

procedure TNFeXML.FinalizaNF;
var
  F2: TextFile;
begin
  Arquivo.Add('</enviNFe>');
  Arquivo.Text := retirar_quebra_linha(Arquivo.Text);
  Arquivo.SaveToFile(NomeArquivo);
  { AssignFile(F2, NomeArquivo);
    Rewrite(F2);
    Write(F2, #$EF+#$BB+#$BF);
    Write(F2,AnsiToUtf8(Arquivo.Text));
    CloseFile(F2); }
end;

function retirar_quebra_linha(texto: string): string;
var
  p: integer;
begin
  while (pos(#13, texto) <> 0) do
  begin
    p := pos(#13, texto);
    Delete(texto, p, 1);
    insert(' ', texto, 1);
  end;
  while (pos(#10, texto) <> 0) do
  begin
    p := pos(#10, texto);
    Delete(texto, p, 1);
    insert(' ', texto, 1);
  end;
  Result := Trim(texto);
end;

end.
