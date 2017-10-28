unit ObservFile;

interface

uses RinexFile, Classes;

type
  PMath = procedure(Sender: TObject; sMath: String) of Object;

type
  TObservFile = Class(TRinexFile)
  private
    { Private declarations }
    FFileName: String;
    FMath: PMath;
    function Parse(sRegex: String): String; overload;
    function Parse(sRegex, Text: String): String; overload;
    function GetFileName: String;
    procedure SetFileName(const Value: String);
    function GetOnMath: PMath;
    procedure SetOnMath(const Value: PMath);
    function GetVersionType (): String;
  public
    { Public declarations }
    constructor Create(sFilePath: String); overload;
    destructor Destroy; override;
    procedure ParseRegex(sRegex: String);
    function GetType (): String;
    function GetVer (): String;
    function GetSystem (): String;
    property FileName: String read GetFileName write SetFileName;
    property OnMath: PMath read GetOnMath write SetOnMath;
  end;

var
  StringList: TStringList;

implementation

uses RegExpr;

{ TObservFile }

constructor TObservFile.Create(sFilePath: String);
begin
  inherited;
  Self.sFilePath := sFilePath;
  StringList := TStringList.Create;
  StringList.LoadFromFile (sFilePath);
end;

destructor TObservFile.Destroy;
begin
  StringList.Free;
  inherited;
end;

function TObservFile.GetFileName: String;
begin
  Result := FFileName;
end;

function TObservFile.GetOnMath: PMath;
begin
  Result := FMath;
end;

function TObservFile.GetSystem: String;
const SystemRE = '.{2}\(MIXED\).{11}';
begin
  Result := Parse(SystemRE, GetVersionType ());
end;

function TObservFile.GetType: String;
const TypeRE = '\s{11}(O|G:|N).{19}';
begin
  Result := Parse (TypeRE, GetVersionType ());
end;

function TObservFile.GetVer: String;
const VerRE = '.*\d*\.\d{2}\s{11}';
begin
  Result := Parse (VerRE, GetVersionType ());
end;

function TObservFile.GetVersionType: String;
const VersionTypeRE = '.*\d*\.\d{2}\s{11}.*RINEX VERSION / TYPE';
begin
  Result := Parse (VersionTypeRE, StringList.Text);
end;

function TObservFile.Parse(sRegex: String): String;
var
  r: TRegExpr;
begin
  Result := '';
  r := TRegExpr.Create;
  //r.ModifierG := False;
  try
     r.Expression := sRegex;
     if r.Exec (StringList.Text) then
      REPEAT
       Result := Result + r.Match [0];// + ',';
      UNTIL not r.ExecNext;
    finally r.Free;
   end;
end;

function TObservFile.Parse(sRegex, Text: String): String;
var
  r: TRegExpr;
begin
  Result := '';
  r := TRegExpr.Create;
  //r.ModifierG := False;
  try
    r.Expression := sRegex;
    if r.Exec (Text) then
      REPEAT
        Result := Result + r.Match [0];// + ',';
      UNTIL not r.ExecNext;
  finally
    r.Free;
  end;
end;

procedure TObservFile.ParseRegex(sRegex: String);
var
  r: TRegExpr;
begin
  //Result := '';
  r := TRegExpr.Create;
  //r.ModifierG := False;
  try
    r.Expression := sRegex;
    if r.Exec (StringList.Text) then
    begin
      repeat
        if @OnMath <> nil then FMath (Self, r.Match [0]);
      until not r.ExecNext;
    end
  finally
    r.Free;
  end;
end;

procedure TObservFile.SetFileName(const Value: String);
begin
  FFileName := Value;
end;

procedure TObservFile.SetOnMath(const Value: PMath);
begin
  FMath := Value;
end;

end.
