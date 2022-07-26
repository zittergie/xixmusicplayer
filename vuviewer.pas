unit VuViewer;

{$mode objfpc}{$H+}

interface

uses bass, Classes, SysUtils, Forms, Graphics;

type TMyThread = class(TThread)
  private
    FFT: array[0..127] of single;
    procedure ShowMe;
  protected
    procedure Execute; override;
  public
    HStrm: HSTREAM;
    constructor Create;
end;

var
  info: BASS_ChannelInfo;
  FTData: array[0..127] of single;
  MyThread: TMyThread;
  TempVU1: Byte;
  vu1, vu2: integer;

implementation

uses hoofd, coverplayer;

procedure TMyThread.ShowMe;
var counter: integer;
    YAxes: integer;
    YValue, YValue2, co1, y, z: Integer;
    needle: longint;
begin
if (Form1.Timer1.Enabled) and not isMediaModeOn then    // No need to redraw when nothing is playing (Less CPU Usage when not playing)
 if VU_Settings.Active<4 then                                                         // Would be better to destroy the Thread and create a new thread when needed.
 begin
 If VU_Settings.Active=1 then       //DIGITAL VuLeft1
  begin
  if vu1<65000 then
    begin
      if vu1>500 then Form1.VuLeft1.Brush.Color:=clLime
                  else Form1.VuLeft1.Brush.Color:=$009EC09E;
      if vu1>2000 then Form1.VuLeft2.Brush.Color:=clLime
                  else Form1.VuLeft2.Brush.Color:=$009EC09E;
      if vu1>4500 then Form1.VuLeft3.Brush.Color:=clLime
                  else Form1.VuLeft3.Brush.Color:=$009EC09E;
      if vu1>6000 then Form1.VuLeft4.Brush.Color:=clLime
                  else Form1.VuLeft4.Brush.Color:=$009EC09E;
      if vu1>9000 then Form1.VuLeft5.Brush.Color:=clLime
                   else Form1.VuLeft5.Brush.Color:=$009EC09E;
      if vu1>12000 then Form1.VuLeft6.Brush.Color:=clLime
                   else Form1.VuLeft6.Brush.Color:=$009EC09E;
      if vu1>16000 then Form1.VuLeft7.Brush.Color:=$0000BD00
                   else Form1.VuLeft7.Brush.Color:=$00768B76;
      if vu1>20000 then Form1.VuLeft8.Brush.Color:=$0000BD00
                   else Form1.VuLeft8.Brush.Color:=$00768B76;
      if vu1>24000 then Form1.VuLeft9.Brush.Color:=$0000BD00
                   else Form1.VuLeft9.Brush.Color:=$00768B76;
      if vu1>28000 then Form1.VuLeft10.Brush.Color:=$0000BD00
                   else Form1.VuLeft10.Brush.Color:=$00768B76;
      if vu1>32000 then Form1.VuLeft11.Brush.Color:=clRed
                   else Form1.VuLeft11.Brush.Color:=$007878AC;
      if vu1>36000 then Form1.VuLeft12.Brush.Color:=clRed
                   else Form1.VuLeft12.Brush.Color:=$007878AC;

      if vu2>500 then Form1.VuRight1.Brush.Color:=clLime
                  else Form1.VuRight1.Brush.Color:=$009EC09E;
      if vu2>2000 then Form1.VuRight2.Brush.Color:=clLime
                  else Form1.VuRight2.Brush.Color:=$009EC09E;
      if vu2>4500 then Form1.VuRight3.Brush.Color:=clLime
                  else Form1.VuRight3.Brush.Color:=$009EC09E;
      if vu2>6000 then Form1.VuRight4.Brush.Color:=clLime
                  else Form1.VuRight4.Brush.Color:=$009EC09E;
      if vu2>9000 then Form1.VuRight5.Brush.Color:=clLime
                   else Form1.VuRight5.Brush.Color:=$009EC09E;
      if vu2>12000 then Form1.VuRight6.Brush.Color:=clLime
                   else Form1.VuRight6.Brush.Color:=$009EC09E;
      if vu2>16000 then Form1.VuRight7.Brush.Color:=$0000BD00
                   else Form1.VuRight7.Brush.Color:=$00768B76;
      if vu2>20000 then Form1.VuRight8.Brush.Color:=$0000BD00
                   else Form1.VuRight8.Brush.Color:=$00768B76;
      if vu2>24000 then Form1.VuRight9.Brush.Color:=$0000BD00
                   else Form1.VuRight9.Brush.Color:=$00768B76;
      if vu2>28000 then Form1.VuRight10.Brush.Color:=$0000BD00
                   else Form1.VuRight10.Brush.Color:=$00768B76;
      if vu2>32000 then Form1.VuRight11.Brush.Color:=clRed
                   else Form1.VuRight11.Brush.Color:=$007878AC;
      if vu2>36000 then Form1.VuRight12.Brush.Color:=clRed
                   else Form1.VuRight12.Brush.Color:=$007878AC;
    end
    else
    begin
      Form1.VuLeft1.Brush.Color:=$009EC09E;
      Form1.VuLeft2.Brush.Color:=$009EC09E;
      Form1.VuLeft3.Brush.Color:=$009EC09E;
      Form1.VuLeft4.Brush.Color:=$009EC09E;
      Form1.VuLeft5.Brush.Color:=$009EC09E;
      Form1.VuLeft6.Brush.Color:=$009EC09E;
      Form1.VuLeft7.Brush.Color:=$00768B76;
      Form1.VuLeft8.Brush.Color:=$00768B76;
      Form1.VuLeft9.Brush.Color:=$00768B76;
      Form1.VuLeft10.Brush.Color:=$00768B76;
      Form1.VuLeft11.Brush.Color:=$007878AC;
      Form1.VuLeft12.Brush.Color:=$007878AC;
      Form1.VuRight1.Brush.Color:=$009EC09E;
      Form1.VuRight2.Brush.Color:=$009EC09E;
      Form1.VuRight3.Brush.Color:=$009EC09E;
      Form1.VuRight4.Brush.Color:=$009EC09E;
      Form1.VuRight5.Brush.Color:=$009EC09E;
      Form1.VuRight6.Brush.Color:=$009EC09E;
      Form1.VuRight7.Brush.Color:=$00768B76;
      Form1.VuRight8.Brush.Color:=$00768B76;
      Form1.VuRight9.Brush.Color:=$00768B76;
      Form1.VuRight10.Brush.Color:=$00768B76;
      Form1.VuRight11.Brush.Color:=$007878AC;
      Form1.VuRight12.Brush.Color:=$007878AC;
    end;
  end;

 if VU_Settings.Active=2 then        // Analog VU Meter
 begin
   Co1:=((vu1+vu2) div 650)+(abs(vu1-vu2) div 300);
   if TempVu1>Co1 then TempVu1:=TempVu1+8;

   if co1>=182 then co1:=4
               else Co1:=3+((TempVu1+Co1) div 2);

   tempVu1:=Co1; y:=3+co1;

   if co1<24 then z:=36-(co1 div 3)
             else if co1<78 then z:=26-(co1 div 6)
                            else z:=(co1 div 6)-5;

    case VU_Settings.Theme of
      1: begin
           Form1.ImageListVU.GetBitmap(0, Form1.VuImage.Picture.Bitmap);
           needle:=clSkyBlue;
         end;
      2: Begin
           Form1.ImageListVU.GetBitmap(1, Form1.VuImage.Picture.Bitmap);
           needle:=clGray;
         end;
      3: begin
           Form1.ImageListVU.GetBitmap(2, Form1.VuImage.Picture.Bitmap);
           needle:=clOlive;
         end;
      end; (* of case *)
      Form1.VuImage.Canvas.Pen.Color:=needle;
      Form1.VuImage.Canvas.Pen.Width:=2;
      Form1.VuImage.Canvas.Line(94, 94, y, z);
  end;

 if VU_Settings.Active=3 then    // Spectrum Analyser
 begin
   If VU_Settings.Placement=2 then YAxes:= Form1.Panel_VU.Height div 2;
   If VU_Settings.Placement=3 then YAxes:= Form1.Panel_VU.Height-2;
   If VU_Settings.Placement=1 then YAxes:= 2;

   Form1.VuImage.Canvas.Pen.Width:=2;   Form1.VuImage.Canvas.Pen.Color:=clHighlight;
   Form1.VuImage.Canvas.Brush.Style:=bssolid; Form1.VuImage.Canvas.Brush.Color:=clBlack;
   Form1.VuImage.Canvas.Rectangle(0,0,Form1.Panel_VU.Width,Form1.Panel_VU.Height);
   For Counter:=0 to 117 do
   begin
    YValue:=round(MyThread.FFT[counter]*128); YValue2:=YValue;

    Form1.VuImage.Canvas.Pen.Color:=clLime;
    if VU_Settings.Placement=2 then
    begin
      if YValue>38 then YValue:=38;
      Form1.VuImage.Canvas.Line(2+counter*2,YAxes+YValue,round(2+counter*2),YAxes-YValue);
      if YValue2>60 then YValue2:=60;
      Form1.VuImage.Canvas.Pen.Color:=clGreen;
      Form1.VuImage.Canvas.Line(2+counter*2,YAxes+trunc(YValue2/1.8),2+counter*2,yAxes-trunc(YValue2/1.8));
      If VU_Settings.ShowPeaks then
      begin
        Form1.VuImage.Canvas.Pixels[Counter*2+2,YAxes-YValue]:=clRed;
        Form1.VuImage.Canvas.Pixels[Counter*2+3,YAxes-YValue]:=clRed;
      end;
    end;
   if VU_Settings.Placement=3 then
    begin
      if YValue>41 then YValue:=41;
      Form1.VuImage.Canvas.Line(2+counter*2,YAxes,2+counter*2,YAxes-round(YValue*1.8));
      if YValue2>60 then YValue2:=60;
      Form1.VuImage.Canvas.Pen.Color:=clGreen;
      Form1.VuImage.Canvas.Line(2+counter*2,YAxes,2+counter*2,yAxes-trunc(YValue2));
      If VU_Settings.ShowPeaks then
      begin
        Form1.VuImage.Canvas.Pixels[Counter*2+2,YAxes-round(YValue*1.8)]:=clRed;
        Form1.VuImage.Canvas.Pixels[Counter*2+3,YAxes-round(YValue*1.8)]:=clRed;
      end;
    end;
    if VU_Settings.Placement=1 then
    begin
      if YValue>40 then YValue:=40;
      Form1.VuImage.Canvas.Line(2+counter*2,YAxes,2+counter*2,YAxes+round(YValue*1.8));
      if YValue2>70 then YValue2:=70;
      Form1.VuImage.Canvas.Pen.Color:=clGreen;
      Form1.VuImage.Canvas.Line(2+counter*2,YAxes,2+counter*2,yAxes+trunc(YValue2));
      If VU_Settings.ShowPeaks then
      begin
        Form1.VuImage.Canvas.Pixels[Counter*2+2,YAxes+round(YValue*1.8)]:=clRed;
        Form1.VuImage.Canvas.Pixels[Counter*2+3,YAxes+round(YValue*1.8)]:=clRed;
      end;
    end;
   end;
 end;

 end;
 if isMediaModeOn then
 begin
    if CoverModePlayer<3 then
    begin
    if vu1<65000 then
      begin
        if vu1>500 then FormCoverPlayer.uELED1.Color:=clLime
                    else FormCoverPlayer.uELED1.Color:=$009EC09E;
        if vu1>2000 then FormCoverPlayer.uELED2.Color:=clLime
                    else FormCoverPlayer.uELED2.Color:=$009EC09E;
        if vu1>4500 then FormCoverPlayer.uELED3.Color:=clLime
                    else FormCoverPlayer.uELED3.Color:=$009EC09E;
        if vu1>6000 then FormCoverPlayer.uELED4.Color:=clLime
                    else FormCoverPlayer.uELED4.Color:=$009EC09E;
        if vu1>9000 then FormCoverPlayer.uELED5.Color:=clLime
                     else FormCoverPlayer.uELED5.Color:=$009EC09E;
        if vu1>12000 then FormCoverPlayer.uELED6.Color:=clLime
                     else FormCoverPlayer.uELED6.Color:=$009EC09E;
        if vu1>16000 then FormCoverPlayer.uELED7.Color:=$0000BD00
                     else FormCoverPlayer.uELED7.Color:=$00768B76;
        if vu1>20000 then FormCoverPlayer.uELED8.Color:=$0000BD00
                     else FormCoverPlayer.uELED8.Color:=$00768B76;
        if vu1>24000 then FormCoverPlayer.uELED9.Color:=$0000BD00
                     else FormCoverPlayer.uELED9.Color:=$00768B76;
        if vu1>28000 then FormCoverPlayer.uELED10.Color:=$0000BD00
                     else FormCoverPlayer.uELED10.Color:=$00768B76;
        if vu1>32000 then FormCoverPlayer.uELED11.Color:=clRed
                     else FormCoverPlayer.uELED11.Color:=$007878AC;
        if vu1>36000 then FormCoverPlayer.uELED12.Color:=clRed
                     else FormCoverPlayer.uELED12.Color:=$007878AC;

      end;
    if vu2<65000 then
      begin
        if vu2>500 then FormCoverPlayer.uELED13.Color:=clLime
                    else FormCoverPlayer.uELED13.Color:=$009EC09E;
        if vu2>2000 then FormCoverPlayer.uELED14.Color:=clLime
                    else FormCoverPlayer.uELED14.Color:=$009EC09E;
        if vu2>4500 then FormCoverPlayer.uELED15.Color:=clLime
                    else FormCoverPlayer.uELED15.Color:=$009EC09E;
        if vu2>6000 then FormCoverPlayer.uELED16.Color:=clLime
                    else FormCoverPlayer.uELED16.Color:=$009EC09E;
        if vu2>9000 then FormCoverPlayer.uELED17.Color:=clLime
                     else FormCoverPlayer.uELED17.Color:=$009EC09E;
        if vu2>12000 then FormCoverPlayer.uELED18.Color:=clLime
                     else FormCoverPlayer.uELED18.Color:=$009EC09E;
        if vu2>16000 then FormCoverPlayer.uELED19.Color:=$0000BD00
                     else FormCoverPlayer.uELED19.Color:=$00768B76;
        if vu2>20000 then FormCoverPlayer.uELED20.Color:=$0000BD00
                     else FormCoverPlayer.uELED20.Color:=$00768B76;
        if vu2>24000 then FormCoverPlayer.uELED21.Color:=$0000BD00
                     else FormCoverPlayer.uELED21.Color:=$00768B76;
        if vu2>28000 then FormCoverPlayer.uELED22.Color:=$0000BD00
                     else FormCoverPlayer.uELED22.Color:=$00768B76;
        if vu2>32000 then FormCoverPlayer.uELED23.Color:=clRed
                     else FormCoverPlayer.uELED23.Color:=$007878AC;
        if vu2>36000 then FormCoverPlayer.uELED24.Color:=clRed
                     else FormCoverPlayer.uELED24.Color:=$007878AC;

      end;
    end;
 end;
end;

constructor TMyThread.create;
begin
   inherited Create(true);
   Priority := tpLower;
   Start;
end;

procedure TMyThread.Execute;
begin
 while not Terminated do
   begin
      BASS_ChannelGetData(Streamvar, @FFT, BASS_DATA_FFT256);
      Sleep(50);
      Synchronize(@Showme);
   end;
end;

end.

