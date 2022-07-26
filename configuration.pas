unit configuration;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  md5, ComCtrls, StdCtrls, Buttons, CheckLst, Menus, Spin, Process, Splash,
  showmydialog, httpsend, {$if not defined(HAIKU)} Bass,{$ifend} types, blcksock, debuglog, LazFileUtils;

type

  { TFormConfig }

  TFormConfig = class(TForm)
    Bevel1: TBevel;
    Bevel10: TBevel;
    Bevel11: TBevel;
    Bevel12: TBevel;
    Bevel13: TBevel;
    Bevel14: TBevel;
    Bevel2: TBevel;
    Bevel3: TBevel;
    Bevel4: TBevel;
    Bevel5: TBevel;
    Bevel6: TBevel;
    Bevel7: TBevel;
    Bevel8: TBevel;
    Bevel9: TBevel;
    Button1: TButton;
    Button10: TButton;
    Button11: TButton;
    Button12: TButton;
    Button13: TButton;
    Button14: TButton;
    Button15: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    Button7: TButton;
    Button8: TButton;
    Button9: TButton;
    CBL_ExcludeExternal: TCheckListBox;
    CBL_ExcludeLocale: TCheckListBox;
    CBL_IncludeExternal: TCheckListBox;
    CBL_IncludeLocale: TCheckListBox;
    CB_Fade: TCheckBox;
    CB_NasBug: TCheckBox;
    CB_SaveOnExternal: TCheckBox;
    CB_Tray: TCheckBox;
    CB_Check_The: TCheckBox;
    CB_FadeManual: TCheckBox;
    CB_RunFromUSB: TCheckBox;
    CB_CacheCDImages: TCheckBox;
    CB_CacheSongtext: TCheckBox;
    CB_Language: TComboBox;
    CB_Notification: TCheckBox;
    CB_Minimized: TCheckBox;
    CB_Upcase: TCheckBox;
    CB_SystemSettings: TCheckBox;
    CheckBox1: TCheckBox;
    CB_Mono: TCheckBox;
    CB_MinimizeOnClose: TCheckBox;
    CB_NetworkControl: TCheckBox;
    CB_SaveLyricsInID3Tag: TCheckBox;
    CB_DeleteMacOSFiles: TCheckBox;
    CB_SaveExternalOnInternal: TCheckBox;
    CB_CDCoverInfo: TCheckBox;
    CB_CDCoverLyrics: TCheckBox;
    CB_ShowAllColumns: TCheckBox;
    CB_FixCDCover: TCheckBox;
    CB_NoAdvance: TCheckBox;
    CB_LoadPictureFromFile: TCheckBox;
    SB_SystemTheme: TCheckBox;
    CB_UseBackdrop: TCheckBox;
    CLB_Lyrics: TCheckListBox;
    CB_TabArtist: TComboBox;
    CB_TabPlaylist: TComboBox;
    CB_Encoder: TComboBox;
    CB_Optical: TComboBox;
    CB_Library: TComboBox;
    CB_Device: TComboBox;
    ComboBox1: TComboBox;
    CB_SystemColorTheme: TComboBox;
    Edit_Opus: TEdit;
    Edit_AAC: TEdit;
    Edit_OGG: TEdit;
    Edit_Port: TEdit;
    Edit_Library: TEdit;
    EditLastFMLogin: TEdit;
    EditLastFMPass: TEdit;
    Edit_Target: TEdit;
    Edit_FormatSingle: TEdit;
    Edit_FormatCompilation: TEdit;
    Edit_Lame: TEdit;
    Edit_Flac: TEdit;
    Edit_mplayer: TEdit;
    GroupBox1: TGroupBox;
    GroupBox3: TGroupBox;
    GroupBox4: TGroupBox;
    GroupBox5: TGroupBox;
    GroupBox6: TGroupBox;
    GroupBoxLastFM: TGroupBox;
    Image1: TImage;
    Label1: TLabel;
    Label10: TLabel;
    Label12: TLabel;
    Label36: TLabel;
    Label37: TLabel;
    Label38: TLabel;
    Label40: TLabel;
    Label49: TLabel;
    Label5: TLabel;
    Label50: TLabel;
    Label51: TLabel;
    Label52: TLabel;
    Label53: TLabel;
    Label54: TLabel;
    Label55: TLabel;
    Label56: TLabel;
    LB_OffsetInfo: TLabel;
    LB_AudioDevice: TLabel;
    LB_Buffer: TLabel;
    Label104: TLabel;
    Label105: TLabel;
    Label106: TLabel;
    Label107: TLabel;
    Label108: TLabel;
    Label109: TLabel;
    Label11: TLabel;
    LB_OpticalDrive: TLabel;
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
    Label39: TLabel;
    Label4: TLabel;
    Label41: TLabel;
    Label42: TLabel;
    Label43: TLabel;
    Label44: TLabel;
    Label45: TLabel;
    Label46: TLabel;
    Label47: TLabel;
    Label48: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label92: TLabel;
    Label93: TLabel;
    Label94: TLabel;
    Label95: TLabel;
    Label96: TLabel;
    Label_Website: TLabel;
    Label_UpdateInfo: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Memo_IP: TMemo;
    MI_RemoveFolder1: TMenuItem;
    MI_RemoveFolder2: TMenuItem;
    MI_RemoveFolder3: TMenuItem;
    MI_RemoveFolder4: TMenuItem;
    OpenDialog1: TOpenDialog;
    PageControl1: TPageControl;
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    PM_RemoveFolder1: TPopupMenu;
    PM_removeFolder2: TPopupMenu;
    PM_RemoveFolder3: TPopupMenu;
    PM_RemoveFolder4: TPopupMenu;
    SelectDirectoryDialog1: TSelectDirectoryDialog;
    Shape1: TShape;
    SpeedButton1: TSpeedButton;
    SB_Update: TSpeedButton;
    SpeedButton10: TSpeedButton;
    SpeedButton11: TSpeedButton;
    SpeedButton12: TSpeedButton;
    SpeedButton13: TSpeedButton;
    SpeedButton14: TSpeedButton;
    SpeedButton15: TSpeedButton;
    SpeedButton16: TSpeedButton;
    SB_NewLibrary: TSpeedButton;
    SpeedButton17: TSpeedButton;
    SpeedButton2: TSpeedButton;
    SpeedButton3: TSpeedButton;
    SpeedButton4: TSpeedButton;
    SpeedButton5: TSpeedButton;
    SpeedButton6: TSpeedButton;
    SpeedButton7: TSpeedButton;
    SpeedButton8: TSpeedButton;
    SE_Buffer: TSpinEdit;
    SpeedButton9: TSpeedButton;
    SpinEdit1: TSpinEdit;
    SpinEditFontGrids: TSpinEdit;
    SpinEditFontMemo: TSpinEdit;
    TabSheet1: TTabSheet;
    TabSheet10: TTabSheet;
    TabSheet11: TTabSheet;
    TabSheet12: TTabSheet;
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
    TabSheet5: TTabSheet;
    TabSheet6: TTabSheet;
    TabSheet8: TTabSheet;
    TabSheet9: TTabSheet;
    TB_Fade: TTrackBar;
    TrackBar1: TTrackBar;
    procedure Button10Click(Sender: TObject);
    procedure Button11Click(Sender: TObject);
    procedure Button12Click(Sender: TObject);
    procedure Button13Click(Sender: TObject);
    procedure Button14Click(Sender: TObject);
    procedure Button15Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure Button8Click(Sender: TObject);
    procedure Button9Click(Sender: TObject);
    procedure CBL_ExcludeExternalClickCheck(Sender: TObject);
    procedure CBL_ExcludeLocaleClickCheck(Sender: TObject);
    procedure CBL_IncludeExternalClickCheck(Sender: TObject);
    procedure CBL_IncludeLocaleClickCheck(Sender: TObject);
    procedure CB_LanguageSelect(Sender: TObject);
    procedure CB_NotificationChange(Sender: TObject);
    procedure CB_LibraryChange(Sender: TObject);
    procedure CB_NetworkControlChange(Sender: TObject);
    procedure CB_CDCoverInfoChange(Sender: TObject);
    procedure Edit_LibraryKeyPress(Sender: TObject; var Key: char);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Label29Click(Sender: TObject);
    procedure Label32Click(Sender: TObject);
    procedure Label35Click(Sender: TObject);
    procedure Label49Click(Sender: TObject);
    procedure Label52Click(Sender: TObject);
    procedure Label55Click(Sender: TObject);
    procedure LB_OffsetInfoClick(Sender: TObject);
    procedure LB_OffsetInfoMouseEnter(Sender: TObject);
    procedure LB_OffsetInfoMouseLeave(Sender: TObject);
    procedure Label48Click(Sender: TObject);
    procedure Label_WebsiteClick(Sender: TObject);
    procedure MI_RemoveFolder1Click(Sender: TObject);
    procedure MI_RemoveFolder2Click(Sender: TObject);
    procedure MI_RemoveFolder3Click(Sender: TObject);
    procedure MI_RemoveFolder4Click(Sender: TObject);
    procedure PageControl1Change(Sender: TObject);
    procedure SB_UpdateClick(Sender: TObject);
    procedure SpeedButton12Click(Sender: TObject);
    procedure SpeedButton13Click(Sender: TObject);
    procedure SpeedButton14Click(Sender: TObject);
    procedure SpeedButton15Click(Sender: TObject);
    procedure SpeedButton16Click(Sender: TObject);
    procedure SB_NewLibraryClick(Sender: TObject);
    procedure SpeedButton17Click(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);
    procedure SpeedButton4Click(Sender: TObject);
    procedure SpeedButton5Click(Sender: TObject);
    procedure LoadLanguage;
    procedure SpeedButton6Click(Sender: TObject);
    procedure SpeedButton7Click(Sender: TObject);
    procedure SpeedButton8Click(Sender: TObject);
    procedure SpeedButton9Click(Sender: TObject);
    procedure SpinEditFontGridsChange(Sender: TObject);
    procedure SpinEditFontMemoChange(Sender: TObject);
    procedure TB_FadeChange(Sender: TObject);
    procedure TrackBar1Change(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  FormConfig: TFormConfig;
  OLD_CB_Library_Index: byte;

implementation

uses hoofd, ThemePrefs, lameconfig, ID3v2, OggVorbis, XiX_OpusTagReader, OggVorbisAndOpusTagLibrary, FLACfile, APEtag, MP4file, coverplayer;

var old_language: shortstring;
    addedfolders: boolean;
    ChangedFolders: boolean;

{$R *.lfm}

{ TFormConfig }

procedure TFormConfig.LoadLanguage;
var i: byte;
begin
  for i:=1 to 20 do Vertaalstring[i]:='';
  FormConfig.Caption:=Form1.Vertaal('Configuration');
  TabSheet1.Caption:=Form1.Vertaal('General');
  TabSheet2.Caption:=Form1.Vertaal('Cache');
  TabSheet3.Caption:=Form1.Vertaal('GUI');
  TabSheet5.Caption:=Form1.Vertaal('Lyrics');
  TabSheet6.Caption:=Form1.Vertaal('Local Folders');
  TabSheet8.Caption:=Form1.Vertaal('Devices');
  TabSheet9.Caption:=Form1.Vertaal('Rip CD');
  TabSheet10.Caption:=Form1.Vertaal('External Apps');
  TabSheet11.Caption:=Form1.Vertaal('Updates');
  Label1.Caption:=Form1.Vertaal('Language')+':';
  CB_Fade.Caption:=Form1.Vertaal('Use crossfading between 2 songs');
  Label3.Caption:=Form1.Vertaal('Fading time')+':';
  CB_FadeManual.Caption:=Form1.Vertaal('Fade on manual selection');
  CB_RunFromUSB.Caption:=Form1.Vertaal('Run from portable USB stick  (needs a restart)');
  Label4.Caption:=Form1.Vertaal('When selecting "Run from portable USB stick" the config, cache & radiopresets will be saved on the USB stick.');
  CB_CacheCDImages.Caption:=Form1.Vertaal('Use cache for CD Cover images');
  CB_CacheSongtext.Caption:=Form1.Vertaal('Use cache for songtext');
  Button2.Caption:=Form1.Vertaal('Clear cache');
  Button4.Caption:=Form1.Vertaal('Clear cache');
  Button1.Caption:=Form1.Vertaal('Show cache');
  Button3.Caption:=Form1.Vertaal('Show cache');
  Label6.Caption:=Form1.Vertaal('Tab Artist')+':';
  Label7.Caption:=Form1.Vertaal('Tab Playing Queue')+':';
  CB_Notification.Caption:=Form1.Vertaal('Show notification');
  CB_Minimized.Caption:=Form1.Vertaal('Only when minimized');
  CB_Tray.Caption:=Form1.Vertaal('Show tray icon');
  Label8.Caption:=Form1.Vertaal('Scan these local folders')+':';
  Label9.Caption:=Form1.Vertaal('Exclude these local folders')+':';
  Button7.Caption:=Form1.Vertaal('Add folder');
  Button8.Caption:=Form1.Vertaal('Add folder');
  Button9.Caption:=Form1.Vertaal('Add folder');
  Button10.Caption:=Form1.Vertaal('Add folder');
  Label10.Caption:=Form1.Vertaal('Scan these external folders')+':';
  Label11.Caption:=Form1.Vertaal('Exclude these external folders')+':';
  CB_NasBug.Caption:=Form1.Vertaal('Workaround for SAMBA bug');
  Label13.Caption:=Form1.Vertaal('Encoder')+':';
  Speedbutton4.Caption:=Form1.Vertaal('Configuration');
  Label14.Caption:=Form1.Vertaal('Select target directory')+':';
  Label15.Caption:=Form1.Vertaal('Format for Single Artist CD')+':';
  Label16.Caption:=Form1.Vertaal('Format for Compilation CD')+':';
  SpeedButton1.Caption:=Form1.Vertaal('Save');
  Label28.Caption:=Form1.Vertaal('LAME is the application that is needed to encode CD-Tracks to MP3');
  Label31.Caption:=Form1.Vertaal('FLAC is the application that is needed to encode CD-Tracks to FLAC');
  Label34.Caption:=Form1.Vertaal('mplayer is needed to rip DVD-Tracks');
  SpeedButton2.Caption:=Form1.Vertaal('Cancel');
  Button11.Caption:=Form1.Vertaal('Try to find all applications');
  CB_TabArtist.Items[0]:=Form1.Vertaal('Bottom');
  CB_TabArtist.Items[1]:=Form1.Vertaal('Left');
  CB_TabArtist.Items[2]:=Form1.Vertaal('Right');
  CB_TabArtist.Items[3]:=Form1.Vertaal('Top');
  CB_TabPlaylist.Items[0]:=Form1.Vertaal('Bottom');
  CB_TabPlaylist.Items[1]:=Form1.Vertaal('Left');
  CB_TabPlaylist.Items[2]:=Form1.Vertaal('Right');
  CB_TabPlaylist.Items[3]:=Form1.Vertaal('Top');
  Label39.Caption:='Version: '+versie;
end;

procedure TFormConfig.SpeedButton6Click(Sender: TObject);
begin
  if OpenDialog1.Execute then Edit_lame.Text:=OpenDialog1.FileName;
end;

procedure TFormConfig.SpeedButton7Click(Sender: TObject);
begin
  if OpenDialog1.Execute then Edit_flac.Text:=OpenDialog1.FileName;
end;

procedure TFormConfig.SpeedButton8Click(Sender: TObject);
begin
  if OpenDialog1.Execute then Edit_mplayer.Text:=OpenDialog1.FileName;
end;

procedure TFormConfig.SpeedButton9Click(Sender: TObject);
begin
  if OpenDialog1.Execute then Edit_AAC.Text:=OpenDialog1.FileName;
end;

procedure TFormConfig.SpinEditFontGridsChange(Sender: TObject);
begin
  Form1.LB_Artist1.Font.Size:=SpinEditFontGrids.Value; Form1.LB_Artists2.Font.Size:=SpinEditFontGrids.Value;
  Form1.LB_Albums1.Font.Size:=SpinEditFontGrids.Value; Form1.LB_Albums2.Font.Size:=SpinEditFontGrids.Value;
  Form1.LB_Playlist.Font.Size:=SpinEditFontGrids.Value; ; Form1.LB_M3U.Font.Size:=SpinEditFontGrids.Value;
  Form1.SG_Podcast.Font.Size:=SpinEditFontGrids.Value;
  Form1.SG_All.Font.Size:=SpinEditFontGrids.Value; Form1.SG_Play.Font.Size:=SpinEditFontGrids.Value;
  Form1.StringGridCD.Font.Size:=SpinEditFontGrids.Value;
  Form1.StringGridRadioAir.Font.Size:=SpinEditFontGrids.Value; Form1.StringGridPresets.Font.Size:=SpinEditFontGrids.Value;
  Form1.StringGridRecorded.Font.Size:=SpinEditFontGrids.Value; Form1.SG_ListenLive.Font.Size:=SpinEditFontGrids.Value;
end;

procedure TFormConfig.SpinEditFontMemoChange(Sender: TObject);
begin
  Form1.MemoLyrics.Font.Size:=SpinEditFontMemo.Value;
  Form1.MemoArtiest.Font.Size:=SpinEditFontMemo.Value;
end;

procedure TFormConfig.TB_FadeChange(Sender: TObject);
begin
  Label92.Caption:=inttostr(TB_Fade.Position);
end;

procedure TFormConfig.TrackBar1Change(Sender: TObject);
begin
  Label96.Caption:=inttostr(TrackBar1.Position);
end;

procedure TFormConfig.FormShow(Sender: TObject);
var Filevar  : textFile;
    i        : byte;
    temp     : String;
    c        : DWORD;
    LanguagesFound: TStringlist;
    {$if not defined(HAIKU)}
    r_info   : Bass_deviceInfo;
    {$ifend}
begin
  old_language:=Settings.Language; LoadLanguage; addedfolders:=false;
  ChangedFolders:=false;
  TrackBar1.Position:=Settings.TimerInterval;
  Label106.Caption:=ConfigDir+DirectorySeparator+'plugins';
  Label107.Caption:='/usr/lib/xixmusicplayer/plugins';
  Label108.Caption:=ExtractFilePath(Paramstr(0))+'plugins';
  SE_Buffer.Value:=Settings.cdb;
  LanguagesFound:=FindAllFiles(StartDir+DirectorySeparator+'Local','*.??', False);
  CB_Language.Items.Clear;  CB_Language.Items.Add('EN - English');
  for i:=0 to LanguagesFound.Count-1 do
    begin
      AssignFile(Filevar,LanguagesFound.Strings[i]);
      Reset(Filevar);
      Readln(Filevar,temp);
      CloseFile(Filevar);
      if length(temp)>5 then CB_Language.Items.Add(temp);
    end;
  LanguagesFound.Free;

  for i:=0 to CB_Language.Items.Count-1 do
    begin
      temp:=Copy(CB_Language.Items[i],1,2);
      if temp=Settings.Language then CB_Language.ItemIndex:=i;
    end;

  CB_Fade.Checked:=Settings.Fade;
  CB_FadeManual.Checked:=Settings.FadeManual;
  TB_Fade.Position:=Settings.FadeTime;
  CB_RunFromUSB.Checked:=Settings.RunFromUSB;

  CB_CacheCDImages.Checked:=Settings.CacheCDImages;
  CB_CacheSongtext.Checked:=Settings.CacheSongtext;

  CB_ShowAllColumns.Checked:=Settings.ShowAllColums;

  CB_CDCoverInfo.Checked:=Settings.CDCoverInfo;
  CB_CDCoverLyrics.Checked:=Settings.CDCoverLyrics;
  CB_TabArtist.ItemIndex:=Settings.TabArtist;
  CB_TabPlaylist.ItemIndex:=Settings.TabPlaylist;
  CB_Notification.Checked:=Settings.Notification;
  CB_Minimized.Checked:=Settings.OnlyWhenMinized;
  CB_Tray.Checked:=Settings.Tray;
  CB_SaveLyricsInID3Tag.Checked:=Settings.SaveLyricsInID3Tag;
  CB_FixCDCover.Checked:=Settings.FixCDCover;
  CB_NoAdvance.Checked:=Settings.NoAdvance;

  CB_SaveExternalOnInternal.Checked:=Settings.SaveExternalOnInternal;
  CBL_IncludeLocale.Items.Clear; CBL_ExcludeLocale.Items.Clear;
  CBL_IncludeExternal.Items.Clear; CBL_ExcludeExternal.Items.Clear;
  CBL_IncludeLocale.Items.AddStrings(Settings.IncludeLocaleDirs);
  If Settings.IncludeLocaleDirs.Count>0 then For i:=0 to Settings.IncludeLocaleDirs.Count-1 do CBL_IncludeLocale.Checked[i]:=Settings.IncludeLocaleDirsChecked[i];
  CBL_ExcludeLocale.Items.AddStrings(Settings.ExcludeLocaleDirs);
  If Settings.ExcludeLocaleDirs.Count>0 then For i:=0 to Settings.ExcludeLocaleDirs.Count-1 do CBL_ExcludeLocale.Checked[i]:=Settings.ExcludeLocaleDirsChecked[i];

  CBL_IncludeExternal.Items.AddStrings(Settings.IncludeExternalDirs);
  If Settings.IncludeExternalDirs.Count>0 then For i:=0 to Settings.IncludeExternalDirs.Count-1 do CBL_IncludeExternal.Checked[i]:=Settings.IncludeExternalDirsChecked[i];
  CBL_ExcludeExternal.Items.AddStrings(Settings.ExcludeExternalDirs);
  If Settings.ExcludeExternalDirs.Count>0 then For i:=0 to Settings.ExcludeExternalDirs.Count-1 do CBL_ExcludeExternal.Checked[i]:=Settings.ExcludeExternalDirsChecked[i];
  CB_NasBug.Checked:=Settings.NASBug;
  CB_SaveOnExternal.Checked:=Settings.SaveOnExternal;
  CB_DeleteMacOSFiles.Checked:=Settings.DeleteMacOSFiles;

  CB_Encoder.ItemIndex:=Settings.Encoder;
  Edit_Target.Text:=Settings.EncodingTargetFolder;
  Edit_FormatSingle.Text:=Settings.EncodingFilenameFormatSingle;
  Edit_FormatCompilation.Text:=Settings.EncodingFilenameFormatCompilation;

  Edit_Lame.Text:=Settings.Lame;
  Edit_Flac.Text:=Settings.Flac;
  Edit_OGG.Text:=Settings.OGG;
  Edit_AAC.Text:=Settings.AAC;
  Edit_Opus.Text:=Settings.Opus;
  Edit_mplayer.Text:=Settings.Mplayer;

  EditLastFMLogin.Text:=Settings.LastFMLogin;
  EditLastFMPass.Text:=Settings.LastFMPass;
  Label41.Caption:=Settings.LastFMToken;

  // TODO:  Lyric plugin checked of niet

  CB_Optical.Text:=Settings.DVDDrive;

  CB_Library.Items.Clear;
  CB_Library.Items.AddStrings(Form1.CB_Library.Items);
  CB_Library.ItemIndex:=Form1.CB_Library.ItemIndex; OLD_CB_Library_Index:=Form1.CB_Library.ItemIndex;

  //Search All Devices
  CB_Device.Items.Clear;  c:=0;
  {$if not defined(HAIKU)}
  while bass.BASS_GetDeviceInfo(c, r_info) do
  begin
   CB_Device.Items.Add(string(r_info.name));
   inc(c);
  end;
  {$ifend}
  if CB_Device.Items.Count>0 then
  begin
    if Settings.Soundcard<=CB_Device.Items.Count then CB_Device.ItemIndex:=Settings.Soundcard
                                                 else CB_Device.ItemIndex:=1;
  end;

  CB_UseBackdrop.Checked:=Settings.UseBackDrop;
  CB_SystemColorTheme.ItemIndex:=Settings.Backdrop;
end;

procedure TFormConfig.Label29Click(Sender: TObject);
{$IFDEF DARWIN}
var cmd: string;
    AProcess: TProcess;
{$ENDIF}
begin
    {$IFDEF WINDOWS}
        DeleteFile(TempDir+'\lame3.99.5.zip');
        if FormShowMyDialog.ShowWith('INSTALL LAME ...','LAME not found','Do you want to download and install LAME?','',
            [mrYes,Form1.Vertaal('YES'),mrNo,Form1.Vertaal('NO')], False) = mrYes
           then
           begin
             if Form1.DownloadFile('http://www.xixmusicplayer.org/optional/windows/lame3.99.5.zip',TempDir+DirectorySeparator+'lame3.99.5.zip') then
             begin
               if not directoryexists(Configdir+'\bin') then mkdir(ConfigDir+'\bin');
               if not directoryexists(Configdir+'\bin\lame') then mkdir(ConfigDir+'\bin\lame');
               Form1.UnZipIt(TempDir+DirectorySeparator+'lame3.99.5.zip',ConfigDir+'\bin\lame');
               Edit_Lame.Text:=ConfigDir+'\bin\lame\lame.exe';
             end
             else ShowMessage('Download failed, please download and install LAME yourself');
           end;
      {$ENDIF}
      {$IFDEF DARWIN}
        DeleteFile(TempDir+DirectorySeparator+'lame3.99.5.dmg');
        if FormShowMyDialog.ShowWith('INSTALL LAME ...','LAME not found','Do you want to download and install LAME?','',
            [mrYes,Form1.Vertaal('YES'),mrNo,Form1.Vertaal('NO')], False) = mrYes
           then
           begin
             if Form1.DownloadFile('http://www.xixmusicplayer.org/optional/macos/lame3.99.5.dmg',TempDir+DirectorySeparator+'lame3.99.5.dmg') then
             begin
               cmd:='open "'+TempDir+DirectorySeparator+'lame3.99.5.dmg"';
               AProcess := TProcess.Create(nil);
               AProcess.CommandLine := cmd;
               AProcess.Execute;
               AProcess.Free;
               ShowMessage('LAME downloaded.  Please install LAME before you continue ...');
             end
             else ShowMessage('Download failed, please download and install LAME yourself');
           end;
      {$ENDIF}
     {$IFDEF LINUX}
       ShowMessage('You need to install LAME yourself.  How depends on your distro.'+#13+#13+'Common commands are:'+#13+'$ sudo apt-get install lame   (Debian, Ubuntu, Mint, ...)'+#13+'$ pacman -S lame   (Arch)');
     {$ENDIF}
     {$IFDEF HAIKU}
     ShowMessage('You need to install LAME yourself.');
     {$ENDIF}
end;

procedure TFormConfig.Label32Click(Sender: TObject);
var cmd: string;
    AProcess: TProcess;
begin
   {$IFDEF WINDOWS}
        DeleteFile(TempDir+DirectorySeparator+'flac-1.3.1-win.zip');
        if FormShowMyDialog.ShowWith('INSTALL FLAC ...','FLAC not found','Do you want to download and install FLAC?','',
            [mrYes,Form1.Vertaal('YES'),mrNo,Form1.Vertaal('NO')],False) = mrYes
           then
           begin
             if Form1.DownloadFile('http://www.xixmusicplayer.org/optional/windows/flac-1.3.1-win.zip',TempDir+'\flac-1.3.1-win.zip') then
             begin
               if not directoryexists(Configdir+'\bin') then mkdir(ConfigDir+'\bin');
               if not directoryexists(Configdir+'\bin\flac') then mkdir(ConfigDir+'\bin\flac');
               Form1.UnZipIt(TempDir+'\flac-1.3.1-win.zip',ConfigDir+'\bin\flac');
               Edit_Flac.Text:=ConfigDir+'\bin\flac\win32\flac.exe';
             end
             else ShowMessage('Download failed, please download and install LAME yourself');
           end;
      {$ENDIF}
  {$IFDEF DARWIN}
  if FormShowMyDialog.ShowWith('INSTALL FLAC ...','Do you want to download and install FLAC?','','',
      [mrYes,Form1.Vertaal('YES'),mrNo,Form1.Vertaal('NO')], False) = mrYes
      then
      begin
        DeleteFile(TempDir+DirectorySeparator+'flac-1.2.1b.dmg');
        if Form1.DownloadFile('http://www.xixmusicplayer.org/optional/macos/flac-1.2.1b.dmg',TempDir+DirectorySeparator+'flac-1.2.1b.dmg') then
        begin
          cmd:='open "'+TempDir+DirectorySeparator+'flac-1.2.1b.dmg"';
          AProcess := TProcess.Create(nil);
          AProcess.CommandLine := cmd;
          AProcess.Execute;
          AProcess.Free;
          ShowMessage('FLAC downloaded.  Please install FLAC and OGG before you continue ...'+#13+'Run the 2 downloaded packages ...'+#13+'When installed, click ''Find all applications'' again.');
        end
          else ShowMessage('Download failed, please download and install FLAC yourself');
      end;
  {$ENDIF}
  {$IFDEF LINUX}
     ShowMessage('You need to install FLAC yourself.  How depends on your distro.'+#13+#13+'Common commands are:'+#13+'$ sudo apt-get install flac   (Debian, Ubuntu, Mint, ...)'+#13+'$ pacman -S flac   (Arch)');
  {$ENDIF}
  {$IFDEF HAIKU}
     ShowMessage('You need to install FLAC yourself.');
  {$ENDIF}
end;



procedure TFormConfig.Label35Click(Sender: TObject);
begin
  Form1.BrowseTo('http://www.mplayerhq.hu');
end;

procedure TFormConfig.Label49Click(Sender: TObject);
begin
  {$IFDEF DARWIN}
  ShowMessage('Download for OGG is not finished yet.  Will work in the future');
  {$ENDIF}
   {$IFDEF WINDOWS}
  ShowMessage('Download for OGG is not finished yet.  Will work in the future');
  {$ENDIF}
  {$IFDEF LINUX}
     ShowMessage('You need to install OGGenc yourself.  How depends on your distro.'+#13+#13+'Common commands are:'+#13+'$ sudo apt-get install vorbis-tools   (Debian, Ubuntu, Mint, ...)'+#13+'$ pacman -S vorbis-tools   (Arch)');
  {$ENDIF}
  {$IFDEF HAIKU}
     ShowMessage('You need to install OGGenc yourself.');
  {$ENDIF}
end;

procedure TFormConfig.Label52Click(Sender: TObject);
begin
  {$IFDEF DARWIN}
    Form1.BrowseTo('http://macappstore.org/fdk-aac/');
  {$ENDIF}
  {$IFDEF LINUX}
     ShowMessage('You need to install FDK-AAC yourself.  How depends on your distro.'+#13+#13+'Common commands are:'+#13+'$ sudo apt-get install fdkaac   (Debian, Ubuntu, Mint, ...)'+#13+'$ pacman -S fdkaac   (Arch)');
  {$ENDIF}
  {$IFDEF WINDOWS}
        DeleteFile(TempDir+DirectorySeparator+'fdkaac-1.6.3-win32-ads.zip');
        if FormShowMyDialog.ShowWith('INSTALL FDKaac for WINDOWS ...','FDKaac binaries for Windows','Do you want to download and install FDKaac?','',
            [mrYes,Form1.Vertaal('YES'),mrNo,Form1.Vertaal('NO')], False) = mrYes
           then
           begin
             if Form1.DownloadFile('http://www.xixmusicplayer.org/optional/windows/fdkaac-1.6.3-win32-ads.zip',TempDir+'\fdkaac-1.6.3-win32-ads.zip') then
             begin
               if not directoryexists(Configdir+'\bin') then mkdir(ConfigDir+'\bin');
               if not directoryexists(Configdir+'\bin\fdkaac') then mkdir(ConfigDir+'\bin\fdkaac');
               Form1.UnZipIt(TempDir+'\fdkaac-1.6.3-win32-ads.zip',ConfigDir+'\bin\fdkaac');
               Edit_AAC.Text:=ConfigDir+'\bin\fdkaac\fdkaac.exe';
             end
             else ShowMessage('Download failed, please download and install FDK-AAC yourself');
           end;
      {$ENDIF}
  {$IFDEF HAIKU}
     ShowMessage('You need to install FDKaac yourself.');
  {$ENDIF}
end;

procedure TFormConfig.Label55Click(Sender: TObject);
begin
   {$IFDEF LINUX}
     ShowMessage('You need to install Opusenc yourself.  How depends on your distro.'+#13+#13+'Common commands are:'+#13+'$ sudo apt-get install opus-tools   (Debian, Ubuntu, Mint, ...)'+#13+'$ pacman -S opus-tools   (Arch)');
  {$ENDIF}
  {$IFDEF DARWIN}
    ShowMessage('Download for OPUS is not finished yet.  Will work in the future.');
  {$ENDIF}
   {$IFDEF WINDOWS}
    ShowMessage('Download for OPUS is not finished yet.  Will work in the future');
  {$ENDIF}
  {$IFDEF HAIKU}
     ShowMessage('You need to install OPUS yourself.');
  {$ENDIF}
end;

procedure TFormConfig.LB_OffsetInfoClick(Sender: TObject);
begin
  Form1.BrowseTo('http://www.accuraterip.com/driveoffsets.htm');
end;

procedure TFormConfig.LB_OffsetInfoMouseEnter(Sender: TObject);
begin
  LB_OffsetInfo.Font.Color:=clBlue;
end;

procedure TFormConfig.LB_OffsetInfoMouseLeave(Sender: TObject);
begin
  LB_OffsetInfo.Font.Color:=clDefault;
end;

procedure TFormConfig.Label48Click(Sender: TObject);
begin
  Form1.BrowseTo('http://'+Label_Website.Caption);
end;

procedure TFormConfig.Label_WebsiteClick(Sender: TObject);
begin
  Form1.BrowseTo('http://'+Label_Website.Caption);
end;

procedure TFormConfig.MI_RemoveFolder1Click(Sender: TObject);
begin
  if CBL_IncludeLocale.ItemIndex>-1 then
  begin
    CBL_IncludeLocale.Items.Delete(CBL_IncludeLocale.ItemIndex);
    If CB_Library.ItemIndex=Form1.CB_library.ItemIndex then addedfolders:=true;
    changedfolders:=true;
  end;
end;

procedure TFormConfig.MI_RemoveFolder2Click(Sender: TObject);
begin
  if CBL_ExcludeLocale.ItemIndex>-1 then
  begin
    CBL_ExcludeLocale.Items.Delete(CBL_ExcludeLocale.ItemIndex);
    If CB_Library.ItemIndex=Form1.CB_library.ItemIndex then addedfolders:=true;
    changedfolders:=true;
  end;
end;

procedure TFormConfig.MI_RemoveFolder3Click(Sender: TObject);
begin
  if CBL_IncludeExternal.ItemIndex>-1 then
    begin
      CBL_IncludeExternal.Items.Delete(CBL_IncludeExternal.ItemIndex);
      If CB_Library.ItemIndex=Form1.CB_library.ItemIndex then addedfolders:=true;
      changedfolders:=true;
    end;
end;

procedure TFormConfig.MI_RemoveFolder4Click(Sender: TObject);
begin
  if CBL_ExcludeExternal.ItemIndex>-1 then
  begin
    CBL_ExcludeExternal.Items.Delete(CBL_ExcludeExternal.ItemIndex);
    If CB_Library.ItemIndex=Form1.CB_library.ItemIndex then addedfolders:=true;
    changedfolders:=true;
  end;
end;

procedure TFormConfig.PageControl1Change(Sender: TObject);
begin

end;

procedure TFormConfig.SB_UpdateClick(Sender: TObject);
var Filevar: TextFile;
    lijn, os: string;
begin
  {$IFDEF DARWIN}
  os:='http://www.zittergie.be/update/xixplayer/osx.ver';
  {$ENDIF}
  {$IFDEF WINDOWS}
  os:='http://www.zittergie.be/update/xixplayer/windows.ver';
  {$ENDIF}
  {$IFDEF LINUX}
  os:='http://www.zittergie.be/update/xixplayer/linux.ver';
  {$ENDIF}
  {$if defined(CPUARM)}
  os:='http://www.zittergie.be/update/xixplayer/armlinux.ver';
  {$ifend}
  SB_Update.Cursor:=CrHourglass; Application.ProcessMessages;
  Label_UpdateInfo.Visible:=True;
  If Form1.DownloadFile(os,Tempdir+DirectorySeparator+versie) then
  begin
    AssignFile(Filevar,Tempdir+DirectorySeparator+versie);
    Reset(Filevar);
    Readln(Filevar,lijn);
    CloseFile(Filevar);
    if lijn=versie then Label_UpdateInfo.Caption:=Form1.Vertaal('No update found')
                   else
                     begin
                       Label_UpdateInfo.Caption:=Form1.Vertaal('Update available at:');
                       Label_Website.Visible:=True;
                     end;
  end
  else Label_UpdateInfo.Caption:=Form1.Vertaal('Network problem');
  SB_Update.Cursor:=CrDefault;
end;

procedure TFormConfig.SpeedButton12Click(Sender: TObject);
begin
  if OpenDialog1.Execute then Edit_Opus.Text:=OpenDialog1.FileName;
end;

procedure TFormConfig.SpeedButton13Click(Sender: TObject);
var Temp: string;
begin
  If (CLB_Lyrics.ItemIndex>0) and (CLB_Lyrics.ItemIndex>-1) then
  begin
    Temp:=CLB_Lyrics.Items[CLB_Lyrics.ItemIndex];
    CLB_Lyrics.Items[CLB_Lyrics.ItemIndex]:=CLB_Lyrics.Items[CLB_Lyrics.ItemIndex-1];
    CLB_Lyrics.Items[CLB_Lyrics.ItemIndex-1]:=Temp;
    CLB_Lyrics.ItemIndex:=CLB_Lyrics.ItemIndex-1;
  end;
end;

procedure TFormConfig.SpeedButton14Click(Sender: TObject);
var Temp: string;
begin
  If (CLB_Lyrics.ItemIndex<CLB_Lyrics.Count-1) and (CLB_Lyrics.ItemIndex>-1) then
  begin
    Temp:=CLB_Lyrics.Items[CLB_Lyrics.ItemIndex];
    CLB_Lyrics.Items[CLB_Lyrics.ItemIndex]:=CLB_Lyrics.Items[CLB_Lyrics.ItemIndex+1];
    CLB_Lyrics.Items[CLB_Lyrics.ItemIndex+1]:=Temp;
    CLB_Lyrics.ItemIndex:=CLB_Lyrics.ItemIndex+1;
  end;
end;

procedure TFormConfig.SpeedButton15Click(Sender: TObject);
begin
  if CLB_Lyrics.ItemIndex>-1 then
  begin
    if FormShowMyDialog.ShowWith('WARNING',Form1.Vertaal('Do you want to delete'),'',ExtractFilename(CLB_Lyrics.Items[CLB_Lyrics.ItemIndex]),Form1.Vertaal('YES'),Form1.Vertaal('NO'), False) then
      begin
        DeleteFile(CLB_Lyrics.Items[CLB_Lyrics.ItemIndex]);
        CLB_Lyrics.Items.Delete(CLB_Lyrics.ItemIndex);
      end;
  end;
end;

procedure TFormConfig.SpeedButton16Click(Sender: TObject);
begin
  if OpenDialog1.Execute then ShowMessage('Not yet implemented - Coming soon');
end;

procedure TFormConfig.SB_NewLibraryClick(Sender: TObject);
begin
  if Edit_Library.Visible then
  begin
    if Edit_Library.Text<>'' then
    begin
      CB_Library.Items.Add(Edit_Library.Text); Form1.CB_Library.Items.Add(Edit_Library.Text);
      CB_Library.ItemIndex:=CB_Library.Items.Count-1;
      ChangedFolders:=True;
    end
    else CB_LibraryChange(Self);
    Button7.Enabled:=True; Button8.Enabled:=True;
    Button9.Enabled:=True; Button10.Enabled:=True;
    CBL_IncludeLocale.Enabled:=True; CBL_IncludeExternal.Enabled:=True;
    CBL_ExcludeLocale.Enabled:=True; CBL_ExcludeExternal.Enabled:=True;
    SB_NewLibrary.Caption:='+'; OLD_CB_Library_Index:=CB_Library.ItemIndex;
    Edit_Library.Text:=''; Edit_Library.Visible:=False; Edit_Library.Enabled:=False;
  end
                   else
  begin
    CB_LibraryChange(Self);
    Button7.Enabled:=False; Button8.Enabled:=False;
    Button9.Enabled:=False; Button10.Enabled:=False;
    CBL_IncludeLocale.Items.Clear; CBL_IncludeExternal.Items.Clear;
    CBL_ExcludeLocale.Items.Clear; CBL_ExcludeExternal.Items.Clear;
    CBL_IncludeLocale.Enabled:=False; CBL_IncludeExternal.Enabled:=False;
    CBL_ExcludeLocale.Enabled:=False; CBL_ExcludeExternal.Enabled:=False;
    SB_NewLibrary.Caption:='v';
    Edit_Library.Text:='';
    Edit_Library.Visible:=True; Edit_Library.Enabled:=True; Edit_Library.SetFocus; ;
  end;
end;

procedure TFormConfig.SpeedButton17Click(Sender: TObject);
{$IFDEF HAIKU}
var AProcess: TProcess;
    AStringlist: TStringlist;
    lijn, Mountpoint: string;
    i: integer;
{$ENDIF}
begin
  {$IFDEF HAIKU}
  ShowMessage('Make sure that an Audio-CD is inserted and is mounted.');
  AProcess:=TProcess.Create(nil);
  AProcess.CommandLine:='df';
  AProcess.Options:=AProcess.Options+[poWaitOnExit, poUsePipes];
  AProcess.Execute;
  AStringlist:=TStringlist.Create;
  AStringlist.LoadFromStream(AProcess.Output);

  if AStringlist.Count<1 then
  begin
    ShowMessage('No AudioCD found');
  end
  else
  begin
    for i:=0 to AStringlist.Count-1 do
      if pos('cdda',AStringlist[i])>0 then lijn:=AStringlist.Strings[i];
    MountPoint:=trim(Copy(lijn,1,pos(' cdda ',lijn)-1));
    Delete(lijn,1, pos('/dev/',lijn)-1);
    ShowMessage('AudioCD found in ['+lijn+'] and mounted on'+#13+'['+Mountpoint+']');
    CB_Optical.Text:=lijn;
  end;
  AStringlist.Free;
  {$ENDIF}
end;

procedure TFormConfig.SpeedButton1Click(Sender: TObject);
begin
  Settings.FontSize:=SpinEditFontGrids.Value;
  Settings.Font2Size:=SpinEditFontMemo.Value;
  Settings.TimerInterval:=Trackbar1.Position; Form1.Timer1.Interval:=TrackBar1.Position;
  Settings.Fade:=CB_Fade.Checked;
  Settings.FadeTime:=TB_Fade.Position;
  Settings.FadeManual:=CB_FadeManual.Checked;
  Settings.RunFromUSB:=CB_RunFromUsb.Checked;

  Settings.CacheCDImages:=CB_CacheCDImages.Checked;
  Settings.CacheSongtext:=CB_CacheSongtext.Checked;

  Settings.ShowAllColums:=CB_ShowAllColumns.Checked;

  Settings.CDCoverInfo:=CB_CDCoverInfo.Checked;
  Settings.CDCoverLyrics:=CB_CDCoverLyrics.Checked;
  Settings.FixCDCover:=CB_FixCDCover.Checked;
  Settings.NoAdvance:=CB_NoAdvance.Checked;

  Settings.Backdrop:=CB_SystemColorTheme.ItemIndex;
  Settings.UseBackDrop:=CB_UseBackdrop.Checked;


  if not Settings.CDCoverInfo then Form1.ClearCDCover
  else
  begin
    if Loaded_CD_Cover<>'x' then Form1.ImageCDCover.Picture.Bitmap:=FormCoverPlayer.ImageCdCover.Picture.Bitmap;
    if not Settings.CDCoverLyrics then
    begin
      Form1.ImageCDCoverLyric.Picture.Bitmap.Clear; Form1.Splitter4.Top:=26;
    end
                                  else
    begin
      if Loaded_CD_Cover<>'x' then
      begin
        Form1.ImageCDCoverLyric.Picture.Bitmap:=FormCoverPlayer.ImageCdCover.Picture.Bitmap;
        if not Form1.Splitter4.Enabled then
           begin
             Form1.Splitter4.Enabled:=True;
             Form1.Splitter4.Top:=26+Form1.ImageCDCoverLyric.Width+1;
           end
           else Form1.Splitter4.Top:=26+Form1.ImageCDCoverLyric.Width+1;
        Form1.Splitter4Moved(Form1.Stringgrid1);
      end;
    end;
  end;

  Settings.TabArtist:=CB_tabArtist.ItemIndex;
  Settings.TabPlaylist:=CB_TabPlaylist.ItemIndex;
  Settings.Notification:=CB_Notification.Checked;
  Settings.OnlyWhenMinized:=CB_Minimized.Checked;
  Settings.Tray:=CB_Tray.Checked;
  Settings.SystemSettings:=CB_SystemSettings.Checked;
  Settings.DVDDrive:=CB_Optical.Text;
  Settings.cdb:=SE_Buffer.Value;
  Settings.PlayMono:=CB_Mono.Checked;
  Settings.MinimizeOnClose:=CB_MinimizeOnClose.Checked;
  Settings.NetworkControl:=CB_NetworkControl.Checked;
  Settings.ip_port:=Edit_port.Text;
  Settings.SaveLyricsInID3Tag:=CB_SaveLyricsInID3Tag.Checked;
  Settings.DeleteMacOSFiles:=CB_DeleteMacOSFiles.Checked;
  Settings.SaveExternalOnInternal:=CB_SaveExternalOnInternal.Checked;


  case Settings.TabArtist of
      0: Form1.PageControl1.TabPosition:=tpBottom;
      1: Form1.PageControl1.TabPosition:=tpLeft;
      2: Form1.PageControl1.TabPosition:=tpRight;
      3: Form1.PageControl1.TabPosition:=tpTop;
   end;
   case Settings.TabPlaylist of
     0: Form1.PageControl2.TabPosition:=tpBottom;
     1: Form1.PageControl2.TabPosition:=tpLeft;
     2: Form1.PageControl2.TabPosition:=tpRight;
     3: Form1.PageControl2.TabPosition:=tpTop;
   end;

  if ChangedFolders then CB_LibraryChange(SpeedButton1);

  Settings.NASBug:=CB_NasBug.Checked;
  Settings.SaveOnExternal:=CB_SaveOnExternal.Checked;

  Settings.Encoder:=CB_encoder.ItemIndex;
  Settings.EncodingTargetFolder:=Edit_Target.Text;
  Settings.EncodingFilenameFormatSingle:=Edit_FormatSingle.Text;
  Settings.EncodingFilenameFormatCompilation:=Edit_FormatCompilation.Text;

  Settings.Lame:=Edit_Lame.Text;
  Settings.Flac:=Edit_Flac.Text;
  Settings.OGG:=Edit_OGG.Text;
  Settings.AAC:=Edit_AAC.Text;
  Settings.Opus:=Edit_Opus.Text;
  Settings.Mplayer:=Edit_mplayer.Text;
  Settings.UpcaseLetter:=CB_Upcase.Checked;
  Settings.Check_The:=CB_Check_The.Checked;

  Settings.LastFMLogin:=EditLastFMLogin.Text;
  Settings.LastFMPass:=EditLastFMPass.Text;
  Settings.LastFMToken:=Label41.Caption;

  Form1.WriteConfig;

  if old_language<>Settings.Language then Form1.VertaalForm1;
  if addedfolders then
  begin
    hide;
    FormShowMyDialog.ShowWith('Reload MP3 Files',Form1.Vertaal('You have changed the folders'),Form1.Vertaal('Files will be reloaded'),'UNTESTED - Needs some extra love','',Form1.Vertaal('OK'), False);
    begin
      FormSplash.Show; FormSplash.Label1.Caption:='Reloading ...';
      FormSplash.Label2.Caption:='Fetching files, please be patient ...';
      Application.ProcessMessages;
      Form1.LB_Artist1.Items.Clear;
      Form1.LB_Albums1.Items.Clear;
      Liedjes:=nil;DB_Liedjes:=nil; FilesFound.Clear; max_records:=0;
      Form1.CB_LibraryChange(Self);

      Form1.AutoSizeAllColumns;

      FormSplash.Hide;
    end;
  end;

  if Settings.Soundcard<>CB_Device.ItemIndex then
  begin
    Settings.Soundcard:=CB_Device.ItemIndex;
    {$if not defined(HAIKU)}
    BASS_SetDevice(Settings.Soundcard);
    {$IFDEF UNIX}
    BASS_Init(Settings.Soundcard, 44100, 0, nil, nil);
    {$ENDIF}
    {$IFDEF WINDOWS}
     BASS_Init(Settings.Soundcard, 44100, 0, 0, nil);
    {$ENDIF}
     {$ifend}
    ShowMessage('You have chosen another audio device.  Update will be at next song.');
  end;

  Form1.LoadTheme;

  Close;
end;

procedure TFormConfig.SpeedButton2Click(Sender: TObject);
begin
  Settings.Language:=old_language;   CB_MinimizeOnClose.Checked:=Settings.MinimizeOnClose;
  Close;
end;

procedure TFormConfig.SpeedButton3Click(Sender: TObject);
begin
  if OpenDialog1.Execute then Edit_OGG.Text:=OpenDialog1.FileName;
end;

procedure TFormConfig.SpeedButton4Click(Sender: TObject);
begin
  FormLameConfig.PageControl1.PageIndex:=CB_Encoder.ItemIndex;
  FormLameConfig.ShowModal;
end;

procedure TFormConfig.SpeedButton5Click(Sender: TObject);
begin
  If SelectDirectoryDialog1.Execute then Edit_Target.Text:=SelectDirectoryDialog1.FileName;
end;

procedure TFormConfig.Button1Click(Sender: TObject);
var cmd: string;
    AProcess: TProcess;
begin
  {$IFDEF LINUX}
    cmd:='xdg-open "'+Configdir+Directoryseparator+'cache'+'"';
  {$ENDIF LINUX}
  {$IFDEF DARWIN}
    cmd:='open "'+Configdir+Directoryseparator+'cache'+'"';
  {$ENDIF DARWIN}
  {$IFDEF WINDOWS}
    cmd:='explorer "'+Configdir+Directoryseparator+'cache'+'"';
  {$ENDIF WINDOWS}
  {$IFDEF HAIKU}
    cmd:='open "'+Configdir+Directoryseparator+'cache'+'"';
  {$ENDIF}
  AProcess := TProcess.Create(nil);
  AProcess.CommandLine := cmd;
  AProcess.Execute;
  AProcess.Free;
end;

procedure TFormConfig.Button10Click(Sender: TObject);
begin
  If SelectDirectoryDialog1.Execute then
  begin
    CBL_ExcludeExternal.Items.Add(SelectDirectoryDialog1.FileName);
    CBL_ExcludeExternal.Checked[CBL_ExcludeExternal.Count-1]:=True;
    If CB_Library.ItemIndex=Form1.CB_Library.ItemIndex then addedfolders:=True;
    ChangedFolders:=True;
  end;
end;

procedure TFormConfig.Button11Click(Sender: TObject);
begin
  Form1.GetExternalApps;
  Edit_Lame.Text:=Settings.Lame;
  Edit_Flac.Text:=Settings.Flac;
  Edit_OGG.Text:=Settings.OGG;
  Edit_AAC.Text:=Settings.AAC;
  Edit_Opus.Text:=Settings.Opus;
  Edit_mplayer.Text:=Settings.Mplayer;
end;

procedure TFormConfig.Button12Click(Sender: TObject);
var fs: TFilestream;
    goed: boolean;
    filevar: textfile;
    lijn: string;
begin
  goed:=true;
  if not fileexistsutf8(tempdir+Directoryseparator+'fmtoken.txt') then
  begin
    fs := TFileStream.Create(tempdir+Directoryseparator+'fmtoken.txt', fmOpenWrite or fmCreate);
    try
      goed:=HTTPGetBinary('http://ws.audioscrobbler.com/2.0/?method=auth.gettoken&api_key=a2c1434814fb382c6020043cbb13b10d', fs);
    finally
      fs.Free;
    end;
  end;

  if goed then
  begin
    AssignFile(Filevar,tempdir+Directoryseparator+'fmtoken.txt');
    Reset(Filevar);
    Readln(Filevar,lijn); readln(Filevar,lijn); Readln(Filevar,lijn);
    CloseFile(Filevar);
  end;
  Delete(lijn,1,7); //showmessage(lijn);
   Delete(lijn,pos('<',lijn),20);//showmessage(lijn);
   Label41.Caption:=lijn; Settings.LastFMToken:=lijn;
   Label41.Refresh;
 //  Form1.BrowseTo('http://www.last.fm/api/auth/?api_key=a2c1434814fb382c6020043cbb13b10d&token='+lijn);
 //  deleteFile(tempdir+Directoryseparator+'fmtoken.txt');
end;

procedure TFormConfig.Button13Click(Sender: TObject);
var fs: TFilestream;
    goed: boolean;
    filevar: textfile;
    lijn: string;
begin
//  form1.browseto('http://ws.audioscrobbler.com/2.0/?method=auth.gettoken&api_key=a2c1434814fb382c6020043cbb13b10d&token='+lijn+'&api_sig='+MD5Print(MD5String('api_keya2c1434814fb382c6020043cbb13b10dmethodauth.getSessiontoken'+lijn+'secret')));

  goed:=true;
  begin
    fs := TFileStream.Create(tempdir+Directoryseparator+'fmtoken2.txt', fmOpenWrite or fmCreate);
    try
      goed:=HTTPGetBinary('http://ws.audioscrobbler.com/2.0/?method=auth.gettoken&api_key=a2c1434814fb382c6020043cbb13b10d&token='+lijn+'&api_sig='+MD5Print(MD5String('api_keya2c1434814fb382c6020043cbb13b10dmethodauth.getSessiontoken'+lijn+'secret')), fs);
    finally
      fs.Free;
    end;
  end;
   if goed then
  begin
    AssignFile(Filevar,tempdir+Directoryseparator+'fmtoken2.txt');
    Reset(Filevar);
    Readln(Filevar,lijn); readln(Filevar,lijn); readln(Filevar,lijn);
    CloseFile(Filevar);
  end;
  Delete(lijn,1,7); //showmessage(lijn);
  Delete(lijn,pos('<',lijn),20);//showmessage(lijn);
  Label46.Caption:=lijn; Settings.LastFMSession:=lijn;
  Label46.Refresh;

   begin
    fs := TFileStream.Create(tempdir+Directoryseparator+'fmtoken3.txt', fmOpenWrite or fmCreate);
    try
      goed:=HTTPGetBinary('http://ws.audioscrobbler.com/2.0/?method=auth.gettoken&api_key=a2c1434814fb382c6020043cbb13b10d&token='+lijn+'&api_sig='+MD5Print(MD5String('api_keya2c1434814fb382c6020043cbb13b10dmethodtrack.scrobble'+lijn+'secret')), fs);
    finally
      fs.Free;
    end;
  end;
   if goed then
  begin
    AssignFile(Filevar,tempdir+Directoryseparator+'fmtoken3.txt');
    Reset(Filevar);
    Readln(Filevar,lijn); readln(Filevar,lijn); readln(Filevar,lijn);
    CloseFile(Filevar);
  end;
  Delete(lijn,1,7); //showmessage(lijn);
  Delete(lijn,pos('<',lijn),20);//showmessage(lijn);
  Label47.Caption:=lijn;// Settings.LastFMSession:=lijn;
  Label47.Refresh;

end;

procedure TFormConfig.Button14Click(Sender: TObject);
var i: longint;
     temp_artists, Temp_Albums: TStringList;
begin
  Form1.LB_Artist1.Items.Clear;
  Form1.LB_Albums1.Items.Clear;

  Temp_Artists:=TStringlist.Create; Temp_Albums:=TStringlist.Create;
  Temp_artists.Sorted:=True; Temp_Artists.Duplicates:=dupIgnore;
  Temp_Albums.Sorted:=True; Temp_Albums.Duplicates:=dupIgnore;

  Cursor:=CrHourGlass; FormSplash.Label1.Caption:='Rereading ALL ID3-Tags - BE PATIENT';
  FormSplash.ShowOnTop; FormSplash.ProgressBar1.Max:=maxsongs; Application.ProcessMessages;
  Application.ProcessMessages;
  ID3:=TID3v2.Create; ID3OGG:=TOggVorbis.Create; id3Flac:=TFLACfile.Create;
  (*Id3Opus:=TXiX_OpusTagReader.Create;*) id3APE:=TAPEtag.Create; ID3AAC:=TMP4file.Create;
  id3OpusTest:=TOpusTag.Create;

  For i:=1 to maxsongs-1 do
    begin
      Form1.GetId3FromFilename(i);
      if (length(Liedjes[i].Artiest)<1) then Form1.GetDetailsFromFilename(i);
      if i mod 80 = 0 then
      begin
        FormSplash.Label2.Caption:=Liedjes[i].Artiest; FormSplash.ProgressBar1.Position:=i;
        Application.ProcessMessages;
      end;
      if Liedjes[i].Artiest<>'' then Temp_Artists.Add(Liedjes[i].Artiest);
      if Liedjes[i].CD<>'' then Temp_Albums.Add(Liedjes[i].CD);
    end;
  FormSplash.Close; Cursor:=CrDefault;
  ID3.Free; id3Ogg.Free;  id3Flac.Free; id3APE.free; id3AAC.Free; (*id3Opus.Free;*) id3OpusTest.Free;
  Form1.LB_Artist1.Items.AddStrings(Temp_Artists); form1.LB_Artist1.Items.Insert(0,Form1.Vertaal('All'));
  Form1.LB_Albums1.Items.AddStrings(Temp_Albums);
  Temp_Artists.Free; Temp_Albums.Free;
end;

procedure TFormConfig.Button15Click(Sender: TObject);
var oldindex: shortint;
begin
  oldindex:=CB_Library.ItemIndex;
  FormLog.MemoDebugLog.Lines.Add('Deleting '+ConfigDir+DirectorySeparator+CB_Library.Items.Strings[CB_Library.ItemIndex]+'.dir');
  DeleteFile(ConfigDir+DirectorySeparator+CB_Library.Items.Strings[CB_Library.ItemIndex]+'.dir');
  CB_Library.Items.Delete(CB_Library.ItemIndex); CB_Library.Text:=CB_Library.Items.Strings[oldindex-1];
  CB_LibraryChange(Self);
  Form1.CB_Library.Items.Delete(oldindex);
end;

procedure TFormConfig.Button3Click(Sender: TObject);
var cmd: string;
    AProcess: TProcess;
begin
  {$IFDEF LINUX}
    cmd:='xdg-open "'+Configdir+Directoryseparator+'songtext'+'"';
  {$ENDIF LINUX}
  {$IFDEF DARWIN}
    cmd:='open "'+Configdir+Directoryseparator+'songtext'+'"';
  {$ENDIF DARWIN}
  {$IFDEF WINDOWS}
    cmd:='explorer "'+Configdir+Directoryseparator+'songtext'+'"';
  {$ENDIF WINDOWS}
  {$IFDEF HAIKU}
    cmd:='open "'+Configdir+Directoryseparator+'songtext'+'"';
  {$ENDIF}
  AProcess := TProcess.Create(nil);
  AProcess.CommandLine := cmd;
  AProcess.Execute;
  AProcess.Free;
end;

procedure TFormConfig.Button5Click(Sender: TObject);
begin
  FormThemePrefs.ShowModal;
end;

procedure TFormConfig.Button7Click(Sender: TObject);
begin
  If SelectDirectoryDialog1.Execute then
  begin
    CBL_IncludeLocale.Items.Add(SelectDirectoryDialog1.FileName);
    CBL_IncludeLocale.Checked[CBL_IncludeLocale.Count-1]:=True;
    If CB_Library.ItemIndex=Form1.CB_Library.ItemIndex then addedfolders:=True;
    ChangedFolders:=True;
  end;
end;

procedure TFormConfig.Button8Click(Sender: TObject);
begin
  If SelectDirectoryDialog1.Execute then
  begin
    CBL_ExcludeLocale.Items.Add(SelectDirectoryDialog1.FileName);
    CBL_ExcludeLocale.Checked[CBL_ExcludeLocale.Count-1]:=True;
    If CB_Library.ItemIndex=Form1.CB_Library.ItemIndex then addedfolders:=True;
    ChangedFolders:=True;
  end;
end;

procedure TFormConfig.Button9Click(Sender: TObject);
begin
  If SelectDirectoryDialog1.Execute then
  begin
    CBL_IncludeExternal.Items.Add(SelectDirectoryDialog1.FileName);
    CBL_IncludeExternal.Checked[CBL_IncludeExternal.Count-1]:=True;
    If CB_Library.ItemIndex=Form1.CB_library.ItemIndex then addedfolders:=True;
    ChangedFolders:=True;
  end;
end;

procedure TFormConfig.CBL_ExcludeExternalClickCheck(Sender: TObject);
begin
  If CB_Library.ItemIndex=0 then addedfolders:=True;
  ChangedFolders:=True;
end;

procedure TFormConfig.CBL_ExcludeLocaleClickCheck(Sender: TObject);
begin
  If CB_Library.ItemIndex=0 then addedfolders:=True;
  ChangedFolders:=True;
end;

procedure TFormConfig.CBL_IncludeExternalClickCheck(Sender: TObject);
begin
  If CB_Library.ItemIndex=0 then addedfolders:=True;
  ChangedFolders:=True;
end;

procedure TFormConfig.CBL_IncludeLocaleClickCheck(Sender: TObject);
begin
  If CB_Library.ItemIndex=0 then addedfolders:=True;
  ChangedFolders:=True;
end;

procedure TFormConfig.CB_LanguageSelect(Sender: TObject);
begin
  Settings.Language:=Copy(CB_Language.Text,1,2);
  LoadLanguage;
end;

procedure TFormConfig.CB_NotificationChange(Sender: TObject);
begin
  CB_Minimized.Enabled:=CB_Notification.Checked;
end;

procedure TFormConfig.CB_LibraryChange(Sender: TObject);
var i, max: shortint;
    libraryfile, lijn, checked_str, lijn_tmp: string;
    Filevar: TextFile;
begin
  if CB_Library.Items.Count>0 then
  begin
  if CB_Library.ItemIndex>1 then Button15.Enabled:=True
                            else Button15.Enabled:=False;
  if ChangedFolders then
  begin
    if Old_CB_Library_Index=0 then libraryfile:=ConfigDir+DirectorySeparator+'default.dir'
      else if Old_CB_Library_Index=1 then libraryfile:=ConfigDir+DirectorySeparator+'work.dir'
        else libraryfile:=ConfigDir+DirectorySeparator+CB_Library.Items.Strings[Old_CB_Library_Index]+'.dir';

    if FormShowMyDialog.ShowWith(Form1.Vertaal('WARNING'),Form1.Vertaal('You have changed the following library:'),CB_Library.Items[Old_CB_Library_Index],Form1.Vertaal('SAVE?'),Form1.Vertaal('YES'),Form1.Vertaal('NO'), False) then
    begin
      FormLog.MemoDebugLog.Lines.Add('Saving Library to '+libraryfile);
      AssignFile(Filevar, libraryfile);
      Rewrite(Filevar);

      Writeln(Filevar,'[Local]');
      max:=CBL_IncludeLocale.Count;
      if max>0 then
      for i:=1 to max do Writeln(Filevar,Booltostr(CBL_IncludeLocale.Checked[i-1])+';'+CBL_IncludeLocale.Items[i-1]);
      Writeln(Filevar,'');
      Writeln(Filevar,'[ExtLocal]');
      max:=CBL_ExcludeLocale.Count;
      if max>0 then
      for i:=1 to max do Writeln(Filevar,Booltostr(CBL_ExcludeLocale.Checked[i-1])+';'+CBL_ExcludeLocale.Items[i-1]);
      Writeln(Filevar,'');
      Writeln(Filevar,'[Offline]');
      max:=CBL_IncludeExternal.Count;
      if max>0 then
      for i:=1 to max do Writeln(Filevar,Booltostr(CBL_IncludeExternal.Checked[i-1])+';'+CBL_IncludeExternal.Items[i-1]);
      Writeln(Filevar,'');
      Writeln(Filevar,'[ExtOffline]');
      max:=CBL_ExcludeExternal.Count;
      if max>0 then
      for i:=1 to max do Writeln(Filevar,Booltostr(CBL_ExcludeExternal.Checked[i-1])+';'+CBL_ExcludeExternal.Items[i-1]);
      CloseFile(Filevar);
    end
    else
    begin
      ChangedFolders:=False; Addedfolders:=false;
    end;
    ChangedFolders:=False;
  end;

  if CB_Library.ItemIndex=0 then libraryfile:=ConfigDir+DirectorySeparator+'default.dir'
      else if CB_Library.ItemIndex=1 then libraryfile:=ConfigDir+DirectorySeparator+'work.dir'
        else libraryfile:=ConfigDir+DirectorySeparator+CB_Library.Items.Strings[CB_Library.ItemIndex]+'.dir';

  CBL_IncludeLocale.Items.Clear; CBL_IncludeExternal.Items.Clear;
  CBL_ExcludeLocale.Items.Clear; CBL_ExcludeExternal.Items.Clear;

  if fileexists(libraryfile) then
  begin
    AssignFile(Filevar,libraryfile);
    Reset(Filevar);
    readln(Filevar,lijn); //Should be [Local]
    i:=0;
    repeat
      readln(Filevar,lijn);
      if length(lijn)>2 then
         begin
           checked_str:=copy(lijn,1,pos(';',lijn)-1); lijn_tmp:=copy(lijn,pos(';',lijn)+1,length(lijn));
           CBL_IncludeLocale.Items.Add(lijn_tmp);
           if checked_str='0' then CBL_IncludeLocale.Checked[i]:=false
                              else CBL_IncludeLocale.Checked[i]:=true;
           inc(i);
         end;
    until (lijn='') or eof(Filevar);
    repeat
      readln(Filevar,lijn);
    until lijn='[ExtLocal]';
    i:=0;
    repeat
      readln(Filevar,lijn);
      if length(lijn)>2 then
         begin
           checked_str:=copy(lijn,1,pos(';',lijn)-1); lijn_tmp:=copy(lijn,pos(';',lijn)+1,length(lijn));
           CBL_ExcludeLocale.Items.Add(lijn_tmp);
           if checked_str='0' then CBL_ExcludeLocale.Checked[i]:=false
                              else CBL_ExcludeLocale.Checked[i]:=true;
           inc(i);
         end;
    until (lijn='') or eof(Filevar);
    repeat
      readln(Filevar,lijn);
    until lijn='[Offline]';
    i:=0;
    repeat
      readln(Filevar,lijn);
      if length(lijn)>2 then
         begin
           checked_str:=copy(lijn,1,pos(';',lijn)-1); lijn_tmp:=copy(lijn,pos(';',lijn)+1,length(lijn));
           CBL_IncludeExternal.Items.Add(lijn_tmp);
           if checked_str='0' then CBL_IncludeExternal.Checked[i]:=false
                              else CBL_IncludeExternal.Checked[i]:=true;
           inc(i);
         end;
    until (lijn='') or eof(Filevar);
    repeat
      readln(Filevar,lijn);
    until lijn='[ExtOffline]';
    i:=0;
    repeat
      readln(Filevar,lijn);
      if length(lijn)>2 then
         begin
           checked_str:=copy(lijn,1,pos(';',lijn)-1); lijn_tmp:=copy(lijn,pos(';',lijn)+1,length(lijn));
           CBL_ExcludeExternal.Items.Add(lijn_tmp);
           if checked_str='0' then CBL_ExcludeExternal.Checked[i]:=false
                              else CBL_ExcludeExternal.Checked[i]:=true;
           inc(i);
         end;
    until (lijn='') or eof(Filevar);
  end;

  ChangedFolders:=False; OLD_CB_Library_Index:=CB_Library.ItemIndex;
  end;
end;

procedure TFormConfig.CB_NetworkControlChange(Sender: TObject);
var ipList : TStringlist;
    TcpSock: TTCPBlockSocket;
begin
  if CB_NetworkControl.Checked then
  begin
    begin
      Form1.Listen := TTCPListenDaemon.Create;
      ipList := TStringList.Create;
      try
        TcpSock := TTCPBlockSocket.create;
        try
          TcpSock.ResolveNameToIP(TcpSock.LocalName, ipList);
        finally
          TcpSock.Free;
        end;
      finally
        FormConfig.Memo_IP.Lines.AddStrings(ipList);
        ipList.Free;
      end;
      FormLog.MemoDebugLog.Lines.Add('Started listening ...');
    end;
  end
  else
  begin
    if Form1.Listen <> nil then
    begin
      Form1.Listen.Terminate;
      Form1.Listen.WaitFor;
      FreeAndNil(Form1.Listen);
      FormLog.MemoDebugLog.Lines.Add('Stopped listening ...');
    end
  end;
end;

procedure TFormConfig.CB_CDCoverInfoChange(Sender: TObject);
begin
  if CB_CDCoverInfo.Checked then CB_CDCoverLyrics.Enabled:=true
                            else CB_CDCoverLyrics.Enabled:=False;
end;

procedure TFormConfig.Edit_LibraryKeyPress(Sender: TObject; var Key: char);
begin
  if key=#27 then
  begin
    Edit_Library.Text:='';SB_NewLibrary.Caption:='+';
    Edit_Library.Visible:=False;
  end;
  if key=#13 then
  begin
    SB_NewLibraryClick(Self);
  end;
  if key in ['/','*','?',':'] then key:=#0;
end;

procedure TFormConfig.FormCreate(Sender: TObject);
begin
  {$if not defined(HAIKU)}
  Image1.Picture.LoadFromResourceName(HInstance,'about');
  {$ifend}
end;

end.

