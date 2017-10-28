unit uMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TForm1 = class(TForm)
    OpenDialog: TOpenDialog;
    lblObserv: TLabel;
    btnObserv: TButton;
    Memo1: TMemo;
    procedure btnObservClick(Sender: TObject);
    function ParseHeader(sFilePath: String): Integer;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

uses RegExpr, ObservFile;

{$R *.dfm}

procedure TForm1.btnObservClick(Sender: TObject);
var
  observFile: TObservFile;
begin
  //if OpenDialog.Execute then
  begin
    observFile := TObservFile.Create ('C:\Users\AM\Desktop\!files\VSTU_2015_05_14_00.00.00.15O');
    //ShowMessage (observFile.GetFormat);
    Memo1.Lines.Add('Format version: ' + observFile.GetFormat);
    //Memo1.Lines.Add('File type: ' + observFile.GetType);
  end;
end;

function TForm1.ParseHeader(sFilePath: String): Integer;
var
  res: TextFile;
  sTemp: String;
  sl: TStringList;
begin
  AssignFile(res, sFilePath);
  Reset(res);
  Memo1.Lines.Add('---HEADER_START---');
  while not Eof(res) do
  begin
    Readln(Res, sTemp);
    Memo1.Lines.Add(sTemp);
    if Pos('END OF HEADER', sTemp) > 0 then Break;
  end;
  Memo1.Lines.Add('---HEADER_END---');
  CloseFile(res);
end;

end.
