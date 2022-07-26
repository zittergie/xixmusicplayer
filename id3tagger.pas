unit id3tagger;

{$mode objfpc}{$H+}
//{$modeswitch nestedprocvars}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  ComCtrls, StdCtrls, Buttons, Menus, Grids, ActnList, {$if not defined(HAIKU)}bass,{$ifend} filltagfromfile,
  Process, StrUtils, LazUTF8, LazUTF8Classes, LazFileUtils;

type
  TTagItem = (
    taArtiest, taOrchestra, taConductor, taInterpreted, taGroupTitel, taTitel,
    taSubTitel, taTrack, taCD, taJaartal, taGenre, taEncoder,taComment,
    taComposer, taOrigArtiest, taOrigTitle, taOrigYear, taCopyright,
    taBestandsnaam, taPad,  taAantalTracks, taSoftware, taEQ, taEQSettings, taPreVolume,
    taFadeSettings, taBeoordeling, taaantalafspelen, taLyric
  );
  TTextOperation = (topChange, topClear, topAllCaps, topFirstCaps, topFirstAllCaps,
                    topRenumber, topAllLower);
  TLogStr = string[20];
  TItemAction = record
    Item: TTagItem;
    Log: TLogStr;
    Edit: TEdit;
  end;

  { TFormID3Tagger }

  TFormID3Tagger = class(TForm)
    actCapsAll: TAction;
    actCapsFirst: TAction;
    actCapsFirstEach: TAction;
    actCapsAllSelection: TAction;
    actCapsFirstSelection: TAction;
    actCapsFirstEachSelection: TAction;
    actClearSelection: TAction;
    actClear: TAction;
    actLowerAll: TAction;
    actRenumber: TAction;
    ActionList1: TActionList;
    Bevel2: TBevel;
    Bevel3: TBevel;
    Bevel4: TBevel;
    Bevel5: TBevel;
    Bevel6: TBevel;
    Button1: TButton;
    Button10: TButton;
    Button11: TButton;
    Button12: TButton;
    Button13: TButton;
    Button14: TButton;
    Button15: TButton;
    Button17: TButton;
    Button18: TButton;
    Button19: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    Button6: TButton;
    Button7: TButton;
    Button8: TButton;
    Button9: TButton;
    ButtonID3Selected_Pictures: TButton;
    CB_Album2: TCheckBox;
    CB_Artist2: TCheckBox;
    CB_Genre2: TCheckBox;
    CB_IncludeCDCover: TCheckBox;
    CB_IncludeLyric: TCheckBox;
    CB_Haiku_Attr: TCheckBox;
    CB_Artist1: TCheckBox;
    CB_Album1: TCheckBox;
    CB_Remark2: TCheckBox;
    CB_Title1: TCheckBox;
    CB_Title2: TCheckBox;
    CB_Track2: TCheckBox;
    CB_Year1: TCheckBox;
    CB_Track1: TCheckBox;
    CB_Genre1: TCheckBox;
    CB_Remark1: TCheckBox;
    CB_Year2: TCheckBox;
    Edit_Album: TEdit;
    Edit_AlbumCUE: TEdit;
    Edit_Artist: TEdit;
    Edit_Comment: TEdit;
    Edit_Composer: TEdit;
    Edit_Conductor: TEdit;
    Edit_Copyright: TEdit;
    Edit_Encoded: TEdit;
    Edit_File: TEdit;
    Edit_Genre: TEdit;
    Edit_GroupTitle: TEdit;
    Edit_Interpreted: TEdit;
    Edit_Orchestra: TEdit;
    Edit_OrigArtist: TEdit;
    Edit_OrigTitle: TEdit;
    Edit_OrigYear: TEdit;
    Edit_SubTitle: TEdit;
    Edit_title: TEdit;
    Edit_Track: TEdit;
    Edit_Year: TEdit;
    GB_Booklet: TGroupBox;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    GroupBoxFileInfo: TGroupBox;
    GroupBox3: TGroupBox;
    Image1: TImage;
    Image2: TImage;
    Label1: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label2: TLabel;
    Label21: TLabel;
    Label22: TLabel;
    Label23: TLabel;
    Label24: TLabel;
    Label27: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label_CUE: TLabel;
    LB_Album: TLabel;
    LB_Album2: TLabel;
    LB_Artist: TLabel;
    LB_Comment: TLabel;
    LB_Composer: TLabel;
    LB_Copyright: TLabel;
    LB_Encoded: TLabel;
    LB_Genre: TLabel;
    LB_MaskTagToFile: TLabel;
    LB_MaskFiletoTag: TLabel;
    Label28: TLabel;
    Label16: TLabel;
    LB_OrigArtist: TLabel;
    LB_Size: TLabel;
    LB_Title: TLabel;
    LB_Track: TLabel;
    LB_Year: TLabel;
    ListBox1: TListBox;
    Memo1: TMemo;
    Memo2: TMemo;
    MenuItem2: TMenuItem;
    MI_Select: TMenuItem;
    MI_ClearYear: TMenuItem;
    MI_ClearTrack: TMenuItem;
    MI_ClearGenre: TMenuItem;
    MI_ClearComment: TMenuItem;
    MI_ClearComposer: TMenuItem;
    MI_ClearOrigArtist: TMenuItem;
    MI_ClearCopyright: TMenuItem;
    MI_ClearURL: TMenuItem;
    MI_ClearEncoded: TMenuItem;
    MenuItem19: TMenuItem;
    MI_SelectAll: TMenuItem;
    MI_ClearAll: TMenuItem;
    MenuItem21: TMenuItem;
    MI_Import: TMenuItem;
    MI_Export: TMenuItem;
    MI_Actions: TMenuItem;
    MenuItem25: TMenuItem;
    MI_Rename: TMenuItem;
    MI_Fill: TMenuItem;
    MenuItem28: TMenuItem;
    MI_Save: TMenuItem;
    MI_InvertSelect: TMenuItem;
    MI_SelectNone: TMenuItem;
    MenuItem5: TMenuItem;
    MI_Clear: TMenuItem;
    MI_ClearTitle: TMenuItem;
    MI_ClearArtist: TMenuItem;
    MI_ClearAlbum: TMenuItem;
    OpenDialog1: TOpenDialog;
    PageControl1: TPageControl;
    PageControl2: TPageControl;
    PopupMenu1: TPopupMenu;
    PopupMenu2: TPopupMenu;
    ProgressBar1: TProgressBar;
    RadioGroup1: TRadioGroup;
    RadioGroup2: TRadioGroup;
    SaveDialog1: TSaveDialog;
    SB_ClearPicture: TSpeedButton;
    SB_Empty_Lyric: TSpeedButton;
    SB_HelpCUE: TSpeedButton;
    SB_MakeBooklet: TSpeedButton;
    SB_OnlineCDCover: TSpeedButton;
    SB_OpenCUE: TSpeedButton;
    SB_OpenLyric: TSpeedButton;
    SB_PlayFromCue: TSpeedButton;
    SB_Reload1: TSpeedButton;
    SB_ReloadLyric: TSpeedButton;
    SB_ReloadLyric1: TSpeedButton;
    SB_ReloadLyricFromTag: TSpeedButton;
    SB_SaveAsLyric: TSpeedButton;
    SB_SaveCUE: TSpeedButton;
    SB_SaveLyricLocalStorage: TSpeedButton;
    SB_SavePictureAs: TSpeedButton;
    SB_SearchCDCover: TSpeedButton;
    SB_Stop: TSpeedButton;
    SB_ActionDialog: TSpeedButton;
    SB_FileToTag: TSpeedButton;
    SB_Stop2: TSpeedButton;
    SB_TagToFile: TSpeedButton;
    SB_Play: TSpeedButton;
    SB_Save: TSpeedButton;
    ScrollBox1: TScrollBox;
    Shape1: TShape;
    SpeedButton1: TSpeedButton;
    SpeedButton11: TSpeedButton;
    SpeedButton2: TSpeedButton;
    SpeedButton3: TSpeedButton;
    SpeedButton4: TSpeedButton;
    SpeedButton5: TSpeedButton;
    SpeedButton8: TSpeedButton;
    SpeedButton9: TSpeedButton;
    Splitter1: TSplitter;
    Splitter2: TSplitter;
    StatusBar1: TStatusBar;
    Browser: TTabSheet;
    Selected: TTabSheet;
    StringGridCue: TStringGrid;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
    TabSheet4: TTabSheet;
    TabSheet5: TTabSheet;
    TabSheet6: TTabSheet;
    procedure actCapsAllExecute(Sender: TObject);
    procedure actLowerAllExecute(Sender: TObject);
    procedure Button12Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button9Click(Sender: TObject);
    procedure ButtonID3Selected_PicturesClick(Sender: TObject);
    procedure CB_IncludeCDCoverChange(Sender: TObject);
    procedure CB_IncludeCDCoverClick(Sender: TObject);
    procedure CB_IncludeCDCoverEditingDone(Sender: TObject);
    procedure CB_IncludeLyricChange(Sender: TObject);
    procedure CB_IncludeLyricClick(Sender: TObject);
    procedure Edit_FileEditingDone(Sender: TObject);
    procedure Edit_GroupTitleContextPopup(Sender: TObject; MousePos: TPoint;
      var Handled: Boolean);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCloseQuery(Sender: TObject; var CanClose: boolean);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Image2Click(Sender: TObject);
    procedure ListBox1Click(Sender: TObject);
    procedure ListBox1SelectionChange(Sender: TObject; User: boolean);
    procedure Memo2Change(Sender: TObject);
    procedure MI_ClearAllClick(Sender: TObject);
    procedure MI_ImportClick(Sender: TObject);
    procedure MI_ExportClick(Sender: TObject);
    procedure MI_RenameClick(Sender: TObject);
    procedure MI_FillClick(Sender: TObject);
    procedure MI_SaveClick(Sender: TObject);
    procedure MI_SelectAllClick(Sender: TObject);
    procedure MI_InvertSelectClick(Sender: TObject);
    procedure MI_SelectNoneClick(Sender: TObject);
    procedure SB_Empty_LyricClick(Sender: TObject);
    procedure SB_FileToTagClick(Sender: TObject);
    procedure SB_OpenCUEClick(Sender: TObject);
    procedure SB_OpenLyricClick(Sender: TObject);
    procedure SB_ReloadLyric1Click(Sender: TObject);
    procedure SB_ReloadLyricClick(Sender: TObject);
    procedure SB_SaveAsLyricClick(Sender: TObject);
    procedure SB_SaveCUEClick(Sender: TObject);
    procedure SB_SaveLyricLocalStorageClick(Sender: TObject);
    procedure SB_StopClick(Sender: TObject);
    procedure SB_TagToFileClick(Sender: TObject);
    procedure SB_PlayFromCueClick(Sender: TObject);
    procedure SpeedButton11Click(Sender: TObject);
    procedure SB_Stop2Click(Sender: TObject);
    procedure SB_SearchCDCoverClick(Sender: TObject);
    procedure SpeedButton13MouseEnter(Sender: TObject);
    procedure SpeedButton13MouseLeave(Sender: TObject);
    procedure SB_OnlineCDCoverClick(Sender: TObject);
    procedure SB_ActionDialogClick(Sender: TObject);
    procedure SB_PlayClick(Sender: TObject);
    procedure SB_Reload1Click(Sender: TObject);
    procedure SB_SavePictureAsClick(Sender: TObject);
    procedure SB_ClearPictureClick(Sender: TObject);
    procedure SB_ReloadLyricFromTagClick(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);
    procedure SpeedButton4Click(Sender: TObject);
    procedure SpeedButton5Click(Sender: TObject);
    procedure SpeedButton8Click(Sender: TObject);
    procedure SpeedButton9Click(Sender: TObject);
    procedure TextClear(Sender: TObject);
    procedure TextCopy(Sender: TObject);
    procedure TextCut(Sender: TObject);
    procedure TextPaste(Sender: TObject);
  private
    { private declarations }
    fActions: array of TItemAction;
    fIgnoreWords: TStringList;
    fSearchWords,fReplaceWords: TStringList;
    fLastChangedEdit: TEdit;
    fCurrentTrack: Integer;
    procedure TaggerListbox1Clicked(Sender: TObject; var Done: Boolean);
    procedure ModifyTagAll(Act:Integer; oper: TTextOperation);
    procedure ModifyTag(Song, Act: Integer; oper: TTextOperation);
    procedure ClearAllTag(Act: Integer);
    procedure RegisterControlAction(Item: TTagItem; Edit: TEdit; Btn: TButton;
        Mnu:TMenuItem; LogMsg: TLogStr);
    procedure EditorAction(Sender: TObject);
    procedure EditorChanged(Sender: TObject);
    procedure CommitEditorPendingChanges;
  public
    procedure ReloadCueSheet;
    procedure ReloadLyrics;
    procedure ReloadLyricsFromLocalStorage;
    procedure ReloadLyricsFromTag;
    procedure ReloadCurrentSongTags;
    procedure SaveLyricsToLocalStorage;
    procedure SaveID3ToTags(i: integer);
    procedure GetHaikuTags(i: integer);
    procedure Log(fmt:string; args: array of const; ForceUpdate:boolean=false);
    { public declarations }
  end;

var
  FormID3Tagger: TFormID3Tagger;
  changedTag: Array of boolean;
  ChangedFileName: Array of Boolean;
  IncludeLyric: Array of Boolean;
  IncludeID3Picture: Array of Boolean;
  IncludeID3PictureFile: TStringlist;
  index: longint;
  LyricChanged: Boolean;
  PictureChanged: Boolean;
  LastUsedFilename: String;

implementation

uses hoofd, ID3v2, APEtag, FLACfile, (*OggVorbis,*) showmydialog, OggVorbisAndOpusTagLibrary;

const
  TagNames: array[taArtiest..taCopyright] of string =
    ('Artist', 'Orchestra', 'Conductor', 'Interpreter / Remixer', 'Group Title',
     'Title', 'Sub Title', 'Track', 'Album', 'Year', 'Genre', 'Encoded by',
     'Comment', 'Composer', 'Orig. Artist', 'Orig. Title', 'Year', 'Copyright');

{$R *.lfm}

{ TFormID3Tagger }

procedure TFormID3Tagger.FormShow(Sender: TObject);
var i: longint;
    s: string;
    aLista, aFields: TStringListUTF8;

    //procedure NewRecord(aList: TStringlist);
    //begin
    //  if aList.Count=2 then
    //  begin
    //    fSearchWords.Add(aList[0]);
    //    fReplaceWords.Add(aList[1]);
    //  end;
    //end;

