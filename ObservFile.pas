unit ObservFile;

interface

uses RinexFile, Classes;

type
  TObservFile = Class(TRinexFile)
  private
    function GetFormatVersion: Double;
    procedure SetFormatVersion(const Value: Double);
    function Parse(sRegex: String): String;
    { Private declarations }
  public
    { Public declarations }
    sFilePath: String;
    property FormatVersion: Double read GetFormatVersion write SetFormatVersion;
    constructor Create(sFilePath: String); overload;
    destructor Destroy; override;
    function GetFormat(): String;
    function GetType(): String;
    function GetRinexVersionType(sRegex: String): String;
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
  StringList.LoadFromFile(sFilePath);
end;

destructor TObservFile.Destroy;
begin
  StringList.Free;
  inherited;
end;

function TObservFile.GetFormat: String;
const
  VersionRE = '.*\d*\.\d{2}\s{11}';
begin
  Result := '';
  Result := Parse (VersionRE);
end;

function TObservFile.GetFormatVersion: Double;
begin
  //
end;

function TObservFile.GetRinexVersionType(sRegex: String): String;
begin

end;

function TObservFile.GetType: String;
const
  TypeRE = ' {11}(O[A-Z]*|N:|G:).*';
begin
  Result := '';
  Result := Parse (TypeRE);
end;

function TObservFile.Parse(sRegex: String): String;
var
  r: TRegExpr;
begin
  Result := '';
  r := TRegExpr.Create;
  r.ModifierG := False;
  try
     r.Expression := sRegex;
     if r.Exec (StringList.Text) then
      REPEAT
       Result := Result + r.Match [0] + ',';
      UNTIL not r.ExecNext;
    finally r.Free;
   end;
end;

procedure TObservFile.SetFormatVersion(const Value: Double);
begin
  //
end;

end.
