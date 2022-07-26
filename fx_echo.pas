(* from the BASS help

typedef struct {
    float fLevel;
    int lDelay;
} BASS_BFX_ECHO;

Members
fLevel 	Echo level 	[0....1....n] linear
lDelay 	Delay in ms 	[1200..30000] ms

Info
This is an echo effect that replays what you have played one or more times after a period of time. It's something like the echoes you might hear shouting against a canyon wall.

The fLevel is the volume of a signal. The lDelay is the delay time in ms.

*)

unit fx_echo;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, ExtCtrls,
  StdCtrls, Buttons {$if not defined(HAIKU)} , bass, bass_fx {$ifend}, types;

type

  { TFormEcho }

  TFormEcho = class(TForm)
    Image1: TImage;
    Image2: TImage;
    Image3: TImage;
    ImageList1: TImageList;
    ImageList2: TImageList;
    ImageOff: TImage;
    ImageOn: TImage;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    LabelDelay: TLabel;
    LabelLevel: TLabel;
    LabelOnOff: TLabel;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    SpeedButton3: TSpeedButton;
    SpeedButton4: TSpeedButton;
    procedure FormShow(Sender: TObject);
    procedure Image2MouseWheelDown(Sender: TObject; Shift: TShiftState;
      MousePos: TPoint; var Handled: Boolean);
    procedure Image2MouseWheelUp(Sender: TObject; Shift: TShiftState;
      MousePos: TPoint; var Handled: Boolean);
    procedure Image3MouseWheelDown(Sender: TObject; Shift: TShiftState;
      MousePos: TPoint; var Handled: Boolean);
    procedure Image3MouseWheelUp(Sender: TObject; Shift: TShiftState;
      MousePos: TPoint; var Handled: Boolean);
    procedure ImageOffClick(Sender: TObject);
    procedure ImageOnClick(Sender: TObject);
    procedure LabelOnOffClick(Sender: TObject);
    Procedure Draw23(x: integer);
    Procedure Draw22(x: integer);
    procedure Setlevel;
    procedure setdelay;
    procedure SetEcho;
    procedure SpeedButton1Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);
    procedure SpeedButton4Click(Sender: TObject);
    Procedure SetMyLevel;
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  FormEcho: TFormEcho;

implementation

uses hoofd;

var knoplevel, knopdelay, knopstand1, knopstand2: integer;

{$R *.lfm}

procedure TFormEcho.Draw23(x: integer);
begin
  {$IFDEF LCLGTK2} ImageList2.Draw(Image3.Canvas,0,0,x,true);  {$ENDIF}
  {$IFDEF WINDOWS} ImageList2.Draw(Image3.Canvas,0,0,x,true);  {$ENDIF}
  {$IFDEF DARWIN} ImageList2.Draw(Image3.Picture.Bitmap.Canvas,0,0,x,true); {$ENDIF}
  {$IFDEF LCLQT} ImageList2.Draw(Image3.Picture.Bitmap.Canvas,0,0,x,true); {$ENDIF}
  {$IFDEF HAIKU} ImageList2.Draw(Image3.Picture.Bitmap.Canvas,0,0,x,true); {$ENDIF}
end;

procedure TFormEcho.Draw22(x: integer);
begin
  {$IFDEF LCLGTK2} ImageList2.Draw(Image2.Canvas,0,0,x,true);  {$ENDIF}
  {$IFDEF WINDOWS} ImageList2.Draw(Image2.Canvas,0,0,x,true);  {$ENDIF}
  {$IFDEF DARWIN} ImageList2.Draw(Image2.Picture.Bitmap.Canvas,0,0,x,true); {$ENDIF}
  {$IFDEF LCLQT} ImageList2.Draw(Image2.Picture.Bitmap.Canvas,0,0,x,true); {$ENDIF}
  {$IFDEF HAIKU} ImageList2.Draw(Image2.Picture.Bitmap.Canvas,0,0,x,true); {$ENDIF}
end;

procedure TFormEcho.Setdelay;
begin
  if delay<30001 then knopdelay:=17;
  if delay<28800 then knopdelay:=16;
  if delay<27000 then knopdelay:=15;
  if delay<26200 then knopdelay:=14;
  if delay<24600 then knopdelay:=13;
  if delay<22800 then knopdelay:=12;
  if delay<21000 then knopdelay:=11;
  if delay<19200 then knopdelay:=10;
  if delay<17400 then knopdelay:=9;
  if delay<15600 then knopdelay:=8;
  if delay<13800 then knopdelay:=7;
  if delay<12000 then knopdelay:=6;
  if delay<10200 then knopdelay:=5;
  if delay<8400 then knopdelay:=4;
  if delay<6600 then knopdelay:=3;
  if delay<4800 then knopdelay:=2;
  if delay<3000 then knopdelay:=1;
  if delay<1201 then knopdelay:=0;
  Labeldelay.Caption:=inttostr(delay);
