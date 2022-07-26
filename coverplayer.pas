unit coverplayer;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, Buttons,
  ExtCtrls, StdCtrls, ActnList, LCLType, Menus, BGRABitmap, BGRABitmapTypes,
 {$if not defined(HAIKU)}  Bass,{$ifend}  BGRAFlashProgressBar, ueled, types, WallOfTiles, wcButtons,
  BGRAGraphicControl, BGRASpeedButton, BGRAImageList;

type

  { TFormCoverPlayer }

  TFormCoverPlayer = class(TForm)
    Action1: TAction;
    Action0: TAction;
    ActionWider: TAction;
    ActionCloser: TAction;
    ActionRepeat: TAction;
    ActionShuffle: TAction;
    ActionChoseMp3: TAction;
    Action2: TAction;
    Action3: TAction;
    Action4: TAction;
    Action5: TAction;
    Action6: TAction;
    Action7: TAction;
    Action8: TAction;
    Action9: TAction;
    ActionChoseRadio: TAction;
    ActionFontSmaller: TAction;
    ActionFontBigger: TAction;
    ActionCDCover: TAction;
    ActionTime: TAction;
    ActionProgress: TAction;
    ActionLeave: TAction;
    ActionPauze: TAction;
    ActionPrev: TAction;
    ActionNext: TAction;
    ActionLyrics: TAction;
    ActionList1: TActionList;
    Bevel1: TBevel;
    Bevel2: TBevel;
    BGRAImageList1: TBGRAImageList;
    ImageBottom: TImage;
    ImageCDCoverReflection: TImage;
    ImageCDCover: TImage;
    BCLabel1: TLabel;
    BCLabel2: TLabel;
    BCLabelTime: TLabel;
    BCLabelTotalTime: TLabel;
    LabelNowPlaying: TLabel;
    LabelLyrics: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label2: TLabel;
    Label9: TLabel;
    MenuItem1: TMenuItem;
    MenuItem2: TMenuItem;
    MenuItem3: TMenuItem;
    MenuItem4: TMenuItem;
    PaintBox1: TPaintBox;
    PopupMenu1: TPopupMenu;
    ProgressBar1: TBGRAFlashProgressBar;
    ImageNext: TImage;
    ImagePrevious: TImage;
    ImagePauze: TImage;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    uELED1: TuELED;
    uELED10: TuELED;
    uELED11: TuELED;
    uELED12: TuELED;
    uELED13: TuELED;
    uELED14: TuELED;
    uELED15: TuELED;
    uELED16: TuELED;
    uELED17: TuELED;
    uELED18: TuELED;
    uELED19: TuELED;
    uELED2: TuELED;
    uELED20: TuELED;
    uELED21: TuELED;
    uELED22: TuELED;
    uELED23: TuELED;
    uELED24: TuELED;
    uELED3: TuELED;
    uELED4: TuELED;
    uELED5: TuELED;
    uELED6: TuELED;
    uELED7: TuELED;
    uELED8: TuELED;
    uELED9: TuELED;
    procedure Action1Execute(Sender: TObject);
    procedure Action2Execute(Sender: TObject);
    procedure Action3Execute(Sender: TObject);
    procedure Action4Execute(Sender: TObject);
    procedure Action5Execute(Sender: TObject);
    procedure Action6Execute(Sender: TObject);
    procedure Action7Execute(Sender: TObject);
    procedure Action8Execute(Sender: TObject);
    procedure Action9Execute(Sender: TObject);
    procedure ActionCDCoverExecute(Sender: TObject);
    procedure ActionChoseMp3Execute(Sender: TObject);
    procedure ActionChoseRadioExecute(Sender: TObject);
    procedure ActionCloserExecute(Sender: TObject);
    procedure ActionFontBiggerExecute(Sender: TObject);
    procedure ActionFontSmallerExecute(Sender: TObject);
    procedure ActionLeaveExecute(Sender: TObject);
    procedure ActionLyricsExecute(Sender: TObject);
    procedure ActionNextExecute(Sender: TObject);
    procedure ActionPauzeExecute(Sender: TObject);
    procedure ActionPrevExecute(Sender: TObject);
    procedure ActionProgressExecute(Sender: TObject);
    procedure ActionRepeatExecute(Sender: TObject);
    procedure ActionShuffleExecute(Sender: TObject);
    procedure ActionTimeExecute(Sender: TObject);
    procedure ActionWiderExecute(Sender: TObject);
    procedure BCLabel1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Image1DblClick(Sender: TObject);
    procedure ImageCDCoverClick(Sender: TObject);
    procedure ImageCDCoverPictureChanged(Sender: TObject);
    procedure ImageNextClick(Sender: TObject);
    procedure ImageNextMouseEnter(Sender: TObject);
    procedure ImageNextMouseLeave(Sender: TObject);
    procedure ImagePreviousClick(Sender: TObject);
    procedure ImagePreviousMouseEnter(Sender: TObject);
    procedure ImagePreviousMouseLeave(Sender: TObject);
    procedure Label4MouseEnter(Sender: TObject);
    procedure Label4MouseLeave(Sender: TObject);
    procedure Label6MouseEnter(Sender: TObject);
    procedure Label6MouseLeave(Sender: TObject);
    procedure MenuItem2Click(Sender: TObject);
    procedure MenuItem3Click(Sender: TObject);
    procedure MenuItem4Click(Sender: TObject);
    procedure PaintBox1DblClick(Sender: TObject);
    procedure PaintBox1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure PaintBox1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure PaintBox1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure ProgressBar1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure ProgressBar1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure ProgressBar1MouseWheel(Sender: TObject; Shift: TShiftState;
      WheelDelta: Integer; MousePos: TPoint; var Handled: Boolean);
    procedure PlayButtonOnClick(Sender: TObject);
    procedure ListButtonOnClick(Sender: TObject);
    procedure UpButtonOnClick(Sender: TObject);
    procedure DownButtonOnClick(Sender: TObject);
    procedure FillPage;
    procedure MenuButtonSongListClick(Sender: TObject);
  private
    { private declarations }
    Wall: TWallOfTiles;
    PlayButton, NextButton, PreviousButton, BackButton, ShuffleButton, RepeatButton, VolumeButton: TWCButton;
    AlbumLabel: TLabel;
  public
    { public declarations }
  end;

var
  FormCoverPlayer: TFormCoverPlayer;

implementation

uses hoofd;

var
  StartOfPushX, StartOfPushY, ButtonHeight: Integer;
  page: Integer;
  SongListPanel: TBGRAGraphicControl;
  UpButton, DownButton, ListButton, MenuButton: TBGRASpeedButton;
  ButtonList: TList;
  SongList: TStringList;
  MaxButtons, MaxPages, ListItemSelected: integer;
  Albummode: Byte;

{$R *.lfm}

{ TFormCoverPlayer }