begin
  {$if not defined(HAIKU)}
    TabSheet6.Visible:=false;
  {$else}
    Tabsheet6.Visible:=true;
  {$ifend}

  Setlength(changedTag,  ListBox1.Items.Count+1); index:=-1;
  Setlength(changedFilename,  ListBox1.Items.Count+1);
  Setlength(IncludeLyric,  Listbox1.Items.Count+1);
  Setlength(IncludeID3Picture,  Listbox1.Items.Count+1);
  IncludeID3PictureFile:=TStringlist.Create;

  LyricChanged:=false;
  for i:=0 to ListBox1.Items.Count-1 do
  begin
    changedTag[i]:=false;
    changedFilename[i]:=false;
    IncludeLyric[i]:=Settings.SaveLyricsInID3Tag;
    IncludeLyric[i]:=false;
    IncludeID3PictureFile.Add(' ');
  end;
  Image1.Picture.Bitmap:=Form1.Image9.Picture.Bitmap;
  ListBox1.ItemIndex:=0; index:=5;
  Listbox1.Selected[0]:=true; ListBox1Click(Self);
  LB_MaskFileToTag.caption:=Settings.MaskToTag;
  LB_MaskTagToFile.Caption:=Settings.MaskToFile;

  GroupBoxFileInfo.Caption:=Form1.Vertaal('File information')+':';
  LB_Size.Caption:=Form1.Vertaal('Filesize')+':';
  LB_Title.Caption:=Form1.Vertaal('Title')+':';
  LB_Artist.Caption:=Form1.Vertaal('Artist')+':';
  LB_Album.Caption:=Form1.Vertaal('Album')+':';
  LB_Album2.Caption:=LB_Album.Caption;
  LB_Track.Caption:=Form1.Vertaal('Track')+' #';
  LB_Year.Caption:=Form1.Vertaal('Year')+':';
  LB_Comment.Caption:=Form1.Vertaal('Comment')+':';
  LB_Composer.Caption:=Form1.Vertaal('Composer')+':';
  LB_OrigArtist.Caption:=Form1.Vertaal('Orig. Artist')+':';
  LB_Copyright.Caption:=Form1.Vertaal('Copyright')+':';
  LB_Encoded.Caption:=Form1.Vertaal('Encoded')+':';
  SB_Reload1.Caption:=Form1.Vertaal('Reload ID3 information');

  CB_IncludeCDCover.Caption:=Form1.Vertaal('CD Cover')+':';
  SB_SearchCDCover.Caption:=Form1.Vertaal('Search for CD Cover');
  SB_OnlineCDCover.Caption:=Form1.Vertaal('Search Online for CD Cover');

  Selected.Caption:=Form1.Vertaal('Selected');
  Browser.Caption:=Form1.Vertaal('Browser');

  StringGridCue.Cells[1,0]:=Form1.Vertaal('Artist');
  StringGridCue.Cells[2,0]:=Form1.Vertaal('Title');
  StringGridCue.Cells[3,0]:=Form1.Vertaal('Time');

  CB_IncludeLyric.Caption:=Form1.Vertaal('Include Lyric in ID3 Tag');

  MI_Select.Caption:=Form1.Vertaal('Select');
  MI_SelectAll.Caption:=Form1.Vertaal('Select All');
  MI_SelectNone.Caption:=Form1.Vertaal('Select None');
  MI_InvertSelect.Caption:=Form1.Vertaal('Invert Selection');
  MI_Clear.Caption:=Form1.Vertaal('Clear');
  MI_ClearTitle.Caption:=Form1.Vertaal('Clear Title');
  MI_ClearArtist.Caption:=Form1.Vertaal('Clear Artist');
  MI_ClearAlbum.Caption:=Form1.Vertaal('Clear Album');
  MI_ClearYear.Caption:=Form1.Vertaal('Clear Year');
  MI_ClearTrack.Caption:=Form1.Vertaal('Clear Track #');
  MI_ClearGenre.Caption:=Form1.Vertaal('Clear Genre');
  MI_ClearComment.Caption:=Form1.Vertaal('Clear Comment');
  MI_ClearComposer.Caption:=Form1.Vertaal('Clear Composer');
  MI_ClearOrigArtist.Caption:=Form1.Vertaal('Clear Original Artist');
  MI_ClearCopyright.Caption:=Form1.Vertaal('Clear Copyright');
  MI_ClearURL.Caption:=Form1.Vertaal('Clear URL');
  MI_Clearencoded.Caption:=Form1.Vertaal('Clear Encoded');
  MI_ClearAll.Caption:=Form1.Vertaal('Clear All');
  MI_Actions.Caption:=Form1.Vertaal('Actions');
  MI_Fill.Caption:=Form1.Vertaal('Fill in ID3 Tag information from Filename');
  MI_Rename.Caption:=Form1.Vertaal('Rename File from ID3 Tag information');
  MI_Import.Caption:=Form1.Vertaal('Import ID3 Tag information');
  MI_Export.Caption:=Form1.Vertaal('Export ID3 Tag information');
  MI_Save.Caption:=Form1.Vertaal('Save');

  SB_Play.Hint:=Form1.Vertaal('Listen to selected song');
  SB_Stop.Hint:=Form1.Vertaal('Stop Playback');
  SB_Stop2.Hint:=SB_Stop.Hint;
  SB_Save.Hint:=Form1.Vertaal('Save all changes');
  SB_ActionDialog.Hint:=Form1.Vertaal('Show RENAME/TAG action dialog');
  SB_FileToTag.Hint:=Form1.Vertaal('Perform ID3-Tagging: Fill in Tags from Filename');
  SB_TagToFile.Hint:=Form1.Vertaal('Perform Rename Files from ID3-tags');
  SB_SavePictureAs.Hint:=Form1.Vertaal('Save Picture As')+' ...';
  SB_ClearPicture.Hint:=Form1.Vertaal('Clear CD Cover');
  SB_OpenCUE.Hint:=Form1.Vertaal('Open CUE Sheet');
  SB_SaveCUE.Hint:=Form1.Vertaal('Save CUE Sheet');
  SB_PlayFromCue.Hint:=Form1.Vertaal('Play Song from CUE point selected');
  SB_OpenLyric.Hint:=Form1.Vertaal('Open Lyric');
  SB_SaveLyricLocalStorage.Hint:=Form1.Vertaal('Save Lyric');
  SB_SaveAsLyric.Hint:=Form1.Vertaal('Save Lyric as')+' ...';
  SB_ReloadLyric1.Hint:=Form1.Vertaal('Reload Lyric from the Internet');
  SB_ReloadLyric.Hint:=Form1.Vertaal('Reload Lyric');
  GB_Booklet.Caption:=Form1.Vertaal('Create A Booklet');
  SB_MakeBooklet.Caption:=Form1.Vertaal('Make Booklet');

  s := ConfigDir+PathDelim+'tagger'+PathDelim;
  fIgnoreWords.Clear;
  if FileExistsUTF8(s+'ignore_words.txt') then
    fIgnoreWords.LoadFromFile(s+'ignore_words.txt');

  fSearchWords.Clear;
  fReplaceWords.Clear;
  if FileExistsUTF8(s+'replace_words.txt') then
  begin
    aLista := TStringlistUTF8.Create;
    aFields := TStringListUTF8.Create;
    try
      aLista.LoadFromFile(s+'replace_words.txt');
      for i:=0 to aLista.Count-1 do
      begin
        aFields.CommaText := aLista[i];
        if aFields.Count=2 then
        begin
          fSearchWords.Add(aFields[0]);
          fReplaceWords.Add(aFields[1]);
          //WriteLn(i,' ',aFields[0],' -> ', aFields[1]);
        end;
      end;

      finally
        aLista.Free;
        aFields.Free;
      end;
      //LCSVUtils.LoadFromCSVFile(s+'replace_words.txt', @NewRecord, ',')
  end;
end;

procedure TFormID3Tagger.Image2Click(Sender: TObject);
begin
  if OpenDialog1.Execute then
  begin
    Try
      Image2.Picture.LoadFromFile(OpenDialog1.FileName);
      CB_IncludeCDCover.Enabled:=True;  CB_IncludeCDCover.Checked:=True;
      IncludeID3PictureFile[Listbox1.ItemIndex]:=OpenDialog1.FileName;
      IncludeID3Picture[Listbox1.ItemIndex]:=True;
      LastUsedFilename:=IncludeID3PictureFile[Listbox1.ItemIndex];
    except
      CB_IncludeCDCover.Enabled:=False;  CB_IncludeCDCover.Checked:=False;
      Image2.Picture.Clear;
      ShowMessage(Form1.Vertaal('Wrong Picture Format'));
      IncludeID3PictureFile[Listbox1.ItemIndex]:=' ';
      LastUsedFilename:='';
    end;
  end;
end;


procedure TFormID3Tagger.Button12Click(Sender: TObject);
var i: longint;
begin
  for i:=0 to ListBox1.Items.Count-1 do
    if Listbox1.Selected[i] then changedTag[i]:=True;
end;

procedure TFormID3Tagger.Button2Click(Sender: TObject);
begin

end;

procedure TFormID3Tagger.Button3Click(Sender: TObject);
begin

end;

procedure TFormID3Tagger.Button9Click(Sender: TObject);
var AProcess: TProcess;
    lijn, temp: string;
    AStringlist: TStringlist;
    i: integer;
begin
  i:=ListBox1.ItemIndex;
  if i>-1 then
  begin
    AProcess:=TProcess.Create(nil);
    lijn:=Tag_Liedjes[i].Pad+Tag_Liedjes[i].Bestandsnaam+'"';
    AProcess.CommandLine:='listattr -l "'+lijn;
    AProcess.Options:=AProcess.Options+[poWaitOnExit, poUsePipes];
    AProcess.Execute;

    //Reading the output the bad way :)
    AStringlist:=TStringlist.Create;
    AStringlist.LoadFromStream(AProcess.Output);
    showMessage(AStringlist.Text);
    AProcess.Free;
    AStringlist.Free;
  end;
end;


procedure TFormID3Tagger.ButtonID3Selected_PicturesClick(Sender: TObject);
var i: longint;
begin
  // Change Picture ID3 for all selected songs
  For i:=0 To ListBox1.Count-1 do
  begin
    if Listbox1.Selected[i] then
    begin
      IncludeID3Picture[i]:=True; IncludeID3PictureFile[i]:=LastUsedFilename;
      Memo1.Lines.Add('> CD Cover changed for '+Tag_Liedjes[i].Bestandsnaam);
    end;
  end;
end;

procedure TFormID3Tagger.CB_IncludeCDCoverChange(Sender: TObject);
var i: integer;
begin
 (*   i:=ListBox1.ItemIndex; changedTag[i]:=True;
  IncludeID3Picture[i]:=not IncludeID3Picture[i];
  if IncludeID3Picture[i] then Memo1.Lines.Add('> INCLUDE CD Cover TAG changed for ('+inttostr(i)+') '+Tag_Liedjes[i].Bestandsnaam+' to TRUE')
   else Memo1.Lines.Add('> INCLUDE CD Cover TAG changed for ('+inttostr(i)+') '+Tag_Liedjes[i].Bestandsnaam+' to FALSE');
   *)
end;

procedure TFormID3Tagger.CB_IncludeCDCoverClick(Sender: TObject);
 var i: longint;
begin
  Memo1.Lines.Add('CB_IncludeCDCover');
  i:=ListBox1.ItemIndex;
  if CB_IncludeCDCover.Checked then Memo1.Lines.Add('TRUE')
                               else Memo1.Lines.Add('FALSE');
  IncludeID3Picture[i]:=CB_IncludeCDCover.Checked;
(*   i:=ListBox1.ItemIndex; changedTag[i]:=True;
  IncludeID3Picture[i]:=not IncludeID3Picture[i];
  if IncludeID3Picture[i] then Memo1.Lines.Add('> INCLUDE CD Cover TAG changed for ('+inttostr(i)+') '+Tag_Liedjes[i].Bestandsnaam+' to TRUE')
   else Memo1.Lines.Add('> INCLUDE CD Cover TAG changed for ('+inttostr(i)+') '+Tag_Liedjes[i].Bestandsnaam+' to FALSE');
   *)
end;

procedure TFormID3Tagger.CB_IncludeCDCoverEditingDone(Sender: TObject);
var i: longint;
begin

end;

procedure TFormID3Tagger.actCapsAllExecute(Sender: TObject);
var
  Song: Integer;
  act: Integer;
begin
  act := TComponent(Sender).Tag;
  Song := Listbox1.ItemIndex;

  //Log('%s: %s ',[TComponent(Sender).Name, TagNames[fActions[Act].Item]]);

  if Sender=actCapsAll then
    ModifyTag(Song, act, topAllCaps)
  else if Sender=actCapsFirst then
    ModifyTag(Song, act, topFirstCaps)
  else if Sender=actCapsFirstEach then
    ModifyTag(Song, act, topFirstAllCaps)
  else if Sender=actClear then
    ModifyTag(Song, act, topClear)
  else if Sender=actCapsAllSelection then
    ModifyTagAll(act, topAllCaps)
  else if Sender=actCapsFirstSelection then
    ModifyTagAll(act, topFirstCaps)
  else if Sender=actCapsFirstEachSelection then
    ModifyTagAll(act, topFirstAllCaps)
  else if sender=actClearSelection then
    ModifyTagAll(act, topClear)
  else if sender=actRenumber then
    ModifyTagAll(act, topRenumber);

  ReloadCurrentSongTags;
end;

procedure TFormID3Tagger.actLowerAllExecute(Sender: TObject);
var
  Song: Integer;
  act: Integer;
begin
  act := TComponent(Sender).Tag;
  Song := Listbox1.ItemIndex;

  //Log('%s: %s ',[TComponent(Sender).Name, TagNames[fActions[Act].Item]]);

  if Sender=actCapsAll then
    ModifyTag(Song, act, topAllCaps)
  else if Sender=actCapsFirst then
    ModifyTag(Song, act, topFirstCaps)
  else if Sender=actCapsFirstEach then
    ModifyTag(Song, act, topFirstAllCaps)
  else if Sender=actClear then
    ModifyTag(Song, act, topClear)
  else if Sender=actCapsAllSelection then
    ModifyTagAll(act, topAllCaps)
  else if Sender=actCapsFirstSelection then
    ModifyTagAll(act, topFirstCaps)
  else if Sender=actCapsFirstEachSelection then
    ModifyTagAll(act, topFirstAllCaps)
  else if sender=actClearSelection then
    ModifyTagAll(act, topClear)
  else if Sender=actLowerAll then
    ModifyTag(Song, act, topAllLower)
  else if sender=actRenumber then
    ModifyTagAll(act, topRenumber);

  ReloadCurrentSongTags;
end;

procedure TFormID3Tagger.CB_IncludeLyricChange(Sender: TObject);
begin
  IncludeLyric[Listbox1.ItemIndex]:=CB_IncludeLyric.Checked;
end;

procedure TFormID3Tagger.CB_IncludeLyricClick(Sender: TObject);
var i:longint;
begin
  i:=ListBox1.ItemIndex;
  IncludeLyric[i]:=CB_IncludeLyric.Checked; changedTag[i]:=True;
  Memo1.Lines.Add('> INCLUDE LYRIC TAG changed for '+Tag_Liedjes[i].Bestandsnaam);
end;

procedure TFormID3Tagger.Edit_FileEditingDone(Sender: TObject);
var i:longint;
begin
  i:=ListBox1.ItemIndex;
  if Liedjes[TagVolgorde[i]].Bestandsnaam<>Edit_File.Text+Label16.Caption then
  begin
    Tag_Liedjes[i].Bestandsnaam:=Edit_File.Text+Label16.Caption;
    if not changedFilename[i] then
      Memo1.Lines.Add('> FILENAME changed for '+Liedjes[TagVolgorde[i]].Bestandsnaam);
    changedFilename[i]:=True;
  end;
end;

procedure TFormID3Tagger.Edit_GroupTitleContextPopup(Sender: TObject;
  MousePos: TPoint; var Handled: Boolean);
