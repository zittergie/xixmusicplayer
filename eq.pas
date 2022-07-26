unit eq;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  StdCtrls, ComCtrls, Menus {$if not defined(HAIKU)}  ,bass, bass_fx {$ifend};

type

  { TFormEQ }

  TFormEQ = class(TForm)
    Bevel1: TBevel;
    CB_EQ: TCheckBox;
    ComboBox1: TComboBox;
    Label1: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    Label2: TLabel;
    Label20: TLabel;
    Label21: TLabel;
    Label22: TLabel;
    Label23: TLabel;
    Label24: TLabel;
    Label25: TLabel;
    Label26: TLabel;
    Label27: TLabel;
    Label28: TLabel;
    Label29: TLabel;
    Label3: TLabel;
    Label30: TLabel;
    Label31: TLabel;
    Label32: TLabel;
    Label33: TLabel;
    Label34: TLabel;
    Label35: TLabel;
    Label36: TLabel;
    Label37: TLabel;
    Label38: TLabel;
    Label39: TLabel;
    Label4: TLabel;
    Label40: TLabel;
    Label41: TLabel;
    Label42: TLabel;
    Label43: TLabel;
    Label44: TLabel;
    Label45: TLabel;
    Label46: TLabel;
    Label47: TLabel;
    Label48: TLabel;
    Label49: TLabel;
    Label5: TLabel;
    Label50: TLabel;
    Label51: TLabel;
    Label52: TLabel;
    Label53: TLabel;
    Label54: TLabel;
    Label55: TLabel;
    Label56: TLabel;
    Label57: TLabel;
    Label58: TLabel;
    Label59: TLabel;
    Label6: TLabel;
    Label60: TLabel;
    Label61: TLabel;
    Label62: TLabel;
    Label63: TLabel;
    Label64: TLabel;
    Label65: TLabel;
    Label66: TLabel;
    Label67: TLabel;
    Label68: TLabel;
    Label69: TLabel;
    Label7: TLabel;
    Label70: TLabel;
    Label71: TLabel;
    Label72: TLabel;
    Label73: TLabel;
    Label74: TLabel;
    Label75: TLabel;
    Label76: TLabel;
    Label77: TLabel;
    Label78: TLabel;
    Label79: TLabel;
    Label8: TLabel;
    Label80: TLabel;
    Label81: TLabel;
    Label82: TLabel;
    Label83: TLabel;
    Label84: TLabel;
    Label85: TLabel;
    Label86: TLabel;
    Label87: TLabel;
    Label88: TLabel;
    Label89: TLabel;
    Label9: TLabel;
    Label90: TLabel;
    Label91: TLabel;
    Label92: TLabel;
    Label93: TLabel;
    Label94: TLabel;
    MenuItem1: TMenuItem;
    MenuItem2: TMenuItem;
    MenuItem3: TMenuItem;
    MenuItem4: TMenuItem;
    PopupMenu1: TPopupMenu;
    PopupMenu2: TPopupMenu;
    TB_Balance: TTrackBar;
    TB_EQ1: TTrackBar;
    TB_EQ10: TTrackBar;
    TB_EQ2: TTrackBar;
    TB_EQ3: TTrackBar;
    TB_EQ4: TTrackBar;
    TB_EQ5: TTrackBar;
    TB_EQ6: TTrackBar;
    TB_EQ7: TTrackBar;
    TB_EQ8: TTrackBar;
    TB_EQ9: TTrackBar;
    TrackBar1: TTrackBar;
    procedure CB_EQChange(Sender: TObject);
    procedure ComboBox1Select(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure MenuItem1Click(Sender: TObject);
    procedure MenuItem2Click(Sender: TObject);
    procedure MenuItem3Click(Sender: TObject);
    procedure MenuItem4Click(Sender: TObject);
    procedure SetEQPreset;
    procedure TB_BalanceChange(Sender: TObject);
    procedure TB_EQ10Change(Sender: TObject);
    procedure TB_EQ1Change(Sender: TObject);
    procedure TB_EQ2Change(Sender: TObject);
    procedure TB_EQ3Change(Sender: TObject);
    procedure TB_EQ4Change(Sender: TObject);
    procedure TB_EQ5Change(Sender: TObject);
    procedure TB_EQ6Change(Sender: TObject);
    procedure TB_EQ7Change(Sender: TObject);
    procedure TB_EQ8Change(Sender: TObject);
    procedure TB_EQ9Change(Sender: TObject);
    procedure TrackBar1Change(Sender: TObject);
    procedure SetEQ;
    procedure UpdateEQ;
    procedure SetCustomEQ(track: longint);
    procedure CheckAllFX;
    procedure SetMyEQ;
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  FormEQ: TFormEQ;

implementation

uses hoofd, fx_echo, fx_flanger, fx_reverb;

{$R *.lfm}

{ TFormEQ }

procedure TFormEQ.MenuItem2Click(Sender: TObject);
begin
  TrackBar1.Position:=100;
end;

procedure TFormEQ.MenuItem3Click(Sender: TObject);
begin
  TB_Balance.Position:=-10;
end;

procedure TFormEQ.MenuItem4Click(Sender: TObject);
begin
  TB_Balance.Position:=10;
end;

procedure TFormEQ.MenuItem1Click(Sender: TObject);
begin
  TB_Balance.Position:=0;
end;

procedure TFormEQ.SetEQPreset;
begin
  TB_EQ1.Position:=EQ_Preset[EQ_Set,1];
  TB_EQ2.Position:=EQ_Preset[EQ_Set,2];
  TB_EQ3.Position:=EQ_Preset[EQ_Set,3];
  TB_EQ4.Position:=EQ_Preset[EQ_Set,4];
  TB_EQ5.Position:=EQ_Preset[EQ_Set,5];
  TB_EQ6.Position:=EQ_Preset[EQ_Set,6];
  TB_EQ7.Position:=EQ_Preset[EQ_Set,7];
  TB_EQ8.Position:=EQ_Preset[EQ_Set,8];
  TB_EQ9.Position:=EQ_Preset[EQ_Set,9];
  TB_EQ10.Position:=EQ_Preset[EQ_Set,10];
end;

procedure TFormEQ.TB_BalanceChange(Sender: TObject);
{$if not defined(HAIKU)}
var mystream: HStream;
{$ifend}
begin
  {$if not defined(HAIKU)}
  if stream=1 then myStream:=Song_Stream1;
  if stream=2 then myStream:=Song_Stream2;
  if stream=6 then myStream:=Song_Stream1;
  if stream=4 then myStream:=ReverseStream;
  if stream=5 then mystream:=CDstream;
  if stream>9 then mystream:=Radiostream;
  BASS_ChannelSetAttribute(mystream,BASS_ATTRIB_PAN,(TB_Balance.Position/10));
  {$ifend}
end;

procedure TFormEQ.CheckAllFX;
begin
  if Liedjes[songplaying].EQ then SetCustomEQ(songplaying)
                             else If CB_EQ.Checked then FormEQ.SetEQ;
  TB_BalanceChange(Self);
  TrackBar1Change(Self);
  If is_echo_on then FormEcho.SetEcho;
  If is_reverb_on then FormReverb.SetReverb;
  If is_Flanger_on then FormFlanger.SetFlanger;
end;

procedure TFormEQ.TB_EQ10Change(Sender: TObject);
begin
  if CB_EQ.Checked then
  begin
    UpdateEQ;
    If EQ_Set>6 then EQ_Preset[EQ_Set,10]:=TB_EQ10.Position;
  end;
end;

procedure TFormEQ.TB_EQ1Change(Sender: TObject);
begin
  if CB_EQ.Checked then
  begin
    UpdateEQ;
    If EQ_Set>6 then EQ_Preset[EQ_Set,1]:=TB_EQ1.Position;
  end;
end;

procedure TFormEQ.TB_EQ2Change(Sender: TObject);
begin
  if CB_EQ.Checked then
  begin
    UpdateEQ;
    If EQ_Set>6 then EQ_Preset[EQ_Set,2]:=TB_EQ2.Position;
  end;
end;

procedure TFormEQ.TB_EQ3Change(Sender: TObject);
begin
  if CB_EQ.Checked then
  begin
    UpdateEQ;
    If EQ_Set>6 then EQ_Preset[EQ_Set,3]:=TB_EQ3.Position;
  end;
end;

procedure TFormEQ.TB_EQ4Change(Sender: TObject);
begin
  if CB_EQ.Checked then
  begin
    UpdateEQ;
    If EQ_Set>6 then EQ_Preset[EQ_Set,4]:=TB_EQ4.Position;
  end;
end;

procedure TFormEQ.TB_EQ5Change(Sender: TObject);
begin
  if CB_EQ.Checked then
  begin
    UpdateEQ;
    If EQ_Set>6 then EQ_Preset[EQ_Set,5]:=TB_EQ5.Position;
  end;
end;

procedure TFormEQ.TB_EQ6Change(Sender: TObject);
begin
  if CB_EQ.Checked then
  begin
    UpdateEQ;
    If EQ_Set>6 then EQ_Preset[EQ_Set,6]:=TB_EQ6.Position;
  end;
end;

procedure TFormEQ.TB_EQ7Change(Sender: TObject);
begin
  if CB_EQ.Checked then
  begin
    UpdateEQ;
    If EQ_Set>6 then EQ_Preset[EQ_Set,7]:=TB_EQ7.Position;
  end;
end;

procedure TFormEQ.TB_EQ8Change(Sender: TObject);
begin
  if CB_EQ.Checked then
  begin
    UpdateEQ;
    If EQ_Set>6 then EQ_Preset[EQ_Set,8]:=TB_EQ8.Position;
  end;
end;

procedure TFormEQ.TB_EQ9Change(Sender: TObject);
begin
  if CB_EQ.Checked then
  begin
    UpdateEQ;
    If EQ_Set>6 then EQ_Preset[EQ_Set,9]:=TB_EQ9.Position;
  end;
end;


procedure TFormEQ.TrackBar1Change(Sender: TObject);
begin
  // Als Prevolume reeds imnevuld in Liedjes, dan heeft het prevolume van het liedje voorrang
  // Moet nog geprogrameerd worden.
  if (CB_EQ.Checked) and (not Liedjes[songplaying].EQ) then
  begin
    {$if not defined(HAIKU)}
    BASS_FXGetParameters(FxEqualizer[0],@PreVolume);
    PreVolume.lChannel:=BASS_BFX_CHANALL;
    PreVolume.fVolume:=TrackBar1.Position/100;
    BASS_FXSetParameters(FxEqualizer[0],@PreVolume);
    {$ifend}
  end;
end;

procedure TFormEQ.SetMyEQ;
begin
  {$if not defined(HAIKU)}
    BASS_FXSetParameters(FxEqualizer[1],@Equalizer);
  {$ifend}
end;

procedure TFormEQ.UpdateEQ;
begin
  if CB_EQ.Checked then
  begin
  if not Liedjes[songplaying].EQ then
  begin
     {$if not defined(HAIKU)}
    Equalizer.fGain:=TB_EQ1.Position;
    Equalizer.fBandwidth:=1;
    Equalizer.fCenter:=32;
    Equalizer.lBand:=0;
    Equalizer.lChannel:=BASS_BFX_CHANALL;
    SetMyEQ;
    Equalizer.fGain:=TB_EQ2.Position;
    Equalizer.lBand:=1;
    Equalizer.fCenter:=64;
    SetMyEQ;
    Equalizer.fGain:=TB_EQ3.Position;
    Equalizer.lBand:=2;
    Equalizer.fCenter:=128;
    SetMyEQ;
    Equalizer.fGain:=TB_EQ4.Position;
    Equalizer.lBand:=3;
    Equalizer.fCenter:=256;
    SetMyEQ;
    Equalizer.fGain:=TB_EQ5.Position;
    Equalizer.lBand:=4;
    Equalizer.fCenter:=512;
    SetMyEQ;
    Equalizer.fGain:=TB_EQ6.Position;
    Equalizer.lBand:=5;
    Equalizer.fCenter:=1024;
    SetMyEQ;
    Equalizer.fGain:=TB_EQ7.Position;
    Equalizer.lBand:=6;
    Equalizer.fCenter:=2048;
    SetMyEQ;
    Equalizer.fGain:=TB_EQ8.Position;
    Equalizer.lBand:=7;
    Equalizer.fCenter:=4096;
    SetMyEQ;
    Equalizer.fGain:=TB_EQ9.Position;
    Equalizer.lBand:=8;
    Equalizer.fCenter:=8192;
    SetMyEQ;
    Equalizer.fGain:=TB_EQ10.Position;
    Equalizer.lBand:=9;
    Equalizer.fCenter:=16384;
    SetMyEQ;
     {$ifend}
  end;
  end;
end;

procedure TFormEQ.SetEQ;
{$if not defined(HAIKU)}
var mystream: HStream;
{$ifend}
begin
{$if not defined(HAIKU)}
  PreVolume.lChannel:=BASS_BFX_CHANALL;
  PreVolume.fVolume:=1;

  FxEqualizer[0]:=BASS_ChannelSetFX(mystream,BASS_FX_BFX_VOLUME,1);
  FxEqualizer[1]:=BASS_ChannelSetFX(mystream,BASS_FX_BFX_PEAKEQ,1);

  PreVolume.lChannel:=BASS_BFX_CHANALL;
  PreVolume.fVolume:=Trackbar1.Position/100;
  BASS_FXSetParameters(FxEqualizer[0],@PreVolume);

  Equalizer.fGain:=TB_EQ1.Position;
  Equalizer.fBandwidth:=1;
  Equalizer.fCenter:=32;
  Equalizer.lBand:=0;
  Equalizer.lChannel:=BASS_BFX_CHANALL;
  SetMyEQ;
  Equalizer.fGain:=TB_EQ2.Position;
  Equalizer.lBand:=1;
  Equalizer.fCenter:=64;
  SetMyEQ;
  Equalizer.fGain:=TB_EQ3.Position;
  Equalizer.lBand:=2;
  Equalizer.fCenter:=128;
  SetMyEQ;
  Equalizer.fGain:=TB_EQ4.Position;
  Equalizer.lBand:=3;
  Equalizer.fCenter:=256;
  SetMyEQ;
  Equalizer.fGain:=TB_EQ5.Position;
  Equalizer.lBand:=4;
  Equalizer.fCenter:=512;
  SetMyEQ;
  Equalizer.fGain:=TB_EQ6.Position;
  Equalizer.lBand:=5;
  Equalizer.fCenter:=1024;
  SetMyEQ;
  Equalizer.fGain:=TB_EQ7.Position;
  Equalizer.lBand:=6;
  Equalizer.fCenter:=2048;
  SetMyEQ;
  Equalizer.fGain:=TB_EQ8.Position;
  Equalizer.lBand:=7;
  Equalizer.fCenter:=4096;
  SetMyEQ;
  Equalizer.fGain:=TB_EQ9.Position;
  Equalizer.lBand:=8;
  Equalizer.fCenter:=8192;
  SetMyEQ;
  Equalizer.fGain:=TB_EQ10.Position;
  Equalizer.lBand:=9;
  Equalizer.fCenter:=16384;
  SetMyEQ;
   {$ifend}
end;

procedure TFormEQ.SetCustomEQ(track: longint);
{$if not defined(HAIKU)}
var mystream: HStream;
{$ifend}
begin
  {$if not defined(HAIKU)}
  if Liedjes[songplaying].EQ (*CB_EQ.Checked*) then
  begin

  case stream of
    1,6: mystream:=Song_Stream1;
    2: mystream:=Song_Stream2;
    4: mystream:=ReverseStream;
    5: mystream:=CDstream;
   10,11,12: mystream:=Radiostream;
  end;

  FxEqualizer[0]:=BASS_ChannelSetFX(mystream,BASS_FX_BFX_VOLUME,1);
  FxEqualizer[1]:=BASS_ChannelSetFX(mystream,BASS_FX_BFX_PEAKEQ,1);

  Equalizer.fGain:=Liedjes[track].EQSettings[1];
  Equalizer.fBandwidth:=1;
  Equalizer.fCenter:=32;
  Equalizer.lBand:=0;
  Equalizer.lChannel:=BASS_BFX_CHANALL;
  BASS_FXSetParameters(FxEqualizer[1],@Equalizer);
  Equalizer.fGain:=Liedjes[track].EQSettings[2];
  Equalizer.lBand:=1;
  Equalizer.fCenter:=64;
  BASS_FXSetParameters(FxEqualizer[1],@Equalizer);
  Equalizer.fGain:=Liedjes[track].EQSettings[3];
  Equalizer.lBand:=2;
  Equalizer.fCenter:=128;
  BASS_FXSetParameters(FxEqualizer[1],@Equalizer);
  Equalizer.fGain:=Liedjes[track].EQSettings[4];
  Equalizer.lBand:=3;
  Equalizer.fCenter:=256;
  BASS_FXSetParameters(FxEqualizer[1],@Equalizer);
  Equalizer.fGain:=Liedjes[track].EQSettings[5];
  Equalizer.lBand:=4;
  Equalizer.fCenter:=512;
  BASS_FXSetParameters(FxEqualizer[1],@Equalizer);
  Equalizer.fGain:=Liedjes[track].EQSettings[6];
  Equalizer.lBand:=5;
  Equalizer.fCenter:=1024;
  BASS_FXSetParameters(FxEqualizer[1],@Equalizer);
  Equalizer.fGain:=Liedjes[track].EQSettings[7];
  Equalizer.lBand:=6;
  Equalizer.fCenter:=2048;
  BASS_FXSetParameters(FxEqualizer[1],@Equalizer);
  Equalizer.fGain:=Liedjes[track].EQSettings[8];
  Equalizer.lBand:=7;
  Equalizer.fCenter:=4096;
  BASS_FXSetParameters(FxEqualizer[1],@Equalizer);
  Equalizer.fGain:=Liedjes[track].EQSettings[9];
  Equalizer.lBand:=8;
  Equalizer.fCenter:=8192;
  BASS_FXSetParameters(FxEqualizer[1],@Equalizer);
  Equalizer.fGain:=Liedjes[track].EQSettings[10];
  Equalizer.lBand:=9;
  Equalizer.fCenter:=16384;
  BASS_FXSetParameters(FxEqualizer[1],@Equalizer);

  //Pre-Volume
  BASS_FXGetParameters(FxEqualizer[0],@PreVolume);
  PreVolume.lChannel:=BASS_BFX_CHANALL;
  PreVolume.fVolume:=Liedjes[track].PreVolume/100;
  BASS_FXSetParameters(FxEqualizer[0],@PreVolume);

  end;
   {$ifend}
end;


procedure TFormEQ.ComboBox1Select(Sender: TObject);
begin
  EQ_Set:=ComboBox1.ItemIndex;
  SetEQPreset;

  If EQ_Set=0 then
                       begin
                         TB_EQ1.Position:=0; TB_EQ2.Position:=0;
                         TB_EQ3.Position:=0; TB_EQ4.Position:=0;
                         TB_EQ5.Position:=0; TB_EQ6.Position:=0;
                         TB_EQ7.Position:=0; TB_EQ8.Position:=0;
                         TB_EQ9.Position:=0; TB_EQ10.Position:=0;
                       end;
  If EQ_Set>6 then
                       begin
                         TB_EQ1.Enabled:=True; TB_EQ2.Enabled:=True;
                         TB_EQ3.Enabled:=True; TB_EQ4.Enabled:=True;
                         TB_EQ5.Enabled:=True; TB_EQ6.Enabled:=True;
                         TB_EQ7.Enabled:=True; TB_EQ8.Enabled:=True;
                         TB_EQ9.Enabled:=True; TB_EQ10.Enabled:=True;
                       end
                         else
                       begin
                         TB_EQ1.Enabled:=False; TB_EQ2.Enabled:=False;
                         TB_EQ3.Enabled:=False; TB_EQ4.Enabled:=False;
                         TB_EQ5.Enabled:=False; TB_EQ6.Enabled:=False;
                         TB_EQ7.Enabled:=False; TB_EQ8.Enabled:=False;
                         TB_EQ9.Enabled:=False; TB_EQ10.Enabled:=False;
                       end;
end;

procedure TFormEQ.FormShow(Sender: TObject);
begin
  CB_EQ.Caption:=Form1.Vertaal('On');
  Label53.Caption:=Form1.Vertaal('Left');
  Label54.Caption:=Form1.Vertaal('Right');
  Label10.Caption:=Form1.Vertaal('silent');
  Label9.Caption:=Form1.Vertaal('double');
  MenuItem3.Caption:=Form1.Vertaal('Left');
  MenuItem1.Caption:=Form1.Vertaal('Center');
  MenuItem4.Caption:=Form1.Vertaal('Right');
  MenuItem2.Caption:=Form1.Vertaal('Center');
 // FormEQ.Width:=Label54.Left+46;
end;

procedure TFormEQ.CB_EQChange(Sender: TObject);
{$if not defined(HAIKU)}
var mystream: HStream;
{$ifend}
begin
  if CB_EQ.Checked then
                       begin
                          if Liedjes[songplaying].EQ then
                                                       begin
                                                         SetCustomEQ(songplaying);
                                                       end
                                                     else
                                                     begin
                                                         SetEQ;
                                                     end;
                          Form1.ImageListEQ.GetBitmap(0, Form1.SpeedButton8.Glyph);
                       end
                   else
                   begin
                   //  if not Liedjes[songplaying].EQ then
                 //    begin
                       {$if not defined(HAIKU)}
                       if stream=1 then myStream:=Song_Stream1;
                       if stream=2 then myStream:=Song_Stream2;
                       if stream=6 then myStream:=Song_Stream1;
                       if stream=4 then myStream:=ReverseStream;
                       if stream=5 then myStream:=CDStream;
                       if stream>9 then mystream:=Radiostream;
                       BASS_ChannelRemoveFX(mystream, fxEqualizer[0]);
                       BASS_ChannelRemoveFX(mystream, fxEqualizer[1]);
                       Form1.ImageListEQ.GetBitmap(1, Form1.SpeedButton8.Glyph);
                       {$ifend}
                 //    end; *)
                   end;
end;

end.

