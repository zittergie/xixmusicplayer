unit fetchlyrics;

{$mode objfpc}{$H+}


interface

uses
  Classes, SysUtils, FileUtil, httpsend, LazFileUtils, openssl, fphttpclient;

type
  TLyrics = class
    private
    public
      ExtraStartLines  : Byte;
      MakeBreaks, DeleteInlineScripts: Boolean;
      BaseURL, MaskURL: string;
      StartString, EndString: Array[1..2] of string;
      NotFound, Version: String;
      NotFoundCounter: byte;
      LyricURL, IgnoreChars: string;
      AllLyricSourceFiles: TStringlist;
      SourceArtist, TargetArtist: TStringlist;
      LyricsText: TStringList;
      SourceMasked: Array[1..2] of string;
      TargetMaskedChar: Array[1..2] of string;
      destructor destroy; override;
      procedure GetLyricSources(folder: string);
      procedure GetSourceInfo(filename: string);
      procedure CreateLyricURL(artist, title: string);
      Function GetLyric(url: String): Boolean;
    end;

implementation

uses hoofd;

destructor TLyrics.destroy;
begin
  LyricsText.Free;
  AllLyricSourceFiles.Free;
  inherited destroy;
end;

procedure TLyrics.GetLyricSources(folder: string);
begin
  AllLyricSourceFiles:=TStringlist.Create;
  AllLyricSourceFiles:=FindAllFiles(folder,'*.lpl', True);
end;

procedure TLyrics.GetSourceInfo(filename: string);
var FileVar: TextFile;
    lijn: string;
begin
  if Fileexists(filename) then
  begin
    IgnoreChars:='';
    AssignFile(FileVar,filename);
    Reset(FileVar);
    readln(FileVar, lijn);
    if lijn='XIX Lyrics Plugin' then
    begin
      readln(Filevar,Version);
      readln(Filevar,BaseURL);
      readln(Filevar,MaskURL);
      readln(Filevar,lijn);
      if lijn='[IGNORECHARS]' then
      begin
        readln(Filevar,IgnoreChars);
        readln(Filevar,lijn);
      end;
      if lijn='[REPLACECHARS]' then
      begin
        readln(Filevar,SourceMasked[1]);
        SourceMasked[2]:='';
        readln(Filevar,lijn); if length(lijn)>0 then TargetMaskedChar[1]:=lijn[1]
                                                else TargetMaskedChar[1]:='';
        readln(Filevar,lijn); //[DROP]
        if lijn<>'[DROP]' then
        begin
          SourceMasked[2]:=lijn;
          readln(Filevar,lijn); if length(lijn)>0 then TargetMaskedChar[2]:=lijn[1]
                                                  else TargetMaskedChar[2]:='';
          readln(Filevar,lijn); //[DROP]
        end;
      end;
      if lijn='[DROP]' then
      begin
        readln(Filevar,StartString[1]);
        readln(Filevar,StartString[2]);
      end;
      readln(Filevar,lijn);   //[REND]
      readln(Filevar,lijn);   //[READ]
      if lijn='[READ]' then
      begin
        readln(Filevar,EndString[1]);
        readln(Filevar,EndString[2]);
      end;
      readln(Filevar,lijn);   //[END]
      readln(Filevar,lijn);   //[NOT FOUND]
      readln(Filevar,lijn);  NotFoundCounter:=StrtointDef(lijn,0);
      readln(Filevar,lijn);  NotFound:=lijn;
      readln(Filevar,lijn);   //[END]
      readln(Filevar,lijn);   //[EXTRA]
      readln(Filevar,lijn); ExtraStartLines:=Strtointdef(lijn,0);
      Readln(Filevar,lijn); if lijn='0' then MakeBreaks:=False
                                        else MakeBreaks:=True;
    end;
    CloseFile(FileVar);
  end;
end;

procedure TLyrics.CreateLyricURL(artist, title: string);
var i, i2: integer;
    ExtendedURL: string;
