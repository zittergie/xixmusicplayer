unit ripcd;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  StdCtrls, Buttons, ComCtrls, Grids, Menus, Process;

type

  { TFormRip }

  TFormRip = class(TForm)
    CB_Various: TCheckBox;
    CB_NoFade: TCheckBox;
    CheckBox1: TCheckBox;
    CB_CopyCDCover: TCheckBox;
    CB_Include: TCheckBox;
    CB_MakePDF: TCheckBox;
    CB_Encoder: TComboBox;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Edit4: TEdit;
    EditRipArtist: TEdit;
    EditRipVarious: TEdit;
    Image1: TImage;
    Image2: TImage;
    LB_Selection1: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    LB_Album: TLabel;
    LB_Released: TLabel;
    LB_Year: TLabel;
    LB_Genre2: TLabel;
    LB_Genre: TLabel;
    Label18: TLabel;
    LB_cddb: TLabel;
    LB_Encodewith: TLabel;
    Label26: TLabel;
    Label27: TLabel;
    Label3: TLabel;
    LB_Artist: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    MI_NewCDCover: TMenuItem;
    MI_FillComment: TMenuItem;
    MI_FillOrigArtist: TMenuItem;
    MenuItem2: TMenuItem;
    MI_ClearCover: TMenuItem;
    MI_FillArtist: TMenuItem;
    MI_FillAlbum: TMenuItem;
    MI_FillYear: TMenuItem;
    MI_FillGenre: TMenuItem;
    MI_FillComposer: TMenuItem;
    MI_FillCopyRight: TMenuItem;
    OpenDialog1: TOpenDialog;
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    PopupMenu1: TPopupMenu;
    PopupMenu2: TPopupMenu;
    ProgressBarTracks: TProgressBar;
    ProgressBarRip: TProgressBar;
    RB_Artist: TRadioButton;
    RB_Varia: TRadioButton;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    SpeedButton3: TSpeedButton;
    SpeedButton4: TSpeedButton;
    SB_SearchCDCover: TSpeedButton;
    StringGrid1: TStringGrid;
    procedure CB_EncoderChange(Sender: TObject);
    procedure CB_EncoderSelect(Sender: TObject);
    procedure Edit1EditingDone(Sender: TObject);
    procedure Edit1KeyPress(Sender: TObject; var Key: char);
    procedure Edit2EditingDone(Sender: TObject);
    procedure Edit2KeyPress(Sender: TObject; var Key: char);
    procedure Edit3EditingDone(Sender: TObject);
    procedure Edit3KeyPress(Sender: TObject; var Key: char);
    procedure Edit4EditingDone(Sender: TObject);
    procedure Edit4KeyPress(Sender: TObject; var Key: char);
    procedure FormShow(Sender: TObject);
    procedure Image2Click(Sender: TObject);
    procedure LB_AlbumClick(Sender: TObject);
    procedure LB_ArtistClick(Sender: TObject);
    procedure LB_GenreClick(Sender: TObject);
    procedure LB_YearClick(Sender: TObject);
    procedure MI_FillCommentClick(Sender: TObject);
    procedure MI_FillOrigArtistClick(Sender: TObject);
    procedure MI_ClearCoverClick(Sender: TObject);
    procedure MI_FillArtistClick(Sender: TObject);
    procedure MI_FillAlbumClick(Sender: TObject);
    procedure MI_FillYearClick(Sender: TObject);
    procedure MI_FillGenreClick(Sender: TObject);
    procedure MI_FillComposerClick(Sender: TObject);
    procedure MI_FillCopyRightClick(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);
    procedure SpeedButton4Click(Sender: TObject);
    procedure SB_SearchCDCoverClick(Sender: TObject);
    procedure StringGrid1ButtonClick(Sender: TObject; aCol, aRow: Integer);
    procedure StringGrid1EditingDone(Sender: TObject);
    procedure StringGrid1HeaderClick(Sender: TObject; IsColumn: Boolean;
      Index: Integer);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  FormRip: TFormRip;
    format1, format2: String;

