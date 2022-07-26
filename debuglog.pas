unit debuglog;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, StdCtrls;

type

  { TFormLog }

  TFormLog = class(TForm)
    Button1: TButton;
    CB_Log: TCheckBox;
    MemoDebugLog: TMemo;
    procedure Button1Click(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  FormLog: TFormLog;

implementation

{$R *.lfm}

{ TFormLog }

procedure TFormLog.Button1Click(Sender: TObject);
begin
  MemoDebugLog.Lines.Clear;
end;

end.

