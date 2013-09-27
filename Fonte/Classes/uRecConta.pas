unit uRecConta;

interface

uses ZConnection, ZDataset, SysUtils, uConstantes, Classes, uProcedimentosBanco, uExceptions, Variants, Forms,
     Dialogs, Windows, uCliente, JvMemoryDataset, Controls, Contnrs;

type

  TRecConta = class
  public


    function geticontaorigem: integer;
    function geticonta: integer;
    function getiparcela: integer;
    function getdvencimento: tdate;
    function getnvalor: Real;
    function getddatabaixa: TDate;
    function getvaloramortizado: Real;

    function iRetornaUltimoCodigo: Integer;
    constructor Create(pzcoConnection: TZConnection);
    destructor Destroy; override;
    procedure CadastraConta(piContaOigem: Integer;piparcela: integer; pdvencimento: tdate; pnvalor: Real;
   pddatabaixa: TDate; pvaloramortizado:real =0);
    procedure AlteraConta(piContaOigem: Integer;piconta:integer; piparcela: integer; pdvencimento: tdate; pnvalor: Real;
   pddatabaixa: TDate; pvaloramortizado:real =0);
    procedure DeletaConta(piconta: integer);


    function bPesquisaContaCodigo(piConta: Integer): Boolean;

  private
    icontaorigem: integer;
    iconta: integer;
    iparcela: integer;
    dvencimento: tdate;
    nvalor: Real;
    ddatabaixa: TDate;
    valoramortizado: Real;
    zcoConnection: TZConnection;
    function iCamposConsistentes: Integer;
  end;

  TParcela = class
  public
    oParcela: TRecConta;

    constructor Create(pzcoConnection: TZConnection);
    destructor Destroy;override;

  end;


  TRecContaOrigem = class
  public
    oCliente: TCliente;
    oParcelas: TObjectList;

    procedure SetiContaOrigem(piContaOrigem: Integer);
    procedure Setsserie(psserie: String);
    procedure Setnumero(pnumero: String);
    procedure SetQtdParcelas(piQtdParcelas: Integer);
    procedure SetEmissao(pdEmissao: TDate);
    procedure SetValorTotal(pnValorTotal: Real);

    function GetiContaOrigem : Integer;
    function GetsSerie  : String;
    function GetsNumero: String;
    function GetiQtdParcela: Integer;
    function GetEmissao: TDate;
    function GetnValorTotal: Real;

    function iRetornaUltimoCodigo: Integer;
    constructor Create(pzcoConnection: TZConnection);
    destructor Destroy; override;
    procedure CadastraContaOrigem;
    procedure AlteraContaOrigem;
    procedure DeletaContaOrigem;

    function bPesquisaContaOrigemCodigo(piContaOrigem: Integer): Boolean;
    function bPesquisaContaOrigemClienteSerieNumero(pCliente:STring;pSerie: String;pNumero:String): Boolean;


  private
    iContaOrigem: integer;
    sserie: string;
    numero: string;
    qtdparcelas: integer;
    dEmissao: TDate;
    nvalortotal: real;
    zcoConnection: TZConnection;
    function iCamposConsistentes: Integer;
  end;


   TRecBaixa =  class
   public
      oConta: TRecConta;

      function Geticontabaixa: integer;
      function Geticonta: integer;
      function Getddatapagamento: TdateTime;
      function Getddatabaixa: Tdate;
      function Getnvalorbaixa: Real;
      function Getndesconto: Real;
      function Getndinheiro: Real;
      function Getnchequeavista: Real;
      function Getnchequepre: Real;
      function Getncartao: Real;
      function Getntipobaixa: String;

      function iRetornaUltimoCodigo: Integer;
      constructor Create(pzcoConnection: TZConnection);
      destructor Destroy; override;
      procedure CadastraBaixa(pddatapagamento: TdateTime; pddatabaixa: Tdate;
         pnvalorbaixa, pndesconto, pndinheiro, pnchequeavista, pnchequepre, pncartao: Real;
         pntipobaixa: String);


   private
      icontabaixa: integer;
      iconta: integer;
      ddatapagamento: TdateTime;
      ddatabaixa: Tdate;
      nvalorbaixa: Real;
      ndesconto: Real;
      ndinheiro: Real;
      nchequeavista: Real;
      nchequepre: Real;
      ncartao: Real;
      ntipobaixa: String;
      zcoConnection: TZConnection;
   end;