procedure TFormCoverPlayer.FormShow(Sender: TObject);
var ledsize: byte;
begin
  Top:=0;Left:=0;StartOfPushX:=0;StartOfPushY:=0;
  Width:=Screen.Width;Height:=Screen.Height;

  FormCoverPlayer.BCLabel2.Caption:=Form1.LB_Titel.Caption;
  FormCoverPlayer.BCLabel1.Caption:=Form1.LB_Artiest.Caption;
  FormCoverPlayer.Label9.Caption:=Form1.LB_CD.Caption;

  if CoverModePlayer=1 then
  begin
   ImageBottom.Width:=Screen.Width; ImageBottom.Height:=round(Screen.Height/3.5);
   if Screen.Width>1920 then ImageBottom.Stretch:=False
                        else ImageBottom.Stretch:=True;

  (* {$IFDEF LCLGTK2}
    ImageBottom.Stretch:=False; ImageBottom.Width:=1920;
    if Screen.Width>1920 then
    begin
      ImageGTK2.Visible:=True; imageGTK2.width:=1920;
      ImageGTK2.Picture.Bitmap:=ImageBottom.Image;
    end;
   {$ENDIF}  *)
   ImageCDCover.Top:=round(Screen.Height/4);  ImageCDCover.Left:=round(Screen.Width/4.8);
   ImageCDCover.Width:=Round(Screen.Width/2.8); ImageCDCover.Height:=ImageCDCover.Width;
   Label2.Top:=round(Screen.Height/3*2.1);

   ledsize:= round(screen.Height/28);
   ueled13.Left:=width-round(Width/10); ueled13.Top:=round(height/1.40);
   ueled13.Height:=ledsize; ueled13.Width:=ledsize;
   ueled12.Height:=ledsize; ueled12.Width:=ledsize;
   ueled11.Height:=ledsize; ueled11.Width:=ledsize;
   ueled10.Height:=ledsize; ueled10.Width:=ledsize;
   ueled9.Height:=ledsize; ueled9.Width:=ledsize;
   ueled8.Height:=ledsize; ueled8.Width:=ledsize;
   ueled7.Height:=ledsize; ueled7.Width:=ledsize;
   ueled6.Height:=ledsize; ueled6.Width:=ledsize;
   ueled5.Height:=ledsize; ueled5.Width:=ledsize;
   ueled4.Height:=ledsize; ueled4.Width:=ledsize;
   ueled3.Height:=ledsize; ueled3.Width:=ledsize;
   ueled2.Height:=ledsize; ueled2.Width:=ledsize;
   ueled1.Height:=ledsize; ueled1.Width:=ledsize;
   ueled14.Height:=ledsize; ueled14.Width:=ledsize;
   ueled15.Height:=ledsize; ueled15.Width:=ledsize;
   ueled16.Height:=ledsize; ueled16.Width:=ledsize;
   ueled17.Height:=ledsize; ueled17.Width:=ledsize;
   ueled18.Height:=ledsize; ueled18.Width:=ledsize;
   ueled19.Height:=ledsize; ueled19.Width:=ledsize;
   ueled20.Height:=ledsize; ueled20.Width:=ledsize;
   ueled21.Height:=ledsize; ueled21.Width:=ledsize;
   ueled22.Height:=ledsize; ueled22.Width:=ledsize;
   ueled23.Height:=ledsize; ueled23.Width:=ledsize;
   ueled24.Height:=ledsize; ueled24.Width:=ledsize;

   IsMediaModeOn:=True;
   Form1.UpdateMediaMode;
   if stream>9 then
   begin
     BCLabelTotalTime.Caption:='';BCLabelTime.Visible:=True;
     if stream=11 then ProgressBar1.Visible:=True;
   end
              else
   begin
     ProgressBar1.Visible:=True;
     BCLabelTotalTime.Visible:=True;BCLabelTime.Visible:=True;
   end;
   ImageCDCoverReflection.Height:=ImageCDCover.Height;
   ImageCDCoverPictureChanged(Self);
   BCLabel1.Top:=ImageCDCover.Top+40;
   BCLabel1.Left:=ImageCDCover.Left+ImageCDCover.Width+8;
   BCLabel2.Left:=BCLabel1.Left;
   BCLabelTime.Top:=Height-30; BCLabelTotalTime.Top:=BCLabelTime.Top;
   LabelNowPlaying.Font.Height:=LabelNowPlaying.Height-18;
   ProgressBar1.Left:=round(width/3); ProgressBar1.Width:=ProgressBar1.Left;
   LabelLyrics.Caption:=Form1.MemoLyrics.Text;
 end;
 IsMediaModeOn:=True;
end;

procedure TFormCoverPlayer.ActionLyricsExecute(Sender: TObject);
begin
  LabelLyrics.Visible:=not LabelLyrics.Visible;

  if LabelLyrics.Visible then
  begin
    ImageCDCover.Top:=round(Screen.Height/4);  ImageCDCover.Left:=round(Screen.Width/4.8);
    ImageCDCover.Width:=Round(Screen.Width/2.8); ImageCDCover.Height:=ImageCDCover.Width;
  end
  else
  begin
    ImageCDCover.Top:=round(Screen.Height/4);  ImageCDCover.Left:=round(Screen.Width/6);
    ImageCDCover.Width:=Round(Screen.Width/2.8); ImageCDCover.Height:=ImageCDCover.Width;
  end;

end;

procedure TFormCoverPlayer.ActionLeaveExecute(Sender: TObject);
begin
  if CoverModePlayer=3 then If Page<>-1 then ImageCDCoverClick(Self);
  IsMediaModeOn:=False; Form1.ActiveDefaultControlChanged(Form1.SB_Play);
  FormCoverPlayer.Close;
end;

procedure TFormCoverPlayer.ActionCDCoverExecute(Sender: TObject);
begin
  ImageCDCover.Visible:=not ImageCDCover.Visible;
  ImageCDCoverReflection.Visible:=not ImageCDCoverReflection.Visible;
end;

procedure TFormCoverPlayer.ActionChoseMp3Execute(Sender: TObject);
begin
  Form1.ActionChoseMP3Execute(Self);
end;

procedure TFormCoverPlayer.Action1Execute(Sender: TObject);
begin
  if (Stream=10) and (Form1.StringgridPresets.RowCount>1) then
  begin
    Form1.PageControl1.ActivePageIndex:=4; Form1.TabSheetRadioShow(Self);
    Form1.PageControl4.ActivePageIndex:=1;
    Form1.StringgridPresets.Row:=1;
    Form1.StringGridPresetsDblClick(Self);
  end;
end;

procedure TFormCoverPlayer.Action2Execute(Sender: TObject);
begin
  if (Stream=10) and (Form1.StringgridPresets.RowCount>2) then
  begin
    Form1.PageControl1.ActivePageIndex:=4; Form1.TabSheetRadioShow(Self);
    Form1.PageControl4.ActivePageIndex:=1;
    Form1.StringgridPresets.Row:=2;
    Form1.StringGridPresetsDblClick(Self);
  end;
end;

procedure TFormCoverPlayer.Action3Execute(Sender: TObject);
begin
   if (Stream=10) and (Form1.StringgridPresets.RowCount>3) then
  begin
    Form1.PageControl1.ActivePageIndex:=4; Form1.TabSheetRadioShow(Self);
    Form1.PageControl4.ActivePageIndex:=1;
    Form1.StringgridPresets.Row:=3;
    Form1.StringGridPresetsDblClick(Self);
  end;
end;

procedure TFormCoverPlayer.Action4Execute(Sender: TObject);
begin
   if (Stream=10) and (Form1.StringgridPresets.RowCount>4) then
   begin
     Form1.PageControl1.ActivePageIndex:=4; Form1.TabSheetRadioShow(Self);
     Form1.PageControl4.ActivePageIndex:=1;
     Form1.StringgridPresets.Row:=4;
     Form1.StringGridPresetsDblClick(Self);
   end;
end;

procedure TFormCoverPlayer.Action5Execute(Sender: TObject);
begin
   if (Stream=10) and (Form1.StringgridPresets.RowCount>5) then
   begin
     Form1.PageControl1.ActivePageIndex:=4; Form1.TabSheetRadioShow(Self);
     Form1.PageControl4.ActivePageIndex:=1;
     Form1.StringgridPresets.Row:=5;
     Form1.StringGridPresetsDblClick(Self);
   end;
end;

procedure TFormCoverPlayer.Action6Execute(Sender: TObject);
begin
   if (Stream=10) and (Form1.StringgridPresets.RowCount>6) then
   begin
     Form1.PageControl1.ActivePageIndex:=4; Form1.TabSheetRadioShow(Self);
     Form1.PageControl4.ActivePageIndex:=1;
     Form1.StringgridPresets.Row:=6;
     Form1.StringGridPresetsDblClick(Self);
   end;
end;

procedure TFormCoverPlayer.Action7Execute(Sender: TObject);
begin
   if (Stream=10) and (Form1.StringgridPresets.RowCount>7) then
   begin
     Form1.PageControl1.ActivePageIndex:=4; Form1.TabSheetRadioShow(Self);
     Form1.PageControl4.ActivePageIndex:=1;
     Form1.StringgridPresets.Row:=7;
     Form1.StringGridPresetsDblClick(Self);
   end;
end;

procedure TFormCoverPlayer.Action8Execute(Sender: TObject);
begin
  if (Stream=10) and (Form1.StringgridPresets.RowCount>8) then
  begin
    Form1.PageControl1.ActivePageIndex:=4; Form1.TabSheetRadioShow(Self);
    Form1.PageControl4.ActivePageIndex:=1;
    Form1.StringgridPresets.Row:=8;
    Form1.StringGridPresetsDblClick(Self);
  end;
