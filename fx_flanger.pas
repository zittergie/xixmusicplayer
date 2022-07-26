(* from the BASS Help

typedef struct{
    float fWetDry;
    float fSpeed;
    int lChannel;
} BASS_BFX_FLANGER;

Members
fWetDry 	Ratio of wet (processed) signal to dry (unprocessed) signal 	[0..1..n] linear
fSpeed 	Flanger speed in ms 	[0..0.09] ms
lChannel 	The affected channels using BASS_BFX_CHANxxx flags

Info
Flangers mix a varying delayed signal (usually about 5mS to 15mS) with the original to produce a series of notches in the frequency response. The important difference between flanging and phasing is that a flanger produces a large number of notches that are harmonically (musically) related, while a phaser produces a small number of notches that are evenly spread across the frequency spectrum. With high resonance, you get the "jet plane" effect.

*)

unit fx_flanger;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, ExtCtrls,
  StdCtrls, Buttons, types {$if not defined(HAIKU)}, bass, bass_fx{$ifend};

type

  { TFormFlanger }

  TFormFlanger = class(TForm)
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
    LabelOnOff: TLabel;
    LabelSpeed: TLabel;
    LabelWet: TLabel;
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
    procedure SpeedButton1Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);
    procedure SpeedButton4Click(Sender: TObject);
    procedure Setwet;
    procedure SetFlanger;
    procedure SetSpeed;
    Procedure Draw23(x: integer);
    Procedure Draw22(x: integer);
    procedure SetMyFlanger;
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  FormFlanger: TFormFlanger;

implementation

uses hoofd, fx_echo;