implementation

uses Hoofd, fillincd, configuration, songdetails;

{$R *.lfm}

{ TFormRip }

procedure TFormRip.SpeedButton1Click(Sender: TObject);
begin
  Edit1.Visible:=False; Edit2.Visible:=False; Edit3.Visible:=False;
  Close;
end;

procedure TFormRip.SpeedButton2Click(Sender: TObject);
var i,i2: byte;
begin
  CancelRip:=False; OverwriteAllRip:=False;
  If CB_Encoder.ItemIndex=0 then
    if not fileexists(Settings.Lame) then
    begin
        FormConfig.PageControl1.ActivePageIndex:=7;
        FormConfig.Label29Click(Self);
        FormConfig.ShowModal;
        exit;
    end;
  If CB_Encoder.ItemIndex=1 then
    if not fileexists(Settings.Flac) then
    begin
      FormConfig.PageControl1.ActivePageIndex:=7;
      FormConfig.Label32Click(Self);
      FormConfig.ShowModal;
      exit;
    end;
  If CB_Encoder.ItemIndex=0 then

  If (status_cd=2) and (CB_Encoder.ItemIndex=1) then
  begin
    ShowMessage('DVD can not be ripped to FLAC yet. Please select LAME');
    exit;
  end;

  Edit1.Visible:=False; Edit2.Visible:=False; Edit3.Visible:=False;
  FormRip.Color:=clGray;
  if stream=5 then Form1.SB_StopClick(self);
  Application.ProcessMessages;
  Settings.EncodingFilenameFormatSingle:=EditRipArtist.Text;
  Settings.EncodingFilenameFormatCompilation:=EditRipVarious.Text;
  i2:=0;

  Cursor:=CrHourglass; Application.ProcessMessages;
  {$if defined(WINDOWS) or defined(UNIX)}
  FormRip.Enabled:=false;  Form1.Enabled:=false;
  {$IFEND}
  For i:=1 to Stringgrid1.RowCount-1 do If Stringgrid1.Cells[0,i]='1' then inc(i2);
  ProgressBarTracks.Max:=i2; Application.ProcessMessages;
  if RB_Varia.Checked then RipOptiesCompilation:=true
                      else ripoptiesCompilation:=false;
  For i:=1 to Stringgrid1.RowCount-1 do
     If Stringgrid1.Cells[0,i]='1' then
     begin
       CD[i].artiest:=Stringgrid1.Cells[2,i];
       CD[i].Titel:=Stringgrid1.Cells[3,i];
       CD[i].Album:=Stringgrid1.Cells[4,i];
       CD[i].Composer:=Stringgrid1.Cells[7,i];
       CD[i].copyright:=Stringgrid1.Cells[9,i];
       CD[i].original:=Stringgrid1.Cells[8,i];
       CD[i].comment:=Stringgrid1.Cells[10,i];
       if length(Stringgrid1.Cells[5,i])>0 then CD[i].jaartal:=Stringgrid1.Cells[5,i];
       if length(Stringgrid1.Cells[6,i])>0 then CD[i].genre:=Stringgrid1.Cells[6,i];

       dec(i2);

       Stringgrid1.Row:=i;
       Application.ProcessMessages;
       try
       if status_cd=1 then Form1.RipTrack(i-1)
                      else Form1.RipDVDTrack(i-1);
       if CancelRip then
       begin
         FormRip.Color:=clDefault;
         Cursor:=CrDefault;
         {$if defined(WINDOWS) or defined(UNIX)}
           FormRip.Enabled:=True;
           Form1.Enabled:=True;
         {$IFEND}
         Break;
       end;
       StringGrid1.Cells[0,i]:='2';
       finally
       end;
       ProgressBarTracks.Position:=ProgressBarTracks.Max-i2;
     end;

 {$if defined(WINDOWS) or defined(UNIX)}
  Sleep(150);
  FormRip.Enabled:=True;
  Form1.Enabled:=True;
 {$IFEND}

  FormRip.Color:=clDefault;
  Cursor:=CrDefault;
  if not CancelRip then Close;