end;

procedure TFormCoverPlayer.Action9Execute(Sender: TObject);
begin
  if (Stream=10) and (Form1.StringgridPresets.RowCount>9) then
  begin
    Form1.PageControl1.ActivePageIndex:=4; Form1.TabSheetRadioShow(Self);
    Form1.PageControl4.ActivePageIndex:=1;
    Form1.StringgridPresets.Row:=9;
    Form1.StringGridPresetsDblClick(Self);
  end;
end;

procedure TFormCoverPlayer.ActionChoseRadioExecute(Sender: TObject);
begin
  Form1.ActionChoseRadioExecute(Self);
end;

procedure TFormCoverPlayer.ActionCloserExecute(Sender: TObject);
begin
  LabelLyrics.BorderSpacing.Left:=LabelLyrics.BorderSpacing.Left+2;
  uELED13.BorderSpacing.Right:=uELED13.BorderSpacing.Right+1;
  ProgressBar1.BorderSpacing.Bottom:=ProgressBar1.BorderSpacing.Bottom+1;
end;

procedure TFormCoverPlayer.ActionFontBiggerExecute(Sender: TObject);
begin
  if LabelLyrics.Font.Size<40 then LabelLyrics.Font.Size:=LabelLyrics.Font.Size+1;
end;

procedure TFormCoverPlayer.ActionFontSmallerExecute(Sender: TObject);
begin
  if LabelLyrics.Font.Size>7 then LabelLyrics.Font.Size:=LabelLyrics.Font.Size-1;
end;

procedure TFormCoverPlayer.ActionNextExecute(Sender: TObject);
begin
  Form1.SB_NextClick(Self);
end;

procedure TFormCoverPlayer.ActionPauzeExecute(Sender: TObject);
begin
  Form1.SB_PauzeClick(Self);
end;

procedure TFormCoverPlayer.ActionPrevExecute(Sender: TObject);
begin
 Form1.SB_PreviousClick(Self);
end;

procedure TFormCoverPlayer.ActionProgressExecute(Sender: TObject);
begin
  Progressbar1.Visible:=not Progressbar1.Visible;
end;

procedure TFormCoverPlayer.ActionRepeatExecute(Sender: TObject);
begin
  Form1.SB_RepeatClick(Self);
end;

procedure TFormCoverPlayer.ActionShuffleExecute(Sender: TObject);
begin
  Form1.SB_ShuffleClick(Self);
  Form1.UpdateMediaMode;
end;

procedure TFormCoverPlayer.ActionTimeExecute(Sender: TObject);
begin
  BCLabelTime.Visible:=not BCLabelTime.Visible;
  BCLabelTotalTime.Visible:=not BCLabelTotalTime.Visible;
end;

procedure TFormCoverPlayer.ActionWiderExecute(Sender: TObject);
begin
  if LabelLyrics.BorderSpacing.Left>30 then
  begin
    LabelLyrics.BorderSpacing.Left:=LabelLyrics.BorderSpacing.Left-2;
    uELED13.BorderSpacing.Right:=uELED13.BorderSpacing.Right-1;
    ProgressBar1.BorderSpacing.Bottom:=ProgressBar1.BorderSpacing.Bottom-1;
  end;
end;

procedure TFormCoverPlayer.BCLabel1Click(Sender: TObject);
var i: longint;
begin
  if CoverModePlayer=3 then
  begin
    if (page=-1) then
    begin
     begin
      Albummode:=2;
      ButtonHeight:=50;
      SongList:=TStringList.Create;
      for i:=0 to maxsongs-1 do
      begin
        if Liedjes[i].Artiest=BCLabel1.Caption then SongList.Add(inttostr(i));
      end;
      //PANEL
      SongListPanel:=TBGRAGraphicControl.Create(Wall);
      SongListPanel.Parent:=Wall;
      SongListPanel.Top:=80;
      SongListPanel.Left:=300;
      SongListPanel.Height:=ImageCDCover.Top-160;
      SongListPanel.Width:=Wall.Width-500;
      SongListPanel.Caption:='';
      SongListPanel.Color:=clBlack;
      SongListPanel.ColorOpacity:=120;
      SongListPanel.BevelInner:=bvLowered;

      //UP BUTTON
      UpButton:=TBGRASpeedbutton.Create(Wall);
      UpButton.Parent:=Wall;
      UpButton.Top:=SongListPanel.Top+1;UpButton.Left:=SongListPanel.Left+1;
      UpButton.Height:=30; UpButton.Width:=SongListPanel.Width-3;
      UpButton.Flat:=True;
      UpButton.OnClick:=@UpButtonOnClick;
      BGRAImageList1.GetBitmap(0, UpButton.Glyph);

      MaxButtons:=(SongListPanel.Height-60) div ButtonHeight;
      MaxPages:=SongList.Count div MaxButtons;
      if MaxButtons>SongList.Count then MaxButtons:=SongList.Count;
      ButtonList:=TList.Create; i:=1; page:=0;

      if maxbuttons>0 then
      begin
      repeat
        ListButton:=TBGRASpeedButton.Create(Self);
        ListButton.Parent:=Wall;
        ListButton.Name:='ListButton'+inttostr(i);
        ButtonList.Add(ListButton);
        if i=1 then
        begin
          TBGRASpeedbutton(ButtonList[0]).Left:=UpButton.Left;
          TBGRASpeedbutton(ButtonList[0]).Width:=UpButton.Width;
          TBGRASpeedbutton(ButtonList[0]).Height:=ButtonHeight;
          TBGRASpeedbutton(ButtonList[0]).AnchorSide[akTop].Side:=asrBottom;
          TBGRASpeedbutton(ButtonList[0]).AnchorSide[akTop].Control:=UpButton;
          TBGRASpeedbutton(ButtonList[0]).Anchors:=TBGRASpeedbutton(ButtonList[0]).Anchors-[akBottom]+[akTop];
          TBGRASpeedbutton(ButtonList[0]).Flat:=True;
          TBGRASpeedbutton(ButtonList[0]).Caption:=Liedjes[strtoint(SongList.Strings[i-1])].Titel;
          TBGRASpeedbutton(ButtonList[0]).Font.Color:=$00FF00FF;
          TBGRASpeedbutton(ButtonList[0]).Font.Size:=ButtonHeight div 2;
          TBGRASpeedbutton(ButtonList[0]).OnClick:=@ListButtonOnClick;
        end
        else
        begin
          TBGRASpeedbutton(ButtonList[i-1]).Left:=UpButton.Left;
          TBGRASpeedbutton(ButtonList[i-1]).Width:=UpButton.Width;
          TBGRASpeedbutton(ButtonList[i-1]).Height:=ButtonHeight;
          TBGRASpeedbutton(ButtonList[i-1]).AnchorSide[akTop].Side:=asrBottom;
          TBGRASpeedbutton(ButtonList[i-1]).AnchorSide[akTop].Control:=TBGRASpeedbutton(ButtonList[i-2]);
          TBGRASpeedbutton(ButtonList[i-1]).Anchors:=TBGRASpeedbutton(ButtonList[i-1]).Anchors-[akBottom]+[akTop];
          TBGRASpeedbutton(ButtonList[i-1]).Flat:=True;
          TBGRASpeedbutton(ButtonList[i-1]).Caption:=Liedjes[strtoint(SongList.Strings[i-1])].Titel;
          TBGRASpeedbutton(ButtonList[i-1]).Font.Color:=$00FF00FF;
          TBGRASpeedbutton(ButtonList[i-1]).Font.Size:=ButtonHeight div 2;
          TBGRASpeedbutton(ButtonList[i-1]).OnClick:=@ListButtonOnClick;
        end;
        inc(i);
      until i>MaxButtons;
      end;

      //DOWNBUTTON
      DownButton:=TBGRASpeedbutton.Create(Wall);
      DownButton.Parent:=Wall;
      DownButton.Top:=SongListPanel.Top+SongListPanel.Height-31;DownButton.Left:=SongListPanel.Left+1;
      DownButton.Height:=30; DownButton.Width:=SongListPanel.Width-3;
      DownButton.Flat:=True;
      BGRAImageList1.GetBitmap(1, DownButton.Glyph);
      DownButton.OnClick:=@DownButtonOnClick;
     end;
    end
    else
    begin
      For i:=0 to MaxButtons-1 do TBGRASpeedbutton(ButtonList[i]).Free;
      Upbutton.Free; DownButton.Free;
      SongListPanel.Free; ButtonList.Free; SongList.Free;
      page:=-1;
    end;
  end;