implementation

uses uPessoa;



{ TRecContaOrigem }

procedure TRecContaOrigem.AlteraContaOrigem;
var
  ZQryContaOrigem: TZQuery;
begin
  if iCamposConsistentes = 0 then
  begin
    ZQryContaOrigem := TZQuery.Create(nil);
    with ZQryContaOrigem do
    begin
      Connection := zcoConnection;
      SQL.Clear;
      SQL.Add('UPDATE tbreccontaorigem SET ');
      SQL.Add(' icliente = :icliente,');
      SQL.Add(' sserie = :sserie,');
      SQL.Add(' numero = :numero,');
      SQL.Add(' qtdparcelas = :qtdparcelas');
      SQL.Add(' demissao = :demissao');
      SQL.Add(' nvalortotal = :nvalortotal');
      SQL.Add('WHERE icontaorigem = :icontaorigem');
      ParamByName('icliente').AsString     := oCliente.sGetCodigo;
      ParamByName('sserie').AsString       := GetsSerie;
      ParamByName('numero').AsString        := GetsNumero;
      ParamByName('qtdparcelas').AsInteger  := GetiContaOrigem;
      ParamByName('demissao').AsDateTime    := GetEmissao;
      ParamByName('nvalortotal').AsFloat := GetnValorTotal;
      ParamByName('icontaorigem').AsInteger:= GetiContaOrigem;
      ExecSQL;
    end;
    FreeAndNil(ZQryContaOrigem);
  end;
end;

procedure TRecContaOrigem.CadastraContaOrigem;
var
  ZQryContaOrigem: TZQuery;
begin
    ZQryContaOrigem := TZQuery.Create(nil);
    with ZQryContaOrigem do
    begin
      Connection := zcoConnection;
      SQL.Clear;
      SQL.Add('INSERT INTO tbreccontaorigem(');
      SQL.Add(' icliente,');
      SQL.Add(' sserie,');
      SQL.Add(' numero,');
      SQL.Add(' qtdparcelas,');
      SQL.Add(' demissao,');
      SQL.Add(' nvalortotal,');
      SQL.Add(' icontaorigem)');
      SQL.Add('VALUES(');
      SQL.Add(' :icliente,');
      SQL.Add(' :sserie,');
      SQL.Add(' :numero,');
      SQL.Add(' :qtdparcelas,');
      SQL.Add(' :demissao,');
      SQL.Add(' :nvalortotal,');
      SQL.Add(' :icontaorigem)');
      ParamByName('icliente').AsInteger     := StrToInt(oCliente.sGetCodigo);
      ParamByName('sserie').AsString       := GetsSerie;
      ParamByName('numero').AsInteger        := StrToInt(GetsNumero);
      ParamByName('qtdparcelas').AsInteger  := GetiContaOrigem;
      ParamByName('demissao').AsDateTime    := GetEmissao;
      ParamByName('nvalortotal').AsFloat := GetnValorTotal;
      ParamByName('icontaorigem').AsInteger:= iRetornaUltimoCodigo;
      SetiContaOrigem(iRetornaUltimoCodigo);
      try
        ExecSQL;
      except
        on E: Exception do
        begin
          TrataErro(E.Message);
          Application.MessageBox(Pchar(E.Message),'Erro',MB_OK);
        end;
      end;
    end;
    FreeAndNil(ZQryContaOrigem);
end;

constructor TRecContaOrigem.Create(pzcoConnection: TZConnection);
begin
  zcoConnection := pzcoConnection;
  oCliente := TCliente.Create(pzcoConnection);
end;

procedure TRecContaOrigem.DeletaContaOrigem;
var
  ZQryContaOrigem: TZQuery;
