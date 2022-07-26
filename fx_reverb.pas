(* From the BASS help

typedef struct {
    float fLevel;
    int lDelay;
} BASS_BFX_REVERB;

Members
fLevel 	Reverb level 	[0..1..n] linear
lDelay 	Delay in ms      	[1200..10000] ms

Info
Reverb is the sound you hear in a room with hard surfaces (such as your bathroom) where sound bounces around the room for a while after the initial sound stops. This effect takes a lot of computing power to reproduce well.
Reverb is actually made up of a very large number of repeats, with varying levels and tones over time. Reverbs usually offer you a choice of different algorithm to simulate different environments such as different sized rooms and halls, studio effects such as plate, chamber and reverse * reverbs, and sometimes emulations of guitar spring reverbs.

The fLevel is the volume of a signal. The lDelay is the delay time in ms.

*)

unit fx_reverb;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, ExtCtrls,
  StdCtrls, Buttons {$if not defined(HAIKU)}, bass, bass_fx {$ifend}, types;

type

  { TFormReverb }

  TFormReverb = class(TForm)
    Image1: TImage;
    Image2: TImage;
    Image3: TImage;
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
    procedure Setlevel;
    procedure setdelay;
    procedure SetReverb;
    procedure SpeedButton1Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);
    procedure SpeedButton4Click(Sender: TObject);
    Procedure Draw23(x: integer);
    Procedure Draw22(x: integer);
    Procedure SetMyReverb;
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  FormReverb: TFormReverb;

implementation

{$R *.lfm}

uses hoofd, fx_echo;

var knoplevel, knopdelay, knopstand1, knopstand2: integer;

{ TFormReverb }

procedure TFormReverb.Draw23(x: integer);
begin
  {$IFDEF LCLGTK2} FormEcho.ImageList2.Draw(Image3.Canvas,0,0,x,true);  {$ENDIF}
  {$IFDEF WINDOWS} FormEcho.ImageList2.Draw(Image3.Canvas,0,0,x,true);  {$ENDIF}
  {$IFDEF DARWIN} FormEcho.ImageList2.Draw(Image3.Picture.Bitmap.Canvas,0,0,x,true); {$ENDIF}
  {$IFDEF LCLQT} FormEcho.ImageList2.Draw(Image3.Picture.Bitmap.Canvas,0,0,x,true); {$ENDIF}
  {$IFDEF HAIKU} FormEcho.ImageList2.Draw(Image3.Picture.Bitmap.Canvas,0,0,x,true); {$ENDIF}
end;

procedure TFormReverb.Draw22(x: integer);
begin
  {$IFDEF LCLGTK2} FormEcho.ImageList2.Draw(Image2.Canvas,0,0,x,true);  {$ENDIF}
  {$IFDEF WINDOWS} FormEcho.ImageList2.Draw(Image2.Canvas,0,0,x,true);  {$ENDIF}
  {$IFDEF DARWIN} FormEcho.ImageList2.Draw(Image2.Picture.Bitmap.Canvas,0,0,x,true); {$ENDIF}
  {$IFDEF LCLQT} FormEcho.ImageList2.Draw(Image2.Picture.Bitmap.Canvas,0,0,x,true); {$ENDIF}
  {$IFDEF HAIKU} FormEcho.ImageList2.Draw(Image2.Picture.Bitmap.Canvas,0,0,x,true); {$ENDIF}
end;

procedure TFormReverb.LabelOnOffClick(Sender: TObject);
begin
  If LabelOnOff.Caption='OFF' then ImageOffClick(self)
                              else ImageOnClick(self);
end;

procedure TFormReverb.ImageOffClick(Sender: TObject);
begin
  is_reverb_on:=true;
  ImageOn.Visible:=True; Imageoff.Visible:=False;
  LabelOnOff.Caption:='ON ';
  Setlevel; Setdelay;
  Draw22(knoplevel);
  Draw23(knopdelay);
  SetReverb;
  LabelLevel.Font.Color:=ClLime; LabelDelay.Font.Color:=ClLime;
  Label1.Font.Color:=ClSkyBlue; Label2.Font.Color:=ClSkyBlue;
end;