var knopwet, knopspeed, knopstand1, knopstand2: integer;

  {$R *.lfm}

  { TFormFlanger }

  procedure TFormFlanger.Draw23(x: integer);
  begin
    {$IFDEF LCLGTK2} FormEcho.ImageList2.Draw(Image3.Canvas,0,0,x,true);  {$ENDIF}
    {$IFDEF WINDOWS} FormEcho.ImageList2.Draw(Image3.Canvas,0,0,x,true);  {$ENDIF}
    {$IFDEF DARWIN} FormEcho.ImageList2.Draw(Image3.Picture.Bitmap.Canvas,0,0,x,true); {$ENDIF}
    {$IFDEF LCLQT} FormEcho.ImageList2.Draw(Image3.Picture.Bitmap.Canvas,0,0,x,true); {$ENDIF}
    {$IFDEF HAIKU} FormEcho.ImageList2.Draw(Image3.Picture.Bitmap.Canvas,0,0,x,true); {$ENDIF}
  end;

  procedure TFormFlanger.Draw22(x: integer);
  begin
    {$IFDEF LCLGTK2} FormEcho.ImageList2.Draw(Image2.Canvas,0,0,x,true);  {$ENDIF}
    {$IFDEF WINDOWS} FormEcho.ImageList2.Draw(Image2.Canvas,0,0,x,true);  {$ENDIF}
    {$IFDEF DARWIN} FormEcho.ImageList2.Draw(Image2.Picture.Bitmap.Canvas,0,0,x,true); {$ENDIF}
    {$IFDEF LCLQT} FormEcho.ImageList2.Draw(Image2.Picture.Bitmap.Canvas,0,0,x,true); {$ENDIF}
    {$IFDEF HAIKU} FormEcho.ImageList2.Draw(Image2.Picture.Bitmap.Canvas,0,0,x,true); {$ENDIF}
  end;

  procedure TFormFlanger.LabelOnOffClick(Sender: TObject);
  begin
    If LabelOnOff.Caption='OFF' then ImageOffClick(self)
                                else ImageOnClick(self);
  end;

  procedure TFormFlanger.ImageOnClick(Sender: TObject);
  {$if not defined(HAIKU)}
  var mystream: Hstream;
  {$ifend}
  begin
    is_flanger_on:=false;
    Imageoff.Visible:=True;
    ImageOn.Visible:=False;
    LabelOnOff.Caption:='OFF';
    Draw22(0);
    Draw23(0);
    {$if not defined(HAIKU)}
    case stream of
      1,6: mystream:=Song_stream1;
      2: mystream:=Song_stream2;
      4: mystream:=Reversestream;
      5: mystream:=CDStream;
      10, 11, 12: mystream:=Radiostream;
    end;
    BASS_ChannelRemoveFX(mystream, fxEffects[1]);
    {$ifend}
    LabelWet.Font.Color:=ClGray; LabelSpeed.Font.Color:=ClGray;
    Label1.Font.Color:=ClGray; Label2.Font.Color:=ClGray;
  end;

  procedure TFormFlanger.SetSpeed;
  begin
    if speed<901 then knopspeed:=17;
    if speed<850 then knopspeed:=16;
    if speed<800 then knopspeed:=15;
    if speed<750 then knopspeed:=14;
    if speed<700 then knopspeed:=13;
    if speed<650 then knopspeed:=12;
    if speed<600 then knopspeed:=11;
    if speed<550 then knopspeed:=10;
    if speed<500 then knopspeed:=9;
    if speed<450 then knopspeed:=8;
    if speed<400 then knopspeed:=7;
    if speed<350 then knopspeed:=6;
    if speed<300 then knopspeed:=5;
    if speed<250 then knopspeed:=4;
    if speed<200 then knopspeed:=3;
    if speed<150 then knopspeed:=2;
    if speed<100 then knopspeed:=1;
    if speed<50 then knopspeed:=0;
    Labelspeed.Caption:=inttostr(speed);
  end;

  procedure TFormFlanger.SetMyFlanger;
  begin
    {$if not defined(HAIKU)}
    flanger.fWetDry:=wet/100;
    flanger.fSpeed:=speed;
    BASS_FXSetParameters(FxEffects[1],@flanger);
    {$ifend}
  end;

  procedure TFormFlanger.SpeedButton1Click(Sender: TObject);
  begin
    dec(knopstand1);if knopstand1<0 then knopstand1:=11;
    {$IFDEF DARWIN} FormEcho.ImageList1.Draw(Image2.Picture.Bitmap.Canvas,0,0,knopstand1,true); {$ENDIF}
    {$IFDEF LCLQT} FormEcho.ImageList1.Draw(Image2.Picture.Bitmap.Canvas,0,0,knopstand1,true); {$ENDIF}
    {$IFDEF HAIKU} FormEcho.ImageList1.Draw(Image2.Picture.Bitmap.Canvas,0,0,knopstand1,true); {$ENDIF}
    {$IFDEF DARWIN} FormEcho.ImageList1.Draw(Image2.Canvas,0,0,knopstand1,true); {$ENDIF}
    {$IFDEF LCLGTK2} FormEcho.ImageList1.Draw(Image2.Canvas,0,0,knopstand1,true); {$ENDIF}
    If is_flanger_on then
    begin
      dec(wet); if wet<0 then wet:=0;
      Setwet;
      Draw22(knopwet);
      SetMyFlanger;
    end
    else Draw22(0);
  end;

  procedure TFormFlanger.SpeedButton2Click(Sender: TObject);
  begin
    inc(knopstand1);if knopstand1>11 then knopstand1:=0;
  FormEcho.ImageList1.Draw(Image2.Canvas,0,0,knopstand1,true);
  If is_flanger_on then
  begin
    inc(wet); if wet > 200 then wet:=200;
    Setwet;
    Draw22(knopwet);
    SetMyFlanger;
  end
  else Draw22(0);
  end;

  procedure TFormFlanger.SpeedButton3Click(Sender: TObject);
  begin
      dec(knopstand2);if knopstand2<0 then knopstand2:=11;
    {$IFDEF DARWIN} FormEcho.ImageList1.Draw(Image3.Picture.Bitmap.Canvas,0,0,knopstand2,true); {$ENDIF}
    {$IFDEF LCLQT} FormEcho.ImageList1.Draw(Image3.Picture.Bitmap.Canvas,0,0,knopstand2,true); {$ENDIF}
    {$IFDEF HAIKU} FormEcho.ImageList1.Draw(Image3.Picture.Bitmap.Canvas,0,0,knopstand2,true); {$ENDIF}
    {$IFDEF DARWIN} FormEcho.ImageList1.Draw(Image3.Canvas,0,0,knopstand2,true);{$ENDIF}
     {$IFDEF LCLGTK2} FormEcho.ImageList1.Draw(Image3.Canvas,0,0,knopstand2,true);{$ENDIF}
    If is_flanger_on then
    begin
      speed:=speed-20; if speed<0 then speed:=0;
      Setspeed;
      Draw23(knopspeed);
      SetMyFlanger;
    end
    else Draw23(0);
  end;

  procedure TFormFlanger.SpeedButton4Click(Sender: TObject);
  begin
    inc(knopstand2);if knopstand2>11 then knopstand2:=0;
    {$IFDEF DARWIN} FormEcho.ImageList1.Draw(Image3.Picture.Bitmap.Canvas,0,0,knopstand2,true); {$ENDIF}
    {$IFDEF LCLQT} FormEcho.ImageList1.Draw(Image3.Picture.Bitmap.Canvas,0,0,knopstand2,true); {$ENDIF}
    {$IFDEF HAIKU} FormEcho.ImageList1.Draw(Image3.Picture.Bitmap.Canvas,0,0,knopstand2,true); {$ENDIF}
    {$IFDEF DARWIN} FormEcho.ImageList1.Draw(Image3.Canvas,0,0,knopstand2,true); {$ENDIF}
    {$IFDEF LCLGTK2} FormEcho.ImageList1.Draw(Image3.Canvas,0,0,knopstand2,true); {$ENDIF}
    If is_flanger_on then
    begin
      speed:=speed+20; if speed > 900 then speed:=900;
      Setspeed;
      Draw23(knopspeed);
      SetMyFlanger;
    end
    else Draw23(0);
  end;

  procedure TFormFlanger.Setwet;
  begin
    if wet<201 then knopwet:=17;
    if wet<194 then knopwet:=16;
    if wet<182 then knopwet:=15;
    if wet<170 then knopwet:=14;
    if wet<158 then knopwet:=13;
    if wet<146 then knopwet:=12;
    if wet<134 then knopwet:=11;
    if wet<122 then knopwet:=10;
    if wet<110 then knopwet:=9;
    if wet<98 then knopwet:=8;
    if wet<86 then knopwet:=7;
    if wet<74 then knopwet:=6;
    if wet<62 then knopwet:=5;
    if wet<50 then knopwet:=4;
    if wet<38 then knopwet:=3;
    if wet<26 then knopwet:=2;
    if wet<14 then knopwet:=1;
    if wet<2 then knopwet:=0;
    Labelwet.Caption:=inttostr(wet);
  end;

  procedure TFormFlanger.SetFlanger;
  {$if not defined(HAIKU)}
  var mystream: HStream;
  {$ifend}
  begin
    if is_flanger_on then
    begin
      {$if not defined(HAIKU)}
      case stream of
       1,6: mystream:=Song_stream1;
       2: mystream:=Song_stream2;
       4: mystream:=Reversestream;
       5: mystream:=CDStream;
       10, 11, 12: mystream:=Radiostream;
      end;

      flanger.lChannel:=BASS_BFX_CHANALL;

      Fxeffects[1]:=BASS_ChannelSetFX(mystream,BASS_FX_BFX_FLANGER,1);

      flanger.fWetDry:=wet/100;
      flanger.fSpeed:=speed;

      BASS_FXSetParameters(FxEffects[1],@flanger);
      {$ifend}
    end;
  end;

  procedure TFormFlanger.ImageOffClick(Sender: TObject);
  begin
    is_flanger_on:=true;
    ImageOn.Visible:=True;
    Imageoff.Visible:=False;
    LabelOnOff.Caption:='ON ';
    Setwet; SetSpeed;
    Draw22(knopwet);
    Draw23(knopspeed);
    SetFlanger;
    LabelWet.Font.Color:=ClLime; Labelspeed.Font.Color:=ClLime;
    Label1.Font.Color:=ClSkyBlue; Label2.Font.Color:=ClSkyBlue;
  end;

  procedure TFormFlanger.Image2MouseWheelDown(Sender: TObject;
    Shift: TShiftState; MousePos: TPoint; var Handled: Boolean);
  begin
    dec(knopstand1);if knopstand1<0 then knopstand1:=11;
    {$IFDEF DARWIN} FormEcho.ImageList1.Draw(Image2.Picture.Bitmap.Canvas,0,0,knopstand1,true); {$ENDIF}
    {$IFDEF LCLQT} FormEcho.ImageList1.Draw(Image2.Picture.Bitmap.Canvas,0,0,knopstand1,true); {$ENDIF}
    {$IFDEF HAIKU} FormEcho.ImageList1.Draw(Image2.Picture.Bitmap.Canvas,0,0,knopstand1,true); {$ENDIF}
    {$IFDEF DARWIN} FormEcho.ImageList1.Draw(Image2.Canvas,0,0,knopstand1,true); {$ENDIF}
    {$IFDEF LCLGTK2} FormEcho.ImageList1.Draw(Image2.Canvas,0,0,knopstand1,true); {$ENDIF}
    If is_flanger_on then
    begin
      dec(wet); if wet<0 then wet:=0;
      Setwet;
      Draw22(knopwet);
      SetMyFlanger;
    end
    else Draw22(0);
  end;

  procedure TFormFlanger.FormShow(Sender: TObject);
  begin
    knopstand1:=1; knopstand2:=1;
    SetWet; SetSpeed;
  end;

  procedure TFormFlanger.Image2MouseWheelUp(Sender: TObject; Shift: TShiftState;
    MousePos: TPoint; var Handled: Boolean);
  begin
    inc(knopstand1);if knopstand1>11 then knopstand1:=0;
    {$IFDEF DARWIN} FormEcho.ImageList1.Draw(Image2.Picture.Bitmap.Canvas,0,0,knopstand1,true); {$ENDIF}
    {$IFDEF LCLQT} FormEcho.ImageList1.Draw(Image2.Picture.Bitmap.Canvas,0,0,knopstand1,true); {$ENDIF}
    {$IFDEF HAIKU} FormEcho.ImageList1.Draw(Image2.Picture.Bitmap.Canvas,0,0,knopstand1,true); {$ENDIF}
    {$IFDEF WINDOWS} FormEcho.ImageList1.Draw(Image2.Canvas,0,0,knopstand1,true); {$ENDIF}
    {$IFDEF LCLGTK2} FormEcho.ImageList1.Draw(Image2.Canvas,0,0,knopstand1,true); {$ENDIF}
    If is_flanger_on then
    begin
      inc(wet); if wet > 200 then wet:=200;
      Setwet;
      Draw22(knopwet);
      SetMyFlanger;
    end
    else draw22(0);
  end;

  procedure TFormFlanger.Image3MouseWheelDown(Sender: TObject;
    Shift: TShiftState; MousePos: TPoint; var Handled: Boolean);
  begin
    dec(knopstand2);if knopstand2<0 then knopstand2:=11;
    {$IFDEF DARWIN} FormEcho.ImageList1.Draw(Image3.Picture.Bitmap.Canvas,0,0,knopstand2,true); {$ENDIF}
    {$IFDEF LCLQT} FormEcho.ImageList1.Draw(Image3.Picture.Bitmap.Canvas,0,0,knopstand2,true); {$ENDIF}
    {$IFDEF HAIKU} FormEcho.ImageList1.Draw(Image3.Picture.Bitmap.Canvas,0,0,knopstand2,true); {$ENDIF}
    {$IFDEF WINDOWS} FormEcho.ImageList1.Draw(Image3.Canvas,0,0,knopstand2,true); {$ENDIF}
    {$IFDEF LCLGTK2} FormEcho.ImageList1.Draw(Image3.Canvas,0,0,knopstand2,true); {$ENDIF}
    If is_flanger_on then
    begin
      speed:=speed-20; if speed<0 then speed:=0;
      Setspeed;
      Draw23(knopspeed);
      SetMyFlanger;
    end
    else Draw23(0);
  end;

  procedure TFormFlanger.Image3MouseWheelUp(Sender: TObject; Shift: TShiftState;
    MousePos: TPoint; var Handled: Boolean);
  begin
    inc(knopstand2);if knopstand2>11 then knopstand2:=0;
    {$IFDEF DARWIN} FormEcho.ImageList1.Draw(Image3.Picture.Bitmap.Canvas,0,0,knopstand2,true); {$ENDIF}
    {$IFDEF LCLQT} FormEcho.ImageList1.Draw(Image3.Picture.Bitmap.Canvas,0,0,knopstand2,true); {$ENDIF}
    {$IFDEF HAIKU} FormEcho.ImageList1.Draw(Image3.Picture.Bitmap.Canvas,0,0,knopstand2,true); {$ENDIF}
    {$IFDEF WINDOWS} FormEcho.ImageList1.Draw(Image3.Canvas,0,0,knopstand2,true); {$ENDIF}
    {$IFDEF LCLGTK2} FormEcho.ImageList1.Draw(Image3.Canvas,0,0,knopstand2,true); {$ENDIF}
    If is_flanger_on then
    begin
      speed:=speed+20; if speed > 900 then speed:=900;
      Setspeed;
      Draw23(knopspeed);
      SetMyFlanger;
    end
    else Draw23(0);
  end;

  end.

