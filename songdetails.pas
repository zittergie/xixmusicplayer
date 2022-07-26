unit songdetails;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  StdCtrls, Buttons, ComCtrls, MaskEdit, lazutf8;

type

  { TFormDetails }

  TFormDetails = class(TForm)
    Bevel1: TBevel;
    CB_id3: TCheckBox;
    CB_EQ: TCheckBox;
    CB_Begin: TCheckBox;
    CB_End: TCheckBox;
    CB_Mono: TCheckBox;
    CB_NoFade: TCheckBox;
    CB_Genre: TComboBox;
    ComboBox2: TComboBox;
    EditTotalTracks: TEdit;
    EditRemixer: TEdit;
    EditConductor: TEdit;
    EditOrchestra: TEdit;
    EditOrigYear: TEdit;
    EditOrigTitle: TEdit;
    EditSubTitle: TEdit;
    EditGroupTitle: TEdit;
    EditCopyright: TEdit;
    EditComposer: TEdit;
    EditOrigArtist: TEdit;
    EditArtist: TEdit;
    Edit_Nr: TEdit;
    EditTitle: TEdit;
    EditAlbum: TEdit;
    EditYear: TEdit;
    EditComment: TEdit;
    Image1: TImage;
    Image2: TImage;
    Image3: TImage;
    Label43: TLabel;
    Ster5: TImage;
    Ster4: TImage;
    Ster3: TImage;
    Ster2: TImage;
    Ster1: TImage;
    ImageList1: TImageList;
    Label1: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label35: TLabel;
    Label36: TLabel;
    Label37: TLabel;
    Label38: TLabel;
    Label39: TLabel;
    Label4: TLabel;
    Label40: TLabel;
    Label41: TLabel;
    Label42: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label_id: TLabel;
    Label_idver: TLabel;
    Label_Size: TLabel;
    LB_Bitrate: TLabel;
    LB_Index: TLabel;
    MaskEdit1: TMaskEdit;
    MaskEdit2: TMaskEdit;
    ScrollBar1: TScrollBar;
    Label12: TLabel;
    Label_Software: TLabel;
    Label_NumberPlayed: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Label19: TLabel;
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
    Label30: TLabel;
    Label31: TLabel;
    Label32: TLabel;
    Label33: TLabel;
    Label34: TLabel;
    Panel2: TPanel;
    Panel3: TPanel;
    SpeedButton1: TSpeedButton;
    SB_PreVolume: TSpeedButton;
    TB_PreVolume: TTrackBar;
    TB_Eq9: TTrackBar;
    TB_Eq10: TTrackBar;
    TB_Eq1: TTrackBar;
    TB_Eq2: TTrackBar;
    TB_Eq3: TTrackBar;
    TB_Eq4: TTrackBar;
    TB_Eq5: TTrackBar;
    TB_Eq6: TTrackBar;
    TB_Eq7: TTrackBar;
    TB_Eq8: TTrackBar;
    procedure CB_EQChange(Sender: TObject);
    procedure ComboBox2Select(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: boolean);
    procedure FormShow(Sender: TObject);
    procedure Label22Click(Sender: TObject);
    procedure MaskEdit1KeyPress(Sender: TObject; var Key: char);
    procedure MaskEdit2KeyPress(Sender: TObject; var Key: char);
    procedure SB_PreVolumeClick(Sender: TObject);
    procedure Ster1Click(Sender: TObject);
    procedure Ster2Click(Sender: TObject);
    procedure Ster3Click(Sender: TObject);
    procedure Ster4Click(Sender: TObject);
    procedure Ster5Click(Sender: TObject);
    procedure TB_Eq10Change(Sender: TObject);
    procedure TB_Eq1Change(Sender: TObject);
    procedure TB_Eq2Change(Sender: TObject);
    procedure TB_Eq3Change(Sender: TObject);
    procedure TB_Eq4Change(Sender: TObject);
    procedure TB_Eq5Change(Sender: TObject);
    procedure TB_Eq6Change(Sender: TObject);
    procedure TB_Eq7Change(Sender: TObject);
    procedure TB_Eq8Change(Sender: TObject);
    procedure TB_Eq9Change(Sender: TObject);
    procedure UpdateInformation;
    procedure VulSterren(Index: byte);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  FormDetails: TFormDetails;

implementation

uses hoofd, id3v2, showmydialog, (*OggVorbis,*) APEtag, FLACFile, OggVorbisAndOpusTagLibrary;

{$R *.lfm}

{ TFormDetails }

procedure TFormDetails.TB_Eq1Change(Sender: TObject);
begin
  DB_Changed:=True;
end;

procedure TFormDetails.TB_Eq2Change(Sender: TObject);
begin
  DB_Changed:=True;
end;

procedure TFormDetails.TB_Eq3Change(Sender: TObject);
begin
  DB_Changed:=True;
end;

procedure TFormDetails.TB_Eq4Change(Sender: TObject);
begin
  DB_Changed:=True;
end;

procedure TFormDetails.TB_Eq5Change(Sender: TObject);
begin
  DB_Changed:=True;
end;

procedure TFormDetails.TB_Eq6Change(Sender: TObject);
begin
  DB_Changed:=True;
end;

procedure TFormDetails.TB_Eq7Change(Sender: TObject);
begin
  DB_Changed:=True;
end;