var
  Mi: TMenuItem;
  Act: PtrInt;
  s1,s2,s3,s4,s5,s6: string;

  procedure AddMi(Action: TAction; s:string);
  begin
    Action.Caption := s;
    Action.Tag := Act;
    Mi := TMenuItem.Create(Self);
    Mi.Action := Action;
    Mi.Tag := Act;
    PopupMenu2.Items.Add(Mi);
  end;

  procedure AddMiSeparator;
  begin
    if PopupMenu2.Items.Count>0 then
    begin
      Mi := TMenuItem.Create(self);
      Mi.Caption := '-';
      PopupMenu2.Items.Add(Mi);
    end;
  end;

begin
  PopupMenu2.Items.Clear;
  Act := TComponent(Sender).Tag;
  s4 :=Form1.Vertaal('Clear');

  // Commit changes in the last edited field
  CommitEditorPendingChanges;

  if (Act>=0) and not (fActions[Act].Item in [taTrack, taJaartal, taOrigYear]) then
  begin

    s1 := Form1.Vertaal('Capitalize all');
    s2 := Form1.Vertaal('Capitalize first letter');
    s3 := Form1.Vertaal('Capitalize the first letter of each word');
    s6 := Form1.Vertaal('Lowercase all');

    if TEdit(Sender).Text<>'' then
    begin
      AddMi(actCapsFirst, s2);
      AddMi(actCapsFirstEach, s3);
      AddMi(actCapsAll, s1);
      AddMi(actLowerAll, s6);
      AddMi(actClear, s4);
    end;

    if Listbox1.SelCount>1 then
    begin
      AddMiSeparator;
      s5 := Form1.Vertaal('Selection')+', ';
      AddMi(actCapsFirstSelection,  s5 + TagNames[fActions[act].Item] + ': ' +s2);
      AddMi(actCapsFirstEachSelection,  s5 + TagNames[fActions[act].Item] + ': ' +s3);
      AddMi(actCapsAllSelection,  s5 + TagNames[fActions[act].Item] + ': ' +s1);
      AddMi(actClearSelection, s5 + s4 + TagNames[fActions[act].Item]);
    end;
  end else
  begin
    if (Act>=0) and (Sender=Edit_Track) and (Listbox1.SelCount>1) then
    begin
      fCurrentTrack := StrToIntDef(Trim(Edit_Track.Text), 1);
      Dec(fCurrentTrack);
      AddMi(actRenumber, Form1.Vertaal('Renumber tracks'));
    end;
    if TEdit(Sender).Text<>'' then
    begin
      Mi := TMenuItem.Create(self);
      Mi.Caption := s4;
      Mi.OnClick := @TextClear;
      Mi.Tag := PtrInt(Sender);
      PopupMenu2.Items.Add(Mi);
    end;
  end;

  AddMiSeparator;

  // add copy/paste menu items

  if TEdit(Sender).SelLength>0 then
  begin
    Mi := TMenuItem.Create(self);
    Mi.Caption := Form1.Vertaal('Cut');
    Mi.OnClick := @TextCut;
    Mi.Tag := PtrInt(Sender);
    PopupMenu2.Items.Add(Mi);

    Mi := TMenuItem.Create(self);
    Mi.Caption := Form1.Vertaal('Copy');
    Mi.OnClick := @TextCopy;
    Mi.Tag := PtrInt(Sender);
    PopupMenu2.Items.Add(Mi);
  end;

  // TODO: enable only if there are something to paste
  Mi := TMenuItem.Create(self);
  Mi.Caption := Form1.Vertaal('Paste');
  Mi.OnClick := @TextPaste;
  Mi.Tag := PtrInt(Sender);
  PopupMenu2.Items.Add(Mi);

end;

procedure TFormID3Tagger.FormClose(Sender: TObject;
  var CloseAction: TCloseAction);
begin
  ChangedTag:=nil;
end;

procedure TFormID3Tagger.FormCloseQuery(Sender: TObject; var CanClose: boolean);
var i: longint;
    HasSomethingBeenChanged: Boolean;
begin
  HasSomethingBeenChanged:=False;
  For i:=0 to Listbox1.Items.Count-1 do
  begin
    If changedTag[i] or changedFilename[i] then
    begin
      HasSomethingBeenChanged:=True;
      break;
    end;
  end;
  if HasSomethingBeenChanged Then
  begin
    if FormShowMyDialog.ShowWith(Form1.Vertaal('WARNING'),Form1.Vertaal('Some ID3 Tags have been changed'),Form1.Vertaal('Do you want to save the changes?'),'',Form1.Vertaal('NO'),Form1.Vertaal('YES'), False)
       then CanClose:=True
       else
       begin
         MI_SaveClick(Self);
         CanClose:=True;
       end;
  end;
end;

procedure TFormID3Tagger.FormCreate(Sender: TObject);
var
  i: Integer;
begin
  // make sure all edit controls on Tabsheet1 have a valid tag after register
  for i:=0 to Tabsheet1.ComponentCount-1 do
  begin
    if Tabsheet1.Components[i] is TEdit then
      Tabsheet1.Components[i].Tag := -1;
  end;
  RegisterControlAction(taGroupTitel,  Edit_GroupTitle,   Button13,  nil,                 'GROUP TITLE');
  RegisterControlAction(taTitel,       Edit_title,        nil,       MI_ClearTitle,       'TITLE');
  RegisterControlAction(taSubTitel,    Edit_SubTitle,     nil,       nil,                 'SUB TITLE');
  RegisterControlAction(taArtiest,     Edit_Artist,       Button2,   MI_ClearArtist,      'ARTIST');
  RegisterControlAction(taOrigArtiest, Edit_OrigArtist,   Button7,   MI_ClearOrigArtist,  'ORIGINAL ARTIST');
  RegisterControlAction(taOrigYear,    Edit_OrigYear,     Button15,  nil,                 'ORIGINAL YEAR');
  RegisterControlAction(taOrigTitle,   Edit_OrigTitle,    Button14,  nil,                 'ORIGINAL TITLE');
  RegisterControlAction(taCD,          Edit_Album,        Button3,   MI_ClearAlbum,       'ALBUM');
  RegisterControlAction(taGenre,       Edit_Genre,        Button4,   MI_ClearGenre,       'GENRE');
  RegisterControlAction(taComment,     Edit_Comment,      Button5,   MI_ClearComment,     'COMMENT');
  RegisterControlAction(taCopyright,   Edit_Copyright,    Button8,   MI_ClearCopyright,   'COPYRIGHT');
  RegisterControlAction(taEncoder,     Edit_Encoded,      Button10,  MI_ClearEncoded,     'ENCODER');
  RegisterControlAction(taJaartal,     Edit_Year,         Button11,  MI_ClearYear,        'YEAR');
  RegisterControlAction(taComposer,    Edit_Composer,     Button6,   MI_ClearComposer,    'COMPOSER');
  RegisterControlAction(taOrchestra,   Edit_Orchestra,    Button17,  nil,                 'ORCHESTRA');
  RegisterControlAction(taConductor,   Edit_Conductor,    Button18,  nil,                 'CONDUCTOR');
  RegisterControlAction(taInterpreted, Edit_Interpreted,  Button19,  nil,                 'INTERPRETED');
  RegisterControlAction(taTrack,       Edit_Track,        nil,       MI_ClearTrack,       'TRACK');
  fIgnoreWords := TStringList.Create;
  fIgnoreWords.Duplicates := dupIgnore;
  fIgnoreWords.Sorted := true;
  fSearchWords := TStringList.Create;
  fReplaceWords := TStringList.Create;
end;

procedure TFormID3Tagger.FormDestroy(Sender: TObject);
begin
  fIgnoreWords.Free;
  fSearchWords.Free;
  fReplaceWords.Free;
end;

procedure TFormID3Tagger.ListBox1Click(Sender: TObject);

begin
  Memo2.Clear;
  Application.AddOnIdleHandler(@TaggerListbox1Clicked);
end;

procedure TFormID3Tagger.ListBox1SelectionChange(Sender: TObject; User: boolean
  );
begin

end;

procedure TFormID3Tagger.Memo2Change(Sender: TObject);
begin
  SB_SaveLyricLocalStorage.Enabled:=True;
  if not Lyricchanged then Memo1.Lines.Add('> LYRIC TAG changed for '+Tag_Liedjes[Listbox1.ItemIndex].Bestandsnaam);
  changedTag[Listbox1.ItemIndex]:=True;  LyricChanged:=true;
end;

procedure TFormID3Tagger.MI_ClearAllClick(Sender: TObject);
var i: longint;
begin
  for i:=0 to ListBox1.Items.Count-1 do
  begin
    if Listbox1.Selected[i] then
    begin;
      Tag_Liedjes[i].Titel:=''; Edit_Title.Text:='';
      Tag_Liedjes[i].Artiest:=''; Edit_Artist.Text:='';
      Tag_Liedjes[i].CD:=''; Edit_Album.Text:='';
      Tag_Liedjes[i].Jaartal:=''; Edit_Year.Text:='';
      Tag_Liedjes[i].Genre:=''; Edit_Genre.Text:='';
      Tag_Liedjes[i].Comment:=''; Edit_Comment.Text:='';
      Tag_Liedjes[i].Composer:=''; Edit_Composer.Text:='';
      Tag_Liedjes[i].OrigArtiest:=''; Edit_OrigArtist.Text:='';
      Tag_Liedjes[i].OrigTitle:=''; Edit_OrigTitle.Text:='';
      Tag_Liedjes[i].OrigYear:=''; Edit_OrigYear.Text:='';
      Tag_Liedjes[i].Copyright:=''; Edit_Copyright.Text:='';
      Tag_Liedjes[i].Encoder:=''; Edit_Encoded.Text:='';
      Tag_Liedjes[i].Orchestra:=''; Edit_Orchestra.Text:='';
      Tag_Liedjes[i].Conductor:=''; Edit_Conductor.Text:='';
      Tag_Liedjes[i].Interpreted:=''; Edit_Interpreted.Text:='';
      Tag_Liedjes[i].GroupTitel:=''; Edit_GroupTitle.Text:='';
      Tag_Liedjes[i].SubTitel:=''; Edit_SubTitle.Text:='';
      Tag_Liedjes[i].Encoder:=''; Edit_Encoded.Text:='';
      Tag_Liedjes[i].Track:=0; Edit_Track.Text:='';
      Memo1.Lines.Add('> ALL ID3 TAGS cleared for '+Tag_Liedjes[i].Bestandsnaam);
      changedTag[i]:=True;
    end;
  end;
end;

procedure TFormID3Tagger.MI_ImportClick(Sender: TObject);
begin
  ShowMessage('Not yet implemented');
end;

procedure TFormID3Tagger.MI_ExportClick(Sender: TObject);
begin
  ShowMessage('Not yet implemented');
end;

procedure TFormID3Tagger.MI_RenameClick(Sender: TObject);
begin
  SB_TagToFileClick(Self);
end;

procedure TFormID3Tagger.MI_FillClick(Sender: TObject);
begin
  SB_FileToTagClick(Self);
end;

procedure TFormID3Tagger.SaveID3ToTags(i: integer);
var lijn: string;
    OurProcess: TProcess;
begin
  if cb_Artist1.Checked then
  begin
    if Tag_Liedjes[i].Artiest<>'' then
        begin
          Memo1.Lines.Add('> Saving Artist "'+Tag_Liedjes[i].Artiest+'" to BeFS tag');
          lijn:='';
          lijn:=lijn+' -t string Audio:Artist "'+Tag_Liedjes[i].Artiest+'"';
          OurProcess := TProcess.Create(nil);
          OurProcess.CommandLine:='addattr'+lijn+' "'+Tag_Liedjes[i].Pad+Tag_Liedjes[i].Bestandsnaam+'"';
          OurProcess.Options:=OurProcess.Options+[poWaitOnExit];
          OurProcess.Execute;
          OurProcess.Free;
        end;
  end;
  If CB_Album1.Checked then
  begin;
    if Tag_Liedjes[i].CD<>'' then
        begin
          Memo1.Lines.Add('> Saving Album "'+Tag_Liedjes[i].CD+'" to BeFS tag');
          lijn:='';
          lijn:=lijn+' -t string Audio:Album "'+Tag_Liedjes[i].CD+'"';
          OurProcess := TProcess.Create(nil);
          OurProcess.CommandLine:='addattr'+lijn+' "'+Tag_Liedjes[i].Pad+Tag_Liedjes[i].Bestandsnaam+'"';
          OurProcess.Options:=OurProcess.Options+[poWaitOnExit];
          OurProcess.Execute;
          OurProcess.Free;
        end;
  end;
  If CB_Title1.Checked then
  begin
      if Tag_Liedjes[i].Titel<>'' then
        begin
          Memo1.Lines.Add('> Saving Title "'+Tag_Liedjes[i].Titel+'" to BeFS tag');
          lijn:='';
          lijn:=lijn+' -t string Media:Title "'+Tag_Liedjes[i].Titel+'"';
          OurProcess := TProcess.Create(nil);
          OurProcess.CommandLine:='addattr'+lijn+' "'+Tag_Liedjes[i].Pad+Tag_Liedjes[i].Bestandsnaam+'"';
          OurProcess.Options:=OurProcess.Options+[poWaitOnExit];
          OurProcess.Execute;
          OurProcess.Free;
        end;
  end;
  if CB_Track1.Checked then
  begin
      if Tag_Liedjes[i].Track>0 then
        begin
          Memo1.Lines.Add('> Saving Track Number "'+inttostr(Tag_Liedjes[i].Track)+'" to BeFS tag');
          lijn:='';
          lijn:=lijn+' -t int Audio:Track "'+inttostr(Tag_Liedjes[i].Track)+'"';
          OurProcess := TProcess.Create(nil);
          OurProcess.CommandLine:='addattr'+lijn+' "'+Tag_Liedjes[i].Pad+Tag_Liedjes[i].Bestandsnaam+'"';
          OurProcess.Options:=OurProcess.Options+[poWaitOnExit];
          OurProcess.Execute;
          OurProcess.Free;
        end;
  end;
  if CB_Year1.Checked then
  begin
      if Tag_Liedjes[i].Jaartal<>'' then
        begin
          Memo1.Lines.Add('> Saving Year "'+Tag_Liedjes[i].Jaartal+'" to BeFS tag');
          lijn:='';
          lijn:=lijn+' -t string Media:Year "'+Tag_Liedjes[i].Jaartal+'"';
          OurProcess := TProcess.Create(nil);
          OurProcess.CommandLine:='addattr'+lijn+' "'+Tag_Liedjes[i].Pad+Tag_Liedjes[i].Bestandsnaam+'"';
          OurProcess.Options:=OurProcess.Options+[poWaitOnExit];
          OurProcess.Execute;
          OurProcess.Free;
        end;
  end;
  If CB_Genre1.Checked then
  begin
    if Tag_Liedjes[i].Genre<>'' then
        begin
          Memo1.Lines.Add('> Saving Genre "'+Tag_Liedjes[i].Genre+'" to BeFS tag');
          lijn:='';
          lijn:=lijn+' -t string Media:Genre "'+Tag_Liedjes[i].Genre+'"';
          OurProcess := TProcess.Create(nil);
          OurProcess.CommandLine:='addattr'+lijn+' "'+Tag_Liedjes[i].Pad+Tag_Liedjes[i].Bestandsnaam+'"';
          OurProcess.Options:=OurProcess.Options+[poWaitOnExit];
          OurProcess.Execute;
          OurProcess.Free;
        end;
  end;
  If CB_Remark1.Checked then
  begin
    if Tag_Liedjes[i].Comment<>'' then
        begin
          Memo1.Lines.Add('> Saving Comment "'+Tag_Liedjes[i].Comment+'" to BeFS tag');
          lijn:='';
          lijn:=lijn+' -t string Media:Comment "'+Tag_Liedjes[i].Comment+'"';
          OurProcess := TProcess.Create(nil);
          OurProcess.CommandLine:='addattr'+lijn+' "'+Tag_Liedjes[i].Pad+Tag_Liedjes[i].Bestandsnaam+'"';
          OurProcess.Options:=OurProcess.Options+[poWaitOnExit];
          OurProcess.Execute;
          OurProcess.Free;
        end;
  end;
  Application.ProcessMessages;
