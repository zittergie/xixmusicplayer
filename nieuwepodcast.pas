unit nieuwepodcast;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  StdCtrls, Buttons;

type

  { TFormnieuwepodcast }

  TFormnieuwepodcast = class(TForm)
    Edit1: TEdit;
    Label1: TLabel;
    Panel1: TPanel;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    procedure Edit1KeyPress(Sender: TObject; var Key: char);
    procedure SpeedButton1Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  Formnieuwepodcast: TFormnieuwepodcast;

implementation

{$R *.lfm}

{ TFormnieuwepodcast }

procedure TFormnieuwepodcast.SpeedButton1Click(Sender: TObject);
begin
  Edit1.Text:='';
  Close;
end;

procedure TFormnieuwepodcast.Edit1KeyPress(Sender: TObject; var Key: char);
begin
  if key=#13 then Speedbutton2Click(Self);
end;

procedure TFormnieuwepodcast.SpeedButton2Click(Sender: TObject);
begin
  Close;
end;

end.