procedure TFormDetails.TB_Eq8Change(Sender: TObject);
begin
  DB_Changed:=True;
end;

procedure TFormDetails.TB_Eq9Change(Sender: TObject);
begin
  DB_Changed:=True;
end;

procedure TFormDetails.FormShow(Sender: TObject);
var temp_boolean: boolean;
begin
  temp_boolean:=db_changed; FormDetails.Height:=EditRemixer.Top+56;
  Image1.Picture.Bitmap:=Form1.Image9.Picture.Bitmap;
  Image3.Picture.Bitmap:=Form1.Image2.Picture.Bitmap;
  FormDetails.Caption:=Form1.Vertaal('Song Details');
  Label1.Caption:=Form1.Vertaal('Format')+':';
  Label2.Caption:=Form1.Vertaal('Quality')+':';
  Label3.Caption:=Form1.Vertaal('Bitrate')+':';
  Label11.Caption:=Form1.Vertaal('Filesize')+':';
  Label16.Caption:=Form1.Vertaal('Artist')+':';
  Label18.Caption:=Form1.Vertaal('Title')+':';
  Label19.Caption:=Form1.Vertaal('Album')+':';
  Label20.Caption:=Form1.Vertaal('Year')+':';
  Label21.Caption:=Form1.Vertaal('Genre')+':';
  Label23.Caption:=Form1.Vertaal('Comment')+':';
  Label22.Caption:=Form1.Vertaal('Rating')+':';
  Label9.Caption:=Form1.Vertaal('bytes');
  Label7.Caption:=Form1.Vertaal('Original artist')+':';
  Label8.Caption:=Form1.Vertaal('Copyright')+':';
  Label6.Caption:=Form1.Vertaal('Composer')+':';
  CB_id3.Caption:=Form1.Vertaal('Save info as ID3-tag');
  CB_EQ.Caption:=Form1.Vertaal('Custom EQ-Settings for this song');
  Label14.Caption:=Form1.Vertaal('Play as MONO');
  Label35.Caption:=Form1.Vertaal('Do NOT fade (overrides FADE SELECTION)');
  Label15.Caption:=Form1.Vertaal('Times played')+':';
  Label12.Caption:=Form1.Vertaal('Encoded with');
  Label10.Caption:=Form1.Vertaal('Start time')+':';
  Label13.Caption:=Form1.Vertaal('End time')+':';


  If CB_Genre.Items.Count<2 then CB_Genre.Items.AddStrings(Form1.CB_genre.Items);

  UpdateInformation;

  ComboBox2Select(self);
  TB_PreVolume.Position:=Liedjes[songchosen].PreVolume;

  {$IFDEF LINUX}
    //BUG IN GTK2
    CB_id3.Font.Color:=clDefault; CB_id3.Font.Size:=9;
    CB_EQ.Font.Size:=9; CB_EQ.Font.Color:=clDefault;
    CB_Mono.Font.Size:=9; CB_Mono.Font.Color:=clDefault;
    CB_NoFade.Font.Size:=9; CB_NoFade.Font.Color:=clDefault;
  {$ENDIF}
  db_changed:=temp_boolean;
end;

procedure TFormDetails.Label22Click(Sender: TObject);
begin
  Vulsterren(0);
end;

procedure TFormDetails.MaskEdit1KeyPress(Sender: TObject; var Key: char);
begin
  CB_begin.Checked:=True;
end;

procedure TFormDetails.MaskEdit2KeyPress(Sender: TObject; var Key: char);
begin
  CB_End.Checked:=True;
end;

procedure TFormDetails.SB_PreVolumeClick(Sender: TObject);
begin
  TB_PreVolume.Position:=100;
end;

procedure TFormDetails.VulSterren(Index: byte);
begin
  Liedjes[strtoint(LB_Index.Caption)].Beoordeling:=Index;
  if index >= 1 then Form1.ImageListStars.GetBitmap(0, Ster1.Picture.Bitmap)
                else Form1.ImageListStars.GetBitmap(1, Ster1.Picture.Bitmap);
  if index >= 2 then Form1.ImageListStars.GetBitmap(0, Ster2.Picture.Bitmap)
                else Form1.ImageListStars.GetBitmap(1, Ster2.Picture.Bitmap);
  if index >= 3 then Form1.ImageListStars.GetBitmap(0, Ster3.Picture.Bitmap)
                else Form1.ImageListStars.GetBitmap(1, Ster3.Picture.Bitmap);
  if index >= 4 then Form1.ImageListStars.GetBitmap(0, Ster4.Picture.Bitmap)
                else Form1.ImageListStars.GetBitmap(1, Ster4.Picture.Bitmap);
  if index >= 5 then Form1.ImageListStars.GetBitmap(0, Ster5.Picture.Bitmap)
                else Form1.ImageListStars.GetBitmap(1, Ster5.Picture.Bitmap);
end;

procedure TFormDetails.Ster1Click(Sender: TObject);
begin
  Vulsterren(1);
end;

procedure TFormDetails.Ster2Click(Sender: TObject);
begin
  Vulsterren(2);
end;

procedure TFormDetails.Ster3Click(Sender: TObject);
begin
  Vulsterren(3);
end;

procedure TFormDetails.Ster4Click(Sender: TObject);
begin
  Vulsterren(4);
end;