end;

procedure TFormID3Tagger.MI_SaveClick(Sender: TObject);
var i, i2: longint;
    ext: string;
    sourceFile, targetFile, TempTrackString, lijn: string;
    HasSomethingBeenChanged, tmpBool1, tmpBool2: Boolean;
    Error, pictureIndex: Integer;
    jpg: TJpegImage;
    PictureStream: TMemoryStream;
    CoverArtInfo: TOpusVorbisCoverArtInfo;
begin
  Cursor:=CRHourGlass;

  SB_Save.Enabled:=False;
  HasSomethingBeenChanged:=False;
  For i:=0 to Listbox1.Items.Count-1 do
  begin
    if changedFilename[i] then
    begin
      Log('# RENAMING: %s -> %s',[Liedjes[TagVolgorde[i]].Bestandsnaam, Tag_Liedjes[i].Bestandsnaam], true);
      ////  Directories checken & Eventueel aanmaken
      tmpBool1 := true;
      If Liedjes[TagVolgorde[i]].Pad<>Tag_Liedjes[i].Pad then
      begin
        tmpBool1 := ForceDirectoriesUTF8(Tag_Liedjes[i].Pad);
        if not tmpBool1 then Log('   NOTE: rename failed, cannot create target directory %s',[Tag_Liedjes[i].Pad], true);
      end;

      //// check that target filename do not exists.
      if tmpBool1 then
      begin
        //
        SourceFile := Liedjes[TagVolgorde[i]].Pad+Liedjes[TagVolgorde[i]].Bestandsnaam;
        targetFile := Tag_Liedjes[i].Pad+Tag_Liedjes[i].Bestandsnaam;
        tmpBool1 := not FileExistsUTF8(targetFile);
        if not tmpBool1 then
        begin
          // target file does exists, it should be possible to rename this file
          // if it is on a case insensitive, case preserving system
          // TODO: find a system idependant way to do this, as it seems, both
          //       systems allows to modify the filesystem personality.....
          {$IF Defined(DARWIN) or Defined(MSWINDOWS)}
          tmpBool1 := CompareFilenamesIgnoreCase(sourceFile, targetFile)=0;
          {$ENDIF}
        end;
        if not tmpBool1 then Log('   NOTE: rename failed, target filename already exists! ',[], true);

        //// Rename the File
        if tmpBool1 then
        begin

          if RenameFileUTF8(sourceFile, targetFile) then
          begin
            db_changed:=true;
            Liedjes[TagVolgorde[i]].pad:=Tag_Liedjes[i].Pad;
            Liedjes[TagVolgorde[i]].Bestandsnaam:=Tag_Liedjes[i].Bestandsnaam;
            Liedjes[TagVolgorde[i]].FNModified := false;
            Listbox1.Items[i]:=Tag_Liedjes[i].Bestandsnaam;
            Tag_Liedjes[i].FNModified := true;
            changedFilename[i]:=false;
            Application.ProcessMessages;
          end else Log('   NOTE: rename failed, error=%d',[GetLastOSError], true);
        end;
      end;
    end;

    If changedTag[i] then
    begin
      Memo1.Lines.Add('# SAVING TAGS for '+Liedjes[TagVolgorde[i]].Pad+Tag_Liedjes[i].Bestandsnaam);
      Memo1.Lines.Add('   LOADING Lyrics & CD Cover if available ...');
      Application.ProcessMessages;
      Listbox1.Selected[i]:=not Listbox1.Selected[i];Application.ProcessMessages;
      Listbox1.ItemIndex:=i; //ListBox1Click(Self);
      TaggerListbox1Clicked(MI_Save, tmpBool1);
      db_changed:=true; HasSomethingBeenChanged:=True; changedTag[i]:=false;
      ext:=upcase(ExtractFileExt(Liedjes[TagVolgorde[i]].Bestandsnaam));
      case ext of
        '.MP3': begin
                  ID3:=TID3v2.Create;
                  ID3.GroupTitle:=Tag_Liedjes[i].GroupTitel;
                  ID3.Title:=Tag_Liedjes[i].Titel;
                  ID3.SubTitle:=Tag_Liedjes[i].SubTitel;
                  id3.Artist:=Tag_Liedjes[i].Artiest;
                  id3.Album:=Tag_Liedjes[i].CD;
                  id3.Year:=Tag_Liedjes[i].Jaartal;
                  id3.Comment:=Tag_Liedjes[i].Comment;
                  id3.Composer:=Tag_Liedjes[i].Composer;
                  id3.OriginalArtist:=Tag_Liedjes[i].OrigArtiest;
                  id3.OriginalTitle:=Tag_Liedjes[i].OrigTitle;
                  id3.OriginalYear:=Tag_Liedjes[i].OrigYear;
                  id3.Copyright:=Tag_Liedjes[i].Copyright;
                  id3.Genre:=Tag_Liedjes[i].Genre;
                  id3.Track:=Tag_Liedjes[i].Track;
                  id3.Encoder:=Tag_Liedjes[i].Encoder;
                  id3.Software:=Tag_Liedjes[i].Software;
                  id3.orchestra:=Tag_Liedjes[i].Orchestra;
                  id3.conductor:=Tag_Liedjes[i].Conductor;
                  id3.interpreted:=Tag_Liedjes[i].Interpreted;
                  id3.Link:='';
                  if IncludeLyric[i] then id3.lyric:=Memo2.Text
                                     else id3.lyric:=''; //ShowMessage(id3.lyric);
                  if CB_IncludeCDCover.Checked then
                  begin
                    Memo1.Lines.Add('   CD COVER found ...');
                    Memo1.Lines.Add('   Saving CD COVER ...');
                    Application.ProcessMessages;
                    jpg:= TJpegImage.Create;
                    try
                      jpg.Assign(Image2.Picture.Bitmap);
                      jpg.SaveToFile(TempDir+DirectorySeparator+'CD.jpg');
                    finally
                      jpg.free;
                    end;
                    Memo1.Lines.Add('   Trying to attach CD COVER to ID3-TAG ...');
                    Application.ProcessMessages;
                    error:= id3.SetCoverArt2(TempDir+DirectorySeparator+'CD.jpg');
                    case error of
                      1: begin
                           Memo1.Lines.Add('   Saving CD COVER to ID3-TAG failed, trying to recover CD COVER from previous ID3-TAG ...');
                           Application.ProcessMessages;
                           SpeedButton1Click(Self);
                           if CB_IncludeCDCover.Checked then
                           begin
                             jpg:= TJpegImage.Create;
                             try
                               jpg.Assign(Image2.Picture.Bitmap);
                               jpg.SaveToFile(TempDir+DirectorySeparator+'CD.jpg');
                             finally
                               jpg.free;
                             end;
                             error:= id3.SetCoverArt2(TempDir+DirectorySeparator+'CD.jpg');
                             if error=1 then
                              begin
                                Memo1.Lines.Add('   Saving CD COVER failed ...');
                                Application.ProcessMessages;
                              end;
                           end
                           else
                           begin
                              Memo1.Lines.Add('   NO CD Cover found in existing TAGS ...');
                              Application.ProcessMessages;
                           end;
                         end;
                      2: begin
                           Memo1.Lines.Add('   NO CD Cover found in existing TAGS ...');
                              Application.ProcessMessages;
                          end;
                    end;
                  end;
                //  id3.savetofile(utf8tosys(Liedjes[TagVolgorde[i]].Pad+Liedjes[TagVolgorde[i]].Bestandsnaam));
                  id3.savetofile(Liedjes[TagVolgorde[i]].Pad+Liedjes[TagVolgorde[i]].Bestandsnaam);
                  ID3.Free;
                end;
        '.FLAC': begin
                  id3Flac:=TFLACfile.Create;
                  id3flac.Title:=Tag_Liedjes[i].Titel;
                  id3flac.SubTitle:=Tag_Liedjes[i].SubTitel;
                  id3flac.GroupTitle:=Tag_Liedjes[i].GroupTitel;
                  id3flac.Artist:=Tag_Liedjes[i].Artiest;
                  id3flac.Album:=Tag_Liedjes[i].CD;
                  id3flac.Year:=Tag_Liedjes[i].Jaartal;
                  id3flac.Comment:=Tag_Liedjes[i].Comment;
                  id3flac.Composer:=Tag_Liedjes[i].Composer;
                  id3flac.performer:=Tag_Liedjes[i].OrigArtiest;
                  id3flac.OriginalTitle:=Tag_Liedjes[i].OrigTitle;
                  id3flac.OriginalYear:=Tag_Liedjes[i].OrigYear;
                  id3flac.Copyright:=Tag_Liedjes[i].Copyright;
                  id3flac.Genre:=Tag_Liedjes[i].Genre;
                  id3flac.TrackString:=inttostr(Tag_Liedjes[i].Track);
                  id3flac.Encoder:=Tag_Liedjes[i].Encoder;
                  id3flac.orchestra:=Tag_Liedjes[i].Orchestra;
                  id3flac.conductor:=Tag_Liedjes[i].Conductor;
                  id3flac.interpreted:=Tag_Liedjes[i].Interpreted;
                  if IncludeLyric[i] then id3flac.lyrics:=Memo2.Text
                                     else id3flac.lyrics:='';
                  id3flac.Link:=id3extra.link;
                  id3flac.idVendor:=id3extra.id;
                  id3flac.SaveCDCover:=false;
                  if CB_IncludeCDCover.Checked then
                  begin
                    Memo1.Lines.Add('   CD COVER found ...');
                    Memo1.Lines.Add('   Saving CD COVER ...');
                    Application.ProcessMessages;
                    jpg:= TJpegImage.Create;
                    try
                      jpg.Assign(Image2.Picture.Bitmap);
                      jpg.SaveToFile(TempDir+DirectorySeparator+'CD.jpg');
                    finally
                      jpg.free;
                    end;
                    Memo1.Lines.Add('  Trying to attach CD COVER to ID3-TAG ...');
                    Application.ProcessMessages;
                    id3flac.SaveCDCover:=id3flac.SetCoverArt2(3,TempDir+DirectorySeparator+'CD.jpg',Image2.Picture.Width,Image2.Picture.Width);
                    //if id3flac.SaveCDCover then showmessage('Save JPG');
                  end;
                 // id3flac.SaveToFile(utf8tosys(Liedjes[TagVolgorde[i]].Pad+Liedjes[TagVolgorde[i]].Bestandsnaam), false);
                  id3flac.SaveToFile(Liedjes[TagVolgorde[i]].Pad+Liedjes[TagVolgorde[i]].Bestandsnaam, false);
                  id3flac.Free;
                  //DeleteFile(TempDir+DirectorySeparator+'CD.jpg');
                end;
       (* '.OGG': begin
                  ID3OGG:=TOggVorbis.Create;
                  ID3ogg.Title:=Tag_Liedjes[i].Titel;
                  id3ogg.Artist:=Tag_Liedjes[i].Artiest;
                  id3ogg.Album:=Tag_Liedjes[i].CD;
                  id3ogg.Date:=Tag_Liedjes[i].Jaartal;
                  id3ogg.Comment:=Tag_Liedjes[i].Comment;
                  id3ogg.Composer:=Tag_Liedjes[i].Composer;
                  id3ogg.OriginalArtist:=Tag_Liedjes[i].OrigArtiest;
                  id3ogg.Copyright:=Tag_Liedjes[i].Copyright;
                  id3ogg.Genre:=Tag_Liedjes[i].Genre;
                  id3ogg.Track:=Tag_Liedjes[i].Track;
                  id3ogg.Encoder:=Tag_Liedjes[i].Encoder;
                  id3ogg.Conductor:=Tag_Liedjes[i].Conductor;
                  id3ogg.Orchestra:=Tag_Liedjes[i].Orchestra;
                  id3ogg.SubTitle:=Tag_Liedjes[i].SubTitel;
                  id3ogg.GroupTitle:=Tag_Liedjes[i].GroupTitel;
                  id3ogg.OriginalTitle:=Tag_Liedjes[i].OrigTitle;
                  id3ogg.OriginalDate:=Tag_Liedjes[i].OrigYear;
                  id3ogg.Interpreted:=Tag_Liedjes[i].Interpreted;
                  if IncludeLyric[i] then id3extra.lyric:=Memo2.Text
                                     else id3extra.lyric:='';
                  id3ogg.Lyrics:=id3extra.lyric;
                 // id3ogg.License:=id3extra.link;
                  //id3ogg.SaveTag(utf8tosys(Liedjes[TagVolgorde[i]].Pad+Liedjes[TagVolgorde[i]].Bestandsnaam));
                  id3ogg.SaveTag(Liedjes[TagVolgorde[i]].Pad+Liedjes[TagVolgorde[i]].Bestandsnaam);
                  id3ogg.Free;
                end;  *)
        '.APE': begin
                  id3APE:=TAPEtag.Create;
                  if Tag_Liedjes[i].Artiest<>'' then ID3Ape.AppendField('ARTIST',Tag_Liedjes[i].Artiest);
                  if Tag_Liedjes[i].Titel<>'' then ID3Ape.AppendField('TITLE',Tag_Liedjes[i].Titel);
                  if Tag_Liedjes[i].CD<>'' then ID3Ape.AppendField('ALBUM',Tag_Liedjes[i].CD);
                  if Tag_Liedjes[i].Jaartal<>'' then ID3Ape.AppendField('DATE',Tag_Liedjes[i].Jaartal);
                  if Tag_Liedjes[i].Comment<>'' then ID3Ape.AppendField('COMMENT',Tag_Liedjes[i].Comment);
                  if Tag_Liedjes[i].Composer<>'' then ID3Ape.AppendField('COMPOSER',Tag_Liedjes[i].Composer);
                  if Tag_Liedjes[i].OrigArtiest<>'' then ID3Ape.AppendField('ORIGINAL_ARTIST',Tag_Liedjes[i].OrigArtiest);
                  if Tag_Liedjes[i].Copyright<>'' then ID3Ape.AppendField('COPYRIGHT',Tag_Liedjes[i].Copyright);
                  if Tag_Liedjes[i].Genre<>'' then ID3Ape.AppendField('GENRE',Tag_Liedjes[i].Genre);
                  if Tag_Liedjes[i].Track>0 then ID3Ape.AppendField('TRACKNUMBER',inttostr(Tag_Liedjes[i].Track));
                  if Tag_Liedjes[i].SubTitel<>'' then ID3Ape.AppendField('SUBTITLE',Tag_Liedjes[i].SubTitel);
                  if Tag_Liedjes[i].GroupTitel<>'' then ID3Ape.AppendField('GROUPING',Tag_Liedjes[i].GroupTitel);
                  if Tag_Liedjes[i].Encoder<>'' then ID3Ape.AppendField('ENCODEDBY',Tag_Liedjes[i].Encoder);
                  if Tag_Liedjes[i].OrigTitle<>'' then ID3Ape.AppendField('RIGINAL_TITLE',Tag_Liedjes[i].OrigTitle);
                  if Tag_Liedjes[i].OrigYear<>'' then ID3Ape.AppendField('ORIGINAL_DATE',Tag_Liedjes[i].OrigYear);
                  if Tag_Liedjes[i].Orchestra<>'' then ID3Ape.AppendField('ENSEMBLE',Tag_Liedjes[i].Orchestra);
                  if Tag_Liedjes[i].Conductor<>'' then ID3Ape.AppendField('CONDUCTOR',Tag_Liedjes[i].Conductor);
                  if Tag_Liedjes[i].Interpreted<>'' then ID3Ape.AppendField('REMIXER',Tag_Liedjes[i].Interpreted);
                  if IncludeLyric[i] then id3extra.lyric:=Memo2.Text
                                     else id3extra.lyric:='';
                  if id3extra.lyric<>'' then ID3Ape.AppendField('LYRICS',id3extra.lyric);;
                  // if id3extra.link<>'' then ID3Ape.AppendField('Related',id3extra.link);
                  // id3APE.WriteTagInFile(utf8tosys(Liedjes[TagVolgorde[i]].Pad+Liedjes[TagVolgorde[i]].Bestandsnaam));
                  id3APE.WriteTagInFile(Liedjes[TagVolgorde[i]].Pad+Liedjes[TagVolgorde[i]].Bestandsnaam);
                  id3APE.Destroy;
                end;
        '.OPUS', '.OGG': begin
                   id3OpusTest:=TOpusTag.Create;
                   id3OpusTest.LoadFromFile(Tag_Liedjes[i].Pad+Tag_Liedjes[i].Bestandsnaam);
                   id3OpusTest.RemoveEmptyFrames;
                   for i2:=0 to id3OpusTest.Count-1 do
                    begin
                    Case upcase(id3OpusTest.Frames[i2].Name) of
                    'ARTIST': begin
                                id3OpusTest.Frames[i2].SetAsText(Tag_Liedjes[i].Artiest);
                                // TODO:  Clean all artist tags
                                //        Add Posibility to add more Artists
                              end;
                    'TITLE' : id3OpusTest.Frames[i2].SetAsText(Tag_Liedjes[i].Titel);
                    'GENRE'  : id3OpusTest.Frames[i2].SetAsText(Tag_Liedjes[i].Genre);
                    'ALBUM'  : id3OpusTest.Frames[i2].SetAsText(Tag_Liedjes[i].CD);
                    'DATE'   : id3OpusTest.Frames[i2].SetAsText(Tag_Liedjes[i].Jaartal);
                    'TRACKNUMBER': begin
                                     TempTrackString:=inttostr(Tag_Liedjes[i].Track);
                                     if (Tag_Liedjes[i].AantalTracks<>'') and (Tag_Liedjes[i].AantalTracks<>'0')
                                        then TempTrackString:=TempTrackString+'/'+Tag_Liedjes[i].AantalTracks;
                                     if Tag_Liedjes[i].Track<>0
                                       then id3OpusTest.Frames[i2].SetAsText(TempTrackString);
                                   end;
                    'COMMENT'   : id3OpusTest.Frames[i2].SetAsText(Tag_Liedjes[i].Comment);
                    'COMPOSER'  : id3OpusTest.Frames[i2].SetAsText(Tag_Liedjes[i].Composer);
                    'COPYRIGHT ': id3OpusTest.Frames[i2].SetAsText(Tag_Liedjes[i].Copyright);
                    'CONDUCTOR' : id3OpusTest.Frames[i2].SetAsText(Tag_Liedjes[i].Conductor);
                    'ORCHESTRA' : id3OpusTest.Frames[i2].SetAsText(Tag_Liedjes[i].Orchestra);
                    'GROUPTITLE': id3OpusTest.Frames[i2].SetAsText(Tag_Liedjes[i].GroupTitel);
                    'SUBTITLE'  : id3OpusTest.Frames[i2].SetAsText(Tag_Liedjes[i].SubTitel);
                    'INTERPRETED': id3OpusTest.Frames[i2].SetAsText(Tag_Liedjes[i].Interpreted);
                    'ORIGINAL_ARTIST': id3OpusTest.Frames[i2].SetAsText(Tag_Liedjes[i].OrigArtiest);
                    'ORIGINAL_TITLE' : id3OpusTest.Frames[i2].SetAsText(Tag_Liedjes[i].OrigTitle);
                    'ORIGINAL_DATE'  : id3OpusTest.Frames[i2].SetAsText(Tag_Liedjes[i].OrigYear);
                  end;
               end;
               if id3OpusTest.FrameExists('ARTIST')<0 then id3OpusTest.AddTextFrame('ARTIST',Tag_Liedjes[i].Artiest);
               if id3OpusTest.FrameExists('TITLE')<0 then id3OpusTest.AddTextFrame('TITLE',Tag_Liedjes[i].Titel);
               if id3OpusTest.FrameExists('DATE')<0 then id3OpusTest.AddTextFrame('DATE',Tag_Liedjes[i].Jaartal);
               if id3OpusTest.FrameExists('ALBUM')<0 then id3OpusTest.AddTextFrame('ALBUM',Tag_Liedjes[i].CD);
               if id3OpusTest.FrameExists('GENRE')<0 then id3OpusTest.AddTextFrame('GENRE',Tag_Liedjes[i].Genre);
               if id3OpusTest.FrameExists('COMMENT')<0 then id3OpusTest.AddTextFrame('COMMENT',Tag_Liedjes[i].Comment);
               if id3OpusTest.FrameExists('COMPOSER')<0 then id3OpusTest.AddTextFrame('COMPOSER',Tag_Liedjes[i].Composer);
               if id3OpusTest.FrameExists('COPYRIGHT')<0 then id3OpusTest.AddTextFrame('COPYRIGHT',Tag_Liedjes[i].Copyright);
               if id3OpusTest.FrameExists('CONDUCTOR')<0 then id3OpusTest.AddTextFrame('CONDUCTOR',Tag_Liedjes[i].Conductor);
               if id3OpusTest.FrameExists('ORCHESTRA')<0 then id3OpusTest.AddTextFrame('ORCHESTRA',Tag_Liedjes[i].Orchestra);
               if id3OpusTest.FrameExists('GROUPTITLE')<0 then id3OpusTest.AddTextFrame('GROUPTITLE',Tag_Liedjes[i].GroupTitel);
               if id3OpusTest.FrameExists('SUBTITLE')<0 then id3OpusTest.AddTextFrame('SUBTITLE',Tag_Liedjes[i].SubTitel);
               if id3OpusTest.FrameExists('INTERPRETED')<0 then id3OpusTest.AddTextFrame('INTERPRETED',Tag_Liedjes[i].Interpreted);
               if id3OpusTest.FrameExists('ORIGINAL_ARTIST')<0 then id3OpusTest.AddTextFrame('ORIGINAL_ARTIST',Tag_Liedjes[i].OrigArtiest);
               if id3OpusTest.FrameExists('ORIGINAL_TITLE')<0 then id3OpusTest.AddTextFrame('ORIGINAL_TITLE',Tag_Liedjes[i].OrigTitle);
               if id3OpusTest.FrameExists('ORIGINAL_DATE')<0 then id3OpusTest.AddTextFrame('ORIGINAL_DATE',Tag_Liedjes[i].OrigYear);

               if Tag_Liedjes[i].Track=0 then id3OpusTest.DeleteFrameByName('TRACKNUMBER')
                                              else if id3OpusTest.FrameExists('TRACKNUMBER')<0
                                                then begin
                                                       if (Tag_Liedjes[i].AantalTracks<>'') and (Tag_Liedjes[i].AantalTracks<>'')
                                                         then id3OpusTest.AddTextFrame('TRACKNUMBER',Inttostr(Tag_Liedjes[i].Track)+'/'+Tag_Liedjes[i].AantalTracks)
                                                         else id3OpusTest.AddTextFrame('TRACKNUMBER',Inttostr(Tag_Liedjes[i].Track));
                                                     end;
               id3OpusTest.RemoveEmptyFrames;
               if CB_IncludeCDCover.Checked then
                  begin
                    Memo1.Lines.Add('   CD COVER found ...');
                    Memo1.Lines.Add('   Saving CD COVER ...');
                    MeMo1.Lines.Add(' >> IN TEST FASE <<');
                    Application.ProcessMessages;
                    jpg:= TJpegImage.Create; PictureStream:=TMemoryStream.Create;
                    try
                      jpg.Assign(Image2.Picture.Bitmap);
                      jpg.SaveToStream(PictureStream);
                    finally
                    end;
                    CoverArtInfo.ColorDepth:=32;
                    CoverArtInfo.MIMEType:='image/jpeg';
                    CoverArtInfo.Description:='CD Cover';
                    CoverArtInfo.Height:=jpg.Height;
                    CoverArtInfo.Width:=jpg.Width;
                    CoverArtInfo.PictureType:=0;
                    CoverArtInfo.NoOfColors:=0;
                    CoverArtInfo.SizeOfPictureData:=PictureStream.Size;
                    pictureIndex:=id3OpusTest.FrameExists('METADATA_BLOCK_PICTURE');
                    (* Get the Index for the CoverArtFrame*)
                    if pictureIndex>0 then id3OpusTest.SetCoverArtFrame(pictureIndex, PictureStream, CoverArtInfo)
                                      else id3OpusTest.ADDCoverArtFrame(PictureStream, CoverArtInfo);
                    jpg.Free;
                  end;
               id3OpusTest.SaveToFile(Tag_Liedjes[i].Pad+Tag_Liedjes[i].Bestandsnaam);
               id3OpusTest.Free;
             end;
           else Memo1.Lines.Add(ext+': '+Form1.Vertaal('SAVING for this filetype is not yet supported. Saving in DB'));
      end;

      {$if defined(HAIKU)}
      If CB_Haiku_attr.Checked then
      begin
        SaveID3ToTags(i);
      end;

      {$ifend}
     // end;
      tmpBool1 := Liedjes[TagVolgorde[i]].Modified;
      tmpBool2 := Liedjes[TagVolgorde[i]].FNModified;
      Liedjes[TagVolgorde[i]]:=Tag_Liedjes[i];
      // maybe paranoid but let's strictly separate the temporal set of
      // songs (Tag_liedjes) from te original (liedjes) this because the statement
      // above will copy also the 'modified' flags whatever are they.
      Liedjes[TagVolgorde[i]].Modified := tmpBool1;
      Liedjes[TagVolgorde[i]].FNModified := tmpBool2;
      Tag_Liedjes[i].Modified := true;
    end;
  end;
  if not HasSomethingBeenChanged then
  begin
    if Memo1.Lines[Memo1.Lines.Count-1]='# '+Form1.Vertaal('Nothing to save')+' :)'
       then Memo1.Lines.Add('# '+Form1.Vertaal('Don''t you believe me, nothing has been changed, so why bother saving'))
                                                             else Memo1.Lines.Add('# '+Form1.Vertaal('Nothing to save')+' :)');

  end;
  ListBox1Click(Self);  Cursor:=CRDefault;
  SB_Save.Enabled:=True; Memo1.Lines.Add('# SAVING DONE ...');