procedure TFormReverb.Setdelay;
begin
  if revdelay<10001 then knopdelay:=17;
  if revdelay<9600 then knopdelay:=16;
  if revdelay<9200 then knopdelay:=15;
  if revdelay<8800 then knopdelay:=14;
  if revdelay<8400 then knopdelay:=13;
  if revdelay<8000 then knopdelay:=12;
  if revdelay<7600 then knopdelay:=11;
  if revdelay<7000 then knopdelay:=10;
  if revdelay<6400 then knopdelay:=9;
  if revdelay<5800 then knopdelay:=8;
  if revdelay<5200 then knopdelay:=7;
  if revdelay<4600 then knopdelay:=6;
  if revdelay<4000 then knopdelay:=5;
  if revdelay<3400 then knopdelay:=4;
  if revdelay<2800 then knopdelay:=3;
  if revdelay<2200 then knopdelay:=2;
  if revdelay<1600 then knopdelay:=1;
  if revdelay<1201 then knopdelay:=0;
  Labeldelay.Caption:=inttostr(revdelay);
end;

procedure TFormReverb.SetLevel;
begin
  if revlevel<101 then knoplevel:=17;
  if revlevel<96 then knoplevel:=16;
  if revlevel<91 then knoplevel:=15;
  if revlevel<85 then knoplevel:=14;
  if revlevel<79 then knoplevel:=13;
  if revlevel<73 then knoplevel:=12;
  if revlevel<67 then knoplevel:=11;
  if revlevel<61 then knoplevel:=10;
  if revlevel<55 then knoplevel:=9;
  if revlevel<49 then knoplevel:=8;
  if revlevel<43 then knoplevel:=7;
  if revlevel<37 then knoplevel:=6;
  if revlevel<31 then knoplevel:=5;
  if revlevel<25 then knoplevel:=4;
  if revlevel<19 then knoplevel:=3;
  if revlevel<13 then knoplevel:=2;
  if revlevel<7 then knoplevel:=1;
  if revlevel<2 then knoplevel:=0;
  Labellevel.Caption:=inttostr(revlevel);
end;

procedure TFormReverb.SetReverb;
{$if not defined(HAIKU)}
var mystream: HStream;
{$ifend}
begin
  {$if not defined(HAIKU)}
  if is_reverb_on then
  begin
    case stream of
     1,6: mystream:=Song_Stream1;
     2: mystream:=Song_Stream2;
     4: mystream:=Reversestream;
     5: mystream:=CDStream;
     10, 11, 12: mystream:=Radiostream;
    end;

    Fxeffects[2]:=BASS_ChannelSetFX(mystream,BASS_FX_BFX_REVERB,1);

    reverb.flevel:=revlevel/100;
    reverb.ldelay:=revdelay;

    BASS_FXSetParameters(FxEffects[2],@reverb);
  end;
  {$ifend}
end;

procedure TFormReverb.SpeedButton1Click(Sender: TObject);
begin
  dec(knopstand1);if knopstand1<0 then knopstand1:=11;
  {$IFDEF DARWIN} FormEcho.ImageList1.Draw(Image2.Picture.Bitmap.Canvas,0,0,knopstand1,true); {$ENDIF}
  {$IFDEF LCLQT} FormEcho.ImageList1.Draw(Image2.Picture.Bitmap.Canvas,0,0,knopstand1,true); {$ENDIF}
  {$IFDEF WINDOWS} FormEcho.ImageList1.Draw(Image2.Canvas,0,0,knopstand1,true); {$ENDIF}
  {$IFDEF LCLGTK2} FormEcho.ImageList1.Draw(Image2.Canvas,0,0,knopstand1,true); {$ENDIF}
  {$IFDEF HAIKU} FormEcho.ImageList1.Draw(Image2.Picture.Bitmap.Canvas,0,0,knopstand1,true); {$ENDIF}
  If is_reverb_on then
  begin
    dec(revlevel); if revlevel<0 then revlevel:=0;
    Setlevel;
    Draw22(knoplevel);
    SetMyReverb;
  end
  else Draw22(0);
end;

procedure TFormReverb.SetMyReverb;
begin
  {$if not defined(HAIKU)}
  reverb.flevel:=revlevel/100;
  reverb.ldelay:=revdelay;
  BASS_FXSetParameters(FxEffects[2],@reverb);
  {$ifend}
end;

procedure TFormReverb.SpeedButton2Click(Sender: TObject);
begin
  inc(knopstand1);if knopstand1>11 then knopstand1:=0;
  {$IFDEF DARWIN} FormEcho.ImageList1.Draw(Image2.Picture.Bitmap.Canvas,0,0,knopstand1,true); {$ENDIF}
  {$IFDEF LCLQT} FormEcho.ImageList1.Draw(Image2.Picture.Bitmap.Canvas,0,0,knopstand1,true); {$ENDIF}
  {$IFDEF WINDOWS} FormEcho.ImageList1.Draw(Image2.Canvas,0,0,knopstand1,true); {$ENDIF}
  {$IFDEF LCLGTK2} FormEcho.ImageList1.Draw(Image2.Canvas,0,0,knopstand1,true); {$ENDIF}
  {$IFDEF HAIKU} FormEcho.ImageList1.Draw(Image2.Picture.Bitmap.Canvas,0,0,knopstand1,true); {$ENDIF}
  If is_reverb_on then
  begin
    inc(revlevel); if revlevel > 100 then revlevel:=100;
    Setlevel;
    Draw22(knoplevel);
    SetMyReverb;
  end
  else Draw22(0);
