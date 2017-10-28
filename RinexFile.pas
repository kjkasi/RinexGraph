unit RinexFile;

interface

type
  TRinexFile = Class
  private
    { Private declarations }
  public
    { Public declarations }
    sFilePath: String;
    constructor Create(sFilePath: String); overload;
  end;

implementation

uses RegExpr;

{ TRinexFile }

constructor TRinexFile.Create(sFilePath: String);
begin
  //
end;

end.