end;

procedure TFormID3Tagger.MI_SelectAllClick(Sender: TObject);
var i: longint;
begin
  for i:=0 to ListBox1.Items.Count-1 do ListBox1.Selected[i]:=true;
end;

procedure TFormID3Tagger.MI_InvertSelectClick(Sender: TObject);
var i: longint;
begin
  for i:=0 to ListBox1.Items.Count-1 do ListBox1.Selected[i]:=not ListBox1.Selected[i];
end;

procedure TFormID3Tagger.MI_SelectNoneClick(Sender: TObject);
var i: longint;
begin
  for i:=0 to ListBox1.Items.Count-1 do ListBox1.Selected[i]:=false;
end;

procedure TFormID3Tagger.SB_Empty_LyricClick(Sender: TObject);
begin
  Memo2.Lines.Clear; Lyricchanged:=True;  SB_SaveLyricLocalStorage.Enabled:=True;
  CB_IncludeLyric.Checked:=False; IncludeLyric[Listbox1.ItemIndex]:=False;
end;

procedure TFormID3Tagger.SB_FileToTagClick(Sender: TObject);
var i: longint;
    ext, bestandsnaam: string;
begin
  if length(LB_MaskFiletoTag.Caption) > 2 then
  begin
    for i:=0 to ListBox1.Items.Count-1 do
      if ListBox1.Selected[i] then
      begin
        ext:=ExtractFileExt(Tag_Liedjes[i].Bestandsnaam);
        bestandsnaam:=copy(Tag_Liedjes[i].Bestandsnaam,1,length(Tag_Liedjes[i].Bestandsnaam)-length(ext));
        FormFillTagFromFile.DecodeFromFilename(bestandsnaam, LB_MaskFiletoTag.Caption);
        if LiedjesTemp.Artiest<>'' then Tag_Liedjes[i].Artiest:=LiedjesTemp.Artiest;
        if LiedjesTemp.CD<>'' then Tag_Liedjes[i].CD:=LiedjesTemp.CD;
        if LiedjesTemp.Titel<>'' then Tag_Liedjes[i].Titel:=LiedjesTemp.Titel;
        if LiedjesTemp.Jaartal<>'' then Tag_Liedjes[i].Jaartal:=LiedjesTemp.Jaartal;
        if LiedjesTemp.Genre<>'' then Tag_Liedjes[i].Genre:=LiedjesTemp.Genre;
        if LiedjesTemp.Copyright<>'' then Tag_Liedjes[i].Copyright:=LiedjesTemp.Copyright;
        if LiedjesTemp.Comment<>'' then Tag_Liedjes[i].comment:=LiedjesTemp.Comment;
        if LiedjesTemp.Composer<>'' then Tag_Liedjes[i].Composer:=LiedjesTemp.Composer;
        if LiedjesTemp.Track<>0 then Tag_Liedjes[i].Track:=LiedjesTemp.Track;
        if LiedjesTemp.OrigArtiest<>'' then Tag_Liedjes[i].OrigArtiest:=LiedjesTemp.OrigArtiest;
        if LiedjesTemp.OrigTitle<>'' then Tag_Liedjes[i].OrigTitle:=LiedjesTemp.OrigTitle;
        if LiedjesTemp.OrigYear<>'' then Tag_Liedjes[i].OrigYear:=LiedjesTemp.OrigYear;
        if LiedjesTemp.Orchestra<>'' then Tag_Liedjes[i].Orchestra:=LiedjesTemp.Orchestra;
        if LiedjesTemp.Conductor<>'' then Tag_Liedjes[i].Conductor:=LiedjesTemp.Conductor;
        if LiedjesTemp.Interpreted<>'' then Tag_Liedjes[i].Interpreted:=LiedjesTemp.Interpreted;
        if LiedjesTemp.GroupTitel<>'' then Tag_Liedjes[i].GroupTitel:=LiedjesTemp.GroupTitel;
        if LiedjesTemp.SubTitel<>'' then Tag_Liedjes[i].SubTitel:=LiedjesTemp.SubTitel;
        changedTag[i]:=True;
        Memo1.Lines.Add('> TAGS changed for '+Tag_Liedjes[i].Bestandsnaam);
      end;
    ReloadCurrentSongTags;
  end
  else SB_ActionDialogClick(Self);

end;

procedure TFormID3Tagger.SB_OpenCUEClick(Sender: TObject);
begin
  ShowMessage('Work in progress - BUTTON not yet assigned');
end;