begin
  if iCamposConsistentes = 0 then
  begin
    ZQryContaOrigem := TZQuery.Create(nil);
    with ZQryContaOrigem do
    begin
      Connection := zcoConnection;
      SQL.Clear;
      SQL.Add('UPDATE tbreccontaorigem SET sstatus = ' + QuotedStr('I') + ' ');
      SQL.Add('WHERE icontaorigem = :icontaorigem');
      ParamByName('icontaorigem').AsInteger:= GetiContaOrigem;
      ParamByName('sstatus').AsString:= 'I';
      ExecSQL;
    end;
    FreeAndNil(ZQryContaOrigem);
  end;
end;

destructor TRecContaOrigem.Destroy;
begin
   FreeAndNil(oCliente);
  inherited;
end;

function TRecContaOrigem.GetnValorTotal: Real;
begin
   GetnValorTotal := nValorTotal;
end;

function TRecContaOrigem.GetEmissao: TDate;
begin
   GetEmissao := dEmissao;
end;

function TRecContaOrigem.GetiContaOrigem: Integer;
begin
   GetiContaOrigem := iContaOrigem;
end;

function TRecContaOrigem.GetiQtdParcela: Integer;
begin
   GetiQtdParcela := qtdparcelas;
end;

function TRecContaOrigem.GetsNumero: String;
begin
   GetsNumero := Numero;
end;

function TRecContaOrigem.GetsSerie: String;
begin
   GetsSerie := sSerie;
end;

function TRecContaOrigem.iCamposConsistentes: Integer;
begin

end;

function TRecContaOrigem.iRetornaUltimoCodigo: Integer;
var
  ZQryContaOrigem: TZQuery;
begin
  ZQryContaOrigem := TZQuery.Create(nil);
  with ZQryContaOrigem do
  begin
    Connection := zcoConnection;
    SQL.Clear;
    SQL.Add('SELECT COALESCE(MAX(icontaorigem),0) AS ULTIMO FROM tbreccontaorigem');
    Open;
    Result := FieldByName('ULTIMO').AsInteger;
  end;
  FreeAndNil(ZQryContaOrigem);
end;

procedure TRecContaOrigem.SetValorTotal(pnValorTotal: Real);
begin
   nValorTotal := pnValorTotal;
end;

procedure TRecContaOrigem.SetEmissao(pdEmissao: TDate);
begin
   dEmissao := pdEmissao;
end;

procedure TRecContaOrigem.SetiContaOrigem(piContaOrigem: Integer);
begin
   iContaOrigem := picontaOrigem;
end;

procedure TRecContaOrigem.Setnumero(pnumero: String);
begin
   numero := pnumero;
end;

procedure TRecContaOrigem.SetQtdParcelas(piQtdParcelas: Integer);
begin
   if piQtdParcelas < 0 then begin
      raise Exception.Create('A quantidade de parcelas dever ser maior que zero.');
      Exit;
   end;
   qtdparcelas := piQtdParcelas;
end;

procedure TRecContaOrigem.Setsserie(psserie: String);
begin
   sSerie := psserie;
end;

function TRecContaOrigem.bPesquisaContaOrigemCodigo(
  piContaOrigem: Integer): Boolean;
var
  ZQry: TZQuery;
begin
  ZQry := TZQuery.Create(nil);
  with ZQry do
  begin
    Connection := zcoConnection;
    SQL.Clear;
    SQL.Add('SELECT * FROM tbreccontaorigem where icontaorigem = :icontaorigem');
    ParamByName('icontaorigem').AsInteger := picontaorigem;
    Open;
    Result := not (Bof and Eof);
    SetiContaOrigem(piContaOrigem);
    Setsserie(FieldByName('sserie').asstring);
    Setnumero(FieldByName('numero').asstring);
    SetQtdParcelas(FieldByName('qtdparcelas').asinteger);
    SetEmissao(fieldbyname('demissao').asdatetime);
    SetValorTotal(fieldbyname('nvalortotal').asfloat);
  end;
  FreeAndNil(ZQry);
end;


function TRecContaOrigem.bPesquisaContaOrigemClienteSerieNumero(pCliente,
  pSerie, pNumero: String): Boolean;