end;

procedure TFormRip.SpeedButton3Click(Sender: TObject);
begin
    EditRipArtist.Text:=format1;
end;

procedure TFormRip.SpeedButton4Click(Sender: TObject);
begin
    EditRipVarious.Text:=format2;
end;

procedure TFormRip.SB_SearchCDCoverClick(Sender: TObject);
begin
  ShowMessage('Not Yet Functional');
end;

procedure TFormRip.StringGrid1ButtonClick(Sender: TObject; aCol, aRow: Integer);
begin
end;

procedure TFormRip.StringGrid1EditingDone(Sender: TObject);
begin
  Stringgrid1.AutoSizeColumns;
end;

procedure TFormRip.StringGrid1HeaderClick(Sender: TObject; IsColumn: Boolean;
  Index: Integer);
begin
   if not iscolumn then
  begin
     if index>0 then if Stringgrid1.Cells[0,index]=' V' then Stringgrid1.Cells[0,index]:=' '
                                              else Stringgrid1.Cells[0,index]:=' V';
  end;
end;


procedure TFormRip.FormShow(Sender: TObject);
var i: byte;
    lijn: string;
begin
  Image1.Picture.Bitmap:=Form1.Image9.Picture.Bitmap;
  lijn:=Form1.ConvertArtist(LB_Artist.Caption,true)+'-'+Form1.ConvertAlbum(LB_Album.Caption);
  if fileexists(Configdir+Directoryseparator+'cache'+DirectorySeparator+lijn+'.jpg')
     then begin
            Image2.Picture.LoadFromFile(Configdir+Directoryseparator+'cache'+DirectorySeparator+lijn+'.jpg');
            CB_CopyCDCover.Enabled:=True;
          end
     else begin
            Image2.Picture.Bitmap:=FormDetails.Image2.Picture.Bitmap;
            CB_CopyCDCover.Checked:=False; CB_CopyCDCover.Enabled:=False;
          end;
  LB_Selection1.Caption:=Form1.Vertaal('Selection')+':';
  RB_Artist.Caption:=Form1.Vertaal('Rip to artist folder')+':';
  RB_Varia.Caption:=Form1.Vertaal('Rip to various folder')+':';
  Speedbutton2.Caption:=Form1.Vertaal('Rip');
  SpeedButton1.Caption:=Form1.Vertaal('Cancel');
  Label9.Caption:=': '+Form1.Vertaal('Artist');
  Label10.Caption:=': '+Form1.Vertaal('Title');
  Label11.Caption:=': '+Form1.Vertaal('Title Album');
  Label12.Caption:=': '+Form1.Vertaal('Track Number');
  Label27.Caption:=': '+Form1.Vertaal('First letter of the Artist');
  SB_SearchCDCover.Caption:=Form1.Vertaal('Search for CD Cover');
  Stringgrid1.Columns.Items[0].Title.Caption:=Form1.Vertaal('Rip');
  StringGrid1.Columns.Items[0].ButtonStyle:=cbsCheckboxColumn;
  Stringgrid1.Columns.Items[1].Title.Caption:=Form1.Vertaal('Track'); ;
  Stringgrid1.Columns.Items[2].Title.Caption:=Form1.Vertaal('Artist'); ;
  Stringgrid1.Columns.Items[3].Title.Caption:=Form1.Vertaal('Title'); ;
  Stringgrid1.Columns.Items[4].Title.Caption:=Form1.Vertaal('Album'); ;
  Stringgrid1.Columns.Items[5].Title.Caption:=Form1.Vertaal('Year'); ;
  Stringgrid1.Columns.Items[6].Title.Caption:=Form1.Vertaal('Genre'); ;
  Stringgrid1.Columns.Items[7].Title.Caption:=Form1.Vertaal('Composer'); ;
  Stringgrid1.Columns.Items[8].Title.Caption:=Form1.Vertaal('Original Artist'); ;
  Stringgrid1.Columns.Items[9].Title.Caption:=Form1.Vertaal('Copyright'); ;
  Stringgrid1.Columns.Items[10].Title.Caption:=Form1.Vertaal('Comment'); ;
  CB_CopyCDCover.Caption:=Form1.Vertaal('Copy CD Cover to Music Folder');
  CB_Include.Caption:=Form1.Vertaal('Include CD Cover in ID3 Tag');
  LB_Released.Caption:=Form1.Vertaal('Released')+':';
  LB_Genre2.Caption:=Form1.Vertaal('Genre')+':';
  CB_Various.Caption:=Form1.Vertaal('Various artists');
  CB_NoFade.Caption:=Form1.Vertaal('Set NO FADE');
  LB_Encodewith.Caption:=Form1.Vertaal('Encode with');
  CB_MakePDF.Caption:=Form1.Vertaal('Make PDF booklet');
  MI_ClearCover.Caption:=Form1.Vertaal('Clear CD Cover');
  MI_NewCDCover.Caption:=Form1.Vertaal('Load new CD Cover');
  MI_FillArtist.Caption:=Form1.Vertaal('Fill in Artist');
  MI_FillAlbum.Caption:=Form1.Vertaal('Fill in Album');
  MI_FillYear.Caption:=Form1.Vertaal('Fill in Year');
  MI_FillGenre.Caption:=Form1.Vertaal('Fill in Genre');
  MI_FillComposer.Caption:=Form1.Vertaal('Fill in Composer');
  MI_FillOrigArtist.Caption:=Form1.Vertaal('Fill in Original Artist');
  MI_FillCopyright.Caption:=Form1.Vertaal('Fill in Copyright');
  MI_FillComment.Caption:=Form1.Vertaal('Fill in Comment');

  ProgressBarTracks.Position:=0;
  EditRipArtist.Text:=Settings.EncodingFilenameFormatSingle; format1:=Settings.EncodingFilenameFormatSingle;
  EditRipVarious.Text:=Settings.EncodingFilenameFormatCompilation; format2:=Settings.EncodingFilenameFormatCompilation;
  Stringgrid1.RowCount:=Form1.stringgridcd.RowCount;
  for i:=1 to form1.stringgridcd.RowCount-1 do
  begin
   if Form1.StringGridCD.Cells[4,i]='00:00' then Stringgrid1.Cells[0,i]:='0'
                                            else Stringgrid1.Cells[0,i]:='1';
   Stringgrid1.Cells[1,i]:=form1.stringgridcd.Cells[0,i];
   Stringgrid1.Cells[2,i]:=form1.stringgridcd.Cells[1,i];
   Stringgrid1.Cells[3,i]:=form1.stringgridcd.Cells[2,i];
   Stringgrid1.Cells[4,i]:=form1.stringgridcd.Cells[3,i];
   Stringgrid1.Cells[5,i]:=form1.stringgridcd.Cells[5,i];
   Stringgrid1.Cells[6,i]:=form1.stringgridcd.Cells[6,i];
   Stringgrid1.Cells[7,i]:='';
   Stringgrid1.Cells[8,i]:=''; Stringgrid1.Cells[9,i]:='';
  end;
  Stringgrid1.AutoSizeColumns;
  ProgressBarTracks.Max:=Stringgrid1.RowCount-1;
  CB_Encoder.ItemIndex:=Settings.Encoder;
  CB_EncoderSelect(Self);
