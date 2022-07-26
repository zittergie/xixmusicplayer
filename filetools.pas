unit filetools;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ComCtrls,
  Menus, Grids, StdCtrls, ExtCtrls;

type

  { TFormFileTools }

  TFormFileTools = class(TForm)
    CB_Errors: TComboBox;
    Label1: TLabel;
    Label2: TLabel;
    MainMenu1: TMainMenu;
    MenuItem1: TMenuItem;
    MenuItem2: TMenuItem;
    MenuItem3: TMenuItem;
    MenuItem4: TMenuItem;
    MenuItem5: TMenuItem;
    MenuItem6: TMenuItem;
    MenuItem7: TMenuItem;
    MenuItem8: TMenuItem;
    Panel1: TPanel;
    StatusBar1: TStatusBar;
    StringGrid1: TStringGrid;
    procedure FormClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure MenuItem2Click(Sender: TObject);
    procedure AddSongToErrors(Error: byte; x: Longint);
    procedure MenuItem6Click(Sender: TObject);
    procedure MenuItem8Click(Sender: TObject);
  private
    { private declarations }
    errors: longint;
  public
    { public declarations }
  end;

var
  FormFileTools: TFormFileTools;

implementation

uses hoofd, filecheckingsettings;

const
  MaxErrorStrings = 20;
  ErrorStrings: array[0..MaxErrorStrings] of string =
    ('No Error',
     'CAPS: Artist name',
     'CAPS: Title name',
     'CAPS: Album name',
     'LOWERCASE: Artist name',
     'LOWERCASE: Title name',
     'LOWERCASE: Album name',
     'DOUBLE SPACES: Artist name',
     'DOUBLE SPACES: Title name',
     'DOUBLE SPACES: Album name',
     'SPACES: Spaces in front/back of artist name',
     'SPACES: Spaces in front/back of title name',
     'SPACES: Spaces in front/back of album name',
     'WRONG ARTIST NAME: Artist name could be misspelled',
     'HTTP:// reference in title',
     'DB: Artist empty or ''UNKNOWN'' in database',
     'DB: Title empty or ''UNKNOWN'' in database',
     'DB: Album empty in database',
     'DB: Tracknumber empty or 0 in database',
     'DB: Genre is empty in database',
     'DB: Year is empry in database'
     );

{$R *.lfm}

{ TFormFileTools }

procedure TFormFileTools.FormShow(Sender: TObject);
var i: byte;
begin
  StatusBar1.Panels.Items[0].Text:=inttostr(maxsongs)+' songs found';
  CB_Errors.Items.Clear;
  CB_Errors.Items.Add('All Errors/Hints');
  For i:=1 to MaxErrorStrings do CB_Errors.Items.Add(Errorstrings[i]);
  CB_Errors.ItemIndex:=0;
end;

procedure TFormFileTools.FormClick(Sender: TObject);
begin

end;

procedure TFormFileTools.AddSongToErrors(Error: byte; x: Longint);
begin
  Stringgrid1.RowCount:=errors+1;
  Stringgrid1.Cells[0,errors]:=ErrorStrings[error];
  StringGrid1.Cells[1,errors]:=inttostr(x);
  Stringgrid1.Cells[2,errors]:=Liedjes[x].Artiest;
  Stringgrid1.Cells[3,errors]:=Liedjes[x].Titel;
  Stringgrid1.Cells[4,errors]:=inttostr(Liedjes[x].Track);
  Stringgrid1.Cells[5,errors]:=Liedjes[x].CD;
  Stringgrid1.Cells[6,errors]:=Liedjes[x].Jaartal;
  Stringgrid1.Cells[7,errors]:=Liedjes[x].Genre;
  Stringgrid1.Cells[8,errors]:=Liedjes[x].Pad+Liedjes[x].Bestandsnaam;
end;

procedure TFormFileTools.MenuItem6Click(Sender: TObject);
var i: longint;
begin
  Stringgrid1.RowCount:=1; errors:=0;
  for i:=0 to maxsongs-1 do
  begin
    if (Trim(Liedjes[i].Artiest)='') or (upcase(Liedjes[i].Artiest)='UNKNOWN') then
    begin
      inc(errors);
      AddSongToErrors(15,i);
    end;
    if (Trim(Liedjes[i].Titel)='')  or (upcase(Liedjes[i].Titel)='UNKNOWN') then
    begin
      inc(errors);
      AddSongToErrors(16,i);
    end;
    if (Trim(Liedjes[i].CD)='') or (upcase(Liedjes[i].CD)='UNKNOWN') then
    begin
      inc(errors);
      AddSongToErrors(17,i);
    end
    else  // Only Check Tracknumbering when CD is not empty
    begin
      if Liedjes[i].Track=0 then
      begin
        inc(errors);
        AddSongToErrors(18,i);
      end;
    end;
    if Trim(Liedjes[i].Genre)='' then
    begin
      inc(errors);
      AddSongToErrors(19,i);
    end;
    if Trim(Liedjes[i].Jaartal)='' then
    begin
      inc(errors);
      AddSongToErrors(20,i);
    end;
  end;
  StringGrid1.AutoSizeColumns;