begin
  if IgnoreChars<>'' then
    begin
      for i2:=1 to length(IgnoreChars) do
      begin
        artist:=StringReplace(artist,IgnoreChars[i2],'',[rfReplaceAll]);
        title:=StringReplace(title,IgnoreChars[i2],'',[rfReplaceAll]);
      end;
    end;
  for i:=1 to 2 do
  begin
    if SourceMasked[i]<>'' then
    begin
      for i2:=1 to length(SourceMasked[i]) do
      begin
        artist:=StringReplace(artist,'10.000','10000',[rfReplaceAll]);
        artist:=StringReplace(artist,SourceMasked[i][i2],TargetMaskedChar[i],[rfReplaceAll]);
        title:=StringReplace(title,SourceMasked[i][i2],TargetMaskedChar[i],[rfReplaceAll]);
      end;
    end;
  end;
  ExtendedURL:=MaskURL;
  if pos('{a}',ExtendedURL)>0 then
  begin
    if artist[1] in ['0'..'9'] then ExtendedURL:=StringReplace(ExtendedURL,'{a}','0-9',[rfReplaceAll])
                               else ExtendedURL:=StringReplace(ExtendedURL,'{a}',lowercase(artist[1]),[rfReplaceAll]);
  end;
  ExtendedURL:=StringReplace(ExtendedURL,'{artist}',lowercase(artist),[rfReplaceAll]);
  if pos('{Artist}',ExtendedURL)>0 then artist[1]:=Upcase(artist[1]);
  ExtendedURL:=StringReplace(ExtendedURL,'{Artist}',artist,[rfReplaceAll]);
  Title:=StringReplace(Title,'&','%26',[rfReplaceAll]);
  ExtendedURL:=StringReplace(ExtendedURL,'{title}',lowercase(title),[rfReplaceAll]);
  if pos('{Title}',ExtendedURL)>0 then
  begin
    title[1]:=Upcase(Title[1]);
   // StringReplace(Title,'&','%26',[rfReplaceAll]);
  end;
  ExtendedURL:=StringReplace(ExtendedURL,'{Title}',title,[rfReplaceAll]);
  ExtendedURL:=StringReplace(ExtendedURL,' ','%20',[rfReplaceAll]);
  LyricURL:=BaseURL+ExtendedURL;
end;

function TLyrics.GetLyric(url: String): boolean;
var fs: TFilestream;
    TempDir, Temp, TempStr, BreakStr: String;
    goed, gevonden: Boolean;
    i, i2, i3, teller, positie, positie2: integer;
    TempStringList: Tstringlist;
    Filevar: TextFile;
begin
  if LyricsText=nil then LyricsText:=TStringList.Create;
  LyricsText.Clear; goed:=false;
  TempDir:=ChompPathDelim(GetTempDir(False));

  {$IFDEF HAIKU}
  DeleteFile(TempDir+Directoryseparator+'songtext.txt');
  If Form1.DownLoadFile(url,TempDir+Directoryseparator+'songtext.txt') then
  goed:=true;
  {$ELSE}
(*  AssignFile(Filevar,TempDir+Directoryseparator+'songtext.txt');
  Rewrite(Filevar);
  writeln(Filevar,TFPHttpClient.SimpleGet(url));
  CloseFile(Filevar);   *)

  if Form1.DownloadFile(url,TempDir+Directoryseparator+'songtext.txt') then goed:=true;