var
  ZQry: TZQuery;
begin
  ZQry := TZQuery.Create(nil);
  with ZQry do
  begin
    Connection := zcoConnection;
    SQL.Clear;
    SQL.Add('SELECT * FROM tbreccontaorigem where icliente = :icliente and sserie = :sserie and numero = :numero');
    ParamByName('icliente').AsString := pCliente;
    ParamByName('sserie').AsString    := pSerie;
    ParamByName('numero').AsString   := pNumero;
    Open;
    Result := not (Bof and Eof);
    SetiContaOrigem(FieldByName('icontaorigem').AsInteger);
    Setsserie(FieldByName('sserie').asstring);
    Setnumero(FieldByName('numero').asstring);
    SetQtdParcelas(FieldByName('qtdparcelas').asinteger);
    SetEmissao(fieldbyname('demissao').asdatetime);
    SetValorTotal(fieldbyname('nvalortotal').asfloat);
  end;
  FreeAndNil(ZQry);
end;


{ TRecConta }

procedure TRecConta.AlteraConta(piContaOigem: Integer;piconta:integer; piparcela: integer; pdvencimento: tdate; pnvalor: Real;
   pddatabaixa: TDate; pvaloramortizado:real =0);
var
  ZQryConta: TZQuery;
begin
  if iCamposConsistentes = 0 then
  begin
    ZQryConta := TZQuery.Create(nil);
    with ZQryConta do
    begin
      Connection := zcoConnection;
      SQL.Clear;
      SQL.Add('UPDATE tbrecconta SET ');
      SQL.Add(' icontaorigem = :icontaorigem,');
      SQL.Add(' parcela = :parcela,');
      SQL.Add(' dvencimento = :dvencimento,');
      SQL.Add(' nvalor = :nvalor');
      SQL.Add(' ddatabaixa = :ddatabaixa');
      SQL.Add(' nvalorarmotizado = :nvalorarmotizado');
      SQL.Add('WHERE iconta = :iconta');
      ParamByName('icontaorigem').Asinteger    := piContaOigem;
      ParamByName('parcela').AsInteger         := piparcela;
      ParamByName('dvencimento').AsDateTime     := pdvencimento;
      ParamByName('nvalor').AsFloat         := pnvalor;
      ParamByName('ddatabaixa').AsDateTime    := pddatabaixa;
      ParamByName('nvaloramortizado').AsFloat := pvaloramortizado;
      ParamByName('iconta').AsInteger:= piconta;
      ExecSQL;
    end;
    FreeAndNil(ZQryConta);
  end;
end;

function TRecConta.bPesquisaContaCodigo(piConta: Integer): Boolean;
var
  ZQry: TZQuery;
begin
  ZQry := TZQuery.Create(nil);
  with ZQry do
  begin
    Connection := zcoConnection;
    SQL.Clear;
    SQL.Add('SELECT * FROM tbrecconta where iconta = :iconta');
    ParamByName('iconta').AsInteger := piconta;
    Open;
    Result := not (Bof and Eof);
    iconta := fieldbyname('iconta').asinteger;
    iparcela := fieldbyname('iparcela').asinteger;
    dvencimento := fieldbyname('dvencimento').asdatetime;
    nvalor := fieldbyname('nvalor').asfloat;
    ddatabaixa := fieldbyname('ddatabaixa').asdatetime;
    valoramortizado := fieldbyname('valoramortizado').asfloat;
  end;
  FreeAndNil(ZQry);
end;




procedure TRecConta.CadastraConta(piContaOigem: Integer;piparcela: integer; pdvencimento: tdate; pnvalor: Real;
   pddatabaixa: TDate; pvaloramortizado:real =0);
var
  ZQryConta: TZQuery;