end;

procedure TFormEcho.SetLevel;
begin
  if level<201 then knoplevel:=17;
  if level<194 then knoplevel:=16;
  if level<182 then knoplevel:=15;
  if level<170 then knoplevel:=14;
  if level<158 then knoplevel:=13;
  if level<146 then knoplevel:=12;
  if level<134 then knoplevel:=11;
  if level<122 then knoplevel:=10;
  if level<110 then knoplevel:=9;
  if level<98 then knoplevel:=8;
  if level<86 then knoplevel:=7;
  if level<74 then knoplevel:=6;
  if level<62 then knoplevel:=5;
  if level<50 then knoplevel:=4;
  if level<38 then knoplevel:=3;
  if level<26 then knoplevel:=2;
  if level<14 then knoplevel:=1;
  if level<2 then knoplevel:=0;
  Labellevel.Caption:=inttostr(level);
end;

procedure TFormEcho.SetEcho;
{$if not defined(HAIKU)}
var mystream: HStream;
{$ifend}
begin
  if is_echo_on then
  begin
    {$if not defined(HAIKU)}
    case stream of
     1,6: mystream:=Song_Stream1;
     2: mystream:=Song_Stream2;
     4: mystream:=Reversestream;
     5: mystream:=CDStream;
     10,11,12: mystream:=Radiostream;
    end;

    Fxeffects[0]:=BASS_ChannelSetFX(mystream,BASS_FX_BFX_ECHO,1);

    echo.flevel:=level/100;
    echo.ldelay:=delay;

    BASS_FXSetParameters(FxEffects[0],@echo);
    {$ifend}
  end;
end;

procedure TFormEcho.SpeedButton1Click(Sender: TObject);
begin
    dec(knopstand1);if knopstand1<0 then knopstand1:=11;
    {$IFDEF DARWIN}ImageList1.Draw(Image2.Picture.Bitmap.Canvas,0,0,knopstand1,true); {$ENDIF}
    {$IFDEF LCLQT}ImageList1.Draw(Image2.Picture.Bitmap.Canvas,0,0,knopstand1,true); {$ENDIF}
    {$IFDEF WINDOWS} ImageList1.Draw(Image2.Canvas,0,0,knopstand1,true); {$ENDIF}
    {$IFDEF LCLGTK2} ImageList1.Draw(Image2.Canvas,0,0,knopstand1,true); {$ENDIF}
    {$IFDEF HAIKU}ImageList1.Draw(Image2.Picture.Bitmap.Canvas,0,0,knopstand1,true); {$ENDIF}
  If is_echo_on then
  begin
   dec(level); if level<0 then level:=0;
   Setlevel;
   Draw22(knoplevel);
   SetMyLevel;
  end
  else Draw22(0);
  Application.ProcessMessages;
end;

procedure TFormEcho.SpeedButton2Click(Sender: TObject);
begin
   inc(knopstand1);if knopstand1>11 then knopstand1:=0;
  {$IFDEF DARWIN}ImageList1.Draw(Image2.Picture.Bitmap.Canvas,0,0,knopstand1,true); {$ENDIF}
  {$IFDEF LCLQT}ImageList1.Draw(Image2.Picture.Bitmap.Canvas,0,0,knopstand1,true); {$ENDIF}
  {$IFDEF WINDOWS} ImageList1.Draw(Image2.Canvas,0,0,knopstand1,true); {$ENDIF}
  {$IFDEF LCLGTK2} ImageList1.Draw(Image2.Canvas,0,0,knopstand1,true); {$ENDIF}
  {$IFDEF HAIKU}ImageList1.Draw(Image2.Picture.Bitmap.Canvas,0,0,knopstand1,true); {$ENDIF}
  If is_echo_on then
  begin
    inc(level); if level > 200 then level:=200;
    Setlevel;
    Draw22(knoplevel);
    SetMyLevel;
  end
  else Draw22(0);
end;

