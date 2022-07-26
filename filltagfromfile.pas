unit filltagfromfile;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, StdCtrls, Buttons, LazFileUtils;

type

  { TFormFillTagFromFile }

  TFormFillTagFromFile = class(TForm)
    Button1: TButton;
    ComboBox1: TComboBox;
    ComboBox2: TComboBox;
    GB_FillTags: TGroupBox;
    GB_Legend: TGroupBox;
    GB_MaskEditor: TGroupBox;
    Label1: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    Label21: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    LB_Composer: TLabel;
    LB_Copyright: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    LB_Encoder: TLabel;
    LB_Genre: TLabel;
    Label2: TLabel;
    Label20: TLabel;
    LB_OrigArtist: TLabel;
    Label22: TLabel;
    Label23: TLabel;
    Label24: TLabel;
    Label25: TLabel;
    Label26: TLabel;
    LB_Track: TLabel;
    LB_Title: TLabel;
    Label29: TLabel;
    Label3: TLabel;
    LB_Year: TLabel;
    Label31: TLabel;
    Label32: TLabel;
    LB_Ignore: TLabel;
    LB_Example: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    LB_Artist: TLabel;
    LB_Album: TLabel;
    LB_Comment: TLabel;
    ListBox1: TListBox;
    SpeedButton2: TSpeedButton;
    SpeedButton3: TSpeedButton;
    SpeedButton4: TSpeedButton;
    SpeedButton5: TSpeedButton;
    SpeedButton6: TSpeedButton;
    procedure Button1Click(Sender: TObject);
    procedure ComboBox1Select(Sender: TObject);
    procedure ComboBox2Change(Sender: TObject);
    function DecodeToFilename(item: longint; mask: string): string;
    Procedure DecodeFromFilename(bestandsnaam, mask: string);
    procedure FormShow(Sender: TObject);
    procedure ListBox1DblClick(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure SpeedButton5Click(Sender: TObject);
    procedure SpeedButton6Click(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  FormFillTagFromFile: TFormFillTagFromFile;

implementation

uses id3tagger, hoofd;

{$R *.lfm}

{ TFormFillTagFromFile }

Function TFormFillTagFromFile.DecodeToFilename(item: longint;mask: string): string;
var lijn, Track: string;
    i: integer;
begin
  lijn:=mask;
  if Settings.IncludeLocaleDirs.Count>0 then For i:=1 to Settings.IncludeLocaleDirs.Count
    do lijn:=StringReplace(lijn,'%LOCAL['+inttostr(i)+']%',Settings.IncludeLocaleDirs.Strings[i-1],[rfReplaceAll, rfIgnoreCase]);
  if Settings.IncludeExternalDirs.Count>0 then For i:=1 to Settings.IncludeLocaleDirs.Count
    do lijn:=StringReplace(lijn,'%EXTERNAL['+inttostr(i)+']%',Settings.IncludeExternalDirs.Strings[i-1],[rfReplaceAll, rfIgnoreCase]);
  lijn:=StringReplace(lijn,'~',HomeDir,[rfReplaceAll, rfIgnoreCase]);
 // lijn:=StringReplace(lijn,'%VAULT%',Settings.VaultDir,[rfReplaceAll, rfIgnoreCase]);
  lijn:=StringReplace(lijn,'%a',Tag_Liedjes[item].Artiest,[rfReplaceAll, rfIgnoreCase]);
  lijn:=StringReplace(lijn,'%b',Tag_Liedjes[item].CD,[rfReplaceAll, rfIgnoreCase]);
  lijn:=StringReplace(lijn,'%c',Tag_Liedjes[item].Comment,[rfReplaceAll, rfIgnoreCase]);
  lijn:=StringReplace(lijn,'%p',Tag_Liedjes[item].Composer,[rfReplaceAll, rfIgnoreCase]);
  lijn:=StringReplace(lijn,'%r',Tag_Liedjes[item].Copyright,[rfReplaceAll, rfIgnoreCase]);
  lijn:=StringReplace(lijn,'%p',Tag_Liedjes[item].Genre,[rfReplaceAll, rfIgnoreCase]);
  lijn:=StringReplace(lijn,'%o',Tag_Liedjes[item].OrigArtiest,[rfReplaceAll, rfIgnoreCase]);
  Track:=inttostr(Tag_Liedjes[item].Track); if length(Track)=1 then Track:='0'+Track;
  lijn:=StringReplace(lijn,'%n',Track,[rfReplaceAll, rfIgnoreCase]);
  lijn:=StringReplace(lijn,'%t',Tag_Liedjes[item].Titel,[rfReplaceAll, rfIgnoreCase]);
  lijn:=StringReplace(lijn,'%y',Tag_Liedjes[item].Jaartal,[rfReplaceAll, rfIgnoreCase]);
  if length(Tag_Liedjes[item].artiest)>0 then lijn:=StringReplace(lijn,'%1',Upcase(Tag_Liedjes[item].artiest[1]),[rfReplaceAll, rfIgnoreCase]);
  DecodeToFilename:=lijn;
end;

Procedure TFormFillTagFromFile.DecodeFromFilename(bestandsnaam, mask: string);
var tempstr, track: string;
    lijn, lijnbestand, matchedStr: string;
    teller, sl: integer;
    ch, ch2: char;
begin
  teller:=1; lijn:=mask+'%i'; lijnbestand:=bestandsnaam;
  LiedjesTemp.Artiest:=''; LiedjesTemp.Titel:='';
  LiedjesTemp.CD:=''; LiedjesTemp.Track:=0;
  LiedjesTemp.Composer:='';LiedjesTemp.Jaartal:='';
  LiedjesTemp.Copyright:=''; LiedjesTemp.OrigArtiest:='';
  LiedjesTemp.Comment:=''; LiedjesTemp.Genre:='';

 repeat
  repeat
    ch:=lijn[teller];
    inc(teller);
  until (ch='%') or (teller>length(lijn));

  if teller<length(lijn) then
  begin
    ch:=lijn[teller]; inc(teller); tempstr:='';
    repeat
      ch2:=lijn[teller]; if ch2<>'%' then
                                     begin
                                       tempstr:=tempstr+ch2;
                                       inc(teller);
                                     end;
    until (ch2='%') or (teller>=length(lijn));

    sl := pos(tempstr,lijnbestand);
    if sl=0 then
    begin
      // lets try with track or year field
      if (ch='n') or (ch='y') then
      begin
        // this should be numeric values, consume as many digit as there are
        while (sl<Length(lijnbestand)) and (lijnbestand[sl+1] in ['0'..'9']) do
          inc(sl);
      end;
      if sl=0 then
        sl := length(lijnbestand)+1; // the rest of string
    end;

    matchedStr := copy(lijnbestand,1,sl-1);
    case ch of
      'a': begin
             LiedjesTemp.Artiest:=matchedStr;
             Delete(lijnbestand,1,sl+length(tempstr)-1);
           end;
      'b': begin
             LiedjesTemp.CD:=matchedStr;
             Delete(lijnbestand,1,sl+length(tempstr)-1);
           end;
      'n': begin
             Track:=matchedStr;
             LiedjesTemp.Track:=Strtointdef(Track,0);
             Delete(lijnbestand,1,sl+length(tempstr)-1);
           end;
      't': begin
             if length(tempstr)=0 then LiedjesTemp.Titel:=lijnbestand
                                  else LiedjesTemp.Titel:=matchedStr;
             Delete(lijnbestand,1,sl+length(tempstr)-1);
           end;
      'c': begin
             if length(tempstr)=0 then LiedjesTemp.Comment:=lijnbestand
                                  else LiedjesTemp.Comment:=matchedStr;
             Delete(lijnbestand,1,sl+length(tempstr)-1);
           end;
      'p': begin
             if length(tempstr)=0 then LiedjesTemp.Composer:=lijnbestand
                                  else LiedjesTemp.Composer:=matchedStr;
             Delete(lijnbestand,1,sl+length(tempstr)-1);
           end;
      'r': begin
             if length(tempstr)=0 then LiedjesTemp.Copyright:=lijnbestand
                                  else LiedjesTemp.Copyright:=matchedStr;
             Delete(lijnbestand,1,sl+length(tempstr)-1);
           end;
      'g': begin
             if length(tempstr)=0 then LiedjesTemp.Genre:=lijnbestand
                                  else LiedjesTemp.Genre:=matchedStr;
             Delete(lijnbestand,1,sl+length(tempstr)-1);
           end;
      'o': begin
             if length(tempstr)=0 then LiedjesTemp.OrigArtiest:=lijnbestand
                                  else LiedjesTemp.OrigArtiest:=matchedStr;
             Delete(lijnbestand,1,sl+length(tempstr)-1);
           end;
      'y': begin
             if length(tempstr)=0 then LiedjesTemp.Jaartal:=lijnbestand
                                  else LiedjesTemp.Jaartal:=matchedStr;
             Delete(lijnbestand,1,sl+length(tempstr)-1);
           end;
    end;
  end;
 until (teller>length(lijn)) or (length(tempstr)=0);
 lijn:='';
 if LiedjesTemp.Artiest<>'' then lijn:='%a="'+LiedjesTemp.Artiest+'"  ';
 if LiedjesTemp.Track>0 then lijn:=lijn + '%n="'+inttostr(LiedjesTemp.Track)+'"  ';
 if LiedjesTemp.Titel<>'' then lijn:=lijn + '%t="'+LiedjesTemp.Titel+'"  ';
 if LiedjesTemp.CD<>'' then lijn:=lijn+'%b="'+LiedjesTemp.cd+'"  ';
 LB_Example.Caption:=lijn;
end;

procedure TFormFillTagFromFile.ComboBox2Change(Sender: TObject);
begin
  If ComboBox1.ItemIndex=0 then
  begin
    DecodeFromFilename(FormID3Tagger.Edit_File.Text,Combobox2.Text);
    Settings.MaskToTag:=Combobox2.Text;
  end;
  If Combobox1.ItemIndex=1 then
  begin
    LB_Example.Caption:=DecodeToFilename(FormID3Tagger.ListBox1.ItemIndex, Combobox2.Text)+FormID3Tagger.Label16.Caption;
    Settings.MaskToFile:=Combobox2.Text;
  end;
end;

procedure TFormFillTagFromFile.ComboBox1Select(Sender: TObject);
begin
  If ComboBox1.ItemIndex=0 then
  begin
    Label7.Enabled:=False; Label8.Enabled:=False;
    Label9.Enabled:=False; Label10.Enabled:=False;
    Label11.Enabled:=False; Label18.Enabled:=False;
    Label26.Enabled:=False; Label31.Enabled:=False;
    Label32.Enabled:=False; LB_Ignore.Enabled:=False;
    Combobox2.Text:=Settings.MaskToTag;
  end;
  If Combobox1.ItemIndex=1 then
  begin
    Label7.Enabled:=True; Label8.Enabled:=True;
    Label9.Enabled:=True; Label10.Enabled:=True;
    Label11.Enabled:=True; Label18.Enabled:=True;
    Label26.Enabled:=True; Label31.Enabled:=True;
    Label32.Enabled:=True; LB_Ignore.Enabled:=True;
    ComboBox2.Text:=Settings.MaskToFile;
  end;
  ComboBox2Change(Self);
end;

procedure TFormFillTagFromFile.Button1Click(Sender: TObject);
begin
  Close;
end;

procedure TFormFillTagFromFile.FormShow(Sender: TObject);
begin
  Combobox2.Items:=Listbox1.Items;
  GB_FillTags.Caption:=Form1.Vertaal('TAG/RENAME mask');
  LB_Artist.Caption:=Form1.Vertaal('Artist');
  LB_Album.Caption:=Form1.Vertaal('Album');
  LB_Comment.Caption:=Form1.Vertaal('Comment');
  LB_Composer.Caption:=Form1.Vertaal('Composer');
  LB_Copyright.Caption:=Form1.Vertaal('Copyright');
  LB_Track.Caption:=Form1.Vertaal('Track');
  LB_Title.Caption:=Form1.Vertaal('Title');
  LB_Year.Caption:=Form1.Vertaal('Year');
  LB_Encoder.Caption:=Form1.Vertaal('Encoder');
  LB_Genre.Caption:=Form1.Vertaal('Genre');
  LB_OrigArtist.Caption:=Form1.Vertaal('Orig. Artist');
  LB_Ignore.Caption:=Form1.Vertaal('Ignore');
  GB_Legend.Caption:=Form1.Vertaal('Legend');
  GB_MaskEditor.Caption:=Form1.Vertaal('Mask Editor');
  Button1.Caption:=Form1.Vertaal('Close');
  ComboBox1.Items[0]:=Form1.Vertaal('Fill Tags');
  ComboBox1.Items[1]:=Form1.Vertaal('Rename Files');
  SpeedButton6.Hint:=Form1.Vertaal('Copy to the MASK EDITOR');
  Speedbutton2.Hint:=Form1.Vertaal('Remove MASK from MASK EDITOR');
end;

procedure TFormFillTagFromFile.ListBox1DblClick(Sender: TObject);
begin
  If Listbox1.ItemIndex>=0 then ComboBox2.Text:=Listbox1.Items[Listbox1.ItemIndex];
  ComboBox2Change(Self);
end;

procedure TFormFillTagFromFile.SpeedButton2Click(Sender: TObject);
begin
  If ListBox1.ItemIndex>=0 then Listbox1.Items.Delete(Listbox1.ItemIndex);
end;

procedure TFormFillTagFromFile.SpeedButton5Click(Sender: TObject);
var i: longint;
    bestandsnaam, ext, lijn: string;
    newPath, newFilename: string;
begin
  if ComboBox1.ItemIndex=0 then     // Fill in TAGS
  begin
    for i:=0 to FormID3Tagger.ListBox1.Items.Count-1 do
      if FormID3Tagger.ListBox1.Selected[i] then
      begin
        ext:=ExtractFileExt(Tag_Liedjes[i].Bestandsnaam);
        bestandsnaam:=copy(Tag_Liedjes[i].Bestandsnaam,1,length(Tag_Liedjes[i].Bestandsnaam)-length(ext));
        DecodeFromFilename(bestandsnaam, ComboBox2.Text);
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
        changedTag[i]:=True;
        FormID3Tagger.Memo1.Lines.Add('> TAGS changed for '+Tag_Liedjes[i].Bestandsnaam);
      end;
  end;
  if ComboBox1.ItemIndex=1 then     // Make Filename
  begin
    for i:=0 to FormID3Tagger.ListBox1.Items.Count-1 do
      if FormID3Tagger.ListBox1.Selected[i] then
      begin
        ext:=ExtractFileExt(Tag_Liedjes[i].Bestandsnaam);
        lijn:=DecodeToFilename(i,ComboBox2.Text)+ext;
        if pos(DirectorySeparator,lijn)<1 then
        begin
          newFilename:=lijn;
          newPath:=Tag_Liedjes[i].Pad;
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

        Tag_Liedjes[i].Bestandsnaam:=newFilename;
        Tag_Liedjes[i].Pad:=newPath;

        if changedFilename[i] then
        begin
          if Liedjes[TagVolgorde[i]].Pad=newPath then
            FormID3Tagger.Log('> FILENAME changed for %s to %s',[Liedjes[TagVolgorde[i]].Bestandsnaam, newFilename])
          else
          if CompareFilenames(Liedjes[TagVolgorde[i]].Bestandsnaam, newFilename)=0 then
            FormID3Tagger.Log('> PATH changed for %s from %s to %s',[Liedjes[TagVolgorde[i]].Bestandsnaam, Liedjes[TagVolgorde[i]].Pad, newPath])
          else
            FormID3Tagger.Log('> PATH+FILENAME changed for %s to %s',
              [Liedjes[TagVolgorde[i]].Pad+Liedjes[TagVolgorde[i]].Bestandsnaam,newPath+newFilename]);
        end;

      end;
  end;
  FormID3Tagger.ReloadCurrentSongTags;
end;

procedure TFormFillTagFromFile.SpeedButton6Click(Sender: TObject);
begin
  ListBox1.Items.Add(ComboBox2.Text);
  ComboBox2.Items.Add(ComboBox2.Text);
end;

end.