procedure TFormDetails.Ster5Click(Sender: TObject);
begin
  Vulsterren(5);
end;

procedure TFormDetails.TB_Eq10Change(Sender: TObject);
begin
  DB_Changed:=True;
end;

procedure TFormDetails.CB_EQChange(Sender: TObject);
begin
  Panel3.Enabled:=CB_EQ.Checked; DB_Changed:=True;
  Liedjes[songchosen].EQ := CB_EQ.Checked;
  if CB_EQ.Checked then if Liedjes[songchosen].PreVolume=0 then TB_Prevolume.Position:=100;
end;

procedure TFormDetails.ComboBox2Select(Sender: TObject);
var EQ_SetVar: Byte;
begin
  EQ_SetVar:=ComboBox2.ItemIndex; DB_Changed:=True;

  if EQ_SetVar<7 then
  begin
    TB_EQ1.Enabled:=False; TB_EQ2.Enabled:=False;
    TB_EQ3.Enabled:=False; TB_EQ4.Enabled:=False;
    TB_EQ5.Enabled:=False; TB_EQ6.Enabled:=False;
    TB_EQ7.Enabled:=False; TB_EQ8.Enabled:=False;
    TB_EQ9.Enabled:=False; TB_EQ10.Enabled:=False;
    TB_EQ1.Position:=EQ_Preset[EQ_SetVar,1];
    TB_EQ2.Position:=EQ_Preset[EQ_SetVar,2];
    TB_EQ3.Position:=EQ_Preset[EQ_SetVar,3];
    TB_EQ4.Position:=EQ_Preset[EQ_SetVar,4];
    TB_EQ5.Position:=EQ_Preset[EQ_SetVar,5];
    TB_EQ6.Position:=EQ_Preset[EQ_SetVar,6];
    TB_EQ7.Position:=EQ_Preset[EQ_SetVar,7];
    TB_EQ8.Position:=EQ_Preset[EQ_SetVar,8];
    TB_EQ9.Position:=EQ_Preset[EQ_SetVar,9];
    TB_EQ10.Position:=EQ_Preset[EQ_SetVar,10];
  end
                 else
  begin
    TB_EQ1.Enabled:=True; TB_EQ2.Enabled:=True;
    TB_EQ3.Enabled:=True; TB_EQ4.Enabled:=True;
    TB_EQ5.Enabled:=True; TB_EQ6.Enabled:=True;
    TB_EQ7.Enabled:=True; TB_EQ8.Enabled:=True;
    TB_EQ9.Enabled:=True; TB_EQ10.Enabled:=True;
    TB_EQ1.Position:=Liedjes[songchosen].EQSettings[1];
    TB_EQ2.Position:=Liedjes[songchosen].EQSettings[2];
    TB_EQ3.Position:=Liedjes[songchosen].EQSettings[3];
    TB_EQ4.Position:=Liedjes[songchosen].EQSettings[4];
    TB_EQ5.Position:=Liedjes[songchosen].EQSettings[5];
    TB_EQ6.Position:=Liedjes[songchosen].EQSettings[6];
    TB_EQ7.Position:=Liedjes[songchosen].EQSettings[7];
    TB_EQ8.Position:=Liedjes[songchosen].EQSettings[8];
    TB_EQ9.Position:=Liedjes[songchosen].EQSettings[9];
    TB_EQ10.Position:=Liedjes[songchosen].EQSettings[10];
  end;

end;

procedure TFormDetails.FormCloseQuery(Sender: TObject; var CanClose: boolean);
var veranderd: boolean;
    ext, TempPic, TempTrackString: string;
    i: integer;