procedure TFormID3Tagger.SB_OpenLyricClick(Sender: TObject);
begin
  if OpenDialog1.Execute then
  begin
    Memo2.Lines.LoadFromFile(OpenDialog1.FileName);
    SB_SaveLyricLocalStorage.Enabled:=True;
    Lyricchanged:=True;
  end;
end;

procedure TFormID3Tagger.SB_ReloadLyric1Click(Sender: TObject);
begin
  ShowMessage('Work in progress - BUTTON not yet assigned');
end;

procedure TFormID3Tagger.SB_ReloadLyricClick(Sender: TObject);
begin
  ReloadLyricsFromLocalStorage;
  if Memo2.Lines.Count>1 then SB_SaveLyricLocalStorage.Enabled:=True;
end;

procedure TFormID3Tagger.SB_SaveAsLyricClick(Sender: TObject);
begin
  If Memo2.Lines.Count=0 then showmessage(Form1.Vertaal('Nothing to save')+' ...')
                         else
                           begin
                             SaveDialog1.DefaultExt:='.lrc';
                             If SaveDialog1.Execute then Memo2.Lines.SaveToFile(SaveDialog1.FileName);
                           end;
end;

procedure TFormID3Tagger.SB_SaveCUEClick(Sender: TObject);
var Filevar: TextFile;
    Track: Byte;
    lijn, tempfilename: String;
begin
 if StringgridCue.RowCount>1 then
 begin
  tempfilename:=Tag_Liedjes[Listbox1.ItemIndex].Pad+Tag_Liedjes[Listbox1.ItemIndex].Bestandsnaam;
  delete(tempfilename,length(tempfilename)-length(label16.caption)+1,length(label16.caption)); tempfilename:=tempfilename+'.cue';

  Track:=1;
  AssignFile(Filevar,tempfilename+'2');
  Rewrite(Filevar);
  Writeln(Filevar,'REM GENRE "'+Edit_Genre.Text+'"');
  Writeln(Filevar,'REM DATE '+Edit_Year.text);
  Writeln(Filevar,'REM COMMENT "XiX Music Player <http://www.xixmusicplayer.org/>"');
  Writeln(Filevar,'PERFORMER "'+Edit_Artist.Text+'"');
  Writeln(Filevar,'TITLE "'+Edit_AlbumCue.Text+'"');
  Writeln(Filevar,'FILE "'+Edit_File.Text+Label16.Caption+'" WAVE');
  repeat
    lijn:=inttostr(Track); if length(lijn)=1 then lijn:='0'+lijn;
    Writeln(Filevar,'  TRACK '+lijn+' AUDIO');
    Writeln(Filevar,'    TITLE "'+StringGridCue.Cells[2,Track]+'"');
    Writeln(Filevar,'    PERFORMER "'+StringGridCue.Cells[1,Track]+'"');
    Writeln(Filevar,'    INDEX 01 '+StringGridCue.Cells[3,Track]+':00');
    Inc(Track);
  until Track=StringGridCue.RowCount;
  CloseFile(Filevar);
  Memo1.Lines.Add('> Saved CUE changes ...');
 end;
end;

procedure TFormID3Tagger.SB_SaveLyricLocalStorageClick(Sender: TObject);
begin
  SaveLyricsToLocalStorage;
end;

procedure TFormID3Tagger.SB_StopClick(Sender: TObject);
begin
  //BASS_ChannelStop(Song_Stream1);
  Form1.SB_StopClick(Self);
end;

procedure TFormID3Tagger.SB_TagToFileClick(Sender: TObject);
var i: longint;
    ext, lijn: string;
    newPath, newFilename: string;
begin
  if length(LB_MaskTagtoFile.Caption) > 2 then
  begin
    for i:=0 to ListBox1.Items.Count-1 do
      if ListBox1.Selected[i] then
      begin
        ext:=ExtractFileExt(Tag_Liedjes[i].Bestandsnaam);
        //Tag_Liedjes[i].Bestandsnaam:=FormFillTagFromFile.DecodeToFilename(i,LB_MaskTagToFile.Caption)+ext;
        lijn:=FormFillTagFromFile.DecodeToFilename(i,LB_MaskTagToFile.Caption)+ext;
        if pos(DirectorySeparator,lijn)<1 then
        begin
          newFilename:=lijn;
          newPath := Tag_Liedjes[i].Pad;
        end
                                          else
        begin
          newFilename:=ExtractFileName(lijn);
          newPath:=ExtractFilePath(lijn);
        end;
        // TODO: this should use CompareFilenames too but it would probably
        //       skip valid filename case change, need to test considering
        //       OS, case, decomposed utf8 vs normal utf8
        changedFilename[i]:= (newFileName<>Tag_Liedjes[i].Bestandsnaam) or
                             (newPath<>Tag_Liedjes[i].Pad);

        Tag_Liedjes[i].Bestandsnaam := newFilename;
        Tag_Liedjes[i].Pad := newPath;

        if changedFilename[i] then
        begin
          if CompareFilenames(Liedjes[TagVolgorde[i]].Pad, newPath)=0 then
            Log('> FILENAME changed for %s to %s',[Liedjes[TagVolgorde[i]].Bestandsnaam, newFilename])
          else
          if CompareFilenames(Liedjes[TagVolgorde[i]].Bestandsnaam, newFilename)=0 then
            Log('> PATH changed for %s from %s to %s',[Liedjes[TagVolgorde[i]].Bestandsnaam, Liedjes[TagVolgorde[i]].Pad, newPath])
          else
            Log('> PATH+FILENAME changed for %s to %s',
              [Liedjes[TagVolgorde[i]].Pad+Liedjes[TagVolgorde[i]].Bestandsnaam,newPath+newFilename]);
        end;
      end;
    ListBox1Click(Self);
  end
  else SB_ActionDialogClick(Self);
end;

procedure TFormID3Tagger.SB_PlayFromCueClick(Sender: TObject);
var lijn: string;
begin
  lijn:= Tag_Liedjes[Listbox1.ItemIndex].Pad+Tag_Liedjes[Listbox1.ItemIndex].Bestandsnaam;

  Form1.SB_StopClick(Self);
  {$if not defined(HAIKU)}
  BASS_ChannelStop(Song_Stream1);
  Song_Stream1  := BASS_StreamCreateFile(False,PChar(lijn),0,0,BASS_STREAM_AUTOFREE);
  myBool         := BASS_ChannelPlay(Song_Stream1, False);
  total_bytes    := BASS_ChannelGetLength(Song_Stream1, BASS_POS_BYTE);
  total_time     := BASS_ChannelBytes2Seconds(Song_Stream1, total_bytes);
  total_time_str := Form1.SecToTime(round(total_time));
  {$ifend}
end;

procedure TFormID3Tagger.SpeedButton11Click(Sender: TObject);
begin
  ShowMessage('Work in progress - BUTTON not yet assigned');
end;

procedure TFormID3Tagger.SB_Stop2Click(Sender: TObject);
begin
  {$if not defined(HAIKU)}
  BASS_ChannelStop(Song_Stream1);
  {$ifend}
end;

procedure TFormID3Tagger.SB_SearchCDCoverClick(Sender: TObject);
var lijn: string;
begin
  lijn:=Form1.ConvertArtist(Edit_Artist.Text,true)+'-'+Form1.ConvertAlbum(Edit_Album.Text);
  if fileexists(Configdir+Directoryseparator+'cache'+DirectorySeparator+lijn+'.jpg')
     then begin
            CB_IncludeCDCover.Checked:=True; CB_IncludeCDCover.Enabled:=True;
            Image2.Picture.LoadFromFile(Configdir+Directoryseparator+'cache'+DirectorySeparator+lijn+'.jpg');
            LastUsedFilename:=Configdir+Directoryseparator+'cache'+DirectorySeparator+lijn+'.jpg';
            IncludeID3PictureFile[ListBox1.ItemIndex]:=Configdir+Directoryseparator+'cache'+DirectorySeparator+lijn+'.jpg';
            IncludeID3Picture[ListBox1.ItemIndex]:=true;
          end
     else begin
            Image2.Picture.Clear;
            CB_IncludeCDCover.Checked:=False; CB_IncludeCDCover.Enabled:=False;
            IncludeID3PictureFile[ListBox1.ItemIndex]:=' '; IncludeID3Picture[ListBox1.ItemIndex]:=false;
          end;

end;

procedure TFormID3Tagger.SpeedButton13MouseEnter(Sender: TObject);
begin
  SB_SearchCDCover.Visible:=True;
end;

procedure TFormID3Tagger.SpeedButton13MouseLeave(Sender: TObject);
begin
  SB_SearchCDCover.Visible:=False;
end;

procedure TFormID3Tagger.SB_OnlineCDCoverClick(Sender: TObject);
begin
  ShowMessage('Work in progress - BUTTON not yet assigned');
end;

procedure TFormID3Tagger.SB_ActionDialogClick(Sender: TObject);
begin
  ListBox1Click(Self);
  FormFillTagFromFile.showmodal;
  LB_MaskFileToTag.Caption:=Settings.MaskToTag;
  LB_MaskTagToFile.Caption:=Settings.MaskToFile;
end;

procedure TFormID3Tagger.SB_PlayClick(Sender: TObject);
begin
  if Listbox1.ItemIndex>-1 then
  begin
    Form1.SB_StopClick(Self);
    LiedjesTemp:=Liedjes[Tagvolgorde[Listbox1.ItemIndex]];
    Form1.PlayFromFile(LiedjesTemp.Pad+LiedjesTemp.Bestandsnaam);
  end;
end;

procedure TFormID3Tagger.SB_Reload1Click(Sender: TObject);
var i: longint;
begin
  for i:=0 to ListBox1.Items.Count-1 do
  begin
    if Listbox1.Selected[i] then
    begin;
      Tag_Liedjes[i].Titel:=Liedjes[TagVolgorde[i]].Titel;
      Tag_Liedjes[i].Artiest:=Liedjes[TagVolgorde[i]].Artiest;
      Tag_Liedjes[i].CD:=Liedjes[TagVolgorde[i]].CD;
      Tag_Liedjes[i].Jaartal:=Liedjes[TagVolgorde[i]].Jaartal;
      Tag_Liedjes[i].Genre:=Liedjes[TagVolgorde[i]].Genre;
      Tag_Liedjes[i].Comment:=Liedjes[TagVolgorde[i]].Comment;
      Tag_Liedjes[i].Composer:=Liedjes[TagVolgorde[i]].Composer;
      Tag_Liedjes[i].OrigArtiest:=Liedjes[TagVolgorde[i]].OrigArtiest;
      Tag_Liedjes[i].OrigTitle:=Liedjes[TagVolgorde[i]].OrigTitle;
      Tag_Liedjes[i].OrigYear:=Liedjes[TagVolgorde[i]].OrigYear;
      Tag_Liedjes[i].Copyright:=Liedjes[TagVolgorde[i]].Copyright;
      Tag_Liedjes[i].Encoder:=Liedjes[TagVolgorde[i]].Encoder;
      Tag_Liedjes[i].Track:=Liedjes[TagVolgorde[i]].Track;
      Tag_Liedjes[i].SubTitel:=Liedjes[TagVolgorde[i]].SubTitel;
      Tag_Liedjes[i].GroupTitel:=Liedjes[TagVolgorde[i]].GroupTitel;
      Tag_Liedjes[i].orchestra:=Liedjes[TagVolgorde[i]].Orchestra;
      Tag_Liedjes[i].conductor:=Liedjes[TagVolgorde[i]].Conductor;
      Tag_Liedjes[i].interpreted:=Liedjes[TagVolgorde[i]].Interpreted;
      changedTag[i]:=False;
      Memo1.Lines.Add('> ID3 TAG has been reset for '+Liedjes[TagVolgorde[i]].Bestandsnaam);
    end;
  end;
  ReloadCurrentSongTags;
end;

procedure TFormID3Tagger.SB_SavePictureAsClick(Sender: TObject);
var jpg: TJpegImage;
begin
  SaveDialog1.DefaultExt:='.jpg';
  If SaveDialog1.Execute then
  begin
    if fileexists(SaveDialog1.FileName) then
    begin
      If FormShowMyDialog.ShowWith(Form1.Vertaal('WARNING'),SaveDialog1.FileName,Form1.vertaal('already exists'),Form1.Vertaal('OVERWRITE ?'),Form1.Vertaal('NO'),Form1.Vertaal('YES'),False)
         then ShowMessage(Form1.Vertaal('Saving has been cancelled'))
         else DeleteFile(SaveDialog1.FileName);
    end;
    if not fileexists(SaveDialog1.FileName) then
     begin
       jpg:= TJpegImage.Create;
       try
         jpg.Assign(Image2.Picture.Bitmap);
         jpg.SaveToFile(SaveDialog1.FileName);
       finally
         jpg.free;
         ShowMessage(form1.Vertaal('CD Cover saved as')+' '+SaveDialog1.FileName);
       end;
     end;
  end;
end;

procedure TFormID3Tagger.SB_ClearPictureClick(Sender: TObject);
begin
  Image2.Picture.Clear;
  CB_IncludeCDCover.Checked:=False; CB_IncludeCDCover.Enabled:=False;
end;

procedure TFormID3Tagger.SB_ReloadLyricFromTagClick(Sender: TObject);
begin
  ReloadLyricsFromTag;
end;

procedure TFormID3Tagger.SpeedButton1Click(Sender: TObject);
var PictureStream: TStream;
    FlacTagCoverArt: TFlacTagCoverArtInfo;
    temp, aFilename: string;
    pictureIndex: integer;
    CoverArtInfo: TOpusVorbisCoverArtInfo;