end;

procedure TFormCoverPlayer.FormCreate(Sender: TObject);
begin
 // WindowState:=WsFullscreen;
  FormCoverPlayer.Top:=0; FormCoverPlayer.Left:=0;
  FormCoverPlayer.Width:=Screen.Width;
  FormCoverPlayer.Height:=Screen.Height;
  page:=-1;
end;

procedure TFormCoverPlayer.Image1DblClick(Sender: TObject);
begin
  if CoverModePlayer=3 then If Page<>-1 then ImageCDCoverClick(Self);
  IsMediaModeOn:=False;  Close;
end;

procedure TFormCoverPlayer.ImageCDCoverClick(Sender: TObject);
var i: longint;
begin
  if CoverModePlayer=3 then
  begin
    if (page=-1) then
    begin
     if (Label9.Caption<>'') then
     begin
      Albummode:=1;
      ButtonHeight:=50;
      SongList:=TStringList.Create;
      for i:=0 to maxsongs-1 do
      begin
     //   if Liedjes[i].Artiest=BCLabel1.Caption then
          if Liedjes[i].CD=Label9.Caption then SongList.Add(inttostr(i));
      end;
      //PANEL
      SongListPanel:=TBGRAGraphicControl.Create(Wall);
      SongListPanel.Parent:=Wall;
      SongListPanel.Top:=80;
      SongListPanel.Left:=300;
      SongListPanel.Height:=ImageCDCover.Top-160;
      SongListPanel.Width:=Wall.Width-500;
      SongListPanel.Caption:='';
      SongListPanel.Color:=clBlack;
      SongListPanel.ColorOpacity:=120;
      SongListPanel.BevelInner:=bvLowered;

      //UP BUTTON
      UpButton:=TBGRASpeedbutton.Create(Wall);
      UpButton.Parent:=Wall;
      UpButton.Top:=SongListPanel.Top+1;UpButton.Left:=SongListPanel.Left+1;
      UpButton.Height:=30; UpButton.Width:=SongListPanel.Width-3;
      UpButton.Flat:=True;
      UpButton.OnClick:=@UpButtonOnClick;
      BGRAImageList1.GetBitmap(0, UpButton.Glyph);

      MaxButtons:=(SongListPanel.Height-60) div ButtonHeight;
      MaxPages:=SongList.Count div MaxButtons;
      if MaxButtons>SongList.Count then MaxButtons:=SongList.Count;
      ButtonList:=TList.Create; i:=1; page:=0;

      if MaxButtons>0 then
      begin
      repeat
        ListButton:=TBGRASpeedButton.Create(Self);
        ListButton.Parent:=Wall;
        ListButton.Name:='ListButton'+inttostr(i);
        ButtonList.Add(ListButton);
        if i=1 then
        begin
          TBGRASpeedbutton(ButtonList[0]).Left:=UpButton.Left;
          TBGRASpeedbutton(ButtonList[0]).Width:=UpButton.Width;
          TBGRASpeedbutton(ButtonList[0]).Height:=ButtonHeight;
          TBGRASpeedbutton(ButtonList[0]).AnchorSide[akTop].Side:=asrBottom;
          TBGRASpeedbutton(ButtonList[0]).AnchorSide[akTop].Control:=UpButton;
          TBGRASpeedbutton(ButtonList[0]).Anchors:=TBGRASpeedbutton(ButtonList[0]).Anchors-[akBottom]+[akTop];
          TBGRASpeedbutton(ButtonList[0]).Flat:=True;
          TBGRASpeedbutton(ButtonList[0]).Caption:=Liedjes[strtoint(SongList.Strings[i-1])].Titel;
          TBGRASpeedbutton(ButtonList[0]).Font.Color:=$00FF00FF;
          TBGRASpeedbutton(ButtonList[0]).Font.Size:=ButtonHeight div 2;
          TBGRASpeedbutton(ButtonList[0]).OnClick:=@ListButtonOnClick;
        end
        else
        begin
          TBGRASpeedbutton(ButtonList[i-1]).Left:=UpButton.Left;
          TBGRASpeedbutton(ButtonList[i-1]).Width:=UpButton.Width;
          TBGRASpeedbutton(ButtonList[i-1]).Height:=ButtonHeight;
          TBGRASpeedbutton(ButtonList[i-1]).AnchorSide[akTop].Side:=asrBottom;
          TBGRASpeedbutton(ButtonList[i-1]).AnchorSide[akTop].Control:=TBGRASpeedbutton(ButtonList[i-2]);
          TBGRASpeedbutton(ButtonList[i-1]).Anchors:=TBGRASpeedbutton(ButtonList[i-1]).Anchors-[akBottom]+[akTop];
          TBGRASpeedbutton(ButtonList[i-1]).Flat:=True;
          TBGRASpeedbutton(ButtonList[i-1]).Caption:=Liedjes[strtoint(SongList.Strings[i-1])].Titel;
          TBGRASpeedbutton(ButtonList[i-1]).Font.Color:=$00FF00FF;
          TBGRASpeedbutton(ButtonList[i-1]).Font.Size:=ButtonHeight div 2;
          TBGRASpeedbutton(ButtonList[i-1]).OnClick:=@ListButtonOnClick;
        end;
        inc(i);
      until i>MaxButtons;
      end;

      //DOWNBUTTON
      DownButton:=TBGRASpeedbutton.Create(Wall);
      DownButton.Parent:=Wall;
      DownButton.Top:=SongListPanel.Top+SongListPanel.Height-31;DownButton.Left:=SongListPanel.Left+1;
      DownButton.Height:=30; DownButton.Width:=SongListPanel.Width-3;
      DownButton.Flat:=True;
      BGRAImageList1.GetBitmap(1, DownButton.Glyph);
      DownButton.OnClick:=@DownButtonOnClick;
     end;
    end
    else
    begin
      For i:=0 to MaxButtons-1 do TBGRASpeedbutton(ButtonList[i]).Free;
      Upbutton.Free; DownButton.Free;
      SongListPanel.Free; ButtonList.Free; SongList.Free;
      page:=-1;
    end;
  end;
end;

procedure TFormCoverPlayer.ImageCDCoverPictureChanged(Sender: TObject);
var bmp: TBGRABitmap;
   bmpTmp: TBitmap;
begin
 if (FormCoverPlayer.Visible) and IsMediaModeOn then
 begin
   if stream<9 then
   begin
     ProgressBar1.Width:=round(FormCoverPlayer.Width/2.7);
     if Loaded_CD_Cover='x' then ImageCDCoverReflection.Picture.Bitmap.Clear
                            else
     begin
       bmpTmp:=TBitmap.create;
       bmp := TBGRABitmap.Create(ImageCDCover.Picture.Bitmap);
       bmp.VerticalFlip;
       case CoverModePlayer of
         1: bmp.GradientFill(0,0,bmp.Width,bmp.Height,bgra(120,120,120,140),bgra(240,240,240,220), gtlinear,PointF(0,0), PointF(bmp.Width,bmp.Height),dmDrawwithTransparency,True,True);
         2: bmp.GradientFill(0,0,bmp.Width,bmp.Height,bgra(0,0,0,180),bgra(70,70,70,240), gtlinear,PointF(0,0), PointF(bmp.Width,bmp.Height),dmLinearBlend,True,True);
       end;
       with bmpTmp do
         begin
           SetSize(bmp.Width,bmp.height);
           Canvas.Draw(0,0,bmp.Bitmap);
         end;
      ImageCDCoverReflection.Picture.Bitmap:= bmpTmp;  // ImageCDCoverReflection.Height:=ImageCDCover.Height;
      bmp.Free;
      bmptmp.Free;
    end;
   end
   else ImageCDCoverReflection.Picture.Bitmap.Clear;
 end;
end;