end;

procedure TFormRip.Image2Click(Sender: TObject);
begin
  if OpenDialog1.Execute then
  begin
    Image2.Picture.LoadFromFile(OpenDialog1.FileName);
    CB_CopyCDCover.Enabled:=True; CB_CopyCDCover.Checked:=True;
  end;
end;

procedure TFormRip.LB_AlbumClick(Sender: TObject);
begin
  Edit2.Text:=LB_Album.Caption;
  Edit2.Visible:=True;
  Application.ProcessMessages;
  Edit2.SetFocus;
end;

procedure TFormRip.LB_ArtistClick(Sender: TObject);
begin
  Edit1.Text:=LB_Artist.Caption;
  Edit1.Visible:=True;
  Application.ProcessMessages;
  Edit1.SetFocus;
end;

procedure TFormRip.LB_GenreClick(Sender: TObject);
begin
  Edit3.Text:=LB_Genre.Caption;
  Edit3.Visible:=true;
  Application.ProcessMessages;
  Edit3.SetFocus;
end;

procedure TFormRip.LB_YearClick(Sender: TObject);
begin
  Edit4.Text:=LB_Year.Caption;
  Edit4.Visible:=True;
  Application.ProcessMessages;
  Edit4.SetFocus;
end;

procedure TFormRip.MI_FillCommentClick(Sender: TObject);
begin
  FormFillInCD.Label1.Caption:='Comment:';
  FormFillInCD.Edit1.Visible:=true;
  FormFillInCD.MaskEdit1.Visible:=false;
  FormFillInCD.ComboBox1.Visible:=false;
  FormFillInCD.Edit1.Text:=StringGrid1.Cells[10,1];
  FormFillInCD.Showmodal;
  Stringgrid1.AutoSizeColumns;
