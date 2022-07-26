unit wizard;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Dialogs, ExtCtrls,
  ComCtrls, StdCtrls, Buttons, CheckLst, Menus;

type

  { TFormWizard }

  TFormWizard = class(TForm)
    CB_RunFromUSB: TCheckBox;
    CB_NASBug: TCheckBox;
    CB_Fade: TCheckBox;
    CB_FadeManual: TCheckBox;
    CB_ScanDetails: TCheckBox;
    CB_ScanFirst: TCheckBox;
    CB_SaveOnExternal: TCheckBox;
    CLB_AddLocal: TCheckListBox;
    CLB_AddRemote: TCheckListBox;
    CLB_DontAddLocal: TCheckListBox;
    CLB_DontAddRemote: TCheckListBox;
    CB_Language: TComboBox;
    Image1: TImage;
    Image2: TImage;
    Image3: TImage;
    Image4: TImage;
    Image5: TImage;
    Image6: TImage;
    Image7: TImage;
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
    Label23: TLabel;
    Label25: TLabel;
    LabelAAC: TLabel;
    LabelOGG: TLabel;
    LabelLame: TLabel;
    Label21: TLabel;
    Label22: TLabel;
    LabelFlac: TLabel;
    Label24: TLabel;
    Label28: TLabel;
    Label29: TLabel;
    Label3: TLabel;
    Labelmplayer: TLabel;
    Label31: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    MI_RemoveFolder: TMenuItem;
    OpenDialog1: TOpenDialog;
    PageControl1: TPageControl;
    Panel1: TPanel;
    Panel10: TPanel;
    Panel11: TPanel;
    Panel12: TPanel;
    Panel13: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    Panel4: TPanel;
    Panel5: TPanel;
    Panel6: TPanel;
    Panel7: TPanel;
    Panel8: TPanel;
    Panel9: TPanel;
    PopupMenu1: TPopupMenu;
    SelectDirectoryDialog1: TSelectDirectoryDialog;
    Shape1: TShape;
    SB_Next1: TSpeedButton;
    SB_Prev3: TSpeedButton;
    SB_Next5: TSpeedButton;
    SB_Prev5: TSpeedButton;
    SB_Next6: TSpeedButton;
    SB_Prev6: TSpeedButton;
    SB_Next4: TSpeedButton;
    SB_Prev4: TSpeedButton;
    SB_Save: TSpeedButton;
    SB_Prev7: TSpeedButton;
    SpeedButton1: TSpeedButton;
    SpeedButton19: TSpeedButton;
    SpeedButton2: TSpeedButton;
    SpeedButton20: TSpeedButton;
    SpeedButton22: TSpeedButton;
    SB_Next2: TSpeedButton;
    SB_Prev2: TSpeedButton;
    SB_AddFolders1: TSpeedButton;
    SB_AddFolders2: TSpeedButton;
    SB_AddFolders3: TSpeedButton;
    SB_AddFolders4: TSpeedButton;
    SB_Next3: TSpeedButton;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
    TabSheet4: TTabSheet;
    TabSheet5: TTabSheet;
    TabSheet6: TTabSheet;
    TabSheet7: TTabSheet;
    TrackBar_Fade: TTrackBar;
    procedure CB_LanguageSelect(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure MI_RemoveFolderClick(Sender: TObject);
    procedure SB_Prev3Click(Sender: TObject);
    procedure SB_Next5Click(Sender: TObject);
    procedure SB_Prev5Click(Sender: TObject);
    procedure SB_Next6Click(Sender: TObject);
    procedure SB_Prev6Click(Sender: TObject);
    procedure SB_Next4Click(Sender: TObject);
    procedure SB_Prev4Click(Sender: TObject);
    procedure SB_SaveClick(Sender: TObject);
    procedure SB_Prev7Click(Sender: TObject);
    procedure SpeedButton19Click(Sender: TObject);
    procedure SB_Next1Click(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure SpeedButton20Click(Sender: TObject);
    procedure SpeedButton22Click(Sender: TObject);
    procedure SB_Next2Click(Sender: TObject);
    procedure SB_Prev2Click(Sender: TObject);
    procedure SB_AddFolders1Click(Sender: TObject);
    procedure SB_AddFolders2Click(Sender: TObject);
    procedure SB_AddFolders3Click(Sender: TObject);
    procedure SB_AddFolders4Click(Sender: TObject);
    procedure SB_Next3Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure TrackBar_FadeChange(Sender: TObject);
    procedure VertaalForm;
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  FormWizard: TFormWizard;

implementation

uses hoofd;

{$R *.lfm}

{ TFormWizard }

procedure TFormWizard.SB_Next1Click(Sender: TObject);
begin
  PageControl1.PageIndex:=1;
end;

procedure TFormWizard.SpeedButton1Click(Sender: TObject);
begin
   if OpenDialog1.Execute then
  begin
    Settings.OGG:=OpenDialog1.FileName;
    LabelOGG.Caption:='FOUND @ '+OpenDialog1.FileName;
  end;
end;

procedure TFormWizard.SpeedButton20Click(Sender: TObject);
begin
  if OpenDialog1.Execute then
  begin
    Settings.Flac:=OpenDialog1.FileName;
    LabelFlac.Caption:='FOUND @ '+OpenDialog1.FileName;
  end;
end;

procedure TFormWizard.SpeedButton22Click(Sender: TObject);
begin
  if OpenDialog1.Execute then
  begin
    Settings.Mplayer:=OpenDialog1.FileName;
    Labelmplayer.Caption:='FOUND @ '+OpenDialog1.FileName;
  end;
end;

procedure TFormWizard.SB_Prev3Click(Sender: TObject);
begin
  PageControl1.PageIndex:=1;
end;

procedure TFormWizard.FormShow(Sender: TObject);
var LanguagesFound: TStringlist;
    temp, lijn, checked_str: String;
    i: byte;
    Filevar: TextFile;
begin
  DeleteFile(ConfigDir+DirectorySeparator+'music.db'); Application.ProcessMessages;
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
  CB_Language.ItemIndex:=0;

  {$IFDEF WINDOWS}
    CB_NasBug.Checked:=False; CB_NASBug.Enabled:=False;
    If DirectoryExists(HomeDir+'\Music') then CLB_AddLocal.Items.Add(HomeDir+'\Music');
    //XP Folder My Music
    If DirectoryExists(HomeDir+'\Mijn documenten\Mijn muziek') then CLB_AddLocal.Items.Add(HomeDir+'\Mijn documenten\Mijn muziek');
    If DirectoryExists(HomeDir+'\Mijn documenten\My music') then CLB_AddLocal.Items.Add(HomeDir+'\Mijn documenten\My music');
  {$ENDIF}
  {$IFDEF UNIX}
    CB_NASBug.checked:=true;
    If DirectoryExists(HomeDir+'/Muziek') then  CLB_AddLocal.Items.Add(HomeDir+'/Muziek');
    If DirectoryExists(HomeDir+'/Music') then CLB_AddLocal.Items.Add(HomeDir+'/Music');
  {$ENDIF}
  {$IFDEF DARWIN}
    CB_NasBug.Checked:=False; CB_NasBug.Enabled:=False;
  {$ENDIF}

  if CLB_AddLocal.Items.Count > 0 then
     for i:=1 to CLB_AddLocal.Items.Count do CLB_AddLocal.Checked[i-1]:=true;

  Image2.Picture.Bitmap:=Image1.Picture.Bitmap; Image3.Picture.Bitmap:=Image1.Picture.Bitmap;
  Image4.Picture.Bitmap:=Image1.Picture.Bitmap; Image5.Picture.Bitmap:=Image1.Picture.Bitmap;
  Image6.Picture.Bitmap:=Image1.Picture.Bitmap; Image7.Picture.Bitmap:=Image1.Picture.Bitmap;

  Form1.GetExternalApps;

  if length(Settings.Lame)>1 then Labellame.Caption:='FOUND @'+Settings.Lame;
  if length(Settings.Flac)>1 then LabelFlac.Caption:='FOUND @'+Settings.Flac;
  if length(Settings.OGG)>1 then LabelOGG.Caption:='FOUND @'+Settings.OGG;
  if length(Settings.AAC)>1 then LabelAAC.Caption:='FOUND @'+Settings.AAC;
  if length(Settings.Mplayer)>1 then Labelmplayer.Caption:='FOUND @'+Settings.Mplayer;

  if fileexists(ConfigDir+DirectorySeparator+'default.dir') then
    if MessageDlg('Previous folders found', 'Do you want the wizard to import them?', mtConfirmation, [mbYes, mbNo],0) = mrYes then
    begin
      CLB_AddLocal.Items.Clear;
      AssignFile(Filevar, ConfigDir+DirectorySeparator+'default.dir');
      Reset(Filevar);
      Readln(Filevar,lijn);
      i:=0;
      repeat
       readln(Filevar,lijn);
       if length(lijn)>2 then
         begin
           checked_str:=copy(lijn,1,pos(';',lijn)-1);
           temp:=copy(lijn,pos(';',lijn)+1,length(lijn));
           CLB_AddLocal.Items.Add(temp);
           if checked_str='0' then CLB_AddLocal.Checked[i]:=false
                              else CLB_AddLocal.Checked[i]:=true;
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
           checked_str:=copy(lijn,1,pos(';',lijn)-1);
           temp:=copy(lijn,pos(';',lijn)+1,length(lijn));
           CLB_DontAddLocal.Items.Add(temp);
           if checked_str='0' then CLB_DontAddlocal.Checked[i]:=false
                              else CLB_DontAddlocal.Checked[i]:=true;
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
           checked_str:=copy(lijn,1,pos(';',lijn)-1);
           temp:=copy(lijn,pos(';',lijn)+1,length(lijn));
           CLB_AddRemote.Items.Add(temp);
           if checked_str='0' then CLB_AddRemote.Checked[i]:=false
                              else CLB_AddRemote.Checked[i]:=true;
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
           checked_str:=copy(lijn,1,pos(';',lijn)-1);
           temp:=copy(lijn,pos(';',lijn)+1,length(lijn));
           CLB_DontAddRemote.Items.Add(temp);
           if checked_str='0' then CLB_DontAddRemote.Checked[i]:=false
                              else CLB_DontAddRemote.Checked[i]:=true;
           inc(i);
         end;
      until (lijn='') or eof(Filevar);
      CloseFile(Filevar);
    end;
  if Form1.DownloadFile('http://www.xixmusicplayer.org/cdcover/unknown.jpg',ConfigDir+DirectorySeparator+'cache'+DirectorySeparator+'unknown_new.jpg') then
    begin
      DeleteFile(ConfigDir+DirectorySeparator+'cache'+DirectorySeparator+'unknown.jpg');
      CopyFile(ConfigDir+DirectorySeparator+'cache'+DirectorySeparator+'unknown_new.jpg',ConfigDir+DirectorySeparator+'cache'+DirectorySeparator+'unknown.jpg');
    end;
  DeleteFile(ConfigDir+DirectorySeparator+'cache'+DirectorySeparator+'unknown_new.jpg');
end;

procedure TFormWizard.VertaalForm;
var i: byte;
Begin
  for i:=1 to 20 do Vertaalstring[i]:='';
  CB_RunFromUSB.Caption:=Form1.Vertaal('Run from portable USB stick  (needs a restart)');
  SB_Next1.Caption:=Form1.Vertaal('Next');  SB_Next2.Caption:=Form1.Vertaal('Next');
  SB_Next3.Caption:=Form1.Vertaal('Next');  SB_Next4.Caption:=Form1.Vertaal('Next');
  SB_Next5.Caption:=Form1.Vertaal('Next');  SB_Next6.Caption:=Form1.Vertaal('Next');
  SB_Prev2.Caption:=Form1.Vertaal('Previous');
  SB_Prev3.Caption:=Form1.Vertaal('Previous'); SB_Prev4.Caption:=Form1.Vertaal('Previous');
  SB_Prev5.Caption:=Form1.Vertaal('Previous'); SB_Prev6.Caption:=Form1.Vertaal('Previous');
  SB_Prev7.Caption:=Form1.Vertaal('Previous');
  SB_Save.Caption:=Form1.Vertaal('Save');
  SB_AddFolders1.Caption:=Form1.Vertaal('Add folder');  SB_AddFolders2.Caption:=Form1.Vertaal('Add folder');
  SB_AddFolders3.Caption:=Form1.Vertaal('Add folder'); SB_AddFolders4.Caption:=Form1.Vertaal('Add folder');
  CB_Fade.Caption:=Form1.Vertaal('Use crossfading between 2 songs');
  CB_FadeManual.Caption:=Form1.Vertaal('Fade on manual selection');
  Label4.Caption:=Form1.Vertaal('Scan these local folders')+':';
  Label6.Caption:=Form1.Vertaal('Exclude these local folders')+':';
  Label10.Caption:=Form1.Vertaal('Scan these external folders')+':';
  Label12.Caption:=Form1.Vertaal('Exclude these external folders')+':';
  Label15.Caption:=Form1.Vertaal('Options');
end;

procedure TFormWizard.CB_LanguageSelect(Sender: TObject);
begin
  Settings.Language:=copy(CB_Language.Text,1,2);
  VertaalForm;
end;

procedure TFormWizard.MI_RemoveFolderClick(Sender: TObject);
begin
  If PageControl1.PageIndex=1 then if CLB_AddLocal.ItemIndex>-1 then CLB_AddLocal.Items.Delete(CLB_AddLocal.ItemIndex);
  If PageControl1.PageIndex=2 then if CLB_DontAddLocal.ItemIndex>-1 then CLB_DontAddLocal.Items.Delete(CLB_DontAddLocal.ItemIndex);
  If PageControl1.PageIndex=3 then if CLB_AddRemote.ItemIndex>-1 then CLB_AddRemote.Items.Delete(CLB_AddRemote.ItemIndex);
  If PageControl1.PageIndex=4 then if CLB_DontAddRemote.ItemIndex>-1 then CLB_DontAddRemote.Items.Delete(CLB_DontAddRemote.ItemIndex);
end;

procedure TFormWizard.SB_Next5Click(Sender: TObject);
begin
  PageControl1.PageIndex:=5;
end;

procedure TFormWizard.SB_Prev5Click(Sender: TObject);
begin
  PageControl1.PageIndex:=3;
end;

procedure TFormWizard.SB_Next6Click(Sender: TObject);
begin
  PageControl1.PageIndex:=6;
end;

procedure TFormWizard.SB_Prev6Click(Sender: TObject);
begin
   PageControl1.PageIndex:=4;
end;

procedure TFormWizard.SB_Next4Click(Sender: TObject);
begin
  PageControl1.PageIndex:=4;
end;

procedure TFormWizard.SB_Prev4Click(Sender: TObject);
begin
  PageControl1.PageIndex:=2;
end;

procedure TFormWizard.SB_SaveClick(Sender: TObject);
var i, max: integer;
    Filevar: TextFile;
begin
  Settings.Fade:=CB_Fade.Checked;
  Settings.FadeTime:=TrackBar_Fade.Position;
  Settings.FadeManual:=CB_FadeManual.Checked;
  Settings.ScanBackground:=CB_ScanDetails.Checked;
  Settings.ScanAtStart:=CB_ScanFirst.Checked;
  Settings.NASBug:=CB_NasBug.Checked;
  Settings.Language:=copy(CB_Language.Text,1,2);
  Settings.RunFromUSB:=CB_RunFromUSB.Checked;
  Settings.CacheCDImages:=True;
  settings.CacheSongtext:=True;
  Settings.SaveOnExternal:=CB_SaveOnExternal.Checked;

  Setlength(Settings.IncludeLocaleDirsChecked,CLB_AddLocal.Items.Count);
  for i:=0 to CLB_AddLocal.Items.Count-1 do Settings.IncludeLocaleDirsChecked[i]:=CLB_AddLocal.Checked[i];
  Settings.IncludeLocaleDirs.AddStrings(CLB_AddLocal.Items);

  Setlength(Settings.ExcludeLocaleDirsChecked,CLB_DontAddLocal.Items.Count);
  for i:=0 to CLB_DontAddLocal.Items.Count-1 do Settings.ExcludeLocaleDirsChecked[i]:=CLB_DontAddLocal.Checked[i];
  Settings.ExcludeLocaleDirs.AddStrings(CLB_DontAddLocal.Items);

  Setlength(Settings.IncludeExternalDirsChecked,CLB_AddRemote.Items.Count);
  for i:=0 to CLB_AddRemote.Items.Count-1 do Settings.IncludeExternalDirsChecked[i]:=CLB_AddRemote.Checked[i];
  Settings.IncludeExternalDirs.AddStrings(CLB_AddRemote.Items);

  Setlength(Settings.ExcludeExternalDirsChecked,CLB_DontAddRemote.Items.Count);
  for i:=0 to CLB_DontAddRemote.Items.Count-1 do Settings.ExcludeExternalDirsChecked[i]:=CLB_DontAddRemote.Checked[i];
  Settings.ExcludeExternalDirs.AddStrings(CLB_DontAddRemote.Items);

  AssignFile(Filevar, ConfigDir+DirectorySeparator+'default.dir');
  Rewrite(Filevar);
  Writeln(Filevar,'[Local]');
  max:=CLB_AddLocal.Items.Count;
  if max>0 then
  for i:=1 to max do Writeln(Filevar,Booltostr(CLB_AddLocal.Checked[i-1])+';'+CLB_AddLocal.Items[i-1]);
  Writeln(Filevar,'');
  Writeln(Filevar,'[ExtLocal]');
  max:=CLB_DontAddLocal.Items.Count;
  if max>0 then
  for i:=1 to max do Writeln(Filevar,Booltostr(CLB_DontAddLocal.Checked[i-1])+';'+CLB_DontAddLocal.Items[i-1]);
  Writeln(Filevar,'');
  Writeln(Filevar,'[Offline]');
  max:=CLB_AddRemote.Items.Count;
  if max>0 then
  for i:=1 to max do Writeln(Filevar,Booltostr(CLB_AddRemote.Checked[i-1])+';'+CLB_AddRemote.Items[i-1]);
  Writeln(Filevar,'');
  Writeln(Filevar,'[ExtOffline]');
  max:=CLB_DontAddRemote.Items.Count;
  if max>0 then
    for i:=1 to max do Writeln(Filevar,Booltostr(CLB_DontAddRemote.Checked[i-1])+';'+CLB_DontAddRemote.Items[i-1]);

  CloseFile(Filevar);

  Form1.SB_RadioUpdateClick(Self);
  Close;
end;

procedure TFormWizard.SB_Prev7Click(Sender: TObject);
begin
  PageControl1.PageIndex:=5;
end;

procedure TFormWizard.SpeedButton19Click(Sender: TObject);
begin
  if OpenDialog1.Execute then
  begin
    Settings.Lame:=OpenDialog1.FileName;
    LabelLame.Caption:='FOUND @ '+OpenDialog1.FileName;
  end;
end;

procedure TFormWizard.SB_Next2Click(Sender: TObject);
begin
  PageControl1.PageIndex:=2;
end;

procedure TFormWizard.SB_Prev2Click(Sender: TObject);
begin
  PageControl1.PageIndex:=0;
end;

procedure TFormWizard.SB_AddFolders1Click(Sender: TObject);
begin
  If SelectDirectoryDialog1.Execute then
  begin
    CLB_AddLocal.Items.Add(SelectDirectoryDialog1.FileName);
    CLB_AddLocal.Checked[CLB_AddLocal.Count-1]:=True;
  end;
end;

procedure TFormWizard.SB_AddFolders2Click(Sender: TObject);
begin
  If SelectDirectoryDialog1.Execute then
  begin
    CLB_DontAddLocal.Items.Add(SelectDirectoryDialog1.FileName);
    CLB_DontAddLocal.Checked[CLB_DontAddLocal.Count-1]:=True;
  end;
end;

procedure TFormWizard.SB_AddFolders3Click(Sender: TObject);
begin
  If SelectDirectoryDialog1.Execute then
  begin
    CLB_AddRemote.Items.Add(SelectDirectoryDialog1.FileName);
    CLB_AddRemote.Checked[CLB_Addremote.Count-1]:=True;
  end;
end;

procedure TFormWizard.SB_AddFolders4Click(Sender: TObject);
begin
  If SelectDirectoryDialog1.Execute then
  begin
    CLB_DontAddRemote.Items.Add(SelectDirectoryDialog1.FileName);
    CLB_DontAddRemote.Checked[CLB_DontAddremote.Count-1]:=True;
  end;
end;

procedure TFormWizard.SB_Next3Click(Sender: TObject);
begin
  PageControl1.PageIndex:=3;
end;

procedure TFormWizard.SpeedButton2Click(Sender: TObject);
begin
   if OpenDialog1.Execute then
  begin
    Settings.AAC:=OpenDialog1.FileName;
    LabelAAC.Caption:='FOUND @ '+OpenDialog1.FileName;
  end;
end;

procedure TFormWizard.TrackBar_FadeChange(Sender: TObject);
begin
  Label16.Caption:=Inttostr(TrackBar_Fade.Position);
end;

end.