(*  fs := TFileStream.Create(TempDir+Directoryseparator+'songtext.txt', fmOpenWrite or fmCreate);
  try
    goed:=HttpGetBinary(url, fs);
  finally
    fs.Free;
  end;     *)
  {$ENDIF}

  if goed then
  begin
  LyricsText.LoadFromFile(TempDir+Directoryseparator+'songtext.txt');

  if MakeBreaks then
  begin
    TempStringList:=TStringlist.Create;
    TempStringList.AddStrings(LyricsText);
    LyricsText.Clear;  i:=0;
    if TempStringList.Count>0 then
    begin
    while i<TempStringList.Count do
    begin
      Temp:=TempStringList[i];
      BreakStr:='*';
      if BreakStr='*' then
      begin
        if pos('<br/>', Temp)>0 then BreakStr:='<br/>';
        if pos('<br>', Temp)>0 then BreakStr:='<br>';
        if pos('<br />', Temp)>0 then BreakStr:='<br />';
      end;
      if Breakstr<>'*' then
      begin
       repeat
        TempStr:=Copy(Temp,1,Pos(Breakstr,Temp)-1);
        Delete(Temp,1,Pos(BreakStr,Temp)+length(Breakstr)-1);
        LyricsText.Add(trim(Tempstr));
       until pos(BreakStr,Temp)<1;
      end;
      LyricsText.Add(trim(Temp));
      Inc(i);
    end;
    end;
    TempStringList.Free;
  end;
   //ShowMessage(LyricsText.Strings[1]);

  if LyricsText.Count<1 then exit;
  gevonden:=true;
  i3:=1;

  repeat
   If StartString[i3]<>'' then
   begin
    for i:=0 to LyricsText.Count-1 do
    begin
      if NotFoundCounter>0 then if pos(NotFound,LyricsText.Strings[i])>0 then
      begin
        LyricsText.Clear;
        GetLyric:=false;
        exit;
      end;
      if pos(StartString[i3],LyricsText.Strings[i])>0 then break;
    end;

    if i=LyricsText.Count-1 then
    begin
      LyricsText.Clear;
      GetLyric:=false;
      exit;
    end
    else for i2:=i-ExtraStartLines downto 0 do LyricsText.Delete(i2);

    if (ExtraStartLines>0) and (i3=1) then
    begin
      Temp:=LyricsText.Strings[0];
      Delete(Temp,1,pos(StartString[1],Temp)+length(StartString[1])-1);
      If pos('''>',Temp)>1 then Delete(Temp,1,pos('''>',Temp)+1);
      LyricsText.Strings[0]:=trim(Temp);
    end;
   end;
   inc(i3);
  until i3=3;

  If EndString[1]<>'' then
  begin
    i3:=LyricsText.Count-1;
    for i:=1 to LyricsText.Count-1 do
    begin
      if pos(EndString[1],LyricsText.Strings[i])>0 then break;
      if EndString[2]<>'' then if pos(EndString[2],LyricsText.Strings[i])>0 then break;
    end;
    if i3=i then
    begin
      LyricsText.Clear;
      GetLyric:=false;
      exit;
    end;

    for i2:=i3 downto i+1 do LyricsText.Delete(i2);
    temp:=LyricsText.Strings[i];
    if pos(EndString[1],Temp)>0 then
    begin
      Delete(Temp,pos(EndString[1],Temp),length(temp));
      LyricsText.Strings[i]:=trim(Temp);
    end;
    if EndString[2]<>'' then
     if pos(EndString[2],Temp)>0 then
     begin
       Delete(Temp,pos(EndString[2],Temp),length(temp));
       LyricsText.Strings[i]:=trim(Temp);
     end;
  end;

  if LyricsText.Count>0 then
  begin
    i:=0;
    if pos('">',LyricsText.Strings[i])>1 then
    begin
      Temp:=LyricsText.Strings[i];
      Delete(Temp,1,pos('">',Temp)+1);
      LyricsText.Strings[i]:=trim(Temp);
    end;
    repeat
      if pos('adsbygoogle',LyricsText.Strings[i])>0 then LyricsText.Delete(i);
      if pos('<script>',LyricsText.Strings[i])>0 then
      begin
        while pos('</script>',LyricsText.Strings[i])<1 do LyricsText.Delete(i);
        LyricsText.Delete(i);// LyricsText.Delete(i);
      end;
      if pos('<!--',LyricsText.Strings[i])=1 then LyricsText.Delete(i);
      if pos('-->',LyricsText.Strings[i])>0 then LyricsText.Delete(i);
      if pos('<div ',LyricsText.Strings[i])>0 then LyricsText.Delete(i);

      LyricsText.Strings[i]:=StringReplace(LyricsText.Strings[i],'<br/>',#13,[rfReplaceAll]);
      LyricsText.Strings[i]:=StringReplace(LyricsText.Strings[i],'<br />',#13,[rfReplaceAll]);
      LyricsText.Strings[i]:=StringReplace(LyricsText.Strings[i],'<br>',#13,[rfReplaceAll]);
      LyricsText.Strings[i]:=StringReplace(LyricsText.Strings[i],'<i>','',[rfReplaceAll]);
      LyricsText.Strings[i]:=StringReplace(LyricsText.Strings[i],'</i>','',[rfReplaceAll]);
      LyricsText.Strings[i]:=StringReplace(LyricsText.Strings[i],'<strong>','',[]);
      LyricsText.Strings[i]:=StringReplace(LyricsText.Strings[i],'</strong>','',[]);
      LyricsText.Strings[i]:=StringReplace(LyricsText.Strings[i],'<div>','',[]);
      LyricsText.Strings[i]:=StringReplace(LyricsText.Strings[i],'</div>','',[]);
      LyricsText.Strings[i]:=StringReplace(LyricsText.Strings[i],'<p>',#13,[rfReplaceAll]);
      LyricsText.Strings[i]:=StringReplace(LyricsText.Strings[i],'</p>',#13,[rfReplaceAll]);
      LyricsText.Strings[i]:=StringReplace(LyricsText.Strings[i],'</a>','',[]);
      LyricsText.Strings[i]:=StringReplace(LyricsText.Strings[i],'</span>','',[]);
      LyricsText.Strings[i]:=StringReplace(LyricsText.Strings[i],'<p class=''verse''>',#10,[rfReplaceAll]);
      LyricsText.Strings[i]:=StringReplace(LyricsText.Strings[i],'<p class="writers">','',[rfReplaceAll]);
      LyricsText.Strings[i]:=StringReplace(LyricsText.Strings[i],'<p class="lyrics">','',[rfReplaceAll]);
      LyricsText.Strings[i]:=StringReplace(LyricsText.Strings[i],'&copy;','(c)',[rfReplaceAll]);
      LyricsText.Strings[i]:=StringReplace(LyricsText.Strings[i],'&quot;','"',[rfReplaceAll]);
      if pos('<span',LyricsText.Strings[i])>0 then
      begin
        Temp:=trim(LyricsText.Strings[i]);
       // Form1.Memo2.Lines.Add('*'+Temp+'*');
        positie:=pos('<span',Temp);
        positie2:=pos('>',Temp);
        Delete(Temp,positie,positie2-positie+1);
        LyricsText.Strings[i]:=trim(Temp);
      end;
      if pos('<a',LyricsText.Strings[i])>0 then
      begin
        Temp:=trim(LyricsText.Strings[i]);
        positie:=pos('<a',Temp);
        Delete(Temp,positie,pos('>',Temp));
        LyricsText.Strings[i]:=trim(Temp);
      end;
      inc(i);
    until i>=LyricsText.Count;

    teller:=LyricsText.Count-1;
    if teller>0 then
    begin

      repeat
        if length(LyricsText.Strings[teller])=0 then LyricsText.Delete(teller);
        dec(teller);
      until (length(LyricsText.Strings[teller])>1) or (teller=0);

      if LyricsText.Count<5 then
      begin
        i2:=0;
        for i:=0 to  LyricsText.Count-1 do i2:=i2+length(LyricsText.Strings[i]);
        if i2 < 3 then LyricsText.Clear;
      end;
    end;
  end;

  if (LyricsText.Count>NotFoundCounter) and (NotFoundCounter<>0) then
  begin
    gevonden:=true;
    for i:=0 to NotFoundCounter-1 do
    begin
      if pos(NotFound,LyricsText.Strings[i])>0 then
      begin
        gevonden:=false;
        break;
      end;
    end;
    if not gevonden then LyricsText.Clear;
  end;

  if gevonden then if LyricsText.Count>1 then
  begin
    LyricsText.Strings[0]:=Trim(LyricsText.Strings[0]);
    LyricsText.Strings[LyricsText.Count-1]:=Trim(LyricsText.Strings[LyricsText.Count-1]);
    temp:=LyricsText.Strings[0];
    if pos('<',temp)=1 then
    begin
      delete(temp,1,pos('>',temp));
      LyricsText.Strings[0]:=temp;
    end;
    temp:=trim(LyricsText.Strings[1]);
    if pos('<',temp)=1 then
    begin
      delete(temp,1,pos('>',temp));
      LyricsText.Strings[1]:=temp;
    end;
    if trim(LyricsText.Strings[0])='' then LyricsText.Delete(0);
  end;
  end;

 // DeleteFile(TempDir+Directoryseparator+'songtext.txt');
  GetLyric:=Goed;
end;


end.

