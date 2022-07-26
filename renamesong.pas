unit renamesong;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  ExtCtrls, Buttons, Spin, LazFileUtils, lazutf8;

type

  { TFormRenameSong }

  TFormRenameSong = class(TForm)
    Bevel1: TBevel;
    CB_id3: TCheckBox;
    CB_Genre: TComboBox;
    Edit1: TEdit;
    Edit2: TEdit;
    EditArtist: TEdit;
    EditTitle: TEdit;
    EditAlbum: TEdit;
    EditYear: TEdit;
    EditComment: TEdit;
    Edit7: TEdit;
    Edit8: TEdit;
    Image1: TImage;
    LB_File: TLabel;
    LB_Composer: TLabel;
    LB_Copyright: TLabel;
    LB_OrigArtist: TLabel;
    LB_DBInfo: TLabel;
    LB_Artist: TLabel;
    LB_Title: TLabel;
    LB_Album: TLabel;
    LB_Year: TLabel;
    LB_Comment: TLabel;
    LB_Track: TLabel;
    LB_Genre: TLabel;
    Panel1: TPanel;
    SB_Revert: TSpeedButton;
    SB_Save: TSpeedButton;
    SB_Cancel: TSpeedButton;
    SE_track: TSpinEdit;
    procedure FormShow(Sender: TObject);
    procedure SB_RevertClick(Sender: TObject);
    procedure SB_SaveClick(Sender: TObject);
    procedure SB_CancelClick(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  FormRenameSong: TFormRenameSong;

implementation

uses hoofd, id3v2, APEtag, (*OggVorbis,*) FLACFile, OggVorbisAndOpusTagLibrary;

{$R *.lfm}

{ TFormRenameSong }

procedure TFormRenameSong.SB_CancelClick(Sender: TObject);
begin
  Close;
end;

procedure TFormRenameSong.SB_RevertClick(Sender: TObject);
begin
  Edit1.Text:=Liedjes[songchosen].Bestandsnaam;
  EditArtist.Text:=Liedjes[songchosen].Artiest;
  EditTitle.Text:=Liedjes[songchosen].Titel;
  EditAlbum.Text:=Liedjes[songchosen].CD;
  EditYear.Text:=Liedjes[songchosen].Jaartal;
  EditComment.Text:=Liedjes[songchosen].Comment;
  CB_Genre.Text:=Liedjes[songchosen].Genre;
  SE_track.Value:=Liedjes[songchosen].Track;
  Edit7.Text:=Liedjes[songchosen].Composer;
  Edit8.Text:=Liedjes[songchosen].Copyright;
  Edit2.Text:=Liedjes[songchosen].OrigArtiest;
end;

procedure TFormRenameSong.SB_SaveClick(Sender: TObject);
var ext, temp, path, temppic: string;
    veranderd: boolean;
    i: integer;
    TempTrackString: string;
begin
  veranderd:=false;
  ext:=ExtractFileExt(Liedjes[songchosen].Bestandsnaam);
  temp:=ExtractFileExt(Edit1.Text);
  If temp<>ext then Edit1.Text:=Edit1.Text+ext;

  If Edit1.Text<>Liedjes[songchosen].Bestandsnaam then
  begin
    path:=Liedjes[songchosen].Pad;
    If RenameFileUTF8(path+Liedjes[songchosen].Bestandsnaam,path+Edit1.Text) then
    begin
      Liedjes[songchosen].bestandsnaam:=Edit1.Text;
      Hide;
      ShowMessage(Form1.Vertaal('Song successfully renamed.'));
    end;
  end;

  If EditArtist.Text<>Liedjes[songchosen].Artiest then If Form1.LB_Artist1.Items.IndexOf(EditArtist.Text)<0 then
  begin
    Form1.LB_Artist1.Items.Delete(0);
    Form1.LB_Artist1.Items.Add(EditArtist.Text);
    Form1.LB_Artist1.Sorted:=True;  Application.ProcessMessages;
    Form1.LB_Artist1.Sorted:=False;
    Form1.LB_Artist1.Items.Insert(0,'All');
  end;
  if Liedjes[songchosen].Artiest<>EditArtist.Text then veranderd:=true;
  if Liedjes[songchosen].Titel<>EditTitle.Text then veranderd:=true;
  If Liedjes[songchosen].CD<>EditAlbum.Text then veranderd:=true;
  if Liedjes[songchosen].Jaartal<>EditYear.Text then veranderd:=true;
  if Liedjes[songchosen].Comment<>EditComment.Text then veranderd:=true;
  if Liedjes[songchosen].Genre<>CB_Genre.Text then veranderd:=true;
  if Liedjes[songchosen].Track<>SE_Track.Value then veranderd:=true;
  if Liedjes[songchosen].Copyright<>Edit8.Text then veranderd:=true;
  If Liedjes[songchosen].OrigArtiest<>Edit2.Text then veranderd:=true;
  If Liedjes[songchosen].Composer<>Edit7.Text then veranderd:=true;
  if veranderd then
  begin
    db_changed:=true;
    Liedjes[songchosen].Artiest:=EditArtist.Text;
    Liedjes[songchosen].Titel:=EditTitle.Text;
    Liedjes[songchosen].CD:=EditAlbum.Text;
    Liedjes[songchosen].Jaartal:=EditYear.Text;
    Liedjes[songchosen].Comment:=EditComment.Text;
    Liedjes[songchosen].Genre:=CB_Genre.Text;
    Liedjes[songchosen].Track:=SE_Track.Value;
    Liedjes[songchosen].Composer:=Edit7.Text;
    Liedjes[songchosen].Copyright:=Edit8.Text;
    Liedjes[songchosen].OrigArtiest:=Edit2.Text;

    if (CB_id3.Checked) then
    begin
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
               'ORIGINAL_ARTIST': id3OpusTest.Frames[i].SetAsText(Liedjes[songchosen].OrigArtiest);
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
          if id3OpusTest.FrameExists('ORIGINAL_ARTIST')<0 then id3OpusTest.AddTextFrame('ORIGINAL_ARTIST',Liedjes[songchosen].OrigArtiest);

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
      if Upcase(ext)='.APE' then
      begin
        id3APE:=TAPEtag.Create;
        if Liedjes[songchosen].Artiest<>'' then ID3Ape.AppendField('ARTIST',Liedjes[songchosen].Artiest);
        if Liedjes[songchosen].Titel<>'' then ID3Ape.AppendField('TITLE',Liedjes[songchosen].Titel);
        if Liedjes[songchosen].CD<>'' then ID3Ape.AppendField('ALBUM',Liedjes[songchosen].CD);
        if Liedjes[songchosen].Jaartal<>'' then ID3Ape.AppendField('DATE',Liedjes[songchosen].Jaartal);
        if Liedjes[songchosen].Comment<>'' then ID3Ape.AppendField('COMMENT',Liedjes[songchosen].Comment);
        if Liedjes[songchosen].Composer<>'' then ID3Ape.AppendField('COMPOSER',Liedjes[songchosen].Composer);
        if Liedjes[songchosen].OrigArtiest<>'' then ID3Ape.AppendField('ORIGINAL_ARTIST',Liedjes[songchosen].OrigArtiest);
        if Liedjes[songchosen].Copyright<>'' then ID3Ape.AppendField('COPYRIGHT',Liedjes[songchosen].Copyright);
        if Liedjes[songchosen].Genre<>'' then ID3Ape.AppendField('GENRE',Liedjes[songchosen].Genre);
        if Liedjes[songchosen].Track>0 then ID3Ape.AppendField('TRACK',inttostr(Liedjes[songchosen].Track));
        if Liedjes[songchosen].SubTitel<>'' then ID3Ape.AppendField('SUBTITLE',Liedjes[songchosen].SubTitel);
        if Liedjes[songchosen].GroupTitel<>'' then ID3Ape.AppendField('GROUPING',Liedjes[songchosen].GroupTitel);
        if Liedjes[songchosen].Encoder<>'' then ID3Ape.AppendField('ENCODEDBY',Liedjes[songchosen].Encoder);
        if Liedjes[songchosen].OrigTitle<>'' then ID3Ape.AppendField('ORIGINAL_TITLE',Liedjes[songchosen].OrigTitle);
        if Liedjes[songchosen].OrigYear<>'' then ID3Ape.AppendField('ORIGINAL_DATE',Liedjes[songchosen].OrigYear);
        if Liedjes[songchosen].Orchestra<>'' then ID3Ape.AppendField('ENSEMBLE',Liedjes[songchosen].Orchestra);
        if Liedjes[songchosen].Conductor<>'' then ID3Ape.AppendField('CONDUCTOR',Liedjes[songchosen].Conductor);
        if Liedjes[songchosen].Interpreted<>'' then ID3Ape.AppendField('REMIXER',Liedjes[songchosen].Interpreted);
        if id3extra.link<>'' then ID3Ape.AppendField('Related',id3extra.link);
        if id3extra.lyric<>'' then ID3Ape.AppendField('LYRICS',Liedjes[songchosen].Interpreted);
        //id3APE.WriteTagInFile(utf8tosys(Liedjes[songchosen].Pad+Liedjes[songchosen].Bestandsnaam));
        id3APE.WriteTagInFile(Liedjes[songchosen].Pad+Liedjes[songchosen].Bestandsnaam);
        id3APE.Destroy;
      end;
      if Upcase(ext)='.MP3' then
      begin
        threadrunning:=true;
        //TempPic:=Form1.GetCDArtworkFromFile(utf8tosys(Liedjes[songchosen].Pad+Liedjes[songchosen].Bestandsnaam));
        TempPic:=Form1.GetCDArtworkFromFile(Liedjes[songchosen].Pad+Liedjes[songchosen].Bestandsnaam);
        threadrunning:=false;
        Form1.GetId3Extra(songchosen);
        ID3:=TID3v2.Create;
        if TempPic<>'x' then id3.SetCoverArt2(TempPic);
        ID3.GroupTitle:=Liedjes[songchosen].GroupTitel;
        ID3.Title:=Liedjes[songchosen].Titel;
        ID3.SubTitle:=Liedjes[songchosen].SubTitel;
        id3.Artist:=Liedjes[songchosen].Artiest;
        id3.Album:=Liedjes[songchosen].CD;
        id3.Year:=Liedjes[songchosen].Jaartal;
        id3.Comment:=Liedjes[songchosen].Comment;
        id3.Composer:=Liedjes[songchosen].Composer;
        id3.OriginalArtist:=Liedjes[songchosen].OrigArtiest;
        id3.OriginalTitle:=Liedjes[songchosen].OrigTitle;
        id3.OriginalYear:=Liedjes[songchosen].OrigYear;
        id3.Copyright:=Liedjes[songchosen].Copyright;
        id3.Genre:=Liedjes[songchosen].Genre;
        id3.Track:=Liedjes[songchosen].Track;
        id3.Encoder:=Liedjes[songchosen].Encoder;
        id3.Software:=Liedjes[songchosen].Software;
        id3.orchestra:=Liedjes[songchosen].Orchestra;
        id3.conductor:=Liedjes[songchosen].Conductor;
        id3.interpreted:=Liedjes[songchosen].Interpreted;
        id3.Link:=id3extra.link;
        id3.Lyric:=id3extra.lyric;
        //id3.savetofile(utf8tosys(Liedjes[songchosen].Pad+Liedjes[songchosen].Bestandsnaam));
        id3.savetofile(Liedjes[songchosen].Pad+Liedjes[songchosen].Bestandsnaam);
        ID3.Destroy;
      end;
     (* if Upcase(ext)='.OGG' then
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
          ID3OGG.Free;
        end;  *)
       if Upcase(ext)='.FLAC' then
        begin
          threadrunning:=true;
          TempPic:=Form1.GetCDArtworkFromFile(utf8tosys(Liedjes[songchosen].Pad+Liedjes[songchosen].Bestandsnaam));
          threadrunning:=false;
          id3Flac:=TFLACfile.Create;
          id3flac.SaveCDCover:=id3flac.SetCoverArt2(3,TempPic,500,500);
          id3flac.Title:=Liedjes[songchosen].Titel;
          id3flac.GroupTitle:=Liedjes[songchosen].Titel;
          id3flac.SubTitle:=Liedjes[songchosen].Titel;
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
          id3flac.orchestra:=Liedjes[songchosen].Orchestra;
          id3flac.conductor:=Liedjes[songchosen].Conductor;
          id3flac.interpreted:=Liedjes[songchosen].Interpreted;
          id3flac.idVendor:=id3extra.id;
          id3flac.Lyrics:=id3extra.lyric;
          //id3flac.SaveToFile(utf8tosys(Liedjes[songchosen].Pad+Liedjes[songchosen].Bestandsnaam), false);
          id3flac.SaveToFile(Liedjes[songchosen].Pad+Liedjes[songchosen].Bestandsnaam, false);
          id3flac.free;
        end;
       if (Upcase(ext)<>'.MP3') and (Upcase(ext)<>'.OGG') and (Upcase(ext)<>'.FLAC') and (Upcase(ext)<>'.APE') and (Upcase(ext)<>'.OPUS') then showmessage(Form1.Vertaal('Changing ID3 tags only for MP3, FLAC, APE and OGG files'));
    end;
    Form1.UpdateArtistGrids(songchosen);
  end;
  Close;
end;

procedure TFormRenameSong.FormShow(Sender: TObject);
var ext: string;
begin
  Image1.Picture.Bitmap:=Form1.Image9.Picture.Bitmap;
  ext:=upcase(ExtractFileExt(Liedjes[songchosen].Bestandsnaam));
  SB_RevertClick(Self);
  FormRenameSong.Caption:=Form1.Vertaal('Rename File');
  LB_File.Caption:=Form1.Vertaal('New Filename')+':';
  LB_Artist.Caption:=Form1.Vertaal('Artist')+':';
  LB_Title.Caption:=Form1.Vertaal('Title')+':';
  LB_Album.Caption:=Form1.Vertaal('Album')+':';
  LB_Year.Caption:=Form1.Vertaal('Year')+':';
  LB_Genre.Caption:=Form1.Vertaal('Genre')+':';
  LB_Comment.Caption:=Form1.Vertaal('Comment')+':';
  LB_Composer.Caption:=Form1.Vertaal('Composer')+':';
  LB_Copyright.Caption:=Form1.Vertaal('Copyright')+':';
  LB_OrigArtist.Caption:=Form1.Vertaal('Original artist')+':';
  CB_id3.Caption:=Form1.Vertaal('Save database information as ID3-Tag');
  SB_Revert.Caption:=Form1.Vertaal('Revert');
  SB_Cancel.Caption:=Form1.Vertaal('Cancel');
  SB_Save.Caption:=Form1.Vertaal('Save');
  LB_DBInfo.Caption:=Form1.Vertaal('Database Information')+':';
  If CB_Genre.Items.Count<2 then  CB_Genre.Items.AddStrings(Form1.CB_Genre.Items);

  if (ext<>'.MP3') and (ext<>'.OGG') and (ext<>'.FLAC') and (ext<>'.APE') and (ext<>'.OPUS') then
  begin
    CB_ID3.Checked:=false;
    CB_ID3.Enabled:=false;
  end
  else
  begin
    CB_ID3.Checked:=true;
    CB_ID3.Enabled:=true;
  end;
  {$IFDEF LINUX}
    //BUG IN GTK2
    CB_id3.Font.Size:=9; CB_id3.Font.Color:=clHighlightText;
    //SE_Track.Height:=26;
  {$ENDIF}
end;

end.