end;

procedure TFormRip.MI_FillOrigArtistClick(Sender: TObject);
begin
  FormFillInCD.Label1.Caption:='Original Artist:';
  FormFillInCD.Edit1.Visible:=true;
  FormFillInCD.MaskEdit1.Visible:=false;
  FormFillInCD.ComboBox1.Visible:=false;
  FormFillInCD.Edit1.Text:=StringGrid1.Cells[8,1];
  FormFillInCD.Showmodal;
  Stringgrid1.AutoSizeColumns;
end;

procedure TFormRip.MI_ClearCoverClick(Sender: TObject);
begin
  Image2.Picture.Bitmap:=FormDetails.Image2.Picture.Bitmap;
  CB_CopyCDCover.Checked:=false; CB_CopyCDCover.Enabled:=False;
end;

procedure TFormRip.MI_FillArtistClick(Sender: TObject);
begin
  Form1.MenuItem44Click(self);
  Stringgrid1.AutoSizeColumns;
end;

procedure TFormRip.MI_FillAlbumClick(Sender: TObject);
begin
  Form1.MenuItem50Click(self);
  Stringgrid1.AutoSizeColumns;
end;

procedure TFormRip.MI_FillYearClick(Sender: TObject);
begin
   Form1.MenuItem52Click(self);
  Stringgrid1.AutoSizeColumns;
end;

procedure TFormRip.MI_FillGenreClick(Sender: TObject);
begin
   Form1.MenuItem53Click(self);
  Stringgrid1.AutoSizeColumns;
end;

procedure TFormRip.MI_FillComposerClick(Sender: TObject);
begin
   FormFillInCD.Label1.Caption:='Composer:';
  FormFillInCD.Edit1.Visible:=true;
  FormFillInCD.MaskEdit1.Visible:=false;
  FormFillInCD.ComboBox1.Visible:=false;
  FormFillInCD.Edit1.Text:=StringGrid1.Cells[7,1];
  FormFillInCD.Showmodal;
  Stringgrid1.AutoSizeColumns;
end;

procedure TFormRip.MI_FillCopyRightClick(Sender: TObject);
begin
  FormFillInCD.Label1.Caption:='Copyright:';
  FormFillInCD.Edit1.Visible:=true;
  FormFillInCD.MaskEdit1.Visible:=false;
  FormFillInCD.ComboBox1.Visible:=false;
  FormFillInCD.Edit1.Text:=StringGrid1.Cells[9,1];
  FormFillInCD.Showmodal;
  Stringgrid1.AutoSizeColumns;
