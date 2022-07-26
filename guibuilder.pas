unit guibuilder;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  ExtCtrls, Buttons, ExtDlgs, showmydialog;

type

  { TFormGui }

  TFormGui = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    Button6: TButton;
    Button7: TButton;
    CheckBox1: TCheckBox;
    CheckBox2: TCheckBox;
    CB_Transparant: TCheckBox;
    ColorDialog1: TColorDialog;
    ComboBox1: TComboBox;
    Edit1: TEdit;
    FontDialog1: TFontDialog;
    GroupBox1: TGroupBox;
    GroupBox10: TGroupBox;
    GroupBox2: TGroupBox;
    GroupBox3: TGroupBox;
    GroupBox4: TGroupBox;
    GroupBox5: TGroupBox;
    GroupBox6: TGroupBox;
    GroupBox7: TGroupBox;
    GroupBox8: TGroupBox;
    GroupBox9: TGroupBox;
    Image1: TImage;
    Image2: TImage;
    Image3: TImage;
    ImageVU3: TImage;
    ImageBackPlayer: TImage;
    ImageEQOn: TImage;
    ImageNext: TImage;
    ImageNext_Hoover: TImage;
    ImagePause: TImage;
    ImagePause_Hoover: TImage;
    ImagePlay: TImage;
    ImagePlay_Hoover: TImage;
    ImagePrev: TImage;
    ImagePrev_Hoover: TImage;
    ImageReverse: TImage;
    ImageReverse_Hoover: TImage;
    ImageSearch: TImage;
    ImageStop: TImage;
    ImageStop_Hoover: TImage;
    Image_EmptyStar: TImage;
    Image_Star: TImage;
    Imagebackground: TImage;
    ImageCDCover: TImage;
    ImageConfig: TImage;
    ImageEQOff: TImage;
    ImageFullscreen: TImage;
    ImageInvouwen: TImage;
    ImageMuteOff: TImage;
    ImageMuteOn: TImage;
    ImageRepeat1: TImage;
    ImageRepeatOff: TImage;
    ImagerepeatOn: TImage;
    ImageShuffleOff: TImage;
    ImageShuffleOn: TImage;
    ImageSmallBackground: TImage;
    ImageSongtext: TImage;
    ImageUitvouwen: TImage;
    ImageVolume: TImage;
    ImageVU1: TImage;
    ImageVU2: TImage;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    OpenTheme1: TOpenDialog;
    OpenPictureDialog1: TOpenPictureDialog;
    Panel1: TPanel;
    Panel2: TPanel;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    SpeedButton3: TSpeedButton;
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure CheckBox2Change(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Image1Click(Sender: TObject);
    procedure Image2Click(Sender: TObject);
    procedure Image3Click(Sender: TObject);
    procedure ImageBackPlayerClick(Sender: TObject);
    procedure ImagebackgroundClick(Sender: TObject);
    procedure ImageCDCoverClick(Sender: TObject);
    procedure ImageConfigClick(Sender: TObject);
    procedure ImageEQOffClick(Sender: TObject);
    procedure ImageEQOnClick(Sender: TObject);
    procedure ImageFullscreenClick(Sender: TObject);
    procedure ImageInvouwenClick(Sender: TObject);
    procedure ImageMuteOffClick(Sender: TObject);
    procedure ImageMuteOnClick(Sender: TObject);
    procedure ImageNextClick(Sender: TObject);
    procedure ImageNext_HooverClick(Sender: TObject);
    procedure ImagePauseClick(Sender: TObject);
    procedure ImagePause_HooverClick(Sender: TObject);
    procedure ImagePlayClick(Sender: TObject);
    procedure ImagePlay_HooverClick(Sender: TObject);
    procedure ImagePrevClick(Sender: TObject);
    procedure ImagePrev_HooverClick(Sender: TObject);
    procedure ImageRepeat1Click(Sender: TObject);
    procedure ImageRepeatOffClick(Sender: TObject);
    procedure ImagerepeatOnClick(Sender: TObject);
    procedure ImageReverseClick(Sender: TObject);
    procedure ImageReverse_HooverClick(Sender: TObject);
    procedure ImageSearchClick(Sender: TObject);
    procedure ImageShuffleOffClick(Sender: TObject);
    procedure ImageShuffleOnClick(Sender: TObject);
    procedure ImageSmallBackgroundClick(Sender: TObject);
    procedure ImageSongtextClick(Sender: TObject);
    procedure ImageStopClick(Sender: TObject);
    procedure ImageStop_HooverClick(Sender: TObject);
    procedure ImageUitvouwenClick(Sender: TObject);
    procedure ImageVolumeClick(Sender: TObject);
    procedure Image_EmptyStarClick(Sender: TObject);
    procedure Image_StarClick(Sender: TObject);
    procedure Label2Click(Sender: TObject);
    procedure Label3Click(Sender: TObject);
    procedure ophalenThema;
    procedure BewaarThema;
    procedure Button1Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure ComboBox1Select(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

const
  lijn1='You can not change the default values';
  lijn2='Please choose another Theme';
  Titel='Warning';

var
  FormGui: TFormGui;
  ischanged: boolean;

implementation

uses Hoofd, configuration;

{$R *.lfm}

{ TFormGui }

procedure TFormGui.Ophalenthema;
var Filevar: TextFile;
    lijn: string;
begin
  Form1.UnZipIt(ThemeDir+Directoryseparator+Combobox1.Text+'.xix',Tempdir+Directoryseparator+'XiXThema');
  ImageSmallBackground.Picture.LoadFromFile(Tempdir+Directoryseparator+'XiXThema'+DirectorySeparator+'background_small.bmp');
  ImageBackground.Picture.LoadFromFile(Tempdir+Directoryseparator+'XiXThema'+DirectorySeparator+'background.bmp');
  ImagePrev.Picture.LoadFromFile(Tempdir+Directoryseparator+'XiXThema'+DirectorySeparator+'prev.bmp');
  ImagePrev_Hoover.Picture.LoadFromFile(Tempdir+Directoryseparator+'XiXThema'+DirectorySeparator+'prev_hoover.bmp');
  ImageStop.Picture.LoadFromFile(Tempdir+Directoryseparator+'XiXThema'+DirectorySeparator+'stop.bmp');
  ImageStop_Hoover.Picture.LoadFromFile(Tempdir+Directoryseparator+'XiXThema'+DirectorySeparator+'stop_hoover.bmp');
  ImageReverse.Picture.LoadFromFile(Tempdir+Directoryseparator+'XiXThema'+DirectorySeparator+'reverse.bmp');
  ImageReverse_Hoover.Picture.LoadFromFile(Tempdir+Directoryseparator+'XiXThema'+DirectorySeparator+'reverse_hoover.bmp');
  ImagePlay.Picture.LoadFromFile(Tempdir+Directoryseparator+'XiXThema'+DirectorySeparator+'play.bmp');
  ImagePlay_hoover.Picture.LoadFromFile(Tempdir+Directoryseparator+'XiXThema'+DirectorySeparator+'play_hoover.bmp');
  ImagePause.Picture.LoadFromFile(Tempdir+Directoryseparator+'XiXThema'+DirectorySeparator+'pause.bmp');
  ImagePause_hoover.Picture.LoadFromFile(Tempdir+Directoryseparator+'XiXThema'+DirectorySeparator+'pause_hoover.bmp');
  ImageNext.Picture.LoadFromFile(Tempdir+Directoryseparator+'XiXThema'+DirectorySeparator+'next.bmp');
  ImageNext_hoover.Picture.LoadFromFile(Tempdir+Directoryseparator+'XiXThema'+DirectorySeparator+'next_hoover.bmp');
  ImageShuffleOn.Picture.LoadFromFile(Tempdir+Directoryseparator+'XiXThema'+DirectorySeparator+'shuffle_on.bmp');
  ImageShuffleOff.Picture.LoadFromFile(Tempdir+Directoryseparator+'XiXThema'+DirectorySeparator+'shuffle_off.bmp');
  ImageRepeatOff.Picture.LoadFromFile(Tempdir+Directoryseparator+'XiXThema'+DirectorySeparator+'repeat_off.bmp');
  ImageRepeat1.Picture.LoadFromFile(Tempdir+Directoryseparator+'XiXThema'+DirectorySeparator+'repeat_1.bmp');
  ImageRepeatOn.Picture.LoadFromFile(Tempdir+Directoryseparator+'XiXThema'+DirectorySeparator+'repeat_on.bmp');
  ImageSearch.Picture.LoadFromFile(Tempdir+Directoryseparator+'XiXThema'+DirectorySeparator+'search.bmp');
  ImageEQOn.Picture.LoadFromFile(Tempdir+Directoryseparator+'XiXThema'+DirectorySeparator+'eq.bmp');
  ImageEQOff.Picture.LoadFromFile(Tempdir+Directoryseparator+'XiXThema'+DirectorySeparator+'eq_off.bmp');
  ImageInvouwen.Picture.LoadFromFile(Tempdir+Directoryseparator+'XiXThema'+DirectorySeparator+'invouwen.bmp');
  ImageUitvouwen.Picture.LoadFromFile(Tempdir+Directoryseparator+'XiXThema'+DirectorySeparator+'uitvouwen.bmp');
  ImageFullscreen.Picture.LoadFromFile(Tempdir+Directoryseparator+'XiXThema'+DirectorySeparator+'fullscreen.bmp');
  ImageSongtext.Picture.LoadFromFile(Tempdir+Directoryseparator+'XiXThema'+DirectorySeparator+'songtext.bmp');
  ImageVolume.Picture.LoadFromFile(Tempdir+Directoryseparator+'XiXThema'+DirectorySeparator+'volume.bmp');
  ImageConfig.Picture.LoadFromFile(Tempdir+Directoryseparator+'XiXThema'+DirectorySeparator+'config.bmp');
  ImageCDCover.Picture.LoadFromFile(Tempdir+Directoryseparator+'XiXThema'+DirectorySeparator+'cdcover.bmp');
  ImageMuteOn.Picture.LoadFromFile(Tempdir+Directoryseparator+'XiXThema'+DirectorySeparator+'mute_on.bmp');
  ImageMuteOff.Picture.LoadFromFile(Tempdir+Directoryseparator+'XiXThema'+DirectorySeparator+'mute_off.bmp');
  ImageBackPlayer.Picture.LoadFromFile(Tempdir+Directoryseparator+'XiXThema'+DirectorySeparator+'backplayer.bmp');
  Image1.Picture.LoadFromFile(Tempdir+Directoryseparator+'XiXThema'+DirectorySeparator+'back_top.bmp');
  Image2.Picture.LoadFromFile(Tempdir+Directoryseparator+'XiXThema'+DirectorySeparator+'back_center.bmp');
  Image3.Picture.LoadFromFile(Tempdir+Directoryseparator+'XiXThema'+DirectorySeparator+'back_bottom.bmp');
  AssignFile(filevar,Tempdir+Directoryseparator+'XiXThema'+DirectorySeparator+'theme.rc');
  Reset(Filevar);
  Readln(Filevar, Settings.FontNaam); Label2.Font.Name:=Settings.FontNaam;
  Readln(Filevar, lijn);// Settings.FontSize:=strtoint(lijn);
  Readln(Filevar, lijn); Settings.FontColor:=strtoint(lijn); Label2.Font.Color:=Settings.FontColor;

  Readln(Filevar, Settings.Font2Naam); label3.Font.Name:=Settings.Font2Naam;
  Readln(Filevar, lijn); //Settings.Font2Size:=strtoint(lijn);
  Readln(Filevar, lijn); Settings.Font2Color:=strtoint(lijn); Label3.Font.Color:=Settings.Font2Color;
  Readln(Filevar, lijn); Settings.Font2BackColor:=strtoint(lijn); Label3.Color:=Settings.Font2BackColor;
  Readln(Filevar, lijn); if lijn='0' then Settings.Font2Transparant:=False
                                     else Settings.Font2Transparant:=True;
  CheckBox2.Checked:=Settings.Font2Transparant;
  Readln(Filevar, lijn); if lijn='0' then Settings.BoxTransparant:=False
                                     else Settings.BoxTransparant:=True;
  CB_Transparant.Checked:=Settings.BoxTransparant;
  CloseFile(Filevar)
end;

procedure TFormGui.FormShow(Sender: TObject);
begin
  ComboBox1.ItemIndex:=0;

  If combobox1.ItemIndex<1 then
  begin
    Button3.Enabled:=false;
    Button2.Enabled:=false;
  end
                           else
  begin
    Button3.Enabled:=true;
    Button2.Enabled:=true;
  end;
  if Combobox1.Items.Count>0 then ComboBox1Select(Self)
                             else
                               begin
                                 Edit1.Text:='Default'; ComBoBox1.Items.Add(Edit1.Text);
                                 BewaarThema;
                                 Form1.ZipIt(Tempdir+Directoryseparator+'XiXThema',ThemeDir+Directoryseparator+Edit1.Text+'.xix');
                                 Combobox1.ItemIndex:=0;
                               end;
  ischanged:=false;
end;

procedure TFormGui.Image1Click(Sender: TObject);
begin
  If ComboBox1.ItemIndex<1 then FormShowMyDialog.ShowWith(Titel,lijn1,lijn2,'','','OK')
  else
    begin
      If OpenPictureDialog1.Execute then
      begin
        ischanged:=True;
        Image1.Picture.LoadFromFile(OpenPictureDialog1.FileName);
      end;
    end;
end;

procedure TFormGui.Image2Click(Sender: TObject);
begin
  If ComboBox1.ItemIndex<1 then FormShowMyDialog.ShowWith(Titel,lijn1,lijn2,'','','OK')
  else
    begin
      If OpenPictureDialog1.Execute then
      begin
        ischanged:=True;
        Image2.Picture.LoadFromFile(OpenPictureDialog1.FileName);
      end;
    end;
end;

procedure TFormGui.Image3Click(Sender: TObject);
begin
  If ComboBox1.ItemIndex<1 then FormShowMyDialog.ShowWith(Titel,lijn1,lijn2,'','','OK')
  else
    begin
      If OpenPictureDialog1.Execute then
      begin
        ischanged:=True;
        Image3.Picture.LoadFromFile(OpenPictureDialog1.FileName);
      end;
    end;
end;

procedure TFormGui.ImageBackPlayerClick(Sender: TObject);
begin
    If ComboBox1.ItemIndex<1 then FormShowMyDialog.ShowWith(Titel,lijn1,lijn2,'','','OK')
  else
    begin
      If OpenPictureDialog1.Execute then
      begin
        ischanged:=True;
        ImageBackPlayer.Picture.LoadFromFile(OpenPictureDialog1.FileName);
      end;
    end;
end;

procedure TFormGui.ImagebackgroundClick(Sender: TObject);
begin
   If ComboBox1.ItemIndex<1 then FormShowMyDialog.ShowWith(Titel,lijn1,lijn2,'','','OK')
  else
    begin
      If OpenPictureDialog1.Execute then
      begin
        ischanged:=True;
        Imagebackground.Picture.LoadFromFile(OpenPictureDialog1.FileName);
      end;
    end;
end;

procedure TFormGui.FormCreate(Sender: TObject);
begin
end;

procedure TFormGui.Button4Click(Sender: TObject);
begin
  If ComboBox1.ItemIndex<1 then FormShowMyDialog.ShowWith(Titel,lijn1,lijn2,'','','OK')
  else
    begin
      if ColorDialog1.Execute then
      begin
        label2.Font.Color:=ColorDialog1.Color;
        isChanged:=false;
      end;
    end;
end;

procedure TFormGui.Button5Click(Sender: TObject);
begin
  If ComboBox1.ItemIndex<1 then FormShowMyDialog.ShowWith(Titel,lijn1,lijn2,'','','OK')
  else
    begin
      if ColorDialog1.Execute then
      begin
        label3.Font.Color:=ColorDialog1.Color;
        isChanged:=false;
      end;
    end;
end;

procedure TFormGui.Button6Click(Sender: TObject);
begin
    If ComboBox1.ItemIndex<1 then FormShowMyDialog.ShowWith(Titel,lijn1,lijn2,'','','OK')
  else
    begin
      if ColorDialog1.Execute then
      begin
        label3.Color:=ColorDialog1.Color;
        isChanged:=false;
      end;
    end;
end;

procedure TFormGui.Button7Click(Sender: TObject);
var ThemaNaam: String;
begin
  If OpenTheme1.Execute then
  begin
    ThemaNaam:=ExtractFilename(OpenTheme1.FileName);
    Delete(Themanaam,length(Themanaam)-3,4);
    ComboBox1.Items.Add(ThemaNaam); Edit1.Text:=ThemaNaam;
    CopyFile(OpenTheme1.FileName,ThemeDir+DirectorySeparator+ThemaNaam+'.xix');
    ComboBox1.ItemIndex:=ComboBox1.Items.Count-1;
    ComboBox1Select(Self);

  end;
end;

procedure TFormGui.CheckBox2Change(Sender: TObject);
begin
  If checkbox2.Checked then Label3.Transparent:=True
                       else Label3.Transparent:=false;
end;

procedure TFormGui.ImageCDCoverClick(Sender: TObject);
begin
  If ComboBox1.ItemIndex<1 then FormShowMyDialog.ShowWith(Titel,lijn1,lijn2,'','','OK')
  else
    begin
      If OpenPictureDialog1.Execute then
      begin
        ischanged:=True;
        ImageCDCover.Picture.LoadFromFile(OpenPictureDialog1.FileName);
      end;
    end;
end;

procedure TFormGui.ImageConfigClick(Sender: TObject);
begin
  If ComboBox1.ItemIndex<1 then FormShowMyDialog.ShowWith(Titel,lijn1,lijn2,'','','OK')
  else
    begin
      If OpenPictureDialog1.Execute then
      begin
        ischanged:=True;
        ImageConfig.Picture.LoadFromFile(OpenPictureDialog1.FileName);
      end;
    end;
end;

procedure TFormGui.ImageEQOffClick(Sender: TObject);
begin
  If ComboBox1.ItemIndex<1 then FormShowMyDialog.ShowWith(Titel,lijn1,lijn2,'','','OK')
  else
    begin
      If OpenPictureDialog1.Execute then
      begin
        ischanged:=True;
        ImageEQOff.Picture.LoadFromFile(OpenPictureDialog1.FileName);
      end;
    end;
end;

procedure TFormGui.ImageEQOnClick(Sender: TObject);
begin
  If ComboBox1.ItemIndex<1 then FormShowMyDialog.ShowWith(Titel,lijn1,lijn2,'','','OK')
  else
    begin
      If OpenPictureDialog1.Execute then
      begin
        ischanged:=True;
        ImageEQOn.Picture.LoadFromFile(OpenPictureDialog1.FileName);
      end;
    end;
end;

procedure TFormGui.ImageFullscreenClick(Sender: TObject);
begin
   If ComboBox1.ItemIndex<1 then FormShowMyDialog.ShowWith(Titel,lijn1,lijn2,'','','OK')
  else
    begin
      If OpenPictureDialog1.Execute then
      begin
        ischanged:=True;
        ImageFullscreen.Picture.LoadFromFile(OpenPictureDialog1.FileName);
      end;
    end;
end;

procedure TFormGui.ImageInvouwenClick(Sender: TObject);
begin
  If ComboBox1.ItemIndex<1 then FormShowMyDialog.ShowWith(Titel,lijn1,lijn2,'','','OK')
  else
    begin
      If OpenPictureDialog1.Execute then
      begin
        ischanged:=True;
        ImageInvouwen.Picture.LoadFromFile(OpenPictureDialog1.FileName);
      end;
    end;
end;

procedure TFormGui.ImageMuteOffClick(Sender: TObject);
begin
  If ComboBox1.ItemIndex<1 then FormShowMyDialog.ShowWith(Titel,lijn1,lijn2,'','','OK')
 else
   begin
     If OpenPictureDialog1.Execute then
     begin
       ischanged:=True;
       ImageMuteOff.Picture.LoadFromFile(OpenPictureDialog1.FileName);
     end;
   end;
end;

procedure TFormGui.ImageMuteOnClick(Sender: TObject);
begin
   If ComboBox1.ItemIndex<1 then FormShowMyDialog.ShowWith(Titel,lijn1,lijn2,'','','OK')
  else
    begin
      If OpenPictureDialog1.Execute then
      begin
        ischanged:=True;
        ImageMuteOn.Picture.LoadFromFile(OpenPictureDialog1.FileName);
      end;
    end;
end;

procedure TFormGui.ImageNextClick(Sender: TObject);
begin
  If ComboBox1.ItemIndex<1 then FormShowMyDialog.ShowWith(Titel,lijn1,lijn2,'','','OK')
  else
    begin
      If OpenPictureDialog1.Execute then
      begin
        ischanged:=True;
        ImageNext.Picture.LoadFromFile(OpenPictureDialog1.FileName);
      end;
    end;
end;

procedure TFormGui.ImageNext_HooverClick(Sender: TObject);
begin
   If ComboBox1.ItemIndex<1 then FormShowMyDialog.ShowWith(Titel,lijn1,lijn2,'','','OK')
  else
    begin
      If OpenPictureDialog1.Execute then
      begin
        ischanged:=True;
        ImageNext_Hoover.Picture.LoadFromFile(OpenPictureDialog1.FileName);
      end;
    end;
end;

procedure TFormGui.ImagePauseClick(Sender: TObject);
begin
  If ComboBox1.ItemIndex<1 then FormShowMyDialog.ShowWith(Titel,lijn1,lijn2,'','','OK')
  else
    begin
      If OpenPictureDialog1.Execute then
      begin
        ischanged:=True;
        ImagePause.Picture.LoadFromFile(OpenPictureDialog1.FileName);
      end;
    end;
end;

procedure TFormGui.ImagePause_HooverClick(Sender: TObject);
begin
   If ComboBox1.ItemIndex<1 then FormShowMyDialog.ShowWith(Titel,lijn1,lijn2,'','','OK')
  else
    begin
      If OpenPictureDialog1.Execute then
      begin
        ischanged:=True;
        ImagePause_hoover.Picture.LoadFromFile(OpenPictureDialog1.FileName);
      end;
    end;
end;

procedure TFormGui.ImagePlayClick(Sender: TObject);
begin
  If ComboBox1.ItemIndex<1 then FormShowMyDialog.ShowWith(Titel,lijn1,lijn2,'','','OK')
  else
    begin
      If OpenPictureDialog1.Execute then
      begin
        ischanged:=True;
        ImagePlay.Picture.LoadFromFile(OpenPictureDialog1.FileName);
      end;
    end;
end;

procedure TFormGui.ImagePlay_HooverClick(Sender: TObject);
begin
    If ComboBox1.ItemIndex<1 then FormShowMyDialog.ShowWith(Titel,lijn1,lijn2,'','','OK')
  else
    begin
      If OpenPictureDialog1.Execute then
      begin
        ischanged:=True;
        ImagePlay_hoover.Picture.LoadFromFile(OpenPictureDialog1.FileName);
      end;
    end;
end;

procedure TFormGui.ImagePrevClick(Sender: TObject);
begin
    If ComboBox1.ItemIndex<1 then FormShowMyDialog.ShowWith(Titel,lijn1,lijn2,'','','OK')
  else
    begin
      If OpenPictureDialog1.Execute then
      begin
        ischanged:=True;
        ImagePrev.Picture.LoadFromFile(OpenPictureDialog1.FileName);
      end;
    end;
end;

procedure TFormGui.ImagePrev_HooverClick(Sender: TObject);
begin
    If ComboBox1.ItemIndex<1 then FormShowMyDialog.ShowWith(Titel,lijn1,lijn2,'','','OK')
    else
      begin
        If OpenPictureDialog1.Execute then
        begin
          ischanged:=True;
          ImagePrev_Hoover.Picture.LoadFromFile(OpenPictureDialog1.FileName);
        end;
      end;
end;

procedure TFormGui.ImageRepeat1Click(Sender: TObject);
begin
    If ComboBox1.ItemIndex<1 then FormShowMyDialog.ShowWith(Titel,lijn1,lijn2,'','','OK')
    else
      begin
        If OpenPictureDialog1.Execute then
        begin
          ischanged:=True;
          ImageRepeat1.Picture.LoadFromFile(OpenPictureDialog1.FileName);
        end;
      end;
end;

procedure TFormGui.ImageRepeatOffClick(Sender: TObject);
begin
    If ComboBox1.ItemIndex<1 then FormShowMyDialog.ShowWith(Titel,lijn1,lijn2,'','','OK')
    else
      begin
        If OpenPictureDialog1.Execute then
        begin
          ischanged:=True;
          ImageRepeatOff.Picture.LoadFromFile(OpenPictureDialog1.FileName);
        end;
      end;
end;

procedure TFormGui.ImagerepeatOnClick(Sender: TObject);
begin
  If ComboBox1.ItemIndex<1 then FormShowMyDialog.ShowWith(Titel,lijn1,lijn2,'','','OK')
  else
    begin
      If OpenPictureDialog1.Execute then
      begin
        ischanged:=True;
        ImagerepeatOn.Picture.LoadFromFile(OpenPictureDialog1.FileName);
      end;
    end;
end;

procedure TFormGui.ImageReverseClick(Sender: TObject);
begin
  If ComboBox1.ItemIndex<1 then FormShowMyDialog.ShowWith(Titel,lijn1,lijn2,'','','OK')
  else
    begin
      If OpenPictureDialog1.Execute then
      begin
        ischanged:=True;
        ImageReverse.Picture.LoadFromFile(OpenPictureDialog1.FileName);
      end;
    end;
end;

procedure TFormGui.ImageReverse_HooverClick(Sender: TObject);
begin
   If ComboBox1.ItemIndex<1 then FormShowMyDialog.ShowWith(Titel,lijn1,lijn2,'','','OK')
  else
    begin
      If OpenPictureDialog1.Execute then
      begin
        ischanged:=True;
        ImageReverse_hoover.Picture.LoadFromFile(OpenPictureDialog1.FileName);
      end;
    end;
end;

procedure TFormGui.ImageSearchClick(Sender: TObject);
begin
        If ComboBox1.ItemIndex<1 then FormShowMyDialog.ShowWith(Titel,lijn1,lijn2,'','','OK')
  else
    begin
      If OpenPictureDialog1.Execute then
      begin
        ischanged:=True;
        ImageSearch.Picture.LoadFromFile(OpenPictureDialog1.FileName);
      end;
    end;
end;

procedure TFormGui.ImageShuffleOffClick(Sender: TObject);
begin
       If ComboBox1.ItemIndex<1 then FormShowMyDialog.ShowWith(Titel,lijn1,lijn2,'','','OK')
  else
    begin
      If OpenPictureDialog1.Execute then
      begin
        ischanged:=True;
        ImageShuffleOff.Picture.LoadFromFile(OpenPictureDialog1.FileName);
      end;
    end;
end;

procedure TFormGui.ImageShuffleOnClick(Sender: TObject);
begin
     If ComboBox1.ItemIndex<1 then FormShowMyDialog.ShowWith(Titel,lijn1,lijn2,'','','OK')
  else
    begin
      If OpenPictureDialog1.Execute then
      begin
        ischanged:=True;
        ImageShuffleOn.Picture.LoadFromFile(OpenPictureDialog1.FileName);
      end;
    end;
end;

procedure TFormGui.ImageSmallBackgroundClick(Sender: TObject);
begin
    If ComboBox1.ItemIndex<1 then FormShowMyDialog.ShowWith(Titel,lijn1,lijn2,'','','OK')
  else
    begin
      If OpenPictureDialog1.Execute then
      begin
        ischanged:=True;
        ImageSmallBackground.Picture.LoadFromFile(OpenPictureDialog1.FileName);
      end;
    end;
end;

procedure TFormGui.ImageSongtextClick(Sender: TObject);
begin
    If ComboBox1.ItemIndex<1 then FormShowMyDialog.ShowWith(Titel,lijn1,lijn2,'','','OK')
  else
    begin
      If OpenPictureDialog1.Execute then
      begin
        ischanged:=True;
        ImageSongtext.Picture.LoadFromFile(OpenPictureDialog1.FileName);
      end;
    end;
end;

procedure TFormGui.ImageStopClick(Sender: TObject);
begin
      If ComboBox1.ItemIndex<1 then FormShowMyDialog.ShowWith(Titel,lijn1,lijn2,'','','OK')
  else
    begin
      If OpenPictureDialog1.Execute then
      begin
        ischanged:=True;
        ImageStop.Picture.LoadFromFile(OpenPictureDialog1.FileName);
      end;
    end;
end;

procedure TFormGui.ImageStop_HooverClick(Sender: TObject);
begin
      If ComboBox1.ItemIndex<1 then FormShowMyDialog.ShowWith(Titel,lijn1,lijn2,'','','OK')
      else
        begin
          If OpenPictureDialog1.Execute then
          begin
            ischanged:=True;
            ImageStop_Hoover.Picture.LoadFromFile(OpenPictureDialog1.FileName);
          end;
        end;
end;

procedure TFormGui.ImageUitvouwenClick(Sender: TObject);
begin
      If ComboBox1.ItemIndex<1 then FormShowMyDialog.ShowWith(Titel,lijn1,lijn2,'','','OK')
      else
        begin
          If OpenPictureDialog1.Execute then
          begin
            ischanged:=True;
            ImageUitvouwen.Picture.LoadFromFile(OpenPictureDialog1.FileName);
          end;
        end;
end;

procedure TFormGui.ImageVolumeClick(Sender: TObject);
begin
       If ComboBox1.ItemIndex<1 then FormShowMyDialog.ShowWith(Titel,lijn1,lijn2,'','','OK')
      else
        begin
          If OpenPictureDialog1.Execute then
          begin
            ischanged:=True;
            ImageVolume.Picture.LoadFromFile(OpenPictureDialog1.FileName);
          end;
        end;
end;

procedure TFormGui.Image_EmptyStarClick(Sender: TObject);
begin
  If ComboBox1.ItemIndex<1 then FormShowMyDialog.ShowWith(Titel,lijn1,lijn2,'','','OK')
      else
        begin
          If OpenPictureDialog1.Execute then
          begin
            ischanged:=True;
            Image_EmptyStar.Picture.LoadFromFile(OpenPictureDialog1.FileName);
          end;
        end;
end;

procedure TFormGui.Image_StarClick(Sender: TObject);
begin
   If ComboBox1.ItemIndex<1 then FormShowMyDialog.ShowWith(Titel,lijn1,lijn2,'','','OK')
      else
        begin
          If OpenPictureDialog1.Execute then
          begin
            ischanged:=True;
            Image_Star.Picture.LoadFromFile(OpenPictureDialog1.FileName);
          end;
        end;
end;

procedure TFormGui.Label2Click(Sender: TObject);
begin
  If ComboBox1.ItemIndex<1 then FormShowMyDialog.ShowWith(Titel,lijn1,lijn2,'','','OK')
  else
    begin
      if FontDialog1.Execute then
      begin
        Label2.Font:=FontDialog1.Font;
        ischanged:=True;
      end;
    end;
end;

procedure TFormGui.Label3Click(Sender: TObject);
begin
    If ComboBox1.ItemIndex<1 then FormShowMyDialog.ShowWith(Titel,lijn1,lijn2,'','','OK')
  else
    begin
      if FontDialog1.Execute then
      begin
        Label3.Font:=FontDialog1.Font;
        ischanged:=True;
      end;
    end;
end;

procedure TFormGui.BewaarThema;
var tmpdirvar:string;
    Filevar: TextFile;
begin
  tmpdirvar:=Tempdir+Directoryseparator+'XiXThema';
  if not DirectoryExists(Tmpdirvar) then MKDir(Tmpdirvar);
  TmpDirvar:=Tmpdirvar+DirectorySeparator;

  ImageCDCover.Picture.Bitmap.SaveToFile(Tmpdirvar+'cdcover.bmp');
  ImagePrev.Picture.Bitmap.SaveToFile(Tmpdirvar+'prev.bmp');
  ImagePrev_Hoover.Picture.Bitmap.SaveToFile(Tmpdirvar+'prev_hoover.bmp');
  ImageStop.Picture.Bitmap.SaveToFile(Tmpdirvar+'stop.bmp');
  ImageStop_Hoover.Picture.Bitmap.SaveToFile(Tmpdirvar+'stop_hoover.bmp');
  ImageReverse.Picture.Bitmap.SaveToFile(Tmpdirvar+'reverse.bmp');
  ImageReverse_Hoover.Picture.Bitmap.SaveToFile(Tmpdirvar+'reverse_hoover.bmp');
  ImagePlay.Picture.Bitmap.SaveToFile(Tmpdirvar+'play.bmp');
  ImagePlay_Hoover.Picture.Bitmap.SaveToFile(Tmpdirvar+'play_hoover.bmp');
  ImagePause.Picture.Bitmap.SaveToFile(Tmpdirvar+'pause.bmp');
  ImagePause_Hoover.Picture.Bitmap.SaveToFile(Tmpdirvar+'pause_hoover.bmp');
  ImageNext.Picture.Bitmap.SaveToFile(Tmpdirvar+'next.bmp');
  ImageNext_hoover.Picture.Bitmap.SaveToFile(Tmpdirvar+'next_hoover.bmp');
  ImageRepeatOff.Picture.Bitmap.SaveToFile(Tmpdirvar+'repeat_off.bmp');
  ImageRepeat1.Picture.Bitmap.SaveToFile(Tmpdirvar+'repeat_1.bmp');
  ImageRepeatOn.Picture.Bitmap.SaveToFile(Tmpdirvar+'repeat_on.bmp');
  ImageShuffleOff.Picture.Bitmap.SaveToFile(Tmpdirvar+'shuffle_off.bmp');
  ImageShuffleOn.Picture.Bitmap.SaveToFile(Tmpdirvar+'shuffle_on.bmp');
  ImageMuteOn.Picture.Bitmap.SaveToFile(Tmpdirvar+'mute_on.bmp');
  ImageMuteOff.Picture.Bitmap.SaveToFile(Tmpdirvar+'mute_off.bmp');
  ImageSearch.Picture.Bitmap.SaveToFile(Tmpdirvar+'search.bmp');
  ImageFullscreen.Picture.Bitmap.SaveToFile(Tmpdirvar+'fullscreen.bmp');
  ImageEQOn.Picture.Bitmap.SaveToFile(Tmpdirvar+'eq.bmp');
  ImageEQOff.Picture.Bitmap.SaveToFile(Tmpdirvar+'eq_off.bmp');
  ImageSongtext.Picture.Bitmap.SaveToFile(Tmpdirvar+'songtext.bmp');
  ImageConfig.Picture.Bitmap.SaveToFile(Tmpdirvar+'config.bmp');
  ImageVolume.Picture.Bitmap.SaveToFile(Tmpdirvar+'volume.bmp');
  ImageBackground.Picture.Bitmap.SaveToFile(Tmpdirvar+'background.bmp');
  ImageSmallBackground.Picture.Bitmap.SaveToFile(Tmpdirvar+'background_small.bmp');
  ImageInvouwen.Picture.Bitmap.SaveToFile(Tmpdirvar+'invouwen.bmp');
  ImageUitvouwen.Picture.Bitmap.SaveToFile(Tmpdirvar+'uitvouwen.bmp');
  ImageBackPlayer.Picture.Bitmap.SaveToFile(Tmpdirvar+'backplayer.bmp');
  Image1.Picture.Bitmap.SaveToFile(Tmpdirvar+'back_top.bmp');
  Image2.Picture.Bitmap.SaveToFile(Tmpdirvar+'back_center.bmp');
  Image3.Picture.Bitmap.SaveToFile(Tmpdirvar+'back_bottom.bmp');

  AssignFile(Filevar,Tmpdirvar+'theme.rc');
  Rewrite(filevar);
  Writeln(Filevar,Label2.Font.Name);
  Writeln(Filevar,inttostr(Label2.Font.Size));
  Writeln(Filevar,inttostr(Label2.Font.Color));
  Writeln(Filevar,Label3.Font.Name);
  Writeln(Filevar,inttostr(Label3.Font.Size));
  Writeln(Filevar,inttostr(Label3.Font.Color));
  Writeln(Filevar,inttostr(Label3.Color));
  Writeln(Filevar,booltostr(CheckBox2.Checked));
  Writeln(Filevar,booltostr(CB_Transparant.Checked));
  CloseFile(Filevar);
end;

procedure TFormGui.Button3Click(Sender: TObject);
begin
  if ComboBox1.ItemIndex>0 then
  begin
    BewaarThema;
    Form1.ZipIt(Tempdir+Directoryseparator+'XiXThema',ThemeDir+Directoryseparator+ComboBox1.Text+'.xix');
    isChanged:=false;
    FormShowMyDialog.ShowWith(Titel,ComboBox1.Text,'has been saved','','','OK');
  end;
end;

procedure TFormGui.ComboBox1Select(Sender: TObject);
begin
  if fileexists(ThemeDir+Directoryseparator+Combobox1.Text+'.xix') then ophalenThema;
  If ComboBox1.ItemIndex<1 then
  begin
    Button3.Enabled:=false;
    Button2.Enabled:=false;
  end
                           else
  begin
    Button3.Enabled:=true;
    Button2.Enabled:=true;
  end;
end;

procedure TFormGui.SpeedButton1Click(Sender: TObject);
begin
  if isChanged then
   if FormShowMyDialog.ShowWith('WARNING','Theme has been changed','Do you want SAVE the changes','','YES','NO') then
   begin
     Button3Click(Self);
   end;
  FormConfig.CB_Theme.Items:=ComboBox1.Items;
  FormConfig.CB_Theme.ItemIndex:=Combobox1.ItemIndex;
  Close;
end;

procedure TFormGui.SpeedButton2Click(Sender: TObject);
begin
  If Edit1.Text='' then FormShowMyDialog.ShowWith('WARNING','','You did not enter a name','','','OK')
                   else
                     begin
                       ComBoBox1.Items.Add(Edit1.Text);
                       ComboBox1.Text:=Edit1.Text;
                       FormConfig.CB_Theme.Items.Add(Edit1.text);
                       Button3Click(Self);
                       SpeedButton3Click(Self);

                     end;
end;

procedure TFormGui.SpeedButton3Click(Sender: TObject);
begin
  Edit1.Text:=ComboBox1.Text; Edit1.Enabled:=False;
  SpeedButton2.Enabled:=False; SpeedButton3.Enabled:=False;
  Button1.Enabled:=True; Combobox1.Enabled:=True;
  ComboBox1Select(Self);
end;

procedure TFormGui.Button1Click(Sender: TObject);
begin
  Edit1.Text:=''; Edit1.Enabled:=True; Button1.Enabled:=False; Button2.Enabled:=False; Button3.Enabled:=False;
  Combobox1.Enabled:=False;  SpeedButton2.Enabled:=True; SpeedButton3.Enabled:=True;
end;

end.

