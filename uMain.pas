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
    procedure OnMath(Sender: TObject; sMath: String);
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
  Observ: TObservFile;
  DateDiff: TDateTime;
begin
  //if OpenDialog.Execute then
  begin
    Observ := TObservFile.Create ('C:\Users\AM\Desktop\!files\VSTU_2015_05_14_00.00.00.15O');
    //observ.OnMath := OnMath;
    //Memo1.Lines.Add('Format version: ');
    //Memo1.Lines.Add('Start');
    //observ.ParseRegex('.*\d*\.\d{2}\s{11}.*RINEX VERSION / TYPE');
    //Memo1.Lines.Add('Stop');
    //Memo1.Lines.Add(TimeToStr(Now()) + ' Начало');
    DateDiff := Now();
    Memo1.Lines.Add('Формат версии: ' + Observ.GetVer ());
    Memo1.Lines.Add('Тип файла: ' + Observ.GetType ());
    Memo1.Lines.Add('Спутниковая система: ' + Observ.GetSystem ());
    Memo1.Lines.Add('Время ' + TimeToStr(Now() - DateDiff));
  end;
end;

procedure TForm1.OnMath(Sender: TObject; sMath: String);
begin
  Memo1.Lines.Add(sMath);
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