begin
  If Label16.Caption='.flac' then
  begin
    id3Flac:=TFLACfile.Create;
    Picturestream:=TMemorystream.create;
    id3flac.readfromfile(Tag_Liedjes[listbox1.ItemIndex].pad+Tag_Liedjes[listbox1.ItemIndex].Bestandsnaam);
    if id3flac.GetCoverArt(0, Picturestream,FlacTagCoverArt) then
    begin
      Image2.Picture.LoadFromStream(Picturestream);
      CB_IncludeCDCover.Enabled:=True; CB_IncludeCDCover.Checked:=True;
    end
    else
    begin
      Image2.Picture.Clear;
      CB_IncludeCDCover.Enabled:=False; CB_IncludeCDCover.Checked:=False;
    end;
    id3flac.destroy; FreeAndNil(PictureStream);
  end;
  If Label16.Caption='.mp3' then
  begin
    Memo1.Lines.Add('< '+IncludeID3PictureFile[Listbox1.ItemIndex]);
    if IncludeID3Picture[Listbox1.ItemIndex] then Memo1.Lines.Add('TRUE')
                                             else Memo1.Lines.Add('FALSE');
    threadrunning:=true;
    aFilename := Liedjes[TagVolgorde[FormID3Tagger.Listbox1.ItemIndex]].Pad+Liedjes[TagVolgorde[FormID3Tagger.Listbox1.ItemIndex]].Bestandsnaam;

    if (IncludeID3PictureFile[Listbox1.ItemIndex]<>' ') and (IncludeID3PictureFile[Listbox1.ItemIndex]<>'x') then
    begin
      Image2.Picture.LoadFromFile(IncludeID3PictureFile[Listbox1.ItemIndex]);
      CB_IncludeCDCover.Checked:=IncludeID3Picture[Listbox1.ItemIndex]; CB_IncludeCDCover.Enabled:=True;
    end
                                                                                        else
    begin
      Memo1.Lines.Add('GETTING FROM FILE ');
      temp:=Form1.GetCDArtworkFromFile(aFilename);
      if temp<>'x' then
                   begin
                     try
                      Image2.Picture.LoadFromFile(temp);
                      CB_IncludeCDCover.Checked:=True; CB_IncludeCDCover.Enabled:=True;
                     except
                       on E:Exception do begin
                        Image2.Picture.Clear; CB_IncludeCDCover.Enabled:=False;
                        CB_IncludeCDCover.Checked:=true;
                        Memo1.Lines.Add('> ERROR on loading JPEG image on file '+aFilename);
                        Memo1.Lines.Add('> '+E.Message);
                       end;
                     end;
                   end
                 else
                   begin
                     Image2.Picture.Clear;   CB_IncludeCDCover.Enabled:=False;
                     CB_IncludeCDCover.Checked:=False;
                   end;
      threadrunning:=false;
    end;
  end;
  If (Label16.Caption='.opus') or (Label16.Caption='.ogg') then
    begin
       id3OpusTest:=TOpusTag.Create; Picturestream:=TMemorystream.create;
       id3OpusTest.LoadFromFile(Tag_Liedjes[listbox1.ItemIndex].pad+Tag_Liedjes[listbox1.ItemIndex].Bestandsnaam);
       pictureIndex:=id3OpusTest.FrameExists('METADATA_BLOCK_PICTURE');
       if pictureindex>0 then
       begin
         if id3OpusTest.GetCoverArtFromFrame(pictureIndex,PictureStream,CoverArtInfo) then
         begin
           Image2.Picture.LoadFromStream(Picturestream);
           CB_IncludeCDCover.Enabled:=True; CB_IncludeCDCover.Checked:=True;
         end
       end
       else
       begin
         Image2.Picture.Clear;
         CB_IncludeCDCover.Enabled:=False; CB_IncludeCDCover.Checked:=False;
       end;
       id3OpusTest.Free;
    end;
end;

procedure TFormID3Tagger.SpeedButton2Click(Sender: TObject);
var i: longint;
begin
  for i:=0 to ListBox1.Items.Count-1 do
  begin
    if Listbox1.Selected[i] then
    begin;
      IncludeLyric[i]:=False;
    end;
  end;
  CB_IncludeLyric.Checked:=False;
end;

procedure TFormID3Tagger.SpeedButton3Click(Sender: TObject);
var i: longint;
begin
  for i:=0 to ListBox1.Items.Count-1 do
  begin
    if Listbox1.Selected[i] then
    begin;
      IncludeLyric[i]:=True;
    end;
  end;
  CB_IncludeLyric.Checked:=True;
end;

procedure TFormID3Tagger.SpeedButton4Click(Sender: TObject);
var i: integer;
begin
  ProgressBar1.Max:=Listbox1.Items.Count-1;
  ProgressBar1.Position:=0;
  Speedbutton4.Enabled:=False;
  Screen.Cursor:=crHourglass;
  For i:=0 to Listbox1.Count-1 do
  begin
    ProgressBar1.Position:=i;
    SaveID3ToTags(i);
  end;
  Screen.cursor:=crDefault;
  Speedbutton4.Enabled:=True;
  Application.ProcessMessages;
end;

procedure TFormID3Tagger.GetHaikuTags(i: integer);
var AProcess: TProcess;
    lijn, temp: string;
    AStringlist: TStringlist;
    x: integer;
begin
  AProcess:=TProcess.Create(nil);
  lijn:=Tag_Liedjes[i].Pad+Tag_Liedjes[i].Bestandsnaam+'"';
  AProcess.CommandLine:='listattr -l "'+lijn;
  AProcess.Options:=AProcess.Options+[poWaitOnExit, poUsePipes];
  AProcess.Execute;
  //Reading the output the bad way :)
  AStringlist:=TStringlist.Create;
  AStringlist.LoadFromStream(AProcess.Output);
  //DB Fields
  Memo1.Lines.Add('> GetHaikuTags for '+inttostr(i));
  if AStringlist.Count>0 then
    for x:=0 to AStringlist.Count-1 do
    begin
      if pos('"Audio:Artist"',AStringlist.Strings[x])>0 then
      begin
       changedTag[i]:=True;
       lijn:=trim(AStringlist.Strings[x]);
       Delete(lijn,1,pos('"Audio:Artist"',lijn)+14);
       lijn:=trim(lijn);
       Tag_Liedjes[i].Artiest:=lijn;
      end;
      if pos('"Audio:Album"',AStringlist.Strings[x])>0 then
      begin
       changedTag[i]:=True;
       lijn:=trim(AStringlist.Strings[x]);
       Delete(lijn,1,pos('"Audio:Album"',lijn)+13);
       lijn:=trim(lijn);
       Tag_Liedjes[i].CD:=lijn;
      end;
      if pos('"Media:Title"',AStringlist.Strings[x])>0 then
      begin
       changedTag[i]:=True;
       lijn:=trim(AStringlist.Strings[x]);
       Delete(lijn,1,pos('"Media:Title"',lijn)+13);
       lijn:=trim(lijn);
       Tag_Liedjes[i].Titel:=lijn;
      end;
      if pos('"Media:Year"',AStringlist.Strings[x])>0 then
      begin
       changedTag[i]:=True;
       lijn:=trim(AStringlist.Strings[x]);
       Delete(lijn,1,pos('"Media:Year"',lijn)+12);
       lijn:=trim(lijn);
       Tag_Liedjes[i].Jaartal:=lijn;
      end;
      if pos('"Media:Comment"',AStringlist.Strings[x])>0 then
      begin
       changedTag[i]:=True;
       lijn:=trim(AStringlist.Strings[x]);
       Delete(lijn,1,pos('"Media:Comment"',lijn)+15);
       lijn:=trim(lijn);
       Tag_Liedjes[i].Comment:=lijn;
      end;
      if pos('"Audio:Track"',AStringlist.Strings[x])>0 then
      begin
       changedTag[i]:=True;
       lijn:=trim(AStringlist.Strings[x]);
       Delete(lijn,1,pos('"Audio:Track"',lijn)+13);
       lijn:=trim(lijn);
    //   ShowMessage(lijn);
       Tag_Liedjes[i].Track:=strtointdef(lijn,0);
      end;
      if pos('"Media:Genre"',AStringlist.Strings[x])>0 then
      begin
       changedTag[i]:=True;
       lijn:=trim(AStringlist.Strings[x]);
       Delete(lijn,1,pos('"Media:Genre"',lijn)+13);
       lijn:=trim(lijn);
       //ShowMessage(lijn);
       Tag_Liedjes[i].Genre:=lijn;
      end
    end;
  AProcess.Free;
  AStringlist.Free;
end;

procedure TFormID3Tagger.SpeedButton5Click(Sender: TObject);
var i: integer;
begin
  If Listbox1.Items.Count>0
    then
    begin
      Speedbutton5.Enabled:=False;
      ProgressBar1.Max:=ListBox1.Items.count-1;
      For i:=0 to Listbox1.Count-1 do
      begin
        ProgressBar1.Position:=i;
        GetHaikuTags(i);
        Application.ProcessMessages;
      end;
      Speedbutton5.Enabled:=True;
      ShowMessage('ID3-Tags has been updated for '+inttostr(i)+' files.'+#13
                  +'Changes noet yet saved. Press the save button to save the changes.');
    end;
end;

procedure TFormID3Tagger.SpeedButton8Click(Sender: TObject);
begin
  ShowMessage('Work in progress - BUTTON not yet assigned');
end;

procedure TFormID3Tagger.SpeedButton9Click(Sender: TObject);
begin
  ShowMessage('Work in progress - BUTTON not yet assigned');
end;

procedure TFormID3Tagger.TaggerListbox1Clicked(Sender: TObject;
  var Done: Boolean);
begin
  if Sender<>MI_Save then Application.RemoveOnIdleHandler(@TaggerListbox1Clicked);
  if index<>Listbox1.ItemIndex then
  begin
    Listbox1.Cursor:=crHourGlass;
    Memo1.Lines.Add('# Reading '+Tag_Liedjes[Listbox1.ItemIndex].Bestandsnaam);
    Application.ProcessMessages;
    index:=Listbox1.ItemIndex;

    ReloadCurrentSongTags;
    ReloadCueSheet;
    ReloadLyrics;
    CB_IncludeLyric.Checked:=IncludeLyric[index];
    Memo1.Lines.Add('# Reading '+inttostr(Listbox1.ItemIndex));

    if (Listbox1.Count>1) and ((Label16.Caption='.flac') or (Label16.Caption='.mp3') or (Label16.Caption='.opus')) then
      SpeedButton1Click(Self);

    Listbox1.Cursor:=crDefault;
  end;
end;

procedure TFormID3Tagger.TextClear(Sender: TObject);
var
  Edit: TEdit;
begin
  Edit := TEdit(TMenuItem(Sender).Tag);
  Edit.Clear;
end;

procedure TFormID3Tagger.TextCopy(Sender: TObject);
var
  Edit: TEdit;
begin
  Edit := TEdit(TMenuItem(Sender).Tag);
  Edit.CopyToClipboard;
end;

procedure TFormID3Tagger.TextCut(Sender: TObject);
var
  Edit: TEdit;
begin
  Edit := TEdit(TMenuItem(Sender).Tag);
  Edit.CutToClipboard;
end;

procedure TFormID3Tagger.TextPaste(Sender: TObject);
var
  Edit: TEdit;
begin
  Edit := TEdit(TMenuItem(Sender).Tag);
  Edit.PasteFromClipboard;
end;

procedure TFormID3Tagger.ModifyTagAll(Act: Integer; oper: TTextOperation);
var
  Song: Integer;
begin
  for Song:=0 to ListBox1.Items.Count-1 do
  begin
    if Listbox1.Selected[Song] then
      ModifyTag(Song, Act, oper);
  end;
end;