end;

procedure TFormFileTools.MenuItem8Click(Sender: TObject);
begin
  FormFileCheckingSettings.ShowModal;
end;

procedure TFormFileTools.MenuItem2Click(Sender: TObject);
var i, i2: longint;
    templijn: String;
    UpcaseArtist, UpcaseTitle: String;
begin
  StringGrid1.RowCount:=1; errors:=0;
  for i:=0 to maxsongs-1 do
  begin
    UpcaseArtist:=upcase(Liedjes[i].Artiest);
    UpcaseTitle:=upcase(Liedjes[i].Titel);
    if (Liedjes[i].Artiest=UpcaseArtist) and (length(Liedjes[i].Artiest)>1) then           //ARTIEST Contains all CAPS
    begin
      if (not Form1.IsNumber(Liedjes[i].Artiest)) and (FormFileCheckingSettings.ListBox1.Items.IndexOf(Liedjes[i].Artiest)=-1) then
      begin
        inc(errors);
        AddSongToErrors(1,i);
      end;
    end;
    if pos('HTTP://',UpcaseTitle)>0 then
    begin
      inc(errors);
      AddSongToErrors(14,i);
    end
    else
    begin
      if (Liedjes[i].Titel=upcase(Liedjes[i].Titel)) and (length(Liedjes[i].Titel)>0) then               //TITLE Contains all CAPS
      begin
        if not Form1.IsNumber(Liedjes[i].Titel) then
        begin
          inc(errors);
          AddSongToErrors(2,i);
        end;
      end;
    end;
    if (Liedjes[i].CD=upcase(Liedjes[i].CD)) and (length(Liedjes[i].CD)>0) then                    //CD Contains all CAPS
    begin
      if not Form1.IsNumber(Liedjes[i].CD) then
      begin
        inc(errors);
        AddSongToErrors(3,i);
      end;
    end;
    if (Liedjes[i].Artiest=lowercase(Liedjes[i].Artiest)) and (length(Liedjes[i].Artiest)>1) then        //ARTIEST Contains only lowercase
    begin
      if  (not Form1.IsNumber(Liedjes[i].Artiest)) and (FormFileCheckingSettings.ListBox2.Items.IndexOf(Liedjes[i].Artiest)=-1) then
      begin
        inc(errors);
        AddSongToErrors(4,i);
      end;
    end;
    if (Liedjes[i].Titel=lowercase(Liedjes[i].Titel)) and (length(Liedjes[i].Titel)>0) then               //TITLE Contains all lowercase
    begin
      if not Form1.IsNumber(Liedjes[i].Titel) then
       begin
        inc(errors);
        AddSongToErrors(5,i);
       end;
    end;
    if (Liedjes[i].CD=lowercase(Liedjes[i].CD)) and (length(Liedjes[i].CD)>0) then                    //CD Contains all lowercase
    begin
      if not Form1.IsNumber(Liedjes[i].CD) then
      begin
        inc(errors);
        AddSongToErrors(6,i);
      end;
    end;
    if pos('  ',Liedjes[i].Artiest)>0 then
    begin
      inc(errors);
      AddSongToErrors(7,i);
    end;
    if pos('  ',Liedjes[i].Titel)>0 then
    begin
      inc(errors);
      AddSongToErrors(8,i);
    end;
    if pos('  ',Liedjes[i].CD)>0 then
    begin
      inc(errors);
      AddSongToErrors(9,i);
    end;
    if Liedjes[i].Artiest<>Trim(Liedjes[i].Artiest) then
    begin
      inc(errors);
      AddSongToErrors(10,i);
    end;
    if Liedjes[i].Titel<>Trim(Liedjes[i].Titel) then
    begin
      inc(errors);
      AddSongToErrors(11,i);
    end;
    if Liedjes[i].CD<>Trim(Liedjes[i].CD) then
    begin
      inc(errors);
      AddSongToErrors(12,i);
    end;
    if pos('HTTP://',UpcaseArtist)>0 then
    begin
      inc(errors);
      AddSongToErrors(13,i);
    end
    else
    begin
      for i2:=1 to FormFileCheckingSettings.StringGrid1.RowCount-1 do
      begin
        templijn:=FormFileCheckingSettings.StringGrid1.Cells[1,i2];
        if pos('['+Liedjes[i].Artiest+']',templijn)>0 then
        begin
         inc(errors);
         AddSongToErrors(13,i);
         break;
        end;
      end;
    end;
    //NOG CHECKEN:
    //  - Upcase first letter after space for artist (With Blacklist)
    //  - Smiths, The  iso  The Smiths
    //  - Look if Title is in artists other than its own.  If so cjanges are big that Title and Artist are upside down
  end;
  Stringgrid1.AutoSizeColumns;
end;

end.