procedure TFormCoverPlayer.DownButtonOnClick(Sender: TObject);
begin
  if Page<MaxPages then
  begin
    inc(Page);
    FillPage;
  end;
end;

procedure TFormCoverPlayer.UpButtonOnClick(Sender: TObject);
begin
  if Page>0 then
  begin
    dec(Page);
    FillPage;
  end;
end;

procedure TFormCoverPlayer.FillPage;
var i: integer;
begin
  i:=1;
  repeat
    TBGRASpeedbutton(ButtonList[i-1]).ShowAccelChar:=False;
    TBGRASpeedbutton(ButtonList[i-1]).caption:=Liedjes[strtoint(SongList.Strings[i+(page*Maxbuttons)-(page+1)])].Titel;
    inc(i);
  until (i>MaxButtons) or (SongList.Count<=i+(Page*MaxButtons)-(page+1));
  if i<=MaxButtons then
  begin
    repeat
      TBGRASpeedbutton(ButtonList[i-1]).ShowAccelChar:=False;
      TBGRASpeedbutton(ButtonList[i-1]).Caption:='';
      inc(i);
    until i=MaxButtons+1;
  end;
end;

procedure TFormCoverPlayer.ListButtonOnClick(Sender: TObject);
var itemstart, itemclicked: longint;
    Random_Temp: Boolean;
begin
  Cursor:=CrHourglass; Application.ProcessMessages;
  itemstart:=TBGRASpeedbutton(ButtonList[0]).Top; Random_Temp:=Settings.Shuffle;
  itemclicked:= ((mouse.CursorPos.Y-itemstart) div ButtonHeight)+1;
  listitemselected:=itemclicked+(page*MaxButtons)-page;
  if albummode=0 then
  begin
    if listitemselected<Form1.SG_Play.RowCount then
    begin
      Form1.SG_Play.Row:=listitemselected;
      Application.ProcessMessages;
      Form1.SG_PlayDblClick(Self);
    end;
  end;
  if albummode=1 then
  begin
     //showMessage('Work in progress'+#13+'You have clicked: '+inttostr(listitemselected));
    Settings.Shuffle:=False;
    Form1.LB_Albums1.ItemIndex:=Form1.LB_Albums1.Items.IndexOf(Label9.Caption);
    Application.ProcessMessages;
    Form1.LB_Albums1Click(Self);
    Application.ProcessMessages;
    Form1.SG_All.Row:=listitemselected;
    Application.ProcessMessages;
    Form1.SG_AllDblClick(Self);
    Settings.Shuffle:=Random_Temp;
    Albummode:=0;
  end;
  if albummode=2 then
  begin
    // showMessage('Work in progress'+#13+'You have clicked: '+inttostr(listitemselected));
    Settings.Shuffle:=False;
   // Form1.LB_ArtiestClick(Self);
    Form1.LB_Artist1.ItemIndex:=Form1.LB_Artist1.Items.IndexOf(BCLabel1.Caption);;
    Application.ProcessMessages;
    Form1.LB_Artist1Clicked;
    Form1.SG_All.Row:=listitemselected;
    Application.ProcessMessages;
    Form1.SG_AllDblClick(Self);
    Settings.Shuffle:=Random_Temp;
    Albummode:=0;

  end;
  Cursor:=CrDefault;
end;


procedure TFormCoverPlayer.ImageNextClick(Sender: TObject);
begin
   Form1.SB_NextClick(Self);
end;

procedure TFormCoverPlayer.ImageNextMouseEnter(Sender: TObject);
begin
  ImageNext.Picture.Bitmap:=Form1.SB_Play.Glyph;
end;

procedure TFormCoverPlayer.ImageNextMouseLeave(Sender: TObject);
begin
  ImageNext.Picture.Bitmap.Clear;
end;

procedure TFormCoverPlayer.ImagePreviousClick(Sender: TObject);
begin
  Form1.SB_PreviousClick(Self);
end;

procedure TFormCoverPlayer.ImagePreviousMouseEnter(Sender: TObject);
begin
  ImagePrevious.Picture.Bitmap:=Form1.SB_Reverse.Glyph;
end;

procedure TFormCoverPlayer.ImagePreviousMouseLeave(Sender: TObject);
begin
  ImagePrevious.Picture.Bitmap.Clear;
end;

procedure TFormCoverPlayer.Label4MouseEnter(Sender: TObject);
begin
  Label3.Font.Bold:=True; Label4.Font.Bold:=True;
end;

procedure TFormCoverPlayer.Label4MouseLeave(Sender: TObject);
begin
  Label3.Font.Bold:=False; Label4.Font.Bold:=False;
end;

procedure TFormCoverPlayer.Label6MouseEnter(Sender: TObject);
begin
  Label5.Font.Bold:=True; Label6.Font.Bold:=True;
end;

procedure TFormCoverPlayer.Label6MouseLeave(Sender: TObject);
begin
  Label5.Font.Bold:=False; Label6.Font.Bold:=False;
end;

procedure TFormCoverPlayer.MenuItem2Click(Sender: TObject);
begin
  if CoverModePlayer=3 then
  begin
    If Page<>-1 then ImageCDCoverClick(Self);
    ProgressBar1.Parent:=FormCoverPlayer; ImagePrevious.Parent:=FormCoverPlayer; ImageNext.Parent:=FormCoverPlayer;
    BCLabel1.Parent:=FormCoverPlayer; BCLabel2.Parent:=FormCoverPlayer;
    BCLabelTime.Parent:=FormCoverPlayer; BCLabelTotalTime.Parent:=FormCoverPlayer;
    Label9.Parent:=FormCoverPlayer;
    ImageCDCover.Parent:=FormCoverPlayer; PaintBox1.Parent:=FormCoverPlayer;
    MenuButton.Free; Wall.Free; ImagePauze.Parent:=FormCoverPlayer;
    LabelLyrics.Visible:=True;
  end;
  CoverModePlayer:=1;
  FormCoverPlayer.Color:=$00EBEBEB; ImageBottom.Visible:=True;
  ImageCDCover.Top:=round(Screen.Height/4);  ImageCDCover.Left:=round(Screen.Width/4.7);
  ImageCDCover.Width:=Round(Screen.Width/3); ImageCDCover.Height:=ImageCDCover.Width;
  ImageCDCoverReflection.Width:=ImageCDCover.Width;
  ImageCDCoverReflection.Height:=ImageCDCover.Height;
  ImageCDCoverReflection.AnchorToNeighbour(akTop,0,ImageCDCover);
  ImageCDCoverPictureChanged(Self);

  BCLabel1.Font.Size:=round(Screen.Height/56); BCLabel2.Font.Size:=BCLabel1.Font.Size;
  BCLabel1.ShowAccelChar:=False; BCLabel2.ShowAccelChar:=False;
  BCLabel1.AnchorSide[akLeft].Side:=asrRight; BCLabel1.AutoSize:=True;
  BCLabel1.AnchorSide[akleft].Control:=ImageCDCover;
  BCLabel1.Anchors:=BCLabel1.Anchors+[akleft]-[aktop];
  BCLabel1.Top:=ImageCDCover.Top+40;
  BCLabel1.BorderSpacing.Left:=8;

  BCLabel2.AnchorSide[akLeft].Side:=asrLeft; BCLabel2.AutoSize:=True;
  BCLabel2.AnchorSide[akleft].Control:=BCLabel1;
  BCLabel2.AnchorSide[akRight].Side:=asrLeft;
  BCLabel2.AnchorSide[akRight].Control:=UELed1;
  BCLabel2.Anchors:=BCLabel2.Anchors+[akleft]+[akRight];

  BCLabelTotalTime.AnchorSide[akRight].Side:=asrRight;
  BCLabelTotalTime.AnchorSide[akRight].Control:=ProgressBar1;
  BCLabelTotalTime.Anchors:=BCLabelTotalTime.Anchors+[akRight];

  BCLabelTime.Left:=ProgressBar1.Left;
  BCLabelTime.Top:=Height-30;BCLabelTotalTime.Top:=BCLabelTime.Top;

  BCLabel1.Font.Color:=clBlack; BCLabel2.Font.Color:=$00515151;
  BCLabelTime.Font.Color:=$00515151; BCLabelTotalTime.Font.Color:=$00515151;
  Label9.Font.Color:=$00515151; Label12.Font.Color:=$00515151;
