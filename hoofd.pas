unit hoofd;

{$if not defined(HAIKU)}
{$R theme.rc}
{$IFEND}

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, Menus,
  ComCtrls, ExtCtrls, StdCtrls, Grids, Buttons, wizard, Process, Splash,
  ID3v1, ID3v2, OggVorbis, FLACfile, APEtag, songdetails, configuration,
  httpsend, LazHelpHTML, UTF8Process, Spin, ShellCtrls, ActnList, BCLabel,
  BGRAFlashProgressBar, BGRAImageList, thumbcontrol, showmydialog,
  MP4file, coverplayer, renamesong, newplaylist, addradio,
  recordplan, nieuwepodcast, downloadlist, lazutf8, filltagfromfile, debuglog,
  zipper, types, eq, search, ripcd, fillincd, about, filetools, LazFileUtils,
  fx_echo, fx_flanger, fx_reverb, LclIntf, id3tagger, OggVorbisAndOpusTagLibrary,
  fetchlyrics, lazutf8classes, VuViewer, LMessages, LclType, LResources,
  blcksock, synsock, GridSelection, ssl_openssl
  {$if defined(WINDOWS) or defined(LINUX)}, basscd{$IFEND}
  {$IFDEF HAIKU}  {$ELSE}, Bass, bass_fx {$ENDIF};


const
  GOT_CONNECTION = WM_USER + 1001;
  GOT_STRING = WM_USER + 1002;

type
  TMessage = TLMessage;

type
  TTCPListenDaemon = class(TThread)
  private
    Sock: TTCPBlockSocket;
  public
    constructor Create;
    destructor Destroy; override;
    procedure Execute; override;
  end;

  TTCPReceiveThrd = class(TThread)
  private
    Sock: TTCPBlockSocket;
    CSock: TSocket;
  public
    constructor Create(hsock: tSocket);
    procedure Execute; override;
  end;


type

  { TForm1 }

  TForm1 = class(TForm)
    ActionSearch: TAction;
    ActionRepeat: TAction;
    ActionShuffle: TAction;
    ActionMediaMode: TAction;
    ActionChoseMP3: TAction;
    ActionChoseRadio: TAction;
    ActionConfig: TAction;
    ActionAbout: TAction;
    BCLabel1: TBCLabel;
    Bevel1: TBevel;
    Bevel2: TBevel;
    BitBtn1: TBitBtn;
    CB_ShowAllThumbs: TCheckBox;
    Edit4: TEdit;
    Edit5: TEdit;
    Image1: TImage;
    ImageListBackDrop: TImageList;
    ImageListLCD: TImageList;
    MenuItem1: TMenuItem;
    MenuItem115: TMenuItem;
    MenuItem122: TMenuItem;
    MenuItem2: TMenuItem;
    MenuItem3: TMenuItem;
    MI_SGALL_Wiki: TMenuItem;
    MenuItem92: TMenuItem;
    MI_SGAll_Play2: TMenuItem;
    MenuItem127: TMenuItem;
    MenuItem133: TMenuItem;
    MenuItem134: TMenuItem;
    MenuItem141: TMenuItem;
    MenuItem142: TMenuItem;
    MI_SGALL_AddAll: TMenuItem;
    MenuItem144: TMenuItem;
    MI_AddToPlaylist1: TMenuItem;
    MI_RemoveFromPlaylist: TMenuItem;
    MenuItem147: TMenuItem;
    MI_SGALL_CopyTo: TMenuItem;
    MI_SGALL_Rename: TMenuItem;
    MI_SGALL_Delete: TMenuItem;
    MenuItem151: TMenuItem;
    MenuItem152: TMenuItem;
    MI_FadingOptions1: TMenuItem;
    MenuItem154: TMenuItem;
    MenuItem155: TMenuItem;
    MI_SGALL_OpenFolder: TMenuItem;
    MenuItem157: TMenuItem;
    MI_SGALL_About: TMenuItem;
    MI_SGALL_ShowLog: TMenuItem;
    MI_SGALL_AddToBegin: TMenuItem;
    MI_SGALL_AddToEnd: TMenuItem;
    MenuItem162: TMenuItem;
    MI_SGALL_AddAfterCurrent: TMenuItem;
    MI_SGALL_CopyToFolder: TMenuItem;
    MenuItem165: TMenuItem;
    MenuItem166: TMenuItem;
    MenuItem167: TMenuItem;
    MenuItem168: TMenuItem;
    MI_SGALL_Tagger: TMenuItem;
    MenuItem170: TMenuItem;
    MI_SGALL_SetFade: TMenuItem;
    MI_SGALL_RemoveFade: TMenuItem;
    MI_SGALL_SameArtist: TMenuItem;
    MI_SGALL_SameAlbum: TMenuItem;
    MI_SGALL_SameGenre: TMenuItem;
    MI_SGALL_SameYear: TMenuItem;
    MenuItem177: TMenuItem;
    MI_SGALL_ShowInfo: TMenuItem;
    MenuItem179: TMenuItem;
    MI_SGALL_ShowInVirtualFS: TMenuItem;
    MenuItem90: TMenuItem;
    MI_SGAll_Play1: TMenuItem;
    MI_PlayCDfromCover: TMenuItem;
    MenuItem116: TMenuItem;
    MenuItem121: TMenuItem;
    MI_DeleteAlbum: TMenuItem;
    MenuItem126: TMenuItem;
    MI_TagCDFromCover: TMenuItem;
    MenuItem128: TMenuItem;
    MenuItem129: TMenuItem;
    MenuItem132: TMenuItem;
    Mi_AddBeginQueue: TMenuItem;
    MI_AddPlayingQueue: TMenuItem;
    MenuItem135: TMenuItem;
    MenuItem136: TMenuItem;
    MenuItem137: TMenuItem;
    MenuItem138: TMenuItem;
    MenuItem139: TMenuItem;
    MenuItem140: TMenuItem;
    SearchPanelBrowser: TPanel;
    SearchPanelQueue: TPanel;
    PM_CDCoverBrowser: TPopupMenu;
    PM_SGAll: TPopupMenu;
    SpeedButton13: TSpeedButton;
    SpeedButton15: TSpeedButton;
    SpeedButton28: TSpeedButton;
    SpeedButton29: TSpeedButton;
    SpeedButton30: TSpeedButton;
    SpeedButton4: TSpeedButton;
    Ster0: TImage;
    Ster1: TImage;
    Ster2: TImage;
    Ster5: TImage;
    Ster4: TImage;
    Ster3: TImage;
    ImageCDCoverLyric: TImage;
    ImageCDCover: TImage;
    Image9: TImage;
    ImageListVU: TBGRAImageList;
    ImageListOthers: TBGRAImageList;
    ImageListRepeat: TBGRAImageList;
    ImageListEQ: TBGRAImageList;
    ImageListStars: TBGRAImageList;
    Label29: TLabel;
    Label34: TLabel;
    Label35: TLabel;
    Label36: TLabel;
    MenuItem105: TMenuItem;
    MI_CopyToLocal1: TMenuItem;
    MenuItem114: TMenuItem;
    MI_VU_Active4: TMenuItem;
    MenuItem12: TMenuItem;
    MenuItem15: TMenuItem;
    MI_CopyToExternal1: TMenuItem;
    ProgressBarSpeed: TBGRAFlashProgressBar;
    CB_Library: TComboBox;
    CB_SubDirs: TCheckBox;
    LB_on: TLabel;
    MI_VU_at_center: TMenuItem;
    MI_VU_at_bottom: TMenuItem;
    MI_VU_showpeaks: TMenuItem;
    MenuItem89: TMenuItem;
    MI_VU_at_top: TMenuItem;
    MI_VU_Active3: TMenuItem;
    MI_Play_ShowInVFS: TMenuItem;
    MenuItem112: TMenuItem;
    SG_Podcast: TStringGrid;
    TabSheetCovers: TTabSheet;
    ThumbControl1: TThumbControl;
    TimerTCP: TTimer;
    TB_ThumbSize: TTrackBar;
    TV_VFS: TTreeView;
    MenuItem101: TMenuItem;
    MenuItem102: TMenuItem;
    TabSheetVirtualFS: TTabSheet;
    TrackBar2: TProgressBar;
    CB_GenreRadio1: TCheckBox;
    CB_Land1: TCheckBox;
    CheckBox4: TCheckBox;
    CB_UseCue: TCheckBox;
    ComboBox1: TComboBox;
    Edit3: TEdit;
    Image2: TImage;
    Label10: TLabel;
    Label28: TLabel;
    LB_Trimmed: TLabel;
    Label2: TLabel;
    Label30: TLabel;
    Label31: TLabel;
    Label32: TLabel;
    Label33: TLabel;
    LB_LastFMInfo: TLabel;
    LB_XiXInfo: TLabel;
    Label_Extra: TLabel;
    LB_CD: TLabel;
    LB_Artiest: TLabel;
    LabelSimilar: TLabel;
    LB_Genre: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    LB_Filename: TLabel;
    LB_GenreRadio1: TComboBox;
    LB_land1: TComboBox;
    LB_MostPlayed: TListBox;
    MemoArtiest: TMemo;
    MenuItem100: TMenuItem;
    MenuItem106: TMenuItem;
    MenuItem107: TMenuItem;
    MenuItem108: TMenuItem;
    MenuItem109: TMenuItem;
    MenuItem24: TMenuItem;
    MenuItem27: TMenuItem;
    MenuItem66: TMenuItem;
    MenuItem81: TMenuItem;
    MenuItem97: TMenuItem;
    Mi_Wiki1EN: TMenuItem;
    MI_Wiki1Custom: TMenuItem;
    MI_GetArtworkFromFile: TMenuItem;
    MenuItem110: TMenuItem;
    MI_About2: TMenuItem;
    MenuItem113: TMenuItem;
    MI_DeleteArtistInfo: TMenuItem;
    MI_Move1: TMenuItem;
    MI_CurrentSong1: TMenuItem;
    MenuItem117: TMenuItem;
    MenuItem118: TMenuItem;
    MenuItem119: TMenuItem;
    MenuItem120: TMenuItem;
    MI_AddFolderToConfig: TMenuItem;
    MI_OpenAlbumInTagger1: TMenuItem;
    MenuItem125: TMenuItem;
    MI_PlayAlbum2: TMenuItem;
    MI_TagAlbum2: TMenuItem;
    MI_PlayArtist1: TMenuItem;
    MI_TagArtist1: TMenuItem;
    MenuItem130: TMenuItem;
    MI_Vu3: TMenuItem;
    MI_ReloadArtistInfo: TMenuItem;
    MenuItem91: TMenuItem;
    MI_CopyToFolder1: TMenuItem;
    MenuItem93: TMenuItem;
    MenuItem94: TMenuItem;
    MenuItem95: TMenuItem;
    MenuItem99: TMenuItem;
    MI_ReloadSongtext: TMenuItem;
    MenuItem96: TMenuItem;
    MenuItem98: TMenuItem;
    MI_RemoveSongtext: TMenuItem;
    OpenDialog1: TOpenDialog;
    OpenDialog2: TOpenDialog;
    Panel15: TPanel;
    PanelLastFM: TPanel;
    PanelXiXInfo: TPanel;
    Panel12: TPanel;
    Panel13: TPanel;
    Panel3: TPanel;
    PM_Songtext: TPopupMenu;
    PM_FX: TPopupMenu;
    PM_Information: TPopupMenu;
    PopupMenu3: TPopupMenu;
    PM_Folder: TPopupMenu;
    PM_Albums: TPopupMenu;
    PopupMenu4: TPopupMenu;
    PM_Artists1: TPopupMenu;
    SB_Copy: TSpeedButton;
    SB_Delete: TSpeedButton;
    SB_New: TSpeedButton;
    SB_Rename: TSpeedButton;
    SB_Save: TSpeedButton;
    SB_LastFM: TSpeedButton;
    SpeedButton34: TSpeedButton;
    SpeedButton35: TSpeedButton;
    SG_Disco: TStringGrid;
    SpeedButton5: TSpeedButton;
    SpeedButton6: TSpeedButton;
    SpeedButton9: TSpeedButton;
    Splitter7: TSplitter;
    SG_CUE: TStringGrid;
    SG_ListenLive: TStringGrid;
    TabSheet1: TTabSheet;
    VuImage: TImage;
    LabelTime: TLabel;
    LabelCDEntry: TLabel;
    Memo1: TMemo;
    MenuItem44: TMenuItem;
    MenuItem50: TMenuItem;
    MenuItem52: TMenuItem;
    MenuItem53: TMenuItem;
    MenuItem55: TMenuItem;
    MenuItem59: TMenuItem;
    MenuItem60: TMenuItem;
    MenuItem74: TMenuItem;
    MenuItem75: TMenuItem;
    MenuItem76: TMenuItem;
    MenuItem77: TMenuItem;
    MenuItem78: TMenuItem;
    MenuItem79: TMenuItem;
    MenuItem80: TMenuItem;
    MenuItem82: TMenuItem;
    MenuItem83: TMenuItem;
    MenuItem84: TMenuItem;
    MI_CDCover_ChooseNewFile: TMenuItem;
    MenuItem86: TMenuItem;
    MI_CDCover_RemoveCDCover: TMenuItem;
    MenuItem88: TMenuItem;
    MI_VU_Active2: TMenuItem;
    MI_VU_Active1: TMenuItem;
    MI_Vu1: TMenuItem;
    MI_Vu2: TMenuItem;
    Mi_ReShuffle: TMenuItem;
    MenuItem61: TMenuItem;
    MenuItem62: TMenuItem;
    MenuItem63: TMenuItem;
    MenuItem64: TMenuItem;
    MenuItem65: TMenuItem;
    MI_AddToPlaylist2: TMenuItem;
    MenuItem67: TMenuItem;
    MenuItem68: TMenuItem;
    MenuItem69: TMenuItem;
    MenuItem70: TMenuItem;
    MenuItem71: TMenuItem;
    MenuItem72: TMenuItem;
    MenuItem73: TMenuItem;
    MI_Stop: TMenuItem;
    MI_Prev: TMenuItem;
    MI_Next: TMenuItem;
    MenuItem54: TMenuItem;
    MI_Fullscreen: TMenuItem;
    MenuItem56: TMenuItem;
    MI_About: TMenuItem;
    MenuItem58: TMenuItem;
    MI_Play: TMenuItem;
    MI_Pauze: TMenuItem;
    ActionPauze: TAction;
    ActionPlay: TAction;
    PanelVolume: TPanel;
    PM_Panel: TPopupMenu;
    ActionPrevious: TAction;
    ActionNext: TAction;
    ActionFullScreen: TAction;
    ActionStop: TAction;
    ActionList1: TActionList;
    Bevel4: TBevel;
    Bevel5: TBevel;
    Bevel7: TBevel;
    CB_GenreRadio: TCheckBox;
    CB_Land: TCheckBox;
    CheckBox1: TCheckBox;
    CB_Year: TCheckBox;
    CB_Genre: TComboBox;
    CB_From1: TCheckBox;
    CB_Station: TCheckBox;
    Edit1: TEdit;
    Edit2: TEdit;
    Ster6: TImage;
    Ster7: TImage;
    Ster8: TImage;
    Ster9: TImage;
    Ster10: TImage;
    Image15: TImage;
    Image16: TImage;
    Label1: TLabel;
    LabelRecordings: TLabel;
    LabelElapsedTime: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    LB_To1: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    LabelLyricSource: TLabel;
    Label20: TLabel;
    Label21: TLabel;
    Label22: TLabel;
    Label23: TLabel;
    Label24: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    LabelPodcast: TLabel;
    LB_RadioWebsite: TLabel;
    LB_RadioNaam: TLabel;
    LB_Search1: TLabel;
    LabelBitrate: TLabel;
    LabelProgram: TLabel;
    LB_GenreRadio: TComboBox;
    LB_land: TComboBox;
    LB_Titel: TLabel;
    LB_Artist1: TListBox;
    LB_Albums2: TListBox;
    LB_Albums1: TListBox;
    LB_Artists2: TListBox;
    LB_Playlist: TListBox;
    LB_M3U: TListBox;
    MemoLyrics: TMemo;
    MenuItem19: TMenuItem;
    MenuItem39: TMenuItem;
    MenuItem40: TMenuItem;
    MenuItem41: TMenuItem;
    MenuItem42: TMenuItem;
    MenuItem43: TMenuItem;
    MI_CopyRecording: TMenuItem;
    MenuItem46: TMenuItem;
    MI_DeleteRecording: TMenuItem;
    MI_AddToPresets: TMenuItem;
    MenuItem45: TMenuItem;
    MI_AddNewradio: TMenuItem;
    MenuItem47: TMenuItem;
    MenuItem48: TMenuItem;
    MenuItem49: TMenuItem;
    MI_RecordFromRadio: TMenuItem;
    MenuItem51: TMenuItem;
    MI_UpdateRadio: TMenuItem;
    MI_GoToAlbum: TMenuItem;
    MI_PlayAlbum: TMenuItem;
    MenuItem13: TMenuItem;
    MenuItem14: TMenuItem;
    PageControl1: TPageControl;
    PageControl2: TPageControl;
    PageControl3: TPageControl;
    PageControl4: TPageControl;
    Panel10: TPanel;
    Panel6: TPanel;
    Panel7: TPanel;
    Panel8: TPanel;
    Panel9: TPanel;
    Panel2: TPanel;
    Panel4: TPanel;
    Panel5: TPanel;
    Panel_VU: TPanel;
    PM_Albums2: TPopupMenu;
    PM_Playlist1: TPopupMenu;
    PM_Radio: TPopupMenu;
    PM_RecordedRadio: TPopupMenu;
    PM_CD: TPopupMenu;
    PM_Play: TPopupMenu;
    PM_CDCover: TPopupMenu;
    PopupMenu2: TPopupMenu;
    SaveDialog1: TSaveDialog;
    SB_CDText: TSpeedButton;
    SB_DeletePreset: TSpeedButton;
    SB_Next: TSpeedButton;
    SB_Info: TSpeedButton;
    SB_Pauze: TSpeedButton;
    SB_Play: TSpeedButton;
    SB_Presets: TSpeedButton;
    SB_RadioAdd: TSpeedButton;
    SB_RadioPlan: TSpeedButton;
    SB_RadioRecord: TSpeedButton;
    SB_ReadCD: TSpeedButton;
    SB_Reverse: TSpeedButton;
    SB_RipCD: TSpeedButton;
    SB_Stop: TSpeedButton;
    SB_Previous: TSpeedButton;
    SelectDirectoryDialog1: TSelectDirectoryDialog;
    Shape1: TShape;
    Shape2: TShape;
    SpeedButton10: TSpeedButton;
    SpeedButton11: TSpeedButton;
    SpeedButton12: TSpeedButton;
    SB_ReadDVD: TSpeedButton;
    StringGridCD: TStringGrid;
    TabSheetCD2: TTabSheet;
    TrayIcon1: TTrayIcon;
    VolumeBar: TTrackBar;
    ShellListView1: TShellListView;
    ShellTreeView1: TShellTreeView;
    SpeedButton1: TSpeedButton;
    SB_RadioUpdate: TSpeedButton;
    SpeedButton14: TSpeedButton;
    SB_ReloadPlaylist: TSpeedButton;
    SpeedButton16: TSpeedButton;
    SpeedButton17: TSpeedButton;
    SpeedButton18: TSpeedButton;
    SpeedButton19: TSpeedButton;
    SpeedButton2: TSpeedButton;
    SpeedButton20: TSpeedButton;
    SpeedButton21: TSpeedButton;
    SpeedButton22: TSpeedButton;
    SpeedButton23: TSpeedButton;
    SpeedButton24: TSpeedButton;
    SpeedButton25: TSpeedButton;
    SpeedButton26: TSpeedButton;
    SpeedButton27: TSpeedButton;
    SB_PodcastUp: TSpeedButton;
    SpeedButton3: TSpeedButton;
    SB_PodcastDown: TSpeedButton;
    SB_PodcastSave: TSpeedButton;
    SB_Config: TSpeedButton;
    SB_Repeat: TSpeedButton;
    SB_Shuffle: TSpeedButton;
    SpeedButton7: TSpeedButton;
    SpeedButton8: TSpeedButton;
    SE_Jaar1: TSpinEdit;
    SE_Jaar2: TSpinEdit;
    Splitter1: TSplitter;
    Splitter2: TSplitter;
    Splitter3: TSplitter;
    SG_All: TStringGrid;
    SG_Play: TStringGrid;
    Splitter4: TSplitter;
    Splitter5: TSplitter;
    Splitter6: TSplitter;
    Splitter8: TSplitter;
    StringGrid1: TStringGrid;
    StringGridPresets: TStringGrid;
    StringGridRadioAir: TStringGrid;
    StringGridRecorded: TStringGrid;
    TabSheetArtists: TTabSheet;
    TabSheet10: TTabSheet;
    TabSheet11: TTabSheet;
    TabSheet12: TTabSheet;
    TabSheetFiles2: TTabSheet;
    TabSheet14: TTabSheet;
    TabSheet15: TTabSheet;
    TabSheet16: TTabSheet;
    TabSheetRadio2: TTabSheet;
    TabSheetPodcast: TTabSheet;
    TabSheetPodcast2: TTabSheet;
    TabSheetAlbums: TTabSheet;
    TabSheetPlaylists: TTabSheet;
    TabSheetFiles: TTabSheet;
    TabSheetRadio: TTabSheet;
    TabSheetCD: TTabSheet;
    TabSheetBrowser: TTabSheet;
    TabSheetPlayQue: TTabSheet;
    Timer1: TTimer;
    TimerSchedule: TTimer;
    VuLeft1: TShape;
    VuLeft10: TShape;
    VuLeft11: TShape;
    VuLeft12: TShape;
    VuLeft2: TShape;
    VuLeft3: TShape;
    VuLeft4: TShape;
    VuLeft5: TShape;
    VuLeft6: TShape;
    VuLeft7: TShape;
    VuLeft8: TShape;
    VuLeft9: TShape;
    VuRight1: TShape;
    VuRight10: TShape;
    VuRight11: TShape;
    VuRight12: TShape;
    VuRight2: TShape;
    VuRight3: TShape;
    VuRight4: TShape;
    VuRight5: TShape;
    VuRight6: TShape;
    VuRight7: TShape;
    VuRight8: TShape;
    VuRight9: TShape;
    procedure ActionSearchExecute(Sender: TObject);
    procedure ActionChoseMP3Execute(Sender: TObject);
    procedure ActionChoseRadioExecute(Sender: TObject);
    procedure ActionNextExecute(Sender: TObject);
    procedure ActionPauzeExecute(Sender: TObject);
    procedure ActionPlayExecute(Sender: TObject);
    procedure ActionPreviousExecute(Sender: TObject);
    procedure ActionStopExecute(Sender: TObject);
    procedure CB_ShowAllThumbsChange(Sender: TObject);
    procedure Edit4KeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure Edit5KeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormActivate(Sender: TObject);
    procedure ImageCDCoverPictureChanged(Sender: TObject);
    procedure Label35MouseEnter(Sender: TObject);
    procedure Label35MouseLeave(Sender: TObject);
    procedure MenuItem102Click(Sender: TObject);
    procedure MenuItem114Click(Sender: TObject);
    procedure MenuItem122Click(Sender: TObject);
    procedure MenuItem123Click(Sender: TObject);
    procedure MenuItem129Click(Sender: TObject);
    procedure MenuItem1Click(Sender: TObject);
    procedure MenuItem3Click(Sender: TObject);
    procedure MenuItem90Click(Sender: TObject);
    procedure MI_SGALL_WikiClick(Sender: TObject);
    procedure MI_SGALL_DeleteClick(Sender: TObject);
    procedure MI_SGALL_ShowInVirtualFSClick(Sender: TObject);
    procedure MI_SGALL_ShowInfoClick(Sender: TObject);
    procedure MI_SGALL_SameYearClick(Sender: TObject);
    procedure MI_SGALL_SameGenreClick(Sender: TObject);
    procedure MI_SGALL_SameAlbumClick(Sender: TObject);
    procedure MI_SGALL_SameArtistClick(Sender: TObject);
    procedure MI_SGALL_AboutClick(Sender: TObject);
    procedure MI_SGALL_ShowLogClick(Sender: TObject);
    procedure MI_SGALL_OpenFolderClick(Sender: TObject);
    procedure MenuItem170Click(Sender: TObject);
    procedure MI_SGALL_RemoveFadeClick(Sender: TObject);
    procedure MI_SGALL_SetFadeClick(Sender: TObject);
    procedure MI_SGALL_TaggerClick(Sender: TObject);
    procedure MI_SGALL_RenameClick(Sender: TObject);
    procedure MI_SGALL_CopyToFolderClick(Sender: TObject);
    procedure MI_AddToPlaylist1Click(Sender: TObject);
    procedure MI_SGALL_AddAfterCurrentClick(Sender: TObject);
    procedure MI_SGALL_AddToEndClick(Sender: TObject);
    procedure MI_SGALL_AddToBeginClick(Sender: TObject);
    procedure MI_SGALL_AddAllClick(Sender: TObject);
    procedure MI_SGAll_Play2Click(Sender: TObject);
    procedure MI_SGAll_Play1Click(Sender: TObject);
    procedure MI_PlayCDfromCoverClick(Sender: TObject);
    procedure MI_DeleteAlbumClick(Sender: TObject);
    procedure MenuItem135Click(Sender: TObject);
    procedure Mi_AddBeginQueueClick(Sender: TObject);
    procedure MI_AddPlayingQueueClick(Sender: TObject);
    procedure MI_TagCDFromCoverClick(Sender: TObject);
    procedure MenuItem88Click(Sender: TObject);
    procedure MI_VU_Active4Click(Sender: TObject);
    procedure MI_CopyToFolder1Click(Sender: TObject);
    procedure PageControl1Change(Sender: TObject);
    procedure PageControl2Change(Sender: TObject);
    procedure PM_SGAllPopup(Sender: TObject);
    procedure ProgressBarSpeedMouseWheelDown(Sender: TObject;
      Shift: TShiftState; MousePos: TPoint; var Handled: Boolean);
    procedure ProgressBarSpeedMouseWheelUp(Sender: TObject;
      Shift: TShiftState; MousePos: TPoint; var Handled: Boolean);
    procedure BitBtn1Click(Sender: TObject);
    procedure CB_GenreRadio1Change(Sender: TObject);
    procedure CB_Land1Change(Sender: TObject);
    procedure CB_LibraryChange(Sender: TObject);
    procedure CB_LibrarySelect(Sender: TObject);
    procedure CB_SubDirsChange(Sender: TObject);
    procedure Edit1KeyPress(Sender: TObject; var Key: char);
    procedure Edit3KeyPress(Sender: TObject; var Key: char);
    procedure FormDestroy(Sender: TObject);
    procedure Image13DblClick(Sender: TObject);
    procedure Image1Resize(Sender: TObject);
    procedure ImageCdCoverDblClick(Sender: TObject);
    procedure ImageCDCoverLyricDblClick(Sender: TObject);
    procedure CB_GenreRadioChange(Sender: TObject);
    procedure CB_LandChange(Sender: TObject);
    procedure CheckBox1Change(Sender: TObject);
    procedure CB_YearChange(Sender: TObject);
    procedure ComboBox1Select(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: boolean);
    procedure FormCreate(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure GetExternalApps;
    procedure LB_ArtiestResize(Sender: TObject);
    procedure LB_LastFMInfoClick(Sender: TObject);
    procedure LB_LastFMInfoMouseEnter(Sender: TObject);
    procedure LB_LastFMInfoMouseLeave(Sender: TObject);
    procedure Label30Click(Sender: TObject);
    procedure LB_XiXInfoClick(Sender: TObject);
    procedure LB_XiXInfoMouseEnter(Sender: TObject);
    procedure LB_XiXInfoMouseLeave(Sender: TObject);
    procedure LabelLyricSourceClick(Sender: TObject);
    procedure LB_Albums1KeyPress(Sender: TObject; var Key: char);
    procedure LB_Albums1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure LB_ArtiestClick(Sender: TObject);
    procedure LB_ArtiestMouseEnter(Sender: TObject);
    procedure LB_ArtiestMouseLeave(Sender: TObject);
    procedure LB_Artists2Click(Sender: TObject);
    procedure LB_PlaylistDragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure LB_PlaylistDragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure MI_VU_at_centerClick(Sender: TObject);
    procedure MI_VU_at_bottomClick(Sender: TObject);
    procedure MI_VU_showpeaksClick(Sender: TObject);
    procedure MI_VU_at_topClick(Sender: TObject);
    procedure MI_Play_ShowInVFSClick(Sender: TObject);
    procedure MenuItem106Click(Sender: TObject);
    procedure MenuItem107Click(Sender: TObject);
    procedure MenuItem81Click(Sender: TObject);
    procedure MenuItem97Click(Sender: TObject);
    procedure Mi_Wiki1ENClick(Sender: TObject);
    procedure MI_Wiki1CustomClick(Sender: TObject);
    procedure MI_GetArtworkFromFileClick(Sender: TObject);
    procedure MI_DeleteArtistInfoClick(Sender: TObject);
    procedure MI_CurrentSong1Click(Sender: TObject);
    procedure MenuItem120Click(Sender: TObject);
    procedure MI_AddFolderToConfigClick(Sender: TObject);
    procedure MI_RemoveFromPlaylistClick(Sender: TObject);
    procedure MI_OpenAlbumInTagger1Click(Sender: TObject);
    procedure MI_PlayAlbum2Click(Sender: TObject);
    procedure MI_TagAlbum2Click(Sender: TObject);
    procedure MI_PlayArtist1Click(Sender: TObject);
    procedure MI_TagArtist1Click(Sender: TObject);
    procedure MenuItem65Click(Sender: TObject);
    procedure MI_Vu3Click(Sender: TObject);
    procedure MenuItem47Click(Sender: TObject);
    procedure MenuItem48Click(Sender: TObject);
    procedure MI_AboutClick(Sender: TObject);
    procedure MenuItem93Click(Sender: TObject);
    procedure MenuItem95Click(Sender: TObject);
    procedure MenuItem99Click(Sender: TObject);
    procedure MI_ReloadArtistInfoClick(Sender: TObject);
    procedure MI_RemoveSongtextClick(Sender: TObject);
    procedure MI_ReloadSongtextClick(Sender: TObject);
    procedure Panel14Click(Sender: TObject);
    procedure SB_CDTextClick(Sender: TObject);
    procedure SB_SaveClick(Sender: TObject);
    procedure SG_AllColRowInserted(Sender: TObject; IsColumn: Boolean; sIndex,
      tIndex: Integer);
    procedure SG_AllColRowMoved(Sender: TObject; IsColumn: Boolean; sIndex,
      tIndex: Integer);
    procedure SG_AllDrawCell(Sender: TObject; aCol, aRow: Integer;
      aRect: TRect; aState: TGridDrawState);
    procedure SG_AllHeaderClick(Sender: TObject; IsColumn: Boolean;
      Index: Integer);
    procedure SG_AllKeyPress(Sender: TObject; var Key: char);
    procedure SG_AllMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure SG_PlayCompareCells(Sender: TObject; ACol, ARow, BCol,
      BRow: Integer; var Result: integer);
    procedure SG_PlayDragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure SG_PlayDragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure SG_PlayDrawCell(Sender: TObject; aCol, aRow: Integer;
      aRect: TRect; aState: TGridDrawState);
    procedure SG_PlayKeyPress(Sender: TObject; var Key: char);
    procedure SG_PlayKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure SG_PlayMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure SG_PodcastClick(Sender: TObject);
    procedure SG_PodcastDblClick(Sender: TObject);
    procedure ShellListView1Click(Sender: TObject);
    procedure ShellListView1DblClick(Sender: TObject);
    procedure ShellTreeView1Click(Sender: TObject);
    procedure SB_ReadDVDClick(Sender: TObject);
    procedure SB_LastFMClick(Sender: TObject);
    procedure SpeedButton13Click(Sender: TObject);
    procedure SpeedButton15Click(Sender: TObject);
    procedure SpeedButton28Click(Sender: TObject);
    procedure SpeedButton29Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure SB_RepeatClick(Sender: TObject);
    procedure SpeedButton30Click(Sender: TObject);
    procedure SpeedButton34Click(Sender: TObject);
    procedure SpeedButton35Click(Sender: TObject);
    procedure SpeedButton4Click(Sender: TObject);
    procedure SpeedButton5Click(Sender: TObject);
    procedure SpeedButton6Click(Sender: TObject);
    procedure SpeedButton9Click(Sender: TObject);
    procedure Ster10Click(Sender: TObject);
    procedure Ster6Click(Sender: TObject);
    procedure Ster0Click(Sender: TObject);
    procedure Ster1Click(Sender: TObject);
    procedure Ster2Click(Sender: TObject);
    procedure Ster3Click(Sender: TObject);
    procedure Ster4Click(Sender: TObject);
    procedure Ster5Click(Sender: TObject);
    procedure Label12Click(Sender: TObject);
    procedure Label20Click(Sender: TObject);
    procedure LabelElapsedTimeClick(Sender: TObject);
    procedure LabelPodcastClick(Sender: TObject);
    procedure LabelRecordingsClick(Sender: TObject);
    procedure LB_Albums1Click(Sender: TObject);
    procedure LB_Albums1DblClick(Sender: TObject);
    procedure LB_Albums2Click(Sender: TObject);
    procedure LB_Albums2DblClick(Sender: TObject);
    procedure LB_Albums2KeyPress(Sender: TObject; var Key: char);
    procedure LB_Albums2MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure LB_Artist1Click(Sender: TObject);
    procedure LB_Artist1DblClick(Sender: TObject);
    procedure LB_Artist1KeyPress(Sender: TObject; var Key: char);
    procedure LB_Artist1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure LB_M3UClick(Sender: TObject);
    procedure LB_M3UDblClick(Sender: TObject);
    procedure LB_PlaylistClick(Sender: TObject);
    procedure LB_PlaylistDblClick(Sender: TObject);
    procedure LB_PlaylistMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure LB_TitelClick(Sender: TObject);
    procedure ListBox2Click(Sender: TObject);
    procedure LB_RadioWebsiteClick(Sender: TObject);
    procedure ListBox2DblClick(Sender: TObject);
    procedure MenuItem44Click(Sender: TObject);
    procedure MenuItem50Click(Sender: TObject);
    procedure MenuItem52Click(Sender: TObject);
    procedure MenuItem53Click(Sender: TObject);
    procedure MenuItem55Click(Sender: TObject);
    procedure MenuItem58Click(Sender: TObject);
    procedure MenuItem60Click(Sender: TObject);
    procedure MenuItem61Click(Sender: TObject);
    procedure MenuItem62Click(Sender: TObject);
    procedure MenuItem64Click(Sender: TObject);
    procedure MenuItem69Click(Sender: TObject);
    procedure MenuItem70Click(Sender: TObject);
    procedure MenuItem73Click(Sender: TObject);
    procedure MenuItem74Click(Sender: TObject);
    procedure MenuItem75Click(Sender: TObject);
    procedure MenuItem76Click(Sender: TObject);
    procedure MenuItem78Click(Sender: TObject);
    procedure MenuItem79Click(Sender: TObject);
    procedure MI_CDCover_ChooseNewFileClick(Sender: TObject);
    procedure MI_CDCover_RemoveCDCoverClick(Sender: TObject);
    procedure MI_VU_Active1Click(Sender: TObject);
    procedure MI_CopyRecordingClick(Sender: TObject);
    procedure MI_DeleteRecordingClick(Sender: TObject);
    procedure MI_FullscreenClick(Sender: TObject);
    procedure MI_NextClick(Sender: TObject);
    procedure MI_PauzeClick(Sender: TObject);
    procedure MI_PlayClick(Sender: TObject);
    procedure MI_PrevClick(Sender: TObject);
    procedure MI_GoToAlbumClick(Sender: TObject);
    procedure MI_PlayAlbumClick(Sender: TObject);
    procedure Mi_ReShuffleClick(Sender: TObject);
    procedure MI_StopClick(Sender: TObject);
    procedure MI_Vu1Click(Sender: TObject);
    procedure MI_Vu2Click(Sender: TObject);
    procedure Panel_VUClick(Sender: TObject);
    procedure GetAllMusicFiles;
    procedure GetMusicDetails;
    procedure FillVirtualFSTree;
    procedure RefreshLists(tagsModified, filesModified: boolean);
    procedure GetDetailsFromFilename(i: longint);
    procedure GetId3FromFilename(i: longint);
    procedure GetId3Extra(i: longint);
    function IsNumber(const AString: String): boolean;
    procedure SB_DeletePresetClick(Sender: TObject);
    procedure SB_InfoClick(Sender: TObject);
    procedure SB_NextClick(Sender: TObject);
    procedure SB_PauzeClick(Sender: TObject);
    procedure SB_PlayClick(Sender: TObject);
    procedure SB_PresetsClick(Sender: TObject);
    procedure SB_PreviousClick(Sender: TObject);
    procedure SB_RadioAddClick(Sender: TObject);
    procedure SB_RadioPlanClick(Sender: TObject);
    procedure SB_RadioRecordClick(Sender: TObject);
    procedure SB_ReadCDClick(Sender: TObject);
    procedure SB_ReverseClick(Sender: TObject);
    procedure SB_RipCDClick(Sender: TObject);
    procedure SB_StopClick(Sender: TObject);
    procedure SG_AllClick(Sender: TObject);
    procedure SG_AllDblClick(Sender: TObject);
    procedure SG_AllMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure SG_PlayClick(Sender: TObject);
    procedure SB_NewClick(Sender: TObject);
    procedure SB_RenameClick(Sender: TObject);
    procedure SB_CopyClick(Sender: TObject);
    procedure SB_DeleteClick(Sender: TObject);
    procedure SG_PlayColRowMoved(Sender: TObject; IsColumn: Boolean; sIndex,
      tIndex: Integer);
    procedure SG_PlayDblClick(Sender: TObject);
    procedure SG_PlayHeaderClick(Sender: TObject; IsColumn: Boolean;
      Index: Integer);
    procedure SB_RadioUpdateClick(Sender: TObject);
    procedure SG_PlayMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure SpeedButton10Click(Sender: TObject);
    procedure SpeedButton11Click(Sender: TObject);
    procedure SpeedButton12Click(Sender: TObject);
    procedure SpeedButton14Click(Sender: TObject);
    procedure SB_ReloadPlaylistClick(Sender: TObject);
    procedure SpeedButton16Click(Sender: TObject);
    procedure SpeedButton17Click(Sender: TObject);
    procedure SpeedButton18Click(Sender: TObject);
    procedure SpeedButton19Click(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure SpeedButton20Click(Sender: TObject);
    procedure SpeedButton21Click(Sender: TObject);
    procedure SpeedButton22Click(Sender: TObject);
    procedure SpeedButton26Click(Sender: TObject);
    procedure SpeedButton27Click(Sender: TObject);
    procedure SB_PodcastUpClick(Sender: TObject);
    procedure SB_PodcastDownClick(Sender: TObject);
    procedure SB_PodcastSaveClick(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);
    procedure SB_ConfigClick(Sender: TObject);
    procedure SB_ShuffleClick(Sender: TObject);
    procedure SpeedButton7Click(Sender: TObject);
    procedure SpeedButton8Click(Sender: TObject);
    procedure Splitter3Moved(Sender: TObject);
    procedure Splitter4ChangeBounds(Sender: TObject);
    procedure Splitter4Moved(Sender: TObject);
    procedure Ster7Click(Sender: TObject);
    procedure Ster8Click(Sender: TObject);
    procedure Ster9Click(Sender: TObject);
    procedure StringGrid1Click(Sender: TObject);
    procedure StringGrid1DblClick(Sender: TObject);
    procedure SG_CUEDblClick(Sender: TObject);
    procedure SG_ListenLiveDblClick(Sender: TObject);
    procedure StringGridCDClick(Sender: TObject);
    procedure StringGridCDDblClick(Sender: TObject);
    procedure StringGridCDEditingDone(Sender: TObject);
    procedure StringGridPresetsClick(Sender: TObject);
    procedure StringGridPresetsDblClick(Sender: TObject);
    procedure StringGridRadioAirClick(Sender: TObject);
    procedure StringGridRadioAirDblClick(Sender: TObject);
    procedure StringGridRadioAirMouseDown(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure StringGridRecordedClick(Sender: TObject);
    procedure StringGridRecordedDblClick(Sender: TObject);
    procedure StringGridRecordedMouseDown(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure TabSheet14Show(Sender: TObject);
    procedure TabSheet1Show(Sender: TObject);
    procedure TabSheetAlbumsShow(Sender: TObject);
    procedure TabSheetArtistsContextPopup(Sender: TObject; MousePos: TPoint;
      var Handled: Boolean);
    procedure TabSheetArtistsShow(Sender: TObject);
    procedure TabSheetCDShow(Sender: TObject);
    procedure TabSheetCoversEnter(Sender: TObject);
    procedure TabSheetFilesShow(Sender: TObject);
    procedure TabSheetPlaylistsShow(Sender: TObject);
    procedure TabSheetPlayQueShow(Sender: TObject);
    procedure TabSheetPodcastShow(Sender: TObject);
    procedure TabSheetRadioShow(Sender: TObject);
    procedure ThumbControl1DblClick(Sender: TObject);
    procedure ThumbControl1KeyPress(Sender: TObject; var Key: char);
    procedure ThumbControl1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Timer1Timer(Sender: TObject);
    procedure TimerTCPTimer(Sender: TObject);
    procedure TimerScheduleStopTimer(Sender: TObject);
    procedure TimerScheduleTimer(Sender: TObject);
    procedure TB_ThumbSizeChange(Sender: TObject);
    procedure TB_ThumbSizeMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure TrackBar2Click(Sender: TObject);
    procedure TrackBar2MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure TrackBar2MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure TrackBar2MouseWheel(Sender: TObject; Shift: TShiftState;
      WheelDelta: Integer; MousePos: TPoint; var Handled: Boolean);
    procedure TrayIcon1Click(Sender: TObject);
    procedure TV_VFSDeletion(Sender: TObject; Node: TTreeNode);
    procedure TV_VFSSelectionChanged(Sender: TObject);
    procedure VolumeBarMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure VolumeBarMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure VolumeBarMouseWheelDown(Sender: TObject; Shift: TShiftState;
      MousePos: TPoint; var Handled: Boolean);
    procedure VolumeBarMouseWheelUp(Sender: TObject; Shift: TShiftState;
      MousePos: TPoint; var Handled: Boolean);
    procedure VuLeft1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure WriteConfig;
    procedure ReadConfig;
    function DownloadFile(const Url, PathToSaveTo: string): boolean;
    function Vertaal(x: utf8string): utf8string;
    procedure BrowseTo(url: string);
    procedure WriteMusicDatabase;
    procedure ReadDatabase;
    procedure DeleteSong(X: longint; RefLists:boolean=true);
    procedure RemoveFromPlayingQueue(x: longint);
    procedure LaadSpeellijsten;
    procedure OnCopyToHasClick(Sender: TObject);
    procedure OnSubItemHasClick(Sender: TObject);
    procedure OnSubItem2HasClick(Sender: TObject);
    procedure OnSubItemLyricsHasClick(Sender: TObject);
    procedure SavePresets;
    procedure PlayRadio(waar: integer);
    procedure PlayPodcast(url: string);
    function EndSchedule(Sender: Tobject): Boolean;
    function SecToTime(Sec: longint): string;
    function TimeToSec(Sec: string): longint;
    procedure GetPodCast(x: Integer;podcasttitle: string);
    function DownloadHTTP(URL, TargetFile: string): boolean;
    procedure RipTrack(x: integer);
    procedure Encode(x: integer);
    procedure PlayTrack(track: DWORD);
    procedure PanelVUClick(Sender: TObject);
    procedure KiesVuImage(x: byte);
    procedure Play(song: longint);
    function GetCDCover(song: longint; artiest, CD: string): string;
    Function GetCDArtworkFromFile(song: string): string;
    Function GetCDArtworkfromLastFM(song: longint): string;
    procedure VulSterren(Index: byte);
    procedure VulSterrenPlaylist(Index: byte);
    procedure VertaalForm1;
    procedure SetFullscreen;
    procedure RipDVDTrack(x: integer);
    Function ReplaceHTMLQoutes(lijn: string): string;
    procedure PlayFromFile(song: string);
    procedure RadioStationsOpslaan;
    procedure UnZipIt(zipbestand, doeldir: string);
    procedure ZipIt(source, doel: string);
    procedure UpdateArtistGrids(x: longint);
    procedure UpdateMediaMode;
    procedure JumpInTrackBar;
    Function ConvertArtist(artiest: string; nospaces: boolean): string;
    Function ConvertTitle(titel: string): string;
    Function ConvertAlbum(titel: string): string;
    Function MakeWikiArtist(temp: string; ch: char):string;
    procedure ShowTabs(ActivePage: Byte; All, Queue, Files, Radio, Podcast, CD, CDCovers: Boolean);
    procedure LB_Artist1Clicked;
    Procedure AutoSizePlayColumns;
    Procedure AutosizeAllColumns;
    procedure ClearCDCover;
    procedure GetSongsFromAlbum(Artist, Album: String; SingleArtist: Boolean);
    procedure LoadTheme;
    procedure GetRadioDB(country,genre,zoekterm: string; Toevoegen: Boolean);
  private
    { private declarations }
     FAllSel, FPlaySel: TGridSelection;

     procedure RefreshArtistAlbums;
     procedure RefreshAlbumArtists;
     procedure LB_Artist1ClickedHandler(Sender: TObject; var Done: Boolean);
     function GetGridFilename(aRow: Integer): string;
     function SongToRow(aGrid: TStringGrid; Song: Integer): Integer;
     function RowToSong(aGrid: TStringGrid; aRow: Integer): Integer;
     procedure DeleteSelectedSongs(aGrid: TStringGrid);
     procedure ClearPlayIndicator;
     procedure ClearGridSelection(aGrid: TStringGrid; withInvalidate:boolean=true);
     function IsCellSelected(aGrid: TStringGrid; aCol, aRow: Integer): boolean;
     procedure ShowParameters;
     procedure RunParameters(Data:IntPtr);
     procedure ReadFolders;
  public
    { public declarations }
    Listen: TTCPListenDaemon;
    Receive: TTCPReceiveThrd;
    sock: TTCPBlockSocket;
    procedure Got_Connection(var Msg: TMessage); message GOT_CONNECTION;
    procedure Got_String(var Msg: TMessage); message GOT_STRING;
  end;

type TSong = record
       Bestandsnaam  : string[255];
       Pad           : string[255];
       Artiest       : string[118];
       Orchestra     : string[118];
       Conductor     : string[100];
       Interpreted   : string[80];
       GroupTitel    : string[200];
       Titel         : string[255];
       SubTitel      : string[200];
       Track         : Byte;
       CD            : string[255];
       Jaartal       : string[10];
       Genre         : string[40];
       Encoder       : string[40];
       AantalTracks  : string[2];
       Comment       : string[255];
       Composer      : string[118];
       OrigArtiest   : string[118];
       OrigTitle     : string[118];
       OrigYear      : string[10];
       Copyright     : string[100];
       Software      : string[80];
       EQ            : Boolean;
       EQSettings    : Array [0..10] of shortint;
       PreVolume     : byte;
       FadeSettings  : byte;
       Beoordeling   : Byte;
       aantalafspelen: Integer;
       Deleted       : Boolean;
       TrimBegin, TrimEnd : Boolean;
       TrimLength    : Array [0..1] of longint;
       Mono          : Boolean;
       Modified      : Boolean;
       FNModified    : Boolean;
    end;

type TCD = record
       artiest   : utf8string;
       Titel     : utf8string;
       Album     : utf8string;
       tijd      : utf8string;
       filename  : utf8string;
       jaartal   : utf8string;
       genre     : utf8string;
       comment   : utf8string;
       composer  : utf8string;
       copyright : utf8string;
       original  : utf8string;
end;

type TPodcast = record
       ch_title    : utf8string;
       ch_descript : utf8string;
       ch_link     : utf8string;
       ch_copyright: utf8string;
       ch_lastdate : utf8string;
       ch_pubdate  : utf8string;
       ch_master   : utf8string;
       it_title    : utf8string;
       it_link     : utf8string;
       it_guid     : utf8string;
       it_descript : utf8string;
       it_mediaurl : utf8string;
       it_medialen : utf8string;
       it_type     : utf8string;
       it_pubdate  : utf8string;
       it_cat      : utf8string;
       it_bytes    : longint;
       itunes_sub  : utf8string;
       itunes_oms  : utf8string;
       itunes_img  : utf8string;
     end;

type

{ TSettings }

 TSettings = class
       FadeTime      : shortint;
       Language      : shortstring;
       Fade          : Boolean;
       FadeManual    : Boolean;
       RunFromUSB    : Boolean;
       NASBug        : Boolean;
       ScanBackground: Boolean;
       ScanAtStart   : Boolean;
       Shuffle       : Boolean;
       RepeatSong    : Byte;
       Lame          : String;
       Flac          : String;
       OGG           : String;
       AAC           : String;
       Opus          : String;
       Mplayer       : String;
       IncludeLocaleDirs: TStringlist;
       IncludeLocaleDirsChecked: Array of Boolean;
       ExcludeLocaleDirs: TStringlist;
       ExcludeLocaleDirsChecked: Array of Boolean;
       IncludeExternalDirs : TStringlist;
       IncludeExternalDirsChecked: Array of Boolean;
       ExcludeExternalDirs : TStringlist;
       ExcludeExternalDirsChecked: Array of Boolean;
       SaveLyricsInID3Tag : boolean;
       VuLeft1            : byte;
       CacheCDImages : boolean;
       CacheSongtext : boolean;
       TabArtist     : byte;
       TabPlaylist   : byte;
       Notification  : boolean;
       OnlyWhenMinized  : boolean;
       Tray          : boolean;
       Encoder       : byte;
       EncodingTargetFolder: String;
       EncodingFilenameFormatSingle: String;
       EncodingFilenameFormatCompilation: String;
       UpcaseLetter  : boolean;
       Check_The     : boolean;
       VaultDir      : string;
       CacheDirCDCover : string;
       CacheDirSongtext: string;
       cacheDirRadio  : string;
       SystemSettings : boolean;
       EQ             : Boolean;
       LastFMLogin    : String;
       LastFMPass     : String;
       LastFMToken    : String;
       LastFMSession  : String;
       SaveOnExternal : Boolean;
       FontSize       : integer;
       Font2Size       : integer;
       TimerInterval  : byte;
       DVDDrive       : string;
       MaskToTag, MaskToFile : string;
       TrimFade              : integer;
       cdb                   : integer;
       PlayMono              : Boolean;
       ChosenLibrary         : Byte;
       MinimizeOnClose       : Boolean;
       NetworkControl        : Boolean;
       ip_port               : String;
       DeleteMacOSFiles      : Boolean;
       Fast                  : Boolean;
       SaveExternalOnInternal: Boolean;
       Soundcard             : Integer;
       CDCoverInfo           : Boolean;
       CDCoverLyrics         : Boolean;
       ShowAllColums         : Boolean;
       FixCDCover            : Boolean;
       NoAdvance             : Boolean;
       Backdrop              : byte;
       UseBackDrop           : Boolean;
       constructor create;
       destructor destroy; override;
end;

type TScheduleSettings = record
       CopyRec, RenameRec        : Boolean;
       Overwrite, DeleteAfterCopy: Boolean;
       CopyDir, RenameFormat     : String;
end;

type TLameOpties = record
       Mono       : Boolean;
       EncQuality : shortstring;
       Preset     : shortstring;
       BitrateMin    : shortstring;
       BitrateMax    : shortstring;
       BitRateQuality: shortstring;
       tags       : string;
       vbr        : boolean;
       cbr        : boolean;
       abr        : boolean;
       pr         : boolean;
end;

type TOGGOpties = record
       EncQuality : shortstring;
       BitrateMin    : shortstring;
       BitrateMax    : shortstring;
       vbr        : boolean;
       cbr        : boolean;
       mmode      : boolean;
       ForceQuality: Boolean;
end;

type TAACOpties = record
       Bitrate    : shortstring;
       vbr        : boolean;
       cbr        : boolean;
       vbrmode    : byte;
end;

type TOpusOpties = record
       EncQuality : shortstring;
       Bitrate    : shortstring;
       vbr        : boolean;
       cvbr       : boolean;
       cbr        : boolean;
       Framesizei : byte;
       Framesize  : byte;
end;


type TId3Extra = record
       id         : string;   // FLAC: Vendor
       CDCoverLink: String;
       Size       : Longint;
       link       : string;
       version    : byte;
       bitrate    : string;
       quality    : string;
       lyric      : string;
end;

type TRadioStation = record
       internalnr  : string;
       naam        : utf8string;
       land        : utf8string;
       genres      : utf8string;
       website     : utf8string;
       logo1       : utf8string;
       link        : utf8string;
       volgorde    : char;
     end;

 type TVU_Vars = record
       Active   : byte;
       Theme    : byte;
       Placement: byte; // '1' Top,  '2' Center, '3' Bottom
       ShowPeaks: boolean;
     end;

type TDownloadPodCastThread = class(TThread)
       private
         procedure OnTerminate;
       protected
         procedure Execute; override;
       end;

type TSearchForArtistInfoThread = class(TThread)
      private
        procedure ShowInfo;
        procedure NoInfo;
      protected
        procedure Execute; override;
      end;

type TSearchForSongTextThread = class(TThread)
       private
         procedure NoLyrics;
         procedure ShowLyrics;
       protected
         procedure Execute; override;
       end;

type TSearchforPlaylistThread = class(TThread)
         private
           procedure ShowPlaylist;
         protected
           procedure Execute; override;
         end;

  type TLastFMInfoThread = class(TThread)
         private
           procedure ShowMe;
         protected
           procedure Execute; override;
         end;

  type TGetCDCoverThread = class(TThread)
         var coverthread: longint;
         private
           procedure ShowCDCover;
           procedure HideCDCover;
         protected
           procedure Execute; override;
         end;


const
  configversion='v0.14c';
  versie='2020-12-22';
  READ_BYTES = 2048;
  // TODO: customizing grids columns could be a per/user setting
  //       for the moment, use this ....
  {$ifdef COL_FILENAME_FIRST}
  COL_SG_ALL_PATH  = 6;
  COL_SG_ALL_NAME  = 5;
  {$else}
  COL_SG_ALL_PATH  = 5;
  COL_SG_ALL_NAME  = 6;
  {$endif}


var
  Form1: TForm1;
  StartDir, TempDir, ConfigDir, HomeDir, PlugInDir: string;

  Settings   : TSettings;
  ScheduleSettings: TScheduleSettings;
  RadioStation, DBRadiostation: array [0..2200] of TRadioStation;
  TotalDBRadio: integer;
  MyBool, FirstTime, pause, isplayingsong  : Boolean;

  FilesFound, M3uFilesfound, Artiesten, Albums: TStringlist;
  PlaylistsFound: TStringlist;

  Liedjes, DB_Liedjes, Tag_Liedjes: Array of TSong;
  LiedjesTemp                     : TSong;

  MaxSongs, songplaying, songchosen, max_records, songrowplaying, FilePlaying: longint;
  internalsongs, SongsInPlayingQueue: longint;
  LB_itemindex, Active_LB_itemindex, Startrij: integer;
  vertaalstring         : Array [1..20] of UTF8string;
  vertaalstringteller, modespeellijst, aantalsterren, status_cd: byte;
  GeladenPlaylist, GetoondePlaylist, (* zoekstring, *) ArtiestInfo, ArtiestInfoBio: String;
  Songtext_CDCoverSplitter, SplitterLyric, formleft, formwidth, formtop, formheight: integer;
  OrigineleVolgorde, TagVolgorde: Array of Longint;
  CD_Cover_Temp, Loaded_CD_Cover, lyricssource, zoekstring: string;
  isfullscreen, IsMediaModeOn, fullrandom, db_changed, CancelRip, OverwriteAllRip: Boolean;

  aNode      : TTreeNode;
  SubItem    : TMenuItem;

  // RADIO
  internalradio, personalradio, gekozenradio : integer;
  RadioAktief                                : integer;
  FileStream                                 : TFileStream;
  StreamSave, schedulehasstarted             : boolean;
  recordstreamtofile                         : string;
  plannedrecordings                          : byte;
  endrecording, Beginrecording               : Real;
  PlayingFromRecorded, EditRadioStation      : Boolean;
  RadioDisconnected: Boolean;

  // Streams
  stream      : byte;

  // TIME
  total_bytes, elapsed_bytes, elapsed_time: longint;
  total_time: double;
  total_time_str, elapsed_time_str, time_str: string;
  elapsed: Boolean;

  // PODCAST
  downloadpodcast: boolean;
  savepodcastto, urlvar  : string;
  Podcast        : TPodcast;
  SaveDownloadto : TStringlist;

  /// Mag lokaal
  id3        : tid3v2;
  id3ogg     : TOggVorbis;
  id3Flac    : TFLACFile;
  id3Extra   : Tid3Extra;
  id3APE     : TAPEtag;
  id3AAC     : TMP4file;
  id3OpusTest: TOpusTag;

  // EQ
  FxEqualizer: array[0..10] of integer;
  EQ_Preset: Array[0..9,1..10] of integer;
  EQ_Set: Byte;

  // FX
  FXEffects: array[0..10] of integer;
  wet, speed, delay, level, revLevel, revDelay: integer;
  is_echo_on, is_flanger_on, is_reverb_on: boolean;

  // CD DVD
  CD_text, t: PAnsiChar;
  CD, CDTxt      : array [1..99] of TCD;
  selectedchapter: string;
  Ripping: Boolean;
  RipOptiesCompilation : Boolean;
  LameOpties : TLameOpties;
  OGGOpties  : TOggOpties;
  AACOpties  : TAACOpties;
  OpusOpties : TOpusOpties;
  RunEncoder     : TProcess;
  CDTrackPlaying: byte;
  Tracksfound: TStringList = nil;
  DVDLetter: string;

  //LYRICS
  CachedLyrics, ArtistLyric, TitleLyric: String;
  SearchLyrics: Byte;
  welkecover: LongInt;
  ThreadSongTextRunning, Threadrunning: boolean;
  ThreadArtiestInfoRunning: boolean;
  LyricsNotFound: TStringlist = nil; // Holds the songtexts already searched and not found (Limited to 100 songs)
  LyricsVar: TLyrics;

  //ASK.FM
  ArtiestString: string;

  //LASTFM
  UnixTimeStamp: String;
  MostPlayed: TStringList;

  //CUE
  PlayingCue: byte;

  //THREADS
  ThreadSongText : TSearchForSongTextThread;
  ThreadPlaylist : TSearchForPlaylistThread = nil;
  ThreadCDCover  : TGetCDCoverThread;
  ThreadLastFMInfo: TLastFMInfoThread;
  Thread1        : TDownloadPodCastThread;
  ThreadGetArtiestInfo: TSearchForArtistInfoThread;
  RemoteConnection: Boolean;
  MessageUsed: String;

  //VU
  VU_Settings: TVU_Vars;
  CoverModePlayer: Byte;

  // BASS RELATED
  {$IFDEF HAIKU}

  {$ELSE}
    radioStream, cdStream, Song_Stream1, Song_Stream2, ReverseStream, streamVar : HStream;
    Echo: BASS_BFX_ECHO;
    Flanger: BASS_BFX_FLANGER;
    reverb: BASS_BFX_REVERB;
    Equalizer: BASS_BFX_PEAKEQ;
    PreVolume: BASS_BFX_VOLUME;
  {$ENDIF}

implementation

{$R *.lfm}

type
  PNodeSongInfo = ^TNodeSongInfo;
  TNodeSongInfo = record
    Song: Integer;  // what song produced this node
    Len: Integer;   // how many bytes we took from the song's path
  end;

constructor TTCPListenDaemon.Create;
begin
  inherited Create(False);
  sock := TTCPBlockSocket.Create;
end;

destructor TTCPListenDaemon.Destroy;
begin
  Sock.Free;
end;

procedure TTCPListenDaemon.Execute;
var
  ClientSock: TSocket;
begin
  sock.CreateSocket;
  sock.setLinger(True, 10000);
  sock.bind('0.0.0.0', '50200');
  sock.listen;
  repeat
    if terminated then break;
    if sock.canread(1000) then
    begin
      ClientSock := sock.accept;
      // We can use ClientSock to create a TCPBlockSocket;
      SendMessage(Form1.Handle, GOT_CONNECTION, wparam(ClientSock), 0);
    end;
  until False;
end;

constructor TTCPReceiveThrd.Create(Hsock: TSocket);
begin
  inherited Create(False);
  Csock := Hsock;
end;

procedure TTCPReceiveThrd.Execute;
var
  s: string;
begin
  sock := TTCPBlockSocket.Create;
  try
    Sock.socket := CSock;
    sock.GetSins;
    repeat
      if terminated then break;
      s := sock.RecvPacket(60000);
      if sock.lastError <> 0 then break;
      if s <> '' then SendMessage(Form1.Handle, GOT_STRING, wparam(PChar(s)), 0);
    until False;
  finally
    Sock.Free;
  end;
end;

{ TSettings }

constructor TSettings.create;
begin
  inherited create;
  Language:='EN';
  DVDDrive:='/dev/sr0';
  FontSize:=10;
  Font2Size:=10;
  IncludeLocaleDirs:=Tstringlist.Create;
  ExcludeLocaleDirs:=Tstringlist.Create;
  IncludeExternalDirs:=Tstringlist.Create;
  ExcludeExternalDirs:=Tstringlist.Create;
  SaveOnExternal:=True;
  PlayMono:=False;
  ChosenLibrary:=0;
  TabArtist:=3;
  TabPlaylist:=3;
  CacheCDImages:=True;
  CacheSongtext:=True;
  ShowAllColums:=True;
  FixCDCover:=True;
  Tray:=True;
  OnlyWhenMinized:=True;
  Notification:=True;
  Encoder:=0;
  EncodingFilenameFormatSingle:='%1/%a/%l/%a - (%l) - %n) %t';
  EncodingFilenameFormatCompilation:='Compilations/%l/%n) %a - %t';
  SystemSettings:=True;
  cdb:=500;
  MinimizeOnClose:=False;
  BackDrop:=1; // 0 - Auto 1 - Light Backdrop 2 - Dark Backdrop
  UseBackDrop:=True;

  LastFMLogin:='';
  LastFMPass:='';
  LastFMToken:='';
end;

destructor TSettings.destroy;
begin
 (* IncludeLocaleDirs.Free;
  ExcludeLocaleDirs.Free;
  IncludeExternalDirs.Free;
  ExcludeExternalDirs.Free;   *)
end;

{ TForm1 }

function StripHTML(S: string): string;
var
  TagBegin, TagEnd, TagLength: integer;
begin
  TagBegin := Pos( '&lt;', S);  // search position of first <

  while (TagBegin > 0) do begin  // while there is a < in S
    TagEnd := Pos('&gt;', S);  // find the matching >
    TagLength := TagEnd - TagBegin + 1;
    Delete(S, TagBegin, TagLength+3); // delete the tag
    TagBegin:= Pos( '&lt;', S);        // search for next <
  end;

  Result := S;                // give the result
end;

procedure TForm1.UnZipIt(zipbestand, doeldir: string);
var uzip: Tunzipper;
begin
  if FormLog.CB_Log.Checked then FormLog.MemoDebugLog.Lines.Add('UnZipIt: '+zipbestand);
  uzip:=Tunzipper.Create;
  uzip.OutputPath:=doeldir;
  uzip.UnZipAllFiles(zipbestand);
  uzip.Free;
end;

procedure TForm1.ZipIt(source, doel: string);
var zip: Tzipper;
    i, max: longint;
    aList: TStringList;
begin
  if FormLog.CB_Log.Checked then FormLog.MemoDebugLog.Lines.Add('ZipIt: '+source);
  zip:=Tzipper.Create;
  Zip.FileName:=doel;
  aList:=FindAllFiles(source, '*.*', True);
  max:=aList.Count-1;
  For i:= 0 to max do Zip.Entries.AddFileEntry(aList.Strings[i],ExtractFilename(aList.Strings[i]));
  aList.Free;
  Zip.ZipAllFiles;
  zip.Free;
end;

function HexToDec(Str: string): longInt;
var
  i, M: longint;
begin
  Result:=0; M:=1;
  Str:=AnsiUpperCase(Str);
  for i:=Length(Str) downto 1 do
  begin
    case Str[i] of
      '1'..'9': Result:=Result+(Ord(Str[i])-Ord('0'))*M;
      'A'..'F': Result:=Result+(Ord(Str[i])-Ord('A')+10)*M;
    end;
    M:=M shl 4;
  end;
end;


procedure TSearchForArtistInfoThread.NoInfo;
begin
  Form1.MemoArtiest.Lines.Clear; form1.LabelSimilar.Caption:='-'; Form1.LB_Genre.Caption:='-';
end;

procedure TSearchForArtistInfoThread.ShowInfo;
var i: integer;
    lijn, substring, bestand: string;
    Filevar: TextFile;
begin
  Form1.MemoArtiest.Lines.Clear; form1.LabelSimilar.Caption:='-'; Form1.LB_Genre.Caption:='-';
  Form1.SG_Disco.RowCount:=1; i:=0; bestand:='';
  if FileExistsUTF8(Configdir+Directoryseparator+'artist'+Directoryseparator+ArtiestInfo) then bestand:=Configdir+Directoryseparator+'artist'+Directoryseparator+ArtiestInfo
    else if FileExistsUTF8(tempdir+Directoryseparator+'artist.txt') then bestand:=tempdir+Directoryseparator+'artist.txt';
  if bestand<>'' then
  begin
    if FormLog.CB_Log.Checked then FormLog.MemoDebugLog.Lines.Add('Loading Artist Info from '+bestand);
    AssignFile(Filevar,bestand);
    Reset(Filevar);
    Readln(Filevar,lijn);
    repeat
      Readln(Filevar,lijn);
      if lijn<>'[SIMILAR]' then Form1.MemoArtiest.Lines.Add(lijn);
    until (lijn='[SIMILAR]') or eof(Filevar);
    if not eof(Filevar) then
    begin
      Readln(Filevar,lijn);
      Form1.LabelSimilar.Caption:=lijn;
      Readln(Filevar,lijn); Readln(Filevar,lijn);
      Form1.LB_Genre.Caption:=lijn;
      Readln(Filevar,lijn); Readln(Filevar,lijn);
      Readln(Filevar,lijn);
      repeat
        Readln(Filevar,lijn);
        if (not eof(Filevar)) and (length(lijn)>1) then
        begin
          inc(i); Form1.SG_Disco.RowCount:=i+1;
          substring:=Copy(lijn,1,pos(';',lijn)-1); Delete(lijn,1,pos(';',lijn));
          Form1.SG_Disco.Cells[0,i]:=substring;
          Form1.SG_Disco.Cells[1,i]:=lijn;
        end;
      until eof(Filevar);
    end;
    CloseFile(Filevar);
    Form1.SG_Disco.AutoSizeColumns;
  end;
  Form1.MemoArtiest.Lines.Insert(0,'');
end;

Procedure TSearchForArtistInfoThread.Execute;
var gevonden, goed: boolean;
    lijn, sSimilar, sGenre, sMBID, temp: string;
    Filevar: textFile;
    i,i2: integer;
    fs: TFilestream;
    sArtist: TStringList;
begin
  ThreadArtiestInfoRunning:=True; gevonden:=false;
  if lowercase(artiestInfo)='unknown' then
  begin
   gevonden:=true;
   Synchronize(@NoInfo);
  end;

   if (artiestInfo<>ArtiestInfoBio) and (FileExistsUTF8(Configdir+Directoryseparator+'artist'+Directoryseparator+ArtiestInfo)) then
   begin
      gevonden:=True; Synchronize(@ShowInfo);
      ArtiestInfoBio:=ArtiestInfo;
   end;
   if (artiestInfo<>ArtiestInfoBio) and (not gevonden) then //Configdir+Directoryseparator+'artist'+Directoryseparator+ArtiestInfo;
     begin
      ArtiestInfoBio:=ArtiestInfo;
      begin
        {$IFDEF HAIKU}
        goed:=Form1.DownLoadFile('http://www.xixmusicplayer.org/php/info_artist.php?artiest='+artiestInfo,tempdir+Directoryseparator+'artist.txt');
        {$ELSE}
        fs := TFileStream.Create(tempdir+Directoryseparator+'artist.txt', fmOpenWrite or fmCreate);
        try
          goed:=HTTPGetBinary('http://www.xixmusicplayer.org/php/info_artist.php?artiest='+artiestInfo, fs);
        finally
          fs.Free;
        end;
        {$ENDIF}
        if goed then
        begin
          AssignFile(Filevar,tempdir+Directoryseparator+'artist.txt');
          Reset(Filevar);
          Readln(Filevar,lijn);
          CloseFile(Filevar);
          if (pos('!DOCTYPE',lijn)<1) and (length(lijn)>2) then
          begin
           gevonden:= true;
           CopyFile(tempdir+Directoryseparator+'artist.txt',Configdir+Directoryseparator+'artist'+Directoryseparator+ArtiestInfo);
          end
          else DeleteFile(tempdir+Directoryseparator+'artist.txt');
        end;
       end;
      if not gevonden then
       begin
         sSimilar:='';
         {$IFDEF HAIKU}
         goed:=Form1.DownLoadFile('http://ws.audioscrobbler.com/2.0/?method=artist.getinfo&artist='+ArtiestString+'&api_key=a2c1434814fb382c6020043cbb13b10d',tempdir+Directoryseparator+'artist-askfm.txt');
         {$ELSE}
         fs := TFileStream.Create(tempdir+Directoryseparator+'artist-askfm.txt', fmOpenWrite or fmCreate);
         try
           goed:=HTTPGetBinary('http://ws.audioscrobbler.com/2.0/?method=artist.getinfo&artist='+ArtiestString+'&api_key=a2c1434814fb382c6020043cbb13b10d', fs);
         finally
           fs.Free;
         end;
         {$ENDIF}

         if goed then
         begin
           sArtist:=TStringlist.Create;  sSimilar:=''; sGenre:='';
           AssignFile(Filevar,tempdir+Directoryseparator+'artist-askfm.txt');
           Reset(Filevar);
           // READ MBID
           Repeat
             Readln(Filevar,lijn);
           until (eof(Filevar)) or (pos('<mbid>',lijn)>0) or (pos('<stats>',lijn)>0);
           if (pos('<mbid>',lijn)>0) then
           begin
             delete(lijn,1,pos('<mbid>',lijn)+5); delete(lijn,pos('</mbid>',lijn),length(lijn));
             sMBID:=lijn;
           end;
           // READ SIMILAR ARTIST
           Repeat
             Readln(Filevar,lijn);
           until (eof(Filevar)) or (pos('<similar>',lijn)>0);

           sSimilar:='';
           if (pos('</similar>',lijn)<1) then
           begin
             i2:=0;
             Repeat
               Readln(Filevar,lijn);
               if pos('<name>',lijn)>0 then
               begin
                 delete(lijn,1,pos('<name>',lijn)+5); delete(lijn,pos('</name>',lijn),length(lijn));
                 if i2=0 then sSimilar:=lijn
                         else sSimilar:=sSimilar+'; '+lijn;
                 inc(i2);
               end;
             until eof(Filevar) or (pos('</similar>',lijn)>0);
           end;
           //READ GENRE
           Repeat
             Readln(Filevar,lijn);
           until (eof(Filevar)) or (pos('<tags>',lijn)>0);
           i2:=0;
           Repeat
             if pos('<name>',lijn)<1 then Readln(Filevar,lijn);
             if pos('<name>',lijn)>0 then
             begin
               delete(lijn,1,pos('<name>',lijn)+5); delete(lijn,pos('</name>',lijn),length(lijn));
               if i2=0 then sGenre:=lijn
                       else sGenre:=sGenre+'; '+lijn;
               inc(i2);
             end;
           until eof(Filevar) or (pos('</tags>',lijn)>0);
           //READ ARTIST INFO
           Repeat
             Readln(Filevar,lijn);
           until (eof(Filevar)) or (pos('<content>',lijn)>0);
           i2:=0;
           if (not eof(Filevar)) then
           begin
             lijn:=StringReplace(lijn,'<content>','',[rfReplaceAll, rfIgnoreCase]);
             lijn:=StringReplace(lijn,'</content>','',[rfReplaceAll, rfIgnoreCase]);
             lijn:=Form1.ReplaceHTMLQoutes(lijn);

             //Break String into different lines #10
             repeat
               if pos('&#10;',lijn)>0 then
               begin
                 if pos('&#10;',lijn)=1 then temp:=''
                                        else temp:=Copy(lijn,1,pos('&#10;',lijn)-1);
                 Delete(lijn,1,length(temp)+5);
                 sArtist.Add(temp);
                 inc(i2);
               end;
             until pos('&#10;',lijn)<1;
             if pos('href',lijn)>0 then sArtist.Add(' ');
             sArtist.Add(lijn);
             inc(i2);
           end;
           CloseFile(Filevar);

           if (length(sSimilar)>2) or (sArtist.Count>0) then
           begin
             AssignFile(Filevar,tempdir+Directoryseparator+'artist.txt');
             Rewrite(Filevar);
             Writeln(Filevar,'[ARTIST]');
             if sArtist.Count>0 then for i:=0 to sArtist.Count-1 do Writeln(Filevar,sArtist.Strings[i]);
             Writeln(Filevar,'[SIMILAR]');
             Writeln(Filevar,Form1.ReplaceHTMLQoutes(sSimilar));
             Writeln(Filevar,'[GENRE]');
             Writeln(Filevar,sGenre);
             Writeln(Filevar,'[MBID]');
             Writeln(Filevar,sMBID);
             Writeln(Filevar,'[DISCOGRAPHY]');
             CloseFile(Filevar);
             CopyFile(tempdir+Directoryseparator+'artist.txt',Configdir+Directoryseparator+'artist'+Directoryseparator+ArtiestInfo);
           end;
           sArtist.Free;
         end;
       end;
       Synchronize(@ShowInfo);
       ArtiestInfoBio:=ArtiestInfo;
     end;
  ThreadArtiestInfoRunning:=False;
end;

procedure TSearchForSongTextThread.NoLyrics;
begin
  Form1.LabelLyricSource.Caption:='-';
  FormCoverPlayer.LabelLyrics.Caption:='';
  if FormLog.CB_Log.Checked then FormLog.MemoDebugLog.Lines.Add('SYNCED: NoLyrics');
end;

procedure TSearchForSongTextThread.ShowLyrics;
begin
  Form1.LabelLyricSource.Caption:='-';
  if FileExistsUTF8(CachedLyrics) then if FormLog.CB_Log.Checked then FormLog.MemoDebugLog.Lines.Add('Lyric found in cache: '+CachedLyrics);
  if FileExistsUTF8(CachedLyrics) and (SearchLyrics=0) then
                                        BEGIN
                                          Form1.MemoLyrics.Lines.LoadFromFile(CachedLyrics);
                                          Form1.LabelLyricSource.Caption:=lyricssource;
                                          if FormLog.CB_Log.Checked then FormLog.MemoDebugLog.Lines.Add('Lyric loaded from cache: '+CachedLyrics);
                                        end
  else
  begin
    Form1.MemoLyrics.Lines.LoadFromFile(tempdir+Directoryseparator+'songtext2.txt');
    Form1.LabelLyricSource.Caption:=lyricssource;
    if FormLog.CB_Log.Checked then FormLog.MemoDebugLog.Lines.Add('Lyric loaded from '+lyricssource);
  end;
  FormCoverPlayer.LabelLyrics.Caption:=Form1.MemoLyrics.Caption;
  DeleteFile(tempdir+Directoryseparator+'songtext.txt');
end;

procedure TGetCDCoverThread.Execute;
begin
  Threadrunning:=true; coverthread:=welkecover;
  CD_Cover_Temp:=Form1.GetCDCover(welkecover,'','');
  if CD_Cover_Temp='x' then
  begin
    Synchronize(@HideCDCover);
    if welkecover>-1 then CD_Cover_Temp:=Form1.GetCDArtworkfromfile(Liedjes[welkecover].Pad+Liedjes[welkecover].Bestandsnaam);
  end;
  if CD_Cover_Temp='x' then CD_Cover_temp:=Form1.GetCDArtworkfromLastFM(welkecover);
  Synchronize(@ShowCDCover);
  ThreadRunning:=false;
  ThreadCDCover.FreeOnTerminate:=True;
  ThreadCDCover.Terminate;
end;

procedure TGetCDCoverThread.ShowCDCover;
begin
  if FormLog.CB_Log.Checked then
  begin
    FormLog.MemoDebugLog.Lines.Add('ShowCDCover.CD_Cover_Temp='+CD_Cover_Temp);
    FormLog.MemoDebugLog.Lines.Add('ShowCDCover.Loaded_Cover_Temp='+Loaded_CD_Cover);
    FormLog.MemoDebugLog.Lines.Add('coverthread='+inttostr(coverthread));
    FormLog.MemoDebugLog.Lines.Add('welkecover='+inttostr(welkecover));
  end;

  if coverthread=welkecover then
   begin
    if (CD_Cover_Temp<>Loaded_CD_Cover) and (CD_Cover_Temp<>'x') then
     begin
       if FormLog.CB_Log.Checked then FormLog.MemoDebugLog.Lines.Add('Loading CD Cover '+CD_Cover_temp);
       Loaded_CD_Cover:=CD_Cover_temp;
       TRY
         FormCoverPlayer.ImageCDCover.Picture.LoadFromFile(CD_Cover_temp);
       ExCEPT
         FormCoverPlayer.iMAGEcdcOVER.Picture.Bitmap:=FormDetails.Image2.Picture.Bitmap;
       end;

       if settings.CDCoverInfo then Form1.ImageCDCover.Picture.Bitmap:=FormCoverPlayer.ImageCdCover.Picture.Bitmap;
       if Settings.CDCoverInfo and Settings.CDCoverLyrics then
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

  if (CD_Cover_Temp='x') then
      begin
        if FormLog.CB_Log.Checked then FormLog.MemoDebugLog.Lines.Add('Clearing CD Cover');
        Form1.ClearCDCover;
        Form1.Splitter4.Enabled:=false;
        Loaded_CD_Cover:='x';
      end;

  form1.MI_GetArtworkFromFile.Enabled:=True;
end;

procedure TGetCDCoverThread.HideCDCover;
begin
  if (CD_Cover_Temp='x') then
    begin
      Form1.ClearCDCover;
      Form1.Splitter4.Enabled:=false;
      Loaded_CD_Cover:='x';
      if FormLog.CB_Log.Checked then FormLog.MemoDebugLog.Lines.Add('Clearing CD Cover');
    end;
end;

procedure TLastFMInfoThread.ShowMe;
begin
  Form1.LB_MostPlayed.Items.AddStrings(MostPlayed);
  Form1.LB_MostPlayed.TopIndex:=1;
  Form1.SB_LastFM.enabled:=True;
end;

procedure TLastFMInfoThread.Execute;
var i: longint;
    temp: string;
    {$IFDEF HAIKU} doorgaan:Boolean=False; {$ENDIF}
begin
    MostPlayed.Clear;
    begin
      {$IFDEF HAIKU}
      DeleteFile(tempdir+Directoryseparator+'MostPlayed.txt');
      If Form1.DownLoadFile('http://ws.audioscrobbler.com/2.0/?method=artist.getTopTracks&artist='+Form1.MakeWikiArtist(Form1.LB_Artiest.Caption,'+')+'&api_key=a2c1434814fb382c6020043cbb13b10d',tempdir+Directoryseparator+'MostPlayed.txt') then
        begin
         MostPlayed.LoadFromFile(tempdir+Directoryseparator+'MostPlayed.txt');
         doorgaan:=true;
        end;
      if doorgaan then
      {$ELSE}
      if HttpGetText('http://ws.audioscrobbler.com/2.0/?method=artist.getTopTracks&artist='+Form1.MakeWikiArtist(Form1.LB_Artiest.Caption,'+')+'&api_key=a2c1434814fb382c6020043cbb13b10d',MostPlayed) then
      {$ENDIF}
      begin
       i:=0;
       repeat
         if (pos('name>',MostPlayed.Strings[i])<1) or (pos('artist>',MostPlayed.Strings[i])>1) then MostPlayed.Delete(i)
                                               else
         begin
           temp:=MostPlayed.Strings[i];
           Delete(temp,1,pos('name>',temp)+4); Delete(temp,length(temp)-6,7);
           temp:=Form1.ReplaceHTMLQoutes(temp);
           MostPlayed.Strings[i]:=temp;
           inc(i);
           temp:=MostPlayed.Strings[i];
           Delete(temp,1,pos('ount>',temp)+4); Delete(temp,length(temp)-11,12);
           MostPlayed.Strings[i-1]:=MostPlayed.Strings[i-1]+'   -  '+temp+' times played' ;
           MostPlayed.Delete(i);
         end;
       until pos('/lfm',MostPlayed.Strings[i])>0;
       MostPlayed.delete(i);
       Synchronize(@ShowMe);
     end;
   end;
   Form1.SB_LastFM.Enabled:=True;
end;

procedure TSearchForPlaylistThread.Execute;
var i: longint;
  aList: TStringList;
begin
   if Settings.IncludeLocaleDirs.Count>0 then
  begin
    for i:=0 to Settings.IncludeLocaleDirs.Count-1 do
    begin
      if Settings.IncludeLocaleDirsChecked[i] then
      begin
        aList := FindAllFiles(Settings.IncludeLocaleDirs.Strings[i], '*.m3u', True);
        PlaylistsFound.addstrings(aList);
        aList.Free;
      end;
    end;
  end;

  if Settings.IncludeExternalDirs.Count>0 then
  begin
    for i:=0 to Settings.IncludeExternalDirs.Count-1 do
    begin
      if Settings.IncludeExternalDirsChecked[i] then
      begin
        aList := FindAllFiles(Settings.IncludeExternalDirs.Strings[i], '*.m3u', True);
        PlaylistsFound.AddStrings(aList);
        aList.Free;
      end;
    end;
  end;
  if PlaylistsFound.count>0 then For i:=0 to PlaylistsFound.Count-1 do M3UFilesFound.Add(PlaylistsFound.Strings[i]);
  Synchronize(@ShowPlaylist);
  Terminate;
end;

procedure TSearchForPlaylistThread.ShowPlaylist;
var i: longint;
begin
  if FormLog.CB_Log.Checked then
  begin
    FormLog.MemoDebugLog.Lines.Add('M3U Playlists found: '+inttostr(M3uFilesFound.Count));
    FormLog.MemoDebugLog.Lines.Add('Loading M3U Playlists into ListBox');
  end;
  Form1.LB_M3U.Items.Clear;
  if M3uFilesfound.count>0 then For i:=1 to M3uFilesFound.Count do Form1.LB_M3U.Items.Add(ExtractFilename(M3uFilesFound.Strings[i-1]));
  Form1.SB_ReloadPlaylist.Enabled:=True; Form1.SB_ReloadPlaylist.Caption:=Form1.Vertaal('Reload M3U playlists');
  PlaylistsFound.Clear;
end;

procedure TSearchForSongTextThread.Execute;
var gevonden: boolean;
    i, i2, i_einde, i_begin, x: integer;
begin
  ThreadSongTextRunning:=true;
  gevonden:=false; x:=LyricsNotFound.Count;
  if x>0 then
  begin
   for i:=x-1 downto 0 do
    try
     if LyricsNotFound.Strings[i]=CachedLyrics then
     begin
      Synchronize(@NoLyrics);
      gevonden:=true;
      break;
     end;
    except
      break;
    end;
  end;

  if LyricsNotFound.Count>100 then
  begin
   LyricsNotFound.Free;
   LyricsNotFound:=TStringlist.Create;
  end;

  if not gevonden then
  begin
    DeleteFile(tempdir+Directoryseparator+'songtext.txt');
    gevonden:=false; //goed:=false;

    if (Settings.CacheSongtext) then if (SearchLyrics=0) then
      if FileExistsUTF8(CachedLyrics) then
                                        BEGIN
                                          lyricssource:='*** CACHE ***';
                                          Synchronize(@ShowLyrics);
                                          gevonden:=true;
                                        end;

    // LYRICS ZIT NIET IN CACHE
    if not gevonden then
    begin
      if SearchLyrics=0 then
      begin
        i_begin:=0; i_einde:=FormConfig.CLB_Lyrics.Count-1;
      end
                        else
      begin
        i_begin:=SearchLyrics; i_einde:=SearchLyrics;
      end;

      for i2:=i_begin to i_einde do
      begin
        LyricsVar:=TLyrics.Create;
        LyricsVar.GetSourceInfo(FormConfig.CLB_Lyrics.Items[i2]);
        LyricsVar.CreateLyricURL(ArtistLyric, TitleLyric);
        if LyricsVar.GetLyric(LyricsVar.LyricURL) then
        begin
          if LyricsVar.LyricsText.Count>2 then
          begin
            LyricsVar.LyricsText.SaveToFile(tempdir+Directoryseparator+'songtext2.txt');
            LyricsSource:=Lyricsvar.BaseURL;  urlvar:=Lyricsvar.LyricURL;
            LyricsVar.Free;
            Synchronize(@ShowLyrics);
            gevonden:=true;
            break;
         end;
        end;
        LyricsVar.Free;
      end;


    if not gevonden then
                    begin
                      LyricsNotFound.Add(CachedLyrics);
                      Synchronize(@NoLyrics);
                    end
                    else CopyFile(tempdir+Directoryseparator+'songtext2.txt',CachedLyrics);
    end;
  end;
//EINDE SONGTEXT

 ThreadSongTextRunning:=false;
 ThreadSongText.FreeOnTerminate:=True;
 ThreadSongText.Terminate;
end;

procedure TForm1.Got_Connection(var Msg: TMessage);
begin
  sock := TTCPBlockSocket.Create;
  Sock.socket := TSocket(Msg.wParam);
  sock.GetSins;
  Receive := TTCPReceiveThrd.Create(Sock.socket);
  if Formlog.CB_Log.Checked then FormLog.MemoDebugLog.Lines.Add('Incoming Connected');
  RemoteConnection:=True;
end;

//REMOTE
procedure TForm1.Got_String(var Msg: TMessage);
var rcvd_String: String;
    sub_String: String;
    i: longint;
begin
  rcvd_String:=StrPas(PChar(Msg.wParam));
  MessageUsed:=rcvd_String;
  case rcvd_String of
   'XIX: Get all files': begin
                          for i:=0 to maxsongs-1 do
                            begin;
                              sock.SendString(ansistring('FILE: '+inttostr(i)+'.&.'+Liedjes[i].Artiest+'.&.'+Liedjes[i].Titel));
                              Sleep(20);
                            end;
                          Sleep(120);
                          sock.SendString(ansistring('FILE END'));
                          MessageUsed:='nil';
                        end;
   'XIX: Get playingqueue': begin
                              if SG_Play.RowCount >1 then
                              for i:=1 to SG_Play.RowCount-1 do
                              begin;

                                sock.SendString(ansistring('QUEUE: '+SG_Play.Cells[6,i]+'.&.'+SG_Play.Cells[1,i]+'.&.'+SG_Play.Cells[3,i]));
                                Sleep(40);
                              end;
                              sock.SendString(ansistring('QUEUE END'));
                              MessageUsed:='nil';
                            end;
   'XIX: Get Artists': begin
                          for i:=0 to LB_Artist1.Items.Count-1 do
                            begin;
                              sock.SendString(ansistring('ARTIST: '+LB_Artist1.Items[i]));
                              Sleep(10);
                            end;
                          Sleep(120);
                          sock.SendString(ansistring('ARTIST END'));
                          MessageUsed:='nil';
                        end;
   'XIX: Get Radiostations': begin
                         For i:=1 to 2200 do
                         begin
                           if length(RadioStation[i].naam)>0 then
                            begin;
                              sock.SendString(ansistring('RADIO: '+inttostr(i)+', '+RadioStation[i].naam));
                              Sleep(10);
                            end;
                          end;
                          Sleep(120);
                          For i:=1 to Stringgridpresets.RowCount-1 do
                          begin
                              sock.SendString(ansistring('PRESET: '+StringgridPresets.Cells[0,i])+', '+StringgridPresets.Cells[1,i]);
                              Sleep(10);
                          end;
                          Sleep(120);
                          sock.SendString(ansistring('RADIO END'));
                          MessageUsed:='nil';
                      end;
   'XIX: Help me': begin
                      sock.SendString(ansistring('You can use the following commands:'+#13+'XIX: Play - To start playing'
                      +#13+'XIX: Play selected - Starts playing the selected song'
                      +#13+'XIX: Stop - To stop the music'
                      +#13+'XIX: Next - To play the next song'
                      +#13+'XIX: Previous - To play the previous song'
                      +#13+'XIX: Reverse - To start playing backwards'
                      +#13+'XIX: Pauze - To pauze to music'
                      +#13+'XIX: Volume up - To increase the volume'
                      +#13+'XIX: Volme down - To decrease the music')
                      +#13+'XIX: Play artist <artist> - To select <Artist> and start playing'
                      +#13+'XIX: Play song <song nr> - To select and play the song at <song nr>'
                      +#13+'XIX: Select artist <artist> - To select <artist>'
                      +#13+'XIX: Select song <song title> - To select <song title>'
                      +#13+'XIX: Get Status - Status Shuffle, Repeat, Song Number Playing, Stream, Name Song Playing'
                      +#13+'XIX: Fullscreen - Puts XiXMusicPlayer in fullscreen'
                      +#13+'XIX: Fullscreen off - Exits XiXMusicPlayer fullscreen mode'
                      +#13+'XIX: Radio - Show the Radio Tab'
                      +#13+'XIX: Radio station <Nr of RadioStation> - Plays the selected RadiosStation'
                      +#13+'XIX: Radio preset <Nr of preset> - Plays the RadioStation at preset'
                      +#13+'XIX: listenlive.eu preset <Nr of preset> <Country> - Plays the station from ListenLive.eu'
                      +#13+'XIX: Get songs from <artist> - Lists all songs from <artist>'
                      );
                      MessageUsed:='nil';
                    end;
   (*
    'XIX: Mute': Begin
                 end;
    'XIX: Mute off': Begin
                     end;  *)
    'XIX: Get Status': begin      // Song Playing - Settings
                         sock.SendString('STATUS: '+ansistring(booltostr(Settings.Shuffle)+','+inttostr(Settings.RepeatSong)+','+inttostr(songrowplaying)+','+inttostr(Stream)));
                         Sleep(60);
                         if stream<5 then sock.SendString('PLAYING: '+inttostr(songplaying)+') '+Liedjes[songplaying].Artiest+' - '+Liedjes[songplaying].Titel);
                         MessageUsed:='nil';
                       end;
    else
      if pos('XIX: Get songs from', Messageused)>0 then            // Send all songs from ARTIST
         begin
           Sub_String:=Copy(Messageused,21,length(Messageused));
           for i:=0 to maxsongs-1 do
             begin
               if Liedjes[i].Artiest=Sub_String then
               begin;
                 sock.SendString(ansistring('SONG: '+inttostr(i)+', '+Liedjes[i].Titel));
                 Sleep(20);
               end;
             end;
             Sleep(120);
             sock.SendString(ansistring('SONG END'));
           end;
  end;
  if MessageUsed<>'nil' then TimerTCP.Enabled:=True;
end;


function TForm1.ReplaceHTMLQoutes(lijn: string): string;
begin
  lijn:=StringReplace(lijn,'&quot;','"',[rfReplaceAll, rfIgnoreCase]);
  lijn:=StringReplace(lijn,'&auml;','ä',[rfReplaceAll, rfIgnoreCase]);
  lijn:=StringReplace(lijn,'&euml;','ë',[rfReplaceAll, rfIgnoreCase]);
  lijn:=StringReplace(lijn,'&ouml;','ö',[rfReplaceAll, rfIgnoreCase]);
  lijn:=StringReplace(lijn,'&amp;','&',[rfReplaceAll, rfIgnoreCase]);
  lijn:=StringReplace(lijn,'&eacute;','é',[rfReplaceAll, rfIgnoreCase]);
  lijn:=StringReplace(lijn,'&apos;','''',[rfReplaceAll, rfIgnoreCase]);
  lijn:=StringReplace(lijn,'&lt;','<',[rfReplaceAll, rfIgnoreCase]);
  lijn:=StringReplace(lijn,'&gt;','>',[rfReplaceAll, rfIgnoreCase]);
  ReplaceHTMLQoutes:=lijn;
end;

function TForm1.ConvertArtist(artiest: string; nospaces: boolean): string;
var Temp_Artist: string;
    max, i: integer;
    ch: char;
begin
  Temp_Artist:=''; ch:=' ';
  if nospaces then artiest:=StringReplace(artiest,' ','',[rfReplaceAll, rfIgnoreCase]);
  max:=length(artiest);
   for i:=1 to max do
     begin
       if (artiest[i]=' ') then
       begin
         if ch<>'-' then Temp_Artist:=Temp_Artist+'-'; //Dubbele - uithalen
         ch:='-';
       end
         else if artiest[i] in ['''', ',', '?', '.', '*', '/', ':'] then Temp_Artist:=Temp_Artist
                                       else
                                         begin
                                           Temp_Artist:=Temp_Artist+Artiest[i];
                                           ch:='x';
                                         end;
      end;
   Temp_Artist:=lowercase(Temp_Artist);
   Temp_Artist:=StringReplace(Temp_Artist,'&','and',[rfReplaceAll]);
   if not nospaces then
   begin
    // if upcase(Temp_Artist)='ACDC' then Temp_Artist:='ac-dc';
     if (upcase(Temp_Artist)='CCR') or (upcase(Temp_Artist)='C.C.R.') then Temp_Artist:='creedence-clearwater-revival';
   end;
   ConvertArtist:=Temp_artist;
end;

function TForm1.ConvertTitle(titel: string): string;
var Temp_Title: string;
    max, i: integer;
    ch: char;
begin
  Temp_Title:=''; ch:=' ';
  max:=length(titel);
     for i:=1 to max do
       begin
        if titel[i]=' ' then
         begin
          if ch<>'-' then Temp_Title:=Temp_Title+'-';
          ch:='-';    //Dubbele spaties weghalen
         end
           else if titel[i] in ['''', ',', '?','*','/', ':'] then Temp_Title:=Temp_Title
                                        else
                                        begin
                                           Temp_Title:=Temp_Title+titel[i];
                                           ch:='x';
                                        end;

       end;
     Temp_Title:=lowercase(Temp_Title);
     Temp_Title:=StringReplace(Temp_Title,'-(demo)','',[rfReplaceAll, rfIgnoreCase]);
     Temp_Title:=StringReplace(Temp_Title,'-[demo]','',[rfReplaceAll, rfIgnoreCase]);
     Temp_Title:=StringReplace(Temp_Title,'-(live)','',[rfReplaceAll, rfIgnoreCase]);
     Temp_Title:=StringReplace(Temp_Title,'-[live]','',[rfReplaceAll, rfIgnoreCase]);
     Temp_Title:=StringReplace(Temp_Title,'-(unplugged)','',[rfReplaceAll, rfIgnoreCase]);
     ConvertTitle:=Temp_Title;
end;

function TForm1.ConvertAlbum(titel: string): string;
var Temp_Title: string;
    max, i: integer;
begin
 Temp_Title:=''; max:=length(titel);
 for i:=1 to max do
   begin
     if titel[i] in [' ', '''', ',', '?','*','/', ':'] then Temp_Title:=Temp_Title
                                                       else Temp_Title:=Temp_Title+titel[i];
   end;
 ConvertAlbum:=lowercase(Temp_Title);
end;

procedure TForm1.VertaalForm1;
begin
   if LB_Artist1.Items.Count>1 then LB_Artist1.Items[0]:=Vertaal('All');
   TabsheetArtists.Caption:=Vertaal('Artists'); Label4.Caption:=Vertaal('Artists')+':';
   TabsheetAlbums.Caption:=Vertaal('Albums'); Label1.Caption:=Vertaal('Albums')+':';
   TabsheetPlaylists.Caption:=vertaal('Playlists');
   TabsheetFiles.Caption:=vertaal('File Manager');
   TabsheetPlayQue.Caption:=Vertaal('Playing Queue');
   Tabsheet10.Caption:=Vertaal('Lyrics');
   TabSheetFiles2.Caption:=Vertaal('Files');
   TabSheetBrowser.Caption:=TabSheetFiles2.Caption;
   TabSheet11.Caption:=Vertaal('Artist Info');
   TabSheet12.Caption:=Vertaal('Discography');
   TabSheet14.Caption:=Vertaal('Online');
   TabSheet15.Caption:=Vertaal('Presets');
   TabSheet16.Caption:=Vertaal('Recorded');

   Label3.Caption:=Vertaal('Source');
   LabelCDEntry.Caption:=Vertaal('Choose the CD entry')+':';
   Label7.Caption:=Vertaal('Genre')+':';
   Label2.Caption:=Vertaal('Similar artists')+':';
   Label8.Caption:=Vertaal('Information')+':';
   Label10.Caption:=Vertaal('CD Cover and Lyric')+':';

   SG_All.Cells[1,0]:=Vertaal('Artist'); SG_Play.Cells[1,0]:=Vertaal('Artist');
   SG_CUE.Cells[1,0]:=Vertaal('Artist');
   SG_All.Cells[3,0]:=Vertaal('Title'); SG_Play.Cells[3,0]:=Vertaal('Title');
   SG_CUE.Cells[2,0]:=Vertaal('Title');
   SG_All.Cells[COL_SG_ALL_PATH, 0]:=Vertaal('Path'); SG_Play.Cells[5,0]:=Vertaal('Year');
   SG_All.Cells[COL_SG_ALL_NAME, 0]:=Vertaal('Filename'); SG_Play.Cells[4,0]:=Vertaal('Album');
   SG_Disco.Cells[0,0]:=Vertaal('Album'); SG_CUE.Cells[4,0]:=Vertaal('Album');
   SG_Disco.Cells[1,0]:=Vertaal('Year');
   StringgridRadioAir.Cells[1,0]:=Vertaal('Name');
   SG_ListenLive.Cells[1,0]:=Vertaal('Name');
   StringGridPresets.Cells[1,0]:=Vertaal('Name');
   StringgridRadioAir.Cells[2,0]:=Vertaal('Country');
   SG_ListenLive.Cells[2,0]:=Vertaal('Country');
   StringGridPresets.Cells[2,0]:=Vertaal('Country');
   StringgridRadioAir.Cells[3,0]:=Vertaal('Genres');
   SG_ListenLive.Cells[3,0]:=Vertaal('Genres');
   StringGridPresets.Cells[3,0]:=Vertaal('Genres');
   StringGridCD.Cells[0,0]:=Vertaal('Track');
   StringGridCD.Cells[1,0]:=Vertaal('Artist');
   StringGridCD.Cells[2,0]:=Vertaal('Title');
   StringGrid1.Cells[1,0]:=Vertaal('Title');
   StringGridCD.Cells[3,0]:=Vertaal('Album');
   StringGridCD.Cells[4,0]:=Vertaal('Time');
   SG_CUE.Cells[3,0]:=Vertaal('Time');
   StringGridCD.Cells[5,0]:=Vertaal('Year');
   StringGridCD.Cells[6,0]:=Vertaal('Genre');
   StringGrid1.Cells[0,0]:=Vertaal('Date');
   StringGridRecorded.Cells[0,0]:=Vertaal('Date');
   StringGridRecorded.Cells[1,0]:=Vertaal('Radio Station');

   CB_Land1.Caption:=Vertaal('Country')+':';
   CB_GenreRadio1.Caption:=Vertaal('Genre')+':';

   SB_New.Caption:=Vertaal('New');
   Sb_Save.Caption:=Vertaal('Save');
   SB_Rename.Caption:=Vertaal('Rename');
   SB_Copy.Caption:=Vertaal('Copy');
   SB_Delete.Caption:=Vertaal('Delete');
   SpeedButton16.Caption:=Vertaal('Delete');
   SB_Presets.Caption:=Vertaal('Preset');
   SB_RadioAdd.Caption:=Vertaal('Add');
   SB_RadioRecord.Caption:=Vertaal('Record');
   SB_RadioPlan.Caption:=Vertaal('Plan');
   SpeedButton14.Caption:=Vertaal('Add');
   SpeedButton26.Caption:=Vertaal('Delete');
   SB_PodcastUp.Caption:=Vertaal('Up');
   SB_PodcastDown.Caption:=Vertaal('Down');
   SB_PodcastSave.Caption:=Vertaal('Save');

   CheckBox1.Caption:=Vertaal('Genre');
   CB_Year.Caption:=Vertaal('From year');
   Label11.Caption:=Vertaal('until');
   Label12.Caption:=Vertaal('Stars')+':';
   Speedbutton17.Caption:=Vertaal('Build Playlist');

   MI_SGALL_Play1.Caption:=Vertaal('Play (add to Playing Queue)');
   MI_SGALL_Play2.Caption:=Vertaal('Play (do not add Playing Queue)');
   MI_SGALL_OpenFolder.Caption:=Vertaal('Open folder');
   MI_SGALL_CopyTo.Caption:=Vertaal('Copy item to');
   MI_SGALL_Rename.Caption:=Vertaal('Rename item');
   MI_SGALL_Delete.Caption:=Vertaal('Delete item(s)');
   Menuitem155.Caption:=Vertaal('Show');
   Menuitem142.Caption:=Vertaal('Add Selected');
   MI_SGALL_AddAll.Caption:=Vertaal('Add all to Playing Queue');
   MI_SGALL_AddToEnd.Caption:=Vertaal('to end of Playing Queue');
   MI_AddToPlaylist1.Caption:=Vertaal('Add to playlist');
   MI_AddToPlaylist2.Caption:=MI_AddToPlaylist1.Caption;
   MI_RemoveFromPlaylist.Caption:=Vertaal('Remove song(s) from playlist');
   MI_SGALL_AddToBegin.Caption:=Vertaal('to beginning of Playing Queue');
   MI_SGALL_AddAfterCurrent.Caption:=Vertaal('after song currently being played');
   MI_CurrentSong1.Caption:=MI_SGALL_AddAfterCurrent.Caption;
   MI_SGALL_CopyToFolder.Caption:=Vertaal('Folder');
   MI_SGALL_SameArtist.Caption:=Vertaal('Same Artist');
   MI_SGALL_SameAlbum.Caption:=Vertaal('Same Album');
   MI_SGALL_SameGenre.Caption:=Vertaal('Same Genre');
   MI_SGALL_SameYear.Caption:=Vertaal('Same Year');
   MenuItem44.Caption:=vertaal('Fill in Artist');
   MenuItem50.Caption:=vertaal('Fill in Album');
   MenuItem52.Caption:=vertaal('Fill in Year');
   MenuItem53.Caption:=vertaal('Fill in Genre');
   MI_CDCover_ChooseNewFile.Caption:=vertaal('Choose other CD artwork');
   MI_CDCover_RemoveCDCover.Caption:=vertaal('Remove CD Artwork from cache');
   MenuItem88.Caption:=vertaal('Do not show artwork');
   MI_GetArtworkFromFile.Caption:=Vertaal('Get Artwork from song');
   MenuItem60.Caption:=MI_SGALL_SameArtist.Caption;
   MenuItem74.Caption:=MI_SGALL_SameAlbum.Caption;
   MenuItem75.Caption:=MI_SGALL_SameGenre.Caption;
   MenuItem76.Caption:=MI_SGALL_SameYear.Caption;
   MI_SGALL_ShowInfo.Caption:=Vertaal('Information');
   MenuItem78.Caption:=MI_SGALL_ShowInfo.Caption;
   MI_SGALL_About.Caption:=Vertaal('About');
   Mi_About2.Caption:=Vertaal('About');
   MI_FadingOptions1.Caption:=Vertaal('Fading options');
   MI_SGALL_SetFade.Caption:=Vertaal('Set FADE');
   MI_SGALL_RemoveFade.Caption:=Vertaal('Remove FADE');
   MI_Move1.Caption:=Vertaal('Move');
   MI_SGALL_Tagger.Caption:=Vertaal('TAG/RENAME Selected song(s)');

   Mi_AddToPresets.Caption:=Vertaal('Add Station to Presets');
   MI_AddNewRadio.Caption:=Vertaal('Add New Radiostation');
   MenuItem47.Caption:=Vertaal('Edit Radiostation');
   MenuItem48.Caption:=Vertaal('Remove Radiostation');
   MI_RecordFromRadio.Caption:=Vertaal('Record from Radiostation');
   MI_UpdateRadio.Caption:=Vertaal('Update Radio Listing (Internet update)');

   MI_CopyRecording.Caption:=Vertaal('Copy Recording to')+'...';
   Mi_DeleteRecording.Caption:=Vertaal('Delete recording');

   MenuItem55.Caption:=Vertaal('Play');
   MI_Play.Caption:=MenuItem55.Caption;
   MI_Reshuffle.Caption:=Vertaal('Reshuffle');
   MenuItem73.Caption:=Vertaal('Open folder');

   MenuItem61.Caption:=Vertaal('Remove selected from Playing Queue');
   MenuItem62.Caption:=Vertaal('Empty Playing Queue');
   MenuItem64.Caption:=Vertaal('Save Playing Queue as new playlist');
   MenuItem68.Caption:=Vertaal('Copy item to');
   MenuItem69.Caption:=Vertaal('Rename item');
   Menuitem70.Caption:=Vertaal('Delete item');
   MenuItem79.Caption:=Vertaal('Folder');
   Menuitem72.Caption:=Vertaal('Show');
   MenuItem73.Caption:=Vertaal('Open folder');

   MenuItem93.Caption:=Vertaal('Save Songtext');
   MI_ReloadSongtext.Caption:=Vertaal('Reload Songtext');
   MenuItem96.Caption:=Vertaal('Reload Songtext from');
   MenuItem106.Caption:=Vertaal('File');
   MI_RemoveSongtext.Caption:=Vertaal('Remove Songtext');

   MI_GoToAlbum.Caption:=Vertaal('Go to Album');
   MI_PlayAlbum.Caption:=Vertaal('Play complete album');

   MI_Play.Caption:=Vertaal('Play');
   MI_Pauze.Caption:=Vertaal('Pauze');
   MI_Stop.Caption:=Vertaal('Stop');
   MI_Prev.Caption:=Vertaal('Previous');
   MI_Next.Caption:=Vertaal('Next');
   MI_Fullscreen.Caption:=Vertaal('Fullscreen');
   MI_About.Caption:=Vertaal('About');
   MenuItem58.Caption:=Vertaal('Exit');

   Menuitem19.Caption:=Vertaal('Create New Playlist');
   MenuItem40.Caption:=Vertaal('Duplicate Playlist');
   Menuitem41.Caption:=Vertaal('Rename Playlist');
   Menuitem43.Caption:=Vertaal('Delete Playlist');

   CB_Land.Caption:=Vertaal('Country')+':';
   CB_GenreRadio.Caption:=Vertaal('Genre')+':';
   Label14.Caption:=Vertaal('General Search String')+':';
   Label32.Caption:=Vertaal('General Search String')+':';
   Speedbutton7.Hint:=Vertaal('Open Search Dialog');
   SB_Config.Hint:=vertaal('Open configuration dialog');
   Speedbutton1.Hint:=Vertaal('Switch Fullscreen mode');
   SB_ReadCD.Hint:=Vertaal('Read CD Info');
   SB_CDText.Hint:=Vertaal('Try to read CD-text');
   SB_RipCD.Hint:=Vertaal('Rip Tracks from the CD to MP3 or FLAC');
   SB_ReadCD.Caption:=Vertaal('Read CD');
   SB_ReadDVD.Caption:=Vertaal('Read DVD');
   LB_Search1.Caption:=Vertaal('Search');
   CB_From1.Caption:=Vertaal('From');
   LB_To1.Caption:=Vertaal('to');
   CB_Station.Caption:=Vertaal('Station')+':';

   MI_PlayArtist1.Caption:=Vertaal('Play Artist');
   MI_TagArtist1.Caption:=Vertaal('Tag songs from this artist');
   MI_PlayAlbum2.Caption:=Vertaal('Play Album');
   MI_TagAlbum2.Caption:=Vertaal('Tag Album');
   CB_UseCue.Caption:=Vertaal('Use .CUE info');

   MI_AddFolderToConfig.Caption:=Vertaal('Add selected folder to locale XiXMusicPlayer folders');

   MI_Wiki1Custom.Caption:='Info on Wikipedia ('+uppercase(Settings.Language)+')';
end;


procedure TDownloadPodCastThread.Execute;
var fs: TFilestream;
    mode, temp, temp2, folder: string;
begin
  Downloadpodcast:=True;
  Repeat
    mode:=copy(FormDownLoadOverView.ListBox1.Items[0],1,4);
    if upcase(mode)='HTTP' then
    begin
      fs := TFileStream.Create(saveDownloadTo[0], fmOpenWrite or fmCreate);
      try
        HttpGetBinary(FormDownLoadOverView.ListBox1.Items[0], fs);
      finally
         fs.Free;
      end;
    end
    else
    begin
      temp:=saveDownloadTo[0]; folder:='';
      repeat
        temp2:=copy(temp,1,pos(DirectorySeparator,temp));
        folder:=folder+temp2;
        if not directoryexists(folder) then CreateDirUTF8(folder);
        temp:=copy(temp,pos(DirectorySeparator,temp)+1,length(temp));
      until pos(DirectorySeparator,temp)=0;
      if not directoryexistsUTF8(saveDownloadTo[0]) then CreateDirUTF8(saveDownloadTo[0]);
      CopyFile(FormDownLoadOverView.ListBox1.Items[0],saveDownloadTo[0]+DirectorySeparator+ExtractFilename(FormDownLoadOverView.ListBox1.Items[0]));
    end;
    SaveDownLoadTo.Delete(0);                                      // Must go outside the thread to be thread safe
    Form1.LabelPodcast.Caption:=inttostr(SaveDownloadTo.Count);    // Must go outside the thread to be thread safe
    FormDownLoadOverView.ListBox1.Items.Delete(0);                 // Must go outside the thread to be thread safe
  until SaveDownLoadTo.Count=0;
  Downloadpodcast:=False;
  Thread1.FreeOnTerminate:=True;
  Thread1.Terminate;
end;

procedure TDownloadPodCastThread.OnTerminate;
begin
  Downloadpodcast:=False;
  Form1.LabelPodcast.Caption:='0';
end;

procedure TForm1.FormCreate(Sender: TObject);
var ldata: pchar;
    i: byte;
    {$IFDEF LINUX} libdir: string; {$ENDIF}
begin
  FirstTime:=True;  isfullscreen:=false;
  Randomize;

  MostPlayed := tstringlist.Create;   Settings := TSettings.create;
  FilesFound:=TStringList.Create;     M3uFilesfound:=TStringList.Create;
  PlaylistsFound:=TStringlist.Create; SaveDownloadto:=TStringlist.Create;
  LyricsNotFound:=TStringlist.Create; Artiesten:=TStringlist.Create;
  Albums:=TStringList.Create;

  // Put Images in Place
 // {$IFDEF HAIKU}
 // {$ELSE}
 // Image9.Picture.LoadFromResourceName(HInstance,'background-hoofd');
 // {$ENDIF}

  {$IFDEF LINUX}  // Problems with preloaded Images.  Need to check
  Image1.Picture.Bitmap:=Image2.Picture.Bitmap;
  ImageListStars.GetBitmap(1, Ster1.Picture.Bitmap);
  ImageListStars.GetBitmap(1, Ster2.Picture.Bitmap);
  ImageListStars.GetBitmap(1, Ster3.Picture.Bitmap);
  ImageListStars.GetBitmap(1, Ster4.Picture.Bitmap);
  ImageListStars.GetBitmap(1, Ster5.Picture.Bitmap);
  {$ENDIF}

 (* StartDir:=ExtractFilePath(Paramstr(0));
  ConfigDir:=ChompPathDelim(GetAppConfigDir(True));
  TempDir:=ChompPathDelim(GetTempDir(False)); HomeDir:=ChompPathDelim(GetEnvironmentVariable('HOME'));
  if DirectoryExists(ConfigDir+DirectorySeparator+'plugins') then PlugInDir:=ConfigDir+DirectorySeparator+'plugins'
    else if DirectoryExists('/usr/lib/xixmusicplayer/plugins') then PlugInDir:='/usr/lib/xixmusicplayer/plugins'
      else PluginDir:=ExtractFilePath(Paramstr(0))+'plugins';    *)

  StartDir:=ExtractFileDir(Paramstr(0));      ConfigDir:=ChompPathDelim(GetAppConfigDir(False));
  TempDir:=ChompPathDelim(GetTempDir(False)); HomeDir:=ChompPathDelim(GetEnvironmentVariable('HOME'));
  if DirectoryExists(ConfigDir+DirectorySeparator+'plugins') then PlugInDir:=ConfigDir+DirectorySeparator+'plugins'
    else if DirectoryExists('/usr/lib/xixmusicplayer/plugins') then PlugInDir:='/usr/lib/xixmusicplayer/plugins'
      else PluginDir:=ExtractFilePath(Paramstr(0))+'plugins';

  aantalsterren:=0; schedulehasstarted:=False; plannedrecordings:=0; Streamsave:=False;
  SongsInPlayingQueue:=0; songrowplaying:=1; isfullscreen:=false; songplaying:=0;
  PlayingFromRecorded:=False; Threadrunning:=false; ThreadArtiestInfoRunning:=False; personalradio:=2000;
  IsMediaModeOn:=false; Settings.NetworkControl:=true;
  Listen:=nil; Sock:=nil; RemoteConnection:=false;
  CoverModePlayer:=1; Loaded_CD_Cover:='x';

  ScheduleSettings.CopyRec:=False; ScheduleSettings.RenameRec:=False; ScheduleSettings.Overwrite:=False;
  ScheduleSettings.CopyDir:=Homedir; ScheduleSettings.RenameFormat:='%Y-%M-%D - %R';

  Settings.DeleteMacOSFiles:=False; Settings.Soundcard:=1;
  Settings.CDCoverInfo:=True; Settings.CDCoverLyrics:=True;
  Settings.TimerInterval:=80;
  if (Paramstr(1)='-cdb') then Settings.cdb:=strtointdef(paramstr(2),250);
  {$if defined(LCLQT) or defined(LCLQT5)} Settings.TabArtist:=1; {$ENDIF}

  VU_Settings.Placement:=2; VU_Settings.ShowPeaks:=False;
  VU_Settings.Active:=1;    VU_Settings.Theme:=2;

  Level:=50; Delay:=6000;        // FX Echo
  wet:=60; Speed:=200;           // FX Flanger
  revLevel:=30; revDelay:=3000;  // FX Reverb
  is_echo_on:=false; is_flanger_on:=false; is_reverb_on:=false; EQ_Set:=0;

  Lameopties.vbr:=false; Lameopties.abr:=false; Lameopties.Mono:=false; LameOpties.pr:=True;
  Lameopties.Bitratemin:='192';  Lameopties.BitrateMax:='320';Lameopties.cbr:=false;
  LameOpties.Preset:='0'; lameopties.BitRateQuality:='192';
  LameOpties.EncQuality:='extreme';

  OGGopties.cbr:=false; OGGopties.vbr:=true; OGGopties.ForceQuality:=true; OGGopties.EncQuality:='8';
  OGGopties.mmode:=false; OGGopties.BitrateMin:='96'; OGGopties.BitrateMax:='192';

  AACopties.cbr:=true; AACopties.vbr:=false; AACopties.vbrmode:=5; AACopties.Bitrate:='192';

  Opusopties.cbr:=false; Opusopties.vbr:=true; Opusopties.cvbr:=false;
  Opusopties.Bitrate:='160'; Opusopties.EncQuality:='10'; Opusopties.Framesize:=20;
  Opusopties.Framesizei:=5;

  fullrandom:=false; db_changed:=false;

    // Setting Values for Flat and Custom presets to 0
    for i:=1 to 10 do
    begin
      EQ_Preset[0,i]:=0;          // Flat EQ
      EQ_Preset[7,i]:=0;          // Custom 1
      EQ_Preset[8,i]:=0;          // Custom 2
      EQ_Preset[9,i]:=0;          // Custom 3
    end;
    //EQ Classic
    EQ_Preset[1,1]:=0; EQ_Preset[1,2]:=0; EQ_Preset[1,3]:=0;
    EQ_Preset[1,4]:=0; EQ_Preset[1,5]:=0; EQ_Preset[1,6]:=0;
    EQ_Preset[1,7]:=-3; EQ_Preset[1,8]:=-3; EQ_Preset[1,9]:=-3; EQ_Preset[1,10]:=-4;
    //EQ Dance
    EQ_Preset[2,1]:=4; EQ_Preset[2,2]:=3; EQ_Preset[2,3]:=2;
    EQ_Preset[2,4]:=0; EQ_Preset[2,5]:=0; EQ_Preset[2,6]:=-1;
    EQ_Preset[2,7]:=-2; EQ_Preset[2,8]:=-2; EQ_Preset[2,9]:=0; EQ_Preset[1,10]:=0;
    //EQ Jazz
    EQ_Preset[3,1]:=0; EQ_Preset[3,2]:=0; EQ_Preset[3,3]:=0;
    EQ_Preset[3,4]:=-2; EQ_Preset[3,5]:=0; EQ_Preset[3,6]:=-2;
    EQ_Preset[3,7]:=-2; EQ_Preset[3,8]:=0; EQ_Preset[3,9]:=0; EQ_Preset[3,10]:=0;
    //EQ Pop
    EQ_Preset[4,1]:=-1; EQ_Preset[4,2]:=2; EQ_Preset[4,3]:=3;
    EQ_Preset[4,4]:=4; EQ_Preset[4,5]:=3; EQ_Preset[4,6]:=1;
    EQ_Preset[4,7]:=0; EQ_Preset[4,8]:=0; EQ_Preset[4,9]:=1; EQ_Preset[4,10]:=1;
    //EQ Rock
    EQ_Preset[5,1]:=3; EQ_Preset[5,2]:=2; EQ_Preset[5,3]:=-2;
    EQ_Preset[5,4]:=-3; EQ_Preset[5,5]:=-1; EQ_Preset[5,6]:=1;
    EQ_Preset[5,7]:=3; EQ_Preset[5,8]:=4; EQ_Preset[5,9]:=4; EQ_Preset[5,10]:=4;
    //EQ Techno
    EQ_Preset[6,1]:=3; EQ_Preset[6,2]:=2; EQ_Preset[6,3]:=0;
    EQ_Preset[6,4]:=-2; EQ_Preset[6,5]:=-1; EQ_Preset[6,6]:=0;
    EQ_Preset[6,7]:=3; EQ_Preset[6,8]:=4; EQ_Preset[6,9]:=4; EQ_Preset[6,10]:=3;
    EQ_Set:=0;


  {$IFDEF HAIKU}
  {$ELSE}
  if (HI(BASS_GetVersion) <> BASSVERSION) then ShowMessage('An incorrect version of the BASS Library was loaded');
  BASS_SetConfig(BASS_CONFIG_DEV_BUFFER, Settings.cdb);
  {$IFDEF WINDOWS}
    if not BASS_Init(-1, 44100, 0, Handle, nil) then Showmessage('Error initializing audio!');
    Homedir:=GetEnvironmentVariable('HOMEDRIVE')+ChompPathDelim(GetEnvironmentVariable('HOMEPATH'));
    ldata:=pchar('bassflac.dll'); BASS_PluginLoad(ldata, 0);
    ldata:=pchar('basscd.dll'); BASS_PluginLoad(ldata, 0);
    ldata:=pchar('bass_fx.dll'); BASS_PluginLoad(ldata, 0);
    ldata:=pchar('bass_aac.dll'); BASS_PluginLoad(ldata, 0);
    ldata:=pchar('bass_ape.dll'); BASS_PluginLoad(ldata, 0);
    ldata:=pchar('bass_alac.dll'); BASS_PluginLoad(ldata, 0);
    ldata:=pchar('bassopus.dll'); BASS_PluginLoad(ldata, 0);
    ldata:=pchar('bassdsd.dll'); BASS_PluginLoad(ldata, 0);
  {$ENDIF}
  {$IFDEF LINUX}
    if FileExistsUTF8('/usr/lib/libbass.so') then libdir:='/usr/lib/'
                                             else libdir:='lib/';
    if not BASS_Init(-1, 44100, 0, nil, nil) then Showmessage('Error initializing audio!');
    ldata:=pchar(libdir+'libbasscd.so'); BASS_PluginLoad(ldata, 0);
    ldata:=pchar(libdir+'libbassflac.so'); BASS_PluginLoad(ldata, 0);
    ldata:=pchar(libdir+'libbass_fx.so'); BASS_PluginLoad(ldata, 0);
    ldata:=pchar(libdir+'libbass_aac.so'); BASS_PluginLoad(ldata, 0);
    if FileExistsUTF8(libdir+'libbassalac.so')
       then
       begin
          ldata:=pchar(libdir+'libbassalac.so'); BASS_PluginLoad(ldata, 0);
       end
       else
       begin
          ldata:=pchar(libdir+'libbass_alac.so'); BASS_PluginLoad(ldata, 0);
       end;
    ldata:=pchar(libdir+'libbass_ape.so'); BASS_PluginLoad(ldata, 0);
    ldata:=pchar(libdir+'libbassopus.so'); BASS_PluginLoad(ldata, 0);
  {$ENDIF}
  {$IFDEF DARWIN}
  (* Var settings for Darwin:
       - Put the tabs for artist, album, ... on the left side
       - NASbug only for Linux
       - Loading Bass Libraries for MAC OS X  *)
    if not BASS_Init(-1, 44100, 0, nil, nil) then Showmessage('Error initializing audio!');
    ConfigDir:=ChompPathDelim(GetEnvironmentVariable('HOME'))+'/.XIXBrowser.ini';
    ldata:=pchar('libbassflac.dylib'); BASS_PluginLoad(ldata, 0);
    ldata:=pchar('libbass_fx.dylib');  BASS_PluginLoad(ldata, 0);
    ldata:=pchar('libbassopus.dylib'); BASS_PluginLoad(ldata, 0);
    ldata:=pchar('libbass_ape.dylib'); BASS_PluginLoad(ldata, 0);
    ldata:=pchar('libbassdsd.dylib');  BASS_PluginLoad(ldata, 0);
    Settings.TabArtist:=1; Settings.NASBug:=False;
    Tracksfound:=TStringList.Create;
  {$ENDIF}
  BASS_SetConfig(BASS_CONFIG_NET_PLAYLIST, 1);
//  BASS_SetConfigPtr(BASS_CONFIG_CD_CDDB_SERVER, pchar('gnudb.gnudb.org'));
  {$ENDIF}
  CreateDir(ConfigDir);
  CreateDir(Configdir+Directoryseparator+'artist');
  CreateDir(Configdir+Directoryseparator+'cache');
  CreateDir(Configdir+Directoryseparator+'radio');
  CreateDir(Configdir+Directoryseparator+'songtext');
  CreateDir(Configdir+Directoryseparator+'recorded');
  CreateDir(Configdir+Directoryseparator+'playlist');

  Settings.CacheDirCDCover:=Configdir+Directoryseparator+'cache';
  Settings.CacheDirSongtext:=Configdir+Directoryseparator+'songtext';
  Settings.cacheDirRadio:=Configdir+Directoryseparator+'radio'+DirectorySeparator;
  Settings.SaveLyricsInID3Tag:=True; Settings.SaveExternalOnInternal:=True;

  PageControl1.ActivePageIndex:=0;
  ShellListView1.Mask:='*.mp3;*.ogg;*.flac;*.m4a;*.aac;*.mp4;*.ape;*.opus;*.dff;*.wav';

  FAllSel := TGridSelection.create(SG_All, gsoGrabAll);
  FPlaySel := TGridSelection.Create(SG_Play, gsoGrabAll);
end;


procedure TForm1.Encode(x: integer);
var cmd, format, folder, ext, tempartiest, temptitel, tempalbum: String;
    filename, temp, temp2, trackstring: string;
    toevoegen, gevonden, overschrijven, bestaatreeds: boolean;
    i, i2, tempyear: longint;
    ch: char;
    jpg: TJpegImage;
    LameEncoderOptieParameters: TStringList;
    OptieParameters: TStringList;
    lijn: string;
    {$IFDEF HAIKU} AProcess: TProcess; {$ENDIF}
begin
  bestaatreeds:=false;
  tempartiest:=CD[x+1].artiest; temptitel:=CD[x+1].Titel; tempAlbum:=CD[x+1].Album;
  tempyear:=Strtointdef(CD[x+1].jaartal,0);

  if ripoptiesCompilation then format:=Settings.EncodingFilenameFormatCompilation
                          else format:=Settings.EncodingFilenameFormatSingle;

  OptieParameters:=Tstringlist.Create; LameEncoderOptieParameters:=Tstringlist.Create;
  (*LAME*)
  case Settings.Encoder of
    0: Begin          (* LAME *)
         if Lameopties.pr then
         begin
           LameEncoderOptieParameters.add('--preset');  LameEncoderOptieParameters.add(lameopties.EncQuality);
         end
         else
         begin
           LameEncoderOptieParameters.add('-q'); LameEncoderOptieParameters.add(lameopties.Preset);
         end;

         if Lameopties.abr then
         begin
           LameEncoderOptieParameters.add('-b'); LameEncoderOptieParameters.add(lameopties.BitRateQuality);
         end;
         if lameopties.vbr then
         begin
           if lameopties.cbr then
           begin
             LameEncoderOptieParameters.add('--cbr');
             LameEncoderOptieParameters.add('-b'); LameEncoderOptieParameters.add(lameopties.Bitratemin);
           end
           else
           begin
             LameEncoderOptieParameters.add('-v');
             LameEncoderOptieParameters.add('-b'); LameEncoderOptieParameters.add(lameopties.Bitratemin);
             LameEncoderOptieParameters.add('-B'); LameEncoderOptieParameters.add(lameopties.BitrateMax);
           end;
         end;
         if lameopties.Mono then
         begin
           LameEncoderOptieParameters.add('-m'); LameEncoderOptieParameters.add('m');
         end;

         OptieParameters.Add('--id3v2-latin1'); OptieParameters.Add('--nohist');
         OptieParameters.Add('--id3v2-only');
         OptieParameters.Add('--tt'); OptieParameters.Add(temptitel);
         OptieParameters.Add('--ta'); OptieParameters.Add(tempartiest);
         if length(tempAlbum)>0 then
         begin
           OptieParameters.Add('--tl'); OptieParameters.Add(tempalbum);
         end;
         OptieParameters.Add('--tn');
         OptieParameters.Add(inttostr(x+1)+'/'+inttostr(Stringgridcd.rowcount-1));
         if Tempyear>0 then
         begin
           OptieParameters.Add('--ty'); OptieParameters.Add(CD[x+1].jaartal);
         end;
         if length(CD[x+1].genre)>1 then
         begin
           OptieParameters.Add('--tg'); OptieParameters.Add(CD[x+1].genre);
         end;
         if length(CD[X+1].comment)>1 then
         begin
           OptieParameters.Add('--tc'); OptieParameters.Add(cd[x+1].comment);
         end;
       end;

    1: begin  (* FLAC *)
         OptieParameters.Add('-T'); OptieParameters.Add('TITLE='+temptitel);
         OptieParameters.Add('-T'); OptieParameters.Add('ARTIST='+tempartiest);
         if length(CD[x+1].Album)>1 then
         begin
           OptieParameters.Add('-T'); OptieParameters.Add('ALBUM='+tempalbum);
         end;
         if length(CD[x+1].jaartal)>1 then
         begin
           OptieParameters.Add('-T'); OptieParameters.Add('DATE='+CD[x+1].jaartal);
         end;
         if length(CD[x+1].genre)>1 then
         begin
           OptieParameters.Add('-T'); OptieParameters.Add('GENRE='+CD[x+1].genre);
         end;
         if length(CD[x+1].composer)>1 then
         begin
           OptieParameters.Add('-T'); OptieParameters.Add('COMPOSER='+CD[x+1].composer);
         end;
         if length(CD[x+1].copyright)>1 then
         begin
           OptieParameters.Add('-T'); OptieParameters.Add('COPYRIGHT='+CD[x+1].copyright);
         end;
         if length(CD[x+1].comment)>1 then
         begin
           OptieParameters.Add('-T'); OptieParameters.Add('COMMENT='+CD[x+1].comment);
         end;
         if length(CD[x+1].Album)>1 then
         begin
           OptieParameters.Add('-T'); OptieParameters.Add('TRACKNUMBER='+inttostr(x+1));
         end;
         OptieParameters.Add('-T'); OptieParameters.Add('ENCODER=XiX Music Player v'+versie);
       end;
    2: Begin  (* OGG *)
         If OGGOpties.mmode then OptieParameters.Add('--managed');
         If OGGOpties.ForceQuality then
         begin
           OptieParameters.Add('-q'); OptieParameters.Add(OGGOpties.EncQuality);
         end
         else
         begin
           If OGGOpties.cbr then
           begin
             OptieParameters.Add('-bitrate'); OptieParameters.Add(OGGOpties.BitrateMin);
           end
           else
           begin
             OptieParameters.Add('-m'); OptieParameters.Add(OGGOpties.BitrateMin);
             OptieParameters.Add('-M'); OptieParameters.Add(OGGOpties.BitrateMax);
           end;
         end;
         OptieParameters.Add('-a'); OptieParameters.Add(tempartiest);
         OptieParameters.Add('-t'); OptieParameters.Add(temptitel);
         if length(tempalbum)>1 then
         begin
           OptieParameters.Add('-l'); OptieParameters.Add(tempalbum);
         end;
         OptieParameters.Add('-N'); OptieParameters.Add(inttostr(x+1));
         if Tempyear>0 then
         begin
           OptieParameters.Add('-d'); OptieParameters.Add(CD[x+1].jaartal);
         end;
         if length(CD[x+1].genre)>1 then
         begin
           OptieParameters.Add('-G'); OptieParameters.Add(CD[x+1].genre);
         end;
         //OptieParameters.Add('-c'); OptieParameters.Add('ENCODER=XiX Music Player v'+versie);
       end;
    3: begin // AAC
         If AACOpties.cbr then
           begin
             OptieParameters.Add('-b'); OptieParameters.Add(AACOpties.Bitrate);
           end
           else
           begin
              OptieParameters.Add('-m'); OptieParameters.Add(inttostr(AACOpties.vbrmode+1));
           end;
           OptieParameters.Add('--artist'); OptieParameters.Add(tempartiest);
           OptieParameters.Add('--title'); OptieParameters.Add(temptitel);
           OptieParameters.Add('--album'); OptieParameters.Add(tempalbum);
           OptieParameters.Add('--track'); OptieParameters.Add(inttostr(x+1)+'/'+inttostr(Stringgridcd.rowcount-1));
           OptieParameters.Add('--comment'); OptieParameters.Add('ENCODER=XiX Music Player v'+versie);
           if Tempyear>0 then
             begin
               OptieParameters.Add('--date'); OptieParameters.Add(CD[x+1].jaartal);
             end;
           if length(CD[x+1].genre)>1 then
             begin
               OptieParameters.Add('--genre'); OptieParameters.Add(CD[x+1].genre);
             end;
       end;
    4: begin   // OPUS
         If OpusOpties.cbr then OptieParameters.Add('--vbr');
         If OpusOpties.cvbr then OptieParameters.Add('--cvbr');
         If OpusOpties.cbr then OptieParameters.Add('--hard-cbr');
         OptieParameters.Add('--bitrate'); OptieParameters.Add(OpusOpties.Bitrate);
         if OpusOpties.EncQuality<>'10' then
         begin
           OptieParameters.Add('--comp'); OptieParameters.Add(OpusOpties.EncQuality);
         end;
         if OpusOpties.Framesize<>20 then
         begin
           OptieParameters.Add('--framesize'); OptieParameters.Add(inttostr(OpusOpties.Framesize));
         end;
         OptieParameters.Add('--artist'); OptieParameters.Add(tempartiest);
         OptieParameters.Add('--title'); OptieParameters.Add(temptitel);
         if length(tempalbum)>0 then
         begin
           OptieParameters.Add('--album'); OptieParameters.Add(tempalbum);
         end;
         OptieParameters.Add('--comment'); OptieParameters.Add('TRACKNUMBER='+inttostr(x+1)+'/'+inttostr(Stringgridcd.rowcount-1));
         OptieParameters.Add('--comment'); OptieParameters.Add('COMMENT=XiX Music Player v'+versie);
         if Tempyear>0 then
         begin
           OptieParameters.Add('--date'); OptieParameters.Add(CD[x+1].jaartal);
         end;
         if length(CD[x+1].genre)>1 then
         begin
           OptieParameters.Add('--genre'); OptieParameters.Add(CD[x+1].genre);
         end;
       end;
  end; (* of case *)

  (*FILENAME*)
  tempartiest:=CD[x+1].artiest; temptitel:=CD[x+1].Titel; tempAlbum:=CD[x+1].Album;
  if length(tempartiest)>0 then for i:=1 to length(tempartiest) do
     if tempartiest[i] in ['*', '>', '<', '/', '\', '|', '%', '~', '''', '"'] then tempartiest[i]:='_';
  if length(temptitel)>0 then for i:=1 to length(temptitel) do
     if temptitel[i] in ['*', '>', '<', '/', '\', '|', '%', '~', '''', '"'] then temptitel[i]:='_';
  if length(tempAlbum)>0 then for i:=1 to length(tempAlbum) do
     if tempalbum[i] in ['*', '>', '<', '/', '\', '|', '%', '~', '''', '"'] then tempAlbum[i]:='_';

  filename:=Settings.EncodingTargetFolder+DirectorySeparator+format;

  // %1 - First letter of artiest
  if Pos('%1', filename)>0 then
  begin
    ch:=lowercase(tempartiest[1]);
    if pos('DE ',upcase(tempartiest))=1 then ch:=lowercase(tempartiest[4]);
    if pos('THE ',upcase(tempartiest))=1 then ch:=lowercase(tempartiest[5]);
    filename:=stringreplace(filename,'%1',ch,[rfReplaceAll]);
  end;
  filename:=stringreplace(filename,'%a',tempartiest,[rfReplaceAll]); // %a - Artist
  filename:=stringreplace(filename,'%t',tempTitel,[rfReplaceAll]);   // %t - Title
  filename:=stringreplace(filename,'%l',TempAlbum,[rfReplaceAll]);   // %l - Album
  // %n - Tracknumber
  if Pos('%n', filename)>0 then
  begin
    trackstring:=inttostr(x+1);
    if length(trackstring)=1 then trackstring:='0'+trackstring;
    filename:=stringreplace(filename,'%n',trackString,[rfReplaceAll]);
  end;
  filename:=stringreplace(filename,'?','',[rfReplaceAll]);   // ? - Delete char
  //showmessage(filename);

  {$IFDEF WINDOWS}
   Repeat
    if Pos('/', filename)>0 then
    begin
      filename[Pos('/', filename)]:='\';
    end;
  until pos('/',filename)=0;
  {$ENDIF}

//  Directories checken & Eventueel aanmaken
  temp:=copy(filename,length(Settings.EncodingTargetFolder)+2,length(filename));
  folder:=Settings.EncodingTargetFolder;
  repeat
    temp2:=copy(temp,1,pos(DirectorySeparator,temp)-1);
    folder:=folder+Directoryseparator+temp2;
    if not directoryexistsutf8(folder) then CreateDirUTF8(folder);
    temp:=copy(temp,pos(DirectorySeparator,temp)+1,length(temp));
  until pos(DirectorySeparator,temp)=0;

  Case Settings.Encoder of
    0: ext:='.mp3';
    1: ext:='.flac';
    2: ext:='.ogg';
    3: ext:='.m4a';
    4: ext:='.opus';
  end;

  overschrijven:=true; bestaatreeds:=false;
  if (FileExistsUTF8(filename+ext)) and (not OverwriteAllRip) then
  begin
 //  overschrijven:=not FormShowMyDialog.ShowWith(Vertaal('WARNING'),filename+ext,vertaal('already exists'),Vertaal('OVERWRITE ?'),Vertaal('NO'),Vertaal('YES'),False);
//   [mrYes,yesStr,mrYesToAll,Vertaal('YES TO ALL'),mrNo,noStr,mrCancel,Vertaal('CANCEL')]
    case FormShowMyDialog.ShowWith(Vertaal('WARNING'),filename+ext,vertaal('already exists'),Vertaal('OVERWRITE ?'),[mrYes,Vertaal('YES'),mrYesToAll,Vertaal('YES TO ALL'),mrNo,Vertaal('NO'),mrCancel,Vertaal('BREAK')] ,False) of
      mrYes: overschrijven:=true;
      mrNo: overschrijven:=false;
      mrYesToAll: OverwriteAllRip:=true;
      mrCancel: Begin
                  CancelRip:=true;
                  overschrijven:=false;
                end;
    end;

   bestaatreeds:=true;
  end;

  If formRip.CB_CopyCDCover.Checked then
   begin
     folder := ExtractFilePath(Filename);
     if not FileExistsUTF8(folder+'cover.jpg') then
     begin
       jpg:= TJpegImage.Create;
       try
         jpg.Assign(FormRip.Image2.Picture.Bitmap);
         jpg.SaveToFile(Folder+'cover.jpg');
       finally
         jpg.free;
       end;
     end;
   end;

  If formRip.CB_Include.Checked then
   begin
    DeleteFile(TempDir+DirectorySeparator+'cover.jpg');
    jpg:= TJpegImage.Create;
       try
         jpg.Assign(FormRip.Image2.Picture.Bitmap);
         jpg.SaveToFile(TempDir+DirectorySeparator+'cover.jpg');
       finally
         jpg.free;
       end;
   end;

  (*EXTRA TAGS*)
  if FormRip.CB_Include.Checked and FileExistsUTF8(TempDir+DirectorySeparator+'cover.jpg') then
  begin
    LameencoderOptieParameters.Add('--ti'); LameencoderoptieParameters.Add(TempDir+DirectorySeparator+'cover.jpg');
    If Settings.Encoder=1 then OptieParameters.Add('--picture='+TempDir+DirectorySeparator+'cover.jpg');
    If Settings.Encoder=4 then
    begin
     OptieParameters.Add('--picture'); OptieParameters.Add(TempDir+DirectorySeparator+'cover.jpg');
    end;
  end;
  if length(CD[x+1].composer)>0 then
  begin
    LameencoderOptieParameters.Add('--tv'); LameencoderoptieParameters.Add('TCOM='+CD[x+1].composer);
  end;
  if length(CD[x+1].copyright)>0 then
  begin
    LameencoderOptieParameters.Add('--tv'); LameencoderoptieParameters.Add('TCOP='+CD[x+1].copyright);
  end;
  if length(CD[x+1].original)>0 then
  begin
    LameencoderOptieParameters.Add('--tv'); LameencoderoptieParameters.Add('TOPE='+CD[x+1].original);
  end;
  LameencoderOptieParameters.Add('--tv'); LameencoderoptieParameters.Add('TENC=XiX Music Player v'+versie);


  if (overschrijven) or (OverwriteAllRip) then
  begin
   if (Settings.Encoder=0) then      //LAME
   begin
      cmd:=Settings.Lame;
      {$IFDEF DARWIN}
       FormRip.ProgressbarTracks.Max:=FormRip.StringGrid1.RowCount; FormRip.ProgressbarTracks.Position:=x+1;
       if status_cd=1 then OptieParameters.Add(Tracksfound.Strings[x])
                      else OptieParameters.Add(tempDir+DirectorySeparator+'Track_'+inttostr(x+1)+'.wav');
      {$ELSE}
       {$IFDEF HAIKU}
         AProcess:=TProcess.Create(Nil);
         AProcess.Executable:='cp';
         Aprocess.Parameters.Add(Tracksfound.Strings[x]);
         Aprocess.Parameters.Add(tempDir+DirectorySeparator+'Track_'+inttostr(x+1)+'.wav');
         AProcess.Options:=AProcess.Options+[poWaitOnExit];
         AProcess.Execute;
         AProcess.Free;
       {$ENDIF}
       OptieParameters.Add(tempDir+DirectorySeparator+'Track_'+inttostr(x+1)+'.wav');

      {$ENDIF}
      OptieParameters.Add(filename+'.mp3');
   end;

   if (Settings.encoder=1) then      //FLAC
   begin
    cmd:=Settings.Flac;
    {$IF DEFined(DARWIN)}
      FormRip.ProgressbarTracks.Max:=FormRip.StringGrid1.RowCount ; FormRip.ProgressbarTracks.Position:=x+1;
      if status_cd=1 then OptieParameters.Add(Tracksfound.Strings[x])
                     else OptieParameters.Add(tempDir+DirectorySeparator+'Track_'+inttostr(x+1)+'.wav');
    {$ELSE}
      {$IFDEF HAIKU}
         AProcess:=TProcess.Create(Nil);
         AProcess.Executable:='cp';
         Aprocess.Parameters.Add(Tracksfound.Strings[x]);
         Aprocess.Parameters.Add(tempDir+DirectorySeparator+'Track_'+inttostr(x+1)+'.wav');
         AProcess.Options:=AProcess.Options+[poWaitOnExit];
         AProcess.Execute;
         AProcess.Free;
       {$ENDIF}
      OptieParameters.Add(tempDir+DirectorySeparator+'Track_'+inttostr(x+1)+'.wav');
    {$ENDIF}
    OptieParameters.Add('-f'); OptieParameters.Add('-o'); OptieParameters.Add(filename+'.flac');
   end;
   if (Settings.encoder=2) then      //OGG
   begin
    cmd:=Settings.Ogg;
    {$IF DEFined(DARWIN)}
      FormRip.ProgressbarTracks.Max:=FormRip.StringGrid1.RowCount ; FormRip.ProgressbarTracks.Position:=x+1;
      if status_cd=1 then OptieParameters.Add(Tracksfound.Strings[x])
                     else OptieParameters.Add(tempDir+DirectorySeparator+'Track_'+inttostr(x+1)+'.wav');
    {$ELSE}
    {$IFDEF HAIKU}
         AProcess:=TProcess.Create(Nil);
         AProcess.Executable:='cp';
         Aprocess.Parameters.Add(Tracksfound.Strings[x]);
         Aprocess.Parameters.Add(tempDir+DirectorySeparator+'Track_'+inttostr(x+1)+'.wav');
         AProcess.Options:=AProcess.Options+[poWaitOnExit];
         AProcess.Execute;
         AProcess.Free;
       {$ENDIF}
      OptieParameters.Add(tempDir+DirectorySeparator+'Track_'+inttostr(x+1)+'.wav');
    {$ENDIF}
    OptieParameters.Add('-o'); OptieParameters.Add(filename+'.ogg');
   end;
   if (Settings.encoder=3) then      //AAC
   begin
    cmd:=Settings.AAC;
    {$IFDEF WINDOWS} OptieParameters.Add(tempDir+DirectorySeparator+'Track_'+inttostr(x+1)+'.wav'); {$ENDIF}
    {$IFDEF LINUX} OptieParameters.Add(tempDir+DirectorySeparator+'Track_'+inttostr(x+1)+'.wav'); {$ENDIF}
    {$IFDEF HAIKU}
         AProcess:=TProcess.Create(Nil);
         AProcess.Executable:='cp';
         Aprocess.Parameters.Add(Tracksfound.Strings[x]);
         Aprocess.Parameters.Add(tempDir+DirectorySeparator+'Track_'+inttostr(x+1)+'.wav');
         AProcess.Options:=AProcess.Options+[poWaitOnExit];
         AProcess.Execute;
         AProcess.Free;
         OptieParameters.Add(tempDir+DirectorySeparator+'Track_'+inttostr(x+1)+'.wav'); {$ENDIF}
         OptieParameters.Add('-o'); OptieParameters.Add(filename+'.m4a');
    {$IFDEF DARWIN}
      OptieParameters.Add('-R');
      FormRip.ProgressbarTracks.Max:=FormRip.StringGrid1.RowCount ; FormRip.ProgressbarTracks.Position:=x+1;
      if status_cd=1 then OptieParameters.Add(Tracksfound.Strings[x])
                     else OptieParameters.Add(tempDir+DirectorySeparator+'Track_'+inttostr(x+1)+'.wav');
    {$ENDIF}
   end;
   if (Settings.encoder=4) then      //OPUS
   begin
    cmd:=Settings.Opus;
    {$IF DEFined(DARWIN)}
     // OptieParameters.Add('--raw');
      FormRip.ProgressbarTracks.Max:=FormRip.StringGrid1.RowCount ; FormRip.ProgressbarTracks.Position:=x+1;
      if status_cd=1 then OptieParameters.Add(Tracksfound.Strings[x])
                     else OptieParameters.Add(tempDir+DirectorySeparator+'Track_'+inttostr(x+1)+'.wav');
    {$ELSE}
    {$IFDEF HAIKU}
         AProcess:=TProcess.Create(Nil);
         AProcess.Executable:='cp';
         Aprocess.Parameters.Add(Tracksfound.Strings[x]);
         Aprocess.Parameters.Add(tempDir+DirectorySeparator+'Track_'+inttostr(x+1)+'.wav');
         AProcess.Options:=AProcess.Options+[poWaitOnExit];
         AProcess.Execute;
         AProcess.Free;
    {$ENDIF}
      OptieParameters.Add(tempDir+DirectorySeparator+'Track_'+inttostr(x+1)+'.wav');
    {$ENDIF}
    OptieParameters.Add(filename+'.opus');
   end;
   Application.ProcessMessages;

   RunEncoder := TProcess.Create(nil);
   try
    {$IF DEFined(DARWIN)}
      RunEncoder.Options:=RunEncoder.Options+[poWaitOnExit];
    {$ENDIF}
    {$IFDEF WINDOWS}
      RunEncoder.Options:=RunEncoder.Options+[poNoConsole];
    {$ENDIF}
    RunEncoder.Executable := cmd;
    lijn:='';

    case Settings.encoder of
      0: begin
           For i:=0 to OptieParameters.Count-1 do Runencoder.Parameters.Add(OptieParameters[i]);
           For i:=0 to LameEncoderOptieParameters.Count-1 do Runencoder.Parameters.Add(LameEncoderOptieParameters[i]);
         end;
      1: For i:=0 to OptieParameters.Count-1 do Runencoder.Parameters.Add(OptieParameters[i]);
      2: begin
           For i:=0 to OptieParameters.Count-1 do
           begin
            Runencoder.Parameters.Add(OptieParameters[i]);
            lijn:=lijn+' '+OptieParameters[i];
           end;
         end;
      3: For i:=0 to OptieParameters.Count-1 do Runencoder.Parameters.Add(OptieParameters[i]);
      4: For i:=0 to OptieParameters.Count-1 do Runencoder.Parameters.Add(OptieParameters[i]);
    end;
    runEncoder.Execute;
    RunEncoder.Free;
    toevoegen:=true;
   except
     if Settings.Encoder=0 then ShowMessage(Vertaal('ERROR: Make sure LAME is installed'));
     if Settings.Encoder=1 then ShowMessage(Vertaal('ERROR: Make sure FLAC is installed'));
     if Settings.Encoder=2 then ShowMessage(Vertaal('ERROR: Make sure OGG is installed'));
     if Settings.Encoder=3 then ShowMessage(Vertaal('ERROR: Make sure AAC is installed'));
     if Settings.Encoder=4 then ShowMessage(Vertaal('ERROR: Make sure OPUS is installed'));
     toevoegen:=false;
   end;

   if (toevoegen) and (not bestaatreeds) then
   begin
     filename:=filename+ext;
     inc(maxsongs); inc(max_records);
     Setlength(Liedjes,maxsongs+1);

     Liedjes[maxsongs-1].Artiest:=CD[x+1].artiest;
     Liedjes[maxsongs-1].CD:=CD[x+1].Album;
     Liedjes[maxsongs-1].Titel:=CD[x+1].Titel;
     Liedjes[maxsongs-1].Genre:=CD[x+1].genre;
     Liedjes[maxsongs-1].Track:=x+1;
     Liedjes[maxsongs-1].Jaartal:=CD[x+1].jaartal;
     Liedjes[maxsongs-1].AantalTracks:=inttostr(Stringgridcd.rowcount-1);
     Liedjes[maxsongs-1].Bestandsnaam:=ExtractFileName(filename);
     Liedjes[maxsongs-1].Pad:=ExtractFilePath(Filename);
     liedjes[maxsongs-1].Deleted:=False;
     Liedjes[maxsongs-1].Copyright:=CD[x+1].copyright;
     Liedjes[maxsongs-1].Composer:=CD[x+1].composer;
     Liedjes[maxsongs-1].OrigArtiest:=CD[x+1].original;
     Liedjes[maxsongs-1].Comment:=CD[x+1].comment;

     for i2:=1 to 10 do Liedjes[maxsongs-1].EQSettings[i2]:=0;
     If FormRip.CB_NoFade.Checked then Liedjes[maxsongs-1].FadeSettings:=0
                                  else Liedjes[maxsongs-1].FadeSettings:=255;

     Liedjes[maxsongs-1].PreVolume:=255;
     Liedjes[maxsongs-1].Mono:=False;
     Liedjes[maxsongs-1].TrimBegin:=False; Liedjes[maxsongs-1].TrimEnd:=False;
     Liedjes[maxsongs-1].TrimLength[0]:=0;
     Liedjes[maxsongs-1].TrimLength[1]:=0;

     gevonden:=false;

     if LB_Artist1.Items.IndexOf(CD[x+1].artiest)>0 then gevonden:=true;

     if not gevonden then
     begin
      LB_Artist1.Sorted:=False;
      if LB_Artist1.Items.Count>0 then LB_Artist1.Items.Delete(0);
      LB_artist1.Items.Add(CD[x+1].artiest);
      LB_Artist1.Sorted:=True;LB_Artist1.Sorted:=False;
      LB_Artist1.Items.Insert(0,Vertaal('All'));
     end;

     gevonden:=false;
     if LB_Albums1.Items.IndexOf(CD[x+1].Album)>0 then gevonden:=true;

     if not gevonden then
     begin
      LB_Albums1.Sorted:=False;
      LB_albums1.Items.Add(CD[x+1].Album);
      LB_Albums1.Sorted:=true; LB_Albums1.Sorted:=False;
     end;
   end;
  end;
  LameEncoderOptieParameters.Free; OptieParameters.Free;
end;


procedure TForm1.RipTrack(x: integer);
{$if defined(WINDOWS) or defined(LINUX)}
var
  chan: DWORD;
  frq: Single;
 buf : array [0..10000] of BYTE;
 BytesRead : integer;
 temp : AnsiString;
 i : longint;
 RecStream : TFileStream;
 nChannels       : Word;   // number of channels (i.e. mono, stereo, etc.)
 nSamplesPerSec  : DWORD;  // sample rate
 nAvgBytesPerSec : DWORD;
 nBlockAlign     : Word;
 wBitsPerSample  : Word;   // number of bits per sample of mono data
 chaninfo: BASS_CHANNELINFO;
   CancelOp    : Boolean;        PercentDone : Integer;
{$IFEND}
begin
  {$if defined(WINDOWS) or defined(LINUX)}
  //TrackBar2.Visible:=True;
   CancelOp:=False;
  chan := BASS_CD_StreamCreate(0, x, BASS_STREAM_DECODE);
  //BASS_StreamCreateFile(FALSE, PChar(SourceFileName), 0, 0, BASS_STREAM_DECODE {$IFDEF UNICODE} or BASS_UNICODE {$ENDIF});
  BASS_ChannelGetInfo(chan, chaninfo);
  nChannels := chaninfo.chans;
  if (chaninfo.flags and BASS_SAMPLE_8BITS > 0) then wBitsPerSample := 8
                                                else wBitsPerSample := 16;

  nBlockAlign := nChannels * wBitsPerSample div 8;
  BASS_ChannelGetAttribute(chan, BASS_ATTRIB_FREQ, frq);
  nSamplesPerSec := Trunc(frq);
  nAvgBytesPerSec := nSamplesPerSec * nBlockAlign;

    RecStream := TFileStream.Create(TempDir+DirectorySeparator+'Track_'+inttostr(x+1)+'.wav', fmCreate);

 // Write header portion of wave file
    temp := 'RIFF'; RecStream.write(temp[1], length(temp));
    temp := #0#0#0#0; RecStream.write(temp[1], length(temp));   // File size: to be updated
    temp := 'WAVE'; RecStream.write(temp[1], length(temp));
    temp := 'fmt '; RecStream.write(temp[1], length(temp));
    temp := #$10#0#0#0; RecStream.write(temp[1], length(temp)); // Fixed
    temp := #1#0; RecStream.write(temp[1], length(temp));       // PCM format
    if nChannels = 1 then
       temp := #1#0
    else
       temp := #2#0;
    RecStream.write(temp[1], length(temp));
    RecStream.write(nSamplesPerSec, 2);
    temp := #0#0; RecStream.write(temp[1], length(temp));   // SampleRate is given as dWord
    RecStream.write(nAvgBytesPerSec, 4);
    RecStream.write(nBlockAlign, 2);
    RecStream.write(wBitsPerSample, 2);
    temp := 'data'; RecStream.write(temp[1],length(temp));
    temp := #0#0#0#0; RecStream.write(temp[1],length(temp)); // Data size: to be updated
	while (BASS_ChannelIsActive(chan) > 0) do
         begin
                BytesRead := BASS_ChannelGetData(chan, @buf, 10000);
                RecStream.Write(buf, BytesRead);
                Application.ProcessMessages;
                if CancelOp then Break;
                PercentDone := Trunc(100 * (BASS_ChannelGetPosition(Chan, BASS_POS_BYTE) / BASS_ChannelGetLength(chan, BASS_POS_BYTE)));
                FormRip.ProgressBarRip.Position := PercentDone;
	end;
   BASS_StreamFree(chan); // free the stream

// complete WAV header
// Rewrite some fields of header
   i := RecStream.Size - 8;    // size of file
   RecStream.Position := 4;
   RecStream.write(i, 4);
   i := i - $24;               // size of data
   RecStream.Position := 40;
   RecStream.write(i, 4);
   RecStream.Free;

    {$IFEND}
   Encode(x);
end;


procedure TForm1.FormResize(Sender: TObject);
begin
  Splitter4Moved(Self);
  If Form1.Width>1920 then Image9.Stretch:=True
                      else Image9.Stretch:=False;
  LB_Artiest.Left:=Trackbar2.Left+round(Trackbar2.Width/2)-round((LB_Artiest.Width+LB_CD.Width)/2)+15;
end;

function TForm1.Vertaal(x: utf8string): utf8string;
var Filevar: textfile;
    lijn, lijntest: utf8string;
    gevonden: boolean;
    i: shortint;
begin

  if not FileExistsUTF8(StartDir+'/Local/XIXPlayer.'+Settings.Language) then
    begin
      Settings.Language:='EN';
      Vertaal:=x;
    end
                                                           else
  if length(x)>1 then
  begin
    gevonden:=false;i:=0;
     repeat
     begin
       inc(i);
       lijn:=Vertaalstring[i];
       lijntest:=Copy(lijn,1,Pos(';',lijn)-1);
       if (pos(x,lijn)<> 0) and (length(lijntest)=length(x)) then
       begin
         gevonden:=true;
         Delete(lijn,1,Pos(';',lijn));
         Vertaal:=lijn;
       end;
     end;
     until (gevonden) or (i=20);
    if not gevonden then
    begin
      AssignFile(Filevar,StartDir+'/Local/XIXPlayer.'+Settings.Language);
      Reset(Filevar);
      repeat
        Readln(Filevar,lijn);
        if not eof(Filevar) then
        begin
          lijntest:=Copy(lijn,1,Pos(';',lijn)-1);
          if (pos(x,lijn)<> 0) and (length(lijntest)=length(x))  then
          begin
            inc(vertaalstringteller); if vertaalstringteller>20 then vertaalstringteller:=1;
            Vertaalstring[vertaalstringteller]:=lijn;
            gevonden:=true;
            Delete(lijn,1,Pos(';',lijn));
            Vertaal:=lijn;
          end;
        end;
      until eof(Filevar) or gevonden;
      Closefile(Filevar);
      if not gevonden then
      begin
        Vertaal:=x;
        if FormLog.CB_Log.Checked then FormLog.MemoDebugLog.Lines.Add('VERTAAL: "'+x+'" niet gevonden');
      end;
    end;
  end
  else Vertaal:=x;
end;

procedure TForm1.LaadSpeellijsten;
var i, max: longint;
    lijn: string;
    aList: Tstringlist;
begin
  FormSplash.Label1.Caption:=Vertaal('Loading Playlists')+' ...';   Application.ProcessMessages;
  aList:=FindAllFiles(Configdir+DirectorySeparator+'playlist', '*.xix', True);
  If aList.Count>0 then
  begin
    MI_AddToPlaylist1.Enabled:=True; MI_AddToPlaylist2.Enabled:=True;
    max:=aList.Count-1;
    for i:=0 to max do
    begin
      lijn:=ExtractFileName(aList.Strings[i]);
      Delete(lijn,length(lijn)-3,4);
      LB_Playlist.Items.Add(lijn);
      SubItem:= TMenuItem.Create(PM_SGAll);
      Subitem.Name:='MySubItem'+inttostr(i);
      Subitem.OnClick:=@OnSubItemHasClick;
      SubItem.Caption:= lijn;
      PM_SGAll.Items[7].Add(SubItem);
      SubItem:= TMenuItem.Create(PM_Play);
      Subitem.Name:='MySubItem'+inttostr(i+max+1);
      Subitem.OnClick:=@OnSubItem2HasClick;
      SubItem.Caption:= lijn;
      PM_Play.Items[9].Add(SubItem);
    end;
  end
  else
  begin
     MI_AddToPlaylist1.Enabled:=False;
     MI_AddToPlaylist2.Enabled:=False;
  end;
  aList.Free;
end;


procedure TForm1.OnSubItemLyricsHasClick(Sender: TObject);
var test: string;
    i: longint;
    gevonden: boolean;
begin
  test:=(Sender as TMenuItem).Caption; gevonden:=false;
  for i:=0 to FormConfig.CLB_Lyrics.Count-1 do
  begin
    if ExtractFileName(FormConfig.CLB_Lyrics.Items[i])=test then
    begin
      gevonden:=true;
      break;
    end;
  end;
  MemoLyrics.Lines.Clear;
  if gevonden then
  begin
    If not ((LB_Artiest.Caption='--') or (LB_Titel.Caption='--')) then
    begin
      LyricsNotFound.Free;
      LyricsNotFound:=TStringlist.Create;
      SearchLyrics:=i;
      ThreadSongText:=TSearchForSongTextThread.Create(False);
    end;
  end;
end;

procedure TForm1.OnCopyToHasClick(Sender: TObject);
var TargetDir: string;
    i, welke : integer;
begin
  TargetDir:=(Sender as TMenuitem).Caption;
  for i:=1 to SG_All.RowCount-1 do
   begin;
    welke:=strtoint(SG_All.Cells[0,i]);
    SaveDownloadto.Add(TargetDir);
    labelPodcast.Caption:=inttostr(SaveDownLoadTo.Count);
    FormDownLoadOverView.ListBox1.Items.Add(Liedjes[welke].Pad+Liedjes[welke].Bestandsnaam);
   end;
   if not downloadpodcast then Thread1:=TDownloadPodCastThread.Create(False);
end;

procedure TForm1.OnSubItemHasClick(Sender: TObject);
var test: string;
    Filevar: TextFile;
    i,i2, max: longint;
begin
    test:=(Sender as TMenuItem).Caption;
    If FileExistsUTF8(ConfigDir+DirectorySeparator+'playlist'+DirectorySeparator+test+'.xix') then
    begin
      i2:=0; max:=SG_All.RowCount-1;
      AssignFile(Filevar,ConfigDir+DirectorySeparator+'playlist'+DirectorySeparator+test+'.xix');
      Append(Filevar);
      For i := 1 to max do
      begin
         if IsCellSelected(SG_All, 1,i) then
         begin
          inc(i2);
          Writeln(Filevar, GetGridFilename(i));
         end;
      end;
      CloseFile(Filevar);
      FormShowMyDialog.ShowWith(Test,inttostr(i2)+' '+Vertaal('Songs added to the playlist')+':','',test,'',Vertaal('Thanks'),False);
    end
    else FormShowMyDialog.ShowWith(Vertaal('WARNING'),Vertaal('No playlist selected'),'',Vertaal('Please select a playlist and try again'),'',Vertaal('Thanks'),False);
end;

procedure TForm1.OnSubItem2HasClick(Sender: TObject);
var test: string;
    Filevar: TextFile;
    i,i2, max, welke: longint;
begin
    test:=(Sender as TMenuItem).Caption;
    If FileExistsUTF8(ConfigDir+DirectorySeparator+'playlist'+DirectorySeparator+test+'.xix') then
    begin
      i2:=0; max:=SG_Play.RowCount-1;
      AssignFile(Filevar,ConfigDir+DirectorySeparator+'playlist'+DirectorySeparator+test+'.xix');
      Append(Filevar);
      For i := 1 to max do
      begin
         if IsCellSelected(SG_Play,1,i) then
         begin
           inc(i2); welke:=strtoint(SG_Play.Cells[6,i]);
           Writeln(Filevar,Liedjes[welke].Pad+Liedjes[welke].Bestandsnaam);
         end;
      end;
      CloseFile(Filevar);
      FormShowMyDialog.ShowWith(Test,inttostr(i2)+' '+Vertaal('Songs added to the playlist')+':','',test,'',Vertaal('Thanks'),False);
    end
    else FormShowMyDialog.ShowWith(Vertaal('Warning'),Vertaal('No playlist selected'),'',Vertaal('Please select a playlist and try again'),'',Vertaal('Thanks'), False);
end;

procedure TForm1.BrowseTo(url: string);
var
  v: THTMLBrowserHelpViewer;
  BrowserPath, BrowserParams: string;
  p: LongInt;
  BrowserProcess: TProcessUTF8;
begin
  v:=THTMLBrowserHelpViewer.Create(nil);
  try
    v.FindDefaultBrowser(BrowserPath,BrowserParams);
    p:=System.Pos('%s', BrowserParams);
    System.Delete(BrowserParams,p,2);
    System.Insert(URL,BrowserParams,p);

    BrowserProcess:=TProcessUTF8.Create(nil);
    try
      {$IFDEF HAIKU}
      Browserpath:='open';
      {$ENDIF}
      BrowserProcess.CommandLine:=BrowserPath+' '+BrowserParams;
      BrowserProcess.Execute;
    finally
      BrowserProcess.Free;
    end;
  finally
    v.Free;
  end;
end;


procedure TForm1.WriteMusicDatabase;
var Filevar, Filevar2: File of TSong;
    i, i2, loopi : longint;
    lijn, librarychosen: string;
begin
  if Settings.ChosenLibrary=0 then librarychosen:=ConfigDir+DirectorySeparator+'music.db'
     else if Settings.ChosenLibrary=1 then librarychosen:=ConfigDir+DirectorySeparator+'work.db'
       else librarychosen:=ConfigDir+DirectorySeparator+CB_Library.Caption+'.db';

  AssignFile(Filevar,librarychosen);
  Rewrite(Filevar);
  if Settings.SaveOnExternal then
                               begin
                                //ShowMessage('Schrijven op SaveOnExternal: Internalsongs');
                                 For i:=0 to internalsongs-1 do if not Liedjes[i].Deleted then Write(Filevar,Liedjes[i]);
                                 //ShowMessage('Loop gedaan: Internalsongs');
                               end
                             else
                               begin
                                //ShowMessage('Schrijven niet op SaveOnExternal: maxsongs');
                                 For i:=0 to maxsongs-1 do if not Liedjes[i].Deleted then Write(Filevar,Liedjes[i]);
                                // ShowMessage('Loop gedaan: maxsongs');
                               end;

  CloseFile(Filevar);

  //TODO
  //THE PATH IS WRITTEN WITHOUT THE BASIC PATH SEPARATION, SO WHEN THIS FILE READ FROM ANOTHER DEVICE,
  //IT IS POSSIBLE THAT THE FILES NEED TO BE CHECKED AGAIN
  //THE USER NEEDS TO MAKE SURE THAT THE PATH IS THE SAME
  // TO SOLVE THIS, THE DATABASE NEEDS A DIFFERENT APPROACH, BUT THIS IS A LOT OF WORK :(

  if Settings.SaveOnExternal then
  begin
    i2:=internalsongs;
    if Settings.IncludeExternalDirs.count>0 then
    begin
      AssignFile(Filevar2,ConfigDir+DirectorySeparator+CB_Library.Text+'_external.db');
      Rewrite(Filevar2);

      loopi:=0;
      repeat
        if directoryexists(Settings.IncludeExternalDirs.Strings[loopi]) then
        begin
        {$IFDEF HAIKU}
        if Settings.ChosenLibrary=0 then lijn:=Settings.IncludeExternalDirs.Strings[loopi]+Directoryseparator+'bemusic.db'
          else if Settings.ChosenLibrary=1 then lijn:=Settings.IncludeExternalDirs.Strings[loopi]+Directoryseparator+'be_work.db'
            else lijn:=Settings.IncludeExternalDirs.Strings[loopi]+Directoryseparator+'be_'+CB_Library.Caption+'.db';
        {$ENDIF}
        {$IFDEF LINUX}
        if Settings.ChosenLibrary=0 then lijn:=Settings.IncludeExternalDirs.Strings[loopi]+Directoryseparator+'unixmusic.db'
          else if Settings.ChosenLibrary=1 then lijn:=Settings.IncludeExternalDirs.Strings[loopi]+Directoryseparator+'unix_work.db'
            else lijn:=Settings.IncludeExternalDirs.Strings[loopi]+Directoryseparator+'unix_'+CB_Library.Caption+'.db';
        //  lijn:=Settings.IncludeExternalDirs.Strings[loopi]+Directoryseparator+'unixmusic.db';
        {$ENDIF}
        {$if defined(CPUARM)}
        if Settings.ChosenLibrary=0 then lijn:=Settings.IncludeExternalDirs.Strings[loopi]+Directoryseparator+'armunixmusic.db'
          else if Settings.ChosenLibrary=1 then lijn:=Settings.IncludeExternalDirs.Strings[loopi]+Directoryseparator+'armunix_work.db'
            else lijn:=Settings.IncludeExternalDirs.Strings[loopi]+Directoryseparator+'armunix_'+CB_Library.Caption+'.db';
        //   lijn:=Settings.IncludeExternalDirs.Strings[loopi]+Directoryseparator+'armunixmusic.db';
        {$IFEND}
        {$IFDEF WINDOWS}
        if Settings.ChosenLibrary=0 then lijn:=Settings.IncludeExternalDirs.Strings[loopi]+Directoryseparator+'windowsmusic.db'
          else if Settings.ChosenLibrary=1 then lijn:=Settings.IncludeExternalDirs.Strings[loopi]+Directoryseparator+'win_work.db'
            else lijn:=Settings.IncludeExternalDirs.Strings[loopi]+Directoryseparator+'win_'+CB_Library.Caption+'.db';
        //  lijn:=Settings.IncludeExternalDirs.Strings[loopi]+Directoryseparator+'windowsmusic.db';
        {$ENDIF}
        {$IFDEF DARWIN}
        if Settings.ChosenLibrary=0 then lijn:=Settings.IncludeExternalDirs.Strings[loopi]+Directoryseparator+'macmusic.db'
          else if Settings.ChosenLibrary=1 then lijn:=Settings.IncludeExternalDirs.Strings[loopi]+Directoryseparator+'mac_work.db'
            else lijn:=Settings.IncludeExternalDirs.Strings[loopi]+Directoryseparator+'mac_'+CB_Library.Caption+'.db';
        {$ENDIF}
          AssignFile(Filevar,lijn);
          Rewrite(Filevar);
         // ShowMessage('Schrijven van '+Settings.IncludeExternalDirs.Strings[loopi]);
          for i:=i2 to maxsongs-1 do
          begin
            if pos(Settings.IncludeExternalDirs.Strings[loopi],Liedjes[i].Pad)=1 then Write(Filevar,Liedjes[i]);
            Write(Filevar2,Liedjes[i]);
          end;
          //ShowMessage('Gedaan met '+Settings.IncludeExternalDirs.Strings[loopi]);
          CloseFile(Filevar);
        end;
        inc (loopi);
      until loopi>=Settings.IncludeExternalDirs.Count;
      CloseFile(Filevar2);
    end;
  end;
end;

procedure TForm1.FormCloseQuery(Sender: TObject; var CanClose: boolean);
begin
  if not (Paramstr(1)='-exit') then
  begin
    If FormConfig.CB_MinimizeOnClose.Checked then
    begin
       ShowMessage('Minimaliseren');
      CanClose:=False;  Form1.WindowState:=WsMinimized; Exit;
    end
    else CanClose:=true;

    If PlannedRecordings>0 then
    begin
      If FormShowMyDialog.ShowWith(Vertaal('WARNING'),Vertaal('There is a shedule planned.'),'',Vertaal('Choose HIDE or QUIT'),Vertaal('HIDE'),Vertaal('QUIT'), False) then
      begin
        MI_FullScreen.Caption:='SHOW';
        Form1.Hide;
        CanClose:=false;
        if Timer1.Enabled then
          If FormShowMyDialog.ShowWith(Vertaal('WARNING'),Vertaal('XiX Music Player is still playing music.'),Vertaal('Do you want the music to STOP?'),Vertaal('Choose STOP or KEEP PLAYING'),Vertaal('STOP'),Vertaal('KEEP PLAYING'), False) then SB_StopClick(Self);
      end
      else CanClose:=True
    end;

    If PlannedRecordings=0 then CanClose:=True;

    If Downloadpodcast then
    begin
      If FormShowMyDialog.ShowWith(Vertaal('WARNING'),Vertaal('You are downloading a PODCAST.'),'',Vertaal('Do you want to stop the download?'),Vertaal('NO'),Vertaal('YES'), False)
           then CanClose:=false
           else CanClose:=True;
    end;

    If CanClose then
    begin
     // Form1.Hide;
     (* Timer1.Enabled:=False;
      Tracksfound.Free;
      FilesFound.Free;
      M3uFilesfound.Free;
      SaveDownloadto.Free;
      LyricsNotFound.Free;
      Settings.Free;
      PlayListsFound.Free;
      MostPlayed.Free;  *)
      {$IFDEF HAIKU}
      {$ELSE}
    (*  case stream of
       1: BASS_ChannelSlideAttribute(Song_Stream1,BASS_ATTRIB_VOL,0,1000);
       2: BASS_ChannelSlideAttribute(Song_Stream2,BASS_ATTRIB_VOL,0,1000);
       4: BASS_ChannelSlideAttribute(ReverseStream,BASS_ATTRIB_VOL,0,1000);
       5: BASS_ChannelSlideAttribute(CDStream,BASS_ATTRIB_VOL,0,1000);
       6: BASS_ChannelSlideAttribute(Song_Stream1,BASS_ATTRIB_VOL,0,1000);
      end;    *)
      {$ENDIF}
      if not settings.Fast then
      begin
        WriteMusicDatabase;
        WriteConfig;
      end;
    end;
  end
  else
  begin
    CanClose:=True;
  end;
  //MostPlayed.Free;     *)
end;

procedure TForm1.CB_YearChange(Sender: TObject);
begin
  SE_Jaar1.Enabled:=CB_Year.Checked;
  SE_Jaar2.Enabled:=CB_Year.Checked;
end;

(*function PCharsToStrings(P: PChar): TStrings;
begin
  Result := TStringList.Create;
  if Assigned(P) then begin
    while P^ <> #0 do begin
      Result.Add(StrPas(P));
      P := StrScan(P,#0) + 1;
    end;
  end
end;  *)

procedure TForm1.ComboBox1Select(Sender: TObject);
var cddb_query, jaar, genre: string;
    i, i2, tnr: byte;
    tussenteken, lijn:string;
    l: integer;
    Temp, temp2: string;
    Filevar: TextFile;
    doorgaan, gevonden: boolean;
    MemStream: TMemoryStream;
    OurProcess: TProcess;
    NumBytes, BytesRead: LongInt;
    totaltitles: integer;
    laatstetrack: byte;
    hours, minutes, seconds, cddb_query2: string;
    secs: integer;
    h,m,s: byte;
begin
 Memo1.Lines.Clear;Memo1.Lines.Add('..');
 Form1.Cursor:=crHourglass;;
 Application.ProcessMessages;
 if status_cd=1 then
 begin

  {$if defined(WINDOWS) or defined(LINUX)}
    cddb_query:=BASS_CD_GetID(0,BASS_CDID_CDDB_READ+Combobox1.ItemIndex);
    Memo1.Lines.AddStrings(cddb_Query);

    {$IFDEF LCLQT}
    Memo1.Lines.Clear;Memo1.Lines.Add('..'); cddb_Query2:=Cddb_query;
    repeat
      lijn:=Copy(cddb_Query2,0,pos(#10,cddb_query2)-2);//showmessage('"'+lijn+'"');
      delete(cddb_query2,1,pos(#10,cddb_query2));
      Memo1.Lines.Add(lijn);
    until pos(#10,cddb_query2)<1 ;
    {$ENDIF}

    if pos('202',Combobox1.Text)=1 then
      begin
        Memo1.Lines.Add(Vertaal('CDDB Entry not found.'));
        for i := 0 to  StringgridCD.RowCount-2 do
         begin
           CD[i+1].Album:='Unknown CD';
           CD[i+1].Titel:='Unknown';
           CD[i+1].tijd:='01:00';
           CD[i+1].artiest:='Unknown artist';
           StringgridCD.Cells[1,i+1]:=CD[i+1].artiest;
           StringgridCD.Cells[2,i+1]:=CD[i+1].Titel;
           StringgridCD.Cells[3,i+1]:=CD[i+1].Album;
           StringgridCD.Cells[4,i+1]:=CD[i+1].tijd;
         end;
      end;
  {$IFEND}
  i:=0;
  {$if defined(HAIKU) or defined(Darwin)}
  if ComboBox1.TEXT='Reload CD' then
  begin
   SB_ReadCDClick(Self);
   exit;
  end;

    Memo1.Lines.Clear;
    temp:=Copy(ComboBox1.Text,1,pos(' ',Combobox1.Text)-1);  //ShowMessage(Temp);
    temp2:=Copy(ComboBox1.Text,pos(' ',Combobox1.Text)+1,8); //ShowMessage(Temp2);
    cddb_query:=temp+'+'+temp2+'&hello=info+zittergie.be+XiX_Player+'+versie+'&proto=5';
    if DownloadFile('http://freedb.freedb.org/~cddb/cddb.cgi?cmd=cddb+read+'+cddb_query, Tempdir+DirectorySeparator+'cddb.tmp') then
    begin
      AssignFile(Filevar, Tempdir+DirectorySeparator+'cddb.tmp');
      Reset(Filevar);
      repeat
        readln(Filevar,lijn);
        Memo1.Lines.Add(lijn);
      until eof(filevar);
      CloseFILE(FILEVAR);
    end;

 {$ENDIF}
  repeat
    inc(i);
  until (pos('DTITLE',Memo1.Lines[i])=1) or (i=Memo1.Lines.Count-1);

  if i<Memo1.Lines.Count-1 then
  begin
    tussenteken:='';
    if pos(' / ',Memo1.Lines[i])>0 then tussenteken:=' / ';
    if pos(' - ',Memo1.Lines[i])>0 then tussenteken:=' - ';
    for i2:=0 to StringgridCD.RowCount-2 do
    begin
      if length(tussenteken)=3 then CD[i2+1].artiest:=Copy(Memo1.Lines[i],8,pos(tussenteken,Memo1.Lines[i])-8);
      if (length(CD[i2+1].artiest)>1) then if CD[i2+1].artiest[1]=' ' then delete(CD[i2+1].artiest,1,1);
      CD[i2+1].Album:=Copy(Memo1.Lines[i],pos(tussenteken,Memo1.Lines[i])+3,length(memo1.Lines[i]));;
      StringgridCD.Cells[1,i2+1]:=CD[i2+1].artiest;
      StringgridCD.Cells[3,i2+1]:=CD[i2+1].Album;
    end;
  end;
  if pos('DYEAR',Memo1.Lines[i+1])=1 then
  begin
    Jaar:=Copy(Memo1.Lines[i+1],7,4);
    for i2:=0 to StringgridCD.RowCount-2 do
    begin
      CD[i2+1].jaartal:=jaar;
      StringgridCD.Cells[5,i2+1]:=CD[i2+1].jaartal;
    end;
  end;
  if pos('DGENRE',Memo1.Lines[i+2])=1 then
  begin
    genre:=Copy(Memo1.Lines[i+2],8,40);
    for i2:=0 to StringgridCD.RowCount-2 do
    begin
      CD[i2+1].genre:=genre;
      StringgridCD.Cells[6,i2+1]:=CD[i2+1].genre;
    end;
  end;
  repeat
    inc(i);
  until (pos('TTITLE',Memo1.Lines[i])=1) or (i=Memo1.Lines.Count-1);
  if i<Memo1.Lines.Count-1 then
  for i2:=0 to StringgridCD.RowCount-2 do
  begin
    {$if defined(WINDOWS) or defined(LINUX)}
    l := BASS_CD_GetTrackLength(0, i2);
    l := l div 176400;
    CD[i2+1].tijd:=Format('%d:%.2d', [l div 60, l mod 60]);
     StringgridCD.Cells[4,i2+1]:=CD[i2+1].Tijd;
    {$IFEND}

    CD[i2+1].Titel:=Copy(Memo1.Lines[i],length('TTITLE'+inttostr(i2))+2,length(Memo1.Lines[i]));
    if pos(' - ',CD[i2+1].Titel)>1 then
    begin
      if i2<10 then tnr:=9
               else tnr:=10;
      CD[i2+1].artiest:=Copy(Memo1.Lines[i],length('TTITLE'+inttostr(i2))+2,pos(' - ',Memo1.Lines[i])-tnr);
      CD[i2+1].Titel:=Copy(Memo1.Lines[i],pos(' - ',Memo1.Lines[i])+3,length(memo1.Lines[i]));;
      StringgridCD.Cells[1,i2+1]:=CD[i2+1].Artiest;
    end
    else
    begin
     if pos(' / ',CD[i2+1].Titel)>1 then
     begin
       if i2<10 then tnr:=9
                else tnr:=10;
       CD[i2+1].artiest:=Copy(Memo1.Lines[i],length('TTITLE'+inttostr(i2))+2,pos(' / ',Memo1.Lines[i])-tnr);
       CD[i2+1].Titel:=Copy(Memo1.Lines[i],pos(' / ',Memo1.Lines[i])+3,length(memo1.Lines[i]));;
       StringgridCD.Cells[1,i2+1]:=CD[i2+1].Artiest;
     end;
    end;
    StringgridCD.Cells[2,i2+1]:=CD[i2+1].Titel;
    inc(i);
  end;
  FormRip.Stringgrid1.RowCount:=StringgridCD.RowCount;
  StringgridCD.AutoSizeColumns;
  FormRip.LB_Album.Caption:=CD[1].Album;
  FormRip.LB_cddb.Caption:=temp;
  FormRip.LB_Artist.Caption:=CD[1].artiest;
  FormRip.LB_Genre.Caption:=genre;
  Formrip.LB_Year.Caption:=Jaar;
 end;

 if (status_cd=2) then  //DVD Rip
 begin
  //If not FormWarning.Visible then FormWarning.Show;
   ComboBox1.Cursor:=CrHourglass;  Application.ProcessMessages;
   selectedchapter:=inttostr(Combobox1.ItemIndex+1);
   //ShowMessage('Selectedchapter='+selectedchapter);
     MemStream := TMemoryStream.Create;
      BytesRead := 0;
      OurProcess := TProcess.Create(nil);
      {$IFDEF DARWIN}
      OurProcess.CommandLine := Settings.Mplayer+' -novideo -frames 0 -msglevel identify=6 dvd://'+selectedchapter;
      OurProcess.Options := [poUsePipes];
      {$ENDIF}
      {$IFDEF UNIX}
      OurProcess.CommandLine := Settings.Mplayer+' -novideo -frames 0 -msglevel identify=6 dvd://'+selectedchapter+' -dvd-device '+Settings.DVDDrive;
      OurProcess.Options := [poUsePipes];
      {$ENDIF}
      {$IFDEF HAIKU}
      //OurProcess.CommandLine := Settings.Mplayer+' -novideo -frames 0 -msglevel identify=6 dvd://'+selectedchapter+' -dvd-device ';
      //OurProcess.Options := [poUsePipes];
      {$ENDIF}
      {$IFDEF WINDOWS}
       OurProcess.CommandLine:=Settings.Mplayer+' -frames 0 -msglevel identify=6 dvd://'+selectedchapter+dvdLetter;
       OurProcess.Options:=OurProcess.Options+[poNoConsole];
      {$ENDIF}
      OurProcess.Execute;
      Memo1.Lines.Add(OurProcess.CommandLine);

       while OurProcess.Running do
       begin
        MemStream.SetSize(BytesRead + READ_BYTES);
        NumBytes := OurProcess.Output.Read((MemStream.Memory + BytesRead)^, READ_BYTES);
        if NumBytes > 0 then Inc(BytesRead, NumBytes)
                        else Sleep(100);
        Application.ProcessMessages;
       end;
       repeat
        MemStream.SetSize(BytesRead + READ_BYTES);
        NumBytes := OurProcess.Output.Read((MemStream.Memory + BytesRead)^, READ_BYTES);
        if NumBytes > 0 then Inc(BytesRead, NumBytes);
       until NumBytes <= 0;
     // if BytesRead > 0 then WriteLn;
       MemStream.SetSize(BytesRead);
       Memo1.Lines.Add(''); Memo1.Lines.Add(Vertaal('Getting Chapters using MPLAYER ...')); Memo1.Lines.Add('');
       Memo1.Lines.LoadFromStream(Memstream);

      OurProcess.Free; MemStream.Free;
      Application.ProcessMessages;

      ComboBox1.Cursor:=CrDefault;
      i:=1; gevonden:=false;
      repeat
        inc(i);
        if pos('TITLE_'+selectedchapter+'_CHAPTER',Memo1.Lines[i])>1 then
        begin
         gevonden:=true;
         lijn:=Memo1.Lines[i]; delete(lijn,1,pos('=',lijn));
         tnr:=Strtointdef(lijn,0); Stringgridcd.RowCount:=tnr+1;
         for i2 := 1 to tnr do
             begin
               Stringgridcd.Cells[0,i2]:=inttostr(i2);
               Stringgridcd.Cells[1,i2]:=CD[1].artiest;
               Stringgridcd.Cells[2,i2]:='Track '+inttostr(i2);
               Stringgridcd.Cells[3,i2]:=CD[1].Album;
               Stringgridcd.Cells[5,i2]:=CD[1].jaartal;
               Stringgridcd.Cells[6,i2]:=CD[1].genre;
             end;
        end;
         FormRip.LB_Album.Caption:=CD[1].Album;
         FormRip.LB_cddb.Caption:=temp;
         FormRip.LB_Artist.Caption:=CD[1].artiest;
         FormRip.LB_Genre.Caption:=CD[1].genre;
      until gevonden or (i>Memo1.Lines.Count-2);
      if gevonden then
      begin
        gevonden:=false;
        repeat
          inc(i);
          if pos('HAPTERS:', Memo1.Lines[i])>1 then
          begin
             gevonden:= true;
             lijn:=Memo1.Lines[i];
          end;
        until gevonden or (i>Memo1.Lines.Count-2);
        Delete(lijn,1,pos(':',lijn)+1);
        if gevonden then
        begin
          for i2:=1 to tnr do
              begin
               temp:=lijn; Delete(lijn,1,pos(',',lijn));
               Delete(Temp,1,1); Delete(Temp,8,length(temp));
               Stringgridcd.Cells[4,i2]:=temp;
              end;
          for i2:=1 to tnr do
              begin
                hours:=copy(Stringgridcd.Cells[4,i2],1,1);
                minutes:=copy(stringgridcd.Cells[4,i2],3,2);
                seconds:=copy(stringgridcd.Cells[4,i2],6,2);
                secs:=(strtointdef(hours,0)*3600)+(strtointdef(minutes,0)*60)+(strtointdef(seconds,0));
                Stringgridcd.Cells[4,i2]:=inttostr(secs);
              end;
          for i2:=tnr downto 2 do
             begin
                Stringgridcd.Cells[4,i2]:=inttostr(strtointdef(stringgridcd.Cells[4,i2],0)-(strtointdef(stringgridcd.Cells[4,i2-1],0)));
             end;
          for i2:=1 to tnr-1 do Stringgridcd.Cells[4,i2]:=Stringgridcd.Cells[4,i2+1];
          Stringgridcd.Cells[4,tnr]:='0';
          for i2 := 1 to tnr do
          begin
            secs:=strtointdef(stringgridcd.Cells[4,i2],0);
            h:=secs div 3600;
            secs:=secs mod 3600;
            m:=secs div 60;
            secs:=secs mod 60;
            temp:= inttostr(secs); if length(temp)=1 then temp:='0'+temp;
            temp2:=inttostr(m); if length(temp2)=1 then temp2:='0'+temp2;
            Stringgridcd.Cells[4,i2]:=temp2+':'+temp;
          end;

        end;
      end;
  // FormWarning.Hide;
 end;
 Stringgridcd.AutoSizeColumns;
 Form1.Cursor:=crDefault;
end;

procedure TForm1.CheckBox1Change(Sender: TObject);
begin
  CB_Genre.Enabled:=CheckBox1.Checked;
end;

procedure TForm1.CB_LandChange(Sender: TObject);
begin
  LB_land.Enabled:=CB_Land.Checked;
  SpeedButton18click(Self);
end;

procedure TForm1.CB_GenreRadioChange(Sender: TObject);
begin
  LB_GenreRadio.Enabled:=CB_GenreRadio.Checked;
  SpeedButton18click(Self);
end;

procedure TForm1.ShowParameters;
begin
  Writeln('');
  Writeln('Usage:');
  Writeln('');
  Writeln('XiXMusicPlayer [options]');
  Writeln('');
  Writeln('Possible options/parameters are:');
  Writeln('');
  Writeln('-h: Shows this help message');
  Writeln('-startwizard: Starts XiXMusicPlayer as it was the first time.  The start wizard is shown');
  Writeln('-cdb: The audiobuffer specified in the settings menu is used');
  Writeln('-minimized: Minimize XiXMusicPlayer after loading');
  Writeln('-fullscreen: Start the player fullscreen');
  Writeln('-kiosk: Start the player fullscreen');
  Writeln('-shuffle: Select Random order');
  Writeln('-noshuffle: Don''t use random order');
  Writeln('-iminahurry: Load files only from DB.  Do not save DB at close');
  Writeln('');
  Writeln('--autoplay [options]: Starts to play music from the previous used library');
  Writeln('  --artist="artist": Stars playing the artist specified');
  Writeln('  --playlist="playlist": Select the songs from "playlist"');
  Writeln('  --mediamode(=xx): Select the fullscreen Mediamode (not yet for streams)');
  Writeln('  --library="library": Select the library with name "library", when not found, the previous used library is used');
  Writeln('');
  Writeln('--autoplay=radio [options]: Starts to play Radiostream');
  Writeln('  --rnr=xx: Select station xx from the list');
  Writeln('  --preset=xx:  Play the station at the chosen preset');
  Writeln('');
end;

procedure TForm1.FormShow(Sender: TObject);
var Filevar: TextFile;
    lijn, aplayoption: string;
    welke, i, i2: longint;
    radiopreset: integer;
    gevonden: boolean;
    FilesTemp, ipList : TStringlist;
    TcpSock: TTCPBlockSocket;
 //   RunEncoder: TProcess;
begin
 if Application.HasOption('h') or Application.HasOption('help') then
 begin
   ShowParameters; firsttime:=false; Settings.Fast:=True;
   Form1.Visible:=False;
   Close;
 end;

 if firsttime then
  begin
    ProgressBarSpeed.Visible:=False;

    if Application.HasOption('startwizard') or (not FileExistsUTF8(Configdir+DirectorySeparator+'XIXMusicPlayer.ini'))
        then FormWizard.ShowModal
        else ReadConfig;

    if Settings.Lame='wizard' then FormWizard.ShowModal;

    {$IFDEF HAIKU}
    {$ELSE}
    BASS_SetDevice(Settings.Soundcard);
    {$IFDEF UNIX}
    BASS_Init(Settings.Soundcard, 44100, 0, nil, nil);
    {$ENDIF}
    {$IFDEF WINDOWS}
     BASS_Init(Settings.Soundcard, 44100, 0, 0, nil);
    {$ENDIF}
    if Application.HasOption('cdb') then BASS_SetConfig(BASS_CONFIG_DEV_BUFFER, Settings.cdb);
    {$ENDIF}
    Bass.BASS_SetConfigPtr(BASS_CONFIG_CD_CDDB_SERVER,pchar('gnudb.gnudb.org'));
    If Application.HasOption('shuffle') then Settings.Shuffle:=True;
    If Application.HasOption('noshuffle') then Settings.Shuffle:=False;
    If Application.HasOption('iminahurry') then Settings.Fast:=True
                                           else Settings.Fast:=False;

    Timer1.Interval:=Settings.TimerInterval;

    Loadtheme;

    case VU_Settings.Placement of
      1: MI_VU_at_top.Checked:=True;
      2: MI_VU_at_center.Checked:=True;
      3: MI_VU_at_bottom.Checked:=True;
    end;
    MI_VU_showpeaks.Checked:=VU_Settings.ShowPeaks;
  //  Volumebar.Position:=round(BASS_GetVolume*100);

    FormSplash.Show; FormConfig.CB_MinimizeOnClose.Checked:=Settings.MinimizeOnClose;
    FormSplash.LabelVersie.Caption:=versie;

    {$IFDEF DARWIN}
      FormConfig.CB_NasBug.Checked:=False;  FormConfig.CB_NasBug.Enabled:=False;
      LabelElapsedTime.Layout:=tlTop;
    {$ENDIF}

    (* Find Library *.dir files and free the list*)
    FilesTemp:=FindAllFiles(ConfigDir,'*.dir',false);
    for i:=0 to FilesTemp.Count-1 do
    begin
      lijn:=upcase(ExtractFilename(FilesTemp.Strings[i]));
      if (lijn<>'DEFAULT.DIR') and (lijn<>'WORK.DIR') then
      begin
        CB_Library.Items.Add(copy(ExtractFilename(FilesTemp.Strings[i]),1,length(lijn)-4));
      end;
    end;
    FreeAndNil(FilesTemp);

    If Application.HasOption('library') then
    begin
      lijn:=Application.GetOptionValue('l', 'library');
      if length(lijn)>0 then welke:=CB_Library.Items.IndexOf(lijn);
      if welke<0 then welke:=0;

      if welke<>Settings.ChosenLibrary then
      begin
        CB_Library.ItemIndex:=welke;
        Settings.ChosenLibrary:=welke;
        Readfolders;
      end;
    end;

    CB_Library.ItemIndex:=Settings.ChosenLibrary;

    VertaalForm1;
    ReadDatabase;
    GetAllMusicFiles;
    If Settings.Fast then
    begin
     Liedjes:=DB_Liedjes;
     LB_Artist1.Items.AddStrings(Artiesten);
     LB_Artist1.Items.Insert(0,Vertaal('All'));
     LB_Albums1.Items.AddStrings(Albums);
    end
    else
    begin
     GetMusicDetails;
    end;
    FillVirtualFSTree;
    LaadSpeellijsten;

    LB_ArtiestResize(Self);

    begin
     case Settings.TabArtist of
      0: PageControl1.TabPosition:=tpBottom;
      1: PageControl1.TabPosition:=tpLeft;
      2: PageControl1.TabPosition:=tpRight;
      3: PageControl1.TabPosition:=tpTop;
     end;
     case Settings.TabPlaylist of
      0: PageControl2.TabPosition:=tpBottom;
      1: PageControl2.TabPosition:=tpLeft;
      2: PageControl2.TabPosition:=tpRight;
      3: PageControl2.TabPosition:=tpTop;
    end;

    if settings.Shuffle then
    begin
      ImageListRepeat.GetBitmap(3, SB_Shuffle.Glyph);
      SB_Shuffle.Hint:='SHUFFLE: On';
      MI_Reshuffle.Enabled:=True;
    end
                        else ImageListRepeat.GetBitmap(4, SB_Shuffle.Glyph);

    case Settings.RepeatSong of
      0: ImageListRepeat.GetBitmap(2, SB_Repeat.Glyph);
      1: ImageListRepeat.GetBitmap(1, SB_Repeat.Glyph);
      2: ImageListRepeat.GetBitmap(0, SB_Repeat.Glyph);
    end;
   end;

    if maxsongs>0 then
    begin
       FormEQ.CB_EQ.Checked:=Settings.EQ;
       FormEQ.SetEQPreset;
       FormEQ.ComboBox1.ItemIndex:=EQ_Set;
       FormEQ.ComboBox1Select(Self);
    end;

    SG_Play.ColWidths[6]:=0;

    for i:=0 to 147 do CB_Genre.Items.Add(aTAG_MusicGenre[i]);

    (* Loading Radiolisting *)
    If FileExistsUTF8(Settings.cacheDirRadio+'radio.lst') then
    begin
      I:=0;
      FormSplash.Label1.Caption:=Vertaal('Loading online radio listing')+' ...';  Application.ProcessMessages;
      AssignFile(Filevar,Settings.cacheDirRadio+'radio.lst');
      Reset(Filevar);
      Repeat
        Readln(Filevar,lijn);
        if not eof(Filevar) then
        begin
          inc(i); welke:=strtoint(lijn);
          StringgridRadioAir.RowCount:=i+1;
          StringgridRadioAir.Cells[0,i]:=lijn;
          RadioStation[welke].internalnr:=lijn;
          Readln(Filevar,lijn); Radiostation[welke].naam:=lijn;
          StringgridRadioAir.Cells[1,i]:=lijn;
          Readln(Filevar,lijn); Radiostation[welke].land:=lijn;
          StringgridRadioAir.Cells[2,i]:=lijn;
          Readln(Filevar,lijn); Radiostation[welke].genres:=lijn;
          StringgridRadioAir.Cells[3,i]:=lijn;
          Readln(Filevar,lijn); Radiostation[welke].website:=lijn;
          Readln(Filevar,lijn); Radiostation[welke].logo1:=lijn;
          Readln(Filevar,lijn);
          Readln(Filevar,lijn); Radiostation[welke].link:=lijn;
          Readln(Filevar,lijn); Radiostation[welke].volgorde:=lijn[1];
          Readln(Filevar,lijn);
        end;
      until eof(Filevar);
      CloseFile(Filevar);
    end
    else SB_RadioUpdateClick(Self); (* No radiolisting found, trying to download the list *)

    (* Loading Online Radio listing *)
    If FileExistsUTF8(Settings.cacheDirRadio+'radio.prs') then
    begin
      I2:=2000;
      FormSplash.Label1.Caption:=Vertaal('Loading online radio listing')+' ...'; Application.ProcessMessages;
      AssignFile(Filevar,Settings.cacheDirRadio+'radio.prs');
      Reset(Filevar);
      Repeat
        Readln(Filevar,lijn);
        if not eof(Filevar) then
        begin
          inc(i); inc(i2); StringgridRadioAir.RowCount:=i+1;
          StringgridRadioAir.Cells[0,i]:=inttostr(i2);
          RadioStation[i2].internalnr:=lijn;
          Readln(Filevar,lijn); Radiostation[i2].naam:=lijn;
          StringgridRadioAir.Cells[1,i]:=lijn;
          Readln(Filevar,lijn); Radiostation[i2].land:=lijn;
          StringgridRadioAir.Cells[2,i]:=lijn;
          Readln(Filevar,lijn); Radiostation[i2].genres:=lijn;
          StringgridRadioAir.Cells[3,i]:=lijn;
          Readln(Filevar,lijn); Radiostation[i2].website:=lijn;
          Readln(Filevar,lijn); Radiostation[i2].logo1:=lijn;
          Readln(Filevar,lijn);
          Readln(Filevar,lijn); Radiostation[i2].link:=lijn;
          Readln(Filevar,lijn); Radiostation[i2].volgorde:=lijn[1];
          Readln(Filevar,lijn);
        end;
      until eof(Filevar);
      CloseFile(Filevar);
      personalradio:=i2;
    end;
    StringgridRadioAir.AutoSizeColumns;

    (* Loading Radio Presets *)
    If FileExistsUTF8(Settings.cacheDirRadio+'presets') then
    begin
      AssignFile(Filevar,Settings.cacheDirRadio+'presets');
      Reset(Filevar);
      Repeat
        Readln(Filevar, lijn);
        if length(lijn)>0 then
        begin
          i:=strtointdef(lijn,0);
          if i<>0 then
          begin
            Stringgridpresets.RowCount:=Stringgridpresets.RowCount+1;
            i2:=Stringgridpresets.RowCount-1;
            StringgridPresets.Cells[0,i2]:=lijn;
            StringgridPresets.Cells[1,i2]:=Radiostation[i].naam;
            StringgridPresets.Cells[2,i2]:=Radiostation[i].land;
            StringgridPresets.Cells[3,i2]:=Radiostation[i].genres;
          end;
        end;
      until eof(Filevar);
      CloseFile(Filevar);
      StringgridPresets.AutoSizeColumns;
    end;

    (* Loading Recording Schedule *)
    FormSplash.Label1.Caption:=Vertaal('Loading online radio recording schedule')+' ...'; Application.ProcessMessages;
    If FileExistsUTF8(ConfigDir+DirectorySeparator+'radio'+DirectorySeparator+'schedule') then
    begin
      AssignFile(Filevar,ConfigDir+DirectorySeparator+'radio'+DirectorySeparator+'schedule');
      Reset(Filevar);
      Repeat
        readln(Filevar,lijn);
        inc(PlannedRecordings);
        FormPlanRecording.StringGrid1.RowCount:=PlannedRecordings+1;
        FormPlanrecording.Stringgrid1.Cells[0,plannedrecordings]:=copy(lijn,1,pos(';',lijn)-1);
        FormPlanrecording.Stringgrid1.Cells[2,plannedrecordings]:=radiostation[strtoint(FormPlanrecording.Stringgrid1.Cells[0,plannedrecordings])].naam;
        Delete(lijn,1,pos(';',lijn));
        FormPlanrecording.Stringgrid1.Cells[1,plannedrecordings]:=copy(lijn,1,pos(';',lijn)-1);
        Delete(lijn,1,pos(';',lijn));
        FormPlanrecording.Stringgrid1.Cells[3,plannedrecordings]:=copy(lijn,1,pos(';',lijn)-1);
        Delete(lijn,1,pos(';',lijn));
        FormPlanrecording.Stringgrid1.Cells[4,plannedrecordings]:=copy(lijn,1,pos(';',lijn)-1);
        Delete(lijn,1,pos(';',lijn));
        FormPlanrecording.Stringgrid1.Cells[5,plannedrecordings]:=copy(lijn,1,pos(';',lijn)-1);
        Delete(lijn,1,pos(';',lijn));
        FormPlanrecording.Stringgrid1.Cells[6,plannedrecordings]:=copy(lijn,1,pos(';',lijn)-1);
        Delete(lijn,1,pos(';',lijn));
        FormPlanrecording.Stringgrid1.Cells[7,plannedrecordings]:=copy(lijn,1,pos(';',lijn)-1);
        Delete(lijn,1,pos(';',lijn));
        FormPlanrecording.Stringgrid1.Cells[8,plannedrecordings]:=lijn;
      until eof(Filevar);
      CloseFile(Filevar);
      if plannedrecordings>0 then
      begin
          FormPlanRecording.SortSchedule;  Application.ProcessMessages;
          TimerSchedule.Enabled:=True;
      end;
    end;
    FormPlanRecording.CB_CopyFolder.Checked:=ScheduleSettings.CopyRec;  FormPlanRecording.CB_RenameFile.Checked:=ScheduleSettings.RenameRec;
    FormPlanRecording.CB_Overwrite.Checked:=ScheduleSettings.Overwrite; FormPlanRecording.Edit_Copy.Text:=ScheduleSettings.CopyDir;
    FormPlanRecording.Edit_Rename.Text:=ScheduleSettings.RenameFormat;  FormPlanRecording.CB_DeleteAfterCopy.Checked:=ScheduleSettings.DeleteAfterCopy;
    Speedbutton34Click(Self);

    (* Loading PODCAST list *)
    FormSplash.Label1.Caption:=Vertaal('Loading online Internet Podcast')+' ...';
    if FileExistsUTF8(Settings.cacheDirRadio+DirectorySeparator+'podcastnew') then
    begin
      SG_Podcast.LoadFromCSVFile(Settings.cacheDirRadio+DirectorySeparator+'podcastnew',';',false);
      SG_Podcast.AutoSizeColumns;
    end;
    if (VU_Settings.Active>1) and (VU_Settings.Active<4) then
    begin
      dec(VU_Settings.Active);
      Panel_VUClick(self);
    end
    else if VU_Settings.Active=4 then MI_VU_Active4.Checked:=true;
    if Splitter2.Top>TabSheetArtists.Height-42 then Splitter2.Top:=TabSheetArtists.Height-52;

    FormSplash.Hide;
    SB_ReloadPlaylistClick(Self);

    (* Loading Lyrics plugins, If firsttime, put XiX.lpl at front *)
    LyricsVar:=TLyrics.Create;
    LyricsVar.GetLyricSources(PlugInDir);
    for i:=0 to LyricsVar.AllLyricSourceFiles.Count-1 do
    begin
      gevonden:=false;
      for i2:=0 to FormConfig.CLB_Lyrics.Count-1 do if FormConfig.CLB_Lyrics.Items[i2]=LyricsVar.AllLyricSourceFiles.Strings[i] then gevonden:=True;
      if not gevonden then
      begin
         FormConfig.CLB_Lyrics.Items.Add(LyricsVar.AllLyricSourceFiles.Strings[i]);
         FormConfig.CLB_Lyrics.Checked[FormConfig.CLB_Lyrics.Items.Count-1]:= true;
         if (pos('XiX.lpl',LyricsVar.AllLyricSourceFiles.Strings[i])>0) and (i>0) then
         begin
           Lyricsvar.AllLyricSourceFiles.Strings[i]:=LyricsVar.AllLyricSourceFiles.Strings[0];
           LyricsVar.AllLyricSourceFiles.Strings[0]:=FormConfig.CLB_Lyrics.Items.Strings[i];
           FormConfig.CLB_Lyrics.Items.Strings[i]:=FormConfig.CLB_Lyrics.Items.Strings[0];
           FormConfig.CLB_Lyrics.Items.Strings[0]:=LyricsVar.AllLyricSourceFiles.Strings[0];
         end;
      end;
      begin
        SubItem:= TMenuItem.Create(PM_Songtext);
        Subitem.OnClick:=@OnSubItemLyricsHasClick;
        SubItem.Caption:= ExtractFilename(LyricsVar.AllLyricSourceFiles.Strings[i]);
        PM_Songtext.Items[3].Add(SubItem);
      end;
    end;
    LyricsVar.Free;

    FormConfig.SpinEditFontGrids.Value:=Settings.FontSize; FormConfig.SpinEditFontMemo.Value:=Settings.Font2Size;
    FormConfig.SpinEditFontGridsChange(Self); FormConfig.SpinEditFontMemoChange(Self);

    (* Start listening for Network Control evenets *)
    if settings.NetworkControl then
    begin
      if Listen <> nil then
      begin
        Listen.Terminate;
        Listen.WaitFor;
        FreeAndNil(Listen);
        FormLog.MemoDebugLog.Lines.Add('Stopped listening ...');
      end
      else
      begin
        Listen := TTCPListenDaemon.Create;
        ipList := TStringList.Create;
        try
          TcpSock := TTCPBlockSocket.create;
          try
            TcpSock.ResolveNameToIP(TcpSock.LocalName, ipList);
          finally
            TcpSock.Free;
          end;
        finally
          FormLog.MemoDebugLog.Lines.AddStrings(ipList);
          FormConfig.Memo_IP.Lines.AddStrings(ipList);
          ipList.Free;
        end;
        FormLog.MemoDebugLog.Lines.Add('Started listening ...');
      end;
    end
    else FormConfig.CB_NetworkControl.Checked:=false;

    TrayIcon1.Visible:=True;
    MyThread:=TMyThread.Create;
   // firsttime:=false;   In Activate
    SG_ListenLive.AutoSizeColumns;

    (* Controleer andere opstart parameters *)

    (* Autoplay(=xxxxx)
         If no 'xxxxx' play the database
         'xxxxx' = 'radio' - Play the radio (can be combined with preset or radionr *)

    If Application.HasOption('autoplay') then
    begin
     aplayoption:=Application.getOptionValue('u', 'autoplay');
     if aplayoption='radio' then
     begin
       If Application.HasOption('rnr') then
       begin
         lijn:=Application.getOptionValue('r', 'radionr');
         PageControl1.ActivePageIndex:=5;
         PageControl4.ActivePageIndex:=0;
         if StringgridRadioAir.RowCount>1 then
         begin
           i:=0; gevonden:=false;
           repeat
             inc(i);
             If StringgridRadioAir.Cells[0,i]=lijn then
             begin
               gevonden:=true;
               StringgridRadioAir.Row:=i;
               StringgridRadioAirDblClick(Self);
             end;
           until gevonden or (i>=StringgridRadioAir.RowCount-1);
         end;
       end;
       If Application.HasOption('preset') then
       begin
         radiopreset:=strtointdef(Application.getOptionValue('p', 'preset'),1);
         PageControl1.ActivePageIndex:=5;
         PageControl4.ActivePageIndex:=1;
         if radiopreset<StringgridPresets.RowCount then
         begin
           StringgridPresets.Row:=radiopreset;
           StringgridPresetsDblClick(Self);
         end;
       end;
     end;
     if aplayoption='' then
     begin
       if LB_Artist1.Items.Count>0 then
       begin
         If Application.HasOption('artist') then
         begin
           lijn:=Application.getOptionValue('a', 'artist');
           LB_Artist1.ItemIndex:=LB_Artist1.Items.IndexOf(lijn);
         end
         else LB_Artist1.ItemIndex:=0;

         if LB_Artist1.ItemIndex>-1 then
         begin
          // LB_Artist1.MakeCurrentVisible;
           LB_Artist1Clicked; Application.ProcessMessages;
           fullrandom:=true;
           If SG_All.RowCount>1 then SG_AllDblClick(Self);
           fullrandom:=false;
         end;
       end;
     end;
     If Application.HasOption('mediamode') then ImageCDCoverDblClick(Self);
    end;
  end;
  If formSplash.Visible then FormSplash.Close;
  If FormWizard.Visible then FormWizard.Close;
end;

procedure TForm1.LoadTheme;
begin
  {$IFDEF MSWINDOWS}
    Form1.Color:=clDefault;
    LB_Artist1.Color:=clDefault;
    LB_Artist1.Font.Color:=clDefault;
    LB_Artists2.Color:=clDefault;
    LB_Artists2.Font.Color:=clDefault;
    LB_Albums1.Color:=clDefault;
    LB_Albums1.Font.Color:=clDefault;
    LB_Albums2.Color:=clDefault;
    LB_Albums2.Font.Color:=clDefault;
  {$ENDIF}
  case Settings.Backdrop of
      0: begin
           ImageListBackDrop.GetBitmap(0,Image9.Picture.Bitmap);
           ImageListLCD.GetBitmap(0,Image1.Picture.Bitmap);
           ImageListLCD.GetBitmap(0,Image2.Picture.Bitmap);
         end;
      1: Begin
           ImageListBackDrop.GetBitmap(0,Image9.Picture.Bitmap);
           ImageListLCD.GetBitmap(0,Image1.Picture.Bitmap);
           ImageListLCD.GetBitmap(0,Image2.Picture.Bitmap);
         end;
      2: Begin
           ImageListBackDrop.GetBitmap(1,Image9.Picture.Bitmap);
           ImageListLCD.GetBitmap(1,Image1.Picture.Bitmap);
           ImageListLCD.GetBitmap(1,Image2.Picture.Bitmap);
           {$IFDEF MSWINDOWS}
            Form1.Color:=clGray;
            LB_Artist1.Color:=clGray;
            LB_Artist1.Font.Color:=clSilver;
            LB_Albums2.Color:=clGray;;
            LB_Albums2.Font.Color:=clSilver;
            LB_Artists2.Color:=clGray;
            LB_Artists2.Font.Color:=clSilver;
            LB_Albums1.Color:=clGray;;
            LB_Albums1.Font.Color:=clSilver;
            TV_VFS.BackgroundColor:=clGray;
            TV_VFS.Font.Color:=clWhite;
            ShellTreeview1.BackgroundColor:=clGray;
            ShellTreeview1.Color:=clGray;
            ShellTreeView1.Font.Color:=clwhite;
            StringgridRadioAir.Color:=clGray;
            StringgridRadioAir.AlternateColor:=clGray;
            StringgridRadioAir.Font.Color:=clWhite;
            StringgridRadioAir.FixedColor:=clGray;
            StringgridRadioAir.TitleFont.Color:=clSilver;
           {$ENDIF}
         end;
  end;
  if not settings.UseBackDrop then Image9.Picture.Bitmap.Clear;
end;

function TForm1.DownloadFile(const Url, PathToSaveTo: string): boolean;
var fs: TFilestream;
    goed, Haiku: boolean;
    lijn: string;
    Filevar: TextFile;
    AProcess: TProcess;
begin
  goed:=false;Haiku:=False;
  {$IFDEF HAIKU}
     Haiku:=true;
     AProcess := TProcess.Create(nil);
     try
      AProcess.CommandLine:='wget '+url+' -O '+PathToSaveTo+' -T 5 -t 1';
      AProcess.options:=AProcess.options+[poWaitOnExit];
      AProcess.Execute;
     except
    // ShowMessage(Vertaal('Download '+url+' went wrong'));
     end;
     AProcess.Free;
     if fileexists(PathToSaveTo) then goed:=True;
  {$ELSE}

  if (length(url)>1) and not Haiku then
  begin
   fs := TFileStream.Create(PathToSaveTo, fmOpenWrite or fmCreate);
   try
      goed:=HttpGetBinary(Url, fs);
   finally
      fs.Free;
   end;
  end;
  {$ENDIF}
  If (goed) and (FileExistsUTF8(Pathtosaveto)) then
  begin
      if Filesize(Pathtosaveto)>2 then
      begin
        AssignFile(Filevar,Pathtosaveto);
        Reset(Filevar);
        Readln(Filevar,lijn);
        CloseFile(Filevar);
        if pos('!DOCTYPE',lijn)>0 then
        begin
          goed:=false;
          DeleteFileUTF8(Pathtosaveto);
        end;
      end
      else
      begin
        goed:=false;
        DeleteFileUTF8(Pathtosaveto);
      end;
   end;
   DownloadFile:=goed;
end;


procedure TForm1.ReadDatabase;
var Filevar: File of TSong;
    i, tempmax, temp_i, iloop: longint;
    lijn, librarychosen: string;
begin
  i:=0; temp_i:=0;

  Artiesten.Clear; Artiesten.Sorted:=True;  Artiesten.Duplicates:=dupIgnore;
  Albums.Clear; Albums.Sorted:=True;  Albums.Duplicates:=dupIgnore;

  FormSplash.Label1.Caption:='Reading DB'; Application.ProcessMessages;

  if Settings.ChosenLibrary=0 then librarychosen:=ConfigDir+DirectorySeparator+'music.db'
     else if Settings.ChosenLibrary=1 then librarychosen:=ConfigDir+DirectorySeparator+'work.db'
       else librarychosen:=ConfigDir+DirectorySeparator+CB_Library.Caption+'.db';

  if Formlog.CB_Log.Checked then
  begin
    FormLog.MemoDebugLog.Lines.Add('>>BEGIN<< TForm1.ReadDatabase;');
    FormLog.MemoDebugLog.Lines.Add('max_records (before library chosen)='+inttostr(max_records));
    FormLog.MemoDebugLog.Lines.Add('librarychosen='+librarychosen);
  end;

  if FileExistsUTF8(librarychosen) then
  begin
    AssignFile(Filevar,librarychosen);
    Reset(Filevar); max_records:=System.FileSize(Filevar);
    Reset(Filevar); Setlength(DB_Liedjes,max_records+1);
    if max_records>0 then for i:=0 to max_records-1 do
    begin
     Read(Filevar,DB_Liedjes[i]);
     if Settings.Fast then
     begin
       Artiesten.Add(DB_Liedjes[i].Artiest);
       Albums.Add(DB_Liedjes[i].CD);
     end;
    end;
    temp_i:=max_records;
    CloseFile(Filevar);
  end;
  {$IFDEF UNIX}
    FormConfig.CB_Optical.Enabled:=True;
  {$ENDIF}

  If (Settings.IncludeExternalDirs.Count>0) and (settings.SaveOnExternal) then
  begin
    iloop:=0;
    if (Settings.SaveExternalOnInternal) and (FileExistsUTF8(ConfigDir+DirectorySeparator+CB_Library.Text+'_external.db')) then
    begin
      lijn:=ConfigDir+DirectorySeparator+CB_Library.Text+'_external.db';
      AssignFile(Filevar,lijn);
      Reset(Filevar); tempmax:=System.FileSize(Filevar);
      max_records:=max_records+tempmax;
      Reset(Filevar); Setlength(DB_Liedjes,max_records+1);

      for i:=0 to tempmax-1 do
      begin
        try
          Read(Filevar,DB_Liedjes[temp_i+i]);
          if settings.Fast then
          begin
            Artiesten.Add(DB_Liedjes[i].Artiest);
            Albums.Add(DB_Liedjes[i].CD);
          end;
        except
        end;
      end;
      CloseFile(Filevar);
    end
    else
    begin

    repeat
    {$IFDEF HAIKU}
      if Settings.ChosenLibrary=0 then lijn:=Settings.IncludeExternalDirs.Strings[iloop]+Directoryseparator+'bemusic.db'
        else if Settings.ChosenLibrary=1 then lijn:=Settings.IncludeExternalDirs.Strings[iloop]+Directoryseparator+'be_work.db'
          else lijn:=Settings.IncludeExternalDirs.Strings[iloop]+Directoryseparator+'be_'+CB_Library.Caption+'.db';
    {$ENDIF}
    {$IFDEF LINUX}
      if Settings.ChosenLibrary=0 then lijn:=Settings.IncludeExternalDirs.Strings[iloop]+Directoryseparator+'unixmusic.db'
        else if Settings.ChosenLibrary=1 then lijn:=Settings.IncludeExternalDirs.Strings[iloop]+Directoryseparator+'unix_work.db'
          else lijn:=Settings.IncludeExternalDirs.Strings[iloop]+Directoryseparator+'unix_'+CB_Library.Caption+'.db';
    {$ENDIF}
    {$if defined(CPUARM)}
      if Settings.ChosenLibrary=0 then lijn:=Settings.IncludeExternalDirs.Strings[iloop]+Directoryseparator+'armunixmusic.db'
        else if Settings.ChosenLibrary=1 then lijn:=Settings.IncludeExternalDirs.Strings[iloop]+Directoryseparator+'armunix_work.db'
          else lijn:=Settings.IncludeExternalDirs.Strings[iloop]+Directoryseparator+'armunix_'+CB_Library.Caption+'.db';
    {$IFEND}
    {$IFDEF WINDOWS}
      if Settings.ChosenLibrary=0 then lijn:=Settings.IncludeExternalDirs.Strings[iloop]+Directoryseparator+'windowsmusic.db'
        else if Settings.ChosenLibrary=1 then lijn:=Settings.IncludeExternalDirs.Strings[iloop]+Directoryseparator+'win_work.db'
          else lijn:=Settings.IncludeExternalDirs.Strings[iloop]+Directoryseparator+'win_'+CB_Library.Caption+'.db';
    {$ENDIF}
    {$IFDEF DARWIN}
      if Settings.ChosenLibrary=0 then lijn:=Settings.IncludeExternalDirs.Strings[iloop]+Directoryseparator+'macmusic.db'
        else if Settings.ChosenLibrary=1 then lijn:=Settings.IncludeExternalDirs.Strings[iloop]+Directoryseparator+'mac_work.db'
          else lijn:=Settings.IncludeExternalDirs.Strings[iloop]+Directoryseparator+'mac_'+CB_Library.Caption+'.db';
    {$ENDIF}
     if (FileExistsUTF8(lijn)) and (Settings.IncludeExternalDirsChecked[iloop]) then
     begin
      AssignFile(Filevar,lijn);
      Reset(Filevar); tempmax:=System.FileSize(Filevar);

      max_records:=max_records+tempmax;
      Reset(Filevar); Setlength(DB_Liedjes,max_records+1);

      for i:=0 to tempmax-1 do
      begin
        try
          Read(Filevar,DB_Liedjes[temp_i+i]);
          if settings.Fast then
          begin
            Artiesten.Add(DB_Liedjes[i].Artiest);
            Albums.Add(DB_Liedjes[i].CD);
          end;
        except
        end;
      end;
      CloseFile(Filevar);
     end;
    inc(iloop);
    until iloop>=Settings.IncludeExternalDirs.Count;
    end;
    if Formlog.CB_Log.Checked then FormLog.MemoDebugLog.Lines.Add('max_records (after External)='+inttostr(max_records));
  end;
  if Formlog.CB_Log.Checked then FormLog.MemoDebugLog.Lines.Add('>>END<< TForm1.ReadDatabase;');
end;


procedure TForm1.GetMusicDetails;
var I,i2, vanaf: longint;
    temp_artists, Temp_Albums: TStringList;
    lijn: string;
    compareresult: integer;
begin
  if Formlog.CB_Log.Checked then FormLog.MemoDebugLog.Lines.Add('>>BEGIN<< TForm1.GetMusicDetails;');

  Temp_Artists:=TStringlist.Create; Temp_artists.Sorted:=True; Temp_Artists.Duplicates:=dupIgnore;
  Temp_Albums:=TStringlist.Create;  Temp_Albums.Sorted:=True;  Temp_Albums.Duplicates:=dupIgnore;

  vanaf:=0;
  FormSplash.ProgressBar1.Max:=FilesFound.Count; Application.ProcessMessages;

  ID3:=TID3v2.Create; ID3OGG:=TOggVorbis.Create; id3Flac:=TFLACfile.Create;
  (*Id3Opus:=TXiX_OpusTagReader.Create;*) id3APE:=TAPEtag.Create; ID3AAC:=TMP4file.Create;
  Id3OpusTest:=TOpusTag.Create;

  if Formlog.CB_Log.Checked then FormLog.MemoDebugLog.Lines.Add('FilesFound.Count='+inttostr(FilesFound.Count));
  For i:=0 to FilesFound.Count-1 do
  begin
    Liedjes[i].Bestandsnaam:=ExtractFilename(FilesFound[i]);
    Liedjes[i].Pad:=ExtractFilePath(FilesFound[i]);
    Liedjes[i].Deleted:=False;
    for i2:=vanaf to max_records-1 do
    begin
      lijn:=DB_Liedjes[i2].Pad+DB_Liedjes[i2].Bestandsnaam;
      compareresult:=comparestr(FilesFound[i],lijn);
      if compareresult=0 then
      begin
         vanaf:=i2;
         Liedjes[i]:=DB_Liedjes[i2];
         break;
      end
                          else Liedjes[i].EQ:=False;
    end;

    if (length(Liedjes[i].Artiest)<1) then     (* No Artist string found *)
      begin
        if Formlog.CB_Log.Checked then
        begin
          FormLog.MemoDebugLog.Lines.Add('New file found: '+FilesFound[i]);
          FormLog.MemoDebugLog.Lines.Add('Trying ID3 TAG for Artist name');
        end;
        GetId3FromFilename(i);
        if (length(Liedjes[i].Artiest)<1) then
        begin
          if Formlog.CB_Log.Checked then FormLog.MemoDebugLog.Lines.Add('ID3 TAG for artist not found, trying to guess from filename:');
          GetDetailsFromFilename(i);
        end;

        Liedjes[i].FadeSettings:=255;
        Liedjes[i].Mono:=False; Liedjes[i].TrimBegin:=False; Liedjes[i].TrimEnd:=False;
        Liedjes[i].TrimLength[0]:=0; Liedjes[i].TrimLength[1]:=0;
        db_changed:=true;
      end;

    if Liedjes[i].Artiest<>'' then Temp_Artists.Add(Liedjes[i].Artiest);
    if Liedjes[i].CD<>'' then Temp_Albums.Add(Liedjes[i].CD);

    if i mod 80 = 0 then                      (* Update Splash every 80 songs*)
    begin
      FormSplash.Label2.Caption:=Liedjes[i].Artiest+' ('+inttostr(i)+'/'+inttostr(FormSplash.ProgressBar1.Max)+')';
      FormSplash.ProgressBar1.Position:=i;
      Application.ProcessMessages;
    end;

  end;

  ID3.Free; id3Ogg.Free;  id3Flac.Free; id3APE.free; id3AAC.Free; (*id3Opus.Free;*) id3OpusTest.Free;
  LB_Artist1.Items.AddStrings(Temp_Artists); LB_Artist1.Items.Insert(0,Vertaal('All'));
  LB_Albums1.Items.AddStrings(Temp_Albums);
  Temp_Artists.Free; Temp_Albums.Free;

  if Formlog.CB_Log.Checked then FormLog.MemoDebugLog.Lines.Add('>>END<< TForm1.GetMusicDetails;');
end;


procedure TForm1.FillVirtualFSTree;
var
  Song, Len: Integer;

  function FindNode(Parent: TTreeNode; Text: string): TTreeNode;
  begin
    {$ifdef darwin}
    Result:=Parent.GetFirstChild;
    while (Result<>nil) and (CompareFilenames(Result.Text, Text)<>0) do
      Result:=Result.GetNextSibling;
    {$else}
    Result:=Parent.FindNode(Text);
    {$endif}
  end;

  function AddNode(Parent: TTreeNode; Text: string):TTreeNode;
  var
    Data: PNodeSongInfo;
  begin
    if Parent=nil then
      result := TV_VFS.Items.FindTopLvlNode(Text)
    else
      result := FindNode(Parent, Text);

    if result=nil then
    begin
      New(Data);
      Data^.Song := Song;
      Data^.Len := Len;
      result := TV_VFS.Items.AddChildObject(Parent, Text, Data);
    end;
  end;

  procedure AddSongNode;
  var
    level: Integer;
    s: ansistring;
    w, p, pini, c, t, x: pchar;
    ch: Char;
    Parent, Node: TTreeNode;
  begin
    if Liedjes[Song].Pad='' then
      exit;

    // this is supposed to create a new ansistring from a shortstring
    // if Pad type changes, this nedds to be changed to create a copy
    s := Liedjes[Song].Pad;

    Parent := nil;
    level:=0;
    pIni := @S[1];
    t := pIni;
    p := pIni;
    inc(t, Length(Liedjes[Song].Pad));
    while p<t do begin
      w := p;
      // find next separator
      while (p<t) and (not (p^ in ['\','/'])) do inc(p);
      c := p;
      // skip separators
      while (p<t) and (p^ in ['\','/']) do inc(p);
      // c-w='word', p-w='word with separators'
      x := p;
      if level<>0 then
        x := c; // do not include separators on node texts (except on first node)
      ch := x^;
      x^ := #0;
      Len := p-pini;
      Node := AddNode(Parent, w);
      x^ := ch;
      inc(level);
      Parent := Node;
    end;
  end;

var
  Node: TTreeNode;
begin
  // prevent SelectionChangedEvent from triggering
  // TV_VFS.(Un)LockSelectionChangedEvent won't work here
  TV_VFS.OnSelectionChanged := nil;
  TV_VFS.BeginUpdate;
  TV_VFS.Items.Clear;
  for Song:=0 to Length(Liedjes)-1 do
    if not Liedjes[Song].Deleted then AddSongNode;
  Node := TV_VFS.Items.GetFirstNode;
  if Node<>nil then Node.Expand(true);
  TV_VFS.EndUpdate;
  TV_VFS.OnSelectionChanged := @TV_VFSSelectionChanged;
end;

procedure TForm1.RefreshLists(tagsModified, filesModified: boolean);
var
  arrLB: array of
    record
      Listbox: TlistBox;
      TopIndex: Integer;
      ItemIndex: Integer;
      Text: string;
    end;

  procedure RestoreLB(i: Integer);
  var
    LB: TListBox;
    NewIndex: Integer;
    NewTopIndex: Integer;
  begin
    LB := arrLB[i].Listbox;
    NewIndex := arrLB[i].ItemIndex;
    NewTopIndex := -1;
    if NewIndex>=0 then
    begin
      NewIndex := LB.Items.IndexOf(arrLB[i].Text);
      if NewIndex<0 then
      begin
        // old text not found, try to stay near to where it was before
        NewIndex := arrLB[i].ItemIndex;
        if NewIndex>LB.Count-1 then
          NewIndex := LB.Count-1;
        NewTopIndex := ArrLB[i].TopIndex;
      end else
        // old text found, let's keep it at the same position as before
        NewTopIndex :=  NewIndex + arrLB[i].ItemIndex - arrLB[i].TopIndex;
    end;
    LB.ItemIndex := -1;       // overcome MAC's listbox not highlighting itemindex
    LB.ItemIndex := NewIndex; // either it exists or it is -1
    if NewIndex>=0 then
    begin
      // make itemindex visible
      if (NewTopIndex>LB.Count-1) or (NewTopIndex<0) or (NewTopIndex>NewIndex) then
        LB.MakeCurrentVisible
      else
        LB.TopIndex := NewTopIndex;
    end;
  end;

  procedure BackupLB(LB: TListbox);
  var
    i: Integer;
  begin
    i := Length(arrLB);
    SetLength(arrLB, i+1);
    arrLB[i].Listbox := LB;
    arrLB[i].TopIndex := LB.TopIndex;
    arrLB[i].ItemIndex := LB.ItemIndex;
    if arrLB[i].ItemIndex>=0 then
      arrLB[i].Text := LB.Items[arrLB[i].ItemIndex];
  end;

var I,i2,j,songAll,songPLay: longint;
    temp_artists, Temp_Albums: TStringList;
    GridChanged,PathChanged: boolean;
    msg: string;
begin

  if tagsModified then
  begin
    BackupLB(LB_Artist1); // index 0
    BackupLB(LB_Albums1); // index 1
    BackupLB(LB_Artists2); // etc..
    BackupLB(LB_Albums2);

    Temp_Artists:=TStringlist.Create;
    Temp_artists.Sorted:=True;
    Temp_Artists.Duplicates:=dupIgnore;
    Temp_Albums:=TStringlist.Create;
    Temp_Albums.Sorted:=True;
    Temp_Albums.Duplicates:=dupIgnore;

    For i:=0 to Length(Liedjes)-1 do
    begin
      // why are those with empty Artist or Album filtered out? is bad for tagging
      if Liedjes[i].Deleted then continue;
      if Liedjes[i].Artiest<>'' then Temp_Artists.Add(Liedjes[i].Artiest);
      if Liedjes[i].CD<>'' then Temp_Albums.Add(Liedjes[i].CD);
    end;

    LB_Artist1.Items.Assign(Temp_Artists);
    LB_Artist1.Items.Insert(0,Vertaal('All'));
    LB_Albums1.Items.Assign(Temp_Albums);

    RestoreLB(0);
    RestoreLB(1);
    RefreshAlbumArtists;
    RefreshArtistAlbums;
    RestoreLB(2);
    RestoreLB(3);
  end;

  songPlay := -1; songAll := -1;
  if filesModified then
  begin
    if SG_All.RowCount>1 then
      songAll := StrToIntDef(SG_All.Cells[0, SG_All.Row], -1);
    if SG_Play.RowCount>1 then
      songPlay := StrToIntDef(SG_Play.Cells[0, SG_Play.Row], -1);
  end;

  // check if there are changed items in the grids
  for i:=0 to Length(Liedjes)-1 do
  begin

    // All grid
    GridChanged := false; PathChanged := false;
    for j:=1 to SG_All.RowCount-1 do
    begin
      i2 := strtoint(SG_All.Cells[0,j]);
      if (i2=i) and Liedjes[i].Modified then
      begin
        // found a coincidence
        GridChanged := true;

        SG_All.Cells[1,j]:=Liedjes[i].Artiest;
        if Liedjes[i].Track=0 then SG_All.Cells[2,j]:=''
                             else if Liedjes[i].Track<10 then SG_All.Cells[2,j]:='0'+inttostr(Liedjes[i].Track)
                                                         else SG_All.Cells[2,j]:=inttostr(Liedjes[i].Track);
        SG_All.Cells[3,j]:=Liedjes[i].Titel;
        SG_All.Cells[4,j]:=Liedjes[i].CD;
      end;
      if (i2=i) and Liedjes[i].FNModified then
      begin
        // found a coincidence
        PathChanged := true;
        SG_All.Cells[COL_SG_ALL_PATH,j]:=Liedjes[i].Pad;
        SG_All.Cells[COL_SG_ALL_NAME,j]:=Liedjes[i].Bestandsnaam;
      end;
    end;
    if GridChanged then
    begin
      SG_ALL.AutoSizeColumn(1);
      SG_ALL.AutoSizeColumn(2);
      SG_ALL.AutoSizeColumn(3);
      SG_ALL.AutoSizeColumn(4);
    end;
    if PathChanged then
    begin
      SG_ALL.AutoSizeColumn(COL_SG_ALL_PATH);
      SG_ALL.AutoSizeColumn(COL_SG_ALL_NAME);
    end;

    // Play grid
    GridChanged := false;
    for j:=1 to SG_Play.RowCount-1 do
    begin
      i2 := strtoint(SG_Play.Cells[6,j]);
      if (i2=i) and Liedjes[i].Modified then
      begin
        // found a coincidence
        GridChanged := true;

        SG_Play.Cells[1,j]:=Liedjes[i].Artiest;
        if Liedjes[i].Track=0 then SG_Play.Cells[2,j]:=''
                             else if Liedjes[i].Track<10 then SG_Play.Cells[2,j]:='0'+inttostr(Liedjes[i].Track)
                                                         else SG_PLay.Cells[2,j]:=inttostr(Liedjes[i].Track);
        SG_Play.Cells[3,j]:=Liedjes[i].Titel;
        SG_Play.Cells[4,j]:=Liedjes[i].CD;
        SG_Play.Cells[5,j]:=Liedjes[i].Jaartal;

        if j=SG_Play.Row then
        begin
          // we hit the one playing ...
          LB_titel.Caption:=Liedjes[i].Titel;
          LB_Artiest.Caption:=Liedjes[i].Artiest;
          if length(Liedjes[i].CD)>0 then LB_CD.Caption:=Liedjes[i].CD
                                        else LB_CD.Caption:='';

          if (Liedjes[i].Composer<>'') then
          begin
           msg:='(composed by '+Liedjes[i].Composer;
           if (Liedjes[i].OrigArtiest<>'') then msg:=msg+' - Original performed by '+Liedjes[i].OrigArtiest;
           msg:=msg+')';
           Label_Extra.Caption:=msg;
          end
          else if (Liedjes[i].OrigArtiest<>'') then Label_Extra.Caption:='Original performed by '+Liedjes[i].OrigArtiest
                                               else Label_Extra.Caption:='';
          LB_Artiest.Left:=Trackbar2.Left+round(Trackbar2.Width/2)-round((LB_Artiest.Width+LB_CD.Width)/2)+15;
          LB_CD.Caption:=Liedjes[i].CD;
          if length(LB_CD.Caption)>0 then LB_On.Visible:=True
                                     else LB_On.Visible:=False;

          // Is there something missing? ...
          // HERE
        end;
      end;
    end;
    if GridChanged then
    begin
      SG_Play.AutoSizeColumn(1);
      SG_Play.AutoSizeColumn(2);
      SG_Play.AutoSizeColumn(3);
      SG_Play.AutoSizeColumn(4);
      SG_Play.AutoSizeColumn(5);
    end;

    // Refresh filename label
    if Liedjes[i].FNModified and
      (
        ((songAll=i)and(LB_Filename.Tag=1)) or     // origin of current LB_Filename value is SG_All
        ((songPlay=i)and(LB_Filename.Tag=2))       //                  "                     SG_PLay
      )
    then
      LB_Filename.Caption:=Liedjes[i].Pad+Liedjes[i].Bestandsnaam;

    // Mark all songs as not modified
    Liedjes[i].Modified := false;
    Liedjes[i].FNModified := false;
  end;

  //TODO: If only changes on filenames are possible, it doesn't make sense
  //      to enable this, if changes on paths are also possible this must be
  //      enabled ... WIP
  //
  if filesModified then
    FillVirtualFSTree;

  if tagsModified then
  begin
    Temp_Artists.Free;
    Temp_Albums.Free;
  end;
  Application.ProcessMessages;
end;


procedure TForm1.GetId3Extra(i: longint);
var song, TrackTempString, TrackString, TotalTrackString: string;
    tempgenre: integer;
    Channels: byte;
begin
  ID3:=TID3v2.Create; id3Flac:=TFLACfile.Create; id3APE:=TAPEtag.Create;
  ID3AAC:=TMP4file.Create; id3OpusTest:=TOpusTag.Create;

  if i<0 then song:=LiedjesTemp.Bestandsnaam
         else song:=Liedjes[i].Pad+Liedjes[i].Bestandsnaam;

  if FileExistsUTF8(song) then
  begin
   if (pos('.OPUS',Upcase(song))>0) or (pos('.OGG',Upcase(song))>0) then
   begin
     id3opusTest.LoadFromFile(song);

     LiedjesTemp.Artiest:=id3opusTest.ReadFrameByNameAsText('artist');
     LiedjesTemp.Titel:=id3opusTest.ReadFrameByNameAsText('title');
     LiedjesTemp.CD:=id3opusTest.ReadFrameByNameAsText('album');

     TrackTempString:=id3opusTest.ReadFrameByNameAsText('tracknumber');
     if pos('/',TrackTempString)>1 then
     begin
       TrackString:=Copy(TrackTempString,1,pos('/',TrackTempString)-1);
       TotalTrackString:=Copy(TrackTempString,pos('/',TrackTempString)+1,length(TrackTempString)-Length(TrackString)-1);
       LiedjesTemp.Track:=strtointdef(TrackString,0);
       LiedjesTemp.AantalTracks:=TotalTrackString;
     end
     else LiedjesTemp.Track:=strtointdef(id3opusTest.ReadFrameByNameAsText('tracknumber'),0);

     LiedjesTemp.Comment:=id3opusTest.ReadFrameByNameAsText('comment');
     LiedjesTemp.Genre:=id3opusTest.ReadFrameByNameAsText('genre');
     LiedjesTemp.Jaartal:=id3opusTest.ReadFrameByNameAsText('date');
     LiedjesTemp.Software:=id3opusTest.ReadFrameByNameAsText('encoder');
     LiedjesTemp.Encoder:=id3opusTest.ReadFrameByNameAsText('encoder');
     LiedjesTemp.Composer:=id3opusTest.ReadFrameByNameAsText('composer');
     LiedjesTemp.Copyright:=id3opusTest.ReadFrameByNameAsText('copyright');
     LiedjesTemp.OrigArtiest:=id3opusTest.ReadFrameByNameAsText('ORIGINAL_ARTIST');
     LiedjesTemp.GroupTitel:=id3opusTest.ReadFrameByNameAsText('GROUPTITLE');
     LiedjesTemp.SubTitel:=id3opusTest.ReadFrameByNameAsText('SUBTITLE');
     LiedjesTemp.Orchestra:=id3opusTest.ReadFrameByNameAsText('ORCHESTRA');
     LiedjesTemp.Conductor:=id3opusTest.ReadFrameByNameAsText('CONDUCTOR');
     LiedjesTemp.Interpreted:=id3opusTest.ReadFrameByNameAsText('INTERPRETED');
     LiedjesTemp.OrigYear:=id3opusTest.ReadFrameByNameAsText('ORIGINAL_DATE');
     LiedjesTemp.OrigTitle:=id3opusTest.ReadFrameByNameAsText('ORIGINAL_TITLE');
     if (pos('.OPUS',Upcase(song))>0)
       then begin
              id3extra.id:='Opus Codec ('+id3opustest.VendorString+')';
              Channels:=id3opustest.Info.OpusParameters.ChannelCount;
              id3extra.quality:=inttostr(Channels)+ ' channels';
            end
       else begin
              id3extra.id:='Ogg Codec ('+id3opustest.VendorString+')';
              Channels:=id3opustest.Info.VorbisParameters.ChannelMode;
              id3extra.quality:=inttostr(Channels)+ ' channels';
              id3extra.bitrate:=inttostr(id3opustest.Info.VorbisParameters.BitRateNominal);
            end;
     id3extra.Size:=id3opustest.FileSize;
     id3extra.version:=1;
     id3extra.quality:=inttostr(id3opustest.Info.OpusParameters.ChannelCount)+ ' channels';
     case id3opustest.Info.OpusParameters.ChannelCount of
       1: id3extra.quality:=id3extra.quality+' (mono)';
       2: id3extra.quality:=id3extra.quality+' (stereo)';
       else id3extra.quality:=id3extra.quality+' (multi channel)';
     end;
     id3extra.bitrate:='';
     id3extra.lyric:='';
     id3extra.lyric:=id3opusTest.ReadFrameByNameAsText('lyrics');
     if (id3extra.lyric='') and (id3opustest.Count>1) then
     begin
       For i:=1 to id3opustest.Count-1 do
       begin
         //FormLog.MemoDebugLog.Lines.Add(id3opustest.Frames[i].Name);
         if id3opustest.Frames[i].Name='UNSYNCED LYRICS' then
         begin
           If length(id3extra.lyric)=0 then id3extra.lyric:=id3opustest.Frames[i].GetAsText
                                       else id3extra.lyric:=id3extra.lyric+#13+id3opustest.Frames[i].GetAsText;
         end;
       end;
     end;
   end;
   if pos('.APE',Upcase(song))>0 then
   begin
    id3APE.ReadFromFile(song);
    id3extra.id:='Monkey''s Audio';
    id3extra.Size:=id3Ape.Filesize;

    LiedjesTemp.Artiest:=id3APE.SeekField('Artist');
    LiedjesTemp.Titel:=id3APE.SeekField('Title');
    LiedjesTemp.Jaartal:=id3APE.SeekField('Year');
    LiedjesTemp.CD:=id3APE.SeekField('Album');
    LiedjesTemp.Track:=strtointdef(id3APE.SeekField('TRACK'),0);
    LiedjesTemp.Genre:=id3APE.SeekField('Genre');
    LiedjesTemp.Composer:=id3APE.SeekField('Composer');
    LiedjesTemp.Comment:=id3APE.SeekField('Comment');
    LiedjesTemp.Copyright:=id3APE.SeekField('Copyright');
    LiedjesTemp.OrigArtiest:=id3APE.SeekField('Original Artist');
    id3extra.link:=id3APE.SeekField('Related');
    LiedjesTemp.SubTitel:=ID3Ape.SeekField('SUBTITLE');
    LiedjesTemp.GroupTitel:= ID3Ape.SeekField('GROUPING');
    LiedjesTemp.Encoder:=ID3Ape.SeekField('ENCODEDBY');
    LiedjesTemp.OrigTitle:=ID3Ape.SeekField('Original Title');
    LiedjesTemp.OrigYear:=ID3Ape.SeekField('ORIGINALDATE');
    LiedjesTemp.Orchestra:=ID3Ape.SeekField('ORCHESTRA');
    LiedjesTemp.Conductor:=ID3Ape.SeekField('CONDUCTOR');
    LiedjesTemp.Interpreted:=ID3Ape.SeekField('REMIXER');
    id3extra.version:=id3ape.Version;
    id3extra.lyric:=ID3Ape.SeekField('LYRICS');
   end;
   if (pos('.MP4',Upcase(song))>0) or (pos('.M4A',Upcase(song))>0) or (pos('.AAC',Upcase(song))>0) then
   begin
    {$IFDEF WINDOWS}
      try
        id3AAC.ReadFromFile(song);
      except
      end;
    {$ELSE}
      id3AAC.ReadFromFile(song);
    {$ENDIF}
     id3extra.version:=0;
     id3extra.Size:=id3aac.FileSize;
     id3extra.id:=id3aac.FileFormat;
     id3extra.bitrate:=id3aac.BitRate+' kbps'; ;
     id3extra.lyric:='';
   end;
   if pos('.MP3',Upcase(song))>0 then
   begin
     id3.ReadFromFile(song);
     LiedjesTemp.Artiest:=id3.Artist;
     LiedjesTemp.Titel:=id3.Title;
     LiedjesTemp.Track:=id3.Track;
     LiedjesTemp.CD:=id3.Album;

     if length(id3.Genre)>0 then
     begin
       if IsNumber(id3.Genre) then
                                begin
                                  tempGenre:=strtointdef(id3.Genre,12);
                                  if tempGenre>147 then tempGenre:=12;
                                  Liedjes[i].Genre:=aTAG_MusicGenre[tempGenre];
                                end
                              else Liedjes[i].Genre:=id3.Genre;
     end
     else  Liedjes[i].Genre:=id3.Genre;

     LiedjesTemp.Jaartal:=id3.Year;
     id3extra.version:=id3.VersionID;
     LiedjesTemp.Comment:=id3.Comment;
     LiedjesTemp.Composer:=id3.Composer;
     LiedjesTemp.Encoder:=id3.Encoder;
     LiedjesTemp.Copyright:=id3.Copyright;
     LiedjesTemp.OrigArtiest:=id3.OriginalArtist;
     LiedjesTemp.OrigTitle:=id3.OriginalTitle;
     LiedjesTemp.OrigYear:=id3.OriginalYear;
     LiedjesTemp.GroupTitel:=id3.GroupTitle;
     LiedjesTemp.SubTitel:=id3.SubTitle;
     LiedjesTemp.Orchestra:=id3.Orchestra;
     LiedjesTemp.Conductor:=id3.Conductor;
     LiedjesTemp.Interpreted:=id3.Interpreted;
     id3extra.Link:=id3.Link;
     LiedjesTemp.Software:=id3.Software;
     id3extra.id:='MPEG-1 layer 3';
     id3extra.Size:=id3.Filesize;
     id3extra.lyric:=id3.Lyric;
   end;
   if pos('.DFF',Upcase(song))>0 then
   begin
     id3extra.id:='DSD';
     id3extra.lyric:='';
   end;
   if pos('.FLAC',Upcase(song))>0 then
   begin
      id3Flac.ReadFromFile(song);
        LiedjesTemp.Artiest:=id3flac.Artist;
        LiedjesTemp.Titel:=id3flac.Title;
        LiedjesTemp.GroupTitel:=id3flac.GroupTitle;
        LiedjesTemp.SubTitel:=id3flac.SubTitle;
        LiedjesTemp.Track:=strtointdef(id3flac.TrackString,0);
        liedjesTemp.CD:=id3flac.Album;
        liedjesTemp.Comment:=id3flac.Comment;
        liedjesTemp.Jaartal:=id3flac.Year;
        LiedjesTemp.Genre:=id3flac.Genre;
        LiedjesTemp.Software:=id3flac.Encoder;
        LiedjesTemp.Encoder:=id3flac.Encoder;
        LiedjesTemp.Composer:=id3flac.Composer;
        LiedjesTemp.OrigArtiest:=id3flac.Performer;
        LiedjesTemp.OrigTitle:=id3flac.OriginalTitle;
        LiedjesTemp.OrigYear:=id3flac.OriginalYear;
        LiedjesTemp.Copyright:=id3flac.Copyright;
        if LiedjesTemp.Copyright='' then  LiedjesTemp.Copyright:=id3flac.Organization;
        LiedjesTemp.Orchestra:=id3flac.Orchestra;
        LiedjesTemp.Conductor:=id3flac.Conductor;
        LiedjesTemp.Interpreted:=id3flac.Interpreted;
        id3extra.Link:=id3flac.License;
        id3extra.version:=0;
        id3extra.id:=id3flac.Vendor2;
        id3extra.Size:=id3flac.FileLength;
        id3extra.quality:=id3flac.ChannelMode;
        id3extra.bitrate:=inttostr(id3flac.Bitrate);
        id3extra.lyric:=id3flac.Lyrics;
   end;
   id3extra.cdcoverlink:=ExtractFilePath(song);
  end;

  ID3.Free; (*id3Ogg.Free;*)  id3Flac.Free; id3APE.Free; id3aac.Free; Id3Opustest.Free;
end;

procedure TForm1.GetId3FromFilename(i: longint);
var song, TrackString, TotalTrackString, TrackTempString: string;
    tempGenre: integer;
begin
  song:=Liedjes[i].Pad+Liedjes[i].Bestandsnaam;
  if FileExistsUTF8(song) then
  begin
   if (pos('.OPUS',Upcase(song))>0) or (pos('.OGG',Upcase(song))>0)  then
   begin
     id3opustest.LoadFromFile(song);

     Liedjes[i].Artiest:=id3opusTest.ReadFrameByNameAsText('artist');
     Liedjes[i].Titel:=id3opusTest.ReadFrameByNameAsText('title');
     Liedjes[i].CD:=id3opusTest.ReadFrameByNameAsText('album');

     TrackTempString:=id3opusTest.ReadFrameByNameAsText('tracknumber');
     if pos('/',TrackTempString)>1 then
     begin
       TrackString:=Copy(TrackTempString,1,pos('/',TrackTempString)-1);
       TotalTrackString:=Copy(TrackTempString,pos('/',TrackTempString)+1,length(TrackTempString)-Length(TrackString)-1);
       Liedjes[i].Track:=strtointdef(TrackString,0);
       Liedjes[i].AantalTracks:=TotalTrackString;
     end
     else Liedjes[i].Track:=strtointdef(id3opusTest.ReadFrameByNameAsText('tracknumber'),0);

     Liedjes[i].Comment:=id3opusTest.ReadFrameByNameAsText('comment');
     Liedjes[i].Genre:=id3opusTest.ReadFrameByNameAsText('genre');
     Liedjes[i].Jaartal:=id3opusTest.ReadFrameByNameAsText('date');
     Liedjes[i].Software:=id3opusTest.ReadFrameByNameAsText('encoder');
     Liedjes[i].Encoder:=id3opusTest.ReadFrameByNameAsText('encoder');
     Liedjes[i].Composer:=id3opusTest.ReadFrameByNameAsText('composer');
     Liedjes[i].Copyright:=id3opusTest.ReadFrameByNameAsText('copyright');
     Liedjes[i].OrigArtiest:=id3opusTest.ReadFrameByNameAsText('ORIGINAL_ARTIST');
     Liedjes[i].GroupTitel:=id3opusTest.ReadFrameByNameAsText('GROUPTITLE');
     Liedjes[i].SubTitel:=id3opusTest.ReadFrameByNameAsText('SUBTITLE');
     Liedjes[i].Orchestra:=id3opusTest.ReadFrameByNameAsText('ORCHESTRA');
     Liedjes[i].Conductor:=id3opusTest.ReadFrameByNameAsText('CONDUCTOR');
     Liedjes[i].Interpreted:=id3opusTest.ReadFrameByNameAsText('INTERPRETED');
     Liedjes[i].OrigYear:=id3opusTest.ReadFrameByNameAsText('ORIGINAL_DATE');
     Liedjes[i].OrigTitle:=id3opusTest.ReadFrameByNameAsText('ORIGINAL_TITLE');
     id3extra.Size:=id3opustest.FileSize;

     id3extra.version:=1;
     id3extra.lyric:='';
     id3extra.id:=id3opusTest.ReadFrameByNameAsText('VENDOR');;

   (*
     Keep to test own library

     id3opus.ReadFromfile(song);
     Liedjes[i].Artiest:=id3opus.Artist;
     Liedjes[i].Titel:=id3opus.Title;
     Liedjes[i].CD:=id3opus.Album;
     Liedjes[i].Track:=id3opus.Track;
     Liedjes[i].Comment:=id3opus.Comment;
     Liedjes[i].Genre:=id3opus.Genre;
     Liedjes[i].Jaartal:=id3opus.Date;
     Liedjes[i].Software:=id3opus.Encoder;
     Liedjes[i].Encoder:=id3opus.Encoder;
     Liedjes[i].Composer:=id3opus.Composer;
     Liedjes[i].OrigArtiest:=id3opus.OriginalArtist;
     Liedjes[i].Copyright:=id3opus.Copyright;
     Liedjes[i].Copyright:=id3opus.Copyright;
     Liedjes[i].Orchestra:=id3opus.Orchestra;
     Liedjes[i].Conductor:=id3opus.Conductor;
     Liedjes[i].OrigTitle:=id3opus.OriginalTitle;
     Liedjes[i].OrigYear:=id3opus.OriginalDate;
     Liedjes[i].SubTitel:=id3opus.SubTitle;
     Liedjes[i].GroupTitel:=id3opus.GroupTitle;
     Liedjes[i].Interpreted:=id3opus.Interpreted;
     id3extra.Link:=id3opus.License;
     id3extra.version:=0;
     id3extra.id:=id3opus.Vendor;
     id3extra.Size:=id3opus.FileSize;
     //id3extra.quality:=id3opus.ChannelMode;
     id3extra.lyric:=id3opus.Lyrics;  *)
   end;
   if pos('.APE',Upcase(song))>0 then
   begin
    id3extra.id:='Monkey''s Audio';
    id3APE.ReadFromFile(song);
    Liedjes[i].Artiest:=id3APE.SeekField('ARTIST');
    Liedjes[i].Titel:=id3APE.SeekField('TITLE');
    Liedjes[i].Jaartal:=id3APE.SeekField('DATE');
    Liedjes[i].CD:=id3APE.SeekField('Album');
    Liedjes[i].Track:=strtointdef(id3APE.SeekField('TRACK'),0);
    if Liedjes[i].Track=0 then Liedjes[i].Track:=strtointdef(id3APE.SeekField('TRACKNUMBER'),0);
    Liedjes[i].Genre:=id3APE.SeekField('GENRE');
    Liedjes[i].Composer:=id3APE.SeekField('COMPOSER');
    if Liedjes[i].Artiest='' then Liedjes[i].Artiest:=Liedjes[i].Composer;
    Liedjes[i].Comment:=id3APE.SeekField('COMMENT');
    Liedjes[i].Copyright:=id3APE.SeekField('COPYRIGHT');
    Liedjes[i].OrigArtiest:=id3APE.SeekField('ORIGINAL_ARTIST');
    if  Liedjes[i].OrigArtiest='' then Liedjes[i].OrigArtiest:=id3APE.SeekField('ORIGINALARTIST');
    id3extra.link:=id3APE.SeekField('RELATED');
    Liedjes[i].SubTitel:=ID3Ape.SeekField('SUBTITLE');
    Liedjes[i].GroupTitel:= ID3Ape.SeekField('GROUPING');
    Liedjes[i].Encoder:=ID3Ape.SeekField('ENCODEDBY');
    Liedjes[i].OrigTitle:=ID3Ape.SeekField('ORIGINAL_TITLE');
    if Liedjes[i].OrigTitle='' then Liedjes[i].OrigTitle:=ID3Ape.SeekField('ORIGINALTITLE');
    Liedjes[i].OrigYear:=ID3Ape.SeekField('ORIGINAL_DATE');
    if Liedjes[i].OrigYear='' then Liedjes[i].OrigYear:=ID3Ape.SeekField('ORIGINALDATE');
    Liedjes[i].Orchestra:=ID3Ape.SeekField('ENSEMBLE');
    if Liedjes[i].Orchestra='' then Liedjes[i].Orchestra:=ID3Ape.SeekField('ORCHESTRA');
    Liedjes[i].Conductor:=ID3Ape.SeekField('CONDUCTOR');
    Liedjes[i].Interpreted:=ID3Ape.SeekField('REMIXER');
    id3extra.version:=id3ape.Version;
    id3extra.lyric:=ID3Ape.SeekField('LYRICS');
   end;
   if (pos('.M4A',Upcase(song))>0) or (pos('.MP4',Upcase(song))>0)  or (pos('.AAC',Upcase(song))>0) then
   begin
    {$IFDEF WINDOWS}
    try
      id3AAC.ReadFromFile(song);
    except
    end;
    {$ELSE}
      id3AAC.ReadFromFile(song);
    {$ENDIF}
     Liedjes[i].Artiest:=id3aac.Artist;
     Liedjes[i].Titel:=id3aac.Title;
     Liedjes[i].Track:=id3aac.Track;
     Liedjes[i].CD:=id3aac.Album;
     Liedjes[i].Genre:=aTAG_MusicGenre[strtointdef(id3aac.Genre,148)];
     Liedjes[i].Jaartal:=id3aac.Year;
     Liedjes[i].Composer:=id3aac.Composer;
     Liedjes[i].Copyright:=id3aac.Copyright;
     Liedjes[i].Encoder:=id3aac.Encoder;
     id3extra.lyric:='';
   end;
   if pos('.MP3',Upcase(song))>0 then
   begin
     id3.ReadFromFile(song);
     Liedjes[i].Artiest:=id3.Artist;
     Liedjes[i].Titel:=id3.Title;
     Liedjes[i].GroupTitel:=id3.GroupTitle;
     Liedjes[i].SubTitel:=id3.SubTitle;
     Liedjes[i].Track:=id3.Track;
     Liedjes[i].CD:=id3.Album;

     if length(id3.Genre)>0 then
     begin
       if IsNumber(id3.Genre) then
                                begin
                                  tempGenre:=strtointdef(id3.Genre,12);
                                  if tempGenre>147 then tempGenre:=12;
                                  Liedjes[i].Genre:=aTAG_MusicGenre[tempGenre];
                                end
                              else Liedjes[i].Genre:=id3.Genre;
     end
     else  Liedjes[i].Genre:=id3.Genre;

     (*If isNumber(id3.Genre) then Liedjes[i].Genre:=aTAG_MusicGenre[strtointdef(id3.Genre,148)]
                            else Liedjes[i].Genre:=id3.Genre;    *)

     Liedjes[i].Jaartal:=id3.Year;
     id3extra.version:=id3.VersionID;
     Liedjes[i].Comment:=id3.Comment;
     Liedjes[i].Composer:=id3.Composer;
     Liedjes[i].Encoder:=id3.Encoder;
     Liedjes[i].Copyright:=id3.Copyright;
     Liedjes[i].OrigArtiest:=id3.OriginalArtist;
     Liedjes[i].OrigTitle:=id3.OriginalTitle;
     Liedjes[i].OrigYear:=id3.OriginalYear;
     Liedjes[i].Orchestra:=id3.Orchestra;
     Liedjes[i].Conductor:=id3.Conductor;
     Liedjes[i].Interpreted:=id3.Interpreted;
     id3extra.Link:=id3.Link;
     Liedjes[i].Software:=id3.Software;
     id3extra.id:='MPEG-1 layer 3';
     id3extra.Size:=id3.Size;
     id3extra.lyric:=id3.lyric;
    // if length(id3extra.lyric)>0 then showmessage(id3extra.lyric);
   end;
   if pos('.DFF',Upcase(song))>0 then
   begin
     id3extra.id:='DSD';
     id3extra.lyric:='';
   end;
 (*  if (pos('.OGG2',Upcase(song))>0) then
   begin
     id3Ogg.ReadFromFile(song);
     Liedjes[i].Artiest:=id3ogg.Artist;
     Liedjes[i].Titel:=id3ogg.Title;
     Liedjes[i].CD:=id3ogg.Album;
     Liedjes[i].Track:=id3ogg.Track;
     Liedjes[i].Comment:=id3ogg.Comment;
     Liedjes[i].Genre:=id3ogg.Genre;
     Liedjes[i].Jaartal:=id3ogg.Date;
     Liedjes[i].Software:=id3ogg.Encoder;
     Liedjes[i].Encoder:=id3ogg.Encoder;
     Liedjes[i].Composer:=id3ogg.Composer;
     Liedjes[i].OrigArtiest:=id3ogg.OriginalArtist;
     Liedjes[i].Copyright:=id3ogg.Copyright;
     Liedjes[i].Orchestra:=id3ogg.Orchestra;
     Liedjes[i].Conductor:=id3ogg.Conductor;
     Liedjes[i].OrigTitle:=id3ogg.OriginalTitle;
     Liedjes[i].OrigYear:=id3ogg.OriginalDate;
     Liedjes[i].SubTitel:=id3ogg.SubTitle;
     Liedjes[i].GroupTitel:=id3ogg.GroupTitle;
     Liedjes[i].Interpreted:=id3ogg.Interpreted;
     id3extra.Link:=id3ogg.License;
     id3extra.version:=0;
     id3extra.id:=id3ogg.Vendor;
     id3extra.Size:=id3ogg.FileSize;
     id3extra.quality:=id3ogg.ChannelMode;
     id3extra.lyric:=id3ogg.Lyrics;
   end;   *)
   if pos('.FLAC',Upcase(song))>0 then
   begin
  //  try
    {$IFDEF WINDOWS}
      id3Flac.ReadFromFile(song);
    {$ELSE}
      id3Flac.ReadFromFile(song);
    {$ENDIF}
 //    except
 //      ShowMessage('ERROR: FromFile: Reading FLAC file '+song);
 //    end;
     Liedjes[i].Artiest:=id3flac.Artist;
     Liedjes[i].GroupTitel:=id3flac.GroupTitle;
     Liedjes[i].SubTitel:=id3flac.SubTitle;
     Liedjes[i].Titel:=id3flac.Title;
     Liedjes[i].Track:=strtointdef(id3flac.TrackString,0);
     liedjes[i].CD:=id3flac.Album;
     liedjes[i].Comment:=id3flac.Comment;
     liedjes[i].Jaartal:=id3flac.Year;
     Liedjes[i].Genre:=id3flac.Genre;
     Liedjes[i].Software:=id3flac.Encoder;
     Liedjes[i].Encoder:=id3flac.Encoder;
     Liedjes[i].Composer:=id3flac.Composer;
     Liedjes[i].OrigArtiest:=id3flac.Performer;

     Liedjes[i].Copyright:=id3flac.Copyright;

     if Liedjes[i].Copyright='' then Liedjes[i].Copyright:=id3flac.Organization;

     Liedjes[i].OrigTitle:=id3flac.OriginalTitle;
     Liedjes[i].OrigYear:=id3flac.OriginalYear;
     Liedjes[i].Orchestra:=id3flac.Orchestra;
     Liedjes[i].Conductor:=id3flac.Conductor;
     Liedjes[i].Interpreted:=id3flac.Interpreted;

     id3extra.Link:=id3flac.License;
     id3extra.version:=0;
     id3extra.Size:=id3flac.FileLength;
     id3extra.quality:=id3flac.ChannelMode;
     id3extra.bitrate:=inttostr(id3flac.Bitrate);
     id3extra.lyric:=id3flac.Lyrics;
   end;
   id3extra.cdcoverlink:=ExtractFilePath(song);
  end;
(*  ID3.Free; id3Ogg.Free;  id3Flac.Free; id3APE.free; id3AAC.Free;
  id3Opus.Free;  *)
end;

function TForm1.IsNumber(const AString: String): boolean;
var
  lData: PChar;
begin
  lData := PChar(AString);
  while lData^ <> #0 do
  begin
    if ( lData^ < '0' ) or ( lData^ > '9' ) then
      break;
    inc(lData);
  end;
  result := ( lData^ = #0 );
end;

procedure TForm1.SB_DeletePresetClick(Sender: TObject);
begin
If Stringgridpresets.Row>0 then
  begin
    Stringgridpresets.DeleteRow(Stringgridpresets.Row);
    Savepresets;
  end;
end;

procedure TForm1.SB_InfoClick(Sender: TObject);
begin
    If Panel2.Visible then
    begin
      Panel2.Visible:=False;
      SplitterLyric:=Splitter3.Left;
      Splitter3.Enabled:=False;
      Splitter3.Left:=SB_Info.Left-4;
      ImageListOthers.GetBitmap(1, SB_Info.Glyph);
      Tabsheet10.PageControl.Visible:=False;  Tabsheet11.PageControl.Visible:=False;
      Tabsheet12.PageControl.Visible:=False;
      Splitter4Moved(Self);
    end
    else
    begin
      Panel2.Visible:=True;
      Tabsheet10.PageControl.Visible:=True;  Tabsheet11.PageControl.Visible:=True;
      Tabsheet12.PageControl.Visible:=True;
      Splitter3.Left:=SplitterLyric;
      Splitter3.Enabled:=True;
      ImageListOthers.GetBitmap(0, SB_Info.Glyph);
      Splitter4Moved(Self);
    end;
end;

procedure TForm1.SB_NextClick(Sender: TObject);
begin
  PanelVolume.Visible:=False;
  if PageControl1.ActivePageIndex < 3 then If SG_Play.RowCount<2 then exit;
  If Not EndSchedule(Self) then exit;
  if Streamsave then if not FormShowMyDialog.ShowWith(Vertaal('RECORDING'),Vertaal('A recording is active')+': '+LB_CD.Caption,'',Vertaal('Are you sure you want to stop?'),Vertaal('YES'),Vertaal('NO'), False) then exit;

  case stream of
     1: begin
          if Settings.FadeManual then begin
                                       {$if not defined(HAIKU)}
                                       BASS_ChannelSlideAttribute(Song_Stream1,BASS_ATTRIB_VOL,0,1000*Settings.FadeTime)
                                       {$ifend}
                                      end
                                        else SB_StopClick(Self);
          If songrowplaying<SG_Play.RowCount-1 then SG_Play.Row:=songrowplaying+1
                                               else SG_Play.Row:=1;
          SG_playDblClick(Self);
        end;
     2: begin
          if Settings.FadeManual then begin
                                        {$if not defined(HAIKU)}
                                        BASS_ChannelSlideAttribute(Song_Stream2,BASS_ATTRIB_VOL,0,1000*Settings.FadeTime)
                                        {$ifend}
                                      end
                                 else SB_StopClick(Self);
          If songrowplaying<SG_Play.RowCount-1 then SG_Play.Row:=songrowplaying+1
                                               else SG_Play.Row:=1;
          SG_playDblClick(Self);
        end;
     4: begin
          if Settings.FadeManual then
          begin
           {$if not defined(HAIKU)}
           BASS_ChannelSlideAttribute(ReverseStream,BASS_ATTRIB_VOL,0,1000*Settings.FadeTime)
           {$ifend}
          end
           else SB_StopClick(Self);
          Stream:=1;
          If songrowplaying<SG_Play.RowCount-1 then SG_Play.Row:=songrowplaying+1
                                               else SG_Play.Row:=1;
          SG_playDblClick(Self);
        end;
     5: begin
          If CDTrackPlaying<StringgridCD.RowCount-2 then StringgridCD.Row:=CDTrackPlaying+2
                                                    else StringgridCD.Row:=1;
          StringgridCDDblClick(Self);
        end;
     6: begin
          if PlayingFromRecorded then
          begin
            if Settings.RepeatSong=1 then
            begin
              StringgridRecordedDblClick(Self);
            end
                                     else
            begin
              if StringgridRecorded.Row<StringgridRecorded.RowCount-1 then
              begin
                 StringgridRecorded.Row:=StringgridRecorded.Row+1;
                 StringgridRecordedDblClick(Self);
              end
              else if Settings.RepeatSong=2 then
              begin
                StringgridRecorded.Row:=1;
                StringgridRecordedDblClick(Self);
              end;
            end
          end
                                 else
          begin
            if SG_CUE.RowCount>1 then
            begin
              inc(playingcue);
              if playingcue>SG_CUE.RowCount-1 then
              begin
                LabelElapsedTime.Caption:='00:00';
                playingcue:=1; SG_CUE.Row:=1;
                If FilePlaying<ShellListView1.Items.Count-1 then ShellListView1.ItemIndex:=ShellListView1.ItemIndex+1
                                                            else ShellListView1.ItemIndex:=0;
                ShellListView1DblClick(Self);
              end
              else
              begin
                SG_CUE.Row:=playingcue;
                SG_CUEDblClick(Self);
              end;
            end
            else
            begin
              If FilePlaying<ShellListView1.Items.Count-1 then ShellListView1.ItemIndex:=ShellListView1.ItemIndex+1
                                                          else ShellListView1.ItemIndex:=0;
              ShellListView1DblClick(Self);
            end;
          end;
        end;
    10: begin
          If PageControl4.ActivePageIndex=0 then
          begin
            If StringgridRadioAir.Row<StringgridRadioAir.RowCount-1 then StringgridRadioAir.Row:=StringgridRadioAir.Row+1
                                                                    else StringgridRadioAir.Row:=1;
            StringgridRadioAirDblClick(Self);
          end;
          If PageControl4.ActivePageIndex=1 then
          begin
            If StringgridPresets.Row<StringgridPresets.RowCount-1 then StringgridPresets.Row:=StringgridPresets.Row+1
                                                                  else StringgridPresets.Row:=1;
            StringgridPresetsDblClick(Self);
          end;
        end;
    11: begin
          If Stringgrid1.Row<Stringgrid1.RowCount-1 then Stringgrid1.Row:=Stringgrid1.Row+1
                                                    else Stringgrid1.Row:=1;
          Stringgrid1DblClick(Self);
        end;
  end;
end;

procedure TForm1.SB_PauzeClick(Sender: TObject);
begin
 PanelVolume.Visible:=False;
 If Not EndSchedule(Self) then exit;

  if Streamsave then if not FormShowMyDialog.ShowWith(Vertaal('RECORDING'),Vertaal('A recording is active')+': '+LB_CD.Caption,'',Vertaal('Are you sure you want to stop?'),Vertaal('YES'),Vertaal('NO'), False) then exit
                else SB_RadioRecordClick(Self);
  if pause then
             begin
              {$if not defined(HAIKU)}
               Bass_Start;
              {$ifend}
               pause:=false;
             end
           else
           begin
             {$if not defined(HAIKU)}
             pause:=Bass_Pause;
             {$ifend}
           end;

  (* Coverplayer *)
  FormCoverPlayer.ImagePauze.Visible:=pause;
  (* Coverplayer *)
end;

procedure TForm1.SB_PlayClick(Sender: TObject);
begin
  PanelVolume.Visible:=False;
  If Not EndSchedule(Self) then exit;
  if Streamsave then if not FormShowMyDialog.ShowWith(Vertaal('RECORDING'),Vertaal('A recording is active')+': '+LB_CD.Caption,'',Vertaal('Are you sure you want to stop?'),Vertaal('YES'),Vertaal('NO'),False)
                        then exit
                        else SB_RadioRecordClick(Self);
  if pause then SB_PauzeClick(Self);

  if not timer1.Enabled then  //Nothing is playing
  begin
    case PageControl1.ActivePageIndex of
      0, 1, 2: begin
                 If SG_Play.RowCount>1 then Sg_PlayDblClick(Self)
                                       else if SG_All.RowCount>1 then SG_AllDblClick(Self);;
               end;
      4: begin
            If PageControl4.ActivePageIndex=0 then StringgridRadioAirDblClick(Self);
            If PageControl4.ActivePageIndex=1 then StringgridPresetsDblClick(Self);
         end;
      5: begin
           If SG_Podcast.RowCount>1 then
           begin
              If SG_Podcast.Row<1 then SG_Podcast.Row:=1;
              SG_PodcastClick(Self);
              SG_PodcastDblClick(Self);
           end;
         end;
      7: begin
           If StringGridCD.RowCount>1 then
           begin
              StringGridCDDblClick(Self);
           end;
         end;
    end;
  end
  else
  begin
    case stream of
      1,2,3: begin
               if Settings.RepeatSong=1 then If SG_Play.RowCount+1>songrowplaying then
               begin
                  SG_Play.Row:=songrowplaying;
                  Sg_PlayDblClick(Self) ;
               end;
             end;
      4: begin
           {$if not defined(HAIKU)}
           BASS_ChannelSetAttribute(ReverseStream,BASS_ATTRIB_REVERSE_DIR,BASS_FX_RVS_FORWARD)
           {$ifend}
         end;
      10: begin
            If PageControl4.ActivePageIndex=0 then StringgridRadioAirDblClick(Self);
            If PageControl4.ActivePageIndex=1 then StringgridPresetsDblClick(Self);
          end;
      11: if Stringgrid1.RowCount>1 then StringGrid1DblClick(Self);

    end;
  end;
end;

procedure TForm1.SB_PresetsClick(Sender: TObject);
var radiovolg: string;
    i, waar: integer;
    gevonden: boolean;
begin
  If StringgridRadioAir.Row>0 then
  begin
    waar:=StringgridRadioAir.Row;
    gevonden:=false;
    radiovolg:=StringgridRadioAir.Cells[0,StringgridRadioAir.Row];
    For i:=0 to stringgridPresets.RowCount-1 do
    begin
      if StringgridPresets.Cells[0,i]=radiovolg then gevonden:=true;
    end;
    if gevonden then showmessage(Vertaal('Radiostation already in presets'))
                else
                begin
                  i:=StringgridPresets.RowCount;
                  StringgridPresets.RowCount:=i+1;
                  StringgridPresets.Cells[0,i]:=StringgridRadioAir.Cells[0,waar];
                  StringgridPresets.Cells[1,i]:=StringgridRadioAir.Cells[1,waar];
                  StringgridPresets.Cells[2,i]:=StringgridRadioAir.Cells[2,waar];
                  StringgridPresets.Cells[3,i]:=StringgridRadioAir.Cells[3,waar];
                  StringgridPresets.AutoSizeColumns;
                  showmessage(Vertaal('Added to presets')+': '+StringgridRadioAir.Cells[1,waar]);
                  SavePresets;
                end;
  end;
end;

procedure TForm1.SB_PreviousClick(Sender: TObject);
begin
  PanelVolume.Visible:=False;
  If Not EndSchedule(Self) then exit;
  if Streamsave then if not FormShowMyDialog.ShowWith(Vertaal('RECORDING'),Vertaal('A recording is active')+': '+LB_CD.Caption,'',Vertaal('Are you sure you want to stop?'),Vertaal('YES'),Vertaal('NO'), False) then exit;

  case stream of
     1: begin
          if Settings.FadeManual then
          begin
            {$if not defined(HAIKU)}
            BASS_ChannelSlideAttribute(Song_Stream1,BASS_ATTRIB_VOL,0,1000*Settings.FadeTime)
            {$ifend}
          end
           else SB_StopClick(Self);
          If songrowplaying>1 then SG_Play.Row:=songrowplaying-1
                              else SG_Play.Row:=SG_Play.RowCount-1;
          SG_playDblClick(Self);
        end;
     2: begin
          if Settings.FadeManual then
          begin
            {$if not defined(HAIKU)}
            BASS_ChannelSlideAttribute(Song_Stream2,BASS_ATTRIB_VOL,0,1000*Settings.FadeTime)
            {$ifend}
          end
           else SB_StopClick(Self);
          If songrowplaying>1 then SG_Play.Row:=songrowplaying-1
                              else SG_Play.Row:=SG_Play.RowCount-1;
          SG_playDblClick(Self);
        end;
     4: begin
          if Settings.FadeManual then
          begin
            {$if not defined(HAIKU)}
            BASS_ChannelSlideAttribute(ReverseStream,BASS_ATTRIB_VOL,0,1000*Settings.FadeTime)
            {$ifend}
          end
           else SB_StopClick(Self);
          stream:=1;
          If songrowplaying>1 then SG_Play.Row:=songrowplaying-1
                              else SG_Play.Row:=SG_Play.RowCount-1;
          SG_playDblClick(Self);
        end;
     5: begin
          If CDTrackPlaying>0 then StringgridCD.Row:=CDTrackPlaying
                              else StringgridCD.Row:=StringgridCD.RowCount-1;
          StringgridCDDblClick(Self);
        end;
     6: begin
         if PlayingFromRecorded then
            begin
             if Settings.RepeatSong=1 then
              begin
                StringgridRecordedDblClick(Self);
              end
                                     else
              begin
                if StringgridRecorded.Row>1 then
                begin
                   StringgridRecorded.Row:=StringgridRecorded.Row-1;
                   StringgridRecordedDblClick(Self);
                end
                else if Settings.RepeatSong=2 then
                begin
                  StringgridRecorded.Row:=StringgridRecorded.RowCount-1;
                  StringgridRecordedDblClick(Self);
                end;
              end
            end
                                   else
            begin
              if SG_CUE.RowCount>1 then
              begin
                dec(playingcue);

                if playingcue<1 then
                begin
                  playingcue:=1; SG_CUE.Row:=0;
                  If FilePlaying>1 then ShellListView1.ItemIndex:=ShellListView1.ItemIndex-1
                                   else ShellListView1.ItemIndex:=0;
                end
                else
                begin
                  SG_CUE.Row:=playingcue;
                  SG_CUEDblClick(Self);
                end;
              end
              else
              begin
                If FilePlaying>1 then ShellListView1.ItemIndex:=ShellListView1.ItemIndex-1
                                 else ShellListView1.ItemIndex:=0;
                ShellListView1DblClick(Self);
              end;
            end;
        end;
    10: begin
          If PageControl4.ActivePageIndex=0 then
          begin
            If StringgridRadioAir.Row>1 then StringgridRadioAir.Row:=StringgridRadioAir.Row-1
                                        else StringgridRadioAir.Row:=StringgridRadioAir.RowCount-1;
            StringgridRadioAirDblClick(Self);
          end;
          If PageControl4.ActivePageIndex=1 then
          begin
            If StringgridPresets.Row>1 then StringgridPresets.Row:=StringgridPresets.Row-1
                                       else StringgridPresets.Row:=StringgridPresets.RowCount-1;
            StringgridPresetsDblClick(Self);
          end;
        end;
    11: begin
          If Stringgrid1.Row>1 then Stringgrid1.Row:=Stringgrid1.Row-1
                               else Stringgrid1.Row:=Stringgrid1.RowCount-1;
          Stringgrid1DblClick(Self);
        end;
  end;
end;

procedure TForm1.SB_RadioAddClick(Sender: TObject);
begin
  EditRadioStation:=False;
  FormAddRadio.ShowModal;
end;

procedure TForm1.SB_RadioPlanClick(Sender: TObject);
begin
  FormPlanRecording.PageControl1.ActivePageIndex:=1;
  FormPlanRecording.showmodal;
end;

procedure TForm1.SB_RadioRecordClick(Sender: TObject);
var DateRecorded: string;
begin
    if schedulehasstarted then
    begin
      If Sender<>TimerSchedule then
      begin
        if FormShowMyDialog.ShowWith('WARNING','A scheduled recording is busy.','','DO YOU WANT TO QUIT THE RECORDING?','KEEP RECORDING','QUIT RECORDING',False) then exit
           else
           begin
             //Opname uit schedule halen
             schedulehasstarted:=false;
             FormPlanRecording.StringGrid1.Row:=1;
             FormPlanRecording.SpeedButton5Click(self);
           end;
      end;
    end;

  StreamSave:=not StreamSave;

  if Streamsave then
  begin
    if not directoryexists(Configdir+Directoryseparator+'recorded') then MkDir(Configdir+Directoryseparator+'recorded');
    dateRecorded:=FormatDateTime('YYYY.MM.DD hh.nn',now);
    recordstreamtofile:=ConfigDir+DirectorySeparator+'recorded'+DirectorySeparator+dateRecorded+' - '+LB_CD.Caption+'.mp3';

    if not ScheduleSettings.CopyRec then
    begin
      if not ScheduleSettings.DeleteAfterCopy then
      begin
        StringgridRecorded.RowCount:=StringgridRecorded.RowCount+1;
        Stringgridrecorded.Cells[0,Stringgridrecorded.RowCount-1]:=daterecorded;
        Stringgridrecorded.Cells[1,Stringgridrecorded.RowCount-1]:=LB_CD.Caption;
        StringgridRecorded.AutoSizeColumns;
      end;
    end;

    SB_RadioRecord.Font.Bold:=true;
    LB_Filename.Color:=clRed;
    LB_Filename.Caption:='RECORDING '+LB_CD.Caption;
  end
                else
   begin
      SB_RadioRecord.Font.Bold:=false;
      LB_Filename.Color:=clNone;
      LB_Filename.Caption:='Stopped RECORDING';
    end;
end;


function MySum(n: integer): integer;
var x: integer;
begin
  x:=0;
  while n>0 do
  begin
    x:=x + (n mod 10);
    n:=trunc(n/10);
  end;
  Mysum:= x;
end;

procedure TForm1.SB_ReadCDClick(Sender: TObject);
var
  {$IF defined(WINDOWS) or defined(LINUX)} info: BASS_CD_INFO; {$IFEND}
    cd_total_tracks, i, l, a, max: longint;
    cddb_id, CD_UPC, cddb_query, tags, atext, ttext, ttime, talbum, temp, tartist: string;
    t: PAnsiChar;
    lijn, cddb_Query2: String;

    gevonden: Boolean;
    TOC : Array[1..99] of string;
    LeadOut, modresult, i2: Integer;
    Filevar: TextFile;
    cdlength: longint;

  {$IFDEF HAIKU}
    AProcess: TProcess;
    AStringlist, ATocList: TStringlist;
    Mountpoint: string;
    vorigelijn: string;
  {$ENDIF}
begin
  PanelVolume.Visible:=False;
  status_CD:=1; // CD AUDIO = 1  // DVD = 2
   Memo1.Lines.Clear; ComboBox1.Items.Clear;
   StringGridCd.RowCount:=1;
  {$IFDEF HAIKU}
  if not fileexists('/bin/cdrecord') then
  begin
   // if FormShowMyDialog.ShowWith(Vertaal('INSTALLING CDRTOOLS'),Vertaal('CDRTOOLS is not installed on this system.'),Vertaal('Do you want to install CDRTOOLS?'),Vertaal('YES'),Vertaal('NO'), False)
  //      then
  //      begin
          ShowMessage('Please Install CDRTOOLS');
  //      end;
  end;
  AProcess:=TProcess.Create(nil);
  AProcess.CommandLine:='df';
  AProcess.Options:=AProcess.Options+[poWaitOnExit, poUsePipes];
  AProcess.Execute;
  AStringlist:=TStringlist.Create;
  AStringlist.LoadFromStream(AProcess.Output);
  AProcess.free;
  MountPoint:='';ModResult:=0;

  if AStringlist.Count>0 then
  begin
    lijn:='';vorigelijn:='';
    for i:=0 to AStringlist.Count-1 do
      if pos(Settings.DVDDrive ,AStringlist[i])>0 then
      begin
        lijn:=AStringlist.Strings[i];
        vorigelijn:=AStringlist.Strings[i-1];
      end;
    if lijn<>'' then
    begin
      if pos('/',trim(lijn))=1 then MountPoint:=trim(Copy(lijn,1,pos(' cdda ',lijn)-1))
                               else MountPoint:=vorigelijn;
    end;
   // Delete(lijn,1, pos('/dev/',lijn)-1);
    Memo1.Lines.Add('AudioCD mounted on'+#13+'['+Mountpoint+']');
    AProcess:=TProcess.Create(nil);
    AProcess.CommandLine:='cdrecord -toc';
    AProcess.Options:=AProcess.Options+[poWaitOnExit, poUsePipes];
    AProcess.Execute;
    ATocList:=TStringlist.Create;
    ATocList.LoadFromStream(AProcess.Output);
    i2:=0;
    for i:= 0 to AToclist.Count-1 do
    begin
      if pos('first:',AToclist[i])>0 then
      begin
        lijn:=AToclist[i]; Delete(lijn,1,pos('last',lijn)+4);
        cd_total_tracks:=strtointdef(lijn,1);
      end;
      if pos('track:',AToclist[i])>0 then
      begin
        lijn:=AToclist[i];
        Memo1.lines.Add(lijn);
        Delete(lijn,1,pos('lba',lijn)+4);
        Delete(lijn,pos(' (',lijn),50);
        Toc[i2]:=inttostr(strtoint(trim(lijn))+150);
        if pos('lout',AToclist[i])>0
          then Leadout:=strtointdef(lijn,1);

        inc(i2);
      end;
    end;
    ATocList.Free;
   // cdlength:=round((Leadout-strtointdef(Toc[1],150))/75);
    cdlength:=trunc((Leadout)/75);
    for i:= 0 to cd_total_tracks-1 do
    begin
      modresult:=modresult+MySum(trunc(strtoint(Toc[i])/75));
      //ShowMessage(toc[i]);
    end;
    modresult:=modresult mod 255;
    Memo1.lines.Add('---');
    Memo1.Lines.add('Total of tracks: '+inttostr(cd_total_tracks));
    Memo1.Lines.add('Leadout: '+inttostr(Leadout));
    Memo1.Lines.Add('Total CD length: '+inttostr(cdlength)+' (hex: '+inttohex(cdlength,4)+')');
    Memo1.Lines.Add('MOD result: '+inttostr(modresult)+' ('+inttohex(modresult,2)+')');
    cddb_id:=lowercase(inttohex(modresult,2)+inttohex(cdlength,4)+inttohex(cd_total_tracks,2));
    Memo1.Lines.Add('CDDB_id: '+cddb_id);
    cddb_query:=cddb_id+'+'+inttostr(cd_total_tracks);
    for i:= 0 to cd_total_tracks-1 do
    begin
      cddb_query:=cddb_query+'+'+Toc[i];
    end;
    cddb_query:=cddb_query+'+'+inttostr(cdlength)+'&hello=info+zittergie.be+XiX_Player+'+versie+'&proto=5';
    memo1.Lines.Add('http://freedb.freedb.org/~cddb/cddb.cgi?cmd=cddb+query+'+cddb_query);

    if DownloadFile('http://freedb.freedb.org/~cddb/cddb.cgi?cmd=cddb+query+'+cddb_query, Tempdir+DirectorySeparator+'cddb.tmp') then
        begin
          Memo1.Lines.Add('');
          Memo1.Lines.Add('CDDB_Query:');
          Memo1.Lines.Add('BEGIN');
           AssignFile(Filevar, Tempdir+DirectorySeparator+'cddb.tmp');
           Reset(Filevar);
           readln(Filevar,lijn);
           Memo1.Lines.Add(lijn);
           Combobox1.Items.Add('Reload CD');
           if pos('200',lijn)=1 then
           begin
             lijn:= copy(lijn,5, length(lijn));
             ComboBox1.Items.Add(lijn);
           end
           else
           begin
             repeat
               Readln(Filevar,lijn);
               Memo1.Lines.Add(lijn);
               if not eof(Filevar) then if (lijn<>'.') then Combobox1.Items.Add(lijn);
             until eof(Filevar);
           end;
           CloseFILE(Filevar);
           Memo1.Lines.Add('END');
        end;

  end;

  If Mountpoint='' then ShowMessage('No AudioCD found')
  else
  begin
    talbum:=trim(MountPoint);
    if pos(' - ',talbum)>1 then Delete(talbum,1,pos(' - ',talbum)+2)
                           else Delete(talbum,1,1);
    Tracksfound.Free;
    Tracksfound:=FindAllFiles(Mountpoint,'*.wav',true);
    StringgridCD.RowCount:=Tracksfound.Count+1;
    For i:=1 To Tracksfound.Count do
    begin
      l := strtoint(Toc[i])-strtoint(Toc[i-1]);
      l := round(l/75);
      CD[i].tijd:=Format('%d:%.2d', [l div 60, l mod 60]);

      StringgridCD.Cells[0,i]:=inttostr(i);
      tartist:=ExtractFilename(Tracksfound[i-1]);
      Delete(tartist,1,pos('.',tartist)+1);
      Delete(tartist,pos(' - ',tartist),length(tartist));

      StringgridCD.Cells[1,i]:=tartist;
      ttext:=ExtractFilename(Tracksfound[i-1]);
      ttext:=Copy(ttext,pos(' - ',ttext)+3,length(ttext));
      Delete(ttext,Length(ttext)-3,4);
      StringgridCD.Cells[2,i]:=ttext;
      StringgridCD.Cells[3,i]:=talbum;
      StringgridCD.Cells[4,i]:=CD[i].tijd;
      CD[i].Album:=talbum;
      CD[i].Titel:=ttext;
      CD[i].artiest:='Unknown';
      CD[i].filename:=Tracksfound.Strings[i-1];
    end;
    if ComboBox1.items.count>0 then
    begin
      Combobox1.ItemIndex:=0;
      if upcase(mountpoint)='/AUDIO CD' then Combobox1Select(Self);
    end;
  end;

  {$ENDIF}
  {$IFDEF DARWIN}
  Tracksfound.Free;
  Tracksfound:=FindAllDirectories('/Volumes', false);
  Memo1.Lines.Add(' ');
  gevonden:=false;
  if Tracksfound.Count>0 then
  begin
    i:=1;
    Repeat
      if FileExistsUTF8(Tracksfound.Strings[i-1]+'/.TOC.plist') then
      begin
        talbum:=Copy(Tracksfound.Strings[i-1],10,length(Tracksfound.Strings[i-1]));
        gevonden:=True;
        Memo1.Lines.Add('CD Found at '+Tracksfound.Strings[i-1]+' ['+talbum+']');
        AssignFile(Filevar,Tracksfound.Strings[i-1]+'/.TOC.plist');
        Reset(Filevar);
        Repeat
          Readln(Filevar,lijn);
        until (eof(Filevar)) or (pos('<key>Leadout Block</key>',lijn)>0);
        if not eof(Filevar) then
        begin
          Readln(Filevar,lijn);
          lijn:=Copy(lijn,pos('<integer>',lijn)+9,length(lijn));
          lijn:=Copy(lijn,1,pos('</integer>',lijn)-1);
          Leadout:=Strtointdef(lijn,0);
          Memo1.Lines.Add('');
          Memo1.Lines.Add('Leadout block: '+lijn);
        end;
        i2:=1; modresult:=0;
        repeat
          Repeat
            Readln(Filevar,lijn);
          until (eof(Filevar)) or (pos('<key>Start Block</key>',lijn)>0);
          if not eof(Filevar) then
          begin
            Readln(Filevar,lijn);
            lijn:=Copy(lijn,pos('<integer>',lijn)+9,length(lijn));
            lijn:=Copy(lijn,1,pos('</integer>',lijn)-1);
            Toc[i2]:=lijn;
            modresult:=modresult+MySum(round(strtoint(lijn)/75));
            Memo1.Lines.Add('Start block: '+lijn);
            inc(i2);
          end;
        until eof(Filevar);
        CloseFile(Filevar);
        Toc[i2]:=inttostr(leadout);

        modresult:=modresult;
        cdlength:=round((Leadout-strtointdef(Toc[1],0))/75);
        cd_total_tracks:=i2-1;

        Memo1.Lines.Add('');
        Memo1.Lines.Add('Total of tracks: '+inttostr(cd_total_tracks)+' ('+inttohex(cd_total_tracks,2)+')');
        Memo1.Lines.Add('Total CD length: '+inttostr(cdlength)+' ('+inttohex(cdlength,4)+')');
        Memo1.Lines.Add('MOD result: '+inttostr(modresult)+' ('+inttohex(modresult,2)+')');
        cddb_id:=lowercase(inttohex(modresult,2)+inttohex(cdlength,4)+inttohex(cd_total_tracks,2));
        Memo1.Lines.Add('CDDB_id: '+cddb_id);
        cddb_query:=cddb_id+'+'+inttostr(cd_total_tracks);
        for i:= 1 to cd_total_tracks do
        begin
          cddb_query:=cddb_query+'+'+Toc[i];
        end;
        cddb_query:=cddb_query+'+'+inttostr(cdlength)+'&hello=info+zittergie.be+XiX_Player+'+versie+'&proto=5';
        memo1.Lines.Add('http://freedb.freedb.org/~cddb/cddb.cgi?cmd=cddb+query+'+cddb_query);

        if DownloadFile('http://freedb.freedb.org/~cddb/cddb.cgi?cmd=cddb+query+'+cddb_query, Tempdir+DirectorySeparator+'cddb.tmp') then
        begin
          Memo1.Lines.Add('');
          Memo1.Lines.Add('CDDB_Query:');
          Memo1.Lines.Add('BEGIN');
           AssignFile(Filevar, Tempdir+DirectorySeparator+'cddb.tmp');
           Reset(Filevar);
           readln(Filevar,lijn);
           Memo1.Lines.Add(lijn);
           if pos('200',lijn)=1 then
           begin
             lijn:= copy(lijn,5, length(lijn));
             ComboBox1.Items.Add(lijn);
           end
           else
           begin
             repeat
               Readln(Filevar,lijn);
               Memo1.Lines.Add(lijn);
               if not eof(Filevar) then if (lijn<>'.') then Combobox1.Items.Add(lijn);
             until eof(Filevar);
           end;
           CloseFILE(Filevar);
           Memo1.Lines.Add('END');
        end;
      end;
      inc(i);
    until (i>Tracksfound.Count) or gevonden;
  end;

  if gevonden then
  begin
    Tracksfound.Free;
    Tracksfound:=FindAllFiles('/Volumes/'+talbum, '*.aiff', True);
    Memo1.Lines.Add(' ');
    Memo1.Lines.AddStrings(Tracksfound);
    StringgridCD.RowCount:=Tracksfound.Count+1;
    For i:=1 To Tracksfound.Count do
    begin
      l := strtoint(Toc[i+1])-strtoint(Toc[i]);
      l := round(l/75);
      CD[i].tijd:=Format('%d:%.2d', [l div 60, l mod 60]);

      StringgridCD.Cells[0,i]:=inttostr(i);
      StringgridCD.Cells[1,i]:='Unknown';
      ttext:=Copy(Tracksfound[i-1],9+length(talbum),length(Tracksfound[i-1]));
      if i<10 then ttext:=Copy(ttext,5,length(ttext)-9)
              else ttext:=Copy(ttext,6,length(ttext)-10);
      StringgridCD.Cells[2,i]:=ttext;
      StringgridCD.Cells[3,i]:=talbum;
      StringgridCD.Cells[4,i]:=CD[i].tijd;
      CD[i].Album:=talbum;
      CD[i].Titel:=ttext;
      CD[i].artiest:='Unknown';
      CD[i].filename:=Tracksfound.Strings[i-1];
    end;
    Combobox1.ItemIndex:=0;
  end
  else Memo1.Lines.Add(Vertaal('No CD found'));
  {$ENDIF}

  {$IF defined(WINDOWS) or defined(LINUX)}
  Combobox1.Enabled:=False;
  BASS_CD_GetInfo(0, info);
  if info.cdtext then Memo1.Lines.Add(Vertaal('CD Drive Supports CD-TEXT'))
                 else Memo1.Lines.Add(Vertaal('CD Drive does not support CD-TEXT'));
  Memo1.Lines.Add(' ');
  cd_total_tracks:=BASS_CD_GetTracks(0);
  if cd_total_tracks>0 then
  begin
    Memo1.Lines.Add('There are '+inttostr(cd_total_tracks)+' tracks on the CD');
    StringGridCD.RowCount:=cd_total_tracks+1;
    for i:=1 to cd_total_tracks do StringgridCD.Cells[0,i]:=inttostr(i);
  end
                       else Memo1.Lines.Add(Vertaal('Problem reading CD'));
  CD_UPC:=BASS_CD_GetID(0,BASS_CDID_UPC);
  if length(CD_UPC)>0 then Memo1.Lines.Add('CD UPC Code: '+CD_UPC);
  cddb_id:=BASS_CD_GetID(0,BASS_CDID_CDDB);
  if length(cddb_id)>0 then Memo1.Lines.Add(Vertaal('CDDB ID for the CD: ')+cddb_id);
  cd_text:=BASS_CD_GETID(0,BASS_CDID_TEXT);
  Memo1.Lines.Add(cd_text);
  application.ProcessMessages;

  if length(cd_text)>1 then
  begin

    SB_CDText.Visible:=True;
    Memo1.Lines.Add(' ');
    Memo1.Lines.Add(Vertaal('CD appears to have CD-Text information'));

    CDTxt:=CD;
  end
  else SB_CDText.Visible:=False;

  begin
    Memo1.Lines.Add(' ');

    cddb_query:=BASS_CD_GetID(0,BASS_CDID_CDDB_QUERY);
    if length(cddb_query)>0 then
    begin
      Memo1.Lines.Add(cddb_query);
      Combobox1.Enabled:=True;

      temp:=Copy(cddb_query,1,pos(#13,cddb_Query)-1);
      if pos('202',temp)<>1 then
      begin
       max:=cd_total_tracks -1;
        for i := 0 to  max do
         begin
           CD[i+1].Album:='Unknown';
           CD[i+1].Titel:='Unknown';
           CD[i+1].tijd:='00:00';
           CD[i+1].artiest:='Unknown';
           StringgridCD.Cells[1,i+1]:=CD[i+1].artiest;
           StringgridCD.Cells[2,i+1]:=CD[i+1].Titel;
           StringgridCD.Cells[3,i+1]:=CD[i+1].Album;
           StringgridCD.Cells[4,i+1]:=CD[i+1].tijd;
         end;
      end;
      if pos('210',temp)=1 then
      begin
        Delete(cddb_Query,1,pos(#13,cddb_Query)+1);
        Memo1.Lines.Add(Vertaal('CDDB Entry found.  If more than one CD is found, you can choose the right CD in the Dropbox'));
      end;
      i:=0;
      Repeat
        inc(i);
        temp:=Copy(cddb_query,1,pos(#13,cddb_Query)-1);
        Delete(cddb_Query,1,pos(#13,cddb_Query)+1);
        if temp<>'.' then
        begin
           Combobox1.Items.Add(temp);
        end;
      until (cddb_query='.') or (temp='.') or (i=10) or (length(cddb_query)<2);
      If Combobox1.Items.Count>0 then
      begin
        Combobox1.ItemIndex:=0;
        Combobox1Select(self);
      end;
    end;
  end;

  a := BASS_CD_StreamGetTrack(0);
  if (a <> -1) then // this drive has a stream
  begin
    StringgridCD.Row := LO(a); // select current track
   // trkPos.Max := BASS_ChannelGetLength(stream[curdrive], BASS_POS_BYTE) div 176400; // set pos scroller range
  end;
  {$IFEND}
  if StringgridCD.RowCount>1 then
  begin
    FormRip.Stringgrid1.RowCount:=StringgridCD.RowCount;
    StringgridCD.AutoSizeColumns;
    SB_RipCD.Enabled:=True;
    FormRip.LB_Album.Caption:=CD[1].Album;
    FormRip.LB_cddb.Caption:=cddb_id;
    FormRip.LB_Genre.Caption:=CD[1].genre;
  end
  else SB_RipCD.Enabled:=False;
end;

procedure TForm1.SB_ReverseClick(Sender: TObject);
var positie: longint;
begin
  {$if not defined(HAIKU)}
  PanelVolume.Visible:=False;
  Case stream of
    1,2: begin
           if stream=1 then positie:=BASS_ChannelGetPosition(Song_Stream1, BASS_POS_BYTE)
                       else positie:=BASS_ChannelGetPosition(Song_Stream2, BASS_POS_BYTE);
           SB_StopClick(SB_Reverse);
          // Streamvar:=BASS_StreamCreateFile(FALSE,pchar(utf8tosys(Liedjes[songplaying].Pad+Liedjes[songplaying].Bestandsnaam)),0,0,BASS_STREAM_DECODE);
           ReverseStream:=BASS_StreamCreateFile(FALSE,pchar(utf8tosys(Liedjes[songplaying].Pad+Liedjes[songplaying].Bestandsnaam)),0,0,BASS_STREAM_DECODE);
           ReverseStream:=BASS_FX_ReverseCreate(ReverseStream, 2, BASS_FX_FREESOURCE or BASS_STREAM_AUTOFREE);
           BASS_ChannelSetPosition(ReverseStream, positie, BASS_POS_BYTE);
           BASS_ChannelSetAttribute(ReverseStream,BASS_ATTRIB_REVERSE_DIR,BASS_FX_RVS_REVERSE);
           Stream:=4;
           FormEQ.CheckAllFX;
           BASS_ChannelPlay(ReverseStream, false);
           Timer1.Enabled:=True;
           Label34.Visible:=False; Label35.Visible:=False;Label36.Visible:=False;
         end;
    4: begin
         BASS_ChannelSetAttribute(ReverseStream,BASS_ATTRIB_REVERSE_DIR,BASS_FX_RVS_REVERSE);
       end;
    10: FormShowMyDialog.ShowWith(Vertaal('INFORMATION'),Vertaal('A Radiostream can not be played reversed.'),Vertaal('If you want to reverse a Radiostream, you will have to record it first'),'','',Vertaal('OK'), False);
    11: FormShowMyDialog.ShowWith(Vertaal('INFORMATION'),Vertaal('A Podcast can not be played reversed.'),Vertaal('If you want to reverse a Podcast, you will have to download it first'),'','',Vertaal('OK'), False);
  end;
  {$ifend}
end;

procedure TForm1.RipDVDTrack(x: integer);
var
    MemStream: TMemoryStream;
    OurProcess: TProcess;
    NumBytes: LongInt;
    BytesRead: LongInt;
    track: byte;
    templijn1, templijn2: string;
    i: integer;
begin
    templijn1:='';
    MemStream := TMemoryStream.Create;
    BytesRead := 0;
    templijn2:=StringgridCD.Cells[4,x+1];
    For i:=1 to length(templijn2) do if (templijn2[i]<>':') then templijn1:=templijn1+templijn2[i];
    Formrip.ProgressbarRip.Max:=strtointdef(templijn1,300)*19;
    OurProcess := TProcess.Create(nil);
    OurProcess.Options := [poUsePipes];

    if x=0 then OurProcess.CommandLine := Settings.Mplayer+' -vo null -ao pcm:file='+TempDir+DirectorySeparator+'Track_'+inttostr(x+1)+'.wav dvd://'+selectedchapter+' -chapter 0-1'
           else OurProcess.CommandLine := settings.Mplayer+' -vo null -ao pcm:file='+TempDir+DirectorySeparator+'Track_'+inttostr(x+1)+'.wav dvd://'+selectedchapter+' -chapter '+inttostr(x+1)+'-'+inttostr(x+1);
    {$IFDEF UNIX}
        if x=0 then OurProcess.CommandLine := Settings.Mplayer+' -vo null -ao pcm:file='+TempDir+DirectorySeparator+'Track_'+inttostr(x+1)+'.wav dvd://'+selectedchapter+' -chapter 0-1 -dvd-device '+Settings.DVDDrive
               else OurProcess.CommandLine := settings.Mplayer+' -vo null -ao pcm:file='+TempDir+DirectorySeparator+'Track_'+inttostr(x+1)+'.wav dvd://'+selectedchapter+' -chapter '+inttostr(x+1)+'-'+inttostr(x+1) +' -dvd-device '+Settings.DVDDrive;
    {$ENDIF}
    MeMo1.Lines.Add('cmd='+OurProcess.CommandLine);
    {$IFDEF WINDOWS}
      if x=0 then OurProcess.CommandLine := Settings.Mplayer+' -vo null -ao pcm:file=\"'+TempDir+DirectorySeparator+'Track_'+inttostr(x+1)+'.wav\" dvd://'+selectedchapter+' -chapter 0-1'+dvdLetter
             else OurProcess.CommandLine := Settings.Mplayer+' -vo null -ao pcm:file=\"'+TempDir+DirectorySeparator+'Track_'+inttostr(x+1)+'.wav\" dvd://'+selectedchapter+' -chapter '+inttostr(x+1)+'-'+inttostr(x+1)+dvdLetter;
      OurProcess.Options:=OurProcess.Options+[poNoConsole];
    {$ENDIF}
    OurProcess.Execute;

    while OurProcess.Running do
    begin
      MemStream.SetSize(BytesRead + READ_BYTES);
      NumBytes := OurProcess.Output.Read((MemStream.Memory + BytesRead)^, READ_BYTES);

      if NumBytes > 0 then
                        begin
                          Inc(BytesRead, NumBytes);
                          Formrip.ProgressbarRip.Position:=FormRip.ProgressbarRip.Position+1;
                          if Formrip.ProgressbarRip.Position>=Formrip.ProgressbarRip.Max then Formrip.ProgressbarRip.Position:=1;
                          application.ProcessMessages;
                        end
                      else Sleep(100);
    end;
    repeat
      MemStream.SetSize(BytesRead + READ_BYTES);
      NumBytes := OurProcess.Output.Read((MemStream.Memory + BytesRead)^, READ_BYTES);
      if NumBytes > 0 then
                          begin
                            Inc(BytesRead, NumBytes);
                          //  write('*');
                          end;
    until NumBytes <= 0;
  //  if BytesRead > 0 then WriteLn;
    MemStream.SetSize(BytesRead);

    OurProcess.Free;
    MemStream.Free;

    Memo1.Lines.Add(inttostr(x+1)+' Ripped');
    Application.ProcessMessages;
    encode(x);
end;

procedure TForm1.SB_RipCDClick(Sender: TObject);
var i, max: byte;
    isvarious, isingevuld: boolean;
    vorigeartiest: string;
begin
  PanelVolume.Visible:=False;  isingevuld:=true;
  max:=Stringgridcd.RowCount-1;  isvarious:=false;
  for i:=1 to max do
  begin
    if (Stringgridcd.Cells[1,i]='') or (Stringgridcd.Cells[2,i]='') then
    begin
     isingevuld:=false;
     break;
    end;
  end;
  if not isingevuld then showmessage(Vertaal('You did not fill in all the Artist & Title fields'));

  vorigeartiest:=Stringgridcd.Cells[1,1];

   If Settings.EncodingTargetFolder='' then
   begin
    ShowMessage(Vertaal('No target folder is selected, please select a target folder'));
    FormConfig.PageControl1.PageIndex:=6;
    Form1.SB_ConfigClick(Self);
   end
   else
   begin
    max:=Stringgridcd.RowCount-2;
    for i:=0 to max do
    begin
      CD[i+1].artiest:=Stringgridcd.Cells[1,i+1];
      CD[i+1].Titel:=Stringgridcd.Cells[2,i+1];
      CD[i+1].Album:=Stringgridcd.Cells[3,i+1];
      if length(Stringgridcd.Cells[5,i+1])>0 then CD[i+1].jaartal:=Stringgridcd.Cells[5,i+1];
      if length(Stringgridcd.Cells[6,i+1])>0 then CD[i+1].genre:=Stringgridcd.Cells[6,i+1];
      if vorigeartiest<>CD[i+1].artiest then isvarious:=true;
    end;
    ripping:=true;
    If stream=3 then SB_StopClick(self);
    if isvarious then
    begin
      Formrip.RB_Varia.Checked:=True;
      FormRip.LB_Artist.Caption:='Various artists';
      FormRip.CB_Various.Checked:=True;
    end
                 else
    begin
      FormRip.RB_Artist.Checked:=True;
      FormRip.LB_Artist.Caption:=CD[1].artiest;
      FormRip.CB_Various.Checked:=False;
    end;
    FormRip.StringGrid1.Rowcount:=StringgridCD.Rowcount;
    FormRip.ShowModal;
    ripping:=false;
   end;
end;

procedure TForm1.SB_StopClick(Sender: TObject);
begin

  PanelVolume.Visible:=False;
  If Not EndSchedule(Self) then exit;
  CDTrackPlaying:=1;

  if Streamsave then if not FormShowMyDialog.ShowWith(Vertaal('RECORDING'),Vertaal('A recording is active')+': '+LB_CD.Caption,'',Vertaal('Are you sure you want to stop?'),Vertaal('YES'),Vertaal('NO'), False)
                        then exit
                        else SB_RadioRecordClick(Self);
  {$if not defined(HAIKU)}
  Case Stream of
    1: begin
         BASS_ChannelStop(Song_Stream1);
         BASS_ChannelStop(Song_Stream2);
       end;
    2: begin
         BASS_ChannelStop(Song_Stream2);
         BASS_ChannelStop(Song_Stream1);
       end;
    4: begin
         BASS_ChannelStop(StreamVar); BASS_StreamFree(StreamVar);
         BASS_ChannelStop(Reversestream); BASS_StreamFree(ReverseStream);
         BASS_ChannelStop(Song_Stream2);
         BASS_ChannelStop(Song_Stream1);
       end;
    5: BASS_ChannelStop(CDStream);
    6: BASS_ChannelStop(Song_Stream1);
    10,11: begin
                BASS_ChannelStop(RadioStream);
                BASS_StreamFree(RadioStream);
              end;
  end;
  {$ifend}
  if sender=SB_Reverse then exit;

  elapsed_bytes:=0; Trackbar2.Position:=0; Stream:=1;
  LB_Titel.Caption:='--'; LB_Artiest.Caption:='--'; LB_CD.Caption:='--'; LB_On.Visible:=False;
  LabelTime.Caption:='0:00:00'; isplayingsong:=false; SB_RadioRecord.Enabled:=false;

  timer1.Enabled:=False; TrackBar2.Style:=pbstNormal;

end;

function TForm1.EndSchedule(Sender: Tobject): Boolean;
begin
  EndSchedule:=False;
  if schedulehasstarted then
    begin
      If Sender<>TimerSchedule then
      begin
        if FormShowMyDialog.ShowWith(Vertaal('WARNING'),Vertaal('A scheduled recording is busy.'),'',Vertaal('DO YOU WANT TO QUIT THE RECORDING?'),Vertaal('KEEP RECORDING'),Vertaal('QUIT RECORDING'),false) then exit
           else
           begin
            SB_RadioRecordClick(TimerSchedule);  // ActionStop Recording
            schedulehasstarted:=false;
            FormPlanRecording.StringGrid1.Row:=1;       // Remove from schedule
            FormPlanRecording.SpeedButton5Click(self);
            EndSchedule:=True;
           end;
      end;
    end
  else EndSchedule:=True;
end;

procedure TForm1.SavePresets;
var Filevar: TextFile;
    i: integer;
begin
  AssignFile(Filevar,ConfigDir+DirectorySeparator+'radio'+DirectorySeparator+'presets');
  Rewrite(Filevar);
  for i:=1 to StringgridPresets.RowCount-1 do Writeln(Filevar,StringgridPresets.Cells[0,i]);
  CloseFile(Filevar);
end;

procedure TForm1.SG_AllClick(Sender: TObject);
begin
  PanelVolume.Visible:=False;
  if SG_All.RowCount>1 then LB_Filename.Caption:=GetGridFileName(SG_ALL.Row)
                       else LB_Filename.Caption:='';
  LB_Filename.Tag := 1;
end;

Procedure TForm1.AutoSizePlayColumns;
var i: integer;
begin
   If settings.ShowAllColums then
                              begin
                                SG_Play.AutoSizeColumns;
                                // TODO:  Better Calculation
                                i:=round(PageControl2.Width/3.7);
                                if i<SG_Play.ColWidths[1] then SG_Play.ColWidths[1]:= round(Pagecontrol2.Width/3.7);
                                if i<SG_Play.ColWidths[3] then SG_Play.ColWidths[3]:= round(PageControl2.Width/3.6);
                                if i<SG_Play.ColWidths[4] then SG_Play.ColWidths[4]:= round(Pagecontrol2.Width/3.5);
                              end
                            else SG_Play.AutoSizeColumns;
   SG_Play.ColWidths[6]:=0;   // Hide Column 7
end;

procedure TForm1.SG_AllDblClick(Sender: TObject);
var i, max: longint;
begin
 if SG_All.RowCount>1 then
 begin
  SG_Play.BeginUpdate;

  SG_Play.RowCount:=SG_All.RowCount;
  ClearGridSelection(SG_Play, false);

  max:=SG_all.RowCount-1;
  For i:=1 to max do
    begin
        SG_Play.Cells[1,i]:=SG_All.Cells[1,i];
        SG_Play.Cells[2,i]:=SG_All.Cells[2,i];
        SG_Play.Cells[3,i]:=SG_All.Cells[3,i];
        SG_Play.Cells[4,i]:=SG_All.Cells[4,i];
        SG_Play.Cells[5,i]:=Liedjes[strtointdef(SG_All.Cells[0,i],1)].Jaartal;
        SG_Play.Cells[6,i]:=SG_All.Cells[0,i];
    end;

  if fullrandom then if Settings.Shuffle then SG_All.Row:=random(SG_All.Rowcount-1)+1
                                         else SG_All.Row:=1;

  SG_Play.Row:=SG_All.Row;  songrowplaying:=SG_All.Row;
  SG_Play.EndUpdate(True);

  SG_PlayDblClick(Self);

  AutoSizePlayColumns;

  {$IFDEF DONT_SHOW_PLAY_ON_FILES_DBLCLICK}
  {$ELSE}
    PageControl2.PageIndex:=1; // Show SG_Play
  {$ENDIF}
  SongsInPlayingQueue:=SG_Play.RowCount-1;
  SG_Play.Cells[0,songrowplaying]:='»';

  if Settings.Shuffle then
  begin
    Setlength(OrigineleVolgorde,SG_Play.RowCount); Application.ProcessMessages;
    for i:=1 to SG_Play.RowCount-1 do OrigineleVolgorde[i]:=strtoint(SG_Play.Cells[6,i]);
    MI_ReshuffleClick(Self);
    SG_Play.Row:=1;
    SG_Play.TopRow:=1;
  end;
 end;
end;

procedure TForm1.SG_AllMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
end;

procedure TForm1.SG_PlayClick(Sender: TObject);
var x: longint;
begin
  PanelVolume.Visible:=False;
  x:=strtoint(SG_Play.Cells[6,SG_play.Row]);
  LB_Filename.Caption:=Liedjes[x].Pad+Liedjes[x].Bestandsnaam;
  LB_Filename.Tag:=2;
end;

procedure TForm1.SB_NewClick(Sender: TObject);
var olditems: longint;
begin
  modespeellijst:=1; //NIEUW
  olditems:=LB_Playlist.Items.Count;
  FormNewPlaylist.ShowModal;

  if olditems<LB_playlist.Items.Count then
  begin
   SubItem:= TMenuItem.Create(PM_SGAll);
   Subitem.OnClick:=@OnSubItemHasClick;
   SubItem.Caption:=FormNewPlaylist.Edit1.Text;
   PM_SGAll.Items[7].Add(SubItem);
   SubItem:= TMenuItem.Create(PM_Play);
   Subitem.OnClick:=@OnSubItem2HasClick;
   SubItem.Caption:=FormNewPlaylist.Edit1.Text;
   PM_Play.Items[9].Add(SubItem);
   MI_AddToPlaylist1.Enabled:=True;
   MI_RemoveFromPlaylist.Enabled:=True;
   MI_AddToPlaylist2.Enabled:=True;
  end;
  // Popup menu aanpassen
end;

procedure TForm1.SB_RenameClick(Sender: TObject);
var i : longint;
begin
  if LB_Playlist.ItemIndex<0 then ShowMessage(Vertaal('Please select the Playlist you want to rename'))
    else
    begin
      modespeellijst:=3; //RENAME
      FormNewPlaylist.Edit1.Text:=LB_Playlist.Items[LB_Playlist.ItemIndex];
      FormNewPlaylist.ShowModal;

      PM_SGAll.Items[7].Clear; PM_Play.Items[8].Clear;
      for i:=0 to LB_Playlist.Items.Count-1 do
      begin
        SubItem:= TMenuItem.Create(PM_SGAll);
        Subitem.OnClick:=@OnSubItemHasClick;
        SubItem.Caption:=  LB_Playlist.Items[i];
        PM_SGAll.Items[7].Add(SubItem);
        SubItem:= TMenuItem.Create(PM_Play);
        Subitem.OnClick:=@OnSubItem2HasClick;
        SubItem.Caption:= LB_Playlist.Items[i];
        PM_Play.Items[8].Add(SubItem);
      end;
    end;
end;


procedure TForm1.SB_CopyClick(Sender: TObject);
var olditems: longint;
begin
  if LB_Playlist.ItemIndex<0 then ShowMessage(Vertaal('Please select the Playlist you want to copy'))
    else
    begin
      modespeellijst:=2; //COPY
      olditems:=LB_Playlist.Items.Count;
      FormNewPlaylist.Edit1.Text:=LB_Playlist.Items[LB_Playlist.ItemIndex]+' (copy)';
      FormNewPlaylist.ShowModal;

      if olditems<LB_playlist.Items.Count then
      begin
        SubItem:= TMenuItem.Create(PM_SGAll);
        Subitem.OnClick:=@OnSubItemHasClick;
        SubItem.Caption:= FormNewPlaylist.Edit1.Text;
        PM_SGAll.Items[7].Add(SubItem);
        SubItem:= TMenuItem.Create(PM_Play);
        Subitem.OnClick:=@OnSubItem2HasClick;
        SubItem.Caption:=FormNewPlaylist.Edit1.Text;
        PM_Play.Items[8].Add(SubItem);
      end;
    end;
end;

procedure TForm1.SB_DeleteClick(Sender: TObject);
var i: longint;
begin
  if LB_Playlist.ItemIndex>=0 then
  begin
    if FormShowMyDialog.ShowWith(Vertaal('Warning'),Vertaal('Delete Playlist'),LB_Playlist.Items[LB_Playlist.ItemIndex],Form1.Vertaal('ARE YOU SURE?'),Form1.Vertaal('YES'),Form1.Vertaal('NO'), False) then
    begin
      PM_SGAll.Items[7].Clear; PM_Play.Items[8].Clear;
      DeleteFile(Configdir+DirectorySeparator+'playlist'+DirectorySeparator+LB_Playlist.Items[LB_Playlist.ItemIndex]+'.xix');
      LB_Playlist.Items.Delete(LB_Playlist.ItemIndex);
      If LB_Playlist.Items.Count>0 then
      begin
        MI_AddToPlaylist1.Enabled:=True;
        LB_Playlist.ItemIndex:=0;
        LB_PlaylistClick(Self);
        for i:=0 to LB_Playlist.Items.Count-1 do
        begin
          SubItem:= TMenuItem.Create(PM_SGAll);
          Subitem.OnClick:=@OnSubItemHasClick;
          SubItem.Caption:= LB_PlayList.Items[i];
          PM_SGAll.Items[7].Add(SubItem);
          SubItem:= TMenuItem.Create(PM_Play);
          Subitem.OnClick:=@OnSubItem2HasClick;
          SubItem.Caption:= LB_PlayList.Items[i];
          PM_Play.Items[8].Add(SubItem);
        end;
      end
      else
      begin
        SG_All.RowCount:=1;
        MI_AddToPlaylist1.Enabled:=False;
      end;
    end;
  end;
end;

procedure TForm1.SG_PlayColRowMoved(Sender: TObject; IsColumn: Boolean; sIndex,
  tIndex: Integer);
begin
  if sindex>0 then
  begin
    if sindex=songrowplaying then
    begin
      songrowplaying:=tindex;
    end
                          else
    begin
      if (sindex>songrowplaying) and (tindex<=songrowplaying) then inc(songrowplaying)
         else if (sindex<songrowplaying) and (tindex>=songrowplaying) then dec(songrowplaying);
    end;
  end;
end;

procedure TForm1.SG_PlayDblClick(Sender: TObject);
begin
 if SG_Play.RowCount>1 then
 begin
  {$if not defined(HAIKU)}
  if stream=1 then
  begin
    if Settings.FadeManual then BASS_ChannelSlideAttribute(Song_Stream1,BASS_ATTRIB_VOL,0,1000*Settings.FadeTime)
                           else SB_StopClick(Self);
  end;
  if stream=2 then
  begin
    if Settings.FadeManual then BASS_ChannelSlideAttribute(Song_Stream2,BASS_ATTRIB_VOL,0,1000*Settings.FadeTime)
                           else SB_StopClick(Self);
  end;
  if stream=4 then SB_StopClick(Self);
  if stream=5 then SB_StopClick(Self);
  if stream>9 then
  begin
    if Settings.FadeManual then BASS_ChannelSlideAttribute(RadioStream,BASS_ATTRIB_VOL,0,1000*Settings.FadeTime)
                           else SB_StopClick(Self);
  end;
  {$ifend}
  Play(strtoint(SG_Play.Cells[6,SG_Play.Row]));
 end;
end;

procedure TForm1.SG_PlayHeaderClick(Sender: TObject; IsColumn: Boolean;
  Index: Integer);
const
  LastSortedColumn:Integer=-1;
var
  SortedColumn: Integer;
begin
  if not settings.Shuffle then
  begin
    if Index>0 then
      SortedColumn := Index
    else
      SortedColumn := 6;
    if LastSortedColumn<>SortedColumn then
      SG_Play.SortOrder := soAscending
    else
    if SG_Play.SortOrder=soDescending then SG_Play.SortOrder:=soAscending
                                      else SG_Play.SortOrder:=soDescending;
    SG_Play.SortColRow(true, SortedColumn);
    LastSortedColumn := SortedColumn;
  end
  else if settings.Shuffle then ShowMessage(Vertaal('SORT is not allowed when SHUFFLE is active.')+#13+Vertaal('First deactivate SHUFFLE.'));
end;

procedure TForm1.SB_RadioUpdateClick(Sender: TObject);
var Filevar: tEXTfILE;
    i, i2, welke: integer;
    lijn: string;
    sl : TStringList;
    AProcess: TProcess;
    Doorgaan: Boolean=False;
    cmd: string;
begin
 // sl:=TStringlist.create;
 //  HttpGetText('http://www.xixmusicplayer.org/download/radio.lst',sl);
//   showmessage(sl.text);
//   sl.free;

   if DownloadFile('http://www.xixmusicplayer.org/download/radio.lst',Settings.cacheDirRadio+'radio.lst')
    then
    begin
      I:=0;
      AssignFile(Filevar,Settings.cacheDirRadio+'radio.lst');
      Reset(Filevar);
      Repeat
        Readln(Filevar,lijn);
        if not eof(Filevar) then
        begin
          inc(i); welke:=strtoint(lijn);
          StringgridRadioAir.RowCount:=i+1;
          StringgridRadioAir.Cells[0,i]:=lijn;
          RadioStation[welke].internalnr:=lijn;
          Readln(Filevar,lijn); Radiostation[welke].naam:=lijn;
          StringgridRadioAir.Cells[1,i]:=lijn;
          Readln(Filevar,lijn); Radiostation[welke].land:=lijn;
          StringgridRadioAir.Cells[2,i]:=lijn;
          Readln(Filevar,lijn); Radiostation[welke].genres:=lijn;
          StringgridRadioAir.Cells[3,i]:=lijn;
          Readln(Filevar,lijn); Radiostation[welke].website:=lijn;
          Readln(Filevar,lijn); Radiostation[welke].logo1:=lijn;
          Readln(Filevar,lijn);
          Readln(Filevar,lijn); Radiostation[welke].link:=lijn;
          Readln(Filevar,lijn); Radiostation[welke].volgorde:=lijn[1];
          Readln(Filevar,lijn);
        end;
      until eof(Filevar);
      CloseFile(Filevar);
      internalradio:=i;
    If FileExistsUTF8(Settings.cacheDirRadio+'radio.prs') then
    begin
      I2:=2000;
      FormSplash.Label1.Caption:=Vertaal('Loading online radio listing')+' ...';
      Application.ProcessMessages;
      AssignFile(Filevar,Settings.cacheDirRadio+'radio.prs');
      Reset(Filevar);
      Repeat
        Readln(Filevar,lijn);
        if not eof(Filevar) then
        begin
          inc(i); inc(i2); StringgridRadioAir.RowCount:=i+1;
          StringgridRadioAir.Cells[0,i]:=inttostr(i2);
          RadioStation[i2].internalnr:=lijn;
          Readln(Filevar,lijn); Radiostation[i2].naam:=lijn;
          StringgridRadioAir.Cells[1,i]:=lijn;
          Readln(Filevar,lijn); Radiostation[i2].land:=lijn;
          StringgridRadioAir.Cells[2,i]:=lijn;
          Readln(Filevar,lijn); Radiostation[i2].genres:=lijn;
          StringgridRadioAir.Cells[3,i]:=lijn;
          Readln(Filevar,lijn); Radiostation[i2].website:=lijn;
          Readln(Filevar,lijn); Radiostation[i2].logo1:=lijn;
          Readln(Filevar,lijn);
          Readln(Filevar,lijn); Radiostation[i2].link:=lijn;
          Readln(Filevar,lijn); Radiostation[i2].volgorde:=lijn[1];
          Readln(Filevar,lijn);
        end;
      until eof(Filevar);
      CloseFile(Filevar);
      personalradio:=i2;
    end;
  end;
end;

procedure TForm1.SG_PlayMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  SourceCol, SourceRow: Integer;
begin
  if Button = mbLeft then
  begin
    SG_Play.MouseToCell(X, Y, SourceCol, SourceRow);
    startrij:=Sourcerow;
    if (SourceCol > 0) and (SourceRow > 0) then SG_Play.BeginDrag(false,4);
  end;
end;

procedure TForm1.SpeedButton10Click(Sender: TObject);
begin
  VolumeBar.Position:=VolumeBar.Position+VolumeBar.Frequency;
  {$if not defined(HAIKU)}
  BASS_SetVolume(volumeBar.Position/100);
  {$ifend}
end;

procedure TForm1.SpeedButton11Click(Sender: TObject);
begin
  VolumeBar.Position:=VolumeBar.Position-VolumeBar.Frequency;
 // BASS_SetVolume(volumeBar.Position/100);
end;

procedure TForm1.SpeedButton12Click(Sender: TObject);
{$IFDEF UNIX}
var cmd: string;
    AProcess: TProcess;
{$ENDIF}
begin
 // BASS_ChannelStop(cdstream);
  Memo1.Lines.Clear;
  Memo1.Lines.Add('Trying to eject the CD');
  Memo1.Lines.Add('To read the CD Information press the CD Button');
  StringgridCD.RowCount:=1;
  SB_RipCD.Enabled:=False; SB_CDText.Visible:=False;
  ComboBox1.Items.Clear;

  {$IFDEF WINDOWS}
    if (BASS_CD_DoorIsOpen(0) = True) then BASS_CD_Door(0, BASS_CD_DOOR_CLOSE)
                                      else BASS_CD_Door(0, BASS_CD_DOOR_OPEN);
  {$IFEND}
  {$IFDEF UNIX}
  cmd:='eject';
  {$IFDEF DARWIN} cmd:='drutil tray eject'; {$ENDIF}
  AProcess := TProcess.Create(nil);
  try
    AProcess.CommandLine := cmd;
    AProcess.Execute;
  except
    ShowMessage(Vertaal('EJECT command not found'));
  end;
  AProcess.Free;
  {$ENDIF}
end;

procedure TForm1.PlayPodcast(url: string);
var len: integer;
begin
  MenuItem88.Enabled:=false; MI_CDCover_ChooseNewFile.Enabled:=False; MI_CDCover_RemoveCDCover.Enabled:=False;
  MI_GetArtworkFromFile.Enabled:=False;
  SB_StopClick(self); elapsed:=False; SB_RadioRecord.Enabled:=false;
  LabelTime.Caption:='0:00:00';

  {$if not defined(HAIKU)}
  RadioStream := BASS_StreamCreateURL(pchar(url), 0, BASS_STREAM_STATUS, NIL, NIL);
  stream:=11;
  len:=BASS_StreamGetFilePosition(Radiostream, BASS_FILEPOS_END);
  TrackBar2.Step:=len div 100;
  Trackbar2.Max:=len*8; FormCoverPlayer.ProgressBar1.MaxValue:=Trackbar2.Max;
  FormEQ.CheckAllFX;
  BASS_ChannelPlay(radiostream, False);
  {$ifend}
  Timer1.Enabled:=True;
  MemoLyrics.Lines.Clear;
  LB_Titel.Caption:='PODCAST'; Label_Extra.Caption:=''; LB_CD.Caption:='';
  LB_Artiest.Caption:=Label19.Caption;
  LB_ArtiestResize(Self);
  LB_On.Visible:=False;
  FormCoverPlayer.LabelLyrics.Caption:='';
  UpdateMediaMode;
  TrackBar2.Style:=pbstNormal;
  Label34.Visible:=False; Label35.Visible:=False;Label36.Visible:=False;
  Label35.Caption:='100'; ProgressBarSpeed.Value:=0;
end;

procedure TForm1.SpeedButton14Click(Sender: TObject);
var aantal: integer;
begin
  FormNieuwePodcast.ShowModal;
  if FormNieuwePodcast.Edit1.Text<>'' then
  begin
    aantal:=SG_Podcast.RowCount;
    SG_Podcast.RowCount:=aantal+1;
    SG_Podcast.Cells[0,aantal]:='EDIT NAME';
    SG_Podcast.Cells[1,aantal]:=FormNieuwePodcast.Edit1.Text;
 //  Listbox2.Items.Add(FormNieuwePodcast.Edit1.Text);
 //  Listbox2.Items.SaveToFile(Configdir+Directoryseparator+'podcast');
  end;
end;

procedure TForm1.SB_ReloadPlaylistClick(Sender: TObject);
begin
  SB_ReloadPlaylist.Caption:=Form1.Vertaal('Searching for M3U playlists');
  SB_ReloadPlaylist.Enabled:=False;
  M3UFilesFound.Clear; PlayListsFound.Clear;
  ThreadPlaylist:=TSearchForPlaylistThread.Create(True);
  ThreadPlayList.FreeOnTerminate := true;
  ThreadPlayList.Start;
end;

procedure TForm1.SpeedButton16Click(Sender: TObject);
var waar: integer;
begin
  waar:=LB_M3U.ItemIndex;
  if waar>=0 then
  begin
    if FileExistsUTF8(M3UFilesFound.Strings[LB_M3U.ItemIndex]) then
    begin
      if FormShowMyDialog.ShowWith(Vertaal('WARNING'),Vertaal('Delete file')+':',M3UFilesFound.Strings[LB_M3U.ItemIndex],Form1.Vertaal('ARE YOU SURE?'),Form1.Vertaal('YES'),Form1.Vertaal('NO'), False)
        then
          begin
            DeleteFile(M3UFilesFound.Strings[LB_M3U.ItemIndex]);
            M3UFilesFound.Delete(LB_M3U.ItemIndex);
            LB_M3U.Items.Delete(LB_M3U.ItemIndex);
            If waar>LB_M3U.Items.Count-1 then dec(waar);
            LB_M3U.ItemIndex:=waar;
          end;
    end;
  end;
end;

procedure TForm1.SpeedButton17Click(Sender: TObject);
var gevonden, InGenre: boolean;
    i, i2, jaar, aantalgetoonde: longint;
    GenreList: TstringList;
begin
  Cursor:=CrHourGlass; Application.ProcessMessages;
  SB_Save.Enabled:=False;
  GenreList:=TStringList.Create;
  GenreList.CommaText:=Upcase(CB_Genre.Text);

   SG_All.RowCount:=1;
   PageControl2.ActivePageIndex:=0;
   i:=0; aantalgetoonde:=0;
   repeat
     inc(i); gevonden:=true;
     if Liedjes[i].Beoordeling<aantalsterren then gevonden:=false;
     If CB_Year.Checked then
     begin
       jaar:=Strtointdef(Liedjes[i].Jaartal,0);
        If (Jaar<SE_Jaar1.Value) or (Jaar>SE_Jaar2.Value) then gevonden:=false;
     end;

     if gevonden then
     begin
      if (Checkbox1.Checked) then
      begin
        InGenre:=False;
        for i2:=0 to GenreList.Count-1 do
          if pos(GenreList.Strings[i2],upcase(Liedjes[i].Genre))>0 then InGenre:=True;
        if not InGenre then gevonden:=false;
      end;

     end;

     if gevonden then
     begin
       inc(aantalgetoonde);
       SG_All.RowCount:=aantalgetoonde+1;
       SG_All.Cells[0,aantalgetoonde]:=Inttostr(i);
       SG_All.Cells[1,aantalgetoonde]:=Liedjes[i].Artiest;
       if Liedjes[i].Track=0 then SG_All.Cells[2,aantalgetoonde]:=''
                             else SG_All.Cells[2,aantalgetoonde]:=inttostr(Liedjes[i].Track);
       SG_All.Cells[3,aantalgetoonde]:=Liedjes[i].Titel;
       SG_All.Cells[4,aantalgetoonde]:=Liedjes[i].CD;
       SG_All.Cells[COL_SG_ALL_PATH,aantalgetoonde]:=Liedjes[i].Pad;
       SG_All.Cells[COL_SG_ALL_NAME,aantalgetoonde]:=Liedjes[i].Bestandsnaam;
     end;
   until (i=maxsongs-1);
   GenreList.Free;
   AutoSizeAllColumns;
   Cursor:=CrDefault;
end;

procedure TForm1.SpeedButton18Click(Sender: TObject);
var goed: Boolean;
    lijn, lijn2: String;
    i, teller: integer;
begin
  lijn2:=Upcase(Edit1.Text); teller:=0;
  For i:=1 to 2200 do
  begin
    if length(RadioStation[i].naam)>0 then
    begin
      goed:=true;
      lijn:=upcase(RadioStation[i].naam+RadioStation[i].genres+Radiostation[i].land+Radiostation[i].website);
      if CB_Land.Checked then if RadioStation[i].land<>LB_Land.Text then goed:=false;
      if CB_GenreRadio.Checked then if Pos(LB_GenreRadio.Text,RadioStation[i].genres)<1 then goed:=false;
      If length(edit1.Text)>0 then If (Pos(lijn2,lijn)<1) then goed:=false;
      if goed then
      begin
        inc(teller);
        StringgridRadioAir.RowCount:=teller+1;
        StringgridRadioAir.Cells[0,teller]:=RadioStation[i].internalnr;
        StringgridRadioAir.Cells[1,teller]:=RadioStation[i].naam;
        StringgridRadioAir.Cells[2,teller]:=RadioStation[i].land;
        StringgridRadioAir.Cells[3,teller]:=RadioStation[i].genres;
      end;
    end;
  end;
  StringgridRadioAir.AutoSizeColumns;
end;

procedure TForm1.SpeedButton19Click(Sender: TObject);
begin
  PanelVolume.Visible:=False;
  If Panel7.height<100 then Panel7.Height:=132
                       else Panel7.Height:=Label13.Height+1;
end;

procedure TForm1.SpeedButton1Click(Sender: TObject);
begin
  SetFullscreen;
end;

procedure TForm1.SpeedButton20Click(Sender: TObject);
var I: integer;
begin
  If stringgridPresets.RowCount>1 then
    begin
      i:=StringgridPresets.Row;
      If i>1 then stringgridPresets.MoveColRow(False,i,i-1);
      SavePresets;
    end;
end;


procedure TForm1.SpeedButton22Click(Sender: TObject);
begin
  If panel9.height<100 then Panel9.Height:=112
                       else Panel9.Height:=LB_Search1.Height+1;
end;

procedure TForm1.SpeedButton26Click(Sender: TObject);
begin
  (*If Listbox2.ItemIndex>-1 then
  begin
   Listbox2.Items.Delete(Listbox2.ItemIndex);
   Listbox2.Items.SaveToFile(Configdir+Directoryseparator+'podcast');
  end; *)
  if SG_Podcast.Row>0 then
  begin
    SG_Podcast.DeleteRow(SG_Podcast.Row);
    SB_PodcastSaveClick(Self);
  end;
end;

procedure TForm1.GetPodCast(x: Integer;podcasttitle: string);
var
  Filevar: textFile;
  ident, value, lijn, temp: string;
  i: integer;
  doorgaan: boolean;
begin
  i:=0;
  AssignFile(Filevar,Tempdir+DirectorySeparator+'podcast.tmp');
  Reset(Filevar);
  Repeat
    Readln(Filevar,lijn);
  until (pos('<channel>',lijn)>0) or eof(Filevar);
  if not eof(filevar) then
  begin
   // CHANNEL INFO
   Repeat
    Readln(Filevar,lijn);
    if length(lijn)>0 then
    begin
      doorgaan:=true;
      if pos('<itunes:image',lijn)>0 then
      begin
       ident:='itunes:image';
       podcast.itunes_img:=lijn;delete(podcast.itunes_img,1,pos('ref="',podcast.itunes_img)+4);//
       podcast.itunes_img:=stringreplace(podcast.itunes_img,'"/>','',[rfReplaceAll, rfIgnoreCase]);
       podcast.itunes_img:=stringreplace(podcast.itunes_img,'" />','',[rfReplaceAll, rfIgnoreCase]);
      // openurl(podcast.itunes_img);
       value:=podcast.itunes_img;  // ShowMessage('ident='+ident+#13+'value='+value);
       doorgaan:=false;
      end;
      if doorgaan then
      begin
        ident:=Lijn; Delete(ident,1,pos('<',ident)); Delete(ident,pos('>',ident),length(lijn));
        value:=Lijn; Delete(value,1,pos('>',value)); Delete(value,pos('<',value),length(lijn));
      end;
    end;
    case ident of
      'title': podcast.ch_title:=value;
      'link' : begin
                 podcast.ch_link:=value;
                 if pos('http://http://',value)=1 then
                 begin
                  delete(podcast.ch_link,1,7);
                 end;
               end;
      'copyright': podcast.ch_copyright:=value;
      'description': podcast.ch_descript:=value;
      'lastBuildDate': podcast.ch_lastdate:=value;
      'itunes:subtitle': podcast.itunes_sub:=value;
      'itunes:summary': podcast.itunes_oms:=value;
     end;
   until (pos('<item>',lijn)>0) or eof(Filevar);

   //ITEM INFO
   if not eof(Filevar) then
   begin
    repeat
      Repeat
       Readln(Filevar,lijn);
       if length(lijn)>0 then
       begin
        If pos('<enclosure',lijn)>0 then
        begin
         ident:='enclosure';
         podcast.it_mediaurl:=lijn;delete(podcast.it_mediaurl,1,pos('url="',podcast.it_mediaurl)+4);
         delete(podcast.it_mediaurl,pos('" ',podcast.it_mediaurl),length(podcast.it_mediaurl));
         value:=podcast.it_mediaurl;  // ShowMessage('ident='+ident+#13+'value='+value);
         temp:=lijn;
         delete(temp,1,pos('gth="',temp)+4);
         delete(temp,pos('"',temp),length(temp));
         podcast.it_bytes:=strtointdef(temp,8);
        end
                                  else
        begin
          ident:=Lijn; Delete(ident,1,pos('<',ident)); Delete(ident,pos('>',ident),length(lijn));
          value:=Lijn; Delete(value,1,pos('>',value)); Delete(value,pos('<',value),length(lijn));
          value:=stringreplace(value,'&#8211;','-',[rfReplaceAll, rfIgnoreCase]);
          case ident of
           'title': podcast.it_title:=value;
           'link' : podcast.it_link:=value;
           'guid': podcast.it_guid:=value;
           'description': podcast.it_descript:=value;
           'category': podcast.it_cat:=value;
           'pubDate':
             begin
               delete(value,length(value)-5,6);
               podcast.it_pubdate:=value;
             end;
          end;
        end;
       end;
      until (pos('<item>',lijn)>0) or eof(Filevar);
      inc(i);
      if (x=-1) then
      begin
       Stringgrid1.RowCount:=i+1;
       Stringgrid1.Cells[0,i]:=podcast.it_pubdate;
       Stringgrid1.Cells[1,i]:=podcast.it_title;
      end
      else if i=x then
      begin
       Closefile(filevar);
       exit;
      end;

    until (pos('</channel>',lijn)>0) or eof(Filevar);
   end;
  end;
  Closefile(Filevar);

  if x=-1 then stringgrid1.AutoSizeColumns;
end;

procedure TForm1.SpeedButton27Click(Sender: TObject);
var ext1, ext2: string;
begin
  begin
    GetPodcast(Stringgrid1.Row,Stringgrid1.Cells[1,Stringgrid1.Row]);
    ext1:=ExtractFileext(podcast.it_mediaurl);
    SaveDialog1.FileName:=Podcast.it_title+ext1;
    If saveDialog1.Execute then
    begin
     ext2:=ExtractFileext(SaveDialog1.FileName);
     if ext1<>ext2 then SavePodcastto:=SaveDialog1.FileName+ext1
                   else SavePodcastto:=SaveDialog1.FileName;
     SaveDownloadto.Add(SavePodCastto);
     urlvar:=podcast.it_mediaurl;
     labelPodcast.Caption:=inttostr(SaveDownLoadTo.Count);
     FormDownLoadOverView.ListBox1.Items.Add(urlvar);
     if not downloadpodcast then Thread1:=TDownloadPodCastThread.Create(False);
    end;
  end
end;

procedure TForm1.SB_PodcastUpClick(Sender: TObject);
var x: integer;
begin
  if SG_Podcast.Row>0 then
  begin
    x:=SG_Podcast.Row;
    SG_PodCast.MoveColRow(False,x,x-1);
  end;
end;

procedure TForm1.SB_PodcastDownClick(Sender: TObject);
var x: integer;
begin
  if SG_Podcast.Row<SG_Podcast.RowCount-1 then
  begin
    x:=SG_Podcast.Row;
    SG_Podcast.MoveColRow(False,x,x+1);
  end;
end;

procedure TForm1.SB_PodcastSaveClick(Sender: TObject);
begin
  SG_Podcast.SaveToCSVFile(Settings.cacheDirRadio+DirectorySeparator+'podcastnew',';',false);
end;

procedure TForm1.SpeedButton3Click(Sender: TObject);
var SysteemVolume: real;
begin
  {$if not defined(HAIKU)}
  SysteemVolume:=BASS_GetVolume; VolumeBar.Position:=(round(systeemvolume*100));
  {$ifend}
  if panelvolume.visible then PanelVolume.Visible:=False
  else
  begin
    {$if not defined(HAIKU)}
    systeemVolume:=BASS_GetVolume; Volumebar.Position:=round(systeemvolume*100);
    {$ifend}
    PanelVolume.Visible:=true;
  end;
end;

procedure TForm1.SB_ConfigClick(Sender: TObject);
var Mono: Boolean;
begin
  Mono:=Settings.PlayMono;
  FormConfig.Showmodal;
(*  if Settings.PlayMono<>Mono then
  begin
    BASS_Free;
    if Settings.PlayMono then BASS_Init(-1, 44100, BASS_DEVICE_MONO, nil, nil)
                         else BASS_Init(-1, 44100, 0, nil, nil);
  end;                                                    *)
  {$if not defined(HAIKU)}
  BASS_SetConfig(BASS_CONFIG_DEV_BUFFER, Settings.cdb);
  {$ifend}
end;

procedure TForm1.SB_ShuffleClick(Sender: TObject);
var i: longint;
    temp: string;
begin
  Settings.Shuffle:=not Settings.Shuffle;
  Cursor:=CrHourGlass; Application.ProcessMessages;
  //Randomize;

 if Settings.Shuffle then
 begin
   Setlength(OrigineleVolgorde,SG_Play.RowCount); Application.ProcessMessages;
   for i:=1 to SG_Play.RowCount-1 do OrigineleVolgorde[i]:=strtoint(SG_Play.Cells[6,i]);
   ImageListRepeat.GetBitmap(3, SB_Shuffle.Glyph);
   SB_Shuffle.Hint:='SHUFFLE: On';
   MI_Reshuffle.Enabled:=True;
   MI_ReshuffleClick(Self);
 end
            else
 Begin
  if SG_Play.RowCount>1 then
  begin
   SG_Play.Cells[0,songrowplaying]:=' ';
   if isplayingsong then temp:=SG_Play.Cells[6,songrowplaying];
   for i:=1 to SG_Play.RowCount-1 do
   begin
    SG_Play.Cells[1,i]:=Liedjes[OrigineleVolgorde[i]].Artiest;
    if Liedjes[OrigineleVolgorde[i]].Track=0 then SG_Play.Cells[2,i]:=''
       else if Liedjes[OrigineleVolgorde[i]].Track<10 then SG_Play.Cells[2,i]:='0'+inttostr(Liedjes[OrigineleVolgorde[i]].Track)
                                                      else SG_Play.Cells[2,i]:=inttostr(Liedjes[OrigineleVolgorde[i]].Track);
    SG_Play.Cells[3,i]:=Liedjes[OrigineleVolgorde[i]].Titel;
    SG_Play.Cells[4,i]:=Liedjes[OrigineleVolgorde[i]].CD;
    SG_Play.Cells[5,i]:=Liedjes[OrigineleVolgorde[i]].Jaartal;
    SG_Play.Cells[6,i]:=inttostr(OrigineleVolgorde[i]);
    if isplayingsong then
    begin
      if SG_Play.Cells[6,i]=temp then
      begin
        SG_Play.Cells[0,i]:='»'; songrowplaying:=i;
        SG_play.Row:=i;
      end;
    end;

   end;
  end;
   ImageListRepeat.GetBitmap(4, SB_Shuffle.Glyph);
   SB_Shuffle.Hint:='SHUFFLE: Off';
   MI_Reshuffle.Enabled:=False;
  end;
 Cursor:=CrDefault;
end;

procedure TForm1.SpeedButton7Click(Sender: TObject);
begin
  FormSearch.ShowModal;
end;

procedure TForm1.SpeedButton8Click(Sender: TObject);
begin
  if FormEQ.Visible then FormEQ.BringToFront
                    else FormEQ.show;
end;

procedure TForm1.Splitter3Moved(Sender: TObject);
begin
  Splitter4Moved(Self);
end;

procedure TForm1.Splitter4ChangeBounds(Sender: TObject);
begin
  If not Splitter4.Enabled then Splitter4.Top:=26;
end;

procedure TForm1.Splitter4Moved(Sender: TObject);
var deler: real;
begin
  if Splitter4.Top>26+ImageCDCoverLyric.Width+3 then Splitter4.Top:=26+ImageCDCoverLyric.Width+1;
  if (Splitter4.Top>27) and (Splitter4.Enabled) then Songtext_CDCoverSplitter:=Splitter4.Top;
  if Splitter4.Top<26 then Splitter4.Top:=26;
  if ImageCDCoverLyric.Picture.Bitmap.Height<ImageCDCoverLyric.Picture.Bitmap.Width then
          begin
            deler:=ImageCDCoverLyric.Picture.Bitmap.Width/ImageCDCoverLyric.Picture.Bitmap.Height;
            Splitter4.Top:=round(ImageCDCoverLyric.Width/deler)+26+2;
          end;
  If Settings.FixCDCover then
  begin
     if Splitter4.Top>Round(Panel2.Height/1.76) then Splitter4.Top:=round(Panel2.Height/1.76)-2;
  end;
end;

procedure TForm1.Ster7Click(Sender: TObject);
begin
    VulsterrenPlaylist(2);
end;

procedure TForm1.Ster8Click(Sender: TObject);
begin
    VulsterrenPlaylist(3);
end;

procedure TForm1.Ster9Click(Sender: TObject);
begin
    VulsterrenPlaylist(4);
end;

procedure TForm1.StringGrid1Click(Sender: TObject);
begin
  PanelVolume.Visible:=False;
end;

procedure TForm1.StringGrid1DblClick(Sender: TObject);
var downloadok: boolean;
begin
  Stringgrid1.Cursor:=CrHourGlass; Application.ProcessMessages;
  MemoLyrics.Clear; downloadok:=true;
  GetPodcast(Stringgrid1.Row,Stringgrid1.Cells[1,Stringgrid1.Row]);
  Label19.Caption:=Podcast.ch_title;
  Label20.Caption:=Podcast.ch_link;
  Label24.Caption:=Podcast.it_mediaurl;
  if length(Podcast.it_descript)>200 then
  begin
   Label22.Font.Size:=8;
  end
  else
  begin
    Label22.Font.Size:=10;
  end;
  Label22.Caption:=striphtml(Podcast.it_descript);
  label23.Caption:=Podcast.itunes_sub;
  Label21.Caption:=Podcast.ch_copyright;
  Trackbar2.Max:=Podcast.it_bytes;
  FormCoverPlayer.ProgressBar1.MaxValue:=Podcast.it_bytes;

  MemoLyrics.Lines.Add('');
  MemoLyrics.Lines.Add(Podcast.itunes_oms);
  Playpodcast(Podcast.it_mediaurl);

  DeleteFile(TempDir+DirectorySeparator+'podcast.jpg');
  if length(Podcast.itunes_img)>0 then
  begin
    if pos('.jpg',podcast.itunes_img)>0 then
    begin
      if DownloadFile(Podcast.itunes_img,TempDir+DirectorySeparator+'podcast.jpg')
        then
        begin
          try
            ImageCDCover.Picture.LoadFromFile(TempDir+DirectorySeparator+'podcast.jpg');
          except
            downloadok:=false;
           // ImageCDCover.Picture.Bitmap:=FormDetails.Image2.Picture.Bitmap;
          end;
        end
        else downloadok:=false;
    end
    else downloadok:=false;
  end
  else downloadok:=false;
  //openurl(TempDir+DirectorySeparator+'podcast.jpg');

  if downloadok then
  begin
    ImageCDCoverLyric.Picture.Bitmap:=ImageCdCover.Picture.Bitmap;
    if not Splitter4.Enabled then
    begin
      Splitter4.Enabled:=True;
      Splitter4.Top:=26+ImageCDCoverLyric.Width+1;

    end;
    Splitter4Moved(Stringgrid1);
  end
                else
  begin
    ImageCDCover.Picture.Bitmap:=FormDetails.Image2.Picture.Bitmap;
    Splitter4.Top:=26; Splitter4.Enabled:=false;
  end;
  Stringgrid1.Cursor:=CrDefault;
  FormCoverPlayer.ImageCDCover.Picture.Bitmap:=ImageCDCover.Picture.Bitmap;
end;

procedure TForm1.SG_CUEDblClick(Sender: TObject);
var max,huidig: longint;
    u,m,s: byte;
    lijn, temp: string;
begin
  if (SG_CUE.RowCount>1) and (SG_CUE.Row>0) then
  begin
    LabelElapsedTime.caption:=SG_CUE.Cells[3,SG_CUE.Row];

    ShellListView1DblClick(Self);

    playingcue:=SG_CUE.Row;

    if length(Labeltime.Caption)>5 then
    begin
      lijn:=LabelTime.Caption;
      temp:=copy(lijn,1,pos(':',lijn)-1);
      u:=strtoint(temp);
      delete(lijn,1,pos(':',lijn));
      temp:=copy(lijn,1,pos(':',lijn)-1);
      m:=strtoint(temp);
      delete(lijn,1,pos(':',lijn));
      s:=strtoint(lijn);
      max:=s+(m*60)+(u*3600);
    end
    else
    begin
      lijn:=LabelTime.Caption;
      temp:=copy(lijn,1,pos(':',lijn)-1);
      m:=strtoint(temp);
      delete(lijn,1,pos(':',lijn));
      s:=strtoint(lijn);
      max:=s+(m*60)
    end;

    lijn:=SG_CUE.Cells[3,SG_CUE.Row];
    temp:=copy(lijn,1,pos(':',lijn)-1);  m:=strtoint(temp);
    delete(lijn,1,pos(':',lijn));  s:=strtoint(lijn);
    huidig:=s+(m*60);

    Trackbar2.Position:=round(Trackbar2.Max/max*(huidig+0.5));;
    {$if not defined(HAIKU)}
    BASS_ChannelSetPosition(Song_Stream1,Trackbar2.Position, BASS_POS_BYTE);
    {$ifend}
    LB_CD.Caption:=SG_CUE.Cells[4,SG_CUE.Row];
    LB_Titel.Caption:=SG_CUE.Cells[2,SG_CUE.Row];
    LB_Artiest.Caption:=SG_CUE.Cells[1,SG_CUE.Row];
    LB_On.Visible:=True;
    LB_Artiest.Caption:=SG_CUE.Cells[1,SG_CUE.Row];
    Application.ProcessMessages;

    Form1.MI_ReloadSongtextClick(Self);
  end;
end;

procedure TForm1.SG_ListenLiveDblClick(Sender: TObject);
begin
  Radiostation[0].naam:=SG_ListenLive.Cells[1,SG_ListenLive.Row];
  Radiostation[0].land:=SG_ListenLive.Cells[2,SG_ListenLive.Row];
  Radiostation[0].genres:=SG_ListenLive.Cells[3,SG_ListenLive.Row];
  Radiostation[0].website:=SG_ListenLive.Cells[4,SG_ListenLive.Row];
  Radiostation[0].link:=SG_ListenLive.Cells[5,SG_ListenLive.Row];
  PlayRadio(0);
end;

procedure TForm1.StringGridCDClick(Sender: TObject);
begin
  PanelVolume.Visible:=False;
end;

procedure TForm1.StringGridCDDblClick(Sender: TObject);
var OurProcess: TProcess;
begin
  if Stringgridcd.Row>0 then
  begin
    if status_cd=1 then    (* Status_CD=1   -  CD Audio *)
    begin
      CDTrackPlaying:=StringgridCD.Row;
      Playtrack(CDTrackPlaying-1);
    end
    else
    begin                  (* Status_CD=2   -  DVD Track *)
      OurProcess := TProcess.Create(nil);
      OurProcess.CommandLine := Settings.Mplayer+' -vf pp=fd dvd://'+selectedchapter+' -chapter '+inttostr(Stringgridcd.row)+'-'+inttostr(stringgridcd.row);
      {$IFDEF LINUX}
       OurProcess.CommandLine:=OurProcess.CommandLine+' -dvd-device '+Settings.DVDDrive;
      {$ENDIF}
      {$IFDEF WINDOWS}
       OurProcess.CommandLine:=OurProcess.CommandLine+dvdLetter;
       OurProcess.Options:=OurProcess.Options+[poNoConsole];
      {$ENDIF}
      OurProcess.Execute;
      OurProcess.Free;
    end;
  end;
end;

procedure TForm1.PlayTrack(track: DWORD);
begin
  Label_Extra.Caption:='';
  LB_Titel.Caption:=CD[StringgridCD.Row].Titel;
  LB_Artiest.Caption:=CD[StringgridCD.Row].artiest;
  LB_CD.Caption:=CD[StringgridCD.Row].Album;
  if length(CD[StringgridCD.Row].Album)>0 then LB_On.Visible:=true
                                          else LB_On.Visible:=false;
  LabelTime.Caption:=CD[StringgridCD.Row].tijd;
  SB_RadioRecord.Enabled:=False; MI_RecordFromRadio.Enabled:=False;

  {$if not defined(HAIKU)}
  {$IFDEF DARWIN}                           (* MACOS can not make use of BASS_CD *)
    SB_StopClick(self);
    cdstream := BASS_StreamCreateFile(FALSE,PChar(CD[track+1].filename),0,0,BASS_STREAM_AUTOFREE);
  {$ENDIF}
  {$if defined(WINDOWS) or defined(LINUX)}  (* WINDOWS and LINUX can make use of BASS_CD *)
    cdstream := BASS_CD_StreamCreate(0, track, 0);
  {$IFEND}
  if stream<>5 then SB_StopClick(self);
  stream:=5;                               (* Stream=5  -  CD/DVD Stream  (Zet CDTrackPlaying terug op 1) *)
  CDTrackPlaying:=track;                   (* CDTrackPlaying   keeps track of the CD Track currently playing *)
  SB_RadioRecord.Enabled:=false;
  BASS_ChannelPlay(cdstream, False);
  FormEQ.CheckAllFX;

  total_bytes    := BASS_ChannelGetLength(cdstream, BASS_POS_BYTE);
  total_time     := BASS_ChannelBytes2Seconds(cdstream, total_bytes);
  {$endif}
  total_time_str := SecToTime(round(total_time));
  TrackBar2.Step:=round(total_bytes/100);
  TrackBar2.Max:=total_bytes; FormCoverPlayer.ProgressBar1.MaxValue:=total_bytes;
  Timer1.Enabled:=True;

  MI_ReloadSongtextClick(Self);

  if FormLog.CB_Log.Checked then
  begin
    FormLog.MemoDebugLog.Lines.Add('Stream=5  (CD/DVD Stream)');
    FormLog.MemoDebugLog.Lines.Add('CDTrackPlaying='+inttostr(CDTrackPlaying));
  end;
  UpdateMediaMode;
  TrackBar2.Style:=pbstNormal;
end;

procedure TForm1.StringGridCDEditingDone(Sender: TObject);
begin
  if stringgridcd.RowCount>1 then
      begin
        CD[stringgridcd.Row].artiest:=Stringgridcd.Cells[1,stringgridcd.Row];
        CD[stringgridcd.Row].Album:=Stringgridcd.Cells[3,stringgridcd.Row];
        CD[stringgridcd.Row].jaartal:=Stringgridcd.Cells[5,stringgridcd.Row];
        CD[stringgridcd.Row].genre:=Stringgridcd.Cells[6,stringgridcd.Row];
      end;
  StringgridCD.AutoSizeColumns;
end;

procedure TForm1.StringGridPresetsClick(Sender: TObject);
begin
  PanelVolume.Visible:=False;
end;

procedure TForm1.StringGridPresetsDblClick(Sender: TObject);
begin
  PlayRadio(strtoint(StringgridPresets.Cells[0,StringgridPresets.Row]))
end;

procedure TForm1.StringGridRadioAirClick(Sender: TObject);
begin
  PanelVolume.Visible:=False;
end;

procedure TForm1.StringGridRadioAirDblClick(Sender: TObject);
begin
  PlayRadio(strtoint(StringgridRadioAir.Cells[0,StringgridRadioAir.Row]))
end;

procedure TForm1.StringGridRadioAirMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  DestCol, DestRow: Integer;
begin
  if button=mbright then
  begin
    StringgridRadioAir.MouseToCell(X,Y,DestCol, DestRow);
    StringgridRadioAir.Row:=destRow;
    if StringgridRadioAir.row>0 then PM_Radio.PopUp;
  end;
end;

procedure TForm1.StringGridRecordedClick(Sender: TObject);
begin
  PanelVolume.Visible:=False;
end;

procedure TForm1.StringGridRecordedDblClick(Sender: TObject);
begin
  if StringgridRecorded.RowCount>1 then
  begin
   MI_CDCover_ChooseNewFile.Enabled:=False; MI_CDCover_RemoveCDCover.Enabled:=False;
   MI_GetArtworkFromFile.Enabled:=False;
    PlayingFromRecorded:=True;
    PlayFromFile(configDir+DirectorySeparator+'recorded'+DirectorySeparator+StringgridRecorded.Cells[0,StringgridRecorded.Row]+' - '+StringgridRecorded.Cells[1,StringgridRecorded.Row]+'.mp3');
    MemoLyrics.Lines.Clear; MemoArtiest.Lines.Clear; SG_Disco.RowCount:=1; Label_Extra.Caption:='';
    LB_Artiest.Caption:=Vertaal('from')+' '+StringgridRecorded.Cells[1,StringgridRecorded.Row]; LB_CD.Caption:=''; LB_On.Visible:=False;
    LabelProgram.Caption:=Vertaal('Previous recording'); LabelBitrate.Caption:=''; LabelSimilar.Caption:='-'; LB_Genre.Caption:='-';
  end;
end;

procedure TForm1.StringGridRecordedMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  DestCol, DestRow: Integer;
begin
  if button=mbright then
  begin
    StringGridRecorded.MouseToCell(X,Y,DestCol, DestRow);
    StringGridRecorded.Row:=destRow;
    if StringGridRecorded.row>0 then PM_RecordedRadio.PopUp;
  end;
end;

procedure TForm1.TabSheet14Show(Sender: TObject);
var I: longint;
    bestand, datum, radiostation: string;
    FindAllRecordings: TStringlist;
begin
  Cursor:=CrHourglass;
  If StringgridRecorded.RowCount=1 then
  begin
     FindAllRecordings:=FindAllFiles(configdir+directorySeparator+'recorded', '*.mp3', false);
     Stringgridrecorded.RowCount:=FindAllRecordings.Count+1;
     if FindAllRecordings.Count>0 then
     begin
       For i:=1 to FindAllRecordings.Count do
       begin;
         bestand:=ExtractFilename(FindAllRecordings.Strings[i-1]);
         datum:=Copy(bestand,1,pos(' -',bestand)-1);
         radiostation:=Copy(bestand,pos('- ',bestand)+2,length(bestand));
         radiostation:=Copy(radiostation,1,length(radiostation)-4);
         Stringgridrecorded.Cells[0,i]:=datum;
         Stringgridrecorded.Cells[1,i]:=radiostation;
       end;
     end;
     StringgridRecorded.AutoSizeColumns;
     FindAllRecordings.Free;
  end;
  Cursor:=CrDefault;
end;

procedure TForm1.TabSheet1Show(Sender: TObject);
begin
//  if SG_ListenLive.RowCount=1 then Speedbutton34Click(Self);
end;

procedure TForm1.TabSheetAlbumsShow(Sender: TObject);
begin
  ShowTabs(0, True, True, False, False, False, False, True);
  MI_RemoveFromPlaylist.Enabled:=False;
end;

procedure TForm1.TabSheetArtistsContextPopup(Sender: TObject; MousePos: TPoint;
  var Handled: Boolean);
begin

end;

procedure TForm1.TabSheetArtistsShow(Sender: TObject);
begin
  ShowTabs(0, True, True, False, False, False, False, True);
end;

procedure TForm1.TabSheetCDShow(Sender: TObject);
begin
  ShowTabs(5, False, False, False, False, False, True, False);
end;

procedure TForm1.TabSheetCoversEnter(Sender: TObject);
begin

end;

procedure TForm1.TabSheetFilesShow(Sender: TObject);
begin
  ShowTabs(2, False, False, True, False, False, False, False);
end;

procedure TForm1.TabSheetPlaylistsShow(Sender: TObject);
begin
  ShowTabs(0, True, True, False, False, False, False, True);
end;

procedure TForm1.TabSheetPlayQueShow(Sender: TObject);
begin

end;

procedure TForm1.TabSheetPodcastShow(Sender: TObject);
begin
  ShowTabs(4, False, False, False, False, True, False, False);
end;

procedure TForm1.TabSheetRadioShow(Sender: TObject);
begin
  ShowTabs(3, False, False, False, True, False, False, False);
end;

procedure TForm1.ThumbControl1DblClick(Sender: TObject);
var ActiveIndex, i, i2, temp: Integer;
    Artiest, Album: String;
    toevoegen: boolean;
begin
  if ThumbControl1.ImageLoaderManager.CountItems>0 then
  begin
    i2:=0;
    ActiveIndex:=strtointdef(ThumbControl1.ImageLoaderManager.ActiveItem.DataString,0);
    artiest:=upcase(Liedjes[ActiveIndex].Artiest);
    album:=upcase(Liedjes[ActiveIndex].CD);
    GetSongsFromAlbum(Artiest, Album, True);
    SG_Play.BeginUpdate;

    For i:=0 To FilesFound.Count-1 do
    begin
      inc(i2);
      temp:=strtoint(FilesFound.Strings[i]);
      SG_Play.RowCount:=i2+1;
      SG_Play.Cells[1,i2]:=Liedjes[temp].Artiest;
      if Liedjes[temp].Track = 0 then SG_Play.Cells[2, i2] := ''
                                    else if Liedjes[temp].Track < 10 then SG_Play.Cells[2, i2] := '0' + inttostr(Liedjes[temp].Track)
                                            else SG_Play.Cells[2, i2] := inttostr(Liedjes[temp].Track);
      SG_Play.Cells[3,i2]:=Liedjes[temp].Titel;
      SG_Play.Cells[4,i2]:=Liedjes[temp].Artiest;
      SG_Play.Cells[5,i2]:=Liedjes[temp].Jaartal;
      SG_Play.Cells[6,i2]:=FilesFound.Strings[i];
    end;
    SG_Play.EndUpdate(True);
    if Settings.Shuffle then
      begin
        Setlength(OrigineleVolgorde,SG_Play.RowCount);
        for i:=1 to SG_Play.RowCount-1 do OrigineleVolgorde[i]:=strtoint(SG_Play.Cells[6,i]);
        SG_Play.Row:=Random(i2)+1;
        SG_PlayDblClick(LB_Artist1);
        MI_ReshuffleClick(Self);
      end
      else SG_PlayDblClick(LB_Artist1);
      AutoSizePlayColumns;
  end;
end;

procedure TForm1.ThumbControl1KeyPress(Sender: TObject; var Key: char);
begin
  if key=#13 then ThumbControl1DblClick(Self);
end;

procedure TForm1.ThumbControl1MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if (Button=mbRight) or (Button=mbExtra1) then
  begin
     Thumbcontrol1.Click;
     PM_CDCoverBrowser.PopUp;
  end;
end;


{$if not defined(HAIKU)}
{$IFDEF UNIX}
procedure FreeSync(handle: HSYNC; channel, data: DWORD; user: Pointer); cdecl;
{$ELSE}
  procedure FreeSync(handle: HSYNC; channel, data: DWORD; user: Pointer); stdcall;
{$ENDIF}
begin
 // just send a SendMessage or PostMessage that the stream has freed btw the connection lost
  if FormLog.CB_Log.Checked then FormLog.MemoDebugLog.Lines.Add('RADIOSTREAM: Connection lost');
  RadioDisconnected:=True;
end;

{$IFDEF UNIX}
procedure StatusProc(buffer: Pointer; len:DWORD; user: Pointer); CDecl;
{$ELSE}
procedure StatusProc(buffer: Pointer; len:DWORD; user: Pointer); STDcall;
{$ENDIF}
begin
  if StreamSave then
  begin
    if FileStream = nil then
    begin
      try
        FileStream := TFileStream.Create(recordstreamtofile, fmCreate);
      except
        FormLog.MemoDebugLog.Lines.Add('RECORD STREAM: Could not create '+recordstreamtofile);
      end;
    end;
    if (buffer <> nil) then FileStream.Write(buffer^, len) // Okay we have Data write The File
                       else FreeandNil(FileStream);
  end
  else FreeandNil(FileStream);
end;

procedure DoMeta();
var
  meta: PAnsiChar;
  p: Integer;
  lijn, oldLine: string;
begin
 // meta := BASS_ChannelGetTags(radioStream, BASS_TAG_META);
  if (meta <> nil) then
  begin
    p := Pos('StreamTitle=', utf8String(meta));
    if (p = 0) then
      Exit;
    p := p + 13;
    lijn:=utf8String(Copy(meta, p, Pos(';', utf8String(meta)) - p - 1));
    OldLine :=Form1.Label18.Caption;
    if (OldLine<>lijn) and (pos(OldLine, lijn)<>1) then
    begin
      Form1.Label18.Caption:=lijn;
      if (length(lijn)>3) and (pos(' -',lijn)>1) then
      begin
        if RadioStation[RadioAktief].volgorde='1' then Form1.LB_Titel.Caption:=CopY(lijn,1,pos(' -',lijn)-1)
                                                   else Form1.LB_Artiest.Caption:=CopY(lijn,1,pos(' -',lijn)-1);
        Delete(lijn,1,pos('- ',lijn)+1);
        if RadioStation[RadioAktief].volgorde='1' then Form1.LB_Artiest.Caption:=lijn
                                                   else Form1.LB_Titel.Caption:=lijn;
        Form1.MI_ReloadSongtextClick(Form1.MI_ReloadSongtext);
        if IsMediaModeOn then Form1.UpdateMediaMode;
      end;
    end;
  end;
end;

procedure MetaSync; stdcall;
begin
  DoMeta();
end;
{$ifend}


procedure TForm1.Timer1Timer(Sender: TObject);
var len, RealFade: longint;
    oldfade: boolean;
begin
  oldfade:=Settings.Fade;

  {$if not defined(HAIKU)}
  case stream of
   // SONGS
     1: Streamvar:=Song_Stream1;
     2: Streamvar:=Song_Stream2;
     4: StreamVar:=ReverseStream;

   // CD
     5: begin
          Streamvar:=CDStream;
          if BASS_ChannelIsActive(StreamVar)=0 then
          begin
            if (StringgridCD.Row<StringgridCD.RowCount-1) then SB_NextClick(Self)
                                                          else SB_StopClick(Self);
          end;
        end;

     //From File
     6: begin
          Streamvar:=Song_Stream1;
          if BASS_ChannelIsActive(StreamVar)=0 then SB_NextClick(Self)
             else
             begin
               if SG_CUE.rowcount>1 then
               begin
                 if playingcue<SG_CUE.RowCount-1 then
                 begin
                   if (LabelElapsedTime.Caption>SG_CUE.Cells[3,playingcue+1]) and (LabelElapsedTime.Caption<>'--:--') then
                   begin
                     repeat
                       if playingcue<SG_CUE.RowCount then inc(playingcue);
                     until (LabelElapsedTime.Caption<SG_CUE.Cells[3,playingcue+1]) or (playingcue=SG_CUE.RowCount-1);
                     SG_CUE.Row:=playingcue;
                     LB_CD.Caption:=SG_CUE.Cells[4,SG_CUE.Row]; LB_On.Visible:=True;
                     LB_Titel.Caption:=SG_CUE.Cells[2,SG_CUE.Row];
                     LB_Artiest.Caption:=SG_CUE.Cells[1,SG_CUE.Row];
                     Application.ProcessMessages;
                     Form1.MI_ReloadSongtextClick(Self);
                   end;
                 end
                 else LabelElapsedTime.Caption:='00:00';
               end;
             end;
        end;

   // RADIO
    10: begin
          Streamvar:=RadioStream;
          DoMeta();
          If RadioDisconnected then
          begin
            if FormLog.CB_Log.Checked then FormLog.MemoDebugLog.Lines.Add('RadioStream: Trying to reconnet to '+RadioStation[RadioAktief].naam+' ...');
            Sleep(300);
            PlayRadio(RadioAktief);
          end;
        end;
    // PODCAST
    11: begin
          Streamvar:=RadioStream;
          if (elapsed_time mod 36) = 0
            then LB_Artiest.Caption:=Label19.Caption
            else if (elapsed_time mod 23) = 0  then if length(Label22.Caption)>1 then LB_Artiest.Caption:=Label22.Caption
                                               else if (elapsed_time mod 11) = 0
                                                      then if length(Label23.Caption)>1
                                                         then LB_Artiest.Caption:=Label23.Caption;
        end;
  end; (* Of Case *)

  // VU METER
  vu1:=Lo(BASS_ChannelGetLevel(StreamVar)); vu2:=Hi(BASS_ChannelGetLevel(StreamVar));

  //TIME
  elapsed_bytes := BASS_ChannelGetPosition(StreamVar, BASS_POS_BYTE);
  elapsed_time := round(BASS_ChannelBytes2Seconds(StreamVar, elapsed_bytes));
  elapsed_time_str := SecToTime(elapsed_time);
  {$ifend}

  if IsMediaModeOn then  begin
                          FormCoverPlayer.BCLabelTime.Caption:=elapsed_time_str;
                          FormCoverPlayer.ProgressBar1.Value:=TrackBar2.Position;
                         end;

  if not elapsed then begin
                        LabelElapsedTime.Caption:=elapsed_time_str;
                        If stream=10 (* radio *) then Labeltime.Caption:=elapsed_time_str;
                      end
                 else begin
                        time_str:='-'+SecToTime(elapsed_time-round(total_time));
                        LabelElapsedTime.Caption:=time_str;
                      end;

  if (stream<5) then     // 1 & 2 SONGS
  begin

    if Settings.NoAdvance then RealFade:=0
                          else RealFade:=Settings.FadeTime;
    if (Liedjes[songplaying].FadeSettings=0) or (not Settings.Fade) or (stream=5) then                     // NO FADE SETTINGS
    begin
      if (elapsed_time>=total_time-Settings.TrimFade(*-1*)) (*OR (BASS_ChannelIsActive(StreamVar)=0)*) then
      begin
        Settings.Fade:=False;
        if Settings.NoAdvance then SB_StopClick(Self)
                     else
                     begin
                       case Settings.RepeatSong of
                         0: begin
                              if (songrowplaying<SG_Play.RowCount-1) then SB_NextClick(Self)
                                                                     else SB_StopClick(Self);
                            end;
                         1: SB_PlayClick(Self);
                         2: SB_NextClick(Self);
                       end; {of case}
                     end;
         Settings.Fade:=oldfade;
       end;
    end                                                                                                 // FADE SETTINGD
    else if (elapsed_time>total_time-RealFade-Settings.TrimFade(*-1*)) (*OR (BASS_ChannelIsActive(StreamVar)=0)*) then
      begin
        if Settings.NoAdvance then SB_StopClick(Self)
                     else
                     begin
                       case Settings.RepeatSong of
                         0: begin
                              if songrowplaying<SG_Play.RowCount-1 then SB_NextClick(Self);
                            end;
                         1: SB_PlayClick(Self);
                         2: SB_NextClick(Self);
                       end;
                     end;
      end;
    TrackBar2.Position:=elapsed_bytes;
  end
  else if stream<>10 then TrackBar2.Position:=elapsed_bytes;
end;

procedure TForm1.TimerTCPTimer(Sender: TObject);
var sub_String, preset, country: String;
    i: longint;
begin
  case Messageused of
    'XIX: Fullscreen': if not isfullscreen then SpeedButton1Click(Self);
    'XIX: Fullscreen off': if isfullscreen then SpeedButton1Click(Self);
    'XIX: Play': SB_PlayClick(Self);
    'XIX: Play selected': Begin
                            SG_AllClick(Self); Application.ProcessMessages;
                            SG_AllDblClick(Self);
                          end;
    'XIX: Stop': SB_StopClick(Self);
    'XIX: Next': SB_NextClick(Self);
    'XIX: Previous': SB_PreviousClick(Self);
    'XIX: Reverse': SB_ReverseClick(Self);
    'XIX: Pauze': SB_PauzeClick(Self);
    'XIX: Volume up': SpeedButton10Click(Self);
    'XIX: Volume down': SpeedButton11Click(Self);
    'XIX: Radio':Begin
                   PageControl1.TabIndex:=5; Sleep(120);
                 end;
    'XIX: Mute': Begin
                 end;
    'XIX: Mute off': Begin
                     end;
    else
      begin
         if pos('XIX: Radio station', Messageused)>0 then
         begin
          if stream<>10 then
           begin
             SB_StopClick(Self);
             Sleep(180);
           end;
           PageControl1.TabIndex:=5; Application.ProcessMessages;
           Sub_String:=Copy(Messageused,20,length(Messageused));
           PageControl4.TabIndex:=0; Application.ProcessMessages;
           PlayRadio(strtointdef(Sub_String,1))
         end;
         if pos('XIX: Radio preset', Messageused)>0 then
         begin
          if stream<>10 then
           begin
             SB_StopClick(Self); Application.ProcessMessages;
           end;
           PageControl1.TabIndex:=5; Application.ProcessMessages;
           Sub_String:=Copy(Messageused,19,length(Messageused));
           StringgridPresets.Row:=strtointdef(Sub_String,1); Application.ProcessMessages;
           PageControl4.TabIndex:=1; Application.ProcessMessages;
           StringgridPresetsClick(Self); Application.ProcessMessages;
           StringgridPresetsDblClick(Self);
         end;
         if pos('XIX: listenlive.eu preset', Messageused)>0 then
         begin
          if stream<>10 then
           begin
             SB_StopClick(Self); Application.ProcessMessages;
           end;
           PageControl1.TabIndex:=5; Application.ProcessMessages;
           Sub_String:=Copy(Messageused,27,length(Messageused));
           preset:=Copy(Sub_String,1,pos(' ',Sub_String)-1);
           Delete(Sub_String,1,length(preset)+1);
           country:=Sub_String;  LB_Land1.ItemIndex:=LB_Land1.Items.IndexOf(country); Application.ProcessMessages;
           SG_ListenLive.Row:=strtointdef(preset,1); Application.ProcessMessages;
           PageControl4.TabIndex:=3; Application.ProcessMessages;
           SG_ListenLiveDblClick(Self); Application.ProcessMessages;
         end;
         if pos('XIX: Play artist', Messageused)>0 then
         begin
           Sub_String:=Copy(MessageUsed,18,length(MessageUsed));
           LB_Artist1.MultiSelect:=False; Application.ProcessMessages;
           LB_Artist1.ItemIndex:=LB_Artist1.Items.IndexOf(Sub_String); Application.ProcessMessages;
           if LB_Artist1.ItemIndex>0 then begin
                                            LB_Artist1Clicked;  Application.ProcessMessages;  // fullrandom:=true;
                                            If SG_All.RowCount>1 then
                                              begin
                                                SG_All.Row:=1; Application.ProcessMessages;
                                                SG_AllClick(Self);  Application.ProcessMessages; SG_AllDblClick(Self);
                                              end;
                                            //  fullrandom:=false;
                                          end;
         end;
         end;
         if pos('XIX: Play song', Messageused)>0 then
         begin
           Sub_String:=Copy(Messageused,16,length(Messageused));
           SB_StopClick(Self); Application.ProcessMessages;
           Play(strtointdef(Sub_String,1));
         end;
         if pos('XIX: Select artist', Messageused)>0 then
         begin
           Sub_String:=Copy(Messageused,20,length(Messageused));
           LB_Artist1.MultiSelect:=False; Application.ProcessMessages;
           LB_Artist1.ItemIndex:=LB_Artist1.Items.IndexOf(Sub_String); Application.ProcessMessages;
           if LB_Artist1.ItemIndex>0 then LB_Artist1Click(Self);
         end;
         if pos('XIX: Select song', Messageused)>0 then
         begin
           Sub_String:=Copy(Messageused,18,length(Messageused));
           if SG_All.RowCount>1 then
           begin
             for i:=1 to SG_All.RowCount-1 do
             begin
               if SG_All.Cells[3,i]=Sub_String then
               begin
                 SG_All.Row:=i; Application.ProcessMessages;
                 Exit;
               end;
             end;
           end;
         end;
    end;
  Messageused:='nil';
  TimerTCP.Enabled:=False;
end;

procedure TForm1.TimerScheduleStopTimer(Sender: TObject);
begin
  schedulehasstarted:=false;
end;

procedure TForm1.TimerScheduleTimer(Sender: TObject);
var tijd1: string;
    time1: real;
    moderecording, newfilename: string;
    i: integer;
begin
  if plannedrecordings=0 then TimerSchedule.Enabled:=False;

  if (plannedrecordings>0) and schedulehasstarted then
  begin
    if FormLog.MemoDebugLog.Lines[FormLog.MemoDebugLog.Lines.Count-1]<>'Plannedrecordings>0 and schedulehasstarted (TIMER)'
      then FormLog.MemoDebugLog.Lines.Add('Plannedrecordings>0 and schedulehasstarted (TIMER)');
    tijd1:=FormatDateTime('YYYYMMDDhhnn',now);
    time1:=strtofloat(tijd1);
    if time1>endrecording then
      begin
        FormLog.MemoDebugLog.Lines.Add('SCHEDULE: End time reached');
        SB_RadioRecordClick(TimerSchedule);
        schedulehasstarted:=false;
        FormPlanRecording.StringGrid1.Row:=1; Application.ProcessMessages;
        newfilename:=FormPlanRecording.CreateScheduleFilename(ScheduleSettings.RenameFormat, FormPlanRecording.StringGrid1.Cells[2,1]);
        if (not ScheduleSettings.Overwrite) and (FileExistsUTF8(ScheduleSettings.CopyDir+DirectorySeparator+newfilename+'.mp3')) then
          begin
            i:=1;
            while FileExistsUTF8(ScheduleSettings.CopyDir+DirectorySeparator+newfilename+' (copy '+inttostr(i)+')') do inc(i);
            newfilename:=newfilename+' (copy '+inttostr(i)+')';
          end;
        newfilename:=newfilename+'.mp3';

        FormPlanRecording.SpeedButton5Click(TimerSchedule);
        FormPlanRecording.SortSchedule; Application.ProcessMessages;
        SB_StopClick(TimerSchedule);
        if not ScheduleSettings.RenameRec then newfilename:=ExtractFilename(recordstreamtoFile);
        if ScheduleSettings.CopyRec then
        begin
          FormLog.MemoDebugLog.Lines.Add('SCHEDULE: CopyFile to '+ScheduleSettings.CopyDir+DirectorySeparator+newfilename);
          CopyFile(recordstreamtofile, ScheduleSettings.CopyDir+DirectorySeparator+newfilename);
          If ScheduleSettings.DeleteAfterCopy then begin
                                                     DeleteFile(recordstreamtofile);
                                                     FormLog.MemoDebugLog.Lines.Add('SCHEDULE: Original recording is deleted');
                                                   end
                                              else FormLog.MemoDebugLog.Lines.Add('SCHEDULE: Original recording is kept');
        end;
      end;
  end;

 if (plannedrecordings>0) and not schedulehasstarted then
  begin
    Form1.TimerSchedule.Enabled:=False; Application.ProcessMessages;
  //  if FormLog.MemoDebugLog.Lines[FormLog.MemoDebugLog.Lines.Count-1]<>'Plannedrecordings>0 and not schedulehasstarted (TIMER)'
  //    then FormLog.MemoDebugLog.Lines.Add('Plannedrecordings>0 and not schedulehasstarted (TIMER)');
    moderecording:=FormPlanRecording.StringGrid1.Cells[5,1];

    if not (moderecording='9') then
    begin
      tijd1:=FormatDateTime('YYYYMMDDhhnn',now);
      time1:=strtofloat(tijd1);

      if (time1>beginrecording) then
      begin
        if time1>endrecording then
        begin
          FormPlanRecording.StringGrid1.Row:=1;
          FormPlanRecording.StringGrid1.Cells[5,1]:='9';moderecording:='9';
          FormPlanRecording.SpeedButton5Click(TimerSchedule);
        end;
        if moderecording='0' then
        begin
          If StreamSave then SB_RadioRecordClick(TimerSchedule);

          PageControl1.ActivePageIndex:=5; PageControl4.ActivePageIndex:=0;
          StringGridRadioAir.Cursor:=CrHourglass;
          PlayRadio(strtoint(FormPlanRecording.StringGrid1.Cells[0,1]));
          Application.ProcessMessages;
          schedulehasstarted:=true;
          StringGridRadioAir.Cursor:=CrDefault;
          FormPlanRecording.StringGrid1.Cells[5,1]:='9';
          SB_RadioRecordClick(TimerSchedule);
        end;

        if moderecording='1' then
        begin
          FormShowMyDialog.ShowWith(VERTAAL('ALERT'),Vertaal('You have scheduled a warning for'),'',FormPlanRecording.StringGrid1.Cells[2,1],'',Vertaal('Thanks'), False);
          FormPlanRecording.StringGrid1.Row:=1;
          FormPlanRecording.SpeedButton5Click(TimerSchedule);
        end;

        if moderecording='2' then
        begin
          PageControl1.ActivePageIndex:=5; PageControl4.ActivePageIndex:=0;
          StringGridRadioAir.Cursor:=CrHourglass;
          PlayRadio(strtoint(FormPlanRecording.StringGrid1.Cells[0,1]));
          FormPlanRecording.StringGrid1.Row:=1;
          FormPlanRecording.SpeedButton5Click(TimerSchedule);
          StringGridRadioAir.Cursor:=CrDefault;
        end;
      end;
    end;
    Form1.TimerSchedule.Enabled:=true;
  end;
end;

procedure TForm1.TB_ThumbSizeChange(Sender: TObject);
begin
  ThumbControl1.ThumbHeight:=TB_ThumbSize.Position;
  ThumbControl1.ThumbWidth:=TB_ThumbSize.Position;
end;

procedure TForm1.TB_ThumbSizeMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  ThumbControl1.ReloadImages;
end;


function TForm1.SecToTime(Sec: longint): string;
var
   H, M, S: string;
   ZH, ZM, ZS: Integer;
begin
   ZH := Sec div 3600;
   ZM := Sec div 60 - ZH * 60;

   ZS := Sec - (ZH * 3600 + ZM * 60) ;
   if ZM<0 then ZM:=ZM*-1;
   if ZS<0 then ZS:=ZS*-1;
   H := IntToStr(ZH) ;
   M := IntToStr(ZM) ; if length(M)=1 then M:='0'+M;
   S := IntToStr(ZS) ; if length(S)=1 then S:='0'+S;
   if H='0' then Result := M + ':' + S
            else Result := H + ':' + M + ':' + S;
end;

function TForm1.TimeToSec(Sec: string): longint;
var ZH, ZM, ZS, i, i2: Integer;
    TimeStr: Array[1..3] of String;
begin
  TimeStr[1]:='';TimeStr[2]:='';TimeStr[3]:=''; i2:=1;
  if length(Sec)>0 then
  begin
    for i:=length(Sec) downto 1 do
    begin
      if Sec[i]<>':' then TimeStr[i2]:=Sec[i]+TimeStr[i2]
                     else inc(i2);
      if i2>3 then
      begin
        Result:=0;
        exit;
      end;
    end;
  end
  else
  begin
    Result:=0;
    exit;
  end;

  ZS:=strtointdef(TimeStr[1],0);
  ZM:=strtointdef(TimeStr[2],0)*60;
  ZH:=strtointdef(TimeStr[3],0)*3600;

  Result:=ZS+ZM+ZH;
end;

procedure TForm1.JumpInTrackBar;
begin
  {$if not defined(HAIKU)}
  if stream=1 then BASS_ChannelSetPosition(Song_Stream1,Trackbar2.Position, BASS_POS_BYTE);
  if stream=2 then BASS_ChannelSetPosition(Song_Stream2,Trackbar2.Position, BASS_POS_BYTE);
  if stream=4 then BASS_ChannelSetPosition(ReverseStream,Trackbar2.Position, BASS_POS_BYTE);
  if stream=5 then BASS_ChannelSetPosition(cdStream,Trackbar2.Position, BASS_POS_BYTE);
  if stream=6 then BASS_ChannelSetPosition(Song_Stream1,Trackbar2.Position, BASS_POS_BYTE);

  if stream=11 then
  begin
     BASS_ChannelStop(RadioStream); Application.ProcessMessages;
     BASS_ChannelPlay(radiostream, True);
     BASS_ChannelSetPosition(RadioStream,Trackbar2.Position,BASS_POS_DECODETO+BASS_POS_BYTE);
  end;
  {$ifend}
end;

procedure TForm1.TrackBar2Click(Sender: TObject);
begin
  PanelVolume.Visible:=False;
end;

procedure TForm1.TrackBar2MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  Timer1.Enabled:=False;
end;

procedure TForm1.TrackBar2MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var divider: real;
begin
  divider:=TrackBar2.Width/x;
  Trackbar2.Position:=round(Trackbar2.Max/divider);
  JumpInTrackBar; Timer1.Enabled:=True;
end;

procedure TForm1.TrackBar2MouseWheel(Sender: TObject; Shift: TShiftState;
  WheelDelta: Integer; MousePos: TPoint; var Handled: Boolean);
begin
  {$if not defined(HAIKU)}
  Timer1.Enabled:=False;
  if wheeldelta<0 then
  begin
    Trackbar2.Position:=TrackBar2.Position-Trackbar2.step;
    if stream=1 then BASS_ChannelSetPosition(Song_Stream1,Trackbar2.Position, BASS_POS_BYTE);
    if stream=2 then BASS_ChannelSetPosition(Song_Stream2,Trackbar2.Position, BASS_POS_BYTE);
    if stream=4 then BASS_ChannelSetPosition(ReverseStream,Trackbar2.Position, BASS_POS_BYTE);
    if stream=6 then BASS_ChannelSetPosition(Song_Stream1,Trackbar2.Position, BASS_POS_BYTE);
  end;
  if wheeldelta>0 then
  begin
     Trackbar2.Position:=TrackBar2.Position+Trackbar2.Step;
     if stream=1 then BASS_ChannelSetPosition(Song_Stream1,Trackbar2.Position, BASS_POS_BYTE);
     if stream=2 then BASS_ChannelSetPosition(Song_Stream2,Trackbar2.Position, BASS_POS_BYTE);
     if stream=4 then BASS_ChannelSetPosition(ReverseStream,Trackbar2.Position, BASS_POS_BYTE);
     if stream=6 then BASS_ChannelSetPosition(Song_Stream1,Trackbar2.Position, BASS_POS_BYTE);
  end;
  if stream=5 then BASS_ChannelSetPosition(cdStream,Trackbar2.Position, BASS_POS_BYTE);
  if stream=11 then
  begin
     BASS_ChannelStop(RadioStream); Application.ProcessMessages;
     BASS_ChannelPlay(radiostream, True);
     BASS_ChannelSetPosition(RadioStream,Trackbar2.Position,BASS_POS_DECODETO+BASS_POS_BYTE);
  end;
  Application.ProcessMessages;
  Timer1.Enabled:=True;
  {$ifend}
end;

procedure TForm1.TrayIcon1Click(Sender: TObject);
begin
  PM_Panel.PopUp;
end;

procedure TForm1.TV_VFSDeletion(Sender: TObject; Node: TTreeNode);
var
  P: PNodeSongInfo;
begin
  P := PNodeSongInfo(Node.Data);
  if p=nil then exit;
  Dispose(p);
end;

procedure TForm1.TV_VFSSelectionChanged(Sender: TObject);
var
  Song, i2, n, len, PartLen: Integer;
  Node: TTreeNode;
  NodeInfo: PNodeSongInfo;
  PartPath: string[255]; //TODO: make this a type
begin

  getoondePlaylist := '';
  SB_Save.Enabled := False;
  PanelVolume.Visible := False;
  MI_RemoveFromPlaylist.Enabled := False;
  TV_VFS.Cursor := CrHourglass; Application.ProcessMessages;

  i2:=0;
  SG_All.RowCount:=1; SG_All.BeginUpdate;

  // find all selected nodes
  for n:=0 to TV_VFS.SelectionCount-1 do
  begin
    Node := TV_VFS.Selections[n];
    if Node=nil then
      break; // better this than sorry
    NodeInfo := PNodeSongInfo(Node.Data);
    if NodeInfo=nil then
      break; // ditto

    PartPath := Copy(Liedjes[NodeInfo^.Song].Pad, 1, NodeInfo^.Len);
    PartLen := Length(PartPath);
    for Song:=0 to maxsongs-1 do if not Liedjes[Song].Deleted then
    begin

      Len := Length(Liedjes[Song].Pad);
      if (Len<PartLen) or ((not CB_SubDirs.Checked) and (Len<>PartLen)) then
        continue;

      // TODO: if CB_Subdirs is checked there should be some optimization
      //       so no changes on SG_All are made if node parents are chosen

      if CompareMem(@PartPath[1], @Liedjes[Song].Pad[1], PartLen) then
      begin

        //if SongToRow(SG_All, Song)>0 then
        //  continue;

        inc(i2);
        SG_All.RowCount:=i2+1;

        SG_All.Cells[0,i2]:=Inttostr(Song);
        SG_All.Cells[1,i2]:=Liedjes[Song].Artiest;
        if Liedjes[Song].Track=0 then SG_All.Cells[2,i2]:=''
                              else if Liedjes[Song].Track<10 then SG_All.Cells[2,i2]:='0'+inttostr(Liedjes[Song].Track)
                                                          else SG_All.Cells[2,i2]:=inttostr(Liedjes[Song].Track);
        SG_All.Cells[3,i2]:=Liedjes[Song].Titel;
        SG_All.Cells[4,i2]:=Liedjes[Song].CD;
        SG_All.Cells[COL_SG_ALL_PATH,i2]:=Liedjes[Song].Pad;
        SG_All.Cells[COL_SG_ALL_NAME,i2]:=Liedjes[Song].Bestandsnaam;
      end;
    end;

  end;

  // resort the grid in the same column/order than previously
  // this could be probably an option ....
  //
  // TODO: The filling above make a "natural/default sort order"
  //       this needs to be reset in case the following is not desired
  FAllSel.Update;
  SG_AllHeaderClick(self, true, -1);

  SG_All.EndUpdate(True); AutoSizeAllColumns;
  PageControl2.PageIndex:=0; // Show SG_All
  TV_VFS.Cursor:=CRdefault;
  //SG_AllClick(Self);

end;

procedure TForm1.VolumeBarMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
  if ssLeft in Shift then
  begin
    {$if not defined(HAIKU)}
    BASS_SetVolume(volumeBar.Position/100);
    {$ifend}
  end;
end;

procedure TForm1.VolumeBarMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  {$if not defined(HAIKU)}
  BASS_SetVolume(volumeBar.Position/100);
  {$ifend}
end;

procedure TForm1.VolumeBarMouseWheelDown(Sender: TObject; Shift: TShiftState;
  MousePos: TPoint; var Handled: Boolean);
begin
    {$if not defined(HAIKU)}
  BASS_SetVolume(volumeBar.Position/100);
  {$ifend}
end;

procedure TForm1.VolumeBarMouseWheelUp(Sender: TObject; Shift: TShiftState;
  MousePos: TPoint; var Handled: Boolean);
begin
  {$if not defined(HAIKU)}
  BASS_SetVolume(volumeBar.Position/100);
  {$ifend}
end;

procedure TForm1.VuLeft1MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  PanelVUClick(self);
end;

procedure TForm1.PlayRadio(waar: integer);
var url, Filename_str: string;
    icy: PAnsiChar;
begin
  FormLog.MemoDebugLog.Lines.Add('.PlayRadio('+inttostr(waar)+') started');

  MemoLyrics.Lines.Clear;
  FormCoverPlayer.LabelLyrics.Caption:=''; FormCoverPlayer.Label2.Caption:=Vertaal('Radiostation')+':';
  MenuItem88.Enabled:=false; MI_CDCover_ChooseNewFile.Enabled:=False; MI_CDCover_RemoveCDCover.Enabled:=False;
  MI_GetArtworkFromFile.Enabled:=False;
  Filename_str:=LB_Filename.Caption; elapsed:=False;
  LB_Filename.Color:=ClRed; LB_Filename.Caption:='BUFFERING '+ RadioStation[waar].naam+' ...';

  RadioAktief:=waar; SB_StopClick(self);
  Application.ProcessMessages;
  url:=RadioStation[waar].link;
  LabelBitrate.Caption:=''; LabelProgram.Caption:='';
  LB_Titel.Caption:=Vertaal('Internet Radio'); Label_Extra.Caption:='';
  LB_Artiest.Caption:='--'; //LabelTime.caption:='-:--:--';

  {$if not defined(HAIKU)}
  BASS_SetConfig(BASS_CONFIG_NET_READTIMEOUT,5000); //5 sec
  radioStream := BASS_StreamCreateURL(pchar(url), 0, BASS_STREAM_STATUS and BASS_STREAM_AUTOFREE, @StatusProc, NIL);
  BASS_ChannelSetSync(radioStream ,BASS_SYNC_DOWNLOAD ,0,@FreeSync,nil); // just set a sync to detect if the stream has freed
  stream:=10;  // 10 = Radiostream

  // get the broadcast name and bitrate
    icy := BASS_ChannelGetTags(radioStream, BASS_TAG_ICY);
    if (icy = nil) then
      icy := BASS_ChannelGetTags(radioStream, BASS_TAG_HTTP); // no ICY tags, try HTTP
    if (icy <> nil) then
      while (icy^ <> #0) do
      begin
        if (Copy(icy, 1, 9) = 'icy-name:') then LabelProgram.Caption:= utf8String(Copy(icy, 10, 80))
                                           else if (Copy(icy, 1, 7) = 'icy-br:') then
                                                LabelBitrate.Caption:= utf8string('bitrate: ' + Copy(icy, 8, 80));
        icy := icy + Length(icy) + 1;
      end;

  DoMeta();
  FormEQ.CheckAllFX;
  BASS_ChannelPlay(radiostream, False);
  if BASS_ChannelIsActive(radiostream) = BASS_ACTIVE_PLAYING then RadioDisconnected:=False;
  {$ifend}

  LB_Filename.Color:=ClNone;
  LB_CD.Caption:=RadioStation[waar].naam+' ('+RadioStation[waar].land+')';
  LB_On.Visible:=True;
  LB_Artiest.Left:=Trackbar2.Left+round(Trackbar2.Width/2)-round((LB_Artiest.Width+LB_CD.Width)/2)+15;
  Label34.Visible:=False; Label35.Visible:=False;Label36.Visible:=False;
  Label35.Caption:='100'; ProgressBarSpeed.Value:=0;

  Timer1.Enabled:=True;

  Loaded_CD_Cover:='x';
  if DownloadFile(RadioStation[waar].logo1,Tempdir+DirectorySeparator+RadioStation[waar].internalnr) then
  begin
    if FileExistsUTF8(TempDir+DirectorySeparator+RadioStation[waar].internalnr) then
    begin
      try
        ImageCDCover.Picture.LoadFromFile(TempDir+DirectorySeparator+RadioStation[waar].internalnr);
      except
        ImageCDCover.Picture.Bitmap:=Image15.Picture.Bitmap;
      end;
    end
      else ImageCDCover.Picture.Bitmap:=Image15.Picture.Bitmap;
  end
    else ImageCDCover.Picture.Bitmap:=Image15.Picture.Bitmap;
  FormCoverPlayer.ImageCDCover.Picture.Bitmap:=Form1.ImageCdCover.Picture.Bitmap;
  // ImageCDCoverLyric.Picture.Bitmap.Clear;
  if Splitter4.Enabled then
  begin
    Splitter4.Enabled:=False;
    Splitter4.Top:=26;
  end;

  LB_RadioWebsite.Caption:=RadioStation[waar].website;
  LB_RadioNaam.Caption:=RadioStation[waar].naam;
  LB_Filename.Caption:=Filename_str;
  SB_RadioRecord.Enabled:=True; MI_RecordFromradio.Enabled:=True;
  If LB_Artiest.caption='--' then Memoartiest.Lines.Clear;

  UpdateMediaMode;  TrackBar2.Style:=pbstMarquee;

  if not radioDisconnected then
  begin
   FormLog.MemoDebugLog.Lines.Add('Name='+RadioStation[waar].naam);
   FormLog.MemoDebugLog.Lines.Add('Land='+RadioStation[waar].land);
   FormLog.MemoDebugLog.Lines.Add('Link='+RadioStation[waar].link);
   FormLog.MemoDebugLog.Lines.Add('Genre='+RadioStation[waar].genres);
   FormLog.MemoDebugLog.Lines.Add('Website='+RadioStation[waar].website);
   FormLog.MemoDebugLog.Lines.Add('Logo='+RadioStation[waar].logo1);
  end;
end;


procedure TForm1.GetDetailsFromFilename(i: longint);
var temp, temp_filename, temp_pad: string;
    it1, it2, it3, it4, it5, ext, ittemp : string;
    isitunesformat: boolean;
begin
  temp_filename:=Liedjes[i].Bestandsnaam;
  temp_pad:=Liedjes[i].Pad;
  {$ifdef Darwin}
  //temp_filename := lazfileutils.GetDarwinNormalizedFilename(temp_filename);
  //temp_pad:=lazfileutils.GetDarwinNormalizedFilename(temp_pad);
  {$endif}
  ext:=ExtractFileExt(Liedjes[i].Bestandsnaam);

  //Checking for Itunes Format:       Artist/Album/00 - Titel.mp3
  //                                   it5    it4   it3  it2   it1

  temp:=temp_pad+DirectorySeparator+temp_filename;
  it1:=AnsiToUTF8(copy(temp_filename,1,length(temp_filename)-length(ext)));  // 00 - titel
  isitunesformat:=false;

  // Indien it1 niet start met '00 -' is het geen iTunes
  // kan ook 1-00 Titel zijn voor mutlidisc   kan ook zonder - zijn
  if length(it1) > 4 then if (it1[4]='-') or (it1[3]=' ') or (it1[2]='-') then
  begin
    if it1[2]='-' then ittemp:=copy(it1,3,2)
                  else ittemp:=copy(it1,1,2);
    if Form1.IsNumber(ittemp) then
    begin
      it2:=ittemp;
      if (it1[4]='-') or (it1[2]='-') then it1:=copy(it1,6,length(it1)-5)
                                      else it1:=copy(it1,4,length(it1)-3);
      isitunesformat:=true;
    end
                              else isitunesformat:=false;
  end;

  if isitunesformat then
      begin
        ittemp:=ExtractFilename(temp);
        it5:=Copy(temp,1,length(temp)-length(ittemp));
        it3:=ExtractFileName(ExcludeTrailingPathDelimiter(it5));
        it5:=Copy(temp,1,length(temp)-length(it3)-length(ittemp)-1);
        it4:=ExtractFileName(ExcludeTrailingPathDelimiter(it5));
        if length(it4)>0 then Liedjes[i].Artiest:=it4
                         else Liedjes[i].Artiest:='Unknown';
        Liedjes[i].Track:=strtointdef(it2,0);
        if length(it1)>0 then Liedjes[i].Titel:=it1
                         else Liedjes[i].Titel:='Unknown';
        Liedjes[i].CD:=it3;

        if pos(' - ',temp_filename)>0 then
          begin
            Liedjes[i].CD:=it4;
            Delete(temp_filename,1,pos(' - ',temp_filename)+2);
            Delete(temp_filename,pos(' - ',temp_filename),pos(ext,temp_filename));
            Liedjes[i].Artiest:=temp_filename;
          end;
      end;

  if not isitunesformat then
  begin
    if pos(' - ',temp_filename)>0 then    // als er een ' - ' in de naam zit gaan we ervanuit dat het eerste gedeelte de artiestennaam is
    begin
      Liedjes[i].Artiest:=copy(temp_filename,1,pos(' - ',temp_filename)-1);
      if length(Liedjes[i].Artiest)>3 then If (Liedjes[i].Artiest[3]=')') or (Liedjes[i].Artiest[3]='.') then
      begin
        Liedjes[i].Track:=strtointdef(copy(temp_filename,1,2),0);
        Liedjes[i].Artiest:=copy(temp_filename,5,pos(' - ',temp_filename)-5);
      end;
      Liedjes[i].Titel:=copy(temp_filename,pos(' - ',temp_filename)+3,length(temp_filename));
      Liedjes[i].Titel:=copy(Liedjes[i].Titel,1,length(Liedjes[i].Titel)-length(ext));
    end;
    if length(Liedjes[i].Artiest)<1 then Liedjes[i].Artiest:='Unknown';
  end;
  // Als '- (xxx) -' dan xxx is CD naam
  if (pos(' - (',temp_filename)>0) and (pos(') - ',temp_filename)>0) then
  begin
    Liedjes[i].CD:=copy(temp_filename, pos(' - (',temp_filename)+4,length(temp_filename));
    Liedjes[i].CD:=copy(Liedjes[i].CD, 1, pos(') - ',Liedjes[i].CD)-1);

    Liedjes[i].Titel:=copy(temp_filename,pos(') - ',temp_filename)+4,length(temp_filename));
    Delete(Liedjes[i].Titel,length(Liedjes[i].Titel)-length(ext)+1,5);

    if length(Liedjes[i].Titel)>3 then If (Liedjes[i].Titel[3]=')') then
      begin
        Liedjes[i].Track:=strtointdef(copy(Liedjes[i].Titel,1,2),0);
        Delete(Liedjes[i].Titel,1,4);
      end;
  end;
  if (Liedjes[i].Artiest='Unknown') and (Liedjes[i].Titel='') then
    Liedjes[i].Titel:=Copy(temp_filename,1,length(temp_filename)-length(ext));
  Liedjes[i].EQ:=false;
end;

procedure TForm1.GetAllMusicFiles;
var CheckThisDir, tempstr, lijn: String;
    i, i2, id: longint;
    FilesTemp : TStringlist;
    OurProcess: TProcess;
    Filevar: TextFile;
begin
  if Formlog.CB_Log.Checked then
  begin
    FormLog.MemoDebugLog.Lines.Add('>> BEGIN << TForm1.GetAllMusicFiles');
    FormLog.MemoDebugLog.Lines.Add('Settings.IncludeLocaleDirs.Count='+inttostr(Settings.IncludeLocaleDirs.Count));
    FormLog.MemoDebugLog.Lines.Add('Settings.ExcludeLocaleDirs.Count='+inttostr(Settings.ExcludeLocaleDirs.Count));
    FormLog.MemoDebugLog.Lines.Add('Settings.IncludeExternalDirs.Count='+inttostr(Settings.IncludeExternalDirs.Count));
    FormLog.MemoDebugLog.Lines.Add('Settings.ExcludeExternalDirs.Count='+inttostr(Settings.ExcludeExternalDirs.Count));
  end;
  FormSplash.Label1.Caption:=Vertaal('Loading all MUSIC files');  Application.ProcessMessages;
  try
    FilesFound.Clear;
  except
    ShowMessage('Internal Error: Creating Stringlist');
  end;

  if Settings.IncludeLocaleDirs.Count>0 then
  begin
    for i:=0 to Settings.IncludeLocaleDirs.Count-1 do
    begin
      if Settings.IncludeLocaleDirsChecked[i] then
      begin
        CheckThisDir:=Settings.IncludeLocaleDirs.Strings[i];
        if Formlog.CB_Log.Checked then FormLog.MemoDebugLog.Lines.Add('INCLUDELOCALEDIR: CheckThisDir='+CheckThisDir);
        FilesTemp:=FindAllFiles(CheckThisDir, '*.mp3;*.flac;*.ogg;*.m4a;*.mp4;*.ape;*.aac;*.opus;*.dff;*.wav;*.wma', True);
        FilesFound.AddStrings(FilesTemp);
        if Formlog.CB_Log.Checked then
        begin
          FormLog.MemoDebugLog.Lines.Add('FilesTemp.count='+inttostr(FilesTemp.Count)+'  (* Temp Var *)');
          FormLog.MemoDebugLog.Lines.Add('FilesFound.count='+inttostr(FilesFound.Count)+'  (* Holds all songfiles *)');
        end;
        FilesTemp.Free;
      end;
    end;
    if Settings.ExcludeLocaleDirs.Count>0 then
    begin
      for i:=0 to Settings.ExcludeLocaleDirs.Count-1 do
      begin
        if Settings.ExcludeLocaleDirsChecked[i] then
        begin
          CheckThisDir:=Settings.ExcludeLocaleDirs.Strings[i];
          if Formlog.CB_Log.Checked then FormLog.MemoDebugLog.Lines.Add('EXCLUDELOCALEDIR: CheckThisDir='+CheckThisDir);
          for i2:=FilesFound.Count-1 downto 0 do
              If Pos(CheckThisDir,FilesFound.Strings[i2])=1 then FilesFound.Delete(i2);
          if Formlog.CB_Log.Checked then FormLog.MemoDebugLog.Lines.Add('FilesFound.count='+inttostr(FilesFound.Count)+'  (* Holds all songfiles *)');
        end;
      end;
    end;
  end;

  try
    internalsongs:=FilesFound.Count;
  except
    ShowMessage('Internal error: FilesFound.Count');
  end;

  if Settings.IncludeExternalDirs.Count>0 then
  begin
    if not Settings.NASBug then
    begin
      for i:=0 to Settings.IncludeExternalDirs.Count-1 do
      begin
        FormSplash.Label1.Caption:=Vertaal('Loading all MUSIC files on external devices');  Application.ProcessMessages;
       if Settings.IncludeExternalDirsChecked[i] then
        begin
          CheckThisDir:=Settings.IncludeExternalDirs.Strings[i];
          if Formlog.CB_Log.Checked then FormLog.MemoDebugLog.Lines.Add('INCLUDEEXTERNALDIR (without NAS bug): CheckThisDir='+CheckThisDir);
          FilesTemp:=FindAllFiles(CheckThisDir, '*.mp3;*.flac;*.ogg;*.m4a;*.ape;*.mp4;*.aac;*.opus;*.dff;*.wav', True);
          if FilesTemp.Count>1 then for id := FilesTemp.Count-1 downto 1 do
          begin
            TempStr:=Copy(ExtractFilename(FilesTemp.Strings[id]),1,2);
            if Tempstr='._' then
            begin
              If Settings.DeleteMacOSFiles then DeleteFile(FilesTemp.Strings[id]);
              FilesTemp.Delete(id);
              if Formlog.CB_Log.Checked then FormLog.MemoDebugLog.Lines.Add('._file found and removed from list: '+FilesTemp.Strings[id]);
            end;
          end;
          FilesFound.AddStrings(FilesTemp);
          if Formlog.CB_Log.Checked then
          begin
            FormLog.MemoDebugLog.Lines.Add('FilesTemp.count='+inttostr(FilesTemp.Count)+'  (* Temp Var *)');
            FormLog.MemoDebugLog.Lines.Add('FilesFound.count='+inttostr(FilesFound.Count)+'  (* Holds all songfiles *)');
          end;
          FilesTemp.Free;
        end;
      end;
    end
                        else
    begin
     for i:=0 to Settings.IncludeExternalDirs.Count-1 do
     begin
      FormSplash.Label1.Caption:=Vertaal('Loading all MUSIC files on external devices (NAS bug workaround)');  Application.ProcessMessages;
       if Settings.IncludeExternalDirsChecked[i] then
       begin
         CheckThisDir:=Settings.IncludeExternalDirs.Strings[i];
         if Formlog.CB_Log.Checked then
         begin
           FormLog.MemoDebugLog.Lines.Add('INCLUDEEXTERNALDIR (with NAS bug): CheckThisDir='+CheckThisDir);
           FormLog.MemoDebugLog.Lines.Add('Should only happen in LINUX');
         end;
         OurProcess := TProcess.Create(nil);
         OurProcess.CommandLine := 'find "'+CheckThisDir+'" -fprint '+TempDir+DirectorySeparator+'songlist.xix';
         OurProcess.Options := [poWaitOnExit];
         OurProcess.Execute;
         OurProcess.Free;

         if FileExistsUTF8(Tempdir+Directoryseparator+'songlist.xix') then
         begin
           try
             AssignFile(Filevar,Tempdir+Directoryseparator+'songlist.xix');
             Reset(Filevar);
             repeat
               Readln(Filevar, lijn);
                {$IFDEF LINUX} lijn:=string(lijn); {$ENDIF}
               tempstr:=uppercase(ExtractFileExt(lijn));
               if (tempstr='.MP3') or (tempstr='.OGG') or (tempstr='.FLAC') or (tempstr='.M4A') or (tempstr='.APE') or (tempstr='.AAC') or (tempstr='.MP4') or (tempstr='.OPUS') or (tempstr='.DFF') or (tempstr='.WAV') (*or (tempstr='.WMA') *) then
               begin
                 TempStr:=Copy(ExtractFilename(lijn),1,2);
                 if Tempstr<>'._' then FilesFound.Add(lijn)
                                  else if Formlog.CB_Log.Checked then FormLog.MemoDebugLog.Lines.Add('._file found and removed from list: '+lijn);
               end;
             until eof(Filevar);
           finally
             CloseFile(Filevar);
           end;
         end;
         DeleteFile(Tempdir+Directoryseparator+'songlist.xix');
       end;
     end;
    end;

    for i:=0 to Settings.ExcludeExternalDirs.Count-1 do
    begin
      if Settings.ExcludeExternalDirsChecked[i] then
      begin
        CheckThisDir:=Settings.ExcludeExternalDirs.Strings[i];
        if Formlog.CB_Log.Checked then FormLog.MemoDebugLog.Lines.Add('EXCLUDEEXTERNALDIR (with NAS bug): CheckThisDir='+CheckThisDir);
        for i2:=FilesFound.Count-1 downto 0 do
          If Pos(CheckThisDir,FilesFound.Strings[i2])=1 then FilesFound.Delete(i2);
        if Formlog.CB_Log.Checked then if Formlog.CB_Log.Checked then FormLog.MemoDebugLog.Lines.Add('FilesFound.count='+inttostr(FilesFound.Count)+'  (* Holds all songfiles *)');
      end;
    end;
  end;

  if FilesFound.Count<2 then Setlength(Liedjes,2)
                         else Setlength(Liedjes,FilesFound.Count+2);
  maxsongs:=FilesFound.Count;
  FilesFound.Sorted:=True;
  Cursor:=crDefault;
  if Formlog.CB_Log.Checked then FormLog.MemoDebugLog.Lines.Add('>> END << TForm1.GetAllMusicFiles');
end;

procedure TForm1.GetExternalApps;
begin
  {$IFDEF UNIX}
    Settings.Lame:=FindDefaultExecutablePath('lame');
    Settings.Flac:=FindDefaultExecutablePath('flac');
    Settings.OGG:=FindDefaultExecutablePath('oggenc');
    Settings.Opus:=FindDefaultExecutablePath('opusenc');
    Settings.AAC:=FindDefaultExecutablePath('fdkaac');

    Settings.Mplayer:=FindDefaultExecutablePath('mplayer');

    if Settings.Lame='' then if FileExistsUTF8('/usr/bin/lame') then Settings.Lame:='/usr/bin/lame';
    if Settings.Lame='' then if FileExistsUTF8('/opt/local/bin/lame') then Settings.Lame:='/opt/local/bin/lame';
    if Settings.Lame='' then if FileExistsUTF8('/usr/local/bin/lame') then Settings.Lame:='/usr/local/bin/lame';
    if Settings.Lame='' then if FileExistsUTF8(StartDir+'/bin/lame') then Settings.Lame:=StartDir+'/bin/lame';

    if Settings.Flac='' then if FileExistsUTF8('/usr/bin/flac') then Settings.Flac:='/usr/bin/flac';
    if Settings.Flac='' then if FileExistsUTF8('/opt/local/bin/flac') then Settings.Flac:='/opt/local/bin/flac';
    if Settings.Flac='' then if FileExistsUTF8('/usr/local/bin/flac') then Settings.Flac:='/usr/local/bin/flac';
    if Settings.Flac='' then if FileExistsUTF8(StartDir+'/bin/flac') then Settings.Flac:=StartDir+'/bin/flac';

    if Settings.OGG='' then if FileExistsUTF8('/usr/bin/oggenc') then Settings.OGG:='/usr/bin/oggenc';
    if Settings.OGG='' then if FileExistsUTF8('/opt/local/bin/oggenc') then Settings.OGG:='/opt/local/bin/oggenc';
    if Settings.OGG='' then if FileExistsUTF8('/usr/local/bin/oggenc') then Settings.OGG:='/usr/local/bin/oggenc';
    if Settings.OGG='' then if FileExistsUTF8(StartDir+'/bin/oggenc') then Settings.OGG:=StartDir+'/bin/oggenc';

    if Settings.AAC='' then if FileExistsUTF8('/usr/bin/afdkaac') then Settings.AAC:='/usr/bin/fdkaac';
    if Settings.AAC='' then if FileExistsUTF8('/opt/local/bin/fdkaac') then Settings.AAC:='/opt/local/bin/fdkaac';
    if Settings.AAC='' then if FileExistsUTF8('/usr/local/bin/fdkaac') then Settings.AAC:='/usr/local/bin/fdkaac';
    if Settings.AAC='' then if FileExistsUTF8(StartDir+'/bin/fdkaac') then Settings.AAC:=StartDir+'/bin/fdkaac';

    if Settings.Opus='' then if FileExistsUTF8('/usr/bin/opusenc') then Settings.Opus:='/usr/bin/opusenc';
    if Settings.Opus='' then if FileExistsUTF8('/opt/local/bin/opusenc') then Settings.Opus:='/opt/local/bin/opusenc';
    if Settings.Opus='' then if FileExistsUTF8('/usr/local/bin/opusenc') then Settings.Opus:='/usr/local/bin/opusenc';
    if Settings.Opus='' then if FileExistsUTF8(StartDir+'/bin/opusenc') then Settings.Opus:=StartDir+'/bin/opusenc';

    if Settings.Mplayer='' then if FileExistsUTF8('/usr/bin/mplayer') then Settings.Mplayer:='/usr/bin/mplayer';
    if Settings.Mplayer='' then if FileExistsUTF8('/opt/local/bin/mplayer') then Settings.Mplayer:='/opt/local/bin/mplayer';
    if Settings.Mplayer='' then if FileExistsUTF8(StartDir+'/bin/mplayer') then Settings.Mplayer:=StartDir+'/bin/mplayer';
  {$ENDIF}

  {$IFDEF WINDOWS}
    Settings.Lame:=FindDefaultExecutablePath('lame.exe');
    if Settings.Lame='' then if FileExistsUTF8(Startdir+'\lame\lame.exe') then Settings.Lame:=Startdir+'\lame\lame.exe';
    if Settings.Lame='' then if FileExistsUTF8(Configdir+'\bin\lame\lame.exe') then Settings.Lame:=Configdir+'\bin\lame\lame.exe';
    Settings.Flac:=FindDefaultExecutablePath('flac.exe');
    if Settings.Flac='' then if FileExistsUTF8(Startdir+'\flac\flac.exe') then Settings.Flac:=Startdir+'\flac\flac.exe';
    if Settings.Flac='' then if FileExistsUTF8(ConfigDir+'\bin\flac\win32\flac.exe') then Settings.Flac:=Configdir+'\bin\flac\win32\flac.exe';
    Settings.AAC:=FindDefaultExecutablePath('fdkaac.exe');
    if Settings.AAC='' then if FileExistsUTF8(ConfigDir+'\bin\fdkaac\fdkaac.exe') then Settings.AAC:=ConfigDir+'\bin\fdkaac\fdkaac.exe';
    Settings.Mplayer:=FindDefaultExecutablePath('mplayer.exe');
  {$ENDIF}
end;


procedure TForm1.LB_ArtiestResize(Sender: TObject);
begin
  LB_Artiest.Left:=Trackbar2.Left+round(Trackbar2.Width/2)-round((LB_Artiest.Width+LB_CD.Width)/2)+15;
end;

procedure TForm1.LB_LastFMInfoClick(Sender: TObject);
begin
  PanelXiXInfo.Visible:=False;
  PanelLastFM.Visible:=True;
  Application.ProcessMessages;
  if SB_LastFM.Enabled then SB_LastFMClick(Self);
end;

procedure TForm1.LB_LastFMInfoMouseEnter(Sender: TObject);
begin
  LB_LastFMInfo.Font.Style:=[fsBold];
end;

procedure TForm1.LB_LastFMInfoMouseLeave(Sender: TObject);
begin
  LB_LastFMInfo.Font.Style:=[];
end;

procedure TForm1.Label30Click(Sender: TObject);
begin
  BrowseTo('http://www.listenlive.eu');
end;

procedure TForm1.LB_XiXInfoClick(Sender: TObject);
begin
  PanelXiXInfo.Visible:=True;
  PanelLastFM.Visible:=False;
end;

procedure TForm1.LB_XiXInfoMouseEnter(Sender: TObject);
begin
  LB_XiXInfo.Font.Style:=[fsBold];
end;

procedure TForm1.LB_XiXInfoMouseLeave(Sender: TObject);
begin
  LB_XiXInfo.Font.Style:=[];
end;

procedure TForm1.LabelLyricSourceClick(Sender: TObject);
begin
  if LabelLyricSource.Caption='-' then exit;
  if LabelLyricSource.Caption='*** CACHE ***' then Browseto('http://www.xixmusicplayer.org')
  else if pos('http',urlvar)=1 then if pos('xixmusicplayer',urlvar)>0 then Browseto('http://www.xixmusicplayer.org')
                                                                      else Browseto(urlvar);
end;

procedure TForm1.LB_Albums1KeyPress(Sender: TObject; var Key: char);
{$IFDEF DARWIN}
var ch: char;
    i: longint;
{$ENDIF}
begin
  if key=#13 then LB_Albums1DblClick(self);
  {$IFDEF DARWIN}
  if LB_Artist1.Items.Count>1 then
  begin
    if ((key>#47) and (key<#123)) or (key=#32) then
    begin
    //  LB_Albums1.MultiSelect:=False;
      ch:=upcase(key);
      zoekstring:=zoekstring+ch;
      For i:=1 to LB_Albums1.Items.Count-1 do
        if pos(zoekstring,upcase(LB_albums1.Items[i]))=1 then
        begin
          LB_Albums1.ItemIndex:=i; LB_Albums1.MakeCurrentVisible;
         // LB_Aalbums1.MultiSelect:=True;
          exit;
        end;
      zoekstring:=ch;
      For i:=1 to LB_Albums1.Items.Count-1 do
        if pos(zoekstring,upcase(LB_albums1.Items[i]))=1 then
        begin
          LB_Albums1.ItemIndex:=i; LB_Albums1.MakeCurrentVisible;
      //    LB_Albums1.MultiSelect:=True;
          exit;
        end;
    //  LB_Albums1.MultiSelect:=True;
    end;
  end;
 {$ENDIF}
end;

procedure TForm1.LB_Albums1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if ssRight in Shift then LB_Albums1.ItemIndex:=(LB_Albums1.GetIndexAtY(Y));
end;

procedure TForm1.LB_ArtiestClick(Sender: TObject);
var x: longint;
begin
  x:=LB_Artist1.Items.IndexOf(LB_Artiest.Caption);
  if x>=0 then
  begin
    PageControl1.ActivePageIndex:=0;
    LB_Artist1.ItemIndex:=x;
    LB_Artist1.MakeCurrentVisible;
    LB_Artist1Click(Self);
  end;
end;

procedure TForm1.LB_ArtiestMouseEnter(Sender: TObject);
begin
  LB_Artiest.Font.Underline:=True;
  LB_Artiest.Font.Color:=clGreen;
end;

procedure TForm1.LB_ArtiestMouseLeave(Sender: TObject);
begin
  LB_Artiest.Font.Underline:=False;
  LB_Artiest.Font.Color:=clDefault;
end;

procedure TForm1.LB_Artists2Click(Sender: TObject);
begin
  PanelVolume.Visible:=False; MI_RemoveFromPlaylist.Enabled:=False;
end;

procedure TForm1.LB_PlaylistDragDrop(Sender, Source: TObject; X, Y: Integer);
var Filevar:textFile;
    welke: longint;
begin
  if (Source=SG_Play) and (LB_Itemindex>=0) and (SG_Play.Row>0) then
  begin
    AssignFile(Filevar,ConfigDir+DirectorySeparator+'playlist'+DirectorySeparator+LB_Playlist.Items[LB_Itemindex]+'.xix');
    Append(Filevar);
    welke:=strtoint(SG_Play.Cells[6,SG_Play.Row]);
    Writeln(Filevar,Liedjes[welke].Pad+Liedjes[welke].Bestandsnaam);
    CloseFile(Filevar);
    FormShowMyDialog.ShowWith(LB_Playlist.Items[LB_Itemindex],Vertaal('Added the following song to the playlist'),'',Liedjes[welke].Bestandsnaam,'',Vertaal('Thanks'), False);
  end;
end;

procedure TForm1.LB_PlaylistDragOver(Sender, Source: TObject; X, Y: Integer;
  State: TDragState; var Accept: Boolean);
var oudeindex: integer;
begin
  oudeindex:=-2;
  If Source=SG_Play then Accept:=true
                    else Accept:=false;
  LB_itemindex:=LB_Playlist.GetIndexAtY(Y);
  if oudeindex<>LB_itemindex then
  begin
    oudeindex:=LB_itemindex;
    if LB_itemindex>=0 then
    begin
      LB_Playlist.Selected[LB_Itemindex]:=True;
    end;
  end;
end;

procedure TForm1.MI_VU_at_centerClick(Sender: TObject);
begin
  VU_Settings.Placement:=2; MI_VU_Active4.Checked:=False;
  MI_VU_at_center.Checked:=True;
  if VU_Settings.Active<>3 then
  begin
    VU_Settings.Active:=2;
    Panel_VUClick(Self);
  end;
end;

procedure TForm1.MI_VU_at_bottomClick(Sender: TObject);
begin
  VU_Settings.Placement:=3; MI_VU_Active4.Checked:=False;
  MI_VU_at_bottom.Checked:=True;
  if VU_Settings.Active<>3 then
  begin
    VU_Settings.Active:=2;
    Panel_VUClick(Self);
  end;
end;

procedure TForm1.MI_VU_showpeaksClick(Sender: TObject);
begin
  VU_Settings.ShowPeaks:=not VU_Settings.ShowPeaks;
  MI_VU_showpeaks.Checked:=VU_Settings.ShowPeaks;
end;

procedure TForm1.MI_VU_at_topClick(Sender: TObject);
begin
  VU_Settings.Placement:=1; MI_VU_Active4.Checked:=False;
  MI_VU_at_top.Checked:=True;
  if VU_Settings.Active<>3 then
  begin
    VU_Settings.Active:=2;
    Panel_VUClick(Self);
  end;
end;

procedure TForm1.MI_Play_ShowInVFSClick(Sender: TObject);
var sub_str, lijn  : string;
    Str            : TStringlist;
    i              : integer;
begin
  sub_str:=copy(Liedjes[strtoint(SG_Play.Cells[6,SG_Play.Row])].Pad, 1, length(Liedjes[strtoint(SG_Play.Cells[6,SG_Play.Row])].Pad));
  lijn:=sub_str;

  TabSheetVirtualFS.Show;
  Str := TStringlist.Create;
  while pos(DirectorySeparator,sub_str)>0 do
  begin
    lijn:=copy(sub_str,1,pos(DirectorySeparator,sub_str)-1);
    if (length(lijn)>0) {$IFDEF WINDOWS} and (pos(':',lijn)<1) {$ENDIF} then Str.Add(lijn);  // Windows: don't add the drive letter
    Delete(sub_str,1,pos(DirectorySeparator,sub_str));                                       //          Needs to be tested with music on separated drives
  end;

  aNode:=TV_VFS.Items.Item[0];        //Root Node
  For i:=0 to Str.Count-1 do
  begin
    aNode:=aNode.GetFirstChild; // Get the first node under the root Node
    if aNode.Text<>Str[i] then  // If the Node is not the one we search, get to the next sibling
    begin
      repeat
        aNode:=aNode.GetNextSibling;
      until aNode.Text=Str[i];  // Until found
    end;
  end;

  TV_VFS.Items.SelectOnlyThis(aNode);
end;

procedure TForm1.MenuItem106Click(Sender: TObject);
begin
  if OpenDialog2.Execute then
  begin
   MemoLyrics.Lines.LoadFromFile(OpenDialog2.FileName);
   LyricsNotFound.Free;
   LyricsNotFound:=TStringlist.Create;
  end;
end;

procedure TForm1.MenuItem107Click(Sender: TObject);
begin
  if not FormReverb.Visible then FormReverb.Show
                            else FormReverb.BringToFront;
end;

function TForm1.MakeWikiArtist(temp: string; ch: char): string;
var tempartist: string;
begin
  if ch='_' then
  begin
   tempartist:=lowercase(temp);
   case tempartist of
    '10.000 maniacs': temp:='10,000_Maniacs';
    '112': temp:='112_(band)';
    '2 brothers on the 4th floor': temp:='2_Brothers_on_the_4th_Floor';
    '3 drives on vinyl': temp:='Three_Drives';
    '311': temp:='311_(band)';
    '666': temp:='666_(band)';
    'abc': temp:='ABC_(band)';
    'acdc': temp:='AC/DC';
    'agnes': temp:='Agnes_(singer)';
    'anouk': temp:='Anouk_(singer)';
    'anthrax': temp:='Anthrax_(American_band)';
    'arsenal': temp:='Arsenal_(band)';
    'artful dodger': temp:='Artful_Dodger_(UK_band)';
    'bangles': temp:='The_Bangles';
    'biohazard': temp:='Biohazard_(band)';
    'blitz': temp:='Blitz_(band)';
    'blondie': temp:='Blondie_(band)';
    'blue': temp:='Blue_(English_band)';
    'blur': temp:='Blur_(band)';
    'boston': temp:='Boston_(band)';
    'brad': temp:='Brad_(band)';
    'brainstorm': temp:='Brainstorm_(Latvian_band)';
    'breeders': temp:='The_Breeders';
    'bush': temp:='Bush_(band)';
    'cake': temp:='Cake_(band)';
    'cccp': temp:='C.C.C.P._(band)';
    'ccr': temp:='Creedence_Clearwater_Revival';
    'c.c.r.': temp:='Creedence_Clearwater_Revival';
    'clutch': temp:='Clutch_(band)';
    'crowbar': temp:='Crowbar_(American_band)';
    'daan': temp:='Daan_(band)';
    'danzig': temp:='Danzig_(band)';
    'day one': temp:='Day_One_(band)';
    'deus': temp:='Deus_(band)';
    'dido': temp:='Dido_(singer)';
    'dio': temp:='Dio_(band)';
    'disturbed': temp:='Disturbed_(band)';
    'dog eat dog': temp:='Dog_Eat_Dog_(band)';
    'editors': temp:='Editors_(band)';
    'eels': temp:='Eels_(band)';
    'eno': temp:='Brian_Eno';
    'falco': temp:='Falco_(musician)';
    'five': temp:='Five_(band)';
    'franz ferdinand': temp:='Franz_Ferdinand_(band)';
    'jewel': temp:='Jewel_(singer)';
    'genesis': temp:='Genesis_(band)';
    'goose': temp:='Goose_(band)';
    'gossip': temp:='Gossip_(band)';
    'helmet': temp:='Helmet_(band)';
    'hooters': temp:='The_Hooters';
    'l7': temp:='L7_(band)';
    'lamb': temp:='Lamb_(band)';
    'lit': temp:='Lit_(band)';
    'live': temp:='Live_(band)';
    'machine head': temp:='Machine_Head_(band)';
    'madonna': temp:='Madonna_(entertainer)';
    'marilyn manson': temp:='Marilyn_Manson_(band)';
    'meatloaf': temp:='Meat_Loaf';
    'mother tongue': temp:='Mother_Tongue_(band)';
    'mud': temp:='Mud_(band)';
    'muse': temp:='Muse_(band)';
    'nirvana': temp:='Nirvana_(band)';
    'nwa': temp:='N.W.A';
    'oasis': temp:='Oasis_(band)';
    'offspring': temp:='The_Offspring';
    'pennywise': temp:='Pennywise_(band)';
    'placebo': temp:='Placebo_(band)';
    'prince': temp:='Prince_(musician)';
    'primus': temp:='Primus_(band)';
    'public enemy': temp:='Public_Enemy_(group)';
    'queen': temp:='Queen_(band)';
    'red zebra': temp:='Red_Zebra_(band)';
    'rancid': temp:='Rancid_(band)';
    'royal blood': temp:='Royal_Blood_(band)';
    'sade': temp:='Sade_(band)';
    'saxon': temp:='Saxon_(band)';
    'snap': temp:='Snap!';
    'sophia': temp:='Sophia_(British_band)';
    'suede': temp:='Suede_(band)';
    'taj mahal': temp:='Taj_Mahal_(musician)';
    'telex': temp:='Telex_(band)';
    'texas': temp:='Texas_(band)';
    'the charlatans': temp:='The_Charlatans_(UK_band)';
    'the catherine wheel': temp:='Catherine_Wheel';
    'the presidents of the united states of america': temp:='The_Presidents_of_the_United_States_of_America_(band)';
    'pusa': temp:='The_Presidents_of_the_United_States_of_America_(band)';
    'therapy': temp:='Therapy%3F';
    'therapy?': temp:='Therapy%3F';
    'tomahawk': temp:='Tomahawk_(band)';
    'tool': temp:='Tool_(band)';
    'whale': temp:='Whale_(band)';
    'wham': temp:='Wham!';
    'white lies': temp:='White_Lies_(band)';
    else temp:=StringReplace(Temp,' ',ch,[rfReplaceAll]);
   end;
  end;
  if ch='+' then   // Last.fm
  begin
   tempartist:=lowercase(temp);
   case tempartist of
    'acdc': temp:='AC%2FDC';
    'artful dodger': temp:='The+Artful+Dodger';
    'beach boys': temp:='The+Beach+Boys';
    'the catherine wheel': temp:='Catherine+Wheel';
    'lou reed and metallica': temp:='Lou+Reed+&+Metallica';
    'nick cave & the bad seeds': temp:='Nick+Cave';
    'nick cave & grinderman': temp:='Nick+Cave';
    'the ramones': temp:='Ramones';
    'red hot chilli peppers': temp:='Red+Hot+Chili+Peppers';
    'the sweet': temp:='Sweet';
   end; //of case
   temp:=StringReplace(Temp,' ','+',[rfReplaceAll]);
  end;
  MakeWikiArtist:=Temp;
end;

procedure TForm1.RefreshArtistAlbums;
var Temp_StringList: TStringList;
    i, max: longint;
    tempartiest: String;
begin
  LB_Albums2.Clear;
  if LB_Artist1.ItemIndex<0 then
    exit;

  Temp_StringList:=TStringList.Create;
  Temp_StringList.Sorted:=True;
  Temp_StringList.Duplicates:=dupIgnore;

  if LB_Artist1.ItemIndex=0 then
  begin
    max:=maxsongs-1;
    for i:=0 to max do if not Liedjes[i].Deleted then Temp_StringList.Add(Liedjes[i].CD);
  end

                           else
  begin
    tempartiest:=Upcase(LB_Artist1.Items[LB_Artist1.ItemIndex]);
    max:=maxsongs-1;
    for i:=0 to max do
    begin
      if upcase(Liedjes[i].Artiest)=tempartiest then
         if not Liedjes[i].Deleted then Temp_StringList.Add(Liedjes[i].CD);
    end;
  end;

  LB_Albums2.Items.AddStrings(Temp_Stringlist); LB_Albums2.Items.Insert(0,Vertaal('All'));
  Temp_StringList.Free;
end;

procedure TForm1.RefreshAlbumArtists;
var Temp_StringList: TStringList;
    i: longint;
    currentCD: string;
begin
  LB_Artists2.Items.Clear;
  if LB_Albums1.ItemIndex<0 then
    exit;
  currentCD := LB_Albums1.Items[LB_Albums1.ItemIndex];
  Temp_StringList:=TStringList.Create;
  Temp_StringList.Sorted:=True; Temp_StringList.Duplicates:=dupIgnore;
  for i:=0 to maxsongs-1 do
    if not Liedjes[i].Deleted and (Liedjes[i].CD=currentCD) then
      Temp_StringList.Add(Liedjes[i].Artiest);
  LB_Artists2.Items.AddStrings(Temp_Stringlist);
  Temp_StringList.Free;
end;

procedure TForm1.MenuItem81Click(Sender: TObject);
begin
  BrowseTo('http://en.wikipedia.org/wiki/'+MakeWikiArtist(SG_Play.Cells[1,SG_Play.Row],'_'));
end;

procedure TForm1.MenuItem97Click(Sender: TObject);
var i, i_selected, teller, welke: longint;
    filesModified, tagsModified: boolean;
begin
  FormID3Tagger.ListBox1.Items.Clear;
  i_selected:=0; teller:=0;

  for i:=1 to SG_Play.RowCount-1 do
    begin
      if IsCellSelected(SG_Play,1,i) then
      begin
        inc(i_selected);
      end;
    end;

  if i_selected>0 then
  begin
    Setlength(Tag_Liedjes,i_selected+1); Setlength(TagVolgorde,i_selected+1);
    for i:=1 to SG_Play.RowCount-1 do
    begin
      if IsCellSelected(SG_Play,1,i) then
      begin
        welke:=strtoint(SG_Play.Cells[6,i]);
        Tag_Liedjes[teller]:=Liedjes[welke];
        Tag_Liedjes[teller].Modified := false;
        Tag_Liedjes[teller].FNModified := false;
        Liedjes[welke].Modified := false;
        Liedjes[welke].FNModified := false;
        TagVolgorde[teller]:=welke;
        FormID3Tagger.ListBox1.Items.Add(Tag_Liedjes[teller].Bestandsnaam);
        inc(teller);
      end;
    end;
    FormID3Tagger.Memo1.Lines.Clear;
    FormID3Tagger.Memo1.Lines.Add('# '+inttostr(i_selected)+' '+Form1.Vertaal('songs added'));
  end;

  FormID3Tagger.Showmodal;

  // teller holds the real Tag_Liedjes item count, use it.
  filesModified := false; tagsModified := false;
  for i:=0 to teller-1 do
  begin
    if Tag_Liedjes[i].Modified then
    begin
      Liedjes[TagVolgorde[i]].Modified := true;
      tagsModified := true;
    end;
    if Tag_Liedjes[i].FNModified then
    begin
      Liedjes[TagVolgorde[i]].FNModified := true;
      filesModified := true;
    end;
  end;
  if filesModified or tagsModified then
    RefreshLists(tagsModified, filesModified);

  Tag_Liedjes:=nil; TagVolgorde:=nil;
end;

procedure TForm1.Mi_Wiki1ENClick(Sender: TObject);
begin
  BrowseTo('http://en.wikipedia.org/wiki/'+MakeWikiArtist(LB_Artist1.Items[LB_Artist1.ItemIndex],'_'));
end;

procedure TForm1.MI_Wiki1CustomClick(Sender: TObject);
begin
  BrowseTo('http://'+Settings.Language+'.wikipedia.org/wiki/'+MakeWikiArtist(LB_Artist1.Items[LB_Artist1.ItemIndex],'_'));
end;

function TForm1.GetCDArtworkfromLastFM(song: longint): string;
var tx: Tstringlist;
    CDCoverurl, temp: string;
    i: integer;
    mode: byte; // O=Album, 1=Artist
    doorgaan: boolean=false;
begin
  DeleteFile(TempDir+DirectorySeparator+'CD.png');
  tx := tstringlist.Create; CDCoverURL:='x'; Result:='x';
  if length(trim(Liedjes[song].CD))>1 then
  begin
  {$IFDEF HAIKU}
  DeleteFile(TempDir+DirectorySeparator+'cdcover.tmp');
  if DownloadFile('http://ws.audioscrobbler.com/2.0/?method=album.getinfo&artist='+Form1.MakeWikiArtist(Liedjes[song].Artiest,'+')+'&album='+Liedjes[song].CD+'&api_key=a2c1434814fb382c6020043cbb13b10d',TempDir+DirectorySeparator+'cdcover.tmp')
    then
    begin
     doorgaan:=true;
      tx.LoadFromFile(TempDir+DirectorySeparator+'cdcover.tmp');
    end;
  if doorgaan then
  {$ELSE}
  if HttpGetText('http://ws.audioscrobbler.com/2.0/?method=album.getinfo&artist='+Form1.MakeWikiArtist(Liedjes[song].Artiest,'+')+'&album='+Liedjes[song].CD+'&api_key=a2c1434814fb382c6020043cbb13b10d',tx) then
  {$ENDIF}
  begin
      i:=0;
      repeat
        if pos('extralarge',tx.strings[i])>1 then
        begin
          temp:=tx.Strings[i];
          Delete(temp,1,pos('extralarge',temp)+11); Delete(temp,length(temp)-7,8);
          CDCoverurl:=temp;
          mode:=0;
        end;
        inc(i);
       until pos('/lfm',tx.Strings[i])>0;
     end;
  end;
 (* LastFM does not show pictures of  Artists anymore

 if (CDCoverURL='x') or (length(CDCoverURL)<2) then
  begin
    tx.Clear;
    if HTTPGetText('http://ws.audioscrobbler.com/2.0/?method=artist.getTopTracks&artist='+Form1.MakeWikiArtist(Liedjes[song].Artiest,'+')+'&api_key=a2c1434814fb382c6020043cbb13b10d', tx) then
    begin
      i:=0;
      repeat
        if pos('extralarge',tx.strings[i])>1 then
        begin
          temp:=tx.Strings[i];
          Delete(temp,1,pos('extralarge',temp)+11); Delete(temp,length(temp)-7,8);
          CDCoverurl:=temp;

          mode:=1;
          break;
        end;
        inc(i);
       until pos('/lfm',tx.Strings[i])>0;
     end;
  end;    *)

  tx.Free;
  if (CDCoverURL<>'x') and (length(CDCoverURL)>1) then
  begin

    CDCoverURL:=StringReplace(CDCoverURL,'https','http',[rfReplaceAll]);
    DownLoadFile(CDCoverURL, TempDir+DirectorySeparator+'CD.png'); result:= TempDir+DirectorySeparator+'CD.png';
    if mode=0 then
    begin
       CopyFile(TempDir+DirectorySeparator+'CD.png', Settings.CacheDirCDCover+DirectorySeparator+convertArtist(Liedjes[song].Artiest,true)+'-'+convertalbum(Liedjes[song].CD)+'.png');
       GetCDArtworkfromLastFM:=Settings.CacheDirCDCover+DirectorySeparator+convertArtist(Liedjes[song].Artiest,true)+'-'+convertalbum(Liedjes[song].CD)+'.png';
    end;
    if mode=1 then
    begin
      CopyFile(TempDir+DirectorySeparator+'CD.png', Settings.CacheDirCDCover+DirectorySeparator+Convertartist(Liedjes[song].Artiest,true)+'.png');
      GetCDArtworkfromLastFM:=Settings.CacheDirCDCover+DirectorySeparator+Convertartist(Liedjes[song].Artiest,true)+'.png';
    end;
  end
  else GetCDArtworkfromLastFM:='x';
  FormLog.MemoDebugLog.Lines.Add('LastFM CD Cover: '+CDCoverURL);
end;

function TForm1.GetCDArtworkFromFile(song: string): string;
var Filevar, FileOut: File of char;
    ch1, ch2, ch3, ch4, ch5: char;
    Header: Array[1..4] of char;
    gevonden, endreached, wrong: boolean;
    i, i2, i3, ilength, i4: longint;
    strlength, imgstring, ext, ext2, lijn: string;
    PictureStream: TStream;
    FlacTagCoverArt: TFlacTagCoverArtInfo;
    CoverArtInfo: TOpusVorbisCoverArtInfo;
    pictureIndex: integer;
begin
 gevonden:=false; i:=1; strlength:=''; imgstring:=''; //ShowMessage('1:'+Song);
 ext:=upcase(ExtractFileExt(Song));
 if ext='.MP3' then
 begin
  AssignFile(Filevar,song);
  {$I-}Reset(Filevar);{$I+}
  if IOResult<>0 then
  begin
    result := 'x';
    exit;
  end;
  for i:=1 to 10 do Read(Filevar,ch1);
  Header:='APIC';
  Repeat
    Read(Filevar,ch1);
    inc(i);
    if ch1=Header[1] then
    begin
      Read(Filevar,ch1);
      if ch1=Header[2] then
      begin
        Read(Filevar,ch1);
        if ch1=Header[3] then
        begin
          Read(Filevar,ch1);
          if ch1=Header[4] then
          begin
            gevonden:=true;
            // LENGTE TAG INLEZEN
            for i2:=1 to 4 do
            begin
              Read(Filevar,ch1);
              strlength:=strlength+inttohex(ord(ch1),2);
            end;
            ilength:=hextodec(strlength);

            // MIME TYPE INLEZEN
            for i2:=1 to 14 do
            begin
              Read(Filevar,ch1);
              if ch1<>#00 then imgstring:=imgstring+ch1;
            end;

            if pos('png',imgstring)>0 then ext2:='.png'
                                      else ext2:='.jpg';

            // IMAGE INLEZEN
            i4:=0;
            // PNG
            if ext2='.png' then
            begin
              repeat
                read(Filevar,ch1);
                inc(i4)
              until (ch1=#137) or (i4>100);
              if i4<100 then
              begin
                AssignFile(Fileout,TempDir+DirectorySeparator+'CD.png');
                Rewrite(Fileout); write(FileOut,ch1);
                repeat
                  inc(i4);
                  read(Filevar,ch1); write(FileOut,ch1);
                until i4>=ilength-12;
                CloseFile(FileOut);
              end;
            end;

            // JPEG
            if ext2='.jpg' then
            begin
              i3:=0;wrong:=false;
              repeat
                Read(Filevar,ch1); inc(i3)
              until (ch1=#255) or (i3>1000000);  //Tot eerste FF
              AssignFile(Fileout,TempDir+DirectorySeparator+'CD.jpg');
              Rewrite(Fileout);
              write(FileOut,ch1);
              repeat
                inc(i4);
                read(Filevar,ch1); write(FileOut,ch1);
                if ch1=#255 then
                begin
                  inc(i4);
                  if not threadrunning then
                  begin
                    GetCDArtworkFromFile:='x';
                    CloseFile(FileOut);
                    Exit;
                  end;
                  read(Filevar,ch1);   if (i4=3) and (ch1=#00) then wrong:=true;
                //  if i4=3 then showmessage(inttostr(i4)+'-'+inttostr(ord(ch1)));
                  // PARSING WRONG JPEG FILE FORMAT  FF 00 00 xx --> FF 00 xx
                  if (wrong) and (ch1=#00) then
                  begin
                    read(Filevar,ch2); read(Filevar,ch3); i4:=i4+2;
                    if (ch2=#00) and (ch3<>#00) then
                    begin
                     write(FileOut,ch2); write(FileOut, ch3);
                    end
                    else
                    begin
                      write(FileOut,ch1); write(FileOut,ch2); write(FileOut, ch3);
                    end;
                  end
                  else write(FileOut, ch1); // ch1 <> van #00

                  // SOMETHING GONE WRONG IN THE ID3-TAG SIZETAG
                  if ch1=#217 then
                  begin
                   endreached:=true;
                   read(Filevar,ch1); if ch1<>#00 then endreached:=false;
                   read(Filevar,ch2); if ch2<>#00 then endreached:=false;
                   read(Filevar,ch3); if ch3<>#00 then endreached:=false;
                   read(Filevar,ch4); if ch4<>#00 then endreached:=false;
                   read(Filevar,ch5); if ch5<>#00 then endreached:=false;
                   if not endreached then
                   begin
                     write(FileOut,ch1); write(FileOut,ch2);
                     write(FileOut,ch3); write(FileOut,ch4);
                     write(FileOut,ch5);
                     i4:=i4+5;
                   end
                   else i4:=ilength;
                  end;
                end;
              until i4>=ilength-13-i3;
              CloseFile(FileOut);
            end;
          end;
        end;
      end;
    end;
  until (eof(Filevar)) or gevonden or (i>2000);
  CloseFile(Filevar);
 end;

 if ext='.FLAC' then
 begin
   id3Flac:=TFLACfile.Create; Picturestream:=TMemorystream.create;
   id3flac.readfromfile(song);
   if id3flac.GetCoverArt(0, Picturestream,FlacTagCoverArt) then
   begin
     gevonden:=true;
     FlacTagCoverArt.MIMEType := LowerCase(FlacTagCoverArt.MIMEType);
     PictureStream.Seek(0, soFromBeginning);
     if (FlacTagCoverArt.MIMEType = 'image/jpeg') OR (FlacTagCoverArt.MIMEType = 'image/jpg') then ext2 := '.jpg';
     if (FlacTagCoverArt.MIMEType = 'image/png') then ext2 := '.png';
     if (FlacTagCoverArt.MIMEType = 'image/gif') then
     begin
       ext2 := '.gif';
       gevonden:=false;  // TEMP:  File must be converted to JPEG
     end;
     if FlacTagCoverArt.MIMEType = 'image/bmp' then
     begin
       ext2 := '.bmp';
       gevonden:=false;  // TEMP:  File must be converted to JPEG
     end;
     if gevonden then TMemoryStream(PictureStream).SaveToFile(TempDir+DirectorySeparator+'CD'+ext2);
   end
   else gevonden:=false;
   id3flac.destroy; FreeAndNil(PictureStream);
  end;

  if (ext='.OPUS') or (ext='.OGG')  then
  begin
     Id3OpusTest:=TOpusTag.Create; Picturestream:=TMemorystream.create;
     id3OpusTest.LoadFromFile(song);
     pictureIndex:=id3OpusTest.FrameExists('METADATA_BLOCK_PICTURE');
     if id3OpusTest.CoverArtCount>0 then
     begin
       FormLog.MemoDebugLog.Lines.Add(Inttostr(id3OpusTest.CoverArtCount));
       if id3OpusTest.GetCoverArtFromFrame(pictureIndex,PictureStream,CoverArtInfo) then
       begin
         gevonden:=true;
         CoverArtInfo.MIMEType := LowerCase(CoverArtInfo.MIMEType);
         PictureStream.Seek(0, soFromBeginning);
         if (CoverArtInfo.MIMEType = 'image/jpeg') OR (CoverArtInfo.MIMEType = 'image/jpg') then ext2 := '.jpg';
         if (CoverArtInfo.MIMEType = 'image/png') then ext2 := '.png';
         if (CoverArtInfo.MIMEType = 'image/gif') then
         begin
           ext2 := '.gif';
           gevonden:=false;  // TODO:  File must be converted to JPEG
         end;
         if CoverArtInfo.MIMEType = 'image/bmp' then
         begin
           ext2 := '.bmp';
           gevonden:=false;  // TODO:  File must be converted to JPEG
         end;
       if gevonden then TMemoryStream(PictureStream).SaveToFile(TempDir+DirectorySeparator+'CD'+ext2);
     end
     else gevonden:=false;
     end;
     id3OpusTest.Free; FreeAndNil(PictureStream);
  end;

  if gevonden then
              begin
                 GetCDArtworkFromFile:=TempDir+DirectorySeparator+'CD'+ext2;
                 if length(Liedjes[songplaying].CD)>0 then
                 begin
                   lijn:=convertArtist(Liedjes[songplaying].Artiest,true)+'-'+convertalbum(Liedjes[songplaying].CD);
                   //formlog.MemoDebugLog.Lines.Add('File should be copied to '+Settings.CacheDirCDCover+DirectorySeparator+lijn+ext2);
                   CopyFile(TempDir+DirectorySeparator+'CD'+ext2,Settings.CacheDirCDCover+DirectorySeparator+lijn+ext2);
                 end;
              end
              else GetCDArtworkFromFile:='x';

end;

procedure TForm1.MI_GetArtworkFromFileClick(Sender: TObject);
var temp: string;
begin
  threadrunning:=True;
  temp:=GetCDArtworkFromFile(Liedjes[songplaying].Pad+Liedjes[songplaying].Bestandsnaam);
  if temp<>'x' then
  begin
    FormLog.MemoDebugLog.Lines.Add('GetCDArtworkFromFile success');
    ImageCDCover.Picture.LoadFromFile(temp);
    if Settings.CDCoverInfo and Settings.CDCoverLyrics then
       begin
         ImageCDCoverLyric.Picture.Bitmap:=ImageCdCover.Picture.Bitmap;
         FormCoverPlayer.ImageCDCover.Picture.Bitmap:=ImageCdCover.Picture.Bitmap;
         if not Form1.Splitter4.Enabled then
         begin
           Form1.Splitter4.Enabled:=True;
           Form1.Splitter4.Top:=26+Form1.ImageCDCoverLyric.Width+1;
         end
         else Form1.Splitter4.Top:=26+Form1.ImageCDCoverLyric.Width+1;
         Form1.Splitter4Moved(Form1.Stringgrid1);
       end;
  end;
  threadrunning:=False;
end;

procedure TForm1.MI_DeleteArtistInfoClick(Sender: TObject);
begin
  if FileExistsUTF8(Configdir+Directoryseparator+'artist'+Directoryseparator+ArtiestInfo) then
  begin
     DeleteFile(Configdir+Directoryseparator+'artist'+Directoryseparator+ArtiestInfo);
     MemoArtiest.Lines.Clear;
     LB_Genre.Caption:='-'; LabelSimilar.Caption:='-'; ArtiestInfoBio:='x';
  end;
end;

procedure TForm1.MI_CurrentSong1Click(Sender: TObject);
var i, rij: longint;
    values: array[1..6] of string;
begin
  rij:=songrowplaying;
  For i:=SG_Play.RowCount-1 downto 1 do
    if IsCellSelected(SG_Play,1,i) then
    begin
      if rij<>i then    //No need to move the song that currently is playing
      begin
        values[1]:=SG_Play.Cells[1,i]; values[2]:=SG_Play.Cells[2,i];
        values[3]:=SG_Play.Cells[3,i]; values[4]:=SG_Play.Cells[4,i];
        values[5]:=SG_Play.Cells[5,i]; values[6]:=SG_Play.Cells[6,i];
        SG_Play.InsertColRow(False,rij+1);
        SG_Play.Cells[1,rij+1]:=values[1];
        SG_Play.Cells[2,rij+1]:=values[2];
        SG_Play.Cells[3,rij+1]:=values[3];
        SG_Play.Cells[4,rij+1]:=values[4];
        SG_Play.Cells[5,rij+1]:=values[5];
        SG_Play.Cells[6,rij+1]:=values[6];
        if i>rij then SG_Play.DeleteRow(i+1)
                 else
                   begin
                     SG_Play.DeleteRow(i);
                     dec(songrowplaying);
                   end;
      end;
    end;
end;

procedure TForm1.MenuItem120Click(Sender: TObject);
begin
  EditRadioStation:=False;
  FormAddRadio.Edit1.Text:=SG_ListenLive.Cells[1,SG_ListenLive.Row];
  FormAddRadio.Edit2.Text:=SG_ListenLive.Cells[2,SG_ListenLive.Row];
  FormAddRadio.Edit3.Text:=SG_ListenLive.Cells[3,SG_ListenLive.Row];
  FormAddRadio.Edit4.Text:=SG_ListenLive.Cells[4,SG_ListenLive.Row];
  FormAddRadio.Edit7.Text:=SG_ListenLive.Cells[5,SG_ListenLive.Row];
  FormAddRadio.SpeedButton1Click(Self);
end;

procedure TForm1.MI_AddFolderToConfigClick(Sender: TObject);
var folder: string;
    i: integer;
begin
//  folder:=ShellTreeview1.GetSelectedNodePath;
  folder:=ShellTreeView1.GetPathFromNode(ShellTreeView1.Selected);
  if Settings.IncludeLocaleDirs.Count>0 then
  begin
   for i:=1 to Settings.IncludeLocaleDirs.Count do
   begin
     if pos(Settings.IncludeLocaleDirs.Strings[i-1],folder)>0 then
     begin
       showmessage(folder+' is already a part of the folders being used. See "Include Locale Folders" setting');
       exit;
     end;
     if pos(folder,Settings.IncludeLocaleDirs.Strings[i-1])>0 then
     begin
       showmessage('a subfolder of '+folder+' is already a part of the folders being used.'+#32+'Please remove subfolder first before adding the chosen folder. See "Include Locale Folders" setting');
       exit;
     end;
   end;
  end;
  if Settings.IncludeExternalDirs.Count>0 then
  begin
   for i:=1 to Settings.IncludeExternalDirs.Count do
   begin
     if pos(Settings.IncludeExternalDirs.Strings[i-1],folder)>0 then
     begin
       showmessage(folder+' is already a part of the folders being used. See "Include External Folders" setting');
       exit;
     end;
     if pos(folder,Settings.IncludeExternalDirs.Strings[i-1])>0 then
     begin
       showmessage('a subfolder of '+folder+' is already a part of the folders being used.'+#32+'Please remove subfolder first before adding the chosen folder.  See "Include External Folders" setting');
       exit;
     end;
   end;
  end;
  if FormShowMyDialog.ShowWith(Vertaal('WARNING'),Vertaal('Do you want to add the folder to LOCAL or EXTERNAL folders'),Vertaal('EXTERNAL is the best choice for NETWORK or USB drives'),folder,Vertaal('LOCAL'),Vertaal('EXTERNAL'), False) then
  begin
    //ShowMessage('LOCAL');
    Settings.IncludeLocaleDirs.Add(folder);
    Setlength(Settings.IncludeLocaleDirsChecked,Settings.IncludeLocaleDirs.Count);
    Settings.IncludeLocaleDirsChecked[Settings.IncludeLocaleDirs.Count-1]:=true;
  end
  else
  begin
    //ShowMessage('EXTERNAL');
    Settings.IncludeExternalDirs.Add(folder);
    Setlength(Settings.IncludeExternalDirsChecked,Settings.IncludeExternalDirs.Count);
    Settings.IncludeExternalDirsChecked[Settings.IncludeExternalDirs.Count-1]:=true;
  end;
  WriteConfig;
  FormShowMyDialog.ShowWith('Reload MP3 Files',Form1.Vertaal('You have changed the folders'),Form1.Vertaal('Files will be reloaded'),'UNTESTED - Needs some extra love','',Form1.Vertaal('OK'), False);
  FormSplash.Show;
  //Form1.LB_Artist1.Items.Delete(0); Form1.LB_Albums1.Items.Delete(0);
  Form1.LB_Artist1.Items.Clear; //Form1.LB_Artist1.Items.Add('All');
  Form1.LB_Albums1.Items.Clear;
  Liedjes:=nil;DB_Liedjes:=nil; FilesFound.Clear; max_records:=0;
  ReadDatabase;
  GetAllMusicFiles;
  GetMusicDetails;
  FillVirtualFSTree;
  AutoSizeAllColumns;
  FormSplash.Hide;
  //ShowMessage(ShellTreeview1.GetSelectedNodePath);// Shelllistview1.GetPathFromItem(ShellListview1.Selected));
end;

procedure TForm1.MI_RemoveFromPlaylistClick(Sender: TObject);
var bestand: string;
    Filevar: TextFile;
    i, i2, max: longint;
begin
  if SG_All.RowCount>1 then
  begin
    bestand:=ConfigDir+DirectorySeparator+'playlist'+DirectorySeparator+geladenplaylist+'.xix';
    if FileExistsUTF8(bestand) then
    begin
      i2:=0; max:=SG_All.RowCount-1;
      AssignFile(Filevar,bestand);
      Rewrite(Filevar);
      For i := 1 to max do
      begin
         if not IsCellSelected(SG_All,1,i) then Writeln(Filevar,Liedjes[strtoint(SG_All.Cells[0,i])].Pad+Liedjes[strtoint(SG_All.Cells[0,i])].Bestandsnaam)
                                           else inc(i2);
      end;
      CloseFile(Filevar);
      FormShowMyDialog.ShowWith(geladenplaylist,inttostr(i2)+' '+Vertaal('Songs removed from the playlist')+':','',geladenplaylist,'',Vertaal('Thanks'), False);
      for i:=max downto 1 do if IsCellSelected(SG_All,1,i) then SG_all.DeleteRow(i);
    end;
  end
  else ShowMessage('Nothing to do');
end;

procedure TForm1.MI_OpenAlbumInTagger1Click(Sender: TObject);
begin
  MI_GoToAlbumClick(Self);
  Application.ProcessMessages;
  MI_TagAlbum2Click(Self);
end;

procedure TForm1.MI_PlayAlbum2Click(Sender: TObject);
begin
  LB_Albums1Click(Self); Application.ProcessMessages;
  SG_AllDblClick(Self);
end;

procedure TForm1.MI_TagAlbum2Click(Sender: TObject);
begin
  LB_Albums1Click(Self); Application.ProcessMessages;
  if SG_All.RowCount>1 then
  begin
   (* DOES NOT WORK -->    SG_All.Selection:=TGridRect(Rect(1, 1, 4, SG_All.RowCount-1));
      SOLVED using MI_TAGARTIST1 as sender and using al items from SG_All *)
    MI_SGALL_TaggerClick(MI_TagAlbum2);
  end;
end;

procedure TForm1.MI_PlayArtist1Click(Sender: TObject);
begin
  LB_Artist1.ClearSelection; LB_Artist1.Selected[LB_Artist1.ItemIndex]:=true;
  LB_Artist1Clicked; Application.ProcessMessages;
  SG_AllDblClick(Self);
end;

procedure TForm1.MI_TagArtist1Click(Sender: TObject);
begin
  LB_Artist1.ClearSelection; LB_Artist1.Selected[LB_Artist1.ItemIndex]:=true;
  LB_Artist1Clicked; Application.ProcessMessages;
  if SG_All.RowCount>1 then
  begin
   (* DOES NOT WORK -->    SG_All.Selection:=TGridRect(Rect(1, 1, 4, SG_All.RowCount-1));
      SOLVED using MI_TAGARTIST1 as sender and using al items from SG_All *)
    MI_SGALL_TaggerClick(MI_TagArtist1);
  end;
end;

procedure TForm1.MenuItem65Click(Sender: TObject);
var test: string;
    Filevar: TextFile;
    i,i2, max: longint;
begin
  if LB_Playlist.ItemIndex>-1 then
  begin
    test:=LB_Playlist.Items[LB_Playlist.ItemIndex];
    If FileExistsUTF8(ConfigDir+DirectorySeparator+'playlist'+DirectorySeparator+test+'.xix') then
    begin
      i2:=0; max:=SG_Play.RowCount-1;
      AssignFile(Filevar,ConfigDir+DirectorySeparator+'playlist'+DirectorySeparator+test+'.xix');
      Append(Filevar);
      For i := 1 to max do
      begin
         if IsCellSelected(SG_Play, 1,i) then
         begin
          inc(i2);
           Writeln(Filevar,Liedjes[strtoint(SG_Play.Cells[6,i])].Pad+Liedjes[strtoint(SG_Play.Cells[6,i])].Bestandsnaam);
         end;
      end;
      CloseFile(Filevar);
      FormShowMyDialog.ShowWith(Test,inttostr(i2)+' '+Vertaal('Songs added to the playlist')+':','',test,'',Vertaal('Thanks'), False);
    end
    else FormShowMyDialog.ShowWith(Vertaal('WARNING'),Vertaal('No playlist selected'),'',Vertaal('Please select a playlist and try again'),'',Vertaal('Thanks'), False);
  end;
end;

procedure TForm1.MI_Vu3Click(Sender: TObject);
begin
  KiesVuImage(3);
  if VU_Settings.Active<>2 then
  begin
    VU_Settings.Active:=1;
    Panel_VUClick(Self);
  end;
end;

procedure TForm1.MenuItem47Click(Sender: TObject);
begin
  EditRadioStation:=True;
  gekozenradio:=strtointdef(StringgridRadioAir.Cells[0,StringgridRadioAir.row],2001);
  if gekozenradio>2000 then FormAddRadio.ShowModal
                       else FormShowMyDialog.ShowWith(Form1.Vertaal('Edit radiostation'),Vertaal('Only added Radiostation can be edited'),'','','',Vertaal('OK'), False);
  EditRadioStation:=False;
end;

procedure TForm1.RadioStationsOpslaan;
var Filevar: TextFile;
    i: integer;
begin
   if PersonalRadio= 2000 then DeleteFile(Settings.cacheDirRadio+'radio.prs')
                          else
   begin
     AssignFile(Filevar,Settings.cacheDirRadio+'radio.prs');
     Rewrite(Filevar);
     for i:=2001 to PersonalRadio do
     begin
       Writeln(Filevar,Inttostr(i));
       Writeln(Filevar,Radiostation[i].naam);
       Writeln(Filevar,Radiostation[i].land);
       Writeln(Filevar,Radiostation[i].genres);
       Writeln(Filevar,Radiostation[i].website);
       Writeln(Filevar,Radiostation[i].logo1);
       Writeln(Filevar,'');
       Writeln(Filevar,Radiostation[i].link);
       Writeln(Filevar,Radiostation[i].volgorde);
       Writeln(Filevar,'');
     end;
     CloseFile(Filevar);
   end;
end;

procedure TForm1.MenuItem48Click(Sender: TObject);
var i: integer;
begin
  if strtointdef(stringgridRadioAir.Cells[0,StringgridRadioAir.Row],0)>2000 then
  begin
    if StringgridPresets.RowCount > 1 then
    begin
      for i:=1 to StringgridPresets.RowCount-1 do
        if stringgridPresets.Cells[0,i]=stringgridRadioAir.Cells[0,StringgridRadioAir.Row] then
        begin
           StringgridPresets.Row:=i;
           SB_DeletePresetClick(Self);
        end;
    end;
    StringGridRadioAir.DeleteRow(StringGridRadioAir.Row);
    dec(PersonalRadio);
    RadioStationsOpslaan;
  end
  else FormShowMyDialog.ShowWith(Vertaal('WARNING'),'',Vertaal('Only added radiostations can de deleted'),'','',Vertaal('OK'), False);
end;

procedure TForm1.MI_AboutClick(Sender: TObject);
begin
  FormAbout.ShowModal;
end;

procedure TForm1.MenuItem93Click(Sender: TObject);
begin
  MemoLyrics.Lines.Savetofile(CachedLyrics);
end;

procedure TForm1.MenuItem95Click(Sender: TObject);
begin
  if not FormEcho.Visible then FormEcho.Show
                          else Formecho.BringToFront;
end;

procedure TForm1.MenuItem99Click(Sender: TObject);
begin
  FormFlanger.Show;
end;

procedure TForm1.MI_ReloadArtistInfoClick(Sender: TObject);
begin
  MI_DeleteArtistInfoClick(Self);
  if ThreadArtiestInfoRunning then ThreadGetArtiestInfo.Terminate;
  ThreadGetArtiestInfo:=TSearchForArtistInfoThread.Create(False);
 // MI_ReloadSongtextClick(Self);
end;

procedure TForm1.MI_RemoveSongtextClick(Sender: TObject);
begin
  DeleteFile(CachedLyrics);
  MemoLyrics.Lines.Clear;
end;

procedure TForm1.MI_ReloadSongtextClick(Sender: TObject);
begin
 if ThreadSongTextRunning then ThreadSongText.Terminate;
 MemoLyrics.Lines.Clear;
 ArtiestInfo:=ConvertArtist(LB_artiest.Caption, false);
 If  (LB_Artiest.Caption<>'--') and (LB_Titel.Caption<>'--') then
 begin
   id3extra.lyric:=''; ArtistLyric:=LB_Artiest.Caption; TitleLyric:=LB_Titel.Caption;
   //NOG VERANDEREN
   CachedLyrics:=Configdir+Directoryseparator+'songtext'+Directoryseparator+ArtiestInfo+'-'+ConvertTitle(LB_Titel.Caption)+'.lrc'; // ARRAY 0 contains a link to the cached songtext
   if stream<3 then
   begin
     GetId3Extra(songplaying);
     if id3extra.lyric<>'' then
     begin
       MemoLyrics.Text:=id3extra.lyric;
       FormCoverPlayer.LabelLyrics.Caption:=Form1.MemoLyrics.Caption;
       LabelLyricSource.Caption:='ID3-Tag';
     end;
   end;
   if id3extra.lyric='' then
   begin
     LyricsNotFound.Free;
     LyricsNotFound:=TStringlist.Create;
     SearchLyrics:=0;
     ThreadSongText:=TSearchForSongTextThread.Create(False);
   end;
 end;
end;

procedure TForm1.Panel14Click(Sender: TObject);
begin
  Panel15.Visible:=False;
end;

procedure TForm1.SB_CDTextClick(Sender: TObject);
{$IF defined(WINDOWS) or defined(LINUX)}
var
  info: BASS_CD_INFO;
    cd_total_tracks, i, l, a, max: longint;
    cddb_id, CD_UPC, cddb_query, tags, atext, ttext, ttime, talbum, temp, artist: string;
    t: PAnsiChar;
    lijn, cddb_Query2: String;
    {$IFEND}
begin
    {$IF defined(WINDOWS) or defined(LINUX)}cd_text:=BASS_CD_GETID(0,BASS_CDID_TEXT);
   // Memo1.Lines.Add(cd_text);
    application.ProcessMessages;
    cd_total_tracks:=BASS_CD_GetTracks(0);
    StringGridCD.RowCount:=cd_Total_tracks+1;
    max:=cd_total_tracks;
    atext:='Unknown';
    for i := 0 to max do
    begin
      Application.ProcessMessages;
      if i>0 then
      begin
        l := BASS_CD_GetTrackLength(0, i-1);
        ttext := Format('Track %.2d', [i]);
     end;


      if (cd_text <> nil) then
      begin
        t := cd_text;
        tags := Format('TITLE%d=', [i]); // the CD-TEXT tag to look for
      try
        while (t <> nil) do
        begin
          if (Copy(t, 1, Length(tags)) = tags) then // found the track title...
           begin
             ttext := Copy(t, Length(tags)+1, Length(t) - Length(tags)); // replace "track x" with title
             Memo1.Lines.Add(ttext);
             if i=0 then talbum:=ttext;
             Break;
           end;
           t := t + Length(t) + 1;
        end;
       except
        showmessage('Something went wrong in CD-TEXT with var (ttext) - title');
       end;

        t := cd_text;
        application.ProcessMessages;

        if atext<>'' then
        begin
          tags := Format('PERFORMER%d=', [i]); // the CD-TEXT tag to look for
          try
            while (t <> nil) and (length(t)>1) do
            begin
             if (Copy(t, 1, Length(tags)) = tags) then // found the track title...
             begin
               atext := Copy(t, Length(tags)+1, Length(t) - Length(tags)); // replace "track x" with title
               Memo1.Lines.Add(atext); if i=0 then artist:=atext;
               Break;
             end;
             t := t + Length(t) + 1;
            end;
          except
          showmessage('Something went wrong in CD-TEXT with var (atext) - title');
        end;
       end
       else Memo1.Lines.Add('atext');
      end;

      if i>0 then
      begin
        if (l = -1) then ttext :=ttext + ' (data)'
        else
        begin
          try
            l := l div 176400;
          except
            showmessage('Something went wrong in CD-TEXT with var (l) - time');
          end;
          try
            ttime := Format('%d:%.2d', [l div 60, l mod 60]);
          except
            showmessage('Something went wrong in CD-TEXT with var (ttime) - time');
          end;
        end;
      end;


     if I>0 then
     begin
      CD[i].Titel:=ttext;
      CD[i].tijd:=ttime;
      if atext='' then CD[i].artiest:=artist
                  else CD[i].artiest:=atext;
      CD[i].Album:=talbum;
      StringgridCD.Cells[1,i]:=CD[i].artiest;
      StringgridCD.Cells[2,i]:=ttext;
      StringgridCD.Cells[3,i]:=talbum;
      StringgridCD.Cells[4,i]:=ttime;
     end
    end;
    {$IFEND}
end;

procedure TForm1.SB_SaveClick(Sender: TObject);
var Filevar: textFile;
    i: longint;
begin
  SB_Save.Enabled:=False;
  AssignFile(Filevar, Configdir+DirectorySeparator+'playlist'+DirectorySeparator+GetoondePlaylist+'.xix');
  Rewrite(Filevar);
      For i := 1 to Form1.SG_All.RowCount-1 do
      begin
         Writeln(Filevar,GetGridFilename(i));
      end;
  CloseFile(Filevar);
end;

procedure TForm1.SG_AllColRowInserted(Sender: TObject; IsColumn: Boolean;
  sIndex, tIndex: Integer);
begin

end;

procedure TForm1.SG_AllColRowMoved(Sender: TObject; IsColumn: Boolean; sIndex,
  tIndex: Integer);
begin
   if getoondePlaylist<>'' then SB_Save.Enabled:=True;
end;

procedure TForm1.SG_AllDrawCell(Sender: TObject; aCol, aRow: Integer;
  aRect: TRect; aState: TGridDrawState);
begin
  if SearchpanelBrowser.Visible then
  begin
    if  not (gdfixed in aState) then
      begin
        if arow = SG_All.Row then
                                begin
                                  SG_All.Canvas.Brush.Color:=clHighLight;
                                  SG_All.Canvas.Font.Color:=clHighlightText;
                                end
                              else if odd(aRow) then SG_All.Canvas.Brush.Color:=SG_All.Color
                                                else SG_All.Canvas.Brush.Color:=SG_All.AlternateColor;
        SG_All.Canvas.FillRect(aRect);
        SG_All.Canvas.TextOut(aRect.Left+2, aRect.Top+2, SG_All.Cells[aCol, aRow]);
      end;
  end;
end;

procedure TForm1.SG_AllHeaderClick(Sender: TObject; IsColumn: Boolean;
  Index: Integer);
const
  LastSortedColumn:Integer=-1;
begin
  if not IsColumn then
    exit;
  if Index<0 then
  begin
    if LastSortedColumn>=0 then
    begin
      // re-sort the last sorted column in the same order
      SG_ALL.SortColRow(true, LastSortedColumn);
      exit;
    end
    else
      Index := 0;
  end;
  if LastSortedColumn<>Index then
    SG_ALL.SortOrder := soAscending
  else
  if SG_ALL.SortOrder=soDescending then SG_ALL.SortOrder := soAscending
  else                                  SG_ALL.SortOrder := soDescending;
  SG_ALL.SortColRow(true, index);
  LastSortedColumn := Index;
end;

procedure TForm1.SG_AllKeyPress(Sender: TObject; var Key: char);
begin
  If key=#13 then SG_AllDblClick(self);
   if Key='/' then
  begin
   Key:=#0;
    //ShowMessage('Implement Search in Stringgrid');
   SearchPanelBrowser.Visible:=not SearchPanelBrowser.Visible;
   If SearchPanelBrowser.Visible then Edit5.SetFocus;
  end;
end;

procedure TForm1.SG_AllMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  DestCol, DestRow: Integer;
begin
  if button=mbright then
  begin
    SG_All.MouseToCell(X,Y,DestCol{%H-}, DestRow{%H-});
    if not IsCellSelected(SG_All, DestCol, DestRow) then
    begin
      SG_All.Row:=destRow;
      FAllSel.Update;
    end;
    if SG_All.row>0 then PM_SGAll.PopUp;
  end;
end;

procedure TForm1.SG_PlayCompareCells(Sender: TObject; ACol, ARow, BCol,
  BRow: Integer; var Result: integer);
var
  aGrid: TStringGrid;
begin
  aGrid := TStringGrid(Sender);
  if aCol=2 then
    // compare cells numerically
    result := StrToIntDef(aGrid.Cells[ACol, ARow], 0) - StrToIntDef(aGrid.Cells[BCol, BRow], 0)
  else
    Result:=UTF8CompareText(aGrid.Cells[ACol,ARow], aGrid.Cells[BCol,BRow]);
  if aGrid.SortOrder=soDescending then
    result:=-result;
end;

procedure TForm1.SG_PlayDragDrop(Sender, Source: TObject; X, Y: Integer);
var CurrentCol, CurrentRow: integer;
begin
  if (sender=SG_Play) then
  begin
    SG_Play.MouseToCell(X, Y, CurrentCol, CurrentRow);
    if (startrij>0) and (currentrow>0) then SG_Play.MoveColRow(False, StartRij,CurrentRow);
  end;
end;

procedure TForm1.SG_PlayDragOver(Sender, Source: TObject; X, Y: Integer;
  State: TDragState; var Accept: Boolean);
var CurrentCol, CurrentRow: integer;
begin
  if source=sender then
  begin
    Accept:=True;
    SG_Play.MouseToCell(X, Y, CurrentCol, CurrentRow);
  end
  else accept:=false;
end;

procedure TForm1.SG_PlayDrawCell(Sender: TObject; aCol, aRow: Integer;
  aRect: TRect; aState: TGridDrawState);
begin
  if  not (gdfixed in aState) then
    begin
      if arow = SG_Play.Row then
                              begin
                                SG_Play.Canvas.Brush.Color:=clHighLight;
                                SG_Play.Canvas.Font.Color:=clHighlightText;
                              end
                            else if odd(aRow) then SG_Play.Canvas.Brush.Color:=SG_Play.Color
                                              else SG_Play.Canvas.Brush.Color:=SG_Play.AlternateColor;
      SG_Play.Canvas.FillRect(aRect);
      SG_Play.Canvas.TextOut(aRect.Left+2, aRect.Top+2, SG_Play.Cells[aCol, aRow]);
    end;
end;

procedure TForm1.SG_PlayKeyPress(Sender: TObject; var Key: char);
begin
  if Key=#13 then SG_PlayDblClick(Self);
  if Key='/' then
  begin
   Key:=#0;
    //ShowMessage('Implement Search in Stringgrid');
   SearchPanelQueue.Visible:=not SearchPanelQueue.Visible;
   If SearchPanelQueue.Visible then Edit4.SetFocus;
  end;
end;

procedure TForm1.SG_PlayKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState
  );
begin

end;

procedure TForm1.SG_PlayMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  DestCol, DestRow: Integer;
begin
  if button=mbright then
  begin
    SG_Play.MouseToCell(X,Y,DestCol{%H-}, DestRow{%H-});
    if not IsCellSelected(SG_Play, DestCol, DestRow) then
    begin
      SG_Play.Row:=destRow;
      FPlaySel.Update;
    end;
    PM_Play.PopUp;
  end;
end;


procedure TForm1.SG_PodcastClick(Sender: TObject);
begin
  PanelVolume.Visible:=False;
  podcast.itunes_img:=''; podcast.ch_title:='';
  podcast.ch_copyright:=''; podcast.itunes_sub:='';
  podcast.ch_descript:=''; podcast.it_title:='';
  Podcast.it_descript:=''; Podcast.itunes_oms:='';
  if SG_Podcast.Row>0 then
  begin
    if DownloadFile(SG_Podcast.Cells[1,SG_Podcast.Row], Tempdir+DirectorySeparator+'podcast.tmp') then
    begin
       GetPodcast(-1,'ALL');
    end;
  end;
end;

procedure TForm1.SG_PodcastDblClick(Sender: TObject);
begin
  Application.ProcessMessages;
  If Stringgrid1.RowCount>1 then Stringgrid1DblClick(Self);
end;

procedure TForm1.ShellListView1Click(Sender: TObject);
var tempfilename, lijn, ext: string;
    Filevar: TextFile;
    CD_Title: string;
    Song_Artist, Song_Title, Song_Index: string;
    Track: byte;
begin
  PanelVolume.Visible:=False; Track:=0;
  tempfilename:=Shelllistview1.GetPathFromItem(ShellListview1.Selected);
  ext:=ExtractFileext(tempfilename);
  delete(tempfilename,length(tempfilename)-length(ext)+1,length(ext)); tempfilename:=tempfilename+'.cue';
  if FileExistsUTF8(tempfilename) then
  begin
    AssignFile(Filevar,tempfilename);
    Reset(Filevar);
    repeat
      Readln(Filevar,lijn);
    until pos('REM ',lijn)<1;

    repeat
      Readln(Filevar,lijn);
     // if pos('PERFORMER ',lijn)>0 then CD_Artist:=copy(Lijn,9,length(lijn));
      if pos('TITLE ',lijn)>0 then
      begin
        CD_Title:=copy(lijn,8,length(lijn));
        Delete(CD_Title,length(CD_Title),1);
      end;

    until pos('FILE ',lijn)>0;

    repeat
      Readln(Filevar,lijn);
      if pos('TRACK ',lijn)>0 then
      begin
         inc(Track);
         SG_CUE.RowCount:=Track+1;
         SG_CUE.Cells[0,Track]:=inttostr(Track);
         SG_CUE.Cells[4,Track]:=CD_Title;
      end;
      if pos('TITLE "',lijn)>0 then
      begin
        Song_Title:=copy(lijn,pos('"',lijn)+1,length(lijn));
        Delete(Song_Title,length(Song_Title),1);
        SG_CUE.Cells[2,Track]:=Song_Title;
      end;
      if pos('PERFORMER "',lijn)>0 then
      begin
       Song_Artist:=copy(lijn,pos('"',lijn)+1,length(lijn));
       Delete(Song_Artist,length(Song_Artist),1);
       SG_CUE.Cells[1,Track]:=Song_Artist;
      end;
      if pos('INDEX ',lijn)>0 then
      begin
       Song_Index:=lijn;
       Delete(Song_Index,1,pos('DEX ',Song_Index)+6);
       Delete(Song_Index,length(Song_Index)-2,3);
       SG_CUE.Cells[3,Track]:=Song_Index;
      end;
    until eof(Filevar);
    CloseFile(Filevar);
    SG_CUE.AutoSizeColumns;
    If SG_CUE.RowCount>1 then SG_CUE.Row:=1;
  end
  else
  begin
    SG_CUE.RowCount:=1; //SG_CUE.Row:=0;
  end;
end;

procedure TForm1.ShellListView1DblClick(Sender: TObject);
begin
  If ShelllistView1.ItemIndex>-1 then
  if ShellListview1.Items.Count>Shelllistview1.ItemIndex then
  begin
    PlayingFromRecorded:=False;
    PlayFromFile(Shelllistview1.GetPathFromItem(ShellListview1.Selected));

    if SG_CUE.RowCount>1 then
                                begin
                                  playingcue:=1;
                                  LB_CD.Caption:=SG_CUE.Cells[4,1];
                                  LB_Titel.Caption:=SG_CUE.Cells[2,1];
                                  LB_Artiest.Caption:=SG_CUE.Cells[1,1];
                                end;
  end;
end;

procedure TForm1.ShellTreeView1Click(Sender: TObject);
begin
  PanelVolume.Visible:=False;
end;

procedure TForm1.SB_ReadDVDClick(Sender: TObject);
var doorgaan, gevonden: boolean;
    MemStream: TMemoryStream;
    OurProcess: TProcess;
    NumBytes, BytesRead: LongInt;
    i, totaltitles: integer;
    lijn: string;
    laatstetrack: byte;
    Drivex: Char;
begin
  PanelVolume.Visible:=False;
  {$IFDEF WINDOWS}
  // Search all drive letters
  Drivex:='C'; Gevonden:=false;
  repeat
    inc(drivex);
    DvdLetter := Drivex + ':\VIDEO_TS\VIDEO_TS.IFO';
    if FileExistsUTF8(DvdLetter) then
    begin
      dvdLetter:=' -dvd-device '+Drivex+':';
      gevonden:=true;
    end;
  until (Drivex='Z') or (Gevonden);
  {$ENDIF}


  Status_cd:=2; totaltitles:=0; laatstetrack:=0;// DVD Rippen
  doorgaan:=true; Memo1.Lines.Clear;  ComboBox1.Items.Clear;

  if not FileExistsUTF8(Settings.Mplayer) then
                            begin
                              Memo1.Lines.Add('mplayer not found');
                              Memo1.Lines.Add('Please install mplayer before you continue');
                              doorgaan:=false;
                            end;
  if doorgaan then
  begin
    begin
      //Chapters zoeken via mplayer
    //  FormWarning.Show;
      MemStream := TMemoryStream.Create;
      BytesRead := 0;
      OurProcess := TProcess.Create(nil);
      OurProcess.CommandLine := Settings.Mplayer+' -frames 0 -msglevel identify=6 dvd://';
      {$IFDEF UNIX}
      //TODO: search for the DVD, now it is hardcoded at /dev/sr0
      //      Maybe a config option to let the user decide.
        OurProcess.CommandLine := Settings.Mplayer+' -frames 0 -msglevel identify=6 dvd:// -dvd-device '+Settings.DVDDrive;
      {$ENDIF}
      OurProcess.Options := [poUsePipes];
      {$IFDEF WINDOWS}
       Memo1.Lines.Add('');
       Memo1.Lines.Add('DVD found in '+DriveX+':');
       OurProcess.CommandLine:=OurProcess.CommandLine+dvdLetter;
       OurProcess.Options:=OurProcess.Options+[poNoConsole];
      {$ENDIF}
      MeMo1.Lines.Add('cmd='+OurProcess.CommandLine);

      OurProcess.Execute;

      while OurProcess.Running do
      begin
        MemStream.SetSize(BytesRead + READ_BYTES);
        NumBytes := OurProcess.Output.Read((MemStream.Memory + BytesRead)^, READ_BYTES);
        if NumBytes > 0 then Inc(BytesRead, NumBytes)
                        else Sleep(100);
      end;
      repeat
        MemStream.SetSize(BytesRead + READ_BYTES);
        NumBytes := OurProcess.Output.Read((MemStream.Memory + BytesRead)^, READ_BYTES);
        if NumBytes > 0 then Inc(BytesRead, NumBytes);
      until NumBytes <= 0;
      if BytesRead > 0 then WriteLn;
      MemStream.SetSize(BytesRead);
      Memo1.Lines.Add(''); Memo1.Lines.Add('Getting Chapters using MPLAYER ...'); Memo1.Lines.Add('');
      Memo1.Lines.LoadFromStream(Memstream); Application.ProcessMessages;
      OurProcess.Free;
      MemStream.Free;

      Application.ProcessMessages;
      StringgridCD.AutoSizeColumns;
      SB_RipCD.Enabled:=True;
    //  FormWarning.Hide;

      i:=1; gevonden:=false; laatstetrack:=1;
      repeat
        if pos('DVD_TITLES',Memo1.Lines[i])>1 then
        begin
          gevonden:=true;
          lijn:=Memo1.Lines[i];  delete(lijn,1,14);
          Memo1.Lines.Add('Total tracks = '+lijn);
          laatstetrack:=strtointdef(lijn,1);
        end;
        inc(i);
      until gevonden or (i>=Memo1.Lines.Count-1);
      if gevonden then
      begin
        for i:=1 to laatstetrack do ComboBox1.Items.Add('Title '+inttostr(i));
        Stringgridcd.RowCount:=2;
        MenuItem44Click(Self);
        MenuItem50Click(Self);
        MenuItem52Click(Self);
        MenuItem53Click(Self);
        if stringgridcd.RowCount>1 then
        begin
          CD[1].artiest:=Stringgridcd.Cells[1,1];
          CD[1].Album:=Stringgridcd.Cells[3,1];
          CD[1].jaartal:=Stringgridcd.Cells[5,1];
          CD[1].genre:=Stringgridcd.Cells[6,1];
        end;

        if combobox1.Items.Count>0 then
        begin
          Combobox1.ItemIndex:=0;
        {$if defined(WINDOWS) or defined(UNIX)}
          ComboBox1Select(self);
        {$IFEND}
        end;
      //DVD_TITLES
      end
      else
      begin
        // GEEN DVD GEVONDEN
        Memo1.Lines.Add('');
        Memo1.Lines.Add('Problems reading DVD');
        Memo1.Lines.Add('');
        Memo1.Lines.Add('No DVD found');
        Memo1.Lines.Add('Check if a DVD is inserted');
        StringgridCd.RowCount:=1;
        SB_RipCD.Enabled:=False;
      end;
    end;
  end;
end;

procedure TForm1.SB_LastFMClick(Sender: TObject);
begin
  if ArtiestInfo<>ArtiestString then
  begin
    if (LB_Artiest.Caption<>'--') and (upcase(LB_Artiest.Caption)<>'UNKNOWN') then
    begin
      ArtiestString:=Form1.MakeWikiArtist(LB_Artiest.Caption,'+');
      SB_LastFM.enabled:=false;
      LB_MostPlayed.Clear;
      ThreadLastFMInfo:=TLastFMInfoThread.Create(False);
    end;
  end;
end;

procedure TForm1.SpeedButton13Click(Sender: TObject);
var gevonden: Boolean;
    i: Integer;
begin
  i:=SG_Play.Row; gevonden:=false;
  repeat
    inc(i);
    if i<SG_Play.RowCount then
    begin
      If pos(Edit4.Text,upcase(SG_Play.Cells[1,i]))>0 then gevonden:=true;
      If pos(Edit4.Text,upcase(SG_Play.Cells[3,i]))>0 then gevonden:=true;
      If pos(Edit4.Text,upcase(SG_Play.Cells[4,i]))>0 then gevonden:=true;
      If pos(Edit4.Text,SG_Play.Cells[5,i])>0 then gevonden:=true;
    end;
  until (gevonden) or (i>=SG_Play.RowCount-1);
  if gevonden then SG_Play.Row:=i;
  if not gevonden then
  begin
    if FormShowMyDialog.ShowWith('Info Message',Vertaal('End of Playlist reached.'),Vertaal('Do you want to search from beginning?'),' ',Vertaal('YES'),Vertaal('NO'), False) then
    Begin
      i:=0;
      repeat
        inc(i);
        If pos(Edit4.Text,upcase(SG_Play.Cells[1,i]))>0 then gevonden:=true;
        If pos(Edit4.Text,upcase(SG_Play.Cells[3,i]))>0 then gevonden:=true;
        If pos(Edit4.Text,upcase(SG_Play.Cells[4,i]))>0 then gevonden:=true;
        If pos(Edit4.Text,SG_Play.Cells[5,i])>0 then gevonden:=true;
      until (gevonden) or (i>=SG_Play.RowCount-1);
      if gevonden then SG_Play.Row:=i;
    end;
  end;
end;

procedure TForm1.SpeedButton15Click(Sender: TObject);
var gevonden: Boolean;
    i: Integer;
begin
  i:=SG_Play.Row; gevonden:=false;
  repeat
    dec(i);
    If pos(Edit4.Text,upcase(SG_Play.Cells[1,i]))>0 then gevonden:=true;
    If pos(Edit4.Text,upcase(SG_Play.Cells[3,i]))>0 then gevonden:=true;
    If pos(Edit4.Text,upcase(SG_Play.Cells[4,i]))>0 then gevonden:=true;
    If pos(Edit4.Text,SG_Play.Cells[5,i])>0 then gevonden:=true;
  until (gevonden) or (i<=1);
  if gevonden then SG_Play.Row:=i;
  if not gevonden then
  begin
    if FormShowMyDialog.ShowWith('Info Message',Vertaal('End of Playlist reached.'),Vertaal('Do you want to search from the end?'),' ',Vertaal('YES'),Vertaal('NO'), False) then
    Begin
      i:=SG_Play.RowCount;
      repeat
        dec(i);
        If pos(Edit4.Text,upcase(SG_Play.Cells[1,i]))>0 then gevonden:=true;
        If pos(Edit4.Text,upcase(SG_Play.Cells[3,i]))>0 then gevonden:=true;
        If pos(Edit4.Text,upcase(SG_Play.Cells[4,i]))>0 then gevonden:=true;
        If pos(Edit4.Text,SG_Play.Cells[5,i])>0 then gevonden:=true;
      until (gevonden) or (i<=1);
      if gevonden then SG_Play.Row:=i;
    end;
  end;
end;

procedure TForm1.SpeedButton28Click(Sender: TObject);
begin
  SearchPanelBrowser.Visible:=False;
end;

procedure TForm1.SpeedButton29Click(Sender: TObject);
var gevonden: Boolean;
    i: Integer;
begin
  i:=SG_All.Row; gevonden:=false;
  repeat
    inc(i);
    if i<SG_All.RowCount then
    begin
      If pos(Edit5.Text,upcase(SG_All.Cells[1,i]))>0 then gevonden:=true;
      If pos(Edit5.Text,upcase(SG_All.Cells[3,i]))>0 then gevonden:=true;
      If pos(Edit5.Text,upcase(SG_All.Cells[4,i]))>0 then gevonden:=true;
      If pos(Edit5.Text,upcase(SG_All.Cells[5,i]))>0 then gevonden:=true;
      If pos(Edit5.Text,upcase(SG_All.Cells[6,i]))>0 then gevonden:=true;
    end;
  until (gevonden) or (i>=SG_All.RowCount-1);
  if gevonden then SG_All.Row:=i;
  if not gevonden then
  begin
    if FormShowMyDialog.ShowWith('Info Message',Vertaal('End of Playlist reached.'),Vertaal('Do you want to search from beginning?'),' ',Vertaal('YES'),Vertaal('NO'), False) then
    Begin
      i:=0;
      repeat
        inc(i);
        If pos(Edit5.Text,upcase(SG_All.Cells[1,i]))>0 then gevonden:=true;
        If pos(Edit5.Text,upcase(SG_All.Cells[3,i]))>0 then gevonden:=true;
        If pos(Edit5.Text,upcase(SG_All.Cells[4,i]))>0 then gevonden:=true;
        If pos(Edit5.Text,upcase(SG_All.Cells[5,i]))>0 then gevonden:=true;
        If pos(Edit5.Text,upcase(SG_All.Cells[6,i]))>0 then gevonden:=true;
      until (gevonden) or (i>=SG_All.RowCount-1);
      if gevonden then SG_All.Row:=i;
    end;
  end;
end;

procedure TForm1.SpeedButton2Click(Sender: TObject);
begin
  PM_Songtext.PopUp;
end;

procedure TForm1.SB_RepeatClick(Sender: TObject);
begin
  inc(Settings.RepeatSong);if Settings.RepeatSong>2 then Settings.RepeatSong:=0;
  case Settings.RepeatSong of
    0: ImageListRepeat.GetBitmap(2, SB_Repeat.Glyph);
    1: ImageListRepeat.GetBitmap(1, SB_Repeat.Glyph);
    2: ImageListRepeat.GetBitmap(0, SB_Repeat.Glyph);
  end;
end;

procedure TForm1.SpeedButton30Click(Sender: TObject);
var gevonden: Boolean;
    i: Integer;
begin
  i:=SG_All.Row; gevonden:=false;
  repeat
    dec(i);
    If pos(Edit5.Text,upcase(SG_All.Cells[1,i]))>0 then gevonden:=true;
    If pos(Edit5.Text,upcase(SG_All.Cells[3,i]))>0 then gevonden:=true;
    If pos(Edit5.Text,upcase(SG_All.Cells[4,i]))>0 then gevonden:=true;
    If pos(Edit5.Text,upcase(SG_All.Cells[5,i]))>0 then gevonden:=true;
    If pos(Edit5.Text,upcase(SG_All.Cells[6,i]))>0 then gevonden:=true;
  until (gevonden) or (i<=1);
  if gevonden then SG_All.Row:=i;
  if not gevonden then
  begin
    if FormShowMyDialog.ShowWith('Info Message',Vertaal('End of Playlist reached.'),Vertaal('Do you want to search from the end?'),' ',Vertaal('YES'),Vertaal('NO'), False) then
    Begin
      i:=SG_All.RowCount;
      repeat
        dec(i);
        If pos(Edit5.Text,upcase(SG_All.Cells[1,i]))>0 then gevonden:=true;
        If pos(Edit5.Text,upcase(SG_All.Cells[3,i]))>0 then gevonden:=true;
        If pos(Edit5.Text,upcase(SG_All.Cells[4,i]))>0 then gevonden:=true;
        If pos(Edit5.Text,upcase(SG_All.Cells[5,i]))>0 then gevonden:=true;
        If pos(Edit5.Text,upcase(SG_All.Cells[6,i]))>0 then gevonden:=true;
      until (gevonden) or (i<=1);
      if gevonden then SG_All.Row:=i;
    end;
  end;
end;

procedure TForm1.GetRadioDB(country,genre,zoekterm: string; Toevoegen: Boolean);
var Filevar: TextFile;
    presetnr, datum, landcode, lijn, naam, weblink, urllink: string;
begin
  if not toevoegen then TotalDBRadio:=1;
  if FileExistsUTF8(Settings.cacheDirRadio+'XiX.db'+directoryseparator+lowercase(country)+'.rls') then
  begin
    AssignFile(Filevar,Settings.cacheDirRadio+'XiX.db'+directoryseparator+lowercase(country)+'.rls');
    Reset(Filevar);
    Readln(Filevar,lijn); if lijn<>'#Radiolisting XiXMusicPlayer' then exit;
    Readln(Filevar,lijn);Delete(lijn,1,1); landcode:=lijn;
    Readln(Filevar,lijn);Delete(lijn,1,1); datum:=lijn;
    repeat
      Readln(Filevar,lijn);
      if (length(lijn)>3) and (lijn<>':FileEnd') then
      begin
        urllink:='';
      //  ShowMessage(lijn);
        DBRadioStation[TotalDBRadio].internalnr:=landcode+'-'+lijn;
        DBRadioStation[TotalDBRadio].land:=country;
        readln(Filevar,DBRadioStation[TotalDBRadio].naam);
        readln(Filevar,DBRadioStation[TotalDBRadio].genres);
        readln(Filevar,DBRadioStation[TotalDBRadio].website);
        readln(Filevar,DBRadioStation[TotalDBRadio].logo1); // logo link
        readln(Filevar,lijn); // :links
        readln(Filevar,lijn);
        if lijn<>':oms' then
        begin
          DBRadioStation[TotalDBRadio].link:=lijn;
        end;
        repeat
          readln(Filevar,lijn);
        until (lijn=':end') or eof(Filevar);
        readln(Filevar,lijn);
        inc(TotalDBRadio);
      end;
    until eof(Filevar) or (lijn=':FileEnd');
    CloseFile(Filevar);
  end;
end;

procedure TForm1.SpeedButton34Click(Sender: TObject);
var i: integer;
    Filevar: TextFile;
    presetnr, genre, datum, landcode, lijn, naam, weblink, urllink: string;
begin
  SG_ListenLive.RowCount:=1;
  GetRadioDB(LB_Land1.Text,'','',False);
  SG_ListenLive.RowCount:=TotalDBRadio;
  for i:=1 to TotalDBradio-1 do
  begin
    SG_ListenLive.Cells[0,i]:=DBRadioStation[i].internalnr;
    SG_ListenLive.Cells[1,i]:=DBRadioStation[i].naam;
    SG_ListenLive.Cells[2,i]:=DBRadioStation[i].land;
    SG_ListenLive.Cells[3,i]:=DBRadioStation[i].genres;
    SG_ListenLive.Cells[4,i]:=DBRadioStation[i].website;
    SG_ListenLive.Cells[5,i]:=DBRadioStation[i].link;
  end;
  if SG_ListenLive.RowCount=1 then SpeedButton9Click(Self);
  SG_ListenLive.AutoSizeColumns;
end;

procedure TForm1.SpeedButton35Click(Sender: TObject);
begin
  PanelVolume.Visible:=False;
  If Panel13.height<100 then Panel13.Height:=132
                        else Panel13.Height:=Label31.Height+1;
end;

procedure TForm1.SpeedButton4Click(Sender: TObject);
begin
  SearchPanelQueue.Visible:=False;
end;

procedure TForm1.SpeedButton5Click(Sender: TObject);
begin
  PM_Information.PopUp;
end;

procedure TForm1.SpeedButton6Click(Sender: TObject);
begin
  PM_FX.PopUp;
end;

procedure TForm1.SpeedButton9Click(Sender: TObject);
var fs: TFilestream;
    goed: boolean;
    FilevarIn, FilevarOut: TextFile;
    lijn, cmd: string;
    RadioStationTemp : TRadioStation;
    AProcess: TProcess;
begin
  if not directoryexists(Settings.cacheDirRadio+'XiX.db') then CreateDir(Settings.cacheDirRadio+'XiX.db');
  goed:=false;
  fs := TFileStream.Create(Tempdir+Directoryseparator+lowercase(lb_Land1.text)+'.rls', fmOpenWrite or fmCreate);
  try
    goed:=HttpGetBinary('http://www.xixmusicplayer.org/download/radio/'+lowercase(lb_land1.Text)+'.rls', fs);
  finally
    fs.Free;
  end;
  {$IFDEF HAIKU}
     AProcess := TProcess.Create(nil);
     try
      cmd:='wget http://www.xixmusicplayer.org/download/radio/'+lowercase(lb_land1.Text)+'.rls -O '+Tempdir+Directoryseparator+lowercase(lb_Land1.text)+'.rls';
      AProcess.CommandLine := cmd+' -T 5 -t 1';
      AProcess.options:=AProcess.options+[poWaitOnExit];
      AProcess.Execute;
      if fileexists(Tempdir+Directoryseparator+lowercase(lb_Land1.text)+'.rls') then goed:=true;
     except
     ShowMessage(Vertaal('Download Rodiolisting went wrong'));
     end;
     AProcess.Free;
  {$ENDIF}
  if goed then
  begin
    AssignFile(FilevarIn,Tempdir+Directoryseparator+lowercase(lb_Land1.text)+'.rls');
    Reset(FilevarIn);
    Readln(FilevarIn,lijn);
    CloseFile(FilevarIn);
    if pos('#Radiolisting XiXMusicPlayer',lijn)>0 then
    begin
      CopyFile(Tempdir+Directoryseparator+lowercase(lb_Land1.text)+'.rls',Settings.cacheDirRadio+'XiX.db'+DirectorySeparator+lowercase(lb_Land1.text)+'.rls');
      if sender<>Speedbutton34 then Speedbutton34Click(Self);
    end
    else ShowMessage(lb_Land1.text+' noy yet available on XiX.db');
    DeleteFile(Tempdir+Directoryseparator+lowercase(lb_Land1.text)+'.rls');
  end
  else ShowMessage(lb_Land1.text+' noy yet available on XiX.db');
end;

procedure TForm1.Ster10Click(Sender: TObject);
begin
    VulsterrenPlaylist(5);
end;

procedure TForm1.VulSterrenPlaylist(Index: byte);
begin
  if index >= 1 then ImageListStars.GetBitmap(0, Ster6.Picture.Bitmap)
                else ImageListStars.GetBitmap(1, Ster6.Picture.Bitmap);
  if index >= 2 then ImageListStars.GetBitmap(0, Ster7.Picture.Bitmap)
                else ImageListStars.GetBitmap(1, Ster7.Picture.Bitmap);
  if index >= 3 then ImageListStars.GetBitmap(0, Ster8.Picture.Bitmap)
                else ImageListStars.GetBitmap(1, Ster8.Picture.Bitmap);
  if index >= 4 then ImageListStars.GetBitmap(0, Ster9.Picture.Bitmap)
                else ImageListStars.GetBitmap(1, Ster9.Picture.Bitmap);
  if index >= 5 then ImageListStars.GetBitmap(0, Ster10.Picture.Bitmap)
                else ImageListStars.GetBitmap(1, Ster10.Picture.Bitmap);
end;

procedure TForm1.Ster6Click(Sender: TObject);
begin
  VulsterrenPlaylist(1);
end;

procedure TForm1.Ster0Click(Sender: TObject);
begin
  VulSterren(0);
end;

procedure TForm1.Ster1Click(Sender: TObject);
begin
  VulSterren(1);
end;

procedure TForm1.Ster2Click(Sender: TObject);
begin
  VulSterren(2);
end;

procedure TForm1.Ster3Click(Sender: TObject);
begin
  VulSterren(3);
end;

procedure TForm1.Ster4Click(Sender: TObject);
begin
  VulSterren(4);
end;

procedure TForm1.Ster5Click(Sender: TObject);
begin
  VulSterren(5);
end;

procedure TForm1.VulSterren(Index: byte);
begin
  Liedjes[songplaying].Beoordeling:=Index;
  if index >= 1 then ImageListStars.GetBitmap(0, Ster1.Picture.Bitmap)
                else ImageListStars.GetBitmap(1, Ster1.Picture.Bitmap);
  if index >= 2 then ImageListStars.GetBitmap(0, Ster2.Picture.Bitmap)
                else ImageListStars.GetBitmap(1, Ster2.Picture.Bitmap);
  if index >= 3 then ImageListStars.GetBitmap(0, Ster3.Picture.Bitmap)
                else ImageListStars.GetBitmap(1, Ster3.Picture.Bitmap);
  if index >= 4 then ImageListStars.GetBitmap(0, Ster4.Picture.Bitmap)
                else ImageListStars.GetBitmap(1, Ster4.Picture.Bitmap);
  if index >= 5 then ImageListStars.GetBitmap(0, Ster5.Picture.Bitmap)
                else ImageListStars.GetBitmap(1, Ster5.Picture.Bitmap);
end;

procedure TForm1.Label12Click(Sender: TObject);
begin
    VulsterrenPlaylist(0);
end;

procedure TForm1.Label20Click(Sender: TObject);
begin
    Browseto(Label20.Caption);
end;

procedure TForm1.LabelElapsedTimeClick(Sender: TObject);
begin
  if stream<10 then elapsed:=not elapsed;
end;

procedure TForm1.LabelPodcastClick(Sender: TObject);
begin
  FormDownLoadOverview.ShowModal;
end;

procedure TForm1.LabelRecordingsClick(Sender: TObject);
begin
  FormPlanRecording.PageControl1.ActivePageIndex:=0;
  FormPlanRecording.showmodal;
end;

procedure TForm1.LB_Albums1Click(Sender: TObject);
var Temp_StringList: TStringList;
    i, i2: longint;
begin
 if LB_Albums1.Items.Count>0 then
 begin
  GetoondePlaylist:=''; SB_Save.Enabled:=False; PanelVolume.Visible:=False;
  LB_Artists2.Items.Clear; i2:=0; MI_RemoveFromPlaylist.Enabled:=False;
  Temp_StringList:=TStringList.Create;
  Temp_StringList.Sorted:=True; Temp_StringList.Duplicates:=dupIgnore;

  SG_All.RowCount:=1; SG_All.BeginUpdate;
  for i:=0 to maxsongs-1 do
  begin
    if Liedjes[i].CD=LB_Albums1.Items[LB_Albums1.ItemIndex] then if not Liedjes[i].Deleted then
    begin
      Temp_StringList.Add(Liedjes[i].Artiest);

      inc(i2);
      SG_All.RowCount:=i2+1;

      SG_All.Cells[0,i2]:=Inttostr(i);
      SG_All.Cells[1,i2]:=Liedjes[i].Artiest;
      SG_All.Cells[2,i2]:=inttostr(Liedjes[i].Track);
      SG_All.Cells[3,i2]:=Liedjes[i].Titel;
      SG_All.Cells[4,i2]:=Liedjes[i].CD;
      SG_All.Cells[COL_SG_ALL_PATH,i2]:=Liedjes[i].Pad;
      SG_All.Cells[COL_SG_ALL_NAME,i2]:=Liedjes[i].Bestandsnaam;
    end;
  end;
  FAllSel.Update;
  LB_Artists2.Items.AddStrings(Temp_Stringlist);
  PageControl2.PageIndex:=0;
  Temp_StringList.Free;

   SG_All.EndUpdate(True); AutoSizeAllColumns;
 end;
end;

procedure TForm1.AutosizeAllColumns;
var i: integer;
begin
   If settings.ShowAllColums then
                              begin
                                SG_All.AutoSizeColumns;
                                i:=round(SG_All.Width/3.7);
                                if i<SG_all.ColWidths[1] then SG_All.ColWidths[1]:= round(SG_All.Width/3.7);
                                if i<SG_all.ColWidths[3] then SG_All.ColWidths[3]:= round(SG_All.Width/3.5);
                                if i<SG_all.ColWidths[4] then SG_All.ColWidths[4]:= round(SG_All.Width/3.5);
                              end
                            else SG_All.AutoSizeColumns;
end;

procedure TForm1.LB_Albums1DblClick(Sender: TObject);
begin
  Application.ProcessMessages;
  SG_AllDblClick(self);
end;

procedure TForm1.LB_Albums2Click(Sender: TObject);
var i, i2: longint;
    Artist, Album, ChosenArtist, ChosenAlbum: string;
    ArtistDir, AlbumDir: string;
begin
  GetoondePlaylist:=''; SB_Save.Enabled:=False; MI_RemoveFromPlaylist.Enabled:=False;
  PanelVolume.Visible:=False;

  If LB_Albums2.ItemIndex<0 then exit;  // No albums found

  If (LB_Artist1.ItemIndex=0) and (LB_Albums2.ItemIndex=0) and (SG_All.RowCount=maxsongs+1) then exit;

  LB_Albums2.Cursor:=CRHourglass; Application.ProcessMessages;

  i2:=0;
  ArtistDir:=StringReplace(LB_Artist1.Items[LB_Artist1.ItemIndex],'&','&&',[rfReplaceAll]);
  AlbumDir:=StringReplace(LB_Albums2.Items[LB_Albums2.ItemIndex],'&','&&',[rfReplaceAll]);
  ChosenArtist:=upcase(LB_Artist1.Items[LB_Artist1.ItemIndex]);
  ChosenAlbum:=upcase(LB_Albums2.Items[LB_Albums2.ItemIndex]);
  SG_All.RowCount:=1; SG_All.BeginUpdate;
  for i:=0 to maxsongs-1 do if not Liedjes[i].Deleted then
  begin
    Artist:=upcase(Liedjes[i].Artiest); Album:=upcase(Liedjes[i].CD);
    if ((LB_Artist1.ItemIndex=0) and (Album=ChosenAlbum))
      or ((Artist=ChosenArtist) and (Album=ChosenAlbum))
      or ((Artist=ChosenArtist) and (LB_Albums2.ItemIndex=0))
      or ((LB_Albums2.ItemIndex=0) and (LB_Artist1.ItemIndex=0))
      then
    begin
      inc(i2);
      SG_All.RowCount:=i2+1;

      SG_All.Cells[0,i2]:=Inttostr(i);
      SG_All.Cells[1,i2]:=Liedjes[i].Artiest;
      if Liedjes[i].Track=0 then SG_All.Cells[2,i2]:=''
                            else if Liedjes[i].Track<10 then SG_All.Cells[2,i2]:='0'+inttostr(Liedjes[i].Track)
                                                        else SG_All.Cells[2,i2]:=inttostr(Liedjes[i].Track);
      SG_All.Cells[3,i2]:=Liedjes[i].Titel;
      SG_All.Cells[4,i2]:=Liedjes[i].CD;
      SG_All.Cells[COL_SG_ALL_PATH,i2]:=Liedjes[i].Pad;
      SG_All.Cells[COL_SG_ALL_NAME,i2]:=Liedjes[i].Bestandsnaam;
    end;
  end;
  SG_All.EndUpdate(True);

  AutoSizeAllColumns;

  PageControl2.PageIndex:=0; // Show SG_All
  LB_Albums2.Cursor:=CRdefault;

  (* TODO:  Make an iteration to build the menu.  This way custom folders can be added *)
  MI_CopyToLocal1.Clear;
  if Settings.IncludeLocaleDirs.Count > 0 then
   begin
    MI_CopyToLocal1.Enabled:=True;
    For i:=1 to Settings.IncludeLocaleDirs.Count do
    begin
      SubItem:= TMenuItem.Create(PM_Albums2);
      Subitem.OnClick:=@OnCopyToHasClick;
      SubItem.Caption:= Settings.IncludeLocaleDirs.Strings[i-1];
      MI_CopyToLocal1.Add(SubItem);
      SubItem:= TMenuItem.Create(PM_Albums2);
      Subitem.OnClick:=@OnCopyToHasClick;
      SubItem.Caption:= Settings.IncludeLocaleDirs.Strings[i-1]+DirectorySeparator+ArtistDir;
      MI_CopyToLocal1.Add(SubItem);
      SubItem:= TMenuItem.Create(PM_Albums2);
      Subitem.OnClick:=@OnCopyToHasClick;
      SubItem.Caption:= Settings.IncludeLocaleDirs.Strings[i-1]+DirectorySeparator+ArtistDir+DirectorySeparator+AlbumDir;
      MI_CopyToLocal1.Add(SubItem);
      SubItem:= TMenuItem.Create(PM_Albums2);
      Subitem.OnClick:=@OnCopyToHasClick;
      SubItem.Caption:= Settings.IncludeLocaleDirs.Strings[i-1]+DirectorySeparator+lowercase(ArtistDir[1])+DirectorySeparator+ArtistDir;
      MI_CopyToLocal1.Add(SubItem);
      SubItem:= TMenuItem.Create(PM_Albums2);
      Subitem.OnClick:=@OnCopyToHasClick;
      SubItem.Caption:= Settings.IncludeLocaleDirs.Strings[i-1]+DirectorySeparator+lowercase(ArtistDir[1])+DirectorySeparator+ArtistDir+DirectorySeparator+AlbumDir;
      MI_CopyToLocal1.Add(SubItem);
    end;
   end;
  MI_CopyToExternal1.Clear;
  if Settings.IncludeExternalDirs.Count > 0 then
   begin
    MI_CopyToExternal1.Enabled:=True;
    For i:=1 to Settings.IncludeExternalDirs.Count do
    begin
      SubItem:= TMenuItem.Create(PM_Albums2);
      Subitem.OnClick:=@OnCopyToHasClick;
      SubItem.Caption:= Settings.IncludeExternalDirs.Strings[i-1];
      MI_CopyToExternal1.Add(SubItem);
      SubItem:= TMenuItem.Create(PM_Albums2);
      Subitem.OnClick:=@OnCopyToHasClick;
      SubItem.Caption:= Settings.IncludeExternalDirs.Strings[i-1]+DirectorySeparator+ArtistDir;
      MI_CopyToExternal1.Add(SubItem);
      SubItem:= TMenuItem.Create(PM_Albums2);
      Subitem.OnClick:=@OnCopyToHasClick;
      SubItem.Caption:= Settings.IncludeExternalDirs.Strings[i-1]+DirectorySeparator+ArtistDir+DirectorySeparator+AlbumDir;
      MI_CopyToExternal1.Add(SubItem);
      SubItem:= TMenuItem.Create(PM_Albums2);
      Subitem.OnClick:=@OnCopyToHasClick;
      SubItem.Caption:= Settings.IncludeExternalDirs.Strings[i-1]+DirectorySeparator+lowercase(ArtistDir[1])+DirectorySeparator+ArtistDir;
      MI_CopyToExternal1.Add(SubItem);
      SubItem:= TMenuItem.Create(PM_Albums2);
      Subitem.OnClick:=@OnCopyToHasClick;
      SubItem.Caption:= Settings.IncludeExternalDirs.Strings[i-1]+DirectorySeparator+lowercase(ArtistDir[1])+DirectorySeparator+ArtistDir+DirectorySeparator+AlbumDir;
      MI_CopyToExternal1.Add(SubItem);
    end;
   end;
end;

procedure TForm1.LB_Albums2DblClick(Sender: TObject);
begin
  Application.ProcessMessages;
  SG_ALLDblClick(self);
end;

procedure TForm1.LB_Albums2KeyPress(Sender: TObject; var Key: char);
begin
  if key=#13 then SG_AllDblClick(Self);
  if key='/' then
     begin
       Key:=#0;
       if Pagecontrol2.ActivePageIndex=1 then
       begin
         SearchPanelQueue.Visible:=not SearchPanelQueue.Visible;
         if SearchPanelQueue.Visible then Edit4.SetFocus;
       end;
     end;
end;

procedure TForm1.LB_Albums2MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if ssRight in Shift then LB_Albums2.ItemIndex:=(LB_Albums2.GetIndexAtY(Y));
end;

procedure TForm1.LB_Artist1Click(Sender: TObject);
begin
  // queued on app idle as there are too many intermediate events under Mac OS X
  Application.AddOnIdleHandler(@LB_Artist1ClickedHandler);
end;

procedure TForm1.LB_Artist1ClickedHandler(Sender: TObject; var Done: Boolean);
begin
  Application.RemoveOnIdleHandler(@LB_Artist1ClickedHandler);
  LB_Artist1Clicked;
end;

function TForm1.GetGridFilename(aRow: Integer): string;
begin
  result := Form1.SG_All.Cells[COL_SG_ALL_PATH,aRow]+Form1.SG_All.Cells[COL_SG_ALL_NAME, aRow];
end;

function TForm1.SongToRow(aGrid: TStringGrid; Song: Integer): Integer;
var
  aCol: Integer;
  aRow: Integer;
  songStr: string;
begin
  // TODO: use grid.Objects for storing song number in both grids
  if aGrid=SG_All then aCol := 0
                  else aCol := 6;
  songStr := IntToStr(Song);
  result := -1;
  for aRow:=1 to aGrid.RowCount-1 do
    if agrid.Cells[aCol, aRow]=songStr then
    begin
      result := aRow;
      break;
    end;
end;

function TForm1.RowToSong(aGrid: TStringGrid; aRow: Integer): Integer;
var
  aCol: Integer;
begin
  // TODO: use grid.Objects for storing song number in both grids
  if aGrid=SG_All then aCol := 0
                  else aCol := 6;
  result := StrToInt(aGrid.Cells[aCol, aRow]);
end;

procedure TForm1.DeleteSelectedSongs(aGrid: TStringGrid);
var wissen, removeFromPlay, yesToAll: boolean;
    x: longint;
    aRow, mr, i: Integer;
    msgTitle, line1, line2, line3, yesStr, noStr: string;
begin
  removeFromPlay:=false;
  FilesFound.Clear;
  for aRow:=1 to aGrid.RowCount-1 do
  begin
    if aGrid.IsCellSelected[1, aRow] then
    begin
      if aGrid=SG_All then FilesFound.Add(aGrid.Cells[0, aRow])
                      else FilesFound.Add(aGrid.Cells[6, aRow]);
    end;
  end;

  msgTitle := Vertaal('Delete Songs'); yesStr := Vertaal('YES'); noStr := Vertaal('NO');

  begin
    FormShowMyDialog.CheckListBox1.Clear;
    For i:= 0 to FilesFound.Count-1 do
    begin
      FormShowMyDialog.CheckListBox1.Items.Add(Liedjes[strtoint(FilesFound.Strings[i])].Bestandsnaam);
      FormShowMyDialog.CheckListBox1.Checked[i]:=true;
    end;
    if not FormShowMyDialog.ShowWith(msgTitle,Vertaal('Are you sure you want to delete the selected song(s)'),' ',' ',yesStr,noStr, True) then exit;
  end;

  line2 := Vertaal('Deleting the song removes it from the Playing Queue too.');
  line3 := Vertaal('ARE YOU SURE?');
  yesToAll := false;

  If aGrid=SG_All then
  begin
    For i:=0 to FilesFound.Count-1 do
    begin
      if not yesToAll then
      begin
        wissen:=true;
        x:=SongToRow(SG_Play, strtoint(FilesFound.Strings[i]));
        if x>0 then
        begin
          begin
            line1 := format(Vertaal('%s, is in the current Playing Queue.'),[Liedjes[strtoint(FilesFound.Strings[i])].Bestandsnaam]);
            mr := FormShowMyDialog.ShowWith(msgTitle,line1,line2,line3,[mrYes,yesStr,mrYesToAll,Vertaal('YES TO ALL'),mrNo,noStr,mrCancel,Vertaal('CANCEL')], true);
          end;
          case mr of
            mrYes: removeFromPlay := true;
            mrYesToAll: yesToAll := true;
            mrNo: wissen := false;
            else exit;
          end;
          if not wissen then FormShowMyDialog.CheckListBox1.Checked[i]:=false;
        end;
      end;
    end;
  end;

  For i:=0 to FilesFound.Count-1 do
  begin
    if FormShowMyDialog.CheckListBox1.Checked[i] then
    begin
      ShowMessage('Deleting: '+Liedjes[strtoint(FilesFound.Strings[i])].Bestandsnaam);
      DeleteFile(Liedjes[strtoint(FilesFound.Strings[i])].Pad+Liedjes[strtoint(FilesFound.Strings[i])].Bestandsnaam);
      RemoveFromPlayingQueue(strtoint(FilesFound.Strings[i]));
      x:=SongToRow(SG_All,strtoint(FilesFound.Strings[i]));
      if x>0 then SG_All.DeleteRow(x);
      Liedjes[strtoint(FilesFound.Strings[i])].Deleted:=True;
    end;
  end;

end;

procedure TForm1.ClearPlayIndicator;
var
  aRow: Integer;
begin
  for aRow:=1 to SG_Play.RowCount-1 do if SG_Play.Cells[0,aRow]<>' ' then SG_Play.Cells[0,aRow]:=' ';
end;

procedure TForm1.ClearGridSelection(aGrid: TStringGrid; withInvalidate: boolean);
begin
  if aGrid=SG_All then FAllSel.Clear;
  if aGrid=SG_Play then FPlaySel.Clear;

  if withInvalidate then aGrid.Invalidate;
end;

function TForm1.IsCellSelected(aGrid: TStringGrid; aCol, aRow: Integer): boolean;
begin
  if aGrid=SG_All then result := FAllSel.IsCellSelected(aCol, aRow)
                  else result := FPlaySel.IsCellSelected(aCol, aRow);
end;


procedure TForm1.LB_Artist1Clicked;
var
  AllSelected: boolean;
  tempartiest, previousAlbum, temp: String;
  max, lastadded: longint;
  j: longint;
  i2: longint;
  i: longint;
  Temp_StringList: TStringList;
  SongsWithoutAlbum: Boolean;
begin
  getoondePlaylist:=''; SB_Save.Enabled:=False; PanelVolume.Visible:=False;
  MI_RemoveFromPlaylist.Enabled := False; PreviousAlbum:='';

  if LB_Artist1.ItemIndex < 0 then exit; // Geen Liedjes
  AllSelected := LB_Artist1.ItemIndex = 0;
  if AllSelected and (SG_All.RowCount >= maxsongs) then exit;
  LB_Artist1.Cursor := CrHourglass; Application.ProcessMessages;

  LB_Albums2.Items.Clear; i2 := 0;

  Temp_StringList := TStringList.Create;
  Temp_StringList.Sorted := True; Temp_StringList.Duplicates := dupIgnore;

  FAllSel.Enabled := false;
  SG_All.BeginUpdate;
  SG_All.RowCount := maxsongs + 1;

  If not CB_ShowAllThumbs.Checked then
  begin
    lastadded:=0; SongsWithoutAlbum:=False;
    ThumbControl1.ClearImages;
  end;

  if AllSelected then
  begin
    max := maxsongs - 1;
    for i := 0 to max do if not Liedjes[i].Deleted then
    begin
      inc(i2);
      SG_All.Cells[0, i2] := Inttostr(i);
      SG_All.Cells[1, i2] := Liedjes[i].Artiest;
      if Liedjes[i].Track = 0 then SG_All.Cells[2, i2] := ''
                              else if Liedjes[i].Track < 10 then SG_All.Cells[2, i2] := '0' + inttostr(Liedjes[i].Track)
                                                            else SG_All.Cells[2, i2] := inttostr(Liedjes[i].Track);
      SG_All.Cells[3, i2] := Liedjes[i].Titel;
      SG_All.Cells[4, i2] := Liedjes[i].CD;
      SG_All.Cells[COL_SG_ALL_PATH, i2] := Liedjes[i].Pad;
      SG_All.Cells[COL_SG_ALL_NAME, i2] := Liedjes[i].Bestandsnaam;
      //Add images to ThumbControl
      If Length(Liedjes[i].CD)=0 then SongsWithoutAlbum:=true;
          if (Liedjes[i].CD<>PreviousAlbum) and (Length(Liedjes[i].CD)>0) then
          begin
            if Temp_StringList.IndexOf(Liedjes[i].CD)<0 then
            begin
              Temp_StringList.Add(Liedjes[i].CD);

              temp:=ConfigDir+DirectorySeparator+'cache'+DirectorySeparator+ConvertArtist(SG_All.Cells[1,i2],true)+'-'+ConvertAlbum(SG_All.Cells[4,i2])+'.jpg';
              if FileExistsUTF8(temp) then ThumbControl1.AddImage(temp,SG_All.Cells[0,i2],SG_All.Cells[1,i2]+' - '+SG_All.Cells[4,i2] )
                                      else if FileExistsUTF8(ConfigDir+DirectorySeparator+'cache'+DirectorySeparator+ConvertArtist(SG_All.Cells[1,i2],true)+'-'+ConvertAlbum(SG_All.Cells[4,i2])+'.png')
                                           then ThumbControl1.AddImage(ConfigDir+DirectorySeparator+'cache'+DirectorySeparator+ConvertArtist(SG_All.Cells[1,i2],true)+'-'+ConvertAlbum(SG_All.Cells[4,i2])+'.png', SG_All.Cells[0,i2],SG_All.Cells[1,i2]+' - '+SG_All.Cells[4,i2])
                                           else if FileExistsUTF8(ConfigDir+DirectorySeparator+'cache'+DirectorySeparator+ConvertArtist(SG_All.Cells[1,i2],true)+'.png')
                                                then ThumbControl1.AddImage(ConfigDir+DirectorySeparator+'cache'+DirectorySeparator+ConvertArtist(SG_All.Cells[1,i2],true)+'.png', SG_All.Cells[0,i2],SG_All.Cells[1,i2]+' - '+SG_All.Cells[4,i2])
                                                else if FileExistsUTF8(ConfigDir+DirectorySeparator+'cache'+DirectorySeparator+ConvertArtist(SG_All.Cells[1,i2],true)+'.jpg')
                                                     then ThumbControl1.AddImage(ConfigDir+DirectorySeparator+'cache'+DirectorySeparator+ConvertArtist(SG_All.Cells[1,i2],true)+'.jpg', SG_All.Cells[0,i2],SG_All.Cells[1,i2]+' - '+SG_All.Cells[4,i2])
                                                     else if FileExistsUTF8(ConfigDir+DirectorySeparator+'cache'+DirectorySeparator+'unknown.jpg') then ThumbControl1.AddImage(ConfigDir+DirectorySeparator+'cache'+DirectorySeparator+'unknown.jpg', SG_All.Cells[0,i2],SG_All.Cells[1,i2]+' - '+SG_All.Cells[4,i2]);
              inc(lastadded);
              PreviousAlbum:=Liedjes[i].CD;
            end;
          end;
    end;
    SG_All.RowCount := i2 + 1;
  end

                           else
  begin
    for j := 0 to LB_Artist1.Count - 1 do
    begin
      if not LB_Artist1.Selected[j] then
        continue;
      tempartiest := Upcase(LB_Artist1.Items[j]);
      max := maxsongs - 1;
      for i := 0 to max do
      begin

        if upcase(Liedjes[i].Artiest) = tempartiest then if not Liedjes[i].Deleted then
        begin
          inc(i2); //Temp_StringList.Add(Liedjes[i].CD);
          SG_All.Cells[0, i2] := Inttostr(i);
          SG_All.Cells[1, i2] := Liedjes[i].Artiest;
          if Liedjes[i].Track = 0 then SG_All.Cells[2, i2] := ''
                                else if Liedjes[i].Track < 10 then SG_All.Cells[2, i2] := '0' + inttostr(Liedjes[i].Track)
                                                              else SG_All.Cells[2, i2] := inttostr(Liedjes[i].Track);
          SG_All.Cells[3, i2] := Liedjes[i].Titel;
          SG_All.Cells[4, i2] := Liedjes[i].CD;
          SG_All.Cells[COL_SG_ALL_PATH, i2] := Liedjes[i].Pad;
          SG_All.Cells[COL_SG_ALL_NAME, i2] := Liedjes[i].Bestandsnaam;

          //Add images to Thumbcontrol
          If Length(Liedjes[i].CD)=0 then SongsWithoutAlbum:=true;
          if (Liedjes[i].CD<>PreviousAlbum) and (Length(Liedjes[i].CD)>0) then
          begin
            if Temp_StringList.IndexOf(Liedjes[i].CD)<0 then
            begin
              Temp_StringList.Add(Liedjes[i].CD);

              temp:=ConfigDir+DirectorySeparator+'cache'+DirectorySeparator+ConvertArtist(SG_All.Cells[1,i2],true)+'-'+ConvertAlbum(SG_All.Cells[4,i2])+'.jpg';
              if FileExistsUTF8(temp) then ThumbControl1.AddImage(temp,SG_All.Cells[0,i2],SG_All.Cells[1,i2]+' - '+SG_All.Cells[4,i2] )
                                      else if FileExistsUTF8(ConfigDir+DirectorySeparator+'cache'+DirectorySeparator+ConvertArtist(SG_All.Cells[1,i2],true)+'-'+ConvertAlbum(SG_All.Cells[4,i2])+'.png')
                                           then ThumbControl1.AddImage(ConfigDir+DirectorySeparator+'cache'+DirectorySeparator+ConvertArtist(SG_All.Cells[1,i2],true)+'-'+ConvertAlbum(SG_All.Cells[4,i2])+'.png', SG_All.Cells[0,i2],SG_All.Cells[1,i2]+' - '+SG_All.Cells[4,i2])
                                           else if FileExistsUTF8(ConfigDir+DirectorySeparator+'cache'+DirectorySeparator+ConvertArtist(SG_All.Cells[1,i2],true)+'.png')
                                                then ThumbControl1.AddImage(ConfigDir+DirectorySeparator+'cache'+DirectorySeparator+ConvertArtist(SG_All.Cells[1,i2],true)+'.png', SG_All.Cells[0,i2],SG_All.Cells[1,i2]+' - '+SG_All.Cells[4,i2])
                                                else if FileExistsUTF8(ConfigDir+DirectorySeparator+'cache'+DirectorySeparator+ConvertArtist(SG_All.Cells[1,i2],true)+'.jpg')
                                                     then ThumbControl1.AddImage(ConfigDir+DirectorySeparator+'cache'+DirectorySeparator+ConvertArtist(SG_All.Cells[1,i2],true)+'.jpg', SG_All.Cells[0,i2],SG_All.Cells[1,i2]+' - '+SG_All.Cells[4,i2])
                                                     else if FileExistsUTF8(ConfigDir+DirectorySeparator+'cache'+DirectorySeparator+'unknown.jpg') then ThumbControl1.AddImage(ConfigDir+DirectorySeparator+'cache'+DirectorySeparator+'unknown.jpg', SG_All.Cells[0,i2],SG_All.Cells[1,i2]+' - '+SG_All.Cells[4,i2]);
              inc(lastadded);
              PreviousAlbum:=Liedjes[i].CD;
            end;
          end;
        end;
      end;
    end;
    SG_All.RowCount := i2 + 1;
  end;

  If not CB_ShowAllThumbs.Checked then
      if SongsWithoutAlbum then if FileExistsUTF8(ConfigDir+DirectorySeparator+'cache'+DirectorySeparator+'unknown.jpg') then ThumbControl1.AddImage(ConfigDir+DirectorySeparator+'cache'+DirectorySeparator+'unknown.jpg', '-1','No Album');

  if i2 > 0 then SG_All.Row := 1;

  FAllSel.Enabled := true;
  FAllSel.Update;
  SG_All.EndUpdate(True);
  AutoSizeAllColumns;
  LB_Albums2.Items.AddStrings(Temp_Stringlist); LB_Albums2.Items.Insert(0,Vertaal('All'));
  Temp_StringList.Free;

  If (PageControl2.PageIndex=7) and (CB_ShowAllThumbs.Checked) then PageControl2.PageIndex := 0;
  If (PageControl2.PageIndex<>7)  then PageControl2.PageIndex := 0;// Show SG_All
  SG_AllClick(Self);
  LB_Artist1.Cursor := CrDefault;
  if LB_Albums2.Items.Count > 1 then if LB_Albums2.Items[1] = ''
    then LB_Albums2.Items.Delete(1);
  LB_Albums2.ItemIndex := 0;
end;


procedure TForm1.LB_Artist1DblClick(Sender: TObject);
begin
  fullrandom:=true;
  If SG_All.RowCount>1 then SG_AllDblClick(Self);
  fullrandom:=false;
end;

procedure TForm1.LB_Artist1KeyPress(Sender: TObject; var Key: char);
(* WORK AROUND FOR DARWIN LISTBOXES Is NOT NEEDED ANYMORE *)
{$IFDEF DARWIN}
var ch: char;
    i: longint;
{$ENDIF}
begin
  if (key=#13) or (key=#32) then
  begin
    LB_Artist1Clicked;
    Application.ProcessMessages;
  end;
  if key=#13 then SG_AllDblClick(Self);
{$IFDEF DARWIN}
  if LB_Artist1.Items.Count>1 then
  begin
    if ((key>#47) and (key<#123)) or (key=#32) then
    begin
      LB_Artist1.MultiSelect:=False;
      ch:=upcase(key);
      zoekstring:=zoekstring+ch;
      For i:=1 to LB_Artist1.Items.Count-1 do
        if pos(zoekstring,upcase(LB_artist1.Items[i]))=1 then
        begin
          LB_Artist1.ItemIndex:=i; LB_Artist1.MakeCurrentVisible;
          LB_Artist1.MultiSelect:=True;
          exit;
        end;
      zoekstring:=ch;
      For i:=1 to LB_Artist1.Items.Count-1 do
        if pos(zoekstring,upcase(LB_artist1.Items[i]))=1 then
        begin
          LB_Artist1.ItemIndex:=i; LB_Artist1.MakeCurrentVisible;
          LB_Artist1.MultiSelect:=True;
          exit;
        end;
      LB_Artist1.MultiSelect:=True;
    end;
  end;
 {$ENDIF}
 if key='/' then
     begin
       Key:=#0;
       if Pagecontrol2.ActivePageIndex=1 then
       begin
         SearchPanelQueue.Visible:=not SearchPanelQueue.Visible;
         if SearchPanelQueue.Visible then Edit4.SetFocus;
       end;
       if Pagecontrol2.ActivePageIndex=0 then
       begin
         SearchPanelBrowser.Visible:=not SearchPanelBrowser.Visible;
         if SearchPanelBrowser.Visible then Edit5.SetFocus;
       end;
     end;
end;

procedure TForm1.LB_Artist1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if ssRight in Shift then LB_Artist1.ItemIndex:=(LB_Artist1.GetIndexAtY(Y));
end;

procedure TForm1.LB_M3UClick(Sender: TObject);
var lijn, filename, folder: string;
    Filevar: textFile;
    webadres, gevonden, showwarning: boolean;
    i2, aantalgetoonde: longint;
begin
 GetoondePlaylist:=''; SB_Save.Enabled:=False;
 PanelVolume.Visible:=False;
  if LB_M3U.ItemIndex>=0 then
  begin
    MI_RemoveFromPlaylist.Enabled:=False; SB_Save.Enabled:=false;
    if FileExistsUTF8(M3UFilesFound.Strings[LB_M3U.ItemIndex]) then
    begin
      showwarning:=true;
      PageControl2.ActivePageIndex:=0; aantalgetoonde:=0;
      AssignFile(filevar,M3UFilesFound.Strings[LB_M3U.ItemIndex]);
      Reset(Filevar);
      repeat
        Readln(Filevar,lijn);
        if length(lijn)>0 then if lijn[1]<>'#'
           then
           begin
             if pos('http',lijn)=1 then webadres:=true
                                   else webadres:=false;
             if not webadres then
             begin

               folder:=ExtractFileDir(lijn); if folder='' then folder:=ExtractFileDir(M3UFilesFound.Strings[LB_M3U.ItemIndex]);
               Filename:=Extractfilename(lijn);

               lijn:=folder+Directoryseparator+filename;
               if not FileExistsUTF8(lijn) then
               begin
                 if showwarning then if not FormShowMyDialog.ShowWith(Vertaal('WARNING'),lijn,Vertaal('does not exist'),'',Vertaal('OK'),Vertaal('Dont Show Again'), False) then showwarning:=false;
               end
                 else
               begin
                 inc(aantalgetoonde);
                 SG_all.RowCount:=aantalgetoonde+1;
                 gevonden:=false; i2:=0;
                 repeat
                   inc(i2);
                   if lijn=Liedjes[i2].Pad+Liedjes[i2].Bestandsnaam then gevonden:=true;
                   if gevonden then
                   begin
                     Form1.SG_All.Cells[0,aantalgetoonde]:=Inttostr(i2);
                     Form1.SG_All.Cells[1,aantalgetoonde]:=Liedjes[i2].Artiest;
                     if Liedjes[i2].Track=0 then Form1.SG_All.Cells[2,aantalgetoonde]:=''
                                            else Form1.SG_All.Cells[2,aantalgetoonde]:=Inttostr(Liedjes[i2].Track);
                     Form1.SG_All.Cells[3,aantalgetoonde]:=Liedjes[i2].Titel;
                     Form1.SG_All.Cells[4,aantalgetoonde]:=Liedjes[i2].CD;
                     Form1.SG_All.Cells[COL_SG_ALL_PATH,aantalgetoonde]:=Liedjes[i2].Pad;
                     Form1.SG_All.Cells[COL_SG_ALL_NAME,aantalgetoonde]:=Liedjes[i2].Bestandsnaam;
                   end;
                 until (i2=maxsongs) or gevonden;
               end;
             end;
           end;
      until eof(filevar);
      AutoSizeAllColumns;
    end;
  end;
end;

procedure TForm1.LB_M3UDblClick(Sender: TObject);
begin
  Application.ProcessMessages;
  SG_AllDblClick(Self);
end;

procedure TForm1.LB_PlaylistClick(Sender: TObject);
var Filevar: TextFile;
    lijn: string;
    gevonden: boolean;
    i, aantalgetoonde: longint;
begin
 PanelVolume.Visible:=False;
 SB_Save.Enabled:=False;
   PageControl2.ActivePageIndex:=0;
   if LB_Playlist.ItemIndex >=0 then
   begin
     MI_AddToPlaylist1.Enabled:=True;
     MI_RemoveFromPlaylist.Enabled:=True;
     MenuItem65.Enabled:=True; MI_AddToPlaylist2.Enabled:=True;

     LB_Playlist.Cursor:=crHourGlass; Application.ProcessMessages;
     GeladenPlaylist:=LB_Playlist.Items[LB_Playlist.ItemIndex];
     GetoondePlaylist:=GeladenPlaylist;
     aantalgetoonde:=0; SG_All.RowCount:=maxsongs+1;
     AssignFile(Filevar,ConfigDir+DirectorySeparator+'playlist'+DirectorySeparator+GeladenPlaylist+'.xix');
     Reset(Filevar);
     Repeat
       Readln(Filevar,lijn);
       if length(lijn)>0 then
       begin
         gevonden:=false; i:=0;
         repeat
           if lijn=Liedjes[i].Pad+Liedjes[i].Bestandsnaam then gevonden:=true;
           if gevonden then
           begin
             inc(aantalgetoonde);
             Form1.SG_All.Cells[0,aantalgetoonde]:=Inttostr(i);
             Form1.SG_All.Cells[1,aantalgetoonde]:=Liedjes[i].Artiest;
             if Liedjes[i].Track=0 then Form1.SG_All.Cells[2,aantalgetoonde]:=''
                                   else if Liedjes[i].Track<10 then Form1.SG_All.Cells[2,aantalgetoonde]:='0'+inttostr(Liedjes[i].Track)
                                                               else Form1.SG_All.Cells[2,aantalgetoonde]:=inttostr(Liedjes[i].Track);
             Form1.SG_All.Cells[3,aantalgetoonde]:=Liedjes[i].Titel;
             Form1.SG_All.Cells[4,aantalgetoonde]:=Liedjes[i].CD;
             Form1.SG_All.Cells[COL_SG_ALL_PATH,aantalgetoonde]:=Liedjes[i].Pad;
             Form1.SG_All.Cells[COL_SG_ALL_NAME,aantalgetoonde]:=Liedjes[i].Bestandsnaam;
           end;
           inc(i);
         until (i=maxsongs) or gevonden;
       end;
     until eof(Filevar);
     CloseFile(Filevar);
     if aantalgetoonde>1 then MI_RemoveFromPlaylist.Enabled:=True;
     SG_All.RowCount:=aantalgetoonde+1;
     AutoSizeAllColumns;
     LB_Playlist.Cursor:=crDefault;
     MenuItem65.Caption:=Vertaal('Add selected to')+' '+GeladenPlaylist;
   end;
end;

procedure TForm1.LB_PlaylistDblClick(Sender: TObject);
begin
  LB_PlaylistClick(Self);
  if SG_All.RowCount>0 then
  begin
    SG_AllClick(Self);
    SG_ALLDblClick(Self);
  end;
end;

procedure TForm1.LB_PlaylistMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if ssRight in Shift then LB_Playlist.ItemIndex:=(LB_Playlist.GetIndexAtY(Y));
end;

procedure TForm1.LB_TitelClick(Sender: TObject);
begin
  case stream of
    1,2,4: begin
           songchosen:=songplaying;
           if not FormDetails.Visible then FormDetails.Show
                                      else FormDetails.UpdateInformation;
           FormDetails.BringToFront;
         end;
    6: ShowMessage('Detailed info not yet available for individual files');
  end; { of case }
end;

function TForm1.DownloadHTTP(URL, TargetFile: string): boolean;
const
  MaxRetries=3;
var
  HTTPGetResult: boolean;
  HTTPSender: THTTPSend;
  RetryAttempt: integer;
  Haiku: boolean;
  AProcess: TProcess;
begin
  Haiku:=False;
   {$IFDEF HAIKU}
     Haiku:=true;
     AProcess := TProcess.Create(nil);
     try
      AProcess.CommandLine:='wget '+url+' -O '+TargetFile+' -T 5 -t 1';
      AProcess.options:=AProcess.options+[poWaitOnExit];
      AProcess.Execute;
     except
     ShowMessage(Vertaal('Download '+TargetFile+' went wrong'));
     end;
     AProcess.Free;
     if fileexists(TargetFile) then Result:=True;
   {$ENDIF}
  if not haiku then
  begin
    result:=false;
    RetryAttempt:=0;
    //Optional: mangling of Sourceforge file download URLs; see below.
   //URL:=SourceForgeURL(URL); Deal with sourceforge URLs
    HTTPSender:=THTTPSend.Create;
    try
      try
        // Try to get the file
        HTTPGetResult:=HTTPSender.HTTPMethod('GET', URL);
        while (HTTPGetResult=false) and (RetryAttempt<MaxRetries) do
        begin
          sleep(500*RetryAttempt);
          HTTPGetResult:=HTTPSender.HTTPMethod('GET', URL);
          RetryAttempt:=RetryAttempt+1;
        end;
        // If we have an answer from the server, check if the file was sent to us.
        case HTTPSender.Resultcode of
        100..299:
          begin
            with TFileStream.Create(TargetFile,fmCreate or fmOpenWrite) do
            try
              Seek(0, soFromBeginning);
              CopyFrom(HTTPSender.Document, 0);
            finally
              Free;
            end;
            result:=true;
          end; //informational, success
        300..399: result:=false; //redirection. Not implemented, but could be.
        400..499: result:=false; //client error; 404 not found etc
        500..599: result:=false; //internal server error
        else result:=false; //unknown code
      end;
      // Showmessage(inttostr(HTTPSender.Resultcode));
      except
        result:=false;
      end;
    finally
      HTTPSender.Free;
    end;
  end;
end;

procedure TForm1.ListBox2Click(Sender: TObject);
begin

end;

procedure TForm1.LB_RadioWebsiteClick(Sender: TObject);
begin
  BrowseTo('http://'+LB_RadioWebsite.Caption);
end;

procedure TForm1.ListBox2DblClick(Sender: TObject);
begin

end;

procedure TForm1.MenuItem44Click(Sender: TObject);
begin
  If StringGridCD.RowCount>1 then
  begin
    FormFillInCD.Label1.Caption:='Artist:';
    FormFillInCD.Edit1.Visible:=true;
    FormFillInCD.MaskEdit1.Visible:=false;
    FormFillInCD.ComboBox1.Visible:=false;
    FormFillInCD.Edit1.Text:=StringGridCD.Cells[1,1];
    FormFillInCD.Showmodal;
    Stringgridcd.AutoSizeColumns;
  end;
end;

procedure TForm1.MenuItem50Click(Sender: TObject);
begin
  If StringGridCD.RowCount>1 then
  begin
    FormFillInCD.Label1.Caption:='Album:';
    FormFillInCD.Edit1.Visible:=True;
    FormFillInCD.MaskEdit1.Visible:=false;
    FormFillInCD.ComboBox1.Visible:=false;
    FormFillInCD.Edit1.Text:=StringGridCD.Cells[3,1];
    FormFillInCD.Showmodal;
    Stringgridcd.AutoSizeColumns;
  end;
end;

procedure TForm1.MenuItem52Click(Sender: TObject);
begin
  If StringGridCD.RowCount>1 then
  begin
    FormFillInCD.Label1.Caption:='Year:';
    FormFillInCD.Edit1.Visible:=False;
    FormFillInCD.MaskEdit1.Visible:=true;
    FormFillInCD.ComboBox1.Visible:=false;
    FormFillInCD.Showmodal;
    Stringgridcd.AutoSizeColumns;
  end;
end;

procedure TForm1.MenuItem53Click(Sender: TObject);
begin
  If StringGridCD.RowCount>1 then
  begin
    FormFillInCD.Label1.Caption:='Genre:';
    FormFillInCD.Edit1.Visible:=False;
    FormFillInCD.MaskEdit1.Visible:=false;
    FormFillInCD.ComboBox1.Visible:=true;
    FormFillInCD.Edit1.Text:='';
    FormFillInCD.Showmodal;
    Stringgridcd.AutoSizeColumns;
  end;
end;

procedure TForm1.MenuItem55Click(Sender: TObject);
begin
  SG_PlayDblClick(Self);
end;

procedure TForm1.MenuItem58Click(Sender: TObject);
begin
  FormConfig.CB_MinimizeOnClose.Checked:=False;
  Close;
end;

procedure TForm1.MenuItem60Click(Sender: TObject);
begin
  PageControl1.ActivePageIndex:=0;
  LB_Artist1.ItemIndex:=LB_Artist1.Items.IndexOf(SG_Play.Cells[1,SG_Play.Row]);
  LB_Artist1.MakeCurrentVisible;
  LB_Artist1Click(Self);
end;

procedure TForm1.MenuItem61Click(Sender: TObject);
var i: Longint;
begin
  for i:=SG_Play.RowCount-1 downto 1 do if IsCellSelected(SG_Play, 1,i) then
  begin
   if (SG_Play.Cells[0,i]='»') then
                                begin
                                  if FormShowMyDialog.ShowWith(Vertaal('Remove from Playing Queue'),Vertaal('Do you want to remove the song currently playing from the Playing Queue'),Vertaal('This will stop the music'),'',Vertaal('YES'),vertaal('NO'), False) then
                                  begin
                                    SB_StopClick(Self);
                                    SG_Play.Cells[0,i]:='x';
                                  end;
                                end
                              else SG_Play.Cells[0,i]:='x';
  end;
  for i:=SG_Play.RowCount-1 downto 1 do if SG_Play.Cells[0,i]='x' then SG_Play.DeleteRow(i);
end;

procedure TForm1.MenuItem62Click(Sender: TObject);
begin
  SG_Play.RowCount:=1; SongsInPlayingQueue:=0;
  SB_StopClick(Self);
end;

procedure TForm1.MenuItem64Click(Sender: TObject);
var olditems: integer;
begin
  if SG_play.RowCount>1 then
  begin
    olditems:=LB_playlist.Items.Count;
    modespeellijst:=4;
    FOrmNewPlaylist.ShowModal;
    if olditems<LB_playlist.Items.Count then
    begin
      SubItem:= TMenuItem.Create(PM_SGAll);
      Subitem.OnClick:=@OnSubItemHasClick;
      SubItem.Caption:= FormNewPlaylist.Edit1.Text;
      PM_SGAll.Items[7].Add(SubItem);
    end;
  end;
end;


procedure TForm1.MenuItem69Click(Sender: TObject);
var welkerij, welkesong: longint;
begin
  welkerij:=SG_Play.Row; welkesong:=strtoint(SG_Play.Cells[6,welkerij]); songchosen:=welkesong;
  FormRenameSong.Showmodal;
end;

procedure TForm1.UpdateArtistGrids(x: longint);
var i: longint;
begin
  for i:=1 to SG_All.RowCount-1 do
  begin
    If strtoint(SG_All.Cells[0,i])=x then
    begin
      SG_All.Cells[1,i]:=Liedjes[x].Artiest;
      if Liedjes[x].Track>9 then SG_All.Cells[2,i]:=inttostr(Liedjes[x].Track)
                            else if Liedjes[x].Track=0 then SG_All.Cells[2,i]:=''
                                                       else SG_All.Cells[2,i]:='0'+inttostr(Liedjes[x].Track);
      SG_All.Cells[3,i]:=Liedjes[x].Titel;
      SG_All.Cells[4,i]:=Liedjes[x].CD;
      // JRA: what about path?
      // Zittergie:  Does not need to be updated.  ID3 Info Can be changed
      //             & Filename can be changed.  Filepath stays the same
      SG_All.Cells[COL_SG_ALL_NAME,i]:=Liedjes[x].Bestandsnaam;
      AutoSizeAllColumns;
      break;
    end;
  end;
  for i:=1 to SG_Play.RowCount-1 do
  begin
    If strtoint(SG_Play.Cells[6,i])=x then
    begin
      SG_Play.Cells[1,i]:=Liedjes[x].Artiest;
      if Liedjes[x].Track>9 then SG_Play.Cells[2,i]:=inttostr(Liedjes[x].Track)
                            else if Liedjes[x].Track=0 then SG_Play.Cells[2,i]:=''
                                                       else SG_Play.Cells[2,i]:='0'+inttostr(Liedjes[x].Track);
      SG_Play.Cells[3,i]:=Liedjes[x].Titel;
      SG_Play.Cells[4,i]:=Liedjes[x].CD;
      SG_Play.Cells[5,i]:=Liedjes[x].Jaartal;
      AutoSizePlayColumns;
      SG_Play.ColWidths[6]:=1;
      break;
    end;
  end;
end;

procedure TForm1.MenuItem70Click(Sender: TObject);
begin
  DeleteSelectedSongs(SG_Play);
end;

procedure TForm1.MenuItem73Click(Sender: TObject);
var cmd: string;
    AProcess: TProcess;
begin
  {$IFDEF LINUX}
    cmd:='xdg-open "'+Liedjes[strtoint(SG_Play.Cells[6,SG_Play.Row])].Pad+'"';
  {$ENDIF LINUX}
  {$IFDEF DARWIN}
    cmd:='open "'+Liedjes[strtoint(SG_Play.Cells[6,SG_Play.Row])].Pad+'"';
  {$ENDIF DARWIN}
  {$IFDEF WINDOWS}
    cmd:='explorer "'+utf8tosys(Liedjes[strtoint(SG_Play.Cells[6,SG_Play.Row])].Pad)+'"';
  {$ENDIF WINDOWS}
  {$IFDEF HAIKU}
    cmd:='open "'+Liedjes[strtoint(SG_Play.Cells[6,SG_Play.Row])].Pad+'"';
  {$ENDIF}
  AProcess := TProcess.Create(nil);
  AProcess.CommandLine := cmd;
  AProcess.Execute;
  AProcess.Free;
end;

procedure TForm1.MenuItem74Click(Sender: TObject);
begin
  If SG_All.Cells[4,SG_Play.Row]<>'' then
  begin
    PageControl1.ActivePageIndex:=1;
    LB_Albums1.ItemIndex:=LB_Albums1.Items.IndexOf(SG_Play.Cells[4,SG_Play.Row]);
    LB_Albums1.MakeCurrentVisible;
    LB_Albums1Click(Self);
  end;
end;

procedure TForm1.MenuItem75Click(Sender: TObject);
var genre: string;
    i,i2: longint;
begin
  genre:=Liedjes[strtoint(SG_Play.Cells[6, SG_Play.Row])].Genre;
  if genre='' then exit;
  SG_All.RowCount:=1; i2:=0;
  for i:=0 to maxsongs-1 do if not Liedjes[i].Deleted then
  begin
    if (pos(genre,Liedjes[i].Genre)>0) or (pos(Liedjes[i].Genre,genre)>0) then
      begin
       inc(i2);
       SG_All.RowCount:=i2+1;
       SG_All.Cells[0,i2]:=inttostr(i);
       SG_All.Cells[1,i2]:=Liedjes[i].Artiest;
       if Liedjes[i].Track=0 then SG_All.Cells[2,i2]:=''
                             else if Liedjes[i].Track<10 then SG_All.Cells[2,i2]:='0'+inttostr(Liedjes[i].Track)
                                                         else SG_All.Cells[2,i2]:=inttostr(Liedjes[i].Track);
       SG_All.Cells[3,i2]:=Liedjes[i].Titel;
       SG_All.Cells[4,i2]:=Liedjes[i].CD;
       SG_All.Cells[COL_SG_ALL_PATH,i2]:=Liedjes[i].Pad;
       SG_All.Cells[COL_SG_ALL_NAME,i2]:=Liedjes[i].Bestandsnaam;
      end;
  end;
  AutoSizeAllColumns; PageControl2.PageIndex:=0; // Show SG_All

end;

procedure TForm1.MenuItem76Click(Sender: TObject);
var jaar: string;
    i,i2: longint;
begin
  jaar:=SG_Play.Cells[5, SG_Play.Row];
  if jaar='' then exit;
  SG_All.RowCount:=1; i2:=0;
  for i:=0 to maxsongs-1 do if not Liedjes[i].Deleted then
  begin
    if (pos(jaar,Liedjes[i].Jaartal)>0) or (pos(Liedjes[i].Jaartal,jaar)>0) then
      begin
       inc(i2);
       SG_All.RowCount:=i2+1;
       SG_All.Cells[0,i2]:=inttostr(i);
       SG_All.Cells[1,i2]:=Liedjes[i].Artiest;
       if Liedjes[i].Track=0 then SG_All.Cells[2,i2]:=''
                             else if Liedjes[i].Track<10 then SG_All.Cells[2,i2]:='0'+inttostr(Liedjes[i].Track)
                                                         else SG_All.Cells[2,i2]:=inttostr(Liedjes[i].Track);
       SG_All.Cells[3,i2]:=Liedjes[i].Titel;
       SG_All.Cells[4,i2]:=Liedjes[i].CD;
       SG_All.Cells[COL_SG_ALL_PATH,i2]:=Liedjes[i].Pad;
       SG_All.Cells[COL_SG_ALL_NAME,i2]:=Liedjes[i].Bestandsnaam;
      end;
  end;
  AutoSizeAllColumns; PageControl2.PageIndex:=0; // Show SG_All
end;

procedure TForm1.MenuItem78Click(Sender: TObject);
begin
   songchosen:=strtoint(SG_Play.Cells[6,SG_Play.Row]);
   if not FormDetails.Visible then FormDetails.Show
                             else
                               begin
                                 FormDetails.UpdateInformation;
                               end;
   FormDetails.SetFocus;
end;

procedure TForm1.MenuItem79Click(Sender: TObject);
var target, ext, temp: string;
    i: integer;
    welke: longint;  //Songchosen eventueel gebruiken
begin
 if SG_Play.RowCount>1 then
 begin
  If SelectDirectoryDialog1.Execute then
    Begin
     welke:=strtoint(SG_Play.Cells[6,SG_Play.Row]);
     i:=1;
     target:=SelectDirectoryDialog1.FileName+DirectorySeparator+Liedjes[welke].Bestandsnaam;
     ext:=ExtractFileExt(target);
     temp:=copy(target,1,length(target)-length(ext));
     if FileExistsUTF8(target) then
       repeat
          inc(i); target:=temp+' ('+inttostr(i)+')'+ext;
       until not FileExistsUTF8(target) ;
      CopyFile(Liedjes[welke].Pad+Liedjes[welke].Bestandsnaam,target);
      ShowMessage(Vertaal('Song successfully copied.'));
    end;
 end;
end;

procedure TForm1.MI_CDCover_ChooseNewFileClick(Sender: TObject);
var bestand, lijn, ext: string;
begin
 OpenDialog1.FileName:=Liedjes[songplaying].Pad;
  If OpenDialog1.Execute then
  begin
    ext:='x';
    bestand:=UpCase(OpenDialog1.FileName);
    if (pos('.JPG',bestand)>1) or (pos('.JPEG',bestand)>1) then ext:='.jpg';
    if (pos('.PNG',bestand)>1) then ext:='.png';
    if ext<>'x' then
    begin
      lijn:=convertartist(LB_artiest.Caption, true)+'-'+convertalbum(LB_cd.Caption);
      Deletefile(Configdir+Directoryseparator+'cache'+DirectorySeparator+lijn+'.png');
      Deletefile(Configdir+Directoryseparator+'cache'+DirectorySeparator+lijn+'.jpg');
      CopyFile(OpenDialog1.FileName,Configdir+Directoryseparator+'cache'+DirectorySeparator+lijn+ext);
      ImageCDCover.Picture.LoadFromFile(Configdir+Directoryseparator+'cache'+DirectorySeparator+lijn+ext);
      imageCDCoverLyric.Picture.Bitmap:=ImageCDCover.Picture.Bitmap;
    end;
  end;
end;

procedure TForm1.MI_CDCover_RemoveCDCoverClick(Sender: TObject);
var lijn: string;
    RemoveArtistFile: Boolean;
begin
  RemoveArtistFile:=True;
  lijn:=ConvertArtist(LB_artiest.Caption, true)+'-'+ConvertAlbum(LB_cd.Caption);
  If Deletefile(Configdir+Directoryseparator+'cache'+DirectorySeparator+lijn+'.png') then RemoveArtistFile:=false;
  If Deletefile(Configdir+Directoryseparator+'cache'+DirectorySeparator+lijn+'.jpg') then RemoveArtistFile:=false;
  if RemoveArtistFile then
  begin
    lijn:=ConvertArtist(LB_artiest.Caption, true);
    DeleteFile(Configdir+Directoryseparator+'cache'+DirectorySeparator+lijn+'.jpg');
    DeleteFile(Configdir+Directoryseparator+'cache'+DirectorySeparator+lijn+'.png');
  end;
  ImageCDCover.Picture.Bitmap:=FormDetails.Image2.Picture.Bitmap;
  ImageCDCoverLyric.Picture.Clear;
  Splitter4.Top:=26;
  Loaded_CD_Cover:='x';
end;

procedure TForm1.MI_VU_Active1Click(Sender: TObject);
begin
 if VU_Settings.Active<>1 then
 begin
   MI_VU_Active4.Checked:=False;
   VU_Settings.Active:=3;
   Panel_VUClick(Self);
 end;
end;

procedure TForm1.MI_CopyRecordingClick(Sender: TObject);
var MP3bestand: string;
begin
  If StringgridRecorded.Row>0 then
  begin
    MP3bestand:=configdir+DirectorySeparator+'recorded'+DirectorySeparator+StringgridRecorded.Cells[0,StringgridRecorded.Row]+' - '+StringgridRecorded.Cells[1,StringgridRecorded.Row]+'.mp3';
    SaveDialog1.FileName:=StringgridRecorded.Cells[0,StringgridRecorded.Row]+' - '+StringgridRecorded.Cells[1,StringgridRecorded.Row]+'.mp3';
    If SaveDialog1.Execute then
      begin
        cursor:=CrHourglass; Application.ProcessMessages;
        if CopyFile(MP3bestand,SaveDialog1.FileName) then showmessage(Vertaal('Recording copied to')+' '+SaveDialog1.FileName);
        cursor:=CrDefault;
      end;
  end;
end;

procedure TForm1.MI_DeleteRecordingClick(Sender: TObject);
begin
  If stringgridRecorded.Row>0 then
  begin
    DeleteFile(configdir+DirectorySeparator+'recorded'+DirectorySeparator+StringgridRecorded.Cells[0,StringgridRecorded.Row]+' - '+StringgridRecorded.Cells[1,StringgridRecorded.Row]+'.mp3');
    StringgridRecorded.DeleteRow(StringgridRecorded.Row);
  end;
end;

procedure TForm1.MI_FullscreenClick(Sender: TObject);
begin
  if Form1.Visible then SetFullscreen
                   else Form1.Visible:=True;
end;

procedure TForm1.SetFullscreen;
begin
 if isfullscreen then
 begin
   ShowWindow(Handle, SW_SHOWNORMAL);
   isfullscreen:=False;
 end
   else
 begin
   ShowWindow(Handle, SW_SHOWFULLSCREEN);
   isfullscreen:=True;
 end;
end;

procedure TForm1.MI_NextClick(Sender: TObject);
begin
  SB_NextClick(MI_Next);
end;

procedure TForm1.MI_PauzeClick(Sender: TObject);
begin
  SB_PauzeClick(MI_Pauze);
end;

procedure TForm1.MI_PlayClick(Sender: TObject);
begin
  SB_PlayClick(MI_Play);
end;

procedure TForm1.MI_PrevClick(Sender: TObject);
begin
  SB_PreviousClick(MI_Prev)
end;

procedure TForm1.DeleteSong(X: longint; RefLists: boolean);
var aRow: longint;
begin
  aRow := SongToRow(SG_ALL, x);
  if aRow>0 then SG_ALL.DeleteRow(aRow);
  DeleteFile(Liedjes[x].Pad+Liedjes[x].Bestandsnaam);
  Liedjes[x].Deleted:=True;
  if RefLists then RefreshLists(true, true);
end;

procedure TForm1.RemoveFromPlayingQueue(x: longint);
var aRow: Integer;
begin
  aRow := SongToRow(SG_Play, x);
  if aRow>0 then
  begin
    if aRow<songrowplaying then dec(songrowplaying);
    SG_Play.DeleteRow(aRow);
  end;
end;

procedure TForm1.MI_GoToAlbumClick(Sender: TObject);
var i: longint;
    gevonden: Boolean;
begin
  If (LB_Albums2.ItemIndex>0) and (LB_Albums2.Items[LB_Albums2.ItemIndex]<>Vertaal('Unknown')) then
     begin
       gevonden:=False; i:=1;
       repeat
         If LB_albums1.Items[i]=LB_albums2.Items[LB_albums2.ItemIndex] then gevonden:=true;
         inc(i);
       until gevonden or (i=LB_Albums1.Items.Count);
       if gevonden then
       begin
        Application.ProcessMessages;
         LB_albums1.ItemIndex:=i-1; Pagecontrol1.ActivePageIndex:=1;
         LB_albums1Click(Self);
       end;
     end;
end;

procedure TForm1.MI_PlayAlbumClick(Sender: TObject);
begin
  MI_GoToAlbumClick(Self);
  SG_AllDblClick(Self);
end;

procedure TForm1.Mi_ReShuffleClick(Sender: TObject);
var i, x: longint;
    begin_i: byte;
begin
 // If isplayingsong then LB_filename.Caption:=inttostr(songrowplaying)
 //                 else LB_filename.Caption:='not isplayingsong' ;
  if SG_play.RowCount>2 then
  begin
    SG_Play.Cursor:=CrHourGlass;
    Application.ProcessMessages;
    SG_Play.BeginUpdate;
    if (isplayingsong) then
    begin
       SG_play.ExchangeColRow(false,songrowplaying,1);
       songrowplaying:=1; begin_i:=2;
    end
    else
    begin
      SG_Play.Cells[0,songrowplaying]:=' ';
      begin_i:=1;
    end;
   for i:=begin_i to SG_Play.RowCount-2 do
    begin
      x:=random(SG_Play.RowCount-2)+begin_i;
      SG_play.ExchangeColRow(false,i,x);
    end;
    SG_Play.EndUpdate(true);
    SG_play.Row:=1;
    SG_play.Cursor:=CrDefault;
  end;
end;

procedure TForm1.MI_StopClick(Sender: TObject);
begin
  SB_StopClick(MI_Stop);
end;

procedure TForm1.KiesVuImage(x: byte);
begin
  VU_Settings.Theme:=x; MI_VU_Active4.Checked:=False;
  if x=1 then
  begin
    ImageListVU.GetBitmap(0, VuImage.Picture.Bitmap);
    MI_Vu1.Checked:=True; MI_Vu2.Checked:=False; MI_VU2.Checked:=False;
  end;
  if x=2 then
  begin
    ImageListVU.GetBitmap(1, VuImage.Picture.Bitmap);
    MI_Vu2.Checked:=True;
  end;
  if x=3 then
  begin
    ImageListVU.GetBitmap(2, VuImage.Picture.Bitmap);
    MI_Vu3.Checked:=True;
  end;
  VuImage.Picture.Bitmap.Canvas.Pen.Color := clSilver;
  VuImage.Picture.Bitmap.Canvas.Pen.Width:=2;
  VuImage.Picture.Bitmap.Canvas.Line(94, 94, 13, 35);
end;

procedure TForm1.MI_Vu1Click(Sender: TObject);
begin
  KiesVuimage(1);
  if VU_Settings.Active<>2 then
  begin
    VU_Settings.Active:=1;
    Panel_VUClick(Self);
  end;
end;

procedure TForm1.MI_Vu2Click(Sender: TObject);
begin
  KiesVuImage(2);
  if VU_Settings.Active<>2 then
  begin
    VU_Settings.Active:=1;
    Panel_VUClick(Self);
  end;
end;

procedure TForm1.Panel_VUClick(Sender: TObject);
begin
  PanelVUClick(self);
end;

procedure TForm1.PanelVUClick(Sender: TObject);
begin
  inc(VU_Settings.Active); if VU_Settings.Active>3 then VU_Settings.Active:=1;
  if VU_Settings.Active=1 then
  begin
    Panel_VU.Width:=162;
    Panel_VU.Height:=42;
    {$IFDEF Windows}
    VuLeft1.Visible:=True; VuRight1.Visible:=True;
    VuLeft2.Visible:=True; VuRight2.Visible:=True;
    VuLeft3.Visible:=True; VuRight3.Visible:=True;
    VuLeft4.Visible:=True; VuRight4.Visible:=True;
    VuLeft5.Visible:=True; VuRight5.Visible:=True;
    VuLeft6.Visible:=True; VuRight6.Visible:=True;
    VuLeft7.Visible:=True; VuRight7.Visible:=True;
    VuLeft8.Visible:=True; VuRight8.Visible:=True;
    VuLeft9.Visible:=True; VuRight9.Visible:=True;
    VuLeft10.Visible:=True; VuRight10.Visible:=True;
    VuLeft11.Visible:=True; VuRight11.Visible:=True;
    VuLeft12.Visible:=True; VuRight12.Visible:=True;
    {$ENDIF}
    VuImage.Visible:=False;
  end;
  if VU_Settings.Active=2 then
  begin
    VuImage.Visible:=True;
    Panel_VU.Width:=184;
    Panel_VU.Height:=81;
    {$IFDEF Windows}
    VuLeft1.Visible:=False; VuRight1.Visible:=False;
    VuLeft2.Visible:=False; VuRight2.Visible:=False;
    VuLeft3.Visible:=False; VuRight3.Visible:=False;
    VuLeft4.Visible:=False; VuRight4.Visible:=False;
    VuLeft5.Visible:=False; VuRight5.Visible:=False;
    VuLeft6.Visible:=False; VuRight6.Visible:=False;
    VuLeft7.Visible:=False; VuRight7.Visible:=False;
    VuLeft8.Visible:=False; VuRight8.Visible:=False;
    VuLeft9.Visible:=False; VuRight9.Visible:=False;
    VuLeft10.Visible:=False; VuRight10.Visible:=False;
    VuLeft11.Visible:=False; VuRight11.Visible:=False;
    VuLeft12.Visible:=False; VuRight12.Visible:=False;
    {$ENDIF}
    KiesVuimage(VU_Settings.Theme);
  end;
  if VU_Settings.Active=3 then
  begin
    VuImage.Visible:=True;
    Panel_VU.Width:=184;
    Panel_VU.Height:=81;
    Form1.VuImage.Canvas.Pen.Width:=2; Form1.VuImage.Canvas.Pen.Color:=clHighlight;
    Form1.VuImage.Canvas.Brush.Style:=bssolid; Form1.VuImage.Canvas.Brush.Color:=clBlack;
    Form1.VuImage.Canvas.Rectangle(0,0,Form1.Panel_VU.Width,Form1.Panel_VU.Height);
  end;
end;

function TForm1.GetCDCover(song: longint; artiest, CD: string): string;
var lijn, folder, bestand, titel, cdcoveronline, lijn2: string;
    i: byte;
    Filevar: TextFile;
    fs: TFilestream;
    aList: TStringList;
    {$IFDEF LINUX}  OurProcess: TProcess;  {$ENDIF}
begin

 if song>-1 then
 begin
   Artiest:=Liedjes[song].Artiest;
   CD:=Lowercase(Liedjes[song].CD);
   folder:=Liedjes[song].Pad;
   bestand:=Liedjes[song].Bestandsnaam;
   Delete(bestand,Length(bestand)-length(ExtractFileExt(bestand))+1,5);
   titel:=Liedjes[song].Titel;
 end
 else
 begin
   bestand:=LiedjesTemp.Bestandsnaam;
   folder:=ExtractFileDir(LiedjesTemp.Bestandsnaam);
   artiest:=LB_Artiest.Caption;
   CD:=LB_CD.Caption;
 end;

  if (artiest<>'') then
  begin
    lijn:=convertArtist(artiest,true)+'-'+convertalbum(cd);
    cdcoveronline:=lijn; lijn2:=lijn;

  if (cd<>'') then
  begin
    if FileExistsUTF8(Settings.CacheDirCDCover+Directoryseparator+lijn+'.jpg') then
    begin
      GetCDCover:=Settings.CacheDirCDCover+Directoryseparator+lijn+'.jpg';
      exit;
    end;
    if FileExistsUTF8(Settings.CacheDirCDCover+Directoryseparator+lijn+'.png') then
    begin
      GetCDCover:=Settings.CacheDirCDCover+Directoryseparator+lijn+'.png';
      exit;
    end;

    begin
      {$IFDEF HAIKU} aList:=FindAllFiles(folder, '*.jpg', False);  {$ENDIF}
      {$IFDEF DARWIN} aList:=FindAllFiles(folder, '*.jpg', False);  {$ENDIF}
      {$IFDEF WINDOWS} aList:=FindAllFiles(folder, '*.jpg', False);  {$ENDIF}

      {$IFDEF LINUX}
      if Formconfig.CB_NasBug.Checked then  //NAS BUG  :(
      begin
        OurProcess := TProcess.Create(nil);
        OurProcess.CommandLine := 'find "'+folder+'" -fprint '+TempDir+DirectorySeparator+'songlist.xix';
        OurProcess.Options := [poWaitOnExit];
        OurProcess.Execute;
        OurProcess.Free;
        aList := TStringlist.Create;
        aList.LoadFromFile(TempDir+DirectorySeparator+'songlist.xix');
        if aList.Count>0 then
        for i:=aList.Count-1 downto 0 do
        begin
          if (pos('.JPG',uppercase(aList.Strings[i]))<1) then aList.Delete(i);
        end;
      end
      else aList:=FindAllFiles(folder, '*.jpg', False);
      {$ENDIF}

      GetCDCover:='x';

      If aList.Count>0 then
      for i:=0 to aList.Count-1 do
      begin
        case upcase(extractFilename(aList.Strings[i])) of
          'COVER.JPG', 'FRONT.JPG', 'FOLDER.JPG', 'ALBUMART.JPG':
          begin
            GetCDCover:=aList.Strings[i];
            If FormConfig.CB_CacheCDImages.Checked then CopyFile(aList.Strings[i],Settings.CacheDirCDCover+Directoryseparator+lijn+'.jpg');
            exit;
          end;
        end; //case
      end;
      // Application.ProcessMessages;
      // Kijken of er zijn met cover of front in naam
      if aList.Count>0 then
      begin
        for i:=0 to aList.Count-1 do
        begin
          if pos('COVER',Upcase(aList.Strings[i]))>0 then
          begin
            GetCDCover:=aList.Strings[i];
            If FormConfig.CB_CacheCDImages.Checked then CopyFile(aList.Strings[i],Settings.CacheDirCDCover+Directoryseparator+lijn+'.jpg');
            aList.Free;
            exit;
          end;
          if pos('FRONT',Upcase(aList.Strings[i]))>0 then
          begin
            GetCDCover:=aList.Strings[i];
            If FormConfig.CB_CacheCDImages.Checked then CopyFile(aList.Strings[i],Settings.CacheDirCDCover+Directoryseparator+lijn+'.jpg');
            aList.Free;
            exit;
          end;
          if pos('VOOR',Upcase(aList.Strings[i]))>0 then
          begin
            GetCDCover:=aList.Strings[i];
            If FormConfig.CB_CacheCDImages.Checked then CopyFile(aList.Strings[i],Settings.CacheDirCDCover+Directoryseparator+lijn+'.jpg');
            aList.Free;
            exit;
          end;
        end;
      end;
      aList.Free;
   end;
 end;

// FormAbout.Memo1.Lines.Add('GETCDCOVER without ALBUM');
  // Nog altijd niets gevonden.  Kijken voor idem naam.mp3 -- naam.jpg
  begin
    if FileExistsUTF8(folder+bestand+'.jpg') then
      begin
      // FormAbout.Memo1.Lines.Add('GETCDCOVER op NAAM bestand');
        GetCDCover:=folder+bestand+'.jpg';
        exit
      end;
   end;
   if FileExistsUTF8(folder+'folder.jpg') then
      begin
      // FormAbout.Memo1.Lines.Add('GETCDCOVER op NAAM bestand');
        GetCDCover:=folder+'folder.jpg';
        exit
      end;

  lijn:=convertartist(artiest, true);
  If FileExistsUTF8(Settings.CacheDirCDCover+Directoryseparator+lijn+'.jpg') then
     begin
       GetCDCover:=Settings.CacheDirCDCover+Directoryseparator+lijn+'.jpg';
       exit;
     end;
  If FileExistsUTF8(Settings.CacheDirCDCover+Directoryseparator+lijn+'.png') then   //LastFM werkt met PNG
     begin
       GetCDCover:=Settings.CacheDirCDCover+Directoryseparator+lijn+'.png';
       exit;
     end;

  // Nog altijd niet gevonden.  Kijken of artiest.jpg bestaat
  begin
    lijn:=lowercase(artiest);
    lijn2:=convertartist(artiest, true);
    if FileExistsUTF8(folder+lijn+'.jpg') then
    begin
      GetCDCover:=folder+lijn+'.jpg';
      If FormConfig.CB_CacheCDImages.Checked then CopyFile(folder+lijn+'.jpg',Settings.CacheDirCDCover+Directoryseparator+lijn2+'.jpg');
      exit;
    end;

    if FileExistsUTF8(Settings.CacheDirCDCover+Directoryseparator+lijn2+'.jpg') then
    begin
      GetCDCover:=Settings.CacheDirCDCover+Directoryseparator+lijn2+'.jpg';
    //  If FormConfig.CB_CacheCDImages.Checked then CopyFile(folder+lijn+'.jpg',Configdir+Directoryseparator+'cache'+Directoryseparator+lijn2+'.jpg');
      exit;
    end;
  end;

  //Laatste effort :)
  aList:=FindAllFiles(folder, '*.jpg', True);

  {$IFDEF LINUX}
  if Formconfig.CB_NasBug.Checked then  //NAS BUG  :(
  begin
    OurProcess := TProcess.Create(nil);
    OurProcess.CommandLine := 'find "'+folder+'" -maxdepth 1 -fprint '+TempDir+DirectorySeparator+'songlist.xix';
    OurProcess.Options := [poWaitOnExit];
    OurProcess.Execute;
    OurProcess.Free;
    aList.Clear;
    aList.LoadFromFile(TempDir+DirectorySeparator+'songlist.xix');
    if aList.Count>0 then
    for i:=aList.Count-1 downto 0 do
    begin
      if (pos('.JPG',uppercase(aList.Strings[i]))<1) then aList.Delete(i);
    end;
   end;
   {$ENDIF}

    if aList.Count>0 then
      begin
        lijn:=titel;
        if pos('(',titel)>0 then  lijn:=copy(titel,1,pos('(',titel)-1);
        if pos('[',titel)>0 then lijn:=copy(titel,1,pos('[',titel)-1);
        for i:=0 to aList.Count-1 do
        begin
          if pos(upcase(lijn),Upcase(aList.Strings[i]))>0 then
          begin
            GetCDCover:=aList.Strings[i];
            aList.Free;
            exit;
          end;
        end;
      end;
    aList.Free;


  //DOWNLOADCDCOVER
  begin
    if (cd<>'') then
    begin
    //  cdcoveronline:=StringReplace(cdcoveronline,' ','%20',[rfReplaceAll, rfIgnoreCase]);
       urlvar:='http://www.xixmusicplayer.org/cdcover/checkfile.php?bestand='+cdcoveronline+'.jpg';
       {$IFDEF HAIKU}
       DownloadFile(urlvar,tempdir+Directoryseparator+'cdcover.txt');
       {$ELSE}
       fs := TFileStream.Create(tempdir+Directoryseparator+'cdcover.txt', fmOpenWrite or fmCreate);
       try
         HttpGetBinary(urlvar, fs);
       finally
          fs.Free;
       end;
       {$ENDIF}
       if FileExistsUTF8(tempdir+Directoryseparator+'cdcover.txt') then
       begin
          AssignFile(Filevar,tempdir+Directoryseparator+'cdcover.txt');
          Reset(Filevar);
          Readln(Filevar,lijn);
          CloseFile(Filevar);
          if lijn='OK' then
          begin
           urlvar:='http://www.xixmusicplayer.org/cdcover/'+cdcoveronline+'.jpg';

           {$IFDEF HAIKU}
           DownloadFile(urlvar,tempdir+Directoryseparator+'cover.jpg');
           {$ELSE}
           fs := TFileStream.Create(tempdir+Directoryseparator+'cover.jpg', fmOpenWrite or fmCreate);
           try
             HttpGetBinary(urlvar, fs);
           finally
             fs.Free;
           end;
           {$ENDIF}
           CopyFile(tempdir+Directoryseparator+'cover.jpg',Settings.CacheDirCDCover+Directoryseparator+lijn2+'.jpg');
           GetCDCover:=Settings.CacheDirCDCover+Directoryseparator+lijn2+'.jpg';
           exit;
          end;
       end;
     end;

    //ARTIEST from XiXMusicPlayer.org

      lijn:=convertartist(artiest, true);
       urlvar:='http://www.xixmusicplayer.org/cdcover/checkfile.php?bestand='+lijn+'.jpg';
      fs := TFileStream.Create(tempdir+Directoryseparator+'cdcover.txt', fmOpenWrite or fmCreate);
       try
          HttpGetBinary(urlvar, fs);
       finally
          fs.Free;
       end;
       if FileExistsUTF8(tempdir+Directoryseparator+'cdcover.txt') then
       begin
          AssignFile(Filevar,tempdir+Directoryseparator+'cdcover.txt');
          Reset(Filevar);
          Readln(Filevar,lijn2);
          CloseFile(Filevar);
          if lijn2='OK' then
          begin
           urlvar:='http://www.xixmusicplayer.org/cdcover/'+lijn+'.jpg';
           fs := TFileStream.Create(tempdir+Directoryseparator+'cover.jpg', fmOpenWrite or fmCreate);
           try
             HttpGetBinary(urlvar, fs);
           finally
             fs.Free;
           end;
           CopyFile(tempdir+Directoryseparator+'cover.jpg',Settings.CacheDirCDCover+Directoryseparator+lijn+'.jpg');
           GetCDCover:=Settings.CacheDirCDCover+Directoryseparator+lijn+'.jpg';
           exit;
          end;
       end;
    end;
  end;
  GetCDCover:='x';
end;

procedure TForm1.PlayFromFile(song: string);
var artist, title, album: string;
begin
 {There is a schedule busy}
  If Not EndSchedule(Self) then exit;
  {IF RECORDING IS BUSY}
  if Streamsave then if FormShowMyDialog.ShowWith(Vertaal('RECORDING'),Vertaal('A recording is active')+': '+LB_CD.Caption,' ',Vertaal('Are you sure you want to stop?'),vertaal('YES'),vertaal('NO'), False)=false
      then exit
      else SB_RadioRecordClick(Self);

 if not PlayingFromRecorded then
 begin
  FilePlaying:=ShellListView1.ItemIndex;
  LiedjesTemp.Bestandsnaam:=song;
  GetId3Extra(-1);
  artist:=LiedjesTemp.Artiest; if artist='' then artist:='Unknown artist';
  title:=LiedjesTemp.Titel; if title='' then title:='Unknown title';
  album:=LiedjesTemp.CD;
 end
                            else
 begin
   title:='Recorded on '+StringgridRecorded.Cells[0,StringgridRecorded.Row];
   artist:=StringgridRecorded.Cells[1,StringgridRecorded.Row];
   album:='';
 end;

  SB_StopClick(Self);
  LB_Titel.Caption:=title; LB_Artiest.Caption:=artist; LB_CD.Caption:=album;

  if album<>'' then LB_On.Visible:=true
               else LB_on.Visible:=false;

  {$if not defined(HAIKU)}
  Song_Stream1 := BASS_StreamCreateFile(False,PChar(song),0,0,BASS_STREAM_AUTOFREE);
  stream:=6;
  FormEQ.CheckAllFX;
  myBool         := BASS_ChannelPlay(Song_Stream1, False);
  total_bytes    := BASS_ChannelGetLength(Song_Stream1, BASS_POS_BYTE);
  total_time     := BASS_ChannelBytes2Seconds(Song_Stream1, total_bytes);
  {$ifend}
  total_time_str := SecToTime(round(total_time));
  LabelTime.Caption:=total_time_str;
  TrackBar2.Max:=total_bytes; TrackBar2.Step:=round(total_bytes/100);
  FormCoverPlayer.ProgressBar1.MaxValue:=total_bytes;
  Timer1.Enabled:=True;

  if not PlayingFromRecorded then
  begin
    ArtiestInfo:=ConvertArtist(LB_artiest.Caption, false);
    if stream<>4 then MI_ReloadSongtextClick(Self);
    welkecover:=-1;
    if Threadrunning then ThreadCDCover.Terminate;
    if ThreadArtiestInfoRunning then ThreadGetArtiestInfo.Terminate;
    ThreadCDCover:=TGetCDCoverThread.Create(False);
    ThreadGetArtiestInfo:=TSearchForArtistInfoThread.Create(False);
  end;

  isplayingsong:=true;
  TrackBar2.Style:=pbstNormal;
end;

procedure TForm1.ShowTabs(ActivePage: Byte; All, Queue, Files, Radio, Podcast, CD, CDCovers: Boolean);
begin
  TabSheetBrowser.TabVisible:=All;
  TabSheetPlayQue.TabVisible:=Queue;
  TabSheetFiles2.TabVisible:=Files;
  TabSheetRadio2.TabVisible:=Radio;
  TabSheetPodcast2.TabVisible:=Podcast;
  TabSheetCD2.TabVisible:=CD;
  TabsheetCovers.TabVisible:=CDCovers;
  PageControl2.ActivePageIndex:=ActivePage;
end;

procedure TForm1.UpdateMediaMode;
begin
  FormCoverPlayer.BCLabel2.Caption:=LB_Titel.Caption;
  FormCoverPlayer.BCLabel1.Caption:=LB_Artiest.Caption;
  if stream<6 then
  begin
   if length(Liedjes[songplaying].Copyright)>0 then FormCoverPlayer.Label11.Visible:=True
                                               else FormCoverPlayer.Label11.Visible:=False;
   FormCoverPlayer.Label12.Caption:=Liedjes[songplaying].Copyright;
   if SG_Play.Row>1 then
    begin
      FormCoverPlayer.Label3.Caption:=SG_Play.Cells[1,SG_Play.Row-1];
      FormCoverPlayer.Label4.Caption:=SG_Play.Cells[3,SG_Play.Row-1];
    end
    else
    begin
      FormCoverPlayer.Label3.Caption:=''; FormCoverPlayer.Label4.Caption:='';
    end;
   if SG_Play.Row<SG_Play.RowCount-1 then
    begin
      FormCoverPlayer.Label5.Caption:=SG_Play.Cells[1,SG_Play.Row+1];
      FormCoverPlayer.Label6.Caption:=SG_Play.Cells[3,SG_Play.Row+1];
    end
    else
    begin
      FormCoverPlayer.Label5.Caption:=''; FormCoverPlayer.Label6.Caption:='';
    end;
  end
  else
  begin
    FormCoverPlayer.Label3.Caption:='';FormCoverPlayer.Label4.Caption:='';
    FormCoverPlayer.Label5.Caption:='';FormCoverPlayer.Label6.Caption:='';
    FormCoverPlayer.Label11.Visible:=False; FormCoverPlayer.Label12.caption:='';
    if stream=6 then
    begin
      if not PlayingFromRecorded then
      begin
       ImageCDCover.Picture.Bitmap:=FormDetails.Image2.Picture.Bitmap;
       FormCoverplayer.ImageCDCover.Picture.Bitmap:=FormDetails.Image2.Picture.Bitmap;
      end
      else
      begin
        ImageCDCover.Picture.Bitmap:=Image15.Picture.Bitmap;
        FormCoverPlayer.ImageCDCover.Picture.Bitmap:=Image15.Picture.Bitmap;
      end;
    end;
    if Stream=10 then
    begin
     FormCoverPlayer.BCLabel1.Caption:=LB_Radionaam.Caption;
     FormCoverPlayer.BCLabel2.Caption:=Label18.Caption;
    end;
    if stream=11 then
    begin
      FormCoverPlayer.BCLabel2.Caption:=Label22.Caption+' '+Label23.Caption+' ('+StringGrid1.Cells[1,Stringgrid1.Row]+')';
    end;
  end;
  FormCoverPlayer.BCLabelTime.Caption:=LabelElapsedTime.Caption;
  FormCoverPlayer.BCLabelTotalTime.Caption:=LabelTime.Caption;
  FormCoverPlayer.ImagePauze.Visible:=false;
  FormCoverPlayer.Label9.Caption:=LB_CD.Caption;

  if length(LB_CD.Caption)>0 then FormCoverplayer.Label2.Visible:=True
                             else FormCoverplayer.Label2.Visible:=False;

  if CoverModePlayer=2 then
  begin
    FormCoverPlayer.Label2.Visible:=false; FormCoverPlayer.Label9.Visible:=false;
    FormCoverPlayer.Label11.Visible:=false; FormCoverPlayer.Label12.Visible:=false;
  end;

 // Volumebar.Position:=round(BASS_GetVolume*100);
end;

procedure TForm1.Play(song: longint);
var Song_bestand, msg, tempfilename, ext: string;
    positie: longint;
    memp: Pointer;
    fs: TFileStreamutf8;
begin

  MenuItem88.Enabled:=true; MI_CDCover_ChooseNewFile.Enabled:=True; MI_CDCover_RemoveCDCover.Enabled:=True; FormCoverPlayer.Label2.Caption:=Vertaal('From the album')+':';
  MI_GetArtworkFromFile.Enabled:=True; SB_RadioRecord.Enabled:=false;
  welkecover:=song;
  ClearPlayIndicator; FormCoverPlayer.LabelLyrics.Caption:='';
  song_bestand:=Liedjes[song].Pad+Liedjes[song].Bestandsnaam;
  tempfilename:=song_bestand;
  ext:=ExtractFileext(song_bestand);
  delete(tempfilename,length(tempfilename)-length(ext)+1,length(ext)); tempfilename:=tempfilename+'.cue';

  songplaying:=song; Vulsterren(Liedjes[song].Beoordeling);
  songrowplaying:=SG_Play.Row;
  SG_Play.Cells[0,songrowplaying]:='»';
  if FormLog.CB_Log.Checked then
  begin
    FormLog.MemoDebugLog.Lines.Add('songplaying:='+inttostr(songplaying));
    FormLog.MemoDebugLog.Lines.Add('songrowplaying:='+inttostr(songrowplaying));
    if FileExistsUTF8(tempfilename) then FormLog.MemoDebugLog.Lines.Add('.CUE file found')
                                else FormLog.MemoDebugLog.Lines.Add('no .CUE file found');
    if not Liedjes[song].TrimBegin then FormLog.MemoDebugLog.Lines.Add('NO Trimming at begin of song')
                                   else FormLog.MemoDebugLog.Lines.Add('Song should start @ '+inttostr(Liedjes[song].TrimLength[0]));
    if not Liedjes[song].TrimEnd then FormLog.MemoDebugLog.Lines.Add('NO Trimming at end of song')
                                   else FormLog.MemoDebugLog.Lines.Add('Song should end @ '+inttostr(Liedjes[song].TrimLength[1]));
  end;

  {There is a schedule busy}
  If Not EndSchedule(Self) then exit;
  {IF RECORDING IS BUSY}
  if Streamsave then if FormShowMyDialog.ShowWith(Vertaal('RECORDING'),Vertaal('A recording is active')+': '+LB_CD.Caption,' ',Vertaal('Are you sure you want to stop?'),vertaal('YES'),vertaal('NO'), False)=false
      then exit
      else SB_RadioRecordClick(Self);
  {$if not defined(HAIKU)}
  if stream=4 then positie:=BASS_ChannelGetPosition(reverseStream, BASS_POS_BYTE);

  if pause then
             begin
                if stream=1 then BASS_ChannelStop(Song_Stream1)
                            else BASS_ChannelStop(Song_Stream2);
               Bass_Start;
               pause:=false;
             end;
  if stream=1 then
  begin
    BASS_ChannelStop(Song_Stream2);
    {$IFDEF WINDOWS}
  //  Song_Stream2 := BASS_StreamCreateFile(False,PChar(utf8toutf16(song_bestand)),0,0,BASS_STREAM_AUTOFREE or BASS_UNICODE);
      fs := TFileStreamutf8.Create(song_bestand, fmOpenRead);
      GetMem(memp, fs.size);
      fs.Read(memp^, fs.Size);
      Song_Stream2 := BASS_StreamCreateFile(True, memp, 0, fs.Size, BASS_STREAM_DECODE or BASS_UNICODE);
      Song_Stream2 := BASS_FX_TempoCreate(Song_Stream2,BASS_FX_FREESOURCE or BASS_STREAM_AUTOFREE);
      fs.Free;
    {$ELSE}
    Song_Stream2 := BASS_StreamCreateFile(False,PChar(song_bestand),0,0, BASS_STREAM_DECODE);
    Song_Stream2 := BASS_FX_TempoCreate(Song_Stream2,BASS_FX_FREESOURCE or BASS_STREAM_AUTOFREE);
    {$ENDIF}
    BASS_ChannelSetAttribute(Song_Stream2, BASS_ATTRIB_TEMPO, ProgressBarSpeed.Value);
    stream:=2;
    FormEQ.CheckAllFX;
    myBool         := BASS_ChannelPlay(Song_Stream2, False);
    total_bytes    := BASS_ChannelGetLength(Song_Stream2, BASS_POS_BYTE);
    total_time     := BASS_ChannelBytes2Seconds(Song_Stream2, total_bytes);
    total_time_str := SecToTime(round(total_time));
    inc(Liedjes[song].aantalafspelen);
    if (Liedjes[song].TrimBegin) and (Liedjes[song].TrimLength[0]>0) then
    begin
      positie:=BASS_ChannelSeconds2bytes(Song_Stream2, Liedjes[song].TrimLength[0]);
      BASS_ChannelSetPosition(Song_Stream2, positie, BASS_POS_BYTE);
    end;
  end
             else
  begin
    BASS_ChannelStop(Song_Stream1);
    {$IFDEF WINDOWS}
    //Song_Stream1 := BASS_StreamCreateFile(False,PChar(utf8toutf16(song_bestand)),0,0,BASS_STREAM_AUTOFREE or BASS_UNICODE);
      BASS_ChannelStop(ReverseStream); BASS_StreamFree(ReverseStream);
      fs := TFileStreamUTF8.Create(song_bestand, fmOpenRead);
      GetMem(memp, fs.size);
      fs.Read(memp^, fs.Size);
      Song_Stream1 := BASS_StreamCreateFile(True, memp, 0, fs.Size, BASS_STREAM_DECODE or BASS_UNICODE);
      Song_Stream1 := BASS_FX_TempoCreate(Song_Stream1,BASS_FX_FREESOURCE or BASS_STREAM_AUTOFREE);
      fs.Free;
    {$ELSE}
      Song_Stream1 := BASS_StreamCreateFile(False,PChar(song_bestand),0,0, BASS_STREAM_DECODE);
      Song_Stream1 := BASS_FX_TempoCreate(Song_Stream1,BASS_FX_FREESOURCE or BASS_STREAM_AUTOFREE);
    {$ENDIF}
    BASS_ChannelSetAttribute(Song_Stream1, BASS_ATTRIB_TEMPO, ProgressBarSpeed.Value);
    if stream=4 then BASS_ChannelSetPosition(Song_Stream1, positie, BASS_POS_BYTE)
                else inc(Liedjes[song].aantalafspelen);
    stream:=1;
    FormEQ.CheckAllFX;
    myBool         := BASS_ChannelPlay(Song_Stream1, False);
    total_bytes    := BASS_ChannelGetLength(Song_Stream1, BASS_POS_BYTE);
    total_time     := BASS_ChannelBytes2Seconds(Song_Stream1, total_bytes);
    total_time_str := SecToTime(round(total_time));
    if (Liedjes[song].TrimBegin) and (Liedjes[song].TrimLength[0]>0) then
    begin
      positie:=BASS_ChannelSeconds2bytes(Song_Stream1, Liedjes[song].TrimLength[0]);
      BASS_ChannelSetPosition(Song_Stream1, positie, BASS_POS_BYTE);
    end;
  end;
  {$ifend}

  if stream<3 then
    begin
      Label34.Visible:=True; Label35.Visible:=True;Label36.Visible:=True;
    end
    else
    begin
      Label34.Visible:=False; Label35.Visible:=False;Label36.Visible:=False;
      Label35.Caption:='100'; ProgressBarSpeed.Value:=0;
    end;

  LB_titel.Caption:=Liedjes[song].Titel; LB_Artiest.Caption:=Liedjes[song].Artiest;
  if length(Liedjes[song].CD)>0 then LB_CD.Caption:=Liedjes[song].CD
                                else LB_CD.Caption:='';
  LabelTime.Caption:=total_time_str;
  TrackBar2.Step:=total_bytes div 100;
  TrackBar2.Max:=total_bytes;
  FormCoverPlayer.ProgressBar1.MaxValue:=total_bytes;

  //ShowMessage('Voor IsMediModeOn');
  (* Label for COVERPLAYER *)
  If IsMediaModeOn then
  begin
    UpdateMediaMode;
  end;
  (* End for COVERPLAYER *)

  if Settings.Notification then
  begin
    msg:=Liedjes[song].Artiest+' - '+Liedjes[song].Titel+'  '+LabelTime.Caption;
    if Liedjes[song].CD<>'' then msg:=msg+#13+Vertaal('on')+' "'+Liedjes[song].CD+'"';
    TrayIcon1.BalloonHint:=msg;
    if Settings.OnlyWhenMinized then
    begin
      If (not Form1.Visible) or (Form1.WindowState=wsMinimized) then TrayIcon1.ShowBalloonHint;
    end
    else TrayIcon1.ShowBalloonHint;
  end;

  ArtiestInfo:=ConvertArtist(LB_artiest.Caption, false);
  MI_GetArtworkFromFile.Enabled:=False;
  if Threadrunning then ThreadCDCover.Terminate;
  if ThreadArtiestInfoRunning then ThreadGetArtiestInfo.Terminate;
  ThreadCDCover:=TGetCDCoverThread.Create(False);
  ThreadGetArtiestInfo:=TSearchForArtistInfoThread.Create(False);

  isplayingsong:=true;
  Timer1.Enabled:=True;

  begin
    if stream<>4 then if (upcase(LB_Artiest.Caption)<>'UNKNOWN') then MI_ReloadSongtextClick(Self)
                                                                 else
                                                                 begin
                                                                   MemoLyrics.Lines.Clear;
                                                                   FormCoverPlayer.LabelLyrics.Caption:='';
                                                                 end;
  end;

  if (Liedjes[song].Composer<>'') then
  begin
   msg:='(composed by '+Liedjes[song].Composer;
   if (Liedjes[song].OrigArtiest<>'') then msg:=msg+' - Original performed by '+Liedjes[song].OrigArtiest;
   msg:=msg+')';
   Label_Extra.Caption:=msg;
  end
  else if (Liedjes[song].OrigArtiest<>'') then Label_Extra.Caption:='Original performed by '+Liedjes[song].OrigArtiest
                                          else Label_Extra.Caption:='';
  LB_Artiest.Left:=Trackbar2.Left+round(Trackbar2.Width/2)-round((LB_Artiest.Width+LB_CD.Width)/2)+15;
  LB_CD.Caption:=Liedjes[song].CD;
  if length(LB_CD.Caption)>0 then LB_On.Visible:=True
                             else LB_On.Visible:=False;

  UnixTimestamp:=inttostr(Trunc((Now - EncodeDate(1970, 1 ,1)) * 24 * 60 * 60));
  ArtiestString:=Form1.MakeWikiArtist(LB_Artiest.Caption,'+');
  if PanelLastFm.Visible then if SB_LastFM.Enabled then SB_LastFMClick(Self); //LastFMInfo
//  BrowseTo('http://ws.audioscrobbler.com/2.0/?method=track.scrobble&artist[1]='+lowercase(LB_Artiest.Caption)+'&track[1]='+lowercase(LB_Titel.Caption)+'&timestamp='+UnixTimeStamp+'&api_key=a2c1434814fb382c6020043cbb13b10d&api_sig='+Settings.LastFMToken+'&api_sk='+FormConfig.Label46.Caption);

  if Liedjes[songplaying].TrimEnd then
  begin
    Settings.TrimFade:=timetosec(LabelTime.Caption)-Liedjes[songplaying].TrimLength[1];
  end
  else Settings.TrimFade:=0;
  if Liedjes[songplaying].TrimEnd or Liedjes[songplaying].TrimBegin then LB_Trimmed.Visible:=True
                                                                    else LB_Trimmed.Visible:=False;

  TrackBar2.Style:=pbstNormal;
  if RemoteConnection then
  begin
    try
      sock.SendString(ansistring('PLAYING: ('+inttostr(song)+') '+Liedjes[song].Artiest+' - '+Liedjes[song].Titel)); Sleep(60);
      sock.SendString('STATUS: '+ansistring(booltostr(Settings.Shuffle)+','+inttostr(Settings.RepeatSong)+','+inttostr(songrowplaying)+','+inttostr(Stream)));
    except
    end;
  end;
end;

procedure TForm1.WriteConfig;
var Filevar: TextFile;
    i, max: integer;
begin
 // ShowMessage('Begin WriteConfig');
  AssignFile(Filevar,Configdir+DirectorySeparator+'XIXMusicPlayer.ini');
  Rewrite(Filevar);
  Writeln(Filevar,configversion);
  Writeln(Filevar,'');
  Writeln(Filevar,'[General]');
  Writeln(Filevar,Settings.Language);
  Writeln(Filevar,Booltostr(Settings.Fade));       // Fading aan of uit
  Writeln(Filevar,inttostr(Settings.FadeTime));    // Fadetime
  Writeln(Filevar,Booltostr(Settings.FadeManual)); // Fade tussen zelf wisselen van nummers
  Writeln(Filevar,Booltostr(Settings.Shuffle));    // Shuffle
  Writeln(Filevar,inttostr(Settings.RepeatSong));  // Repeat
  Writeln(Filevar,Booltostr(Settings.RunFromUSB)); // Run From USB
  Writeln(Filevar,Booltostr(Settings.NASBug));
  Writeln(Filevar,Booltostr(Settings.CacheCDImages));
  Writeln(Filevar,Booltostr(Settings.CacheSongtext));
  Writeln(Filevar,inttostr(TB_ThumbSize.Position));
  Writeln(Filevar,inttostr(Settings.TabArtist));
  Writeln(Filevar,inttostr(Settings.TabPlaylist));
  Writeln(Filevar,0);                             // Not used
  Writeln(Filevar,Booltostr(Settings.Notification));
  Writeln(Filevar,Booltostr(Settings.OnlyWhenMinized));
  Writeln(Filevar,Booltostr(Settings.Tray));
  Writeln(Filevar,inttostr(Settings.Encoder));
  Writeln(Filevar,Booltostr(Settings.UpcaseLetter));
  Writeln(Filevar,Booltostr(Settings.Check_The));
  Writeln(Filevar,Booltostr(Settings.SystemSettings));
  Writeln(Filevar,Settings.CacheDirCDCover);
  Writeln(Filevar,Settings.CacheDirSongtext);
  Writeln(Filevar,Settings.cacheDirRadio);
  Writeln(Filevar,inttostr(VU_Settings.Active));
  Writeln(Filevar,inttostr(VU_Settings.Theme));
  Writeln(Filevar,inttostr(VU_Settings.Placement));
  Writeln(Filevar,BooltoStr(VU_Settings.ShowPeaks));
  Writeln(Filevar,Booltostr(Settings.SaveOnExternal));
  Writeln(Filevar,BoolToStr(Settings.CDCoverInfo));
  Writeln(Filevar,BoolToStr(Settings.CDCoverLyrics));
  Writeln(Filevar,BoolToStr(Settings.FixCDCover));
  Writeln(Filevar,Inttostr(Settings.TimerInterval));
  Writeln(Filevar,Settings.DVDDrive);
  Writeln(Filevar,inttostr(Settings.cdb));
  Writeln(Filevar,inttostr(Settings.FontSize));
  Writeln(Filevar,inttostr(Settings.Font2Size));
  Writeln(Filevar,inttostr(Settings.ChosenLibrary));
  Writeln(Filevar,Booltostr(Settings.MinimizeOnClose));
  Writeln(Filevar,Booltostr(Settings.NetworkControl));
  Writeln(Filevar,Settings.ip_port);
  Writeln(Filevar, booltostr(Settings.SaveLyricsInID3Tag));
  Writeln(Filevar, booltostr(Settings.DeleteMacOSFiles));
  Writeln(Filevar, booltostr(Settings.SaveExternalOnInternal));
  Writeln(Filevar,inttostr(Settings.Soundcard));
  Writeln(FileVar, booltostr(Settings.ShowAllColums));
  Writeln(FileVar, booltostr(Settings.NoAdvance));

  Writeln(Filevar,'');
  Writeln(Filevar,'[Coords]');
  Writeln(Filevar,inttostr(Form1.left));
  Writeln(Filevar,inttostr(Form1.Top));
  Writeln(Filevar,inttostr(Form1.Height));
  Writeln(Filevar,inttostr(Form1.Width));
  Writeln(Filevar,inttostr(Form1.Splitter1.Left));
  Writeln(Filevar,inttostr(Form1.Splitter3.Left));
  Writeln(Filevar,inttostr(Form1.Splitter2.Top));
  Writeln(Filevar,inttostr(Form1.Splitter5.Top));
  Writeln(Filevar,'');
  Writeln(Filevar,'[Local]');
  max:=Settings.IncludeLocaleDirs.Count;
  for i:=0 to max do
  begin
    if i>0 then Writeln(Filevar,Booltostr(Settings.IncludeLocaleDirsChecked[i-1])+';'+Settings.IncludeLocaleDirs.Strings[i-1]);
  end;
  Writeln(Filevar,'');
  Writeln(Filevar,'[ExtLocal]');
  max:=Settings.ExcludeLocaleDirs.Count;
  for i:=0 to max do
  begin
    if i>0 then Writeln(Filevar,Booltostr(Settings.ExcludeLocaleDirsChecked[i-1])+';'+Settings.ExcludeLocaleDirs.Strings[i-1]);
  end;
  Writeln(Filevar,'');
  Writeln(Filevar,'[Offline]');
  max:=Settings.IncludeExternalDirs.Count;
  for i:=0 to max do
  begin
    if i>0 then Writeln(Filevar,Booltostr(Settings.IncludeExternalDirsChecked[i-1])+';'+Settings.IncludeExternalDirs.Strings[i-1]);
  end;
  Writeln(Filevar,'');
  Writeln(Filevar,'[ExtOffline]');
  max:=Settings.ExcludeExternalDirs.Count;
  for i:=0 to max do
  begin
    if i>0 then Writeln(Filevar,Booltostr(Settings.ExcludeExternalDirsChecked[i-1])+';'+Settings.ExcludeExternalDirs.Strings[i-1]);
  end;
  Writeln(Filevar,'');
  Writeln(Filevar,'[Schedule]');
  writeln(Filevar,booltostr(ScheduleSettings.CopyRec));
  writeln(Filevar,booltostr(ScheduleSettings.RenameRec));
  writeln(Filevar,booltostr(ScheduleSettings.Overwrite));
  writeln(Filevar,ScheduleSettings.CopyDir);
  writeln(Filevar,ScheduleSettings.RenameFormat);
  writeln(Filevar,booltostr(ScheduleSettings.DeleteAfterCopy));
  Writeln(Filevar,'');
  Writeln(Filevar,'[Lame]');
  writeln(Filevar,Settings.Lame);
  Writeln(Filevar,Settings.EncodingTargetFolder);
  Writeln(Filevar,Settings.EncodingFilenameFormatSingle);
  Writeln(Filevar,Settings.EncodingFilenameFormatCompilation);
  Writeln(Filevar,booltostr(LameOpties.pr));
  Writeln(Filevar,booltostr(LameOpties.abr));
  Writeln(Filevar,booltostr(LameOpties.vbr));
  Writeln(Filevar,booltostr(LameOpties.cbr));
  Writeln(Filevar,booltostr(LameOpties.Mono));
  Writeln(Filevar,Lameopties.BitrateMin);
  Writeln(Filevar,Lameopties.BitrateMax);
  Writeln(Filevar,Lameopties.BitRateQuality);
  Writeln(Filevar,Lameopties.Preset);
  Writeln(Filevar,Lameopties.EncQuality);
  Writeln(Filevar,'');
  Writeln(Filevar,'[Flac]');
  writeln(Filevar,Settings.Flac);
  Writeln(Filevar,'');
  Writeln(Filevar,'[OGG]');
  writeln(Filevar,Settings.OGG);
  writeln(Filevar,OGGopties.BitrateMax);
  writeln(Filevar,OGGOpties.BitrateMin);
  writeln(Filevar,OGGopties.EncQuality);
  writeln(Filevar,booltostr(OGGOpties.cbr));
  writeln(Filevar,booltostr(OGGOpties.mmode));
  writeln(Filevar,booltostr(OGGOpties.ForceQuality));
  writeln(Filevar,booltostr(OGGOpties.vbr));
  Writeln(Filevar,'');
  Writeln(Filevar,'[AAC]');
  writeln(Filevar,Settings.AAC);
  writeln(Filevar,AACopties.Bitrate);
  writeln(Filevar,booltostr(AACOpties.vbr));
  writeln(Filevar,booltostr(AACOpties.cbr));
  writeln(Filevar,inttostr(AACOpties.vbrmode));
  Writeln(Filevar,'');
  Writeln(Filevar,'[OPUS]');
  writeln(Filevar,Settings.Opus);
  writeln(Filevar,Opusopties.Bitrate);
  writeln(Filevar,Opusopties.EncQuality);
  writeln(Filevar,booltostr(OpusOpties.cbr));
  writeln(Filevar,booltostr(OpusOpties.vbr));
  writeln(Filevar,booltostr(OpusOpties.cvbr));
  writeln(Filevar,inttostr(OpusOpties.Framesize));
  writeln(Filevar,inttostr(OpusOpties.Framesizei));
  Writeln(Filevar,'');
  Writeln(Filevar,'[DVD]');
  writeln(Filevar,settings.Mplayer);
  Writeln(Filevar,'');
  Writeln(Filevar,'[Lyrics]');
  if FormConfig.CLB_Lyrics.Count>0 then For i:=0 to FormConfig.CLB_Lyrics.Count-1 do Writeln(Filevar,BoolToStr(FormConfig.CLB_Lyrics.Checked[i])+';'+FormConfig.CLB_Lyrics.Items[i]); //TODO: Write Checkstate
  Writeln(Filevar,'');
  Writeln(Filevar,'[EQ]');
  Writeln(filevar,booltostr(FormEQ.CB_EQ.Checked));
  Writeln(filevar,inttostr(EQ_Set));
  Writeln(Filevar,'');
  Writeln(Filevar,'[PREVOLUME]');
  Writeln(filevar,inttostr(FormEQ.TrackBar1.Position));
  Writeln(Filevar,'');
  Writeln(Filevar,'[EQCUSTOM]');
  Writeln(Filevar,'');
  Writeln(Filevar,'[LASTFM]');
  Writeln(Filevar,Settings.LastFMLogin);
  Writeln(Filevar,Settings.LastFMPass);
  Writeln(Filevar,Settings.LastFMToken);
  Writeln(Filevar,'');
  Writeln(Filevar,'[RADIO]');
  Writeln(Filevar,LB_Land1.Text);
  Writeln(Filevar,'');
  Writeln(Filevar,'[ID3TAGGER]');
  Writeln(Filevar,Settings.MaskToTag);
  Writeln(Filevar,Settings.MaskToFile);
  if FormFillTagFromFile.ListBox1.Items.Count>0 then for i:=0 to FormFillTagFromFile.ListBox1.Items.Count-1 do Writeln(Filevar,FormFillTagFromFile.ListBox1.Items[i]);
  Writeln(Filevar,'');
  Writeln(Filevar,'[THEME]');
  Writeln(Filevar,'Theme file');
  Writeln(Filevar,BoolToStr(Settings.UseBackDrop));
  writeln(Filevar,inttostr(Settings.Backdrop));
  Writeln(Filevar,'');
  CloseFile(Filevar);
 // ShowMessage('End WriteConfig');
end;


procedure TForm1.ReadFolders;
var libraryfile, lijn, checked_str, lijn_tmp: string;
    i: integer;
    filevar: textfile;
begin
  Settings.IncludeLocaleDirs.Clear; Settings.IncludeExternalDirs.Clear;
  Settings.ExcludeLocaleDirs.Clear; Settings.ExcludeExternalDirs.Clear;

  Settings.ChosenLibrary:=CB_Library.ItemIndex;

  if CB_Library.ItemIndex=0 then libraryfile:=ConfigDir+DirectorySeparator+'default.dir'
      else if CB_Library.ItemIndex=1 then libraryfile:=ConfigDir+DirectorySeparator+'work.dir'
        else libraryfile:=ConfigDir+DirectorySeparator+CB_Library.Items.Strings[CB_Library.ItemIndex]+'.dir';

  if FileExistsUTF8(libraryfile) then
  begin
    AssignFile(Filevar,libraryfile);
    Reset(Filevar);
    readln(Filevar,lijn);
    i:=0;
    repeat
      readln(Filevar,lijn);
      if length(lijn)>2 then
         begin
           checked_str:=copy(lijn,1,pos(';',lijn)-1);
           lijn_tmp:=copy(lijn,pos(';',lijn)+1,length(lijn));
           Settings.IncludeLocaleDirs.Add(lijn_tmp);
           Setlength(Settings.IncludeLocaleDirsChecked,Settings.IncludeLocaleDirs.Count);
           if checked_str='0' then Settings.IncludeLocaleDirsChecked[i]:=false
                              else Settings.IncludeLocaleDirsChecked[i]:=true;
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
           lijn_tmp:=copy(lijn,pos(';',lijn)+1,length(lijn));
           Settings.ExcludeLocaleDirs.Add(lijn_tmp);
           Setlength(Settings.ExcludeLocaleDirsChecked,Settings.ExcludeLocaleDirs.Count);
           if checked_str='0' then Settings.ExcludeLocaleDirsChecked[i]:=false
                              else Settings.ExcludeLocaleDirsChecked[i]:=true;
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
           lijn_tmp:=copy(lijn,pos(';',lijn)+1,length(lijn));
           Settings.IncludeExternalDirs.Add(lijn_tmp);
           Setlength(Settings.IncludeExternalDirsChecked,Settings.IncludeExternalDirs.Count);
           if checked_str='0' then Settings.IncludeExternalDirsChecked[i]:=false
                              else Settings.IncludeExternalDirsChecked[i]:=true;
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
           lijn_tmp:=copy(lijn,pos(';',lijn)+1,length(lijn));
           Settings.ExcludeExternalDirs.Add(lijn_tmp);
           Setlength(Settings.ExcludeExternalDirsChecked,Settings.ExcludeExternalDirs.Count);
           if checked_str='0' then Settings.ExcludeExternalDirsChecked[i]:=false
                              else Settings.ExcludeExternalDirsChecked[i]:=true;
           inc(i);
         end;
    until (lijn='') or eof(Filevar);
    CloseFile(Filevar);
  end;

end;

procedure TForm1.ReadConfig;
var Filevar: TextFile;
    i: integer;
    lijn,lijn_tmp, checked_str: string;
begin
  AssignFile(Filevar,Configdir+DirectorySeparator+'XIXMusicPlayer.ini');
  Reset(FileVar);
  Readln(Filevar,Lijn);
  if lijn<>configversion then
  begin
    readln(Filevar,lijn);
    readln(Filevar,lijn);
    readln(Filevar,Settings.Language);
    CloseFile(Filevar);
    ShowMessage(Form1.Vertaal('Config needs to be updated.'));
    Settings.Lame:='wizard';
    exit;
  end;
  readln(Filevar,lijn);
  readln(Filevar,lijn);
  readln(Filevar,Settings.Language);
  readln(Filevar,lijn); if lijn='0' then Settings.Fade:=false
                                    else Settings.Fade:=true;
  readln(Filevar,lijn); Settings.FadeTime:=strtoint(lijn);
  readln(Filevar,lijn); if lijn='0' then Settings.FadeManual:=false
                                    else Settings.FadeManual:=true;
  readln(Filevar,lijn); if lijn='0' then Settings.Shuffle:=false
                                    else Settings.Shuffle:=true;
  readln(Filevar,lijn); Settings.RepeatSong:=strtointdef(lijn,0);
  readln(Filevar,lijn); if lijn='0' then Settings.RunFromUSB:=false
                                    else Settings.RunFromUSB:=true;
  readln(Filevar,lijn); if lijn='0' then Settings.NASBug:=false
                                    else Settings.NASBug:=true;
  readln(Filevar,lijn); if lijn='0' then Settings.CacheCDImages:=false
                                    else Settings.CacheCDImages:=true;
  readln(Filevar,lijn); if lijn='0' then Settings.CacheSongtext:=false
                                    else Settings.CacheSongtext:=true;
  readln(Filevar,lijn); TB_ThumbSize.Position:=strtointdef(lijn,120);
  readln(Filevar,lijn); Settings.TabArtist:=strtoint(lijn);
  readln(Filevar,lijn); Settings.TabPlaylist:=strtoint(lijn);
  readln(Filevar,lijn); // Not used
  readln(Filevar,lijn); if lijn='0' then Settings.Notification:=false
                                    else Settings.Notification:=true;
  readln(Filevar,lijn); if lijn='0' then Settings.OnlyWhenMinized:=false
                                    else Settings.OnlyWhenMinized:=true;
  readln(Filevar,lijn); if lijn='0' then Settings.Tray:=false
                                    else Settings.Tray:=true;
  readln(Filevar,lijn); Settings.Encoder:=strtoint(lijn);
  readln(Filevar,lijn); if lijn='0' then Settings.UpcaseLetter:=false
                                    else Settings.UpcaseLetter:=true;
  readln(Filevar,lijn); if lijn='0' then Settings.Check_The:=false
                                    else Settings.Check_The:=true;
  readln(Filevar,lijn); if lijn='0' then Settings.SystemSettings:=false
                                    else Settings.SystemSettings:=true;
  readln(Filevar,lijn); Settings.CacheDirCDCover:=lijn;
  readln(Filevar,lijn); Settings.CacheDirSongtext:=lijn;
  readln(Filevar,lijn); Settings.cacheDirRadio:=lijn;
  readln(Filevar,lijn); VU_Settings.Active:=strtoint(lijn);
  readln(Filevar,lijn); VU_Settings.Theme:=strtoint(lijn);
  readln(Filevar,lijn); VU_Settings.Placement:=strtoint(lijn);
  readln(Filevar,lijn); if lijn='0' then VU_Settings.ShowPeaks:=False
                                    else VU_Settings.ShowPeaks:=True;
  readln(Filevar,lijn); if lijn='0' then Settings.SaveOnExternal:=False
                                    else Settings.SaveOnExternal:=True;
  Readln(Filevar,lijn);  if lijn='0' then Settings.CDCoverInfo:=False
                                    else Settings.CDCoverInfo:=True;
  Readln(Filevar,lijn);  if lijn='0' then Settings.CDCoverLyrics:=False
                                     else Settings.CDCoverLyrics:=True;
  readln(Filevar,lijn);   if lijn='0' then Settings.FixCDCover:=False
                                     else Settings.FixCDCover:=True;
  Readln(Filevar,lijn); Settings.TimerInterval:=strtoint(lijn);
  Readln(Filevar,lijn); Settings.DVDDrive:=lijn;
  Readln(Filevar,lijn); Settings.cdb:=strtointdef(lijn,400);
  Readln(Filevar,lijn); Settings.FontSize:=strtointdef(lijn,9);
  Readln(Filevar,lijn); Settings.Font2Size:=strtointdef(lijn,9);
  Readln(Filevar,lijn); Settings.ChosenLibrary:=strtointdef(lijn,0);
  readln(Filevar,lijn); if lijn='0' then Settings.MinimizeOnClose:=False
                                    else Settings.MinimizeOnClose:=True;
  readln(Filevar, lijn); if lijn='0' then Settings.NetworkControl:=False
                                    else Settings.NetworkControl:=True;
  Readln(Filevar, lijn); Settings.ip_port:=lijn;
  readln(Filevar, lijn); if lijn='0' then Settings.SaveLyricsInID3Tag:=False
                                    else Settings.SaveLyricsInID3Tag:=True;
  readln(Filevar, lijn); if lijn='0' then Settings.DeleteMacOSFiles:=False
                                     else Settings.DeleteMacOSFiles:=True;
  readln(Filevar, lijn); if lijn='0' then Settings.SaveExternalOnInternal:=False
                                     else Settings.SaveExternalOnInternal:=True;
  readln(Filevar, lijn); Settings.Soundcard:=strtointdef(lijn,1);
  readln(Filevar, lijn); if lijn='0' then Settings.ShowAllColums:=False
                                     else Settings.ShowAllColums:=True;
  readln(Filevar, lijn); if lijn='0' then Settings.NoAdvance:=False
                                     else Settings.NoAdvance:=True;
  repeat
     readln(Filevar,lijn);
  until lijn='[Coords]';
  readln(filevar,lijn); Form1.Left:=Strtointdef(lijn,10);
  readln(filevar,lijn); Form1.Top:=Strtointdef(lijn,10);
  readln(filevar,lijn); Form1.Height:=Strtointdef(lijn,400);
  readln(filevar,lijn); Form1.Width:=Strtointdef(lijn,300);
  readln(filevar,lijn); Form1.Splitter1.Left:=Strtoint(lijn);
  readln(filevar,lijn); Form1.Splitter3.Left:=Strtoint(lijn);
  readln(filevar,lijn); Form1.Splitter2.Top:=Strtoint(lijn);
  readln(filevar,lijn); Form1.Splitter5.Top:=Strtoint(lijn);
  repeat
    readln(Filevar,lijn);
  until lijn='[Local]';
  i:=0;
  repeat
    readln(Filevar,lijn);
    if length(lijn)>2 then
         begin
           checked_str:=copy(lijn,1,pos(';',lijn)-1);
           lijn_tmp:=copy(lijn,pos(';',lijn)+1,length(lijn));
           Settings.IncludeLocaleDirs.Add(lijn_tmp);
           Setlength(Settings.IncludeLocaleDirsChecked,Settings.IncludeLocaleDirs.Count);
           if checked_str='0' then Settings.IncludeLocaleDirsChecked[i]:=false
                              else Settings.IncludeLocaleDirsChecked[i]:=true;
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
           lijn_tmp:=copy(lijn,pos(';',lijn)+1,length(lijn));
           Settings.ExcludeLocaleDirs.Add(lijn_tmp);
           Setlength(Settings.ExcludeLocaleDirsChecked,Settings.ExcludeLocaleDirs.Count);
           if checked_str='0' then Settings.ExcludeLocaleDirsChecked[i]:=false
                              else Settings.ExcludeLocaleDirsChecked[i]:=true;
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
           lijn_tmp:=copy(lijn,pos(';',lijn)+1,length(lijn));
           Settings.IncludeExternalDirs.Add(lijn_tmp);
           Setlength(Settings.IncludeExternalDirsChecked,Settings.IncludeExternalDirs.Count);
           if checked_str='0' then Settings.IncludeExternalDirsChecked[i]:=false
                              else Settings.IncludeExternalDirsChecked[i]:=true;
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
           lijn_tmp:=copy(lijn,pos(';',lijn)+1,length(lijn));
           Settings.ExcludeExternalDirs.Add(lijn_tmp);
           Setlength(Settings.ExcludeExternalDirsChecked,Settings.ExcludeExternalDirs.Count);
           if checked_str='0' then Settings.ExcludeExternalDirsChecked[i]:=false
                              else Settings.ExcludeExternalDirsChecked[i]:=true;
           inc(i);
         end;
  until (lijn='') or eof(Filevar);
  repeat
    readln(Filevar,lijn);
  until lijn='[Schedule]';
  readln(Filevar,lijn); if lijn='0' then ScheduleSettings.CopyRec:=false
                                    else ScheduleSettings.CopyRec:=true;
  readln(Filevar,lijn); if lijn='0' then ScheduleSettings.RenameRec:=false
                                    else ScheduleSettings.RenameRec:=true;;
  readln(Filevar,lijn); if lijn='0' then ScheduleSettings.Overwrite:=false
                                    else ScheduleSettings.Overwrite:=true;
  readln(Filevar, ScheduleSettings.CopyDir);
  readln(Filevar, ScheduleSettings.RenameFormat);
  readln(Filevar,lijn); if lijn='0' then ScheduleSettings.DeleteAfterCopy:=false
                                    else ScheduleSettings.DeleteAfterCopy:=true;
  repeat
    readln(Filevar,lijn);
  until lijn='[Lame]';
  ReadLn(Filevar,Settings.Lame);
  ReadLn(Filevar,Settings.EncodingTargetFolder);
  Readln(Filevar,Settings.EncodingFilenameFormatSingle);
  readln(Filevar,Settings.EncodingFilenameFormatCompilation);
  readln(Filevar,lijn); if lijn='0' then Lameopties.pr:=false
                                    else Lameopties.pr:=true;
  readln(Filevar,lijn); if lijn='0' then Lameopties.abr:=false
                                    else Lameopties.abr:=true;;
  readln(Filevar,lijn); if lijn='0' then Lameopties.vbr:=false
                                    else Lameopties.vbr:=true;
  readln(Filevar,lijn); if lijn='0' then Lameopties.cbr:=false
                                    else Lameopties.cbr:=true;
  readln(Filevar,lijn); if lijn='0' then Lameopties.mono:=false
                                    else Lameopties.mono:=true;
  readln(Filevar,Lameopties.BitrateMin);
  readln(Filevar,Lameopties.BitrateMax);
  readln(Filevar,Lameopties.BitRateQuality);
  readln(Filevar,Lameopties.Preset);
  readln(Filevar,Lameopties.EncQuality);
  repeat
    readln(Filevar,lijn);
  until lijn='[Flac]';
  readln(Filevar,Settings.Flac);
  repeat
    readln(Filevar,lijn);
  until lijn='[OGG]';
  readln(Filevar,Settings.OGG);
  readln(Filevar,OGGopties.BitrateMax);
  readln(Filevar,OGGOpties.BitrateMin);
  readln(Filevar,OGGopties.EncQuality);
  readln(Filevar,lijn); if lijn='0' then OGGOpties.cbr:=false
                                    else OGGopties.cbr:=true;
  readln(Filevar,lijn); if lijn='0' then OGGOpties.mmode:=false
                                    else OGGopties.mmode:=true;
  readln(Filevar,lijn); if lijn='0' then OGGOpties.ForceQuality:=false
                                    else OGGopties.ForceQuality:=true;
  readln(Filevar,lijn); if lijn='0' then OGGOpties.vbr:=false
                                    else OGGopties.vbr:=true;
  repeat
    readln(Filevar,lijn);
  until lijn='[AAC]';
  readln(Filevar,Settings.AAC);
  readln(Filevar,AACopties.Bitrate);
  readln(Filevar,lijn); if lijn='0' then AACOpties.vbr:=false
                                    else AACOpties.vbr:=true;
  readln(Filevar,lijn); if lijn='0' then AACOpties.cbr:=false
                                    else AACOpties.cbr:=true;
  readln(Filevar,lijn); AACOpties.vbrmode:=Strtointdef(lijn,4);
  repeat
    readln(Filevar,lijn);
  until lijn='[OPUS]';
  readln(Filevar,Settings.Opus);
  readln(Filevar,Opusopties.Bitrate);
  readln(Filevar,Opusopties.EncQuality);
  readln(Filevar,lijn); if lijn='0' then OpusOpties.cbr:=false
                                    else OpusOpties.cbr:=true;
  readln(Filevar,lijn); if lijn='0' then OpusOpties.vbr:=false
                                    else OpusOpties.vbr:=true;
  readln(Filevar,lijn); if lijn='0' then OpusOpties.cvbr:=false
                                    else OpusOpties.cvbr:=true;
  readln(Filevar,lijn); OpusOpties.Framesize:=Strtointdef(lijn,20);
  readln(Filevar,lijn); OpusOpties.Framesizei:=Strtointdef(lijn,4);
  repeat
    readln(Filevar,lijn);
  until lijn='[DVD]';
  readln(Filevar,Settings.Mplayer);
  repeat
    readln(Filevar,lijn);
  until lijn='[Lyrics]';
  repeat
    Readln(Filevar,lijn);
    if (length(lijn)>2) and (lijn<>'[EQ]') then
    begin
      lijn_tmp:=Copy(lijn,1,1);
      Delete(lijn,1,pos(';',lijn));
      FormConfig.CLB_Lyrics.Items.Add(lijn);
      if lijn_tmp='0' then FormConfig.CLB_Lyrics.Checked[FormConfig.CLB_Lyrics.Items.Count-1]:= false
                      else FormConfig.CLB_Lyrics.Checked[FormConfig.CLB_Lyrics.Items.Count-1]:= true;
    end;
  until lijn='[EQ]';
  Readln(Filevar,lijn);
  if lijn='0' then Settings.EQ:=False
              else Settings.EQ:=True;
  Readln(Filevar,lijn);
  EQ_Set:=strtointdef(lijn,0);
  repeat
    readln(Filevar,lijn);
  until lijn='[PREVOLUME]';
  Readln(Filevar,lijn);
  FormEQ.TrackBar1.Position:=strtointdef(lijn,100);
  repeat
    readln(Filevar,lijn);
  until lijn='[LASTFM]';
  readln(Filevar,Settings.LastFMLogin);
  Readln(Filevar,Settings.LastFMPass);
  repeat
    readln(Filevar,lijn);
  until lijn='[RADIO]';
  readln(Filevar,lijn);
  LB_Land1.ItemIndex:=LB_Land1.Items.IndexOf(lijn);
  repeat
    readln(Filevar,lijn);
  until lijn='[ID3TAGGER]';
  readln(Filevar,Settings.MaskToTag);
  readln(Filevar,Settings.MaskToFile);
  FormFillTagFromFile.ListBox1.Items.Clear;
  repeat
    readln(Filevar,lijn); if lijn<>'[THEME]' then FormFillTagFromFile.ListBox1.Items.Add(lijn);
  until eof(filevar) or (lijn='[THEME]');
  if lijn='[THEME]' then
  begin
    readln(Filevar,lijn);
    readln(Filevar,lijn); if lijn='0' then Settings.UseBackDrop:=False
                                      else Settings.UseBackDrop:=True;
    readln(Filevar,lijn); Settings.Backdrop:=strtointdef(lijn,1);;
  end;
  CloseFile(Filevar);
end;

procedure TForm1.SpeedButton21Click(Sender: TObject);
var I: integer;
begin
  If StringgridPresets.RowCount>1 then
  begin
    i:=StringgridPresets.Row;
    If i<StringgridPresets.RowCount-1 then stringgridPresets.MoveColRow(False,i,i+1);
    SavePresets;
  end;
end;

procedure TForm1.ImageCDCoverLyricDblClick(Sender: TObject);
begin
  FormCoverPlayer.ShowModal;
end;

procedure TForm1.ActionChoseRadioExecute(Sender: TObject);
begin
  PageControl1.ActivePageIndex:=5;
  PageControl4.ActivePageIndex:=0;
  TabSheetRadioShow(Self);
  StringgridRadioAir.Row:=1;
  StringGridRadioAirDblClick(Self);

end;

procedure TForm1.ActionChoseMP3Execute(Sender: TObject);
begin
  PageControl1.ActivePageIndex:=0;
  TabSheetArtistsShow(Self);
  LB_Artist1.ItemIndex:=0;
  LB_Artist1Click(Self);
  LB_Artist1DblClick(Self);
end;

procedure TForm1.ActionSearchExecute(Sender: TObject);
begin
 if Pagecontrol2.ActivePageIndex=0 then
  begin
    SearchPanelBrowser.Visible:=not SearchPanelBrowser.Visible;
    //if SearchPanelQueue.Visible then Edit4.SetFocus;
  end;
  if Pagecontrol2.ActivePageIndex=1 then
  begin
    SearchPanelQueue.Visible:=not SearchPanelQueue.Visible;
    if SearchPanelQueue.Visible then Edit4.SetFocus;
  end;
end;

procedure TForm1.ActionNextExecute(Sender: TObject);
begin
  SB_NextClick(Self);
end;

procedure TForm1.ActionPauzeExecute(Sender: TObject);
begin
  SB_PauzeClick(Self);
end;

procedure TForm1.ActionPlayExecute(Sender: TObject);
begin
  SB_PlayClick(Self);
end;

procedure TForm1.ActionPreviousExecute(Sender: TObject);
begin
  SB_PreviousClick(Self);
end;

procedure TForm1.ActionStopExecute(Sender: TObject);
begin
  SB_StopClick(Self);
end;

procedure TForm1.CB_ShowAllThumbsChange(Sender: TObject);
var Temp_StringList: TStringList;
    i: longint;
    temp, PreviousAlbum: String;
    SongsWithoutAlbum: Boolean;
begin
  CB_ShowAllThumbs.Cursor:=CrHourGlass; SongsWithoutAlbum:=False;
  Application.ProcessMessages;
  (* Begin ThumbControl*)
  Temp_StringList:=TStringList.Create;
  ThumbControl1.ClearImages;
  If CB_ShowAllThumbs.Checked then
  begin
   for i:=0 to MaxSongs-1 do if not Liedjes[i].Deleted then
    begin
      if length(Liedjes[i].CD)=0 then SongsWithoutAlbum:=True
                                 else
      begin
        if Liedjes[i].CD<>PreviousAlbum then
        if Temp_StringList.IndexOf(Liedjes[i].CD)<0 then
        begin
          Temp_StringList.Add(Liedjes[i].CD);
          temp:=ConfigDir+DirectorySeparator+'cache'+DirectorySeparator+ConvertArtist(Liedjes[i].Artiest,true)+'-'+ConvertAlbum(Liedjes[i].CD)+'.jpg';
          if FileExistsUTF8(temp) then ThumbControl1.AddImage(temp,inttostr(i),Liedjes[i].Artiest+' - '+Liedjes[i].CD )
                                  else if FileExistsUTF8(ConfigDir+DirectorySeparator+'cache'+DirectorySeparator+ConvertArtist(Liedjes[i].Artiest,true)+'-'+ConvertAlbum(Liedjes[i].CD)+'.png')
                                       then ThumbControl1.AddImage(ConfigDir+DirectorySeparator+'cache'+DirectorySeparator+ConvertArtist(Liedjes[i].Artiest,true)+'-'+ConvertAlbum(Liedjes[i].CD)+'.png', inttostr(i),Liedjes[i].Artiest+' - '+Liedjes[i].CD)
                                       else if FileExistsUTF8(ConfigDir+DirectorySeparator+'cache'+DirectorySeparator+'unknown.jpg') then ThumbControl1.AddImage(ConfigDir+DirectorySeparator+'cache'+DirectorySeparator+'unknown.jpg', inttostr(i),Liedjes[i].Artiest+' - '+Liedjes[i].CD);
          PreviousAlbum:=Liedjes[i].CD;
        end;
      end;
    end;
    if SongsWithoutAlbum then if FileExistsUTF8(ConfigDir+DirectorySeparator+'cache'+DirectorySeparator+'unknown.jpg') then ThumbControl1.AddImage(ConfigDir+DirectorySeparator+'cache'+DirectorySeparator+'unknown.jpg', '-1','No Album');
  end
                              else
  begin
    for i:=1 to SG_All.RowCount-1 do if not Liedjes[strtoint(SG_All.Cells[0,i])].Deleted
    then
    begin
    begin
      if length(SG_All.Cells[4,i])=0 then SongsWithoutAlbum:=true
      else
      begin
        if SG_All.Cells[4,i]<>PreviousAlbum then
        if Temp_StringList.IndexOf(SG_All.Cells[4,i])<0 then
        begin
          Temp_StringList.Add(SG_All.Cells[4,i]);
          temp:=ConfigDir+DirectorySeparator+'cache'+DirectorySeparator+ConvertArtist(SG_All.Cells[1,i],true)+'-'+ConvertAlbum(SG_All.Cells[4,i])+'.jpg';
          if FileExistsUTF8(temp) then ThumbControl1.AddImage(temp,SG_All.Cells[0,i],SG_All.Cells[1,i]+' - '+SG_All.Cells[4,i] )
                                  else if FileExistsUTF8(ConfigDir+DirectorySeparator+'cache'+DirectorySeparator+ConvertArtist(SG_All.Cells[1,i],true)+'-'+ConvertAlbum(SG_All.Cells[4,i])+'.png')
                                       then ThumbControl1.AddImage(ConfigDir+DirectorySeparator+'cache'+DirectorySeparator+ConvertArtist(SG_All.Cells[1,i],true)+'-'+ConvertAlbum(SG_All.Cells[4,i])+'.png', SG_All.Cells[0,i],SG_All.Cells[1,i]+' - '+SG_All.Cells[4,i])
                                       else if FileExistsUTF8(ConfigDir+DirectorySeparator+'cache'+DirectorySeparator+'unknown.jpg') then ThumbControl1.AddImage(ConfigDir+DirectorySeparator+'cache'+DirectorySeparator+'unknown.jpg', SG_All.Cells[0,i],SG_All.Cells[1,i]+' - '+SG_All.Cells[4,i]);
          PreviousAlbum:=SG_All.Cells[4,i];
        end;
      end;
    end;
    end;
    if SongsWithoutAlbum then if FileExistsUTF8(ConfigDir+DirectorySeparator+'cache'+DirectorySeparator+'unknown.jpg') then ThumbControl1.AddImage(ConfigDir+DirectorySeparator+'cache'+DirectorySeparator+'unknown.jpg', '-1','No Album');
    ThumbControl1.ImageLoaderManager.ActiveIndex:=0;
  end;
  Temp_StringList.Free;
  CB_ShowAllThumbs.Cursor:=CrDefault;
  (* End ThumbControl *)
end;

procedure TForm1.Edit4KeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
var gevonden: Boolean;
    i: Integer;
begin
  //Search for string in stringgrid, starting from the selected row
  i:=SG_Play.Row-1; gevonden:=false;
  repeat
    inc(i);
    If pos(Edit4.Text,upcase(SG_Play.Cells[1,i]))>0 then gevonden:=true;
    If pos(Edit4.Text,upcase(SG_Play.Cells[3,i]))>0 then gevonden:=true;
    If pos(Edit4.Text,upcase(SG_Play.Cells[4,i]))>0 then gevonden:=true;
    If pos(Edit4.Text,SG_Play.Cells[5,i])>0 then gevonden:=true;
  until (gevonden) or (i>=SG_Play.RowCount-1);
  if gevonden then SG_Play.Row:=i;
end;

procedure TForm1.Edit5KeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
var gevonden: Boolean;
    i: Integer;
begin
  //Search for string in stringgrid, starting from the selected row
  i:=SG_All.Row-1; gevonden:=false;
  repeat
    inc(i);
    If pos(Edit5.Text,upcase(SG_All.Cells[1,i]))>0 then gevonden:=true;
    If pos(Edit5.Text,upcase(SG_All.Cells[3,i]))>0 then gevonden:=true;
    If pos(Edit5.Text,upcase(SG_All.Cells[4,i]))>0 then gevonden:=true;
    If pos(Edit5.Text,upcase(SG_All.Cells[5,i]))>0 then gevonden:=true;
    If pos(Edit5.Text,upcase(SG_All.Cells[6,i]))>0 then gevonden:=true;
  until (gevonden) or (i>=SG_All.RowCount-1);
  if gevonden then SG_All.Row:=i;
end;

procedure TForm1.RunParameters(Data:IntPtr);
var TempArtist, TempPlaylist, mode, nr: string;
    index: longint;
begin
(*
  TempArtist:='';TempPlaylist:='';nr:='';
  If Application.HasOption('autoplay') then   // StartPlaying
    begin
      mode:='';
      mode:=Application.GetOptionValue('y', 'autoplay');
      if mode='radio' then
      begin
        index:=0;
        PageControl1.ActivePageIndex:=5;
        nr:=Application.GetOptionValue('n', 'nr');
        if length(nr)>0 then
        begin
          repeat
            inc(index);
          until (nr=StringgridRadioAir.Cells[0,index]) or (index>=StringGridRadioAir.RowCount-1);
          if nr=StringgridRadioAir.Cells[0,index] then
          begin
            StringGridRadioAir.Row:=index; StringgridRadioAirClick(Self);
            StringgridRadioAirDblClick(Self);
          end;
        end;
        nr:=Application.GetOptionValue('r', 'preset');
        if length(nr)>0 then
        begin
          PageControl4.ActivePageIndex:=1;
          index:=Strtointdef(nr,1);
          StringgridPresets.Row:=index;  StringgridPresetsClick(Self);
          StringgridPresetsDblClick(Self);
        end;
        if Application.HasOption('mediamode') then FormCoverPlayer.ShowModal;
        exit;
      end;

      index:=0;
      TempPlaylist:=Application.GetOptionValue('p', 'playlist');
      if length(TempPlaylist)>0 then
      begin
        index:=LB_Playlist.Items.IndexOf(TempPlaylist);
        if index>-1 then
        begin
          PageControl1.ActivePageIndex:=3;
          LB_Playlist.ItemIndex:=index;
          LB_PlaylistClick(Self);
          LB_PlaylistDblClick(Self);
         // exit;
        end;
      end;

      index:=0;
      TempArtist:=Application.GetOptionValue('a', 'artist');
      if length(Tempartist)>0 then
      begin
        index:=LB_Artist1.Items.IndexOf(Tempartist);
        if index<0 then index:=0;
      end;
      LB_Artist1.ItemIndex:=index;
      LB_Artist1Clicked;
      LB_Artist1DblClick(Self);
    end;
 *)
end;


procedure TForm1.FormActivate(Sender: TObject);
begin
  if firsttime then
  begin
    LB_Artist1.MakeCurrentVisible;

    if Application.HasOption('minimized') then Form1.WindowState:=wsMinimized;
    If Application.HasOption('fullscreen') then Form1.WindowState:=wsMaximized;
    If Application.HasOption('kiosk') then SetFullscreen;

    firsttime:=false;
    //Application.QueueAsyncCall(@RunParameters,0);
  end;

end;

procedure TForm1.ImageCDCoverPictureChanged(Sender: TObject);
begin

end;

procedure TForm1.Label35MouseEnter(Sender: TObject);
begin
  Label34.Font.Color:=clRed; Label35.Font.Color:=clRed; Label36.Font.Color:=clRed;
  ProgressBarSpeed.Visible:=True;
end;

procedure TForm1.Label35MouseLeave(Sender: TObject);
begin
   Label34.Font.Color:=clGray; Label35.Font.Color:=clGray; Label36.Font.Color:=clGray;
  ProgressBarSpeed.Visible:=False;
end;

procedure TForm1.MenuItem102Click(Sender: TObject);
var aantal, i, old_aantal: longint;
    page_temp: byte;
begin
  Page_temp:=PageControl2.PageIndex;
  LB_Albums1Click(Self); Application.ProcessMessages;
  aantal:=SG_Play.RowCount; old_aantal:=SG_Play.RowCount;
  SG_Play.RowCount:=SG_Play.RowCount+SG_All.RowCount-1;
  For i:=1 to SG_all.RowCount-1 do
    begin
      inc(aantal);
      SG_Play.Cells[1,aantal-1]:=SG_All.Cells[1,i];
      SG_Play.Cells[2,aantal-1]:=SG_All.Cells[2,i];
      SG_Play.Cells[3,aantal-1]:=SG_All.Cells[3,i];
      SG_Play.Cells[4,aantal-1]:=SG_All.Cells[4,i];
      SG_Play.Cells[5,aantal-1]:=Liedjes[strtointdef(SG_All.Cells[0,i],1)].Jaartal;
      SG_Play.Cells[6,aantal-1]:=SG_All.Cells[0,i];
    end;
  AutoSizePlayColumns;
  if Settings.Shuffle then
  begin
   Setlength(OrigineleVolgorde,SG_Play.RowCount); Application.ProcessMessages;
   for i:=old_aantal to SG_Play.RowCount-1 do OrigineleVolgorde[i]:=strtoint(SG_Play.Cells[6,i]);
   Mi_ReShuffleClick(Self);
  end;
  SongsInPlayingQueue:=SG_Play.RowCount-1;
  PageControl2.PageIndex:=Page_Temp;
end;

procedure TForm1.MenuItem114Click(Sender: TObject);
var temp: string;
begin
  threadrunning:=True;
  temp:=GetCDArtworkFromLastFM(songplaying);
  if temp<>'x' then
  begin
    ImageCDCover.Picture.LoadFromFile(temp);
    FormCoverPlayer.ImageCDCover.Picture.Bitmap:=ImageCDCover.Picture.Bitmap;
  end;
  threadrunning:=False;
end;

procedure TForm1.MenuItem122Click(Sender: TObject);
var welke, i, temp, ActiveIndex: integer;
    Album, Artiest: String;
    toevoegen: boolean;
begin
  if SelectDirectoryDialog1.Execute then
  begin
   ActiveIndex:=strtointdef(ThumbControl1.ImageLoaderManager.ActiveItem.DataString,0);
   artiest:=upcase(Liedjes[ActiveIndex].Artiest);
   album:=upcase(Liedjes[ActiveIndex].CD);
   GetSongsFromAlbum(Artiest, Album, True);
   for i:=0 to FilesFound.Count-1 do
   begin
      temp:=strtoint(FilesFound.Strings[i]);
      SaveDownloadto.Add(SelectDirectoryDialog1.FileName);
      labelPodcast.Caption:=inttostr(SaveDownLoadTo.Count);
      FormDownLoadOverView.ListBox1.Items.Add(Liedjes[temp].Pad+Liedjes[temp].Bestandsnaam);
   end;
   if not downloadpodcast then Thread1:=TDownloadPodCastThread.Create(False);
  end;
end;

procedure TForm1.MenuItem123Click(Sender: TObject);
begin

end;

procedure TForm1.MenuItem129Click(Sender: TObject);
var ActiveIndex: longint;
    Temp: string;
begin
  // TRY TO LOAD CDCOVER FROM LAST FM
 // IS NOT THREADED  yet

  ActiveIndex:=strtointdef(ThumbControl1.ImageLoaderManager.ActiveItem.DataString,0);
  welkecover:=ActiveIndex;
  temp:=GetCDArtworkFromLastFM(ActiveIndex);
  if temp<>'x' then
  begin
    ThumbControl1.ChangeImage(Temp,ThumbControl1.ImageLoaderManager.ActiveIndex);
    ThumbControl1.ReloadImages;
  end
  Else ShowMessage('No CD Cover found !');

end;

procedure TForm1.MenuItem1Click(Sender: TObject);
begin
  case stream of
       1: BASS_ChannelSlideAttribute(Song_Stream1,BASS_ATTRIB_VOL,0,1000);
       2: BASS_ChannelSlideAttribute(Song_Stream2,BASS_ATTRIB_VOL,0,1000);
       4: BASS_ChannelSlideAttribute(ReverseStream,BASS_ATTRIB_VOL,0,1000);
       5: BASS_ChannelSlideAttribute(CDStream,BASS_ATTRIB_VOL,0,1000);
       6: BASS_ChannelSlideAttribute(Song_Stream1,BASS_ATTRIB_VOL,0,1000);
  end;
  WriteConfig;
  WriteMusicDatabase;
  Settings.Fast:=True;
  SHowMessage('Juist voor Close');
  Close;
end;

procedure TForm1.MenuItem3Click(Sender: TObject);
var cmd: string;
    AProcess: TProcess;
begin
  {$IFDEF LINUX}
    cmd:='xdg-open "'+ShellTreeView1.Path+'"';
  {$ENDIF LINUX}
  {$IFDEF DARWIN or $IFDEF HAIKU}
    cmd:='open "'+SG_All.Cells[COL_SG_ALL_PATH,SG_All.Row]+'"';
  {$ENDIF DARWIN}
  {$IFDEF WINDOWS}
    cmd:='explorer "'+utf8tosys(SG_All.Cells[COL_SG_ALL_PATH,SG_All.Row])+'"';
  {$ENDIF WINDOWS}

  AProcess := TProcess.Create(nil);
  AProcess.CommandLine := cmd;
  AProcess.Execute;
  AProcess.Free;
end;

procedure TForm1.MenuItem90Click(Sender: TObject);
var ext, bestand, lijn: String;
    ActiveIndex: longint;
begin
  ActiveIndex:=strtointdef(ThumbControl1.ImageLoaderManager.ActiveItem.DataString,0);
  OpenDialog1.InitialDir:=Liedjes[ActiveIndex].Pad;
  If OpenDialog1.Execute then
  begin
    ext:='x';
    bestand:=UpCase(OpenDialog1.FileName);
    if (pos('.JPG',bestand)>1) or (pos('.JPEG',bestand)>1) then ext:='.jpg';
    if (pos('.PNG',bestand)>1) then ext:='.png';
    if ext<>'x' then
    begin
      lijn:=convertartist(LB_artiest.Caption, true)+'-'+convertalbum(LB_cd.Caption);
      Deletefile(Configdir+Directoryseparator+'cache'+DirectorySeparator+lijn+'.png');
      Deletefile(Configdir+Directoryseparator+'cache'+DirectorySeparator+lijn+'.jpg');
      CopyFile(OpenDialog1.FileName,Configdir+Directoryseparator+'cache'+DirectorySeparator+lijn+ext);
      ThumbControl1.ChangeImage(Configdir+Directoryseparator+'cache'+DirectorySeparator+lijn+ext,ThumbControl1.ImageLoaderManager.ActiveIndex);
      ThumbControl1.ReloadImages;
    end;
  end;
end;

procedure TForm1.MI_SGALL_WikiClick(Sender: TObject);
begin
  BrowseTo('http://en.wikipedia.org/wiki/'+MakeWikiArtist(SG_All.Cells[1,SG_All.Row],'_'));
end;

procedure TForm1.MI_SGALL_DeleteClick(Sender: TObject);
begin
  DeleteSelectedSongs(SG_All);
end;

procedure TForm1.MI_SGALL_ShowInVirtualFSClick(Sender: TObject);
var sub_str, lijn  : string;
    Str            : TStringlist;
    i              : integer;
begin
  sub_str:=copy(Liedjes[strtoint(SG_All.Cells[0,SG_all.Row])].Pad, 1, length(Liedjes[strtoint(SG_All.Cells[0,SG_all.Row])].Pad));
  lijn:=sub_str;

  TabSheetVirtualFS.Show;
  Str := TStringlist.Create;
  while pos(DirectorySeparator,sub_str)>0 do
  begin
    lijn:=copy(sub_str,1,pos(DirectorySeparator,sub_str)-1);
    {$IFDEF WINDOWS}
       if pos(':',lijn)>0 then lijn:=lijn+DirectorySeparator;  // Windows uses driveletters
    {$ENDIF}
    if (length(lijn)>0) then Str.Add(lijn);
    Delete(sub_str,1,pos(DirectorySeparator,sub_str));         // Needs to be tested with music on separated drives
  end;

  aNode:=TV_VFS.Items.Item[0];        // Root Node
  {$IFDEF WINDOWS}
    if aNode.Text<>Str[0] then        // If the Node is not the DRIVELETTER we search, get to the next sibling
    begin
      repeat
        aNode:=aNode.GetNextSibling;
      until aNode.Text=Str[0];        // Until found
    end;
    Str.Delete(0);   // We delete the driveletter from the stringlist
  {$ENDIF}
  For i:=0 to Str.Count-1 do
  begin
    aNode:=aNode.GetFirstChild; // Get the first node under the root Node
    if aNode.Text<>Str[i] then  // If the Node is not the one we search, get to the next sibling
    begin
      repeat
        aNode:=aNode.GetNextSibling;
      until aNode.Text=Str[i];  // Until found
    end;
  end;

  TV_VFS.Items.SelectOnlyThis(aNode);

end;

procedure TForm1.MI_SGALL_ShowInfoClick(Sender: TObject);
begin
    if not FormDetails.Visible then FormDetails.Show
                             else
                               begin
                                 FormDetails.UpdateInformation;
                               end;
  FormDetails.SetFocus;
end;

procedure TForm1.MI_SGALL_SameYearClick(Sender: TObject);
var jaar: string;
    i,i2: longint;
begin
  jaar:=Liedjes[strtoint(SG_All.Cells[0, SG_All.Row])].Jaartal;
  if jaar='' then exit;
  SG_All.RowCount:=1; i2:=0;
  for i:=0 to maxsongs-1 do if not Liedjes[i].Deleted then
  begin
    if (pos(jaar,Liedjes[i].Jaartal)>0) or (pos(Liedjes[i].Jaartal,jaar)>0) then
      begin
       inc(i2);
       SG_All.RowCount:=i2+1;
       SG_All.Cells[0,i2]:=inttostr(i);
       SG_All.Cells[1,i2]:=Liedjes[i].Artiest;
       if Liedjes[i].Track=0 then SG_All.Cells[2,i2]:=''
                             else SG_All.Cells[2,i2]:=inttostr(Liedjes[i].Track);
       SG_All.Cells[3,i2]:=Liedjes[i].Titel;
       SG_All.Cells[4,i2]:=Liedjes[i].CD;
       SG_All.Cells[COL_SG_ALL_PATH,i2]:=Liedjes[i].Pad;
       SG_All.Cells[COL_SG_ALL_NAME,i2]:=Liedjes[i].Bestandsnaam;
      end;
  end;
  AutoSizeAllColumns;
end;

procedure TForm1.MI_SGALL_SameGenreClick(Sender: TObject);
var genre: string;
    i,i2: longint;
begin
  genre:=Liedjes[strtoint(SG_All.Cells[0, SG_All.Row])].Genre;
  if genre='' then exit;
  SG_All.RowCount:=1; i2:=0;
  for i:=0 to maxsongs-1 do if not Liedjes[i].Deleted then
  begin
    if (pos(genre,Liedjes[i].Genre)>0) or (pos(Liedjes[i].Genre,genre)>0) then
      begin
       inc(i2);
       SG_All.RowCount:=i2+1;
       SG_All.Cells[0,i2]:=inttostr(i);
       SG_All.Cells[1,i2]:=Liedjes[i].Artiest;
       if Liedjes[i].Track=0 then SG_All.Cells[2,i2]:=''
                             else SG_All.Cells[2,i2]:=inttostr(Liedjes[i].Track);
       SG_All.Cells[3,i2]:=Liedjes[i].Titel;
       SG_All.Cells[4,i2]:=Liedjes[i].CD;
       SG_All.Cells[COL_SG_ALL_PATH,i2]:=Liedjes[i].Pad;
       SG_All.Cells[COL_SG_ALL_NAME,i2]:=Liedjes[i].Bestandsnaam;
      end;
  end;
  AutoSizeAllColumns;
end;

procedure TForm1.MI_SGALL_SameAlbumClick(Sender: TObject);
begin
    If SG_All.Cells[4,SG_All.Row]<>'' then
  begin
    PageControl1.ActivePageIndex:=1;
    LB_Albums1.ItemIndex:=LB_Albums1.Items.IndexOf(SG_All.Cells[4,SG_All.Row]);
    LB_Albums1.MakeCurrentVisible;
    LB_Albums1Click(Self);
  end;
end;

procedure TForm1.MI_SGALL_SameArtistClick(Sender: TObject);
begin
  PageControl1.ActivePageIndex:=0;
  LB_Artist1.ItemIndex:=LB_Artist1.Items.IndexOf(SG_All.Cells[1,SG_All.Row]);
  LB_Artist1.MakeCurrentVisible;
  LB_Artist1Click(Self);
end;

procedure TForm1.MI_SGALL_AboutClick(Sender: TObject);
begin
  FormAbout.ShowModal;
end;

procedure TForm1.MI_SGALL_ShowLogClick(Sender: TObject);
begin
  if not FormLog.Visible then FormLog.Show;
end;

procedure TForm1.MI_SGALL_OpenFolderClick(Sender: TObject);
var cmd: string;
    AProcess: TProcess;
begin
  {$IFDEF LINUX}
    cmd:='xdg-open "'+SG_All.Cells[COL_SG_ALL_PATH,SG_All.Row]+'"';
  {$ENDIF LINUX}
  {$IFDEF DARWIN or $IFDEF HAIKU}
    cmd:='open "'+SG_All.Cells[COL_SG_ALL_PATH,SG_All.Row]+'"';
  {$ENDIF DARWIN}
  {$IFDEF WINDOWS}
    cmd:='explorer "'+utf8tosys(SG_All.Cells[COL_SG_ALL_PATH,SG_All.Row])+'"';
  {$ENDIF WINDOWS}

  AProcess := TProcess.Create(nil);
  AProcess.CommandLine := cmd;
  AProcess.Execute;
  AProcess.Free;
end;


procedure TForm1.MenuItem170Click(Sender: TObject);
begin
    if not FormFiletools.Visible then FormFileTools.Show
                               else FormFileTools.BringToFront;
end;

procedure TForm1.MI_SGALL_RemoveFadeClick(Sender: TObject);
var i, max: longint;
begin
  max:=SG_All.RowCount-1;
   For i := 1 to max do
       if IsCellSelected(SG_All,1,i)
             then Liedjes[strtoint(SG_All.Cells[0,i])].FadeSettings:=0;
end;
procedure TForm1.MI_SGALL_SetFadeClick(Sender: TObject);
var i, max: longint;
begin
  max:=SG_All.RowCount-1;
   For i := 1 to max do
       if IsCellSelected(SG_All,1,i)
             then Liedjes[strtoint(SG_All.Cells[0,i])].FadeSettings:=255;
end;

procedure TForm1.MI_SGALL_TaggerClick(Sender: TObject);
var i, i_selected, teller, i_row: longint;
    filesModified, tagsModified: boolean;
begin
 // ShowMessage('WORK IN PROGRESS.  Picture information is NOT yet saved as ID3-TAG.  If the file contains an ID3-TAG picture, you will lose this TAG when you save the changed tags.  Only use SAVE if you know what this means.  ID3-TAG picture saving will be added in future releases.');
  FormID3Tagger.ListBox1.Items.Clear;
  i_selected:=0; teller:=0;

  if (sender=MI_TagArtist1) or (sender=MI_TagAlbum2)
     then i_selected:=SG_All.RowCount-1
     else begin
            for i:=1 to SG_All.RowCount-1 do if IsCellSelected(SG_All,1,i) then inc(i_selected);
          end;

  if i_selected>0 then
  begin
    // JRA: why +1?, is the array used as if it was 1-based instead of 0-based?
    // Zittergie: Just because :)  Wanted to be sure that I have enough memory
    Setlength(Tag_Liedjes,i_selected+1);
    Setlength(TagVolgorde,i_selected+1);

    for i:=1 to SG_All.RowCount-1 do
    begin
      if (IsCellSelected(SG_All,1,i)) or (Sender=MI_TagArtist1) or (sender=MI_TagAlbum2)  then
      begin
        i_row := strtoint(SG_All.Cells[0,i]);
        Tag_Liedjes[teller]:=Liedjes[i_row];   // here first teller value is 0, so is 0-based
        Tag_Liedjes[teller].Modified := false;
        Tag_Liedjes[teller].FNModified := false;
        Liedjes[i_row].Modified := false;
        Liedjes[i_row].FNModified := false;
        TagVolgorde[teller]:=i_row;
        FormID3Tagger.ListBox1.Items.Add(Tag_Liedjes[teller].Bestandsnaam);
        inc(teller);
      end;
    end;
    FormID3Tagger.Memo1.Lines.Clear;
    FormID3Tagger.Memo1.Lines.Add('# '+inttostr(i_selected)+' '+Form1.Vertaal('songs added'));
  end;

  FormID3Tagger.Showmodal;

  // teller holds the real Tag_Liedjes item count, use it.
  filesModified := false; tagsModified := false;
  for i:=0 to teller-1 do
  begin
    if Tag_Liedjes[i].Modified  then
    begin
      Liedjes[TagVolgorde[i]].Modified := true;
      tagsModified := true;
    end;
    if Tag_Liedjes[i].FNModified then
    begin
      Liedjes[TagVolgorde[i]].FNModified := true;
      filesModified := true;
    end;
  end;
  if tagsModified or filesModified then
    // refresh lists as there are changes
    RefreshLists(tagsModified, filesModified);
  Tag_Liedjes:=nil; TagVolgorde:=nil;
end;

procedure TForm1.MI_SGALL_RenameClick(Sender: TObject);
begin
  songchosen:=strtoint(SG_All.Cells[0,SG_All.Row]);
  FormRenameSong.Showmodal;
end;

procedure TForm1.MI_SGALL_CopyToFolderClick(Sender: TObject);
var target, ext, temp: string;
    i: integer;
begin
  If SelectDirectoryDialog1.Execute then
    Begin
     i:=1;
     target:=SelectDirectoryDialog1.FileName+DirectorySeparator+Liedjes[songchosen].Bestandsnaam;
     ext:=ExtractFileExt(target);
     temp:=copy(target,1,length(target)-length(ext));
     if FileExistsUTF8(target) then
       repeat
          inc(i); target:=temp+' ('+inttostr(i)+')'+ext;
       until not FileExistsUTF8(target) ;
      CopyFile(Liedjes[songchosen].Pad+Liedjes[songchosen].Bestandsnaam,target);
      ShowMessage(Vertaal('Song successfully copied.'));
    end;
end;

procedure TForm1.MI_AddToPlaylist1Click(Sender: TObject);
begin

end;

procedure TForm1.MI_SGALL_AddAfterCurrentClick(Sender: TObject);
var old_aantal, i, i2, rij: longint;
begin
  old_aantal:=SG_Play.RowCount-1; rij:=songrowplaying;
  For i:=SG_all.RowCount-1 downto 1 do
    if IsCellSelected(SG_All,1,i) then
    begin
      SG_Play.InsertColRow(False,rij+1);
      SG_Play.Cells[1,rij+1]:=SG_All.Cells[1,i];
      SG_Play.Cells[2,rij+1]:=SG_All.Cells[2,i];
      SG_Play.Cells[3,rij+1]:=SG_All.Cells[3,i];
      SG_Play.Cells[4,rij+1]:=SG_All.Cells[4,i];
      SG_Play.Cells[5,rij+1]:=Liedjes[strtointdef(SG_All.Cells[0,i],1)].Jaartal;
      SG_Play.Cells[6,rij+1]:=SG_All.Cells[0,i];
    end;
  AutoSizePlayColumns; SG_Play.ColWidths[6]:=1;
  if Settings.Shuffle then
  begin
   i2:=1;
   Setlength(OrigineleVolgorde,SG_Play.RowCount); Application.ProcessMessages;
   for i:=old_aantal+1 to SG_Play.RowCount-1 do
   begin
     OrigineleVolgorde[i]:=strtoint(SG_Play.Cells[6,rij+i2]);
     inc(i2);
   end;
  end;
  SongsInPlayingQueue:=SG_Play.RowCount-1;
end;


procedure TForm1.MI_SGALL_AddToEndClick(Sender: TObject);
var old_aantal, aantal, i: longint;
begin
  aantal:=SG_Play.RowCount; old_aantal:=SG_Play.RowCount;
  For i:=1 to SG_all.RowCount-1 do
    if IsCellSelected(SG_All,1,i) then
    begin
      inc(aantal);
      SG_Play.RowCount:=aantal;
      SG_Play.Cells[1,aantal-1]:=SG_All.Cells[1,i];
      SG_Play.Cells[2,aantal-1]:=SG_All.Cells[2,i];
      SG_Play.Cells[3,aantal-1]:=SG_All.Cells[3,i];
      SG_Play.Cells[4,aantal-1]:=SG_All.Cells[4,i];
      SG_Play.Cells[5,aantal-1]:=Liedjes[strtointdef(SG_All.Cells[0,i],1)].Jaartal;
      SG_Play.Cells[6,aantal-1]:=SG_All.Cells[0,i];
    end;
  AutoSizePlayColumns; SG_Play.ColWidths[6]:=1;
  PageControl2.ActivePageIndex:=1;
  if Settings.Shuffle then
  begin
   Setlength(OrigineleVolgorde,SG_Play.RowCount); Application.ProcessMessages;
   for i:=old_aantal to SG_Play.RowCount-1 do OrigineleVolgorde[i]:=strtoint(SG_Play.Cells[6,i]);
  end;
  SongsInPlayingQueue:=SG_Play.RowCount-1;
end;

procedure TForm1.MI_SGALL_AddToBeginClick(Sender: TObject);
var old_aantal, aantal, i, i2: longint;
begin
  old_aantal:=SG_Play.RowCount-1;
  For i:=SG_all.RowCount-1 downto 1do
    if IsCellSelected(SG_All,1,i) then
    begin
      SG_Play.InsertColRow(False,1);
      SG_Play.Cells[1,1]:=SG_All.Cells[1,i];
      SG_Play.Cells[2,1]:=SG_All.Cells[2,i];
      SG_Play.Cells[3,1]:=SG_All.Cells[3,i];
      SG_Play.Cells[4,1]:=SG_All.Cells[4,i];
      SG_Play.Cells[5,1]:=Liedjes[strtointdef(SG_All.Cells[0,i],1)].Jaartal;
      SG_Play.Cells[6,1]:=SG_All.Cells[0,i];
      inc(songrowplaying);
    end;
  aantal:=SG_Play.RowCount-1;
  AutoSizePlayColumns; SG_Play.ColWidths[6]:=1;
  PageControl2.ActivePageIndex:=1;
  if Settings.Shuffle then
  begin
   i2:=0;
   Setlength(OrigineleVolgorde,SG_Play.RowCount); Application.ProcessMessages;
   for i:=aantal downto aantal-old_aantal+1 do
   begin
     OrigineleVolgorde[i]:=OrigineleVolgorde[old_aantal-i2];
     inc(i2);
   end;
   for i:=1 to aantal-old_aantal do OrigineleVolgorde[i]:=strtoint(SG_Play.Cells[6,i]);
  end;
  SongsInPlayingQueue:=SG_Play.RowCount-1;
end;

procedure TForm1.MI_SGALL_AddAllClick(Sender: TObject);
var aantal, i, old_aantal: longint;
begin
  aantal:=SG_Play.RowCount; old_aantal:=SG_Play.RowCount;
  SG_Play.RowCount:=SG_Play.RowCount+SG_All.RowCount-1;
  For i:=1 to SG_all.RowCount-1 do
    begin
      inc(aantal);
      SG_Play.Cells[1,aantal-1]:=SG_All.Cells[1,i];
      SG_Play.Cells[2,aantal-1]:=SG_All.Cells[2,i];
      SG_Play.Cells[3,aantal-1]:=SG_All.Cells[3,i];
      SG_Play.Cells[4,aantal-1]:=SG_All.Cells[4,i];
      SG_Play.Cells[5,aantal-1]:=Liedjes[strtointdef(SG_All.Cells[0,i],1)].Jaartal;
      SG_Play.Cells[6,aantal-1]:=SG_All.Cells[0,i];
    end;
  AutoSizePlayColumns;
  if Settings.Shuffle then
  begin
   Setlength(OrigineleVolgorde,SG_Play.RowCount); Application.ProcessMessages;
   for i:=old_aantal to SG_Play.RowCount-1 do OrigineleVolgorde[i]:=strtoint(SG_Play.Cells[6,i]);
  end;
  SongsInPlayingQueue:=SG_Play.RowCount-1;
end;

procedure TForm1.MI_SGAll_Play2Click(Sender: TObject);
begin
  SB_StopClick(Self);
  LiedjesTemp:=Liedjes[strtoint(SG_All.Cells[0,SG_All.Row])];
  PlayFromFile(LiedjesTemp.Pad+LiedjesTemp.Bestandsnaam);
  Stream:=1;
end;

procedure TForm1.MI_SGAll_Play1Click(Sender: TObject);
var aantal: longint;
begin
  aantal:=SG_Play.RowCount;
  inc(aantal); SG_Play.RowCount:=aantal;
  SG_Play.Cells[1,aantal-1]:=SG_All.Cells[1,SG_All.Row];
  SG_Play.Cells[2,aantal-1]:=SG_All.Cells[2,SG_All.Row];
  SG_Play.Cells[3,aantal-1]:=SG_All.Cells[3,SG_All.Row];
  SG_Play.Cells[4,aantal-1]:=SG_All.Cells[4,SG_All.Row];
  SG_Play.Cells[5,aantal-1]:=Liedjes[strtointdef(SG_All.Cells[0,SG_All.Row],1)].Jaartal;
  SG_Play.Cells[6,aantal-1]:=SG_All.Cells[0,SG_All.Row];
  SG_Play.Row:=aantal-1; SG_PlayDblClick(Self);
  AutoSizePlayColumns; SG_Play.ColWidths[6]:=1;
end;

procedure TForm1.MI_PlayCDfromCoverClick(Sender: TObject);
begin
  ThumbControl1DblClick(Self);
end;


procedure TForm1.GetSongsFromAlbum(Artist, Album: String; SingleArtist: Boolean);
var max, i2, ActiveIndex, j, i: integer;
    tempartiest, tempalbum: String;
    toevoegen: Boolean;
Begin
  FilesFound.Clear;
  if ThumbControl1.ImageLoaderManager.CountItems>0 then
  begin
    max := maxsongs - 1;  i2:=0;
    ActiveIndex:=strtointdef(ThumbControl1.ImageLoaderManager.ActiveItem.DataString,0);
    if ActiveIndex<0 then   (*if -1 then Song without Album*)
    begin
      if (not CB_ShowAllThumbs.Checked) and (LB_Artist1.ItemIndex>0) then
      begin
        for j := 0 to LB_Artist1.Count - 1 do
        begin
          if not LB_Artist1.Selected[j] then continue;
          tempartiest := Upcase(LB_Artist1.Items[j]);
          for i := 0 to max do
          begin
            if Liedjes[i].CD='' then if upcase(Liedjes[i].Artiest) = tempartiest then if not Liedjes[i].Deleted then
            begin
               FilesFound.Add(Inttostr(i));
            end;
          end;
        end;
      end
      else
      begin
        for i := 0 to max do
        begin
          if Liedjes[i].CD='' then if not Liedjes[i].Deleted then
            begin
              FilesFound.Add(Inttostr(i));
            end;
        end;
      end;
      exit;
    end;

    tempalbum:=upcase(Album);
    tempartiest:=upcase(Artist);
  for i := 0 to max do
  begin
    if upcase(Liedjes[i].CD)=tempAlbum (*then if upcase(Liedjes[i].Artiest) = tempartiest*) then if not Liedjes[i].Deleted then
          begin
            toevoegen:=true;
            if (tempalbum='GREATEST HITS') or (tempalbum='ONDERWEG') or (tempalbum='HET BESTE VAN') or (tempalbum='HITS') then
              if upcase(Liedjes[i].Artiest) = tempartiest then toevoegen:=true
                                                          else toevoegen:=false;
            if toevoegen then
            begin
              FilesFound.Add(Inttostr(i));
            end;
          end;
    end;
  end;

end;

procedure TForm1.MI_DeleteAlbumClick(Sender: TObject);
var wissen, AllChecked: Boolean;
    artiest, album: string;
    i, ActiveIndex: integer;
begin
  ActiveIndex:=strtointdef(ThumbControl1.ImageLoaderManager.ActiveItem.DataString,0);
  artiest:=upcase(Liedjes[ActiveIndex].Artiest);
  album:=upcase(Liedjes[ActiveIndex].CD);
  GetSongsFromAlbum(Artiest, Album, True);
  For i:=0 To FilesFound.Count-1 do
  begin
    FormShowMyDialog.CheckListBox1.Items.Add(Liedjes[strtoint(FilesFound.Strings[i])].Artiest+' - '+Liedjes[strtoint(FilesFound.Strings[i])].Titel+' ('+Liedjes[strtoint(FilesFound.Strings[i])].Pad+Liedjes[strtoint(FilesFound.Strings[i])].Bestandsnaam+')');
    FormShowMyDialog.CheckListBox1.Checked[i]:=true;
  end;

  wissen:=FormShowMyDialog.ShowWith(Vertaal('WARNING'),upcase(Liedjes[strtointdef(ThumbControl1.ImageLoaderManager.ActiveItem.DataString,0)].CD),'',Vertaal('ARE YOU SURE YOU WANT TO DELETE THIS ALBUM?'),Vertaal('YES'),Vertaal('NO'), True);
  if wissen then
  begin
    AllChecked:=True;
    For i:=0 To FilesFound.Count-1 do
    begin
      If FormShowMyDialog.CheckListBox1.Checked[i] then
      begin
        DeleteFile(Liedjes[strtoint(FilesFound.Strings[i])].Pad+Liedjes[strtoint(FilesFound.Strings[i])].Bestandsnaam);
        Liedjes[strtoint(FilesFound.Strings[i])].Deleted:=True;
      end
      else AllChecked:=false;
    end;
    If AllChecked then
    begin
      CB_ShowAllThumbsChange(Self);
    end;
  end;
  FilesFound.Clear;
  FormShowMyDialog.CheckListBox1.Items.Clear;
end;

procedure TForm1.MenuItem135Click(Sender: TObject);
var artiest, album: string;
    old_aantal, i, i3, aantal, temp, ActiveIndex: longint;
begin
  if ThumbControl1.ImageLoaderManager.CountItems>0 then
  begin
    ActiveIndex:=strtointdef(ThumbControl1.ImageLoaderManager.ActiveItem.DataString,0);
    artiest:=upcase(Liedjes[ActiveIndex].Artiest);
    album:=upcase(Liedjes[ActiveIndex].CD);
    GetSongsFromAlbum(Artiest, Album, True);
    old_aantal:=SG_Play.RowCount-1;
    for i:=0 to FilesFound.Count-1 do
     begin
       temp:=strtoint(FilesFound.Strings[i]);
       SG_Play.RowCount:=SG_Play.RowCount+1;
       i3:=SG_Play.RowCount-1;
       SG_Play.Cells[1,i3]:=Liedjes[temp].Artiest;
       SG_Play.Cells[2,i3]:=inttostr(Liedjes[temp].Track);
       SG_Play.Cells[3,i3]:=Liedjes[temp].Titel;
       SG_Play.Cells[4,i3]:=Liedjes[temp].Artiest;
       SG_Play.Cells[5,i3]:=Liedjes[temp].Jaartal;
       SG_Play.Cells[6,i3]:=FilesFound.Strings[i];
     end;
    aantal:=SG_Play.RowCount-1; AutoSizePlayColumns; SG_Play.ColWidths[6]:=1;
    if Settings.Shuffle then
    begin
     Setlength(OrigineleVolgorde,SG_Play.RowCount); Application.ProcessMessages;
     for i:=old_aantal+1 to aantal do OrigineleVolgorde[i]:=strtoint(SG_Play.Cells[6,i]);
    end;
    SongsInPlayingQueue:=SG_Play.RowCount-1;
  end;
end;

procedure TForm1.Mi_AddBeginQueueClick(Sender: TObject);
var artiest, album: string;
    old_aantal, i, i2, aantal, ActiveIndex: longint;
    temp: longint;
begin
  if ThumbControl1.ImageLoaderManager.CountItems>0 then
  begin
    ActiveIndex:=strtointdef(ThumbControl1.ImageLoaderManager.ActiveItem.DataString,0);
    artiest:=upcase(Liedjes[ActiveIndex].Artiest);
    album:=upcase(Liedjes[ActiveIndex].CD);
    GetSongsFromAlbum(Artiest, Album, True);
    i2:=1; old_aantal:=SG_Play.RowCount-1;
    SG_Play.BeginUpdate;
    For i:=0 To FilesFound.Count-1 do
    begin
      temp:=strtoint(FilesFound.Strings[i]);
      SG_Play.InsertColRow(False,i2);
      SG_Play.Cells[1,i2]:=Liedjes[temp].Artiest;
      SG_Play.Cells[2,i2]:=inttostr(Liedjes[temp].Track);
      SG_Play.Cells[3,i2]:=Liedjes[temp].Titel;
      SG_Play.Cells[4,i2]:=Liedjes[temp].Artiest;
      SG_Play.Cells[5,i2]:=Liedjes[temp].Jaartal;
      SG_Play.Cells[6,i2]:=FilesFound.Strings[i];
      inc(i2);
    end;
    SG_Play.EndUpdate(true);
    songrowplaying:=songrowplaying+i2-1;
    aantal:=SG_Play.RowCount-1; AutoSizePlayColumns; SG_Play.ColWidths[6]:=1;
    if Settings.Shuffle then
    begin
     i2:=0;
     Setlength(OrigineleVolgorde,SG_Play.RowCount); Application.ProcessMessages;
     for i:=aantal downto aantal-old_aantal+1 do
     begin
       OrigineleVolgorde[i]:=OrigineleVolgorde[old_aantal-i2];
       inc(i2);
     end;
     for i:=1 to aantal-old_aantal do OrigineleVolgorde[i]:=strtoint(SG_Play.Cells[6,i]);
    end;
    SongsInPlayingQueue:=SG_Play.RowCount-1;
  end;
end;

procedure TForm1.MI_AddPlayingQueueClick(Sender: TObject);
var artiest, album: string;
    old_aantal, i, i2, aantal, start, temp: longint;
begin
  if ThumbControl1.ImageLoaderManager.CountItems>0 then
  begin
    artiest:=upcase(Liedjes[strtointdef(ThumbControl1.ImageLoaderManager.ActiveItem.DataString,0)].Artiest);
    album:=upcase(Liedjes[strtointdef(ThumbControl1.ImageLoaderManager.ActiveItem.DataString,0)].CD);
    GetSongsFromAlbum(Artiest, Album, True);
    old_aantal:=SG_Play.RowCount-1; start:=songrowplaying;
    For i:=0 To FilesFound.Count-1 do
    begin
      temp:=strtoint(FilesFound.Strings[i]);
      SG_Play.InsertColRow(False,start+i+1);
      SG_Play.Cells[1,start+i+1]:=Liedjes[temp].Artiest;
      SG_Play.Cells[2,start+i+1]:=inttostr(Liedjes[temp].Track);
      SG_Play.Cells[3,start+i+1]:=Liedjes[temp].Titel;
      SG_Play.Cells[4,start+i+1]:=Liedjes[temp].Artiest;
      SG_Play.Cells[5,start+i+1]:=Liedjes[temp].Jaartal;
      SG_Play.Cells[6,start+i+1]:=FilesFound.Strings[i];
    end;
    aantal:=SG_Play.RowCount-1; AutoSizePlayColumns; SG_Play.ColWidths[6]:=1;

    if Settings.Shuffle then
    begin
     i2:=0;
     Setlength(OrigineleVolgorde,SG_Play.RowCount); Application.ProcessMessages;
     for i:=aantal downto aantal-old_aantal+start do
     begin
       OrigineleVolgorde[i]:=OrigineleVolgorde[old_aantal-i2];
       inc(i2);
     end;
     for i:=start to aantal-old_aantal+start do OrigineleVolgorde[i+start]:=strtoint(SG_Play.Cells[6,i+start]);
    end;
    SongsInPlayingQueue:=SG_Play.RowCount-1;
  end;
end;

procedure TForm1.MI_TagCDFromCoverClick(Sender: TObject);
begin
  LB_Albums1.ItemIndex:=LB_Albums1.Items.IndexOf(Liedjes[strtointdef(ThumbControl1.ImageLoaderManager.ActiveItem.DataString,0)].CD);
  if LB_Albums1.ItemIndex>0 then
  begin
    LB_Albums1Click(Self);
    Application.ProcessMessages;
    LB_Artists2.ItemIndex:=LB_Artists2.Items.IndexOf(Liedjes[strtointdef(ThumbControl1.ImageLoaderManager.ActiveItem.DataString,0)].Artiest);
    LB_Artists2Click(Self)
  end
                             else
  begin
    LB_Artist1.ItemIndex:=LB_Artist1.Items.IndexOf(Liedjes[strtointdef(ThumbControl1.ImageLoaderManager.ActiveItem.DataString,0)].Artiest);
    LB_Artist1Clicked;
  end;
  if SG_All.RowCount>1 then MI_SGALL_TaggerClick(MI_TagAlbum2);
end;

procedure TForm1.ClearCDCover;
begin
  Form1.ImageCDCover.Picture.Bitmap:=FormDetails.Image2.Picture.Bitmap;
  Form1.ImageCDCoverLyric.Picture.Clear;
  FormCoverPlayer.ImageCDCover.Picture.Bitmap:=Form1.ImageCDCover.Picture.Bitmap;
  FormCoverPlayer.ImageCDCoverReflection.Picture.Clear;
  Form1.Splitter4.Top:=26;
end;

procedure TForm1.MenuItem88Click(Sender: TObject);
begin
  Settings.CDCoverInfo := not settings.CDCoverInfo;

  if Settings.CDCoverInfo then MenuItem88.Caption:=Vertaal('Do not show artwork')
                          else MenuItem88.Caption:=Vertaal('Show CD artwork');

  if not Settings.CDCoverInfo then ClearCDCover
  else
  begin
    Form1.ImageCDCover.Picture.Bitmap:=FormCoverPlayer.ImageCdCover.Picture.Bitmap;
    if not Settings.CDCoverLyrics then
    begin
      Form1.ImageCDCoverLyric.Picture.Bitmap.Clear; Form1.Splitter4.Top:=26;
    end
                                  else
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
  end;          ;
end;

procedure TForm1.MI_VU_Active4Click(Sender: TObject);
begin
  VU_Settings.Active:=4;
  MI_VU_Active4.Checked:=True;
end;

procedure TForm1.MI_CopyToFolder1Click(Sender: TObject);
var welke, i: integer;
begin
  if SelectDirectoryDialog1.Execute then
  begin
   for i:=1 to SG_All.RowCount-1 do
   begin;
    welke:=strtoint(SG_All.Cells[0,i]);
    SaveDownloadto.Add(SelectDirectoryDialog1.FileName);
    labelPodcast.Caption:=inttostr(SaveDownLoadTo.Count);
    FormDownLoadOverView.ListBox1.Items.Add(Liedjes[welke].Pad+Liedjes[welke].Bestandsnaam);
   end;
   if not downloadpodcast then Thread1:=TDownloadPodCastThread.Create(False);
  end;
end;

procedure TForm1.PageControl1Change(Sender: TObject);
begin

end;

procedure TForm1.PageControl2Change(Sender: TObject);
begin
  If PageControl2.PageIndex=7 then ThumbControl1.SetFocus;
end;

procedure TForm1.PM_SGAllPopup(Sender: TObject);
begin
  songchosen:=strtoint(SG_All.Cells[0,SG_All.Row]);
end;


procedure TForm1.ProgressBarSpeedMouseWheelDown(Sender: TObject;
  Shift: TShiftState; MousePos: TPoint; var Handled: Boolean);
begin
  ProgressBarSpeed.Value:=ProgressBarSpeed.Value-1;
  {$if not defined(HAIKU)}
  case stream of
    1: BASS_ChannelSetAttribute(Song_Stream1, BASS_ATTRIB_TEMPO, ProgressBarSpeed.Value);
    2: BASS_ChannelSetAttribute(Song_Stream2, BASS_ATTRIB_TEMPO, ProgressBarSpeed.Value);
    4: BASS_ChannelSetAttribute(ReverseStream, BASS_ATTRIB_TEMPO, ProgressBarSpeed.Value);
  end;
  {$ifend}
  Label35.Caption:=inttostr(ProgressBarSpeed.Value+100);
end;

procedure TForm1.ProgressBarSpeedMouseWheelUp(Sender: TObject;
  Shift: TShiftState; MousePos: TPoint; var Handled: Boolean);
begin
 ProgressBarSpeed.Value:=ProgressBarSpeed.Value+1;
 {$if not defined(HAIKU)}
  case stream of
    1: BASS_ChannelSetAttribute(Song_Stream1, BASS_ATTRIB_TEMPO, ProgressBarSpeed.Value);
    2: BASS_ChannelSetAttribute(Song_Stream2, BASS_ATTRIB_TEMPO, ProgressBarSpeed.Value);
    4: BASS_ChannelSetAttribute(ReverseStream, BASS_ATTRIB_TEMPO, ProgressBarSpeed.Value);
  end;
  {$ifend}
  Label35.Caption:=inttostr(ProgressBarSpeed.Value+100);
end;

procedure TForm1.BitBtn1Click(Sender: TObject);
var Filevar: TextFile;
    lijn, url, title: string;
    i: integer;
    gevonden: boolean;
begin
  if DownloadFile('http://www.xixmusicplayer.org/download/podcastnew', Tempdir+DirectorySeparator+'podcastnew.tmp') then
  begin
    AssignFile(Filevar,Tempdir+DirectorySeparator+'podcastnew.tmp');
    Reset(Filevar);
    Repeat
      Readln(Filevar,lijn);
      if length(lijn)>1 then
      begin
        title:=Copy(lijn,1,pos(';',lijn)-1);
        url:=Copy(lijn,length(title)+2,length(lijn)-length(title));
        i:=0; gevonden:=false;
        repeat
          if url=SG_Podcast.Cells[1,i] then gevonden:=true;
          inc(i);
        until i=SG_Podcast.RowCount;
        if not gevonden then
        begin
          SG_Podcast.RowCount:=SG_Podcast.RowCount+1;
          SG_Podcast.Cells[0,SG_Podcast.RowCount-1]:=title;
          SG_Podcast.Cells[1,SG_Podcast.RowCount-1]:=url;
        end;
      end;
    until eof(Filevar);
    CloseFile(Filevar);
    DeleteFile(Tempdir+DirectorySeparator+'podcastnew.tmp');
  end;
  SG_Podcast.AutoSizeColumns; SB_PodcastSaveClick(Self);
end;

procedure TForm1.CB_GenreRadio1Change(Sender: TObject);
begin
  LB_GenreRadio1.Enabled:=CB_GenreRadio1.Checked;
  Speedbutton34Click(Self);
end;

procedure TForm1.CB_Land1Change(Sender: TObject);
begin
  LB_Land1.Enabled:=CB_Land1.Checked;
end;

procedure TForm1.CB_LibraryChange(Sender: TObject);
var i: longint;
    LiedjeTemp: TSong;
    EnableTimer: Boolean;
begin
 if (not firsttime) then
 begin
  If Timer1.Enabled then
  begin
    Timer1.Enabled:=False;
    EnableTimer:=True;
  end
  else EnableTimer:=false;

  ReadFolders;

  FormSplash.Show; FormSplash.Label1.Caption:='Reloading ...';

  if SG_Play.RowCount>1 then
  begin
    SG_Play.MoveColRow(false,songrowplaying,1);
    LiedjeTemp:=Liedjes[strtoint(SG_Play.Cells[6,1])];
    if SG_Play.RowCount>2 then for i:=SG_Play.RowCount downto 3 do SG_Play.DeleteRow(i-1);
  end;
  Form1.LB_Artist1.Items.Clear; Form1.LB_Albums2.Items.Clear;
  Form1.LB_Albums1.Items.Clear;  internalsongs:=0;
  Liedjes:=nil;DB_Liedjes:=nil; FilesFound.Clear; max_records:=0;
  Form1.ReadDatabase;
  try
    Form1.GetAllMusicFiles;
  except
    ShowMessage('Internal Error: GetAllMusicFiles');
  end;
  Form1.GetMusicDetails;
  FillVirtualFSTree;

  if SG_Play.RowCount>1 then
  begin
    Liedjes[maxsongs]:=LiedjeTemp;
    SG_Play.Cells[6,1]:=inttostr(maxsongs); songplaying:=maxsongs;
  end;
  if LB_Artist1.Count>0 then
  begin
    LB_Artist1.ItemIndex:=0; Lb_Artist1Click(Self);
  end;
  FormSplash.Hide;
  if EnableTimer then Timer1.Enabled:=True;
 end;
end;

procedure TForm1.CB_LibrarySelect(Sender: TObject);
begin
  if not firsttime then Settings.ChosenLibrary:=CB_Library.ItemIndex;
end;

procedure TForm1.CB_SubDirsChange(Sender: TObject);
begin
  TV_VFSSelectionChanged(Self);
end;

procedure TForm1.Edit1KeyPress(Sender: TObject; var Key: char);
begin
   if key=#13 then Speedbutton18Click(Self);
end;

procedure TForm1.Edit3KeyPress(Sender: TObject; var Key: char);
begin
  if key=#13 then Speedbutton34Click(Self);
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
 (* Tracksfound.Free;
  FilesFound.Free;
  M3uFilesfound.Free;
  SaveDownloadto.Free;
  LyricsNotFound.Free;
  Settings.Free;
  PlayListsFound.Free; *)
end;

procedure TForm1.Image13DblClick(Sender: TObject);
begin
  FormCoverPlayer.ShowModal;
end;

procedure TForm1.Image1Resize(Sender: TObject);
begin
  LB_Artiest.Left:=Trackbar2.Left+round(Trackbar2.Width/2)-round((LB_Artiest.Width+LB_CD.Width)/2)+15;
  LB_Artiest.Constraints.MaxWidth:=TrackBar2.Width;
end;

procedure TForm1.ImageCdCoverDblClick(Sender: TObject);
begin
  FormCoverPlayer.ShowModal;
end;

end.