procedure TFormID3Tagger.ModifyTag(Song, Act: Integer; oper: TTextOperation);
var
  newValue: string;
  modified: boolean;
  ActStr: string;

  procedure ReplaceWords(var aString: string);
  var
    i: Integer;
  begin
    for i:=0 to fSearchWords.Count-1 do
      aString := StringReplace(aString, fSearchWords[i], fReplaceWords[i], [rfReplaceAll]);
  end;

  function CapitalizeWords(const OldValue: string; OnlyFirst:Boolean): string;
  var
    p: pchar;
    Str: string;
    aChar, uChar: string;
    NumOfChanges: Integer;
    i, j, k, aLen: Integer;
  begin
    // should be a better way .... :)
    //
    NumOfChanges := 0;
    Str := UTF8Trim(OldValue);       // make an option for it
    Result := UTF8LowerString(Str);
    // replace words
    ReplaceWords(result);

    //
    i := 1;
    aLen := UTF8Length(Result);
    while i<=aLen do
    begin
      aChar := UTF8Copy(result, i, 1);
      if not (aChar[1] in [#0..' ','.',':']) then
      begin
        uChar := UTF8UpperString(aChar);
        if aChar<>uChar then
        begin

          j := i;
          // skip until next separator or end
          inc(i);
          while (i<=aLen) and (not (UTF8Copy(result, i, 1)[1] in [#0..' ','.',':'])) do
            inc(i);

          inc(NumOfChanges);
          if (NumOfChanges>1) and (fIgnoreWords.Count>0) then
          begin
            // process ignore words (except by the first one)
            p := @result[j];
            inc(p, i-j);
            aChar[1] := p^;
            p^ := #0;
            p := @result[j];
            k := fIgnoreWords.IndexOf(p);
            inc(p, i-j);
            p^ := aChar[1];
            if k>=0 then
              continue;
          end;
          // a character has been successfully made uppercase, replace it
          UTF8Delete(Result, j, 1);
          UTF8Insert(uChar, Result, j);
          if (NumOfChanges=1) and OnlyFirst then
            break;

          Continue;
        end;
      end;
      inc(i);
    end;
  end;

  function TxCaps(OldValue:string): string;
  begin
    case Oper of
      topAllCaps:
        begin
          if fSearchWords.Count>0 then
          begin
            result := UTF8LowerCase(OldValue);
            ReplaceWords(result);
          end else
            result := OldValue;
          result := UTF8UpperString(result);
        end;
      topFirstAllCaps:  result := CapitalizeWords(OldValue, false);
      topFirstCaps:     result := CapitalizeWords(OldValue, true);
      topAllLower:
        begin
          if fSearchWords.Count>0 then
          begin
            result := UTF8LowerCase(OldValue);
            ReplaceWords(result);
          end else
            result := OldValue;
          result := UTF8LowerString(result);
        end;
    end;
  end;

begin

  if (Song<0) or (Song>Listbox1.Count-1) then
    exit;

  case Oper of
    topAllCaps, topFirstAllCaps, topFirstCaps, topAllLower:
      begin
        case Oper of
          topAllCaps:       actStr := 'All caps';
          topFirstAllCaps:  actStr := 'Each word upcase first';
          topFirstCaps:     actStr := 'First word upcase first';
          topAllLower:      actStr := 'All lowercase';
        end;

        case fActions[Act].Item of
        taGroupTitel:   NewValue := TxCaps(Tag_Liedjes[Song].GroupTitel );
        taTitel:        NewValue := TxCaps(Tag_Liedjes[Song].Titel      );
        taSubTitel:     NewValue := TxCaps(Tag_Liedjes[Song].SubTitel   );
        taArtiest:      NewValue := TxCaps(Tag_Liedjes[Song].Artiest    );
        taOrigArtiest:  NewValue := TxCaps(Tag_Liedjes[Song].OrigArtiest);
        //taOrigYear:     NewValue := TxCaps(Tag_Liedjes[Song].OrigYear   );
        taOrigTitle:    NewValue := TxCaps(Tag_Liedjes[Song].OrigTitle  );
        taCD:           NewValue := TxCaps(Tag_Liedjes[Song].CD         );
        taGenre:        NewValue := TxCaps(Tag_Liedjes[Song].Genre      );
        taComment:      NewValue := TxCaps(Tag_Liedjes[Song].Comment    );
        taCopyright:    NewValue := TxCaps(Tag_Liedjes[Song].Copyright  );
        taEncoder:      NewValue := TxCaps(Tag_Liedjes[Song].Encoder    );
        //taJaartal:      NewValue := TxCaps(Tag_Liedjes[Song].Jaartal    );
        taComposer:     NewValue := TxCaps(Tag_Liedjes[Song].Composer   );
        taOrchestra:    NewValue := TxCaps(Tag_Liedjes[Song].Orchestra  );
        taConductor:    NewValue := TxCaps(Tag_Liedjes[Song].Conductor  );
        taInterpreted:  NewValue := TxCaps(Tag_Liedjes[Song].Interpreted);
        //taTrack:        NewValue := TxCaps(Tag_Liedjes[Song].Track      );
        end;
      end;
    topChange:
      begin
        newValue := fActions[Act].Edit.Text;
        actStr := 'changed';
      end;
    topClear:
      begin
        newValue := '';
        actStr := 'cleared';
      end;
    topRenumber:
      begin
        inc(fCurrentTrack);
        newValue := IntToStr(fCurrentTrack);
        actStr := format('renumbered %d -> %s',[Tag_Liedjes[Song].Track, newValue]);
      end;
  end;

  modified := false;

  case fActions[Act].Item of
    taGroupTitel:   Modified := Tag_Liedjes[Song].GroupTitel  <> newValue;
    taTitel:        Modified := Tag_Liedjes[Song].Titel       <> newValue;
    taSubTitel:     Modified := Tag_Liedjes[Song].SubTitel    <> newValue;
    taArtiest:      Modified := Tag_Liedjes[Song].Artiest     <> newValue;
    taOrigArtiest:  Modified := Tag_Liedjes[Song].OrigArtiest <> newValue;
    taOrigYear:     Modified := Tag_Liedjes[Song].OrigYear    <> newValue;
    taOrigTitle:    Modified := Tag_Liedjes[Song].OrigTitle   <> newValue;
    taCD:           Modified := Tag_Liedjes[Song].CD          <> newValue;
    taGenre:        Modified := Tag_Liedjes[Song].Genre       <> newValue;
    taComment:      Modified := Tag_Liedjes[Song].Comment     <> newValue;
    taCopyright:    Modified := Tag_Liedjes[Song].Copyright   <> newValue;
    taEncoder:      Modified := Tag_Liedjes[Song].Encoder     <> newValue;
    taJaartal:      Modified := Tag_Liedjes[Song].Jaartal     <> newValue;
    taComposer:     Modified := Tag_Liedjes[Song].Composer    <> newValue;
    taOrchestra:    Modified := Tag_Liedjes[Song].Orchestra   <> newValue;
    taConductor:    Modified := Tag_Liedjes[Song].Conductor   <> newValue;
    taInterpreted:  Modified := Tag_Liedjes[Song].Interpreted <> newValue;
    taTrack:        Modified := Tag_Liedjes[Song].Track <> StrToIntDef(newValue, 0);
  end;

  if Modified then
  begin
    {$ifndef debug}
    case fActions[Act].Item of
      taGroupTitel:   Tag_Liedjes[Song].GroupTitel  := newValue;
      taTitel:        Tag_Liedjes[Song].Titel       := newValue;
      taSubTitel:     Tag_Liedjes[Song].SubTitel    := newValue;
      taArtiest:      Tag_Liedjes[Song].Artiest     := newValue;
      taOrigArtiest:  Tag_Liedjes[Song].OrigArtiest := newValue;
      taOrigYear:     Tag_Liedjes[Song].OrigYear    := newValue;
      taOrigTitle:    Tag_Liedjes[Song].OrigTitle   := newValue;
      taCD:           Tag_Liedjes[Song].CD          := newValue;
      taGenre:        Tag_Liedjes[Song].Genre       := newValue;
      taComment:      Tag_Liedjes[Song].Comment     := newValue;
      taCopyright:    Tag_Liedjes[Song].Copyright   := newValue;
      taEncoder:      Tag_Liedjes[Song].Encoder     := newValue;
      taJaartal:      Tag_Liedjes[Song].Jaartal     := newValue;
      taComposer:     Tag_Liedjes[Song].Composer    := newValue;
      taOrchestra:    Tag_Liedjes[Song].Orchestra   := newValue;
      taConductor:    Tag_Liedjes[Song].Conductor   := newValue;
      taInterpreted:  Tag_Liedjes[Song].Interpreted := newValue;
      taTrack:        Tag_Liedjes[Song].Track       := StrToIntDef(newValue, 0);
    end;
    changedTag[Song]:=True;
    {$endif}
    Memo1.Lines.Add('> '+fActions[Act].Log+' TAG '+actStr+' for '+Tag_Liedjes[Song].Bestandsnaam);
  end;
end;

procedure TFormID3Tagger.ClearAllTag(Act: Integer);
var
  Song: Integer;
begin
  for Song:=0 to Listbox1.Items.Count-1 do
    if Listbox1.Selected[Song] then
      ModifyTag(Song, Act, topClear);
end;

// This method registers an action, where each action links a song's Tag element
// with several controls, each control having a specific effect on the linked
// tag element.
procedure TFormID3Tagger.RegisterControlAction(Item: TTagItem; Edit: TEdit;
  Btn: TButton; Mnu: TMenuItem; LogMsg: TLogStr);
var
  Act: Integer;
begin
  Act := Length(fActions);
  SetLength(fActions, Act+1);
  fActions[Act].Item := Item;
  fActions[Act].Log := LogMsg;
  fActions[Act].Edit := Edit;

  Edit.Tag := Act;
  Edit.OnEditingDone := @EditorAction;
  Edit.OnChange := @EditorChanged;
  if Btn<>nil then
  begin
    Btn.Tag := Act;
    Btn.OnClick := @EditorAction;
  end;
  if Mnu<>nil then
  begin
    Mnu.Tag := Act;
    Mnu.OnClick := @EditorAction;
  end;
end;

procedure TFormID3Tagger.EditorAction(Sender: TObject);
var
  Song, Act: Integer;
begin
  {$ifdef debug}
  Memo1.Lines.Add('> THE NEXT IS FOR DEBUGGING PURPOSES .... ');
  {$endif}
  // tag is the index to the array of control actions
  Act := TComponent(Sender).Tag;

  if Sender is TMenuItem then
    // clear the tag element linked by the menu item for all selected songs
    ClearAllTag(Act);

  if Sender is TButton then begin
    CommitEditorPendingChanges;
    // change the tag element linked to the TEdit just edited for the current song
    ModifyTagAll(Act, topChange);
  end;

  if sender is TEdit then
  begin
    fLastChangedEdit := nil;
    // change the tag element linked to the TEdit just edited for the current song
    Song := Index;
    if Song<0 then
      raise exception.CreateFmt('Can''t apply %s to the %s tag because there is no song selected',
        [QuotedStr(fActions[Act].Edit.Text), QuotedStr(fActions[Act].Log)]);

    ModifyTag(Song, Act, topChange);
  end;

  ReloadCurrentSongTags;
end;

procedure TFormID3Tagger.EditorChanged(Sender: TObject);
begin
  fLastChangedEdit := TEdit(Sender);
end;

procedure TFormID3Tagger.CommitEditorPendingChanges;
begin
  if fLastChangedEdit<>nil then
    EditorAction(fLastChangedEdit);
end;

procedure TFormID3Tagger.ReloadCueSheet;
var
  Filevar: TextFile;
  Track: byte;
  Song_Index: string;
  Song_Title: string;
  Song_Artist: string;
  temp: string;
  CD_Title: string;
  lijn: string;
  tempfilename: string;
  ext: string;
begin
  if ListBox1.Count>1 then
    exit; // no brain to load all lyrics

  ext := Label16.Caption; tempfilename := Tag_Liedjes[Listbox1.ItemIndex].Pad +
    Tag_Liedjes[Listbox1.ItemIndex].Bestandsnaam;
  if (ext = '.mp3') or (ext = '.flac') or (ext = '.opus') or (ext = '.ogg')  then
  begin
    ScrollBox1.Enabled := True;
  end
  else
  begin
    ScrollBox1.Enabled := False;
  end;

  Delete(tempfilename, length(tempfilename) - length(ext) + 1, length(ext));
    tempfilename := tempfilename + '.cue';
  if fileexists(tempfilename) then
  begin
    Memo1.Lines.Add('   CUE Sheet found ...');
    Label_CUE.Caption := Form1.Vertaal('CUE Sheet found'); Track := 0;
    if FileExistsUTF8(tempfilename) then
    begin
      AssignFile(Filevar, tempfilename);
      Reset(Filevar);
      repeat
        Readln(Filevar, lijn); temp := lijn;
        if pos('DATE', temp) > 0 then
        begin
          Delete(temp, 1, 9); Edit_Year.Text := temp;
        end;
        if pos('GENRE', temp) > 0 then
        begin
          Delete(temp, 1, 11); Delete(temp, length(temp), 1); Edit_Genre.Text
            := temp;
        end;
      until pos('REM ', lijn) < 1;
      repeat
        Readln(Filevar, lijn);
        //if pos('PERFORMER ',lijn)>0 then CD_Artist:=copy(Lijn,9,length(lijn));
        if pos('TITLE ', lijn) > 0 then
        begin
          CD_Title := copy(lijn, 8, length(lijn));
          Delete(CD_Title, length(CD_Title), 1);
        end;
      until pos('FILE ', lijn) > 0;
      repeat
        Readln(Filevar, lijn);
        if pos('TRACK ', lijn) > 0 then
        begin
           inc(Track);
           StringGridCue.RowCount := Track + 1;
           StringGridCue.Cells[0, Track] := inttostr(Track);
        end;
        if pos('TITLE "', lijn) > 0 then
        begin
          Song_Title := copy(lijn, pos('"', lijn) + 1, length(lijn));
          Delete(Song_Title, length(Song_Title), 1);
          StringGridCue.Cells[2, Track] := Song_Title;
        end;
        if pos('PERFORMER "', lijn) > 0 then
        begin
         Song_Artist := copy(lijn, pos('"', lijn) + 1, length(lijn));
         Delete(Song_Artist, length(Song_Artist), 1);
         StringGridCue.Cells[1, Track] := Song_Artist;
        end;
        if pos('INDEX ', lijn) > 0 then
        begin
         Song_Index := lijn;
         Delete(Song_Index, 1, pos('DEX ', Song_Index) + 6);
         Delete(Song_Index, length(Song_Index) - 2, 3);
         StringGridCue.Cells[3, Track] := Song_Index;
        end;
      until eof(Filevar);
      CloseFile(Filevar);
      Edit_AlbumCue.Text := CD_Title;
      StringGridCue.AutoSizeColumns;
    end;
  end
  else
  begin
    Memo1.Lines.Add('   No CUE Sheet found ...');
    Label_CUE.Caption := Form1.Vertaal('No CUE Sheet found');
      StringGridCue.RowCount := 1;
     Edit_AlbumCUE.Text := '';
  end;
end;

procedure TFormID3Tagger.ReloadLyrics;
begin
  //if ListBox1.Count>1 then exit; // no brain to load all lyrics

  CB_IncludeLyric.Checked:=IncludeLyric[Listbox1.ItemIndex];
  //if IncludeLyric[i] then SB_ReloadLyricClick(Self);

  if SB_Save.Enabled then
  begin
    ReloadLyricsFromTag;
    lyricchanged := false;
    if IncludeLyric[Listbox1.ItemIndex] then if Memo2.Lines.Count<2 then ReloadLyricsFromLocalStorage;
  end
  else if IncludeLyric[Listbox1.ItemIndex] then ReloadLyricsFromLocalStorage;
end;

procedure TFormID3Tagger.ReloadLyricsFromLocalStorage;
var
  tempfilename: string;
begin
  tempfilename := Configdir + Directoryseparator + 'songtext' +
    Directoryseparator + Form1.ConvertArtist(Edit_Artist.Text, false) + '-' +
    Form1.ConvertTitle(Edit_Title.Text) + '.lrc';
  if fileexists(tempfilename) then Memo2.Lines.LoadFromFile(tempfilename)
                              else Memo2.Lines.Clear;
  if Memo2.Lines.Count > 0 then
  begin;
    if SB_Save.Enabled then
    begin;
      // if something is modified,
      LyricChanged := True;
      changedTag[Listbox1.ItemIndex] := True;
      Memo1.Lines.Add('> LYRICS Changed for ' + Tag_Liedjes[Listbox1.ItemIndex].Bestandsnaam);
    //  IncludeLyric[Listbox1.ItemIndex]:=CB_IncludeLyric.Checked;
    end;
  end;
end;

procedure TFormID3Tagger.ReloadLyricsFromTag;
var
  i: longint;
begin
  i := ListBox1.ItemIndex;
  LyricChanged := False;
  SB_SaveLyricLocalStorage.Enabled := False;
  changedTag[i] := False;
  Form1.GetId3Extra(TagVolgorde[i]);
  if length(id3extra.lyric) > 1 then
  begin
    CB_IncludeLyric.Checked := True;
    IncludeLyric[i] := CB_IncludeLyric.Checked;
    Memo2.Text := id3extra.lyric;
  end
  else Memo2.Lines.Clear;
end;

procedure TFormID3Tagger.ReloadCurrentSongTags;
var
  Song: Integer;
begin
  Song := Listbox1.ItemIndex;

  Label1.Caption := inttostr(Song + 1) + '/' + inttostr(
    Listbox1.Items.Count) + ':';

  Label16.Caption := lowercase(ExtractFileExt(Tag_Liedjes[Song
    ].Bestandsnaam));
  Edit_File.Text := copy(Tag_Liedjes[Song].Bestandsnaam, 1, length
    (Tag_Liedjes[Song].Bestandsnaam) - length(label16.Caption));

  Edit_Title.Text := Tag_Liedjes[Song].Titel;
  Edit_GroupTitle.Text := Tag_Liedjes[Song].GroupTitel;
  Edit_SubTitle.Text := Tag_Liedjes[Song].SubTitel;
  Edit_Artist.Text := Tag_Liedjes[Song].Artiest;
  Edit_Album.Text := Tag_Liedjes[Song].CD;
  if Tag_Liedjes[Song].Track < 1 then Edit_Track.Text := ''
    else Edit_Track.Text := inttostr(Tag_Liedjes[Song].Track);

  Edit_Year.Text := Tag_Liedjes[Song].Jaartal;
  Edit_Genre.Text := Tag_Liedjes[Song].Genre;
  Edit_Comment.Text := Tag_Liedjes[Song].Comment;
  Edit_Composer.Text := Tag_Liedjes[Song].Composer;
  Edit_OrigArtist.Text := Tag_Liedjes[Song].OrigArtiest;
  Edit_OrigTitle.Text := Tag_Liedjes[Song].OrigTitle;
  Edit_OrigYear.Text := Tag_Liedjes[Song].OrigYear;
  Edit_Copyright.Text := Tag_Liedjes[Song].Copyright;
  Edit_Encoded.Text := Tag_Liedjes[Song].Encoder;
  Edit_Orchestra.Text := Tag_Liedjes[Song].Orchestra;
  Edit_Conductor.Text := Tag_Liedjes[Song].Conductor;
  Edit_Interpreted.Text := Tag_Liedjes[Song].Interpreted;

  StatusBar1.Panels[0].Text := inttostr(TagVolgorde[Song]) +
    ' - ' + Tag_Liedjes[Song].Pad + Tag_Liedjes[Song].Bestandsnaam;
end;

procedure TFormID3Tagger.SaveLyricsToLocalStorage;
begin
  if Memo2.Lines.Count = 0 then
  begin
    if not FormShowMyDialog.ShowWith(
            Form1.Vertaal('WARNING'), Form1.Vertaal('No'+' text available.'), '',
            Form1.Vertaal('DELETE EXISTING LYRICS?'),
            Form1.Vertaal('NO'),
            Form1.Vertaal('YES'), False)
    then
      DeleteFile(Configdir + Directoryseparator + 'songtext' +
        Directoryseparator + Form1.ConvertArtist(Edit_Artist.Text, false) +
        '-' + Form1.ConvertTitle(Edit_Title.Text) + '.lrc');
  end
  else
    Memo2.Lines.SaveToFile(Configdir + Directoryseparator + 'songtext' +
      Directoryseparator + Form1.ConvertArtist(Edit_Artist.Text, false) + '-' +
      Form1.ConvertTitle(Edit_Title.Text) + '.lrc');
  SB_SaveLyricLocalStorage.Enabled := False; LyricChanged := False;
end;

procedure TFormID3Tagger.Log(fmt: string; args: array of const;
  ForceUpdate: boolean);
begin
  Memo1.Lines.Add(format(fmt, args));
  if ForceUpdate then
    Application.ProcessMessages;
end;

initialization

end.

