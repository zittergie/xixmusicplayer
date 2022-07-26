unit lameconfig;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  ComCtrls;

type

  { TFormLameConfig }

  TFormLameConfig = class(TForm)
    Button1: TButton;
    CB_CBR: TCheckBox;
    CB_EncQuality: TComboBox;
    CB_Mono: TCheckBox;
    CB_OGG_Managed: TCheckBox;
    CB_OGG_ForceQuality: TCheckBox;
    CB_Opus_Mono: TCheckBox;
    ComboBox1: TComboBox;
    CB_Opus_Framesize: TComboBox;
    CB_AAC_VBR: TComboBox;
    GroupBitrate: TGroupBox;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    GroupBox3: TGroupBox;
    GroupBox4: TGroupBox;
    GroupBox5: TGroupBox;
    GroupBox6: TGroupBox;
    GroupPresets: TGroupBox;
    GroupQuality: TGroupBox;
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
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    PageControl1: TPageControl;
    RB_Opus_VBR: TRadioButton;
    RB_Opus_CVBR: TRadioButton;
    RB_Opus_CBR: TRadioButton;
    RB_OGG_VBR: TRadioButton;
    RB_OGG_CVBR: TRadioButton;
    RB_AAC_CBR: TRadioButton;
    RB_AAC_VBR: TRadioButton;
    RB_Bitrate: TRadioButton;
    RB_Presets: TRadioButton;
    RB_Quality: TRadioButton;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
    TabSheet4: TTabSheet;
    TabSheet5: TTabSheet;
    TB_BitRate_max: TTrackBar;
    TB_Bitrate_min: TTrackBar;
    TB_Quality: TTrackBar;
    TB_Opus_Bitrate: TTrackBar;
    TB_Opus_Quality: TTrackBar;
    TB_OGG_Min: TTrackBar;
    TB_OGG_Max: TTrackBar;
    TB_OGG_Quality: TTrackBar;
    TB_AAC_Bitrate: TTrackBar;
    procedure Button1Click(Sender: TObject);
    procedure CB_CBRChange(Sender: TObject);
    procedure CB_OGG_ForceQualityChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure GroupBox1Click(Sender: TObject);
    procedure PageControl1Change(Sender: TObject);
    procedure RB_OGG_VBRChange(Sender: TObject);
    procedure RB_AAC_CBRChange(Sender: TObject);
    procedure RB_BitrateChange(Sender: TObject);
    procedure TB_BitRate_maxChange(Sender: TObject);
    procedure TB_Bitrate_minChange(Sender: TObject);
    procedure TB_QualityChange(Sender: TObject);
    procedure TB_Opus_BitrateChange(Sender: TObject);
    procedure TB_Opus_QualityChange(Sender: TObject);
    procedure TB_OGG_MinChange(Sender: TObject);
    procedure TB_OGG_MaxChange(Sender: TObject);
    procedure TB_OGG_QualityChange(Sender: TObject);
    procedure TB_AAC_BitrateChange(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  FormLameConfig: TFormLameConfig;

implementation

uses hoofd;

{$R *.lfm}

{ TFormLameConfig }

procedure TFormLameConfig.Button1Click(Sender: TObject);
begin
  Lameopties.vbr:=RB_Bitrate.Checked; Lameopties.abr:=RB_Quality.Checked; Lameopties.pr:=RB_Presets.Checked;
  Lameopties.Mono:=CB_Mono.Checked;
  Lameopties.BitrateMin:=inttostr(TB_Bitrate_min.Position);
  Lameopties.BitrateMax:=inttostr(TB_Bitrate_max.Position);
  Lameopties.BitRateQuality:=Combobox1.Text;
  Lameopties.cbr:=CB_CBR.Checked;
  LameOpties.Preset:=inttostr(TB_Quality.Position);
  LameOpties.EncQuality:=CB_EncQuality.Text;

  OGGopties.BitrateMax:=inttostr(TB_OGG_Max.Position);
  OGGopties.BitrateMin:=inttostr(TB_OGG_Min.Position);
  OGGopties.vbr:=RB_OGG_VBR.Checked;
  OGGopties.cbr:=RB_OGG_CVBR.Checked;
  OGGopties.mmode:=CB_OGG_managed.Checked;
  OGGopties.EncQuality:=inttostr(TB_OGG_Quality.Position);
  OGGopties.ForceQuality:=CB_OGG_ForceQuality.Checked;

  AACopties.Bitrate:=inttostr(TB_AAC_Bitrate.Position);
  AACopties.cbr:=RB_AAC_CBR.Checked;
  AACopties.vbr:=RB_AAC_VBR.Checked;
  AACopties.vbrmode:=CB_AAC_VBR.ItemIndex;

  Opusopties.vbr:=RB_Opus_VBR.Checked;
  Opusopties.cvbr:=RB_Opus_CVBR.Checked;
  Opusopties.cbr:=RB_Opus_CBR.Checked;
  Opusopties.Bitrate:=Inttostr(TB_Opus_Bitrate.Position);
  Opusopties.EncQuality:=Inttostr(TB_Opus_Quality.Position);
  Opusopties.Framesize:=strtoint(CB_Opus_Framesize.Text);
  Opusopties.Framesizei:=CB_Opus_Framesize.ItemIndex;
  Close;
end;

procedure TFormLameConfig.CB_CBRChange(Sender: TObject);
begin
  if CB_CBR.Checked then TB_Bitrate_max.Enabled:=false
                    else TB_Bitrate_max.Enabled:=true;
end;

procedure TFormLameConfig.CB_OGG_ForceQualityChange(Sender: TObject);
begin
  Groupbox4.Enabled:=not CB_OGG_ForceQuality.Checked;
end;

procedure TFormLameConfig.FormShow(Sender: TObject);
begin
  {$IFDEF DARWIN}
  Label1.Layout:=tlTop; Label5.Layout:=tlTop; Label7.Layout:=tlTop;
  Label2.Layout:=tlTop; Label6.Layout:=tlTop; Label8.Layout:=tlTop;
  {$ENDIF}
  RB_Bitrate.Checked:=lameopties.vbr;
  RB_Presets.Checked:=lameopties.pr;
  RB_Quality.Checked:=lameopties.abr;
  CB_CBR.Checked:=lameopties.cbr;
  RB_BitrateChange(Self);
  TB_Bitrate_Min.Position:=strtoint(lameopties.BitrateMin);
  TB_BitRate_Max.Position:=strtoint(lameopties.BitrateMax);
  TB_Quality.Position:=strtoint(lameopties.Preset);
  Combobox1.Text:=lameopties.BitRateQuality;
  CB_EncQuality.Text:=lameopties.EncQuality;

  TB_OGG_Min.Position:=strtoint(OGGopties.BitrateMin);
  TB_OGG_Max.Position:=strtoint(OGGopties.BitrateMax);
  TB_OGG_Quality.Position:=strtoint(OGGopties.EncQuality);
  RB_OGG_VBR.Checked:=OGGopties.vbr;
  RB_OGG_CVBR.Checked:=OGGopties.cbr;
  CB_OGG_Managed.Checked:=OGGopties.mmode;
  CB_OGG_ForceQuality.Checked:=OGGOpties.ForceQuality;

  TB_AAC_Bitrate.Position:=strtoint(AACOpties.Bitrate);
  RB_AAC_CBR.Checked:=AACOpties.cbr;
  RB_AAC_VBR.Checked:=AACOpties.vbr;
  CB_AAC_VBR.ItemIndex:=AACOpties.vbrmode;

  RB_Opus_VBR.Checked:=Opusopties.vbr;
  RB_Opus_CVBR.Checked:=Opusopties.cvbr;
  RB_Opus_CBR.Checked:=Opusopties.cbr;
  TB_Opus_Bitrate.Position:=strtoint(Opusopties.Bitrate);
  TB_Opus_Quality.Position:=strtoint(Opusopties.EncQuality);
  CB_Opus_Framesize.Text:=inttostr(Opusopties.Framesize);
  CB_Opus_Framesize.ItemIndex:=Opusopties.Framesizei;
end;

procedure TFormLameConfig.GroupBox1Click(Sender: TObject);
begin

end;

procedure TFormLameConfig.PageControl1Change(Sender: TObject);
begin

end;

procedure TFormLameConfig.RB_OGG_VBRChange(Sender: TObject);
begin
  TB_OGG_Max.Enabled:=RB_OGG_VBR.Checked;
end;

procedure TFormLameConfig.RB_AAC_CBRChange(Sender: TObject);
begin
  TB_AAC_Bitrate.Enabled:=RB_AAC_CBR.Checked;
  CB_AAC_VBR.Enabled:=not RB_AAC_CBR.Checked;
end;

procedure TFormLameConfig.RB_BitrateChange(Sender: TObject);
begin
  if RB_Bitrate.Checked then
  begin
    GroupBitrate.Enabled:=True;
    GroupQuality.Enabled:=False;
    GroupPresets.Enabled:=True;
  end;
  if RB_Quality.Checked then
  begin
    GroupBitrate.Enabled:=False;
    GroupQuality.Enabled:=True;
    GroupPresets.Enabled:=True;
  end;
  if RB_Presets.Checked then
  begin
    GroupBitrate.Enabled:=False;
    GroupQuality.Enabled:=False;
    GroupPresets.Enabled:=True;
  end;
end;

procedure TFormLameConfig.TB_BitRate_maxChange(Sender: TObject);
begin
  Label7.Caption:=inttostr(TB_Bitrate_max.Position);
end;

procedure TFormLameConfig.TB_Bitrate_minChange(Sender: TObject);
begin
  TB_Bitrate_max.Min:=TB_Bitrate_min.Position;
  Label5.Caption:=inttostr(TB_Bitrate_min.Position);
end;

procedure TFormLameConfig.TB_QualityChange(Sender: TObject);
begin
  Label9.Caption:=inttostr(TB_Quality.Position);
end;

procedure TFormLameConfig.TB_Opus_BitrateChange(Sender: TObject);
begin
  Label12.Caption:=inttostr(TB_Opus_Bitrate.Position);
end;

procedure TFormLameConfig.TB_Opus_QualityChange(Sender: TObject);
begin
  Label14.Caption:=inttostr(TB_Opus_Quality.Position);
end;

procedure TFormLameConfig.TB_OGG_MinChange(Sender: TObject);
begin
  Label20.Caption:=inttostr(TB_OGG_Min.Position);
  TB_OGG_Max.Min:=TB_OGG_Min.Position;
end;

procedure TFormLameConfig.TB_OGG_MaxChange(Sender: TObject);
begin
  Label23.Caption:=inttostr(TB_OGG_Max.Position);
end;

procedure TFormLameConfig.TB_OGG_QualityChange(Sender: TObject);
begin
  Label25.Caption:=inttostr(TB_OGG_Quality.Position);
end;

procedure TFormLameConfig.TB_AAC_BitrateChange(Sender: TObject);
begin
  Label27.Caption:=inttostr(TB_AAC_Bitrate.Position);
end;

end.