(* BCLabel1.FontEx.ShadowColor:=clSilver;   BCLabel2.FontEx.ShadowColor:=clSilver;
  BCLabelTime.FontEx.ShadowColor:=clSilver; BCLabelTotalTime.FontEx.ShadowColor:=clSilver; *)
  Label3.Font.Color:=$00B8B8B8; Label4.Font.Color:=$00B8B8B8;
  Label5.Font.Color:=$00B8B8B8; Label6.Font.Color:=$00B8B8B8;
  Label9.Font.Size:=10; Label2.Font.Size:=10;
  Label11.Font.Size:=10; Label12.Font.Size:=10;

  LabelLyrics.Font.Color:=clBlack;

  BCLabel1.Visible:=True; BCLabel2.Visible:=True;
  Label3.Visible:=True; Label4.Visible:=True; Label12.Visible:=True;
  BCLabelTotalTime.Visible:=True; Label9.Visible:=True;

  Label5.Visible:=True; Label6.Visible:=True;
  if Label9.Caption<>'' then Label2.Visible:=True;
  if Label12.Caption<>'' then Label11.Visible:=True;
  ImageCDCover.Visible:=True; ImageCDCoverReflection.Visible:=True;
  ProgressBar1.Left:=round(width/3); ProgressBar1.Width:=ProgressBar1.Left;

  LabelNowPlaying.Visible:=True;
end;

procedure TFormCoverPlayer.MenuItem3Click(Sender: TObject);
begin
  if CoverModePlayer=3 then
  begin
    If Page<>-1 then ImageCDCoverClick(Self);
    ProgressBar1.Parent:=FormCoverPlayer; ImagePrevious.Parent:=FormCoverPlayer; ImageNext.Parent:=FormCoverPlayer;
    Label9.Parent:=FormCoverPlayer; BCLabelTotalTime.Parent:=FormCoverPlayer;
    ImageCDCover.Parent:=FormCoverPlayer; PaintBox1.Parent:=FormCoverPlayer;  ImagePauze.Parent:=FormCoverPlayer;
    MenuButton.Free; Wall.Free; BCLabel1.Parent:=FormCoverPlayer; BCLabel2.Parent:=FormCoverPlayer; BCLabelTime.Parent:=FormCoverPlayer;
    LabelLyrics.Visible:=True;
  end;
  CoverModePlayer:=2;
  FormCoverPlayer.Color:=clBlack; ImageBottom.Visible:=False;
  ImageCDCover.Top:=round(Screen.Height/11);
  ImageCDCover.Height:=Round(Screen.Height/1.4); ImageCDCover.Width:=ImageCDCover.Height;
  ImageCDCover.Left:=round(Screen.Width/2)-round(ImageCDCover.Width/2);
  ImageCDCoverReflection.Width:=ImageCDCover.Width;
  ImageCDCoverReflection.Height:=ImageCDCover.Height;
  ImageCDCoverReflection.AnchorToNeighbour(akTop,0,ImageCDCover);
  ImageCDCoverPictureChanged(Self);
  BCLabel1.Font.Size:=round(Screen.Height/60); BCLabel2.Font.Size:=BCLabel1.Font.Size;
  BCLabel1.ShowAccelChar:=False; BCLabel2.ShowAccelChar:=False;
  BCLabel1.BorderSpacing.Left:=8;
  BCLabel1.AnchorSide[akLeft].Side:=asrcenter; BCLabel1.AutoSize:=True;
  BCLabel1.AnchorSide[akleft].Control:=ImageCDCoverReflection;
  BCLabel1.Anchors:=BCLabel1.Anchors+[akleft]-[aktop];
  BCLabel1.Top:=FormCoverPlayer.Height-120;
  BCLabel2.Top:=BCLabel1.Top+18;
  BCLabel2.AnchorSide[akLeft].Side:=asrcenter;
  BCLabel2.AnchorSide[akleft].Control:=ImageCDCoverReflection;
  BCLabel2.Anchors:=BCLabel2.Anchors+[akleft];
  BCLabelTime.Left:=ProgressBar1.Left;
  BCLabelTotalTime.AnchorSide[akRight].Side:=asrRight;
  BCLabelTotalTime.AnchorSide[akRight].Control:=ProgressBar1;
  BCLabelTotalTime.Anchors:=BCLabelTotalTime.Anchors+[akRight];

  BCLabelTime.Top:=Height-30;BCLabelTotalTime.Top:=BCLabelTime.Top;

  BCLabel1.Font.Color:=clLime; BCLabel2.Font.Color:=clLime;
  BCLabelTime.Font.Color:=clLime; BCLabelTotalTime.Font.Color:=clLime;
(* BCLabel1.FontEx.ShadowColor:=clGreen;   BCLabel2.FontEx.ShadowColor:=clGreen;
  BCLabelTime.FontEx.ShadowColor:=clGreen; BCLabelTotalTime.FontEx.ShadowColor:=clGreen;  *)
  Label3.Font.Color:=clGreen; Label4.Font.Color:=clGreen;
  Label5.Font.Color:=clGreen; Label6.Font.Color:=clGreen;

  Label9.Visible:=False; Label12.Visible:=False;
  Label2.Visible:=False; Label11.Visible:=False;

  LabelLyrics.Font.Color:=clSkyBlue;

  BCLabel1.Visible:=True; BCLabel2.Visible:=True;
  Label3.Visible:=True; Label4.Visible:=True;
  Label5.Visible:=True; Label6.Visible:=True;
  ImageCDCover.Visible:=True; ImageCDCoverReflection.Visible:=True;
  BCLabel1.BringToFront; BCLabel2.BringToFront;

  ProgressBar1.Left:=round(width/3); ProgressBar1.Width:=ProgressBar1.Left;

  LabelNowPlaying.Visible:=False;
end;

procedure TFormCoverPlayer.MenuItem4Click(Sender: TObject);
var
  i: integer;
  s: string;
  bmp: TBGRABitmap;
  FilesTemp: TStringList;