procedure TFormEcho.SpeedButton3Click(Sender: TObject);
begin
  dec(knopstand2);if knopstand2<0 then knopstand2:=11;
 {$IFDEF DARWIN} ImageList1.Draw(Image3.Picture.Bitmap.Canvas,0,0,knopstand2,true); {$ENDIF}
 {$IFDEF LCLQT} ImageList1.Draw(Image3.Picture.Bitmap.Canvas,0,0,knopstand2,true); {$ENDIF}
 {$IFDEF WINDOWS} ImageList1.Draw(Image3.Canvas,0,0,knopstand2,true); {$ENDIF}
 {$IFDEF LCLGTK2} ImageList1.Draw(Image3.Canvas,0,0,knopstand2,true); {$ENDIF}
 {$IFDEF HAIKU} ImageList1.Draw(Image3.Picture.Bitmap.Canvas,0,0,knopstand2,true); {$ENDIF}
 If is_echo_on then
 begin
   delay:=delay-200; if delay<1200 then delay:=1200;
   Setdelay;
   Draw23(knopdelay);
   SetMyLevel;
 end
 else Draw23(0);
end;

procedure TFormEcho.SpeedButton4Click(Sender: TObject);
begin
  inc(knopstand2);if knopstand2>11 then knopstand2:=0;
  {$IFDEF DARWIN} ImageList1.Draw(Image3.Picture.Bitmap.Canvas,0,0,knopstand2,true);{$ENDIF}
  {$IFDEF LCLQT} ImageList1.Draw(Image3.Picture.Bitmap.Canvas,0,0,knopstand2,true);{$ENDIF}
  {$IFDEF WINDOWS} ImageList1.Draw(Image3.Canvas,0,0,knopstand2,true);{$ENDIF}
  {$IFDEF LCLGTK2} ImageList1.Draw(Image3.Canvas,0,0,knopstand2,true);{$ENDIF}
  {$IFDEF HAIKU} ImageList1.Draw(Image3.Picture.Bitmap.Canvas,0,0,knopstand2,true);{$ENDIF}
  If is_echo_on then
  begin
    delay:=delay+200; if delay > 30000 then delay:=30000;
    Setdelay;
    Draw23(knopdelay);
    SetMyLevel;
  end
  else Draw23(0);
end;

procedure TFormEcho.ImageOnClick(Sender: TObject);
{$if not defined(HAIKU)}
var mystream: Hstream;
{$ifend}
begin
  is_echo_on:=false;
  Imageoff.Visible:=True;
  ImageOn.Visible:=False;
  LabelOnOff.Caption:='OFF';
  Draw23(0);
  Draw22(0);
  {$if not defined(HAIKU)}
  case stream of
     1,6: mystream:=Song_Stream1;
     2: mystream:=Song_Stream2;
     4: mystream:=Reversestream;
     5: mystream:=CDStream;
     10,11,12: mystream:=Radiostream;
  end;
  BASS_ChannelRemoveFX(mystream, fxEffects[0]);
  {$ifend}
  LabelLevel.Font.Color:=ClGray;
  LabelDelay.Font.Color:=ClGray;
  Label1.Font.Color:=ClGray;
  Label2.Font.Color:=ClGray;
end;

procedure TFormEcho.LabelOnOffClick(Sender: TObject);
begin
  If LabelOnOff.Caption='OFF' then ImageOffClick(self)
                              else ImageOnClick(self);
end;

procedure TFormEcho.ImageOffClick(Sender: TObject);
begin
  is_echo_on:=true;
  ImageOn.Visible:=True;
  Imageoff.Visible:=False;
  LabelOnOff.Caption:='ON ';
  Setlevel; Setdelay;
  Draw22(knoplevel);
  Draw23(knopdelay);
  SetEcho;
  LabelLevel.Font.Color:=ClLime;
  LabelDelay.Font.Color:=ClLime;
  Label1.Font.Color:=ClSkyBlue;
  Label2.Font.Color:=ClSkyBlue;
end;

procedure TFormEcho.FormShow(Sender: TObject);
begin
  knopstand1:=1; knopstand2:=1;
  SetLevel;  SetDelay;
end;

procedure TFormEcho.Image2MouseWheelDown(Sender: TObject; Shift: TShiftState;
  MousePos: TPoint; var Handled: Boolean);