end;

procedure TFormRip.CB_EncoderSelect(Sender: TObject);
begin
  Case CB_Encoder.ItemIndex of
    0: begin
         Settings.Encoder:=0;
         Label3.caption:=Form1.Vertaal('This setting will encode to MP3');
       end;
    1: begin
         Settings.Encoder:=1;
         Label3.caption:=Form1.Vertaal('This setting will encode to FLAC');
       end;
    2: begin
         Settings.Encoder:=2;
         Label3.caption:=Form1.Vertaal('This setting will encode to OGG');
       end;
    3: begin
         Settings.Encoder:=3;
         Label3.caption:=Form1.Vertaal('This setting will encode to AAC (Under development)');
       end;
    4: begin
         Settings.Encoder:=4;
         Label3.caption:=Form1.Vertaal('This setting will encode to OPUS');
       end;
  end;
end;

procedure TFormRip.CB_EncoderChange(Sender: TObject);
begin
  Case CB_Encoder.ItemIndex of
    0, 4: CB_Include.Enabled:=True;
    else
      begin
        CB_Include.Enabled:=False;
        CB_Include.Checked:=False;
      end;
  end;
end;

procedure TFormRip.Edit1EditingDone(Sender: TObject);
var i: shortint;
begin
  LB_Artist.Caption:=Edit1.Text;
  Edit1.visible:=false;
  If not CB_Various.Checked then for i:=1 to Stringgrid1.RowCount-1 do Stringgrid1.Cells[2,i]:=LB_Artist.Caption;
  Stringgrid1.AutoSizeColumns;
end;

procedure TFormRip.Edit1KeyPress(Sender: TObject; var Key: char);
begin
  if key=#27 then
  begin
    Edit1.Text:=LB_Artist.Caption;
    Edit1.visible:=false;
  end;
end;

procedure TFormRip.Edit2EditingDone(Sender: TObject);
var i: shortint;
begin
  LB_Album.Caption:=Edit2.Text;
  Edit2.Visible:=False;
  for i:=1 to Stringgrid1.RowCount-1 do Stringgrid1.Cells[4,i]:=LB_Album.Caption;
  Stringgrid1.AutoSizeColumns;
end;

procedure TFormRip.Edit2KeyPress(Sender: TObject; var Key: char);
begin
    if key=#27 then
  begin
    Edit2.Text:=LB_Album.Caption;
    Edit2.visible:=false;
  end;
end;

procedure TFormRip.Edit3EditingDone(Sender: TObject);
var i: shortint;
begin
  LB_Genre.Caption:=Edit3.Text;
  Edit3.Visible:=False;
  for i:=1 to Stringgrid1.RowCount-1 do Stringgrid1.Cells[6,i]:=LB_Genre.Caption;
  Stringgrid1.AutoSizeColumns;
end;

procedure TFormRip.Edit3KeyPress(Sender: TObject; var Key: char);
begin
  if key=#27 then
  begin
    Edit3.Text:=LB_Genre.Caption;
    Edit3.visible:=false;
  end;
end;

procedure TFormRip.Edit4EditingDone(Sender: TObject);
var i: shortint;
begin
  LB_Year.Caption:=Edit4.Text;
  Edit4.Visible:=False;
  for i:=1 to Stringgrid1.RowCount-1 do Stringgrid1.Cells[5,i]:=LB_Year.Caption;
  Stringgrid1.AutoSizeColumns;
end;

procedure TFormRip.Edit4KeyPress(Sender: TObject; var Key: char);
begin
     if key=#27 then
  begin
    Edit4.Text:=LB_Year.Caption;
    Edit4.visible:=false;
  end;
end;

end.