begin
 if CoverModePlayer<>3 then
 begin
  FormCoverPlayer.Color:=clBlack; ImageBottom.Visible:=False;
  Label3.Visible:=False; Label4.Visible:=False; Label2.Visible:=False;
  Label5.Visible:=False; Label6.Visible:=False;
  LabelLyrics.Visible:=False; Label11.Visible:=False;
  Label12.Visible:=False; LabelNowPlaying.Visible:=False;
  ImageCDCoverReflection.Visible:=False;

  Wall := TWallOfTiles.Create(Self);
  with Wall do
  begin
    Wall.Parent := FormCoverPlayer;
    Align := alClient;
    TileSize := 82;
    Margin := 0;
    Interval := 1500;
    AnimateTime := 2500;
    BlackAndWhite := False;
    BlackAndWhiteAndColor :=True;
    MakeFullScreen := True;
    MovingCamera := True;
  end;
  AlbumLabel := TLabel.Create(Self);
  with AlbumLabel do
  begin
    Parent := Wall;
    AutoSize := True;
    Transparent := True;
    Font.Size := 20;
    Font.Color := clWhite;
    Caption := '';
  end;
  PlayButton := TWCButton.Create(Self);
  with PlayButton do
  begin
    Parent := Wall;
    Background := Wall.Bitmap;
    ButtonType := twPlay;
    Width := 55;
    Height := 55;
    OnClick := @PlayButtonOnClick;
  end;
  NextButton := TWCButton.Create(Self);
  with NextButton do
  begin
    Parent := Wall;
    Background := Wall.Bitmap;
    ButtonType := twNext;
    Width := 47;
    Height := 47;
    OnClick := @ImageNextClick;
  end;
  PreviousButton := TWCButton.Create(Self);
  with PreviousButton do
  begin
    Parent := Wall;
    Background := Wall.Bitmap;
    ButtonType := twPrevious;
    Width := 47;
    Height := 47;
    OnClick := @ImagePreviousClick;
  end;
  BackButton := TWCButton.Create(Self);
  with BackButton do
  begin
    Parent := Wall;
    Background := Wall.Bitmap;
    ButtonType := twLeft;
    Width := 80;
    Height := 80;
    OnClick := @ActionLeaveExecute;
  end;
  ShuffleButton := TWCButton.Create(Self);
  with ShuffleButton do
  begin
    Parent := Wall;
    Background := Wall.Bitmap;
    ButtonType := twShuffle;
    Width := 25;
    Height := 25;
    OnClick := @Form1.SB_ShuffleClick;
  end;
  RepeatButton := TWCButton.Create(Self);
  with RepeatButton do
  begin
    Parent := Wall;
    Background := Wall.Bitmap;
    ButtonType := twRepeat;
    Width := 25;
    Height := 25;
    OnClick := @Form1.SB_RepeatClick;
  end;
  VolumeButton := TWCButton.Create(Self);
  with VolumeButton do
  begin
    Parent := Wall;
    Background := Wall.Bitmap;
    ButtonType := twVolume;
    Width := 25;
    Height := 25;
  end;

  with PlayButton do
  begin
    Left := FormCoverPlayer.Width - 180;
    Top := FormCoverPlayer.Height - 80;
  end;
  with NextButton do
  begin
    Left := PlayButton.Left + PlayButton.Width - 5;
    Top := PlayButton.Top + 4;
  end;
  with PreviousButton do
  begin
    Left := PlayButton.Left - PlayButton.Width + 11;
    Top := PlayButton.Top + 4;
  end;
  with BackButton do
  begin
    Left := 25;
    Top := 25;
  end;
  with ShuffleButton do
  begin
    Left := PreviousButton.Left - NextButton.Width + 9;
    Top := PreviousButton.Top + 10;
  end;
  with RepeatButton do
  begin
    Left := ShuffleButton.Left - ShuffleButton.Width + 2;
    Top := PreviousButton.Top + 10;
  end;
  with VolumeButton do
  begin
    Left := NextButton.Left + NextButton.Width + 4;
    Top := PreviousButton.Top + 10;
  end;
  if pause then PlayButton.ButtonType := twPlay
           else PlayButton.ButtonType := twPause;

  FilesTemp:=TStringList.Create;
  FilesTemp:=FindAllFiles(ConfigDir+DirectorySeparator+'cache', '*.png;*.jpg', True);
  for i := 0 to 100 do
  begin
    s:=FilesTemp.Strings[random(FilesTemp.Count)];
    try
      bmp := TBGRABitmap.Create(s)
    except
      bmp := TBGRABitmap.Create(100, 100, BGRA(Random(255), Random(255), Random(255)));
    end;
    Wall.Tiles.Add(bmp);
  end;
  FilesTemp.Free;

  MenuButton:=TBGRASpeedButton.Create(Self);
  MenuButton.Parent:=Wall;
  MenuButton.Name:='MenuButtonSongList';
  MenuButton.ShowAccelChar:=False;
  MenuButton.Flat:=True;
  MenuButton.Height:=24; MenuButton.Width:=24;
  MenuButton.Top:=RepeatButton.Top;
  MenuButton.Left:=RepeatButton.Left-32;
  MenuButton.Cursor:=crHandPoint;
  MenuButton.OnClick:=@MenuButtonSongListClick;
  BGRAImageList1.GetBitmap(2, MenuButton.Glyph);

 end;

  CoverModePlayer:=3;

  s:=Label9.Caption;
  ProgressBar1.Parent:=Wall; ImagePrevious.Parent:=Wall; ImageNext.Parent:=Wall;
  BCLabelTime.Parent:=Wall; BCLabelTotalTime.Parent:=Wall;
  PaintBox1.Parent:=Wall; Label9.Parent:=Wall;
  ImageCDCover.Parent:=Wall; BCLabel1.Parent:=Wall; BCLabel2.Parent:=Wall;
  ImagePauze.Parent:=Wall;

  //ImageCDCover.Width:=192; ImageCDCover.Height:=192;
  ImageCDCover.Cursor:=crHandpoint;
  ImageCDCover.Width:=round(Screen.Height/4.2); ImageCDCover.Height:=ImageCDCover.Width;
  ImageCDCover.Left:=round(Wall.Width * 0.06);
  ImageCDCover.Top:=Screen.Height-ImageCDCover.Height-round(Screen.Height/12);
  // ImageCDCover.Top:=round(Wall.Height * 0.74);
  ImageCDCover.OnClick:=@ImageCDCoverClick;

  ImagePrevious.Top:=0; ImagePrevious.Height:=Wall.Height;
  ImageNext.Top:=0; ImageNext.Height:=Wall.Height; ImageNext.Width:=36;ImageNext.Left:=Wall.Width-36;

  BCLabel1.Cursor:=crHandpoint;
  BCLabel1.ShowAccelChar:=False; BCLabel2.ShowAccelChar:=False; BCLabel1.Font.Size:=round(ImageCDCover.Height/8);
  BCLabel1.Top:=ImageCDCover.Top+10; BCLabel1.Font.Color:=clWhite;
  BCLabel1.Left:=ImageCDCover.Left+ImageCDCover.Width+10;

  BCLabel2.AnchorSide[akLeft].Side:=asrLeft; BCLabel2.AutoSize:=True;
  BCLabel2.AnchorSide[akleft].Control:=BCLabel1;
  BCLabel2.Anchors:=BCLabel2.Anchors+[akleft]-[akRight];

  BCLabel2.Font.Size:=BCLabel1.Font.Size;
  BCLabel2.Font.Color:=clWhite;  BCLabel2.Left:=BCLabel1.Left;
  BCLabelTime.Font.Color:=clWhite; BCLabelTotalTime.Font.Color:=clWhite;
  BCLabelTime.Left:=ProgressBar1.Left;
  BCLabelTime.Top:=Height-BCLabelTime.Height-6; BCLabelTotalTime.Top:=BCLabelTime.Top;

  BCLabelTotalTime.Left:=ProgressBar1.Left+ProgressBar1.Width-BCLabelTotalTime.Width;

  Label9.Top:=BCLabel2.Top-round(BCLabel2.Font.Height*2.2); Label9.Left:=BCLabel1.Left;
  Label9.AutoSize:=True; Label9.Transparent := True;
  Label9.Font.Size := 18; Label9.Font.Color := clSilver;
  Label9.Caption:=s; Label9.Visible:=True;
  Label9.Cursor:=crHandpoint;
  Label9.OnClick:=@ImageCDCoverClick;

  Wall.Active:=true;
end;