begin
  if iCamposConsistentes = 0 then
  begin
    ZQryConta := TZQuery.Create(nil);
    with ZQryConta do
    begin
      Connection := zcoConnection;
      SQL.Clear;
      SQL.Add('INTERT INTO tbrecconta(');
      SQL.Add(' iconta,');
      SQL.Add(' icontaorigem,');
      SQL.Add(' parcela,');
      SQL.Add(' dvencimento,');
      SQL.Add(' nvalor,');
      SQL.Add(' ddatabaixa,');
      SQL.Add(' nvaloramortizado)');
      SQL.Add(' VALUES(');
      SQL.Add(' :iconta,');
      SQL.Add(' :icontaorigem,');
      SQL.Add(' :parcela,');
      SQL.Add(' :dvencimento,');
      SQL.Add(' :nvalor,');
      if pddatabaixa  = 0 then
         SQL.Add(' null,')
      else
         SQL.Add(' :ddatabaixa,');
      SQL.Add(' :nvaloramortizado)');
      ParamByName('iconta').AsInteger     := iRetornaUltimoCodigo;
      ParamByName('icontaorigem').AsInteger := piContaOigem;
      ParamByName('parcela').AsInteger        := piParcela;
      ParamByName('dvencimento').AsDateTime  := pdvencimento;
      ParamByName('nvalor').Asfloat := pnvalor;
      if pddatabaixa <> 0 then
         ParamByName('ddatabaixa').AsDateTime    := pddatabaixa;
      ParamByName('nvaloramortizado').AsFloat := pvaloramortizado;
      ExecSQL;
    end;
    FreeAndNil(ZQryConta);
  end;
end;


constructor TRecConta.Create(pzcoConnection: TZConnection);
begin
  zcoConnection := pzcoConnection;
  //oContaOrigem := TRecContaOrigem.Create(pzcoConnection);
end;

procedure TRecConta.DeletaConta(piconta: integer);
var
  ZQryConta: TZQuery;
begin
  if iCamposConsistentes = 0 then
  begin
    ZQryConta := TZQuery.Create(nil);
    with ZQryConta do
    begin
      Connection := zcoConnection;
      SQL.Clear;
      SQL.Add('UPDATE tbrecconta SET ');
      SQL.Add(' sstatus = ' + QuotedStr('I'));
      SQL.Add('WHERE iconta = :iconta');
      ParamByName('iconta').AsInteger:= piconta;
      ExecSQL;
    end;
    FreeAndNil(ZQryConta);
  end;
end;


destructor TRecConta.Destroy;
begin
   //FreeAndNil(oContaOrigem);
  inherited;
end;

function TRecConta.getddatabaixa: TDate;
begin
   Result := ddatabaixa;
end;

function TRecConta.getdvencimento: tdate;
begin
   Result := dvencimento;
end;

function TRecConta.geticonta: integer;
begin
   Result := iconta;
end;

function TRecConta.geticontaorigem: integer;
begin
   Result := icontaorigem;
end;

function TRecConta.getiparcela: integer;
begin
   Result := iparcela;
end;

function TRecConta.getnvalor: Real;
begin
   Result := getnvalor;
end;

function TRecConta.getvaloramortizado: Real;
begin
   Result := valoramortizado;
end;

function TRecConta.iCamposConsistentes: Integer;
begin

end;

function TRecConta.iRetornaUltimoCodigo: Integer;
var
  ZQryConta: TZQuery;
begin
  ZQryConta := TZQuery.Create(nil);
  with ZQryConta do
  begin
    Connection := zcoConnection;
    SQL.Clear;
    SQL.Add('SELECT COALESCE(MAX(iconta),0) AS ULTIMO FROM tbrecconta');
    Open;
    Result := FieldByName('ULTIMO').AsInteger;
  end;
  FreeAndNil(ZQryConta);
end;

{ TRecBaixa }

procedure TRecBaixa.CadastraBaixa(pddatapagamento: TdateTime; pddatabaixa: Tdate;
   pnvalorbaixa, pndesconto, pndinheiro, pnchequeavista, pnchequepre, pncartao: Real;
   pntipobaixa: String);
var
  ZQry: TZQuery;