begin
  veranderd:=false;
  if (CB_Nofade.Checked) and (Liedjes[songchosen].FadeSettings<>0) then veranderd:=true;
  if not (CB_Nofade.Checked) and (Liedjes[songchosen].FadeSettings<>255) then veranderd:=true;
  Liedjes[songchosen].EQ:=CB_Eq.Checked;
  Liedjes[songchosen].EQSettings[0]:=ComboBox2.ItemIndex;
  Liedjes[songchosen].EQSettings[1]:=TB_Eq1.Position;
  Liedjes[songchosen].EQSettings[2]:=TB_Eq1.Position;
  Liedjes[songchosen].EQSettings[3]:=TB_Eq1.Position;
  Liedjes[songchosen].EQSettings[4]:=TB_Eq1.Position;
  Liedjes[songchosen].EQSettings[5]:=TB_Eq1.Position;
  Liedjes[songchosen].EQSettings[6]:=TB_Eq1.Position;
  Liedjes[songchosen].EQSettings[7]:=TB_Eq1.Position;
  Liedjes[songchosen].EQSettings[8]:=TB_Eq1.Position;
  Liedjes[songchosen].EQSettings[9]:=TB_Eq1.Position;
  Liedjes[songchosen].EQSettings[10]:=TB_Eq1.Position;
  Liedjes[songchosen].PreVolume:=TB_PreVolume.Position;

  if Liedjes[songchosen].Artiest<>EditArtist.Text then veranderd:=true;
  if Liedjes[songchosen].SubTitel<>EditSubTitle.Text then veranderd:=true;
  if Liedjes[songchosen].GroupTitel<>EditGroupTitle.Text then veranderd:=true;
  if Liedjes[songchosen].Titel<>EditTitle.Text then veranderd:=true;
  if Liedjes[songchosen].OrigTitle<>EditOrigTitle.Text then veranderd:=true;
  If Liedjes[songchosen].CD<>EditAlbum.Text then veranderd:=true;
  if Liedjes[songchosen].Jaartal<>EditYear.Text then veranderd:=true;
  if Liedjes[songchosen].OrigYear<>EditOrigYear.Text then veranderd:=true;
  if Liedjes[songchosen].Comment<>EditComment.Text then veranderd:=true;
  if Liedjes[songchosen].Genre<>CB_Genre.Text then veranderd:=true;
  if Liedjes[songchosen].Track<>strtointdef(Edit_Nr.Text,0) then veranderd:=true;
  if Liedjes[songchosen].AantalTracks<>EditTotalTracks.Text then veranderd:=true;
  if Liedjes[songchosen].OrigArtiest<>EditOrigArtist.Text then veranderd:=true;
  if Liedjes[songchosen].Composer<>EditComposer.Text then veranderd:=true;
  if Liedjes[songchosen].Copyright<>EditCopyright.Text then veranderd:=true;
  if Liedjes[songchosen].Orchestra<>EditOrchestra.Text then veranderd:=true;
  if Liedjes[songchosen].Conductor<>EditConductor.Text then veranderd:=true;
  if Liedjes[songchosen].Interpreted<>EditRemixer.Text then veranderd:=true;
  if Liedjes[songchosen].Mono<>CB_Mono.Checked then veranderd:=true;
  if Liedjes[songchosen].TrimBegin<>CB_Begin.Checked then veranderd:=true;
  if Liedjes[songchosen].TrimEnd<>CB_End.Checked then veranderd:=true;
  if Liedjes[songchosen].TrimLength[0]<>Form1.TimeToSec(MaskEdit1.Text) then veranderd:=true;
  if Liedjes[songchosen].TrimLength[1]<>Form1.TimeToSec(MaskEdit2.Text) then veranderd:=true;

  if veranderd then
  begin
    if FormShowMyDialog.ShowWith(Form1.Vertaal('Save changes?'),Form1.Vertaal('Some information about the song has changed.'),'',Form1.Vertaal('Do you want to save these changes?'),Form1.Vertaal('YES'),Form1.Vertaal('NO'), False) then veranderd:=true
      else veranderd:=false;
  end;

  if veranderd then
  begin
    db_changed:=true;
    If CB_NoFade.Checked then Liedjes[songchosen].FadeSettings:=0
                         else Liedjes[songchosen].FadeSettings:=255;

    Liedjes[songchosen].AantalTracks:=EditTotalTracks.Text;
    Liedjes[songchosen].Artiest:=EditArtist.Text;
    Liedjes[songchosen].Titel:=EditTitle.Text;
    Liedjes[songchosen].SubTitel:=EditSubTitle.Text;
    Liedjes[songchosen].GroupTitel:=EditGroupTitle.Text;
    Liedjes[songchosen].OrigTitle:=EditOrigTitle.Text;
    Liedjes[songchosen].CD:=EditAlbum.Text;
    Liedjes[songchosen].Jaartal:=EditYear.Text;
    Liedjes[songchosen].OrigYear:=EditOrigYear.Text;
    Liedjes[songchosen].Comment:=EditComment.Text;
    Liedjes[songchosen].Genre:=CB_Genre.Text;
    Liedjes[songchosen].Track:=strtointdef(Edit_nr.Text,0);
    Liedjes[songchosen].Composer:=EditComposer.Text;
    Liedjes[songchosen].OrigArtiest:=EditOrigArtist.Text;
    Liedjes[songchosen].Copyright:=EditCopyright.Text;
    Liedjes[songchosen].Orchestra:=EditOrchestra.Text;
    Liedjes[songchosen].Conductor:=EditConductor.Text;
    Liedjes[songchosen].Interpreted:=EditRemixer.Text;
    Liedjes[songchosen].Mono:=CB_Mono.Checked;
    Liedjes[songchosen].TrimBegin:=CB_Begin.Checked;
    Liedjes[songchosen].TrimEnd:=CB_End.Checked;
    Liedjes[songchosen].TrimLength[0]:=Form1.TimetoSec(MaskEdit1.Text);
    Liedjes[songchosen].TrimLength[1]:=Form1.TimetoSec(MaskEdit2.Text);
    ext:=ExtractFileExt(Liedjes[songchosen].Bestandsnaam);
    if (CB_id3.Checked) then
    begin
      if Upcase(ext)='.APE' then
      begin
        id3APE:=TAPEtag.Create;
        if Liedjes[songchosen].Artiest<>'' then ID3Ape.AppendField('ARTIST',Liedjes[songchosen].Artiest);
        if Liedjes[songchosen].Titel<>'' then ID3Ape.AppendField('TITLE',Liedjes[songchosen].Titel);
        if Liedjes[songchosen].CD<>'' then ID3Ape.AppendField('ALBUM',Liedjes[songchosen].CD);
        if Liedjes[songchosen].Jaartal<>'' then ID3Ape.AppendField('YEAR',Liedjes[songchosen].Jaartal);
        if Liedjes[songchosen].Comment<>'' then ID3Ape.AppendField('COMMENT',Liedjes[songchosen].Comment);
        if Liedjes[songchosen].Composer<>'' then ID3Ape.AppendField('OMPOSER',Liedjes[songchosen].Composer);
        if Liedjes[songchosen].OrigArtiest<>'' then ID3Ape.AppendField('ORIGINAL_ARTIST',Liedjes[songchosen].OrigArtiest);
        if Liedjes[songchosen].Copyright<>'' then ID3Ape.AppendField('COPYRIGHT',Liedjes[songchosen].Copyright);
        if Liedjes[songchosen].Genre<>'' then ID3Ape.AppendField('GENRE',Liedjes[songchosen].Genre);
        if Liedjes[songchosen].Track>0 then ID3Ape.AppendField('TRACKNUMBER',inttostr(Liedjes[songchosen].Track));
        if id3extra.link<>'' then ID3Ape.AppendField('RELATED',id3extra.link);
        if Liedjes[songchosen].SubTitel<>'' then ID3Ape.AppendField('SUBTITLE',Liedjes[songchosen].SubTitel);
        if Liedjes[songchosen].GroupTitel<>'' then ID3Ape.AppendField('GROUPING',Liedjes[songchosen].GroupTitel);
        if Liedjes[songchosen].Encoder<>'' then ID3Ape.AppendField('ENCODEDBY',Liedjes[songchosen].Encoder);
        if Liedjes[songchosen].OrigTitle<>'' then ID3Ape.AppendField('ORIGINAL_TITLE',Liedjes[songchosen].OrigTitle);
        if Liedjes[songchosen].OrigYear<>'' then ID3Ape.AppendField('ORIGINAL_DATE',Liedjes[songchosen].OrigYear);
        if Liedjes[songchosen].Orchestra<>'' then ID3Ape.AppendField('ENSEMBLE',Liedjes[songchosen].Orchestra);
        if Liedjes[songchosen].Conductor<>'' then ID3Ape.AppendField('CONDUCTOR',Liedjes[songchosen].Conductor);
        if Liedjes[songchosen].Interpreted<>'' then ID3Ape.AppendField('REMIXER',Liedjes[songchosen].Interpreted);
        if id3extra.lyric<>'' then ID3Ape.AppendField('LYRICS',Liedjes[songchosen].Interpreted);
        id3APE.WriteTagInFile(Liedjes[songchosen].Pad+Liedjes[songchosen].Bestandsnaam);
        id3APE.Destroy;
      end;
      if Upcase(ext)='.MP3' then
      begin
        threadrunning:=true;
        //TempPic:=Form1.GetCDArtworkFromFile(utf8tosys(Liedjes[songchosen].Pad+Liedjes[songchosen].Bestandsnaam));
        TempPic:=Form1.GetCDArtworkFromFile(Liedjes[songchosen].Pad+Liedjes[songchosen].Bestandsnaam);
        threadrunning:=false;
        ID3:=TID3v2.Create;
        if TempPic<>'x' then
        begin
          //id3.SetCoverArt2(utf8tosys(TempPic));
          id3.SetCoverArt2(TempPic);
        end;
        ID3.GroupTitle:=Liedjes[songchosen].GroupTitel;
        ID3.Title:=Liedjes[songchosen].Titel;
        ID3.SubTitle:=Liedjes[songchosen].SubTitel;
        id3.Artist:=Liedjes[songchosen].Artiest;
        id3.Album:=Liedjes[songchosen].CD;
        id3.Year:=Liedjes[songchosen].Jaartal;
        id3.Comment:=Liedjes[songchosen].Comment;
        id3.Composer:=Liedjes[songchosen].Composer;
        id3.OriginalArtist:=Liedjes[songchosen].OrigArtiest;
        id3.Copyright:=Liedjes[songchosen].Copyright;
        id3.Genre:=Liedjes[songchosen].Genre;
        id3.Track:=Liedjes[songchosen].Track;
        id3.Encoder:=Liedjes[songchosen].Encoder;
        id3.Software:=Liedjes[songchosen].Software;
        id3.OriginalTitle:=Liedjes[songchosen].OrigTitle;
        id3.OriginalYear:=Liedjes[songchosen].OrigYear;
        id3.orchestra:=Liedjes[songchosen].Orchestra;
        id3.conductor:=Liedjes[songchosen].Conductor;
        id3.interpreted:=Liedjes[songchosen].Interpreted;
        id3.Link:=id3extra.link;
        id3.Lyric:=id3extra.lyric;
        //id3.savetofile(utf8tosys(Liedjes[songchosen].Pad+Liedjes[songchosen].Bestandsnaam));
        id3.savetofile(Liedjes[songchosen].Pad+Liedjes[songchosen].Bestandsnaam);
        ID3.Destroy;
      end;
 (*     if Upcase(ext)='.OGG' then
        begin
          ID3OGG:=TOggVorbis.Create;
          ID3ogg.Title:=Liedjes[songchosen].Titel;
          id3ogg.Artist:=Liedjes[songchosen].Artiest;
          id3ogg.Album:=Liedjes[songchosen].CD;
          id3ogg.Date:=Liedjes[songchosen].Jaartal;
          id3ogg.Comment:=Liedjes[songchosen].Comment;
          id3ogg.Composer:=Liedjes[songchosen].Composer;
          id3ogg.OriginalArtist:=Liedjes[songchosen].OrigArtiest;
          id3ogg.Copyright:=Liedjes[songchosen].Copyright;
          id3ogg.Genre:=Liedjes[songchosen].Genre;
          id3ogg.Track:=Liedjes[songchosen].Track;
          id3ogg.Encoder:=Liedjes[songchosen].Encoder;
          id3ogg.Interpreted:=Liedjes[songchosen].Interpreted;
          id3ogg.OriginalDate:=Liedjes[songchosen].OrigYear;
          id3ogg.OriginalTitle:=Liedjes[songchosen].OrigTitle;
          id3ogg.Orchestra:=Liedjes[songchosen].Orchestra;
          id3ogg.Conductor:=Liedjes[songchosen].Conductor;
          id3ogg.SubTitle:=Liedjes[songchosen].SubTitel;
          id3ogg.GroupTitle:=Liedjes[songchosen].GroupTitel;
          id3ogg.Lyrics:=id3extra.lyric;
          id3ogg.License:=id3extra.link;
          //id3ogg.SaveTag(utf8tosys(Liedjes[songchosen].Pad+Liedjes[songchosen].Bestandsnaam));
          id3ogg.SaveTag(Liedjes[songchosen].Pad+Liedjes[songchosen].Bestandsnaam);
          id3ogg.Free;
        end;   *)
       (* OPUS:  Tags not yet present are added
                 Empty Tags are removed
                 Other Tags + Picture are save *)
       if (UpCase(ext)='.OPUS') or (UpCase(ext)='.OGG') then
        begin
          id3OpusTest:=TOpusTag.Create;
          id3OpusTest.LoadFromFile(Liedjes[songchosen].Pad+Liedjes[songchosen].Bestandsnaam);
          id3OpusTest.RemoveEmptyFrames;
          for i:=0 to id3OpusTest.Count-1 do
          begin
             Case upcase(id3OpusTest.Frames[i].Name) of
               'ARTIST': begin
                           id3OpusTest.Frames[i].SetAsText(Liedjes[songchosen].Artiest);
                         // TODO:  Clean all artist tags
                         //        Add Posibility to add more Artists
                         end;
               'TITLE' : id3OpusTest.Frames[i].SetAsText(Liedjes[songchosen].Titel);
               'GENRE'  : id3OpusTest.Frames[i].SetAsText(Liedjes[songchosen].Genre);
               'ALBUM'  : id3OpusTest.Frames[i].SetAsText(Liedjes[songchosen].CD);
               'DATE'   : id3OpusTest.Frames[i].SetAsText(Liedjes[songchosen].Jaartal);
               'TRACKNUMBER': begin
                                TempTrackString:=inttostr(Liedjes[songchosen].Track);
                                if (Liedjes[songchosen].AantalTracks<>'') and (Liedjes[songchosen].AantalTracks<>'0')
                                   then TempTrackString:=TempTrackString+'/'+Liedjes[songchosen].AantalTracks;
                                if Liedjes[songchosen].Track<>0
                                  then id3OpusTest.Frames[i].SetAsText(TempTrackString);
                              end;
               'COMMENT'   : id3OpusTest.Frames[i].SetAsText(Liedjes[songchosen].Comment);
               'COMPOSER'  : id3OpusTest.Frames[i].SetAsText(Liedjes[songchosen].Composer);
               'COPYRIGHT ': id3OpusTest.Frames[i].SetAsText(Liedjes[songchosen].Copyright);
               'CONDUCTOR' : id3OpusTest.Frames[i].SetAsText(Liedjes[songchosen].Conductor);
               'ORCHESTRA' : id3OpusTest.Frames[i].SetAsText(Liedjes[songchosen].Orchestra);
               'GROUPTITLE': id3OpusTest.Frames[i].SetAsText(Liedjes[songchosen].GroupTitel);
               'SUBTITLE'  : id3OpusTest.Frames[i].SetAsText(Liedjes[songchosen].SubTitel);
               'INTERPRETED': id3OpusTest.Frames[i].SetAsText(Liedjes[songchosen].Interpreted);
               'ORIGINAL_ARTIST': id3OpusTest.Frames[i].SetAsText(Liedjes[songchosen].OrigArtiest);
               'ORIGINAL_TITLE' : id3OpusTest.Frames[i].SetAsText(Liedjes[songchosen].OrigTitle);
               'ORIGINAL_DATE'  : id3OpusTest.Frames[i].SetAsText(Liedjes[songchosen].OrigYear);
             end;
          end;
          if id3OpusTest.FrameExists('ARTIST')<0 then id3OpusTest.AddTextFrame('ARTIST',Liedjes[songchosen].Artiest);
          if id3OpusTest.FrameExists('TITLE')<0 then id3OpusTest.AddTextFrame('TITLE',Liedjes[songchosen].Titel);
          if id3OpusTest.FrameExists('DATE')<0 then id3OpusTest.AddTextFrame('DATE',Liedjes[songchosen].Jaartal);
          if id3OpusTest.FrameExists('ALBUM')<0 then id3OpusTest.AddTextFrame('ALBUM',Liedjes[songchosen].CD);
          if id3OpusTest.FrameExists('GENRE')<0 then id3OpusTest.AddTextFrame('GENRE',Liedjes[songchosen].Genre);
          if id3OpusTest.FrameExists('COMMENT')<0 then id3OpusTest.AddTextFrame('COMMENT',Liedjes[songchosen].Comment);
          if id3OpusTest.FrameExists('COMPOSER')<0 then id3OpusTest.AddTextFrame('COMPOSER',Liedjes[songchosen].Composer);
          if id3OpusTest.FrameExists('COPYRIGHT')<0 then id3OpusTest.AddTextFrame('COPYRIGHT',Liedjes[songchosen].Copyright);
          if id3OpusTest.FrameExists('CONDUCTOR')<0 then id3OpusTest.AddTextFrame('CONDUCTOR',Liedjes[songchosen].Conductor);
          if id3OpusTest.FrameExists('ORCHESTRA')<0 then id3OpusTest.AddTextFrame('ORCHESTRA',Liedjes[songchosen].Orchestra);
          if id3OpusTest.FrameExists('GROUPTITLE')<0 then id3OpusTest.AddTextFrame('GROUPTITLE',Liedjes[songchosen].GroupTitel);
          if id3OpusTest.FrameExists('SUBTITLE')<0 then id3OpusTest.AddTextFrame('SUBTITLE',Liedjes[songchosen].SubTitel);
          if id3OpusTest.FrameExists('INTERPRETED')<0 then id3OpusTest.AddTextFrame('INTERPRETED',Liedjes[songchosen].Interpreted);
          if id3OpusTest.FrameExists('ORIGINAL_ARTIST')<0 then id3OpusTest.AddTextFrame('ORIGINAL_ARTIST',Liedjes[songchosen].OrigArtiest);
          if id3OpusTest.FrameExists('ORIGINAL_TITLE')<0 then id3OpusTest.AddTextFrame('ORIGINAL_TITLE',Liedjes[songchosen].OrigTitle);
          if id3OpusTest.FrameExists('ORIGINAL_DATE')<0 then id3OpusTest.AddTextFrame('ORIGINAL_DATE',Liedjes[songchosen].OrigYear);

          if Liedjes[songchosen].Track=0 then id3OpusTest.DeleteFrameByName('TRACKNUMBER')
                                         else if id3OpusTest.FrameExists('TRACKNUMBER')<0
                                           then begin
                                                  if (Liedjes[songchosen].AantalTracks<>'') and (Liedjes[songchosen].AantalTracks<>'')
                                                    then id3OpusTest.AddTextFrame('TRACKNUMBER',Inttostr(Liedjes[songchosen].Track)+'/'+Liedjes[songchosen].AantalTracks)
                                                    else id3OpusTest.AddTextFrame('TRACKNUMBER',Inttostr(Liedjes[songchosen].Track));
                                                end;
          id3OpusTest.RemoveEmptyFrames;
          id3OpusTest.SaveToFile(Liedjes[songchosen].Pad+Liedjes[songchosen].Bestandsnaam);
          id3OpusTest.Free;
        end;
       if Upcase(ext)='.FLAC' then
        begin
          threadrunning:=true;
          //TempPic:=Form1.GetCDArtworkFromFile(utf8tosys(Liedjes[songchosen].Pad+Liedjes[songchosen].Bestandsnaam));
          TempPic:=Form1.GetCDArtworkFromFile(Liedjes[songchosen].Pad+Liedjes[songchosen].Bestandsnaam);
          threadrunning:=false;
          id3Flac:=TFLACfile.Create;
          id3flac.SaveCDCover:=id3flac.SetCoverArt2(3,TempPic,500,500);
          id3flac.Title:=Liedjes[songchosen].Titel;
          id3flac.GroupTitle:=Liedjes[songchosen].GroupTitel;
          id3flac.SubTitle:=Liedjes[songchosen].SubTitel;
          id3flac.Artist:=Liedjes[songchosen].Artiest;
          id3flac.Album:=Liedjes[songchosen].CD;
          id3flac.Year:=Liedjes[songchosen].Jaartal;
          id3flac.Comment:=Liedjes[songchosen].Comment;
          id3flac.Composer:=Liedjes[songchosen].Composer;
          id3flac.performer:=Liedjes[songchosen].OrigArtiest;
          id3flac.OriginalTitle:=Liedjes[songchosen].OrigTitle;
          id3flac.OriginalYear:=Liedjes[songchosen].OrigYear;
          id3flac.Copyright:=Liedjes[songchosen].Copyright;
          id3flac.Genre:=Liedjes[songchosen].Genre;
          id3flac.TrackString:=inttostr(Liedjes[songchosen].Track);
          id3flac.Encoder:=Liedjes[songchosen].Encoder;
          id3flac.Link:=id3extra.link;
          id3flac.Orchestra:=Liedjes[songchosen].Orchestra;
          id3flac.conductor:=Liedjes[songchosen].Conductor;
          id3flac.interpreted:=Liedjes[songchosen].Interpreted;
          id3flac.idVendor:=id3extra.link;
          id3flac.Lyrics:=id3extra.lyric;
          //id3flac.SaveToFile(utf8tosys(Liedjes[songchosen].Pad+Liedjes[songchosen].Bestandsnaam), false);
          id3flac.SaveToFile(Liedjes[songchosen].Pad+Liedjes[songchosen].Bestandsnaam, false);
          id3Flac.free;
        end;
       if (Upcase(ext)<>'.MP3') and (Upcase(ext)<>'.OGG') and (Upcase(ext)<>'.FLAC') and (Upcase(ext)<>'.APE') and (Upcase(ext)<>'.OPUS') then showmessage(Form1.Vertaal('Changing ID3 tags only for MP3, FLAC, APE, OGG and OPUS files'));
    end;
    Form1.UpdateArtistGrids(songchosen);
  end;