procedure TFormCoverPlayer.MenuButtonSongListClick(Sender: TObject);
var i: longint;
begin
if CoverModePlayer=3 then
 begin
   if (page=-1) then
   begin
    if (Label9.Caption<>'') then
    begin
     Albummode:=0;
     ButtonHeight:=50;
     SongList:=TStringList.Create;
     for i:=1 to Form1.SG_Play.RowCount-1 do SongList.Add(Form1.SG_Play.Cells[6,i]);
     //PANEL
     SongListPanel:=TBGRAGraphicControl.Create(Wall);
     SongListPanel.Parent:=Wall;
     SongListPanel.Top:=80;
     SongListPanel.Left:=300;
     SongListPanel.Height:=ImageCDCover.Top-160;
     SongListPanel.Width:=Wall.Width-500;
     SongListPanel.Caption:='';
     SongListPanel.Color:=clBlack;
     SongListPanel.ColorOpacity:=120;
     SongListPanel.BevelInner:=bvLowered;

     //UP BUTTON
     UpButton:=TBGRASpeedbutton.Create(Wall);
     UpButton.Parent:=Wall;
     UpButton.Top:=SongListPanel.Top+1;UpButton.Left:=SongListPanel.Left+1;
     UpButton.Height:=30; UpButton.Width:=SongListPanel.Width-3;
     UpButton.Flat:=True;
     UpButton.OnClick:=@UpButtonOnClick;
     BGRAImageList1.GetBitmap(0, UpButton.Glyph);

     MaxButtons:=(SongListPanel.Height-60) div ButtonHeight;
     MaxPages:=SongList.Count div MaxButtons;
     if MaxButtons>SongList.Count then MaxButtons:=SongList.Count;
     ButtonList:=TList.Create; i:=1; page:=0;

     repeat
       ListButton:=TBGRASpeedButton.Create(Self);
       ListButton.Parent:=Wall;
       ListButton.Name:='ListButton'+inttostr(i);
       ButtonList.Add(ListButton);
       if i=1 then
       begin
         TBGRASpeedbutton(ButtonList[0]).Left:=UpButton.Left;
         TBGRASpeedbutton(ButtonList[0]).Width:=UpButton.Width;
         TBGRASpeedbutton(ButtonList[0]).Height:=ButtonHeight;
         TBGRASpeedbutton(ButtonList[0]).AnchorSide[akTop].Side:=asrBottom;
         TBGRASpeedbutton(ButtonList[0]).AnchorSide[akTop].Control:=UpButton;
         TBGRASpeedbutton(ButtonList[0]).Anchors:=TBGRASpeedbutton(ButtonList[0]).Anchors-[akBottom]+[akTop];
         TBGRASpeedbutton(ButtonList[0]).Flat:=True;
         TBGRASpeedbutton(ButtonList[0]).ShowAccelChar:=False;
         TBGRASpeedbutton(ButtonList[0]).Caption:=Liedjes[strtoint(SongList.Strings[i-1])].Titel;
         TBGRASpeedbutton(ButtonList[0]).Font.Color:=$00FF00FF;
         TBGRASpeedbutton(ButtonList[0]).Font.Size:=ButtonHeight div 2;
         TBGRASpeedbutton(ButtonList[0]).OnClick:=@ListButtonOnClick;
       end
       else
       begin
         TBGRASpeedbutton(ButtonList[i-1]).Left:=UpButton.Left;
         TBGRASpeedbutton(ButtonList[i-1]).Width:=UpButton.Width;
         TBGRASpeedbutton(ButtonList[i-1]).Height:=ButtonHeight;
         TBGRASpeedbutton(ButtonList[i-1]).AnchorSide[akTop].Side:=asrBottom;
         TBGRASpeedbutton(ButtonList[i-1]).AnchorSide[akTop].Control:=TBGRASpeedbutton(ButtonList[i-2]);
         TBGRASpeedbutton(ButtonList[i-1]).Anchors:=TBGRASpeedbutton(ButtonList[i-1]).Anchors-[akBottom]+[akTop];
         TBGRASpeedbutton(ButtonList[i-1]).Flat:=True;
         TBGRASpeedbutton(ButtonList[i-1]).ShowAccelChar:=False;
         TBGRASpeedbutton(ButtonList[i-1]).Caption:=Liedjes[strtoint(SongList.Strings[i-1])].Titel;
         TBGRASpeedbutton(ButtonList[i-1]).Font.Color:=$00FF00FF;
         TBGRASpeedbutton(ButtonList[i-1]).Font.Size:=ButtonHeight div 2;
         TBGRASpeedbutton(ButtonList[i-1]).OnClick:=@ListButtonOnClick;
       end;
       inc(i);
     until i>MaxButtons;

     //DOWNBUTTON
     DownButton:=TBGRASpeedbutton.Create(Wall);
     DownButton.Parent:=Wall;
     DownButton.Top:=SongListPanel.Top+SongListPanel.Height-31;DownButton.Left:=SongListPanel.Left+1;
     DownButton.Height:=30; DownButton.Width:=SongListPanel.Width-3;
     DownButton.Flat:=True;
     BGRAImageList1.GetBitmap(1, DownButton.Glyph);
     DownButton.OnClick:=@DownButtonOnClick;
    end;
   end
   else
   begin
     For i:=0 to MaxButtons-1 do TBGRASpeedbutton(ButtonList[i]).Free;
     Upbutton.Free; DownButton.Free;
     SongListPanel.Free; ButtonList.Free; SongList.Free;
     page:=-1;
   end;
 end;

end;

procedure TFormCoverPlayer.PlayButtonOnClick(Sender: TObject);
begin
  if PlayButton.ButtonType = twPlay then PlayButton.ButtonType := twPause
                                    else PlayButton.ButtonType := twPlay;
  Form1.SB_PauzeClick(Self);
end;


procedure TFormCoverPlayer.PaintBox1DblClick(Sender: TObject);
begin
  {$IFDEF LCLQT}
  Application.ProcessMessages;
  Sleep(800);
  {$ENDIF}
  ActionLeaveExecute(PaintBox1);
end;

procedure TFormCoverPlayer.PaintBox1MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  StartOfPushX:=X; StartOfPushY:=Y;
end;

procedure TFormCoverPlayer.PaintBox1MouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  If StartOfPushX>Y then
  begin
   if (ssRight in Shift) or (ssLeft in Shift) then
   begin
     if Y<StartOfPushY-30 then
     begin
       StartOfPushX:=X;
       StartOfPushY:=StartOfPushY-34;
       Form1.SpeedButton10Click(Self);
     end;
     if Y>StartOfPushY+30 then
     begin
       StartOfPushX:=X;
       StartOfPushY:=StartOfPushY+34;
       Form1.SpeedButton11Click(Self);
     end;
   end;
  end;
end;

procedure TFormCoverPlayer.PaintBox1MouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  If StartOfPushX>0 then
  begin
    If X>StartOfPushX+30 Then ImageNextClick(Self)
                         else if X<StartOfPushX-30 then ImagePreviousClick(Self);
  end;
end;

procedure TFormCoverPlayer.ProgressBar1MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  Form1.Timer1.Enabled:=False;
end;

procedure TFormCoverPlayer.ProgressBar1MouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var divider: real;
begin
  divider:=ProgressBar1.Width/x;
  ProgressBar1.Value:=round(ProgressBar1.MaxValue/divider);
  Form1.TrackBar2.Position:=ProgressBar1.Value;
  Form1.JumpInTrackBar;
  Form1.Timer1.Enabled:=True;
end;

procedure TFormCoverPlayer.ProgressBar1MouseWheel(Sender: TObject;
  Shift: TShiftState; WheelDelta: Integer; MousePos: TPoint;
  var Handled: Boolean);
begin
   {$if not defined(HAIKU)}
  Form1.Timer1.Enabled:=False;
  if wheeldelta<0 then
  begin
    Form1.Trackbar2.Position:=Form1.TrackBar2.Position-Form1.Trackbar2.step;
    if stream=1 then BASS_ChannelSetPosition(Song_Stream1,Form1.Trackbar2.Position, BASS_POS_BYTE);
    if stream=2 then BASS_ChannelSetPosition(Song_Stream2,Form1.Trackbar2.Position, BASS_POS_BYTE);
    if stream=4 then BASS_ChannelSetPosition(ReverseStream,Form1.Trackbar2.Position, BASS_POS_BYTE);
    if stream=6 then BASS_ChannelSetPosition(Song_Stream1,Form1.Trackbar2.Position, BASS_POS_BYTE);
  end;
  if wheeldelta>0 then
  begin
     Form1.Trackbar2.Position:=Form1.TrackBar2.Position+Form1.Trackbar2.Step;
     if stream=1 then BASS_ChannelSetPosition(Song_Stream1,Form1.Trackbar2.Position, BASS_POS_BYTE);
     if stream=2 then BASS_ChannelSetPosition(Song_Stream2,Form1.Trackbar2.Position, BASS_POS_BYTE);
     if stream=4 then BASS_ChannelSetPosition(ReverseStream,Form1.Trackbar2.Position, BASS_POS_BYTE);
     if stream=6 then BASS_ChannelSetPosition(Song_Stream1,Form1.Trackbar2.Position, BASS_POS_BYTE);
  end;
  if stream=5 then BASS_ChannelSetPosition(cdStream,Form1.Trackbar2.Position, BASS_POS_BYTE);
  if stream=11 then
  begin
     BASS_ChannelStop(RadioStream); Application.ProcessMessages;
     BASS_ChannelPlay(radiostream, True);
     BASS_ChannelSetPosition(RadioStream,Form1.Trackbar2.Position,BASS_POS_DECODETO+BASS_POS_BYTE);
  end;
  if stream=12 then
  begin
     BASS_ChannelStop(RadioStream); Application.ProcessMessages;
     BASS_ChannelPlay(radiostream, True);
     BASS_ChannelSetPosition(RadioStream,Form1.Trackbar2.Position*14,BASS_POS_DECODETO+BASS_POS_BYTE);
  end;
  Application.ProcessMessages;
  Form1.Timer1.Enabled:=True;
   {$ifend}
end;


end.