begin
    ZQry := TZQuery.Create(nil);
    with ZQry do
    begin
      Connection := zcoConnection;
      SQL.Clear;
      SQL.Add('INTERT INTO tbrecbaixa(');
      SQL.Add('icontabaixa,');
      SQL.Add('iconta,');
      SQL.Add('ddatapagamento,');
      SQL.Add('ddatabaixa,');
      SQL.Add('nvalorbaixa,');
      SQL.Add('ndesconto,');
      SQL.Add('ndinheiro,');
      SQL.Add('nchequeavista,');
      SQL.Add('nchequepre,');
      SQL.Add('ncartao,');
      SQL.Add('ntipobaixa)');
      SQL.Add(' VALUES(');
      SQL.Add(':icontabaixa,');
      SQL.Add(':iconta,');
      SQL.Add(':ddatapagamento,');
      SQL.Add(':ddatabaixa,');
      SQL.Add(':nvalorbaixa,');
      SQL.Add(':ndesconto,');
      SQL.Add(':ndinheiro,');
      SQL.Add(':nchequeavista,');
      SQL.Add(':nchequepre,');
      SQL.Add(':ncartao,');
      SQL.Add(':ntipobaixa)');
      ParamByName('icontabaixa').asinteger := iRetornaUltimoCodigo;
      ParamByName('iconta').asinteger := oConta.iConta;
      ParamByName('ddatapagamento').asdatetime := pddatapagamento;
      ParamByName('ddatabaixa').asdatetime := pddatabaixa;
      ParamByName('nvalorbaixa').asfloat := pnvalorbaixa;
      ParamByName('ndesconto').asfloat := pndesconto;
      ParamByName('ndinheiro').asfloat := pndinheiro;
      ParamByName('nchequeavista').asfloat := pnchequeavista;
      ParamByName('nchequepre').asfloat := pnchequepre;
      ParamByName('ncartao').asfloat := pncartao;
      ParamByName('ntipobaixa').asstring := pntipobaixa;
      ExecSQL;
    end;
    FreeAndNil(ZQry);
end;


constructor TRecBaixa.Create(pzcoConnection: TZConnection);
begin
  zcoConnection := pzcoConnection;
  oConta:= TRecConta.Create(pzcoConnection);
end;

destructor TRecBaixa.Destroy;
begin
  FreeAndNil(oConta);
  inherited;
end;

function TRecBaixa.Getddatabaixa: Tdate;
begin
   Result := ddatabaixa;
end;

function TRecBaixa.Getddatapagamento: TdateTime;
begin
   Result := ddatapagamento;
end;

function TRecBaixa.Geticonta: integer;
begin
   Result := iconta;
end;

function TRecBaixa.Geticontabaixa: integer;
begin
   Result := icontabaixa;
end;

function TRecBaixa.Getncartao: Real;
begin
   Result := ncartao;
end;

function TRecBaixa.Getnchequeavista: Real;
begin
   Result := nchequeavista;
end;

function TRecBaixa.Getnchequepre: Real;
begin
   Result := nchequepre;
end;

function TRecBaixa.Getndesconto: Real;
begin
   Result := ndesconto;
end;

function TRecBaixa.Getndinheiro: Real;
begin
   Result := ndinheiro;
end;

function TRecBaixa.Getntipobaixa: String;
begin
   Result := ntipobaixa;
end;

function TRecBaixa.Getnvalorbaixa: Real;
begin
   Result := nvalorbaixa;
end;

function TRecBaixa.iRetornaUltimoCodigo: Integer;
var
  ZQryConta: TZQuery;
begin
  ZQryConta := TZQuery.Create(nil);
  with ZQryConta do
  begin
    Connection := zcoConnection;
    SQL.Clear;
    SQL.Add('SELECT COALESCE(MAX(icontabaixa),0) AS ULTIMO FROM tbreccontabaixa');
    Open;
    Result := FieldByName('ULTIMO').AsInteger;
  end;
  FreeAndNil(ZQryConta);
end;

{ TParcela }

constructor TParcela.Create(pzcoConnection: TZConnection);
begin
  //zcoConnection := pzcoConnection;
  oParcela:= TRecConta.Create(pzcoConnection);
end;

destructor TParcela.Destroy;
begin
  FreeAndNil(oParcela);
  inherited;
end;

end.
