unit search;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  StdCtrls, Buttons;

type

  { TFormSearch }

  TFormSearch = class(TForm)
    Bevel1: TBevel;
    CheckBox1: TCheckBox;
    CB_Artist: TCheckBox;
    CB_Title: TCheckBox;
    CB_CD: TCheckBox;
    CB_Genre: TCheckBox;
    CB_Year: TCheckBox;
    CB_Filename: TCheckBox;
    CB_Comments: TCheckBox;
    CB_Lyrics: TCheckBox;
    CB_Composer: TCheckBox;
    CB_OrigArtist: TCheckBox;
    CB_Orchestra: TCheckBox;
    CB_Conductor: TCheckBox;
    CB_Interpreted: TCheckBox;
    CB_OrigTitle: TCheckBox;
    CB_OrigYear: TCheckBox;
    CB_SubTitle: TCheckBox;
    CB_GroupTitle: TCheckBox;
    Edit1: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Panel1: TPanel;
    Shape1: TShape;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    Image1: TImage;
    procedure Edit1KeyPress(Sender: TObject; var Key: char);
    procedure FormShow(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  FormSearch: TFormSearch;

implementation

uses hoofd;

{$R *.lfm}

{ TFormSearch }

procedure TFormSearch.SpeedButton2Click(Sender: TObject);
begin
  Close;
end;

procedure TFormSearch.SpeedButton1Click(Sender: TObject);
var gevonden: boolean;
    aantal, i: longint;
    zoekstring, liedjesstring: string;
begin
  zoekstring:=Edit1.Text;
  if not checkbox1.Checked then zoekstring:=upcase(zoekstring);;
  aantal:=0;
  for i:=0 to maxsongs-1 do
  begin
    gevonden:=false;Liedjesstring:=' ';
    if CB_Artist.Checked then liedjesstring:=Liedjesstring+Liedjes[i].Artiest+' ';
    if CB_Title.Checked then liedjesstring:=liedjesstring+Liedjes[i].Titel+' ';
    if CB_CD.Checked then liedjesstring:=liedjesstring+Liedjes[i].CD+' ';
    if CB_Genre.Checked then liedjesstring:=liedjesstring+Liedjes[i].Genre+' ';
    if CB_Year.Checked then liedjesstring:=liedjesstring+Liedjes[i].Jaartal+' ';
    if CB_Filename.Checked then liedjesstring:=liedjesstring+Liedjes[i].Bestandsnaam+' ';
    if CB_Comments.Checked then liedjesstring:=liedjesstring+Liedjes[i].Comment+' ';
    if CB_Composer.Checked then liedjesstring:=liedjesstring+Liedjes[i].Composer+' ';
    if CB_Orchestra.Checked then liedjesstring:=liedjesstring+Liedjes[i].Orchestra+' ';
    if CB_Conductor.Checked then liedjesstring:=liedjesstring+Liedjes[i].Conductor+' ';
    if CB_Interpreted.Checked then liedjesstring:=liedjesstring+Liedjes[i].Interpreted+' ';
    if CB_GroupTitle.Checked then liedjesstring:=liedjesstring+Liedjes[i].GroupTitel+' ';
    if CB_SubTitle.Checked then liedjesstring:=liedjesstring+Liedjes[i].SubTitel+' ';
    if CB_OrigArtist.Checked then liedjesstring:=liedjesstring+Liedjes[i].OrigArtiest+' ';
    if CB_OrigTitle.Checked then liedjesstring:=liedjesstring+Liedjes[i].OrigTitle+' ';
    if CB_OrigYear.Checked then liedjesstring:=liedjesstring+Liedjes[i].OrigYear;
    if not Checkbox1.Checked then liedjesstring:=upcase(liedjesstring);
    if pos(zoekstring, liedjesstring)>0 then gevonden:=true;
    if gevonden then
    begin
      inc(aantal);
      Form1.SG_All.RowCount:=aantal+1;
      Form1.SG_All.Cells[0,aantal]:=inttostr(i);
      Form1.SG_All.Cells[1,aantal]:=Liedjes[i].Artiest;
      if Liedjes[i].Track=0 then Form1.SG_All.Cells[2,aantal]:=''
                            else if Liedjes[i].Track<10 then Form1.SG_All.Cells[2,aantal]:='0'+inttostr(Liedjes[i].Track)
                                                        else Form1.SG_All.Cells[2,aantal]:=inttostr(Liedjes[i].Track);
      Form1.SG_All.Cells[3,aantal]:=Liedjes[i].Titel;
      Form1.SG_All.Cells[4,aantal]:=Liedjes[i].CD;
      Form1.SG_All.Cells[COL_SG_ALL_PATH,aantal]:=Liedjes[i].Pad;
      Form1.SG_All.Cells[COL_SG_ALL_NAME,aantal]:=Liedjes[i].Bestandsnaam;
    end;
  end;
  if aantal=0 then showmessage(Form1.Vertaal('No songs found'))
              else begin
                     Form1.AutosizeAllColumns;
                     Form1.PageControl1.PageIndex:=0;
                     Form1.PageControl2.PageIndex:=0;
                   end;
  close;
end;

procedure TFormSearch.Edit1KeyPress(Sender: TObject; var Key: char);
begin
    if key=#13 then SpeedButton1Click(Self);
end;

procedure TFormSearch.FormShow(Sender: TObject);
begin
  FormSearch.Caption:=Form1.Vertaal('Search');
  SpeedButton1.Caption:=Form1.Vertaal('Search');
  Speedbutton2.Caption:=Form1.Vertaal('Cancel');
  Label2.Caption:=Form1.Vertaal('Fast Search')+':';
  Label3.Caption:=Form1.Vertaal('INCLUDE')+':';
  CheckBox1.Caption:=Form1.Vertaal('Case sensitive');
  CB_Artist.Caption:=Form1.Vertaal('Artist');
  CB_Title.Caption:=Form1.Vertaal('Title');
  CB_CD.Caption:=Form1.Vertaal('Album');
  CB_Genre.Caption:=Form1.Vertaal('Genre');
  CB_Year.Caption:=Form1.Vertaal('Year');
  CB_Filename.Caption:=Form1.Vertaal('Filename');
  CB_Comments.Caption:=Form1.Vertaal('Comments');
  CB_Lyrics.Caption:=Form1.Vertaal('Lyrics');
  CB_Composer.Caption:=Form1.Vertaal('Composer');
  CB_OrigArtist.Caption:=Form1.Vertaal('Original artist');
(*  {$IFDEF LINUX}
    //BUG IN GTK2
    Panel1.Font.Size:=9; Panel1.Font.Color:=clHighlightText;
    CheckBox1.Font.Size:=9; CheckBox1.Font.Color:=clHighlightText;
  {$ENDIF}  *)
end;

end.