end;

procedure TFormDetails.UpdateInformation;
var ext: string;
Begin
  Label5.Caption:='-';
  Form1.GetId3Extra(songchosen);
  EditArtist.Text:=Liedjes[songchosen].Artiest;
  if Liedjes[songchosen].Track>0 then Edit_Nr.Text:=inttostr(Liedjes[songchosen].Track)
                                 else Edit_Nr.Text:='';
  EditTotalTracks.Text:=Liedjes[songchosen].AantalTracks;
  EditTitle.Text:=Liedjes[songchosen].Titel;
  EditSubTitle.Text:=Liedjes[songchosen].SubTitel;
  EditGroupTitle.Text:=Liedjes[songchosen].GroupTitel;
  EditAlbum.Text:=Liedjes[songchosen].CD;
  EditComment.Text:=Liedjes[songchosen].Comment;
  EditComposer.Text:=Liedjes[songchosen].Composer;
  EditOrigArtist.Text:=Liedjes[songchosen].OrigArtiest;
  EditOrigYear.Text:=Liedjes[songchosen].OrigYear;
  EditOrigTitle.Text:=Liedjes[songchosen].OrigTitle;
  EditCopyright.Text:=Liedjes[songchosen].Copyright;
  EditRemixer.Text:=Liedjes[songchosen].Interpreted;
  EditOrchestra.Text:=Liedjes[songchosen].Orchestra;
  EditConductor.Text:=Liedjes[songchosen].Conductor;
  CB_Genre.Text:=Liedjes[songchosen].Genre;
  CB_Begin.Checked:=Liedjes[songchosen].TrimBegin;
  CB_End.Checked:=Liedjes[songchosen].TrimEnd;
  CB_Mono.Checked:=Liedjes[songchosen].Mono;
  MaskEdit1.Text:=Form1.SecToTime(Liedjes[songchosen].TrimLength[0]);
  MaskEdit2.Text:=Form1.SecToTime(Liedjes[songchosen].TrimLength[1]);
  If length(Liedjes[songchosen].Software)>0 then Label_Software.Caption:=Liedjes[songchosen].Software
                                            else Label_Software.Caption:='Unknown Software';
  EditYear.Text:=Liedjes[songchosen].Jaartal;

  CB_EQ.Checked := Liedjes[songchosen].EQ;

  Combobox2.ItemIndex:=Liedjes[songchosen].EQSettings[0];
  if Combobox2.ItemIndex>6 then
  begin
    TB_Eq1.Position:=Liedjes[songchosen].EQSettings[1];
    TB_Eq2.Position:=Liedjes[songchosen].EQSettings[2];
    TB_Eq3.Position:=Liedjes[songchosen].EQSettings[3];
    TB_Eq4.Position:=Liedjes[songchosen].EQSettings[4];
    TB_Eq5.Position:=Liedjes[songchosen].EQSettings[5];
    TB_Eq6.Position:=Liedjes[songchosen].EQSettings[6];
    TB_Eq7.Position:=Liedjes[songchosen].EQSettings[7];
    TB_Eq8.Position:=Liedjes[songchosen].EQSettings[8];
    TB_Eq9.Position:=Liedjes[songchosen].EQSettings[9];
    TB_Eq10.Position:=Liedjes[songchosen].EQSettings[10];
  end;

  LB_Index.Caption:=inttostr(songchosen);
  Label_Id.Caption:=id3extra.id;
  Label_idver.Caption:='id3v2.'+inttostr(id3extra.version);
  Label_Size.Caption:=inttostr(id3extra.Size);
  If Liedjes[songchosen].FadeSettings=255 then CB_NoFade.Checked:=False
                                          else CB_NoFade.Checked:=True;
  Vulsterren(Liedjes[songchosen].Beoordeling);
  Label_NumberPlayed.Caption:=inttostr(Liedjes[songchosen].aantalafspelen);

 ext:=Upcase(ExtractFileExt(Liedjes[songchosen].Bestandsnaam));

 if songplaying=songchosen then LB_Bitrate.Caption:=inttostr(round(id3extra.Size*8/total_time/1000))+' kbps'
                           else LB_Bitrate.Caption:='***';
 if (ext<>'.MP3') then
 begin
   LB_Bitrate.Caption:=id3extra.bitrate;
   Label5.Caption:=id3extra.quality;
   Label_idver.Caption:=' ';
 end;
 if (ext='.FLAC') or (ext='.OPUS') then
 begin
    Label5.Caption:=id3extra.quality;
    LB_Bitrate.Caption:=id3extra.bitrate;
    Label_idver.Caption:=' ';
 end;

 if (Upcase(ext)<>'.MP3') and (Upcase(ext)<>'.OGG') and (Upcase(ext)<>'.FLAC') and (Upcase(ext)<>'.APE') and (Upcase(ext)<>'.OPUS') then
 begin
    CB_ID3.Checked:=false;
    CB_ID3.Enabled:=false;
 end
 else
 begin
    CB_ID3.Checked:=true;
    CB_ID3.Enabled:=true;
 end
end;

end.