begin
  dec(knopstand1);if knopstand1<0 then knopstand1:=11;
   {$IFDEF DARWIN} ImageList1.Draw(Image2.Picture.Bitmap.Canvas,0,0,knopstand1,true);{$ENDIF}
   {$IFDEF LCLQT} ImageList1.Draw(Image2.Picture.Bitmap.Canvas,0,0,knopstand1,true); {$ENDIF}
   {$IFDEF WINDOWS} ImageList1.Draw(Image2.Canvas,0,0,knopstand1,true); {$ENDIF}
   {$IFDEF LCLGTK2} ImageList1.Draw(Image2.Canvas,0,0,knopstand1,true); {$ENDIF}
   {$IFDEF HAIKU}  ImageList1.Draw(Image2.Picture.Bitmap.Canvas,0,0,knopstand1,true); {$ENDIF}
  If is_echo_on then
  begin
    dec(level); if level<0 then level:=0;
    Setlevel;
    Draw22(knoplevel);
    SetMyLevel;
  end
  else Draw22(0);
end;

procedure TFormEcho.Image2MouseWheelUp(Sender: TObject; Shift: TShiftState;
  MousePos: TPoint; var Handled: Boolean);
begin
  inc(knopstand1);if knopstand1>11 then knopstand1:=0;
  {$IFDEF DARWIN} ImageList1.Draw(Image2.Picture.Bitmap.Canvas,0,0,knopstand1,true); {$ENDIF}
  {$IFDEF LCLQT} ImageList1.Draw(Image2.Picture.Bitmap.Canvas,0,0,knopstand1,true);{$ENDIF}
  {$IFDEF WINDOWS} ImageList1.Draw(Image2.Canvas,0,0,knopstand1,true); {$ENDIF}
  {$IFDEF LCLGTK2} ImageList1.Draw(Image2.Canvas,0,0,knopstand1,true); {$ENDIF}
  {$IFDEF HAIKU} ImageList1.Draw(Image2.Picture.Bitmap.Canvas,0,0,knopstand1,true);{$ENDIF}
  If is_echo_on then
  begin
    inc(level); if level > 200 then level:=200;
    Setlevel;
    Draw22(knoplevel);
    SetMyLevel;
  end
  else Draw22(0);
end;

procedure TFormEcho.Image3MouseWheelDown(Sender: TObject; Shift: TShiftState;
  MousePos: TPoint; var Handled: Boolean);
begin
  dec(knopstand2);if knopstand2<0 then knopstand2:=11;
  {$IFDEF DARWIN} ImageList1.Draw(Image3.Picture.Bitmap.Canvas,0,0,knopstand2,true);{$ENDIF}
  {$IFDEF LCLQT} ImageList1.Draw(Image3.Picture.Bitmap.Canvas,0,0,knopstand2,true);{$ENDIF}
  {$IFDEF WINDOWS} ImageList1.Draw(Image3.Canvas,0,0,knopstand2,true); {$ENDIF}
  {$IFDEF LCLGTK2} ImageList1.Draw(Image3.Canvas,0,0,knopstand2,true); {$ENDIF}
  {$IFDEF HAIKU}ImageList1.Draw(Image3.Picture.Bitmap.Canvas,0,0,knopstand2,true); {$ENDIF}
  If is_echo_on then
  begin
    delay:=delay-200; if delay<1200 then delay:=1200;
    Setdelay;
    Draw23(knopdelay);
    SetMyLevel;
  end
  else Draw23(0);
end;

procedure TFormEcho.Image3MouseWheelUp(Sender: TObject; Shift: TShiftState;
  MousePos: TPoint; var Handled: Boolean);
begin
  inc(knopstand2);if knopstand2>11 then knopstand2:=0;
  {$IFDEF DARWIN} ImageList1.Draw(Image3.Picture.Bitmap.Canvas,0,0,knopstand2,true); {$ENDIF}
  {$IFDEF LCLQT} ImageList1.Draw(Image3.Picture.Bitmap.Canvas,0,0,knopstand2,true); {$ENDIF}
  {$IFDEF WINDOWS} ImageList1.Draw(Image3.Canvas,0,0,knopstand2,true); {$ENDIF}
  {$IFDEF LCLGTK2} ImageList1.Draw(Image3.Canvas,0,0,knopstand2,true); {$ENDIF}
  {$IFDEF HAIKU}  ImageList1.Draw(Image3.Picture.Bitmap.Canvas,0,0,knopstand2,true); {$ENDIF}
  If is_echo_on then
  begin
    delay:=delay+200; if delay > 30000 then delay:=30000;
    Setdelay;
    Draw23(knopdelay);
    SetMyLevel;
  end
  else Draw23(0);
end;

Procedure TFormEcho.SetMyLevel;
begin
   {$if not defined(HAIKU)}
  echo.flevel:=level/100;
  echo.ldelay:=delay;
  BASS_FXSetParameters(FxEffects[0],@echo);
   {$ifend}
end;

end.

