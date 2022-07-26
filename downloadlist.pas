unit downloadlist;

{$mode objfpc}{$H+}

interface

uses
  Classes, Forms, Controls, StdCtrls, Buttons;

type

  { TFormDownLoadOverView }

  TFormDownLoadOverView = class(TForm)
    ListBox1: TListBox;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    SpeedButton3: TSpeedButton;
    procedure SpeedButton1Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  FormDownLoadOverView: TFormDownLoadOverView;

implementation

{$R *.lfm}

{ TFormDownLoadOverView }

procedure TFormDownLoadOverView.SpeedButton1Click(Sender: TObject);
begin

end;

procedure TFormDownLoadOverView.SpeedButton2Click(Sender: TObject);
begin

end;

procedure TFormDownLoadOverView.SpeedButton3Click(Sender: TObject);
begin

end;

end.