end;

procedure TFormReverb.SpeedButton3Click(Sender: TObject);
begin
  dec(knopstand2);if knopstand2<0 then knopstand2:=11;
  {$IFDEF DARWIN} FormEcho.ImageList1.Draw(Image3.Picture.Bitmap.Canvas,0,0,knopstand2,true); {$ENDIF}
  {$IFDEF LCLQT} FormEcho.ImageList1.Draw(Image3.Picture.Bitmap.Canvas,0,0,knopstand2,true); {$ENDIF}
  {$IFDEF WINDOWS} FormEcho.ImageList1.Draw(Image3.Canvas,0,0,knopstand2,true); {$ENDIF}
  {$IFDEF LCLGTK2} FormEcho.ImageList1.Draw(Image3.Canvas,0,0,knopstand2,true); {$ENDIF}
  {$IFDEF HAIKU} FormEcho.ImageList1.Draw(Image3.Picture.Bitmap.Canvas,0,0,knopstand2,true); {$ENDIF}
  If is_reverb_on then
  begin
    revdelay:=revdelay-100; if revdelay<1200 then revdelay:=1200;
    Setdelay;
    Draw23(knopdelay);
    SetMyReverb;
  end
  else Draw23(0);
end;

procedure TFormReverb.SpeedButton4Click(Sender: TObject);
begin
  inc(knopstand2);if knopstand2>11 then knopstand2:=0;
  {$IFDEF DARWIN} FormEcho.ImageList1.Draw(Image3.Picture.Bitmap.Canvas,0,0,knopstand2,true); {$ENDIF}
  {$IFDEF LCLQT} FormEcho.ImageList1.Draw(Image3.Picture.Bitmap.Canvas,0,0,knopstand2,true); {$ENDIF}
  {$IFDEF WINDOWS} Formecho.ImageList1.Draw(Image3.Canvas,0,0,knopstand2,true); {$ENDIF}
  {$IFDEF LCLGTK2} Formecho.ImageList1.Draw(Image3.Canvas,0,0,knopstand2,true); {$ENDIF}
  {$IFDEF HAIKU} FormEcho.ImageList1.Draw(Image3.Picture.Bitmap.Canvas,0,0,knopstand2,true); {$ENDIF}
  If is_reverb_on then
  begin
    revdelay:=revdelay+100; if delay > 10000 then delay:=10000;
    Setdelay;
    Draw23(knopdelay);
    SetMyReverb;
  end
  else Draw23(0);
end;

procedure TFormReverb.Image2MouseWheelDown(Sender: TObject; Shift: TShiftState;
  MousePos: TPoint; var Handled: Boolean);
begin
  dec(knopstand1);if knopstand1<0 then knopstand1:=11;
  {$IFDEF DARWIN} FormEcho.ImageList1.Draw(Image2.Picture.Bitmap.Canvas,0,0,knopstand1,true); {$ENDIF}
  {$IFDEF LCLQT} FormEcho.ImageList1.Draw(Image2.Picture.Bitmap.Canvas,0,0,knopstand1,true); {$ENDIF}
  {$IFDEF WINDOWS} FormEcho.ImageList1.Draw(Image2.Canvas,0,0,knopstand1,true); {$ENDIF}
  {$IFDEF LCLGTK2} FormEcho.ImageList1.Draw(Image2.Canvas,0,0,knopstand1,true); {$ENDIF}
  {$IFDEF HAIKU} FormEcho.ImageList1.Draw(Image2.Picture.Bitmap.Canvas,0,0,knopstand1,true); {$ENDIF}
  If is_reverb_on then
  begin
    dec(revlevel); if revlevel<0 then revlevel:=0;
    Setlevel;
    Draw22(knoplevel);
    SetMyReverb;
  end
  else Draw22(0);
end;

procedure TFormReverb.FormShow(Sender: TObject);
begin
  knopstand1:=1; knopstand2:=1;
  SetLevel;  SetReverb;
end;

procedure TFormReverb.Image2MouseWheelUp(Sender: TObject; Shift: TShiftState;
  MousePos: TPoint; var Handled: Boolean);
begin
  inc(knopstand1);if knopstand1>11 then knopstand1:=0;
  {$IFDEF DARWIN} FormEcho.ImageList1.Draw(Image2.Picture.Bitmap.Canvas,0,0,knopstand1,true); {$ENDIF}
  {$IFDEF LCLQT} FormEcho.ImageList1.Draw(Image2.Picture.Bitmap.Canvas,0,0,knopstand1,true); {$ENDIF}
  {$IFDEF WINDOWS} FormEcho.ImageList1.Draw(Image2.Canvas,0,0,knopstand1,true); {$ENDIF}
  {$IFDEF LCLGTK2} FormEcho.ImageList1.Draw(Image2.Canvas,0,0,knopstand1,true); {$ENDIF}
  {$IFDEF HAIKU} FormEcho.ImageList1.Draw(Image2.Picture.Bitmap.Canvas,0,0,knopstand1,true); {$ENDIF}
  If is_reverb_on then
  begin
    inc(revlevel); if revlevel > 100 then revlevel:=100;
    Setlevel;
    Draw22(knoplevel);
    SetMyReverb;
  end
  else Draw22(0);
end;

procedure TFormReverb.Image3MouseWheelDown(Sender: TObject; Shift: TShiftState;
  MousePos: TPoint; var Handled: Boolean);
begin
  dec(knopstand2);if knopstand2<0 then knopstand2:=11;
  {$IFDEF DARWIN} FormEcho.ImageList1.Draw(Image3.Picture.Bitmap.Canvas,0,0,knopstand2,true); {$ENDIF}
  {$IFDEF LCLQT} FormEcho.ImageList1.Draw(Image3.Picture.Bitmap.Canvas,0,0,knopstand2,true); {$ENDIF}
  {$IFDEF WINDOWS} FormEcho.ImageList1.Draw(Image3.Canvas,0,0,knopstand2,true); {$ENDIF}
  {$IFDEF LCLGTK2} FormEcho.ImageList1.Draw(Image3.Canvas,0,0,knopstand2,true); {$ENDIF}
  {$IFDEF HAIKU} FormEcho.ImageList1.Draw(Image3.Picture.Bitmap.Canvas,0,0,knopstand2,true); {$ENDIF}
  If is_reverb_on then
  begin
    revdelay:=revdelay-100; if revdelay<1200 then revdelay:=1200;
    Setdelay;
    Draw23(knopdelay);
    SetMyReverb;
  end
  else Draw23(0);
end;

procedure TFormReverb.Image3MouseWheelUp(Sender: TObject; Shift: TShiftState;
  MousePos: TPoint; var Handled: Boolean);
begin
  inc(knopstand2);if knopstand2>11 then knopstand2:=0;
  {$IFDEF DARWIN} FormEcho.ImageList1.Draw(Image3.Picture.Bitmap.Canvas,0,0,knopstand2,true); {$ENDIF}
  {$IFDEF LCLQT} FormEcho.ImageList1.Draw(Image3.Picture.Bitmap.Canvas,0,0,knopstand2,true); {$ENDIF}
  {$IFDEF WINDOWS} Formecho.ImageList1.Draw(Image3.Canvas,0,0,knopstand2,true); {$ENDIF}
  {$IFDEF LCLGTK2} Formecho.ImageList1.Draw(Image3.Canvas,0,0,knopstand2,true); {$ENDIF}
  {$IFDEF HAIKU} FormEcho.ImageList1.Draw(Image3.Picture.Bitmap.Canvas,0,0,knopstand2,true); {$ENDIF}
  If is_reverb_on then
  begin
    revdelay:=revdelay+100; if delay > 10000 then delay:=10000;
    Setdelay;
    Draw23(knopdelay);
    SetMyReverb;
  end
  else Draw23(0);
end;

procedure TFormReverb.ImageOnClick(Sender: TObject);
{$if not defined(HAIKU)}
var mystream: HStream;
{$ifend}
begin
  is_reverb_on:=false;
  Imageoff.Visible:=True;  ImageOn.Visible:=False;
  LabelOnOff.Caption:='OFF';
  Draw22(0);
  Draw23(0);
  {$if not defined(HAIKU)}
  case stream of
    1,6: mystream:=Song_Stream1;
    2: mystream:=Song_Stream2;
    4: mystream:=Reversestream;
    5: mystream:=CDStream;
    10, 11, 12: mystream:=Radiostream;
  end;
  BASS_ChannelRemoveFX(mystream, fxEffects[2]);
  {$ifend}
  LabelLevel.Font.Color:=ClGray; LabelDelay.Font.Color:=ClGray;
  Label1.Font.Color:=ClGray; Label2.Font.Color:=ClGray;
end;

end.

