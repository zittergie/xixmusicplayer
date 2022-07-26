(*
XiX_OpusTagReader
  Class TXiX_OpusTagReader - Reading (and writing) Vorbis Comments (tags) in
  Opus Files

Some of this work is based on the 'Audio Tools Library ' that can be found @
http://mac.sourceforge.net/atl/

Author:  Bart Dezitter (info@xixmusicplayer.org)

Done:
     - File Length
     - Basic Reading of Tags

ToDo:
     - Store Tags in index
     - Enhanced Reading of Tags
         Storing in stringlist ?
         Reading MetaData like pictures
         Opus Information
     - Basic Writing of Tags
     - Enchanced Writing of Tags

*)

unit XiX_OpusTagReader;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Dialogs;

const
  VORBIS_CM_MONO = 1;                           (* Code for mono mode *)
  VORBIS_CM_STEREO = 2;                         (* Code for stereo mode *)
  VORBIS_CM_MULTICHANNEL = 6;                   (* Code for Multichannel Mode *)

  (* Channel mode names *)
  VORBIS_MODE: array [0..3] of string = ('Unknown', 'Mono', 'Stereo', 'Multichannel');

type
  (* Class XiX_OpusTagReader *)
  TXiX_OpusTagReader = class(TObject)
    private
      FVendor      : string;
      FTitle       : string;
      FArtist      : string;
      FAlbum       : String;
      FTrack       : Byte;
      FTotalTracks : Byte;
      FDate        : string;
      FGenre       : string;
      FComment     : string;
      FOriginalArtist: string;
      FOriginalTitle : String;
      FOriginalDate  : String;
      FComposer    : String;
      FCopyright   : String;
      FEncoder: string;
      FLicense: String;
      FEncodedBy: String;
      FOrchestra: String;
      FConductor: String;
      FSubTitle: String;
      FGroupTitle: String;
      FInterpreted: String;
      FLyrics: String;
      FFilesize    : longInt;
      FNumberOfTags: Byte;

      procedure FReadTag(TagString: String);
      procedure FResetData;
    public
      constructor Create;                                          (* Create object *)
      destructor Destroy; override;                                (* Destroy object *)

      property Vendor: string read FVendor;                        (* Vendor string *)
      property Artist: string read FArtist write FArtist;          (* Artist name *)
      property Title: string read FTitle write FTitle;             (* Song title *)
      property Album: string read FAlbum write FAlbum;             (* Album name *)
      property Track: Byte read FTrack write FTrack;               (* Track number *)
      property TotalTracks: Byte read FTotalTracks write FTotalTracks;             (* Total Track numbers *)
      property Date: string read FDate write FDate;                (* Year/Date *)
      property Genre: string read FGenre write FGenre;             (* Genre name *)
      property Comment: string read FComment write FComment;       (* Comment *)
      property OriginalArtist: string read FOriginalArtist write FOriginalArtist;  (* Original Artist string *)
      property OriginalTitle: string read FOriginalTitle write FOriginalTitle;     (* Original Title string *)
      property OriginalDate: string read FOriginalDate write FOriginalDate;        (* Original Date string *)
      property Composer: string read FComposer write FComposer;    (* Composer string *)
      property Copyright: string read FCopyright write FCopyright; (* Copyright string *)
      property License: string read FLicense write FLicense;       (* License/URL string *)
      property EncodedBy: string read FEncodedBy write FEncodedBy; (* Encoded By string *)
      property Orchestra: string read FOrchestra write FOrchestra; (* Orchestra string *)
      property Conductor: string read FConductor write FConductor; (* Conductor string *)
      property SubTitle: string read FSubTitle write FSubTitle;    (* Sub Title string *)
      property GroupTitle: string read FGroupTitle write FGroupTitle;        (* Group Title string *)
      property Interpreted: string read FInterpreted write FInterpreted;     (* Interpreted string *)
      property Lyrics: string read FLyrics write FLyrics;          (* Lyric string *)
      property Encoder: string read FEncoder write FEncoder;       (* Encoder string *)
      property FileSize: longInt read FFileSize;                   (* File size in bytes *)
      property NumberOfTags: byte read FNumberOfTags write FNumberOfTags; (* Number of Tags *)

      function ReadFromFile(const FileName: String): Boolean;      (* Load data *)

  end;

  function ReverseBytes(Value: Cardinal): Cardinal;

implementation

const
  OPUS_PAGE_ID = 'OggS';           (* Opus page header ID *)
  OPUS_HEAD_ID = 'OpusHead';       (* Opus parameter frame ID *)
  OPUS_TAG_ID  = 'OpusTags';       (* Vorbis tag frame ID *)

type
  OpusHeader = record
      ID: array [1..4] of Char;                 (* Should be "OggS" *)
      StreamVersion: Byte;                      (* Stream structure version *)
      TypeFlag: Byte;                           (* Header type flag *)
      AbsolutePosition: Int64;                  (* Absolute granule position *)
      Serial: Integer;                          (* Stream serial number *)
      PageNumber: Integer;                      (* Page sequence number *)
      Checksum: Cardinal;                       (* Page checksum *)
      Segments: Byte;                           (* Number of page segments *)
      LacingValues: array [1..$FF] of Byte;     (* Lacing values - segment sizes *)
  end;

type
  OpusHead = record
      ID: array [1..8] of Char;                 (* Should be "OpusHead" *)
      BitstreamVersion: Byte;                   (* Bitstream version number *)
      ChannelCount: Byte;                       (* Number of channels *)
      PreSkip: Word;
      SampleRate: LongWord;                     (* Sample rate (hz) *)
      OutputGain: Word;
      MappingFamily: Byte;                      (* 0,1,255 *)
  end;

type
  OpusTag = record
    ID: array [1..8] of Char; (* Should always be "OpusTags" *)
  end;

function ReverseBytes(Value: Cardinal): Cardinal;
begin
    Result := (Value SHR 24) OR (Value SHL 24) OR ((Value AND $00FF0000) SHR 8) OR ((Value AND $0000FF00) SHL 8);
end;

constructor TXiX_OpusTagReader.Create;
begin
  FResetData;
  inherited;
end;

destructor TXiX_OpusTagReader.Destroy;
begin
  inherited;
end;

procedure TXiX_OpusTagReader.FReadTag(TagString: String);
var TagName, TagContent, TagContentExtra: string;
begin
 // ShowMessage(TagString);
  TagName:=Copy(TagString,1,Pos('=',TagString)-1);
  TagContent:=Copy(TagString,Pos('=',TagString)+1,length(Tagstring)-Length(Tagname)-1);
  //ShowMessage('TagName='+TagName+#13+'TagContent='+TagContent);

  (*
  TODO:
      - Keep Index for TAGNAME - TAGVALUE
      - Opus Tags can be reference more than once, so Stringlists should be used
             For the moment the second string is added as:  ', Second String'
      - ELSE --> Keep in stringlist
      - Keep Lyrics in a stringlist ??
      - FREADTAG(Tagstring: String; Details: Byte)
          Details of
          '0': Read All
          '1': Read All but Metadata (Pictures)
          '2': Read All but Metadata and Lyrics
  *)

  case upcase(TagName) of
    'ARTIST'         : Begin
                         FArtist:=TagContent;
                       end;
    'TITLE'          : FTitle:=TagContent;
    'ALBUM'          : FAlbum:=TagContent;
    'TRACKNUMBER'    : Begin
                         If Pos('/',TagContent)>0 then
                         begin
                           TagContentExtra:=Copy(TagContent,Pos('/',Tagcontent)+1,length(TagContent)-Pos('/',TagContent));
                           TagContent:=Copy(TagContent,1,Pos('/',TagContent)-1);
                           FTotalTracks:=StrtoIntDef(TagContentExtra,0);
                         end;
                         FTrack:=StrtoIntDef(TagContent,0);
                       End;
    'GENRE'          : FGenre:=TagContent;
    'DATE'           : FDate:=TagContent;
    'COMMENT'        : FComment:=TagContent;
    'ORIGINAL_ARTIST': FOriginalArtist:=TagContent;
    'ORIGINAL_TITLE' : FOriginalTitle:=TagContent;
    'ORIGINAL_DATE'  : FOriginalDate:=TagContent;
    'COMPOSER'       : FComposer:=TagContent;
    'COPYRIGHT'      : FCopyright:=TagContent;
    'LICENSE'        : FLicense:=TagContent;
    'ENCCODEDBY'     : FEncodedBy:=TagContent;
    'ORCHESTRA'      : FOrchestra:=TagContent;
    'CONDUCTOR'      : FConductor:=TagContent;
    'SUBTITLE'       : FSubTitle:=TagContent;
    'GROUPTITLE'     : FGroupTitle:=TagContent;
    'INTERPRETED'    : FInterpreted:=TagContent;
    'LYRICS'         : begin
                         If length(FLyrics)=0 then FLyrics:=trim(TagContent)
                                              else FLyrics:=FLyrics+#13+Trim(Tagcontent);
                       end;
    'UNSYNCED LYRICS': begin
                         If length(FLyrics)=0 then FLyrics:=trim(TagContent)
                                              else FLyrics:=FLyrics+#13+Trim(Tagcontent);
                       end;
    'ENCODER'        : FEncoder:=TagContent;
    end;
end;

function TXiX_OpusTagReader.ReadFromFile(const FileName: string): Boolean;
var
  SourceFile: TFileStream = nil;
  Info: OpusHeader;
  InfoHead: OpusHead;
  InfoTag: OpusTag;
  TagSize: Cardinal;
  temp: array [1..255000] of char;
  Readchars, index: LongInt;
begin
  Result := false;
  try
  //  ShowMessage(Filename);
    SourceFile := TFileStream.Create(string(FileName), fmOpenRead or fmShareDenyWrite);
    FFilesize := SourceFile.Size;
    Result:=True;
    SourceFile.Seek(0, soFromBeginning);
    SourceFile.Read(Info.ID, SizeOf(Info.ID));
    If Info.ID<>'OggS' then exit;
                     //  Else ShowMessage('Info.ID='+Info.ID);  (* No Opus File *)
    SourceFile.Read(Info.StreamVersion, SizeOf(Info.StreamVersion));
    SourceFile.Read(Info.TypeFlag, SizeOf(Info.TypeFlag));
    SourceFile.Read(Info.AbsolutePosition, SizeOf(Info.AbsolutePosition));
    SourceFile.Read(Info.Serial, SizeOf(Info.Serial));
    SourceFile.Read(Info.PageNumber, SizeOf(Info.PageNumber));
    SourceFile.Read(Info.Checksum, SizeOf(Info.Checksum));
    SourceFile.Read(Info.Segments, SizeOf(Info.Segments));

    (* Jump to OpusHead *)
    SourceFile.Seek(Info.Segments, soFromCurrent);
    SourceFile.Read(InfoHead.ID, SizeOf(InfoHead.ID));
    If InfoHead.ID<>'OpusHead' then
    begin
      SourceFile.Free;
      exit;
    end;
        //                       else ShowMessage('InfoHead.ID='+InfoHead.ID); (* No Opus File *)
    SourceFile.Read(InfoHead.BitstreamVersion, 1);
    SourceFile.Read(InfoHead.ChannelCount, 1);
    SourceFile.Read(InfoHead.PreSkip, 2);
    SourceFile.Read(InfoHead.SampleRate, 4);
    SourceFile.Read(InfoHead.OutputGain, 2);
    SourceFile.Read(InfoHead.MappingFamily, 1);

    (* Second Page ? *)
    SourceFile.Read(Info.ID, SizeOf(Info.ID));
    If Info.ID<>'OggS' then
    begin
      SourceFile.Free;
      exit;
    end;
                  //     else ShowMessage('Info.ID='+INFO.ID); (* No Opus File *)
    SourceFile.Read(Info.StreamVersion, SizeOf(Info.StreamVersion));
    SourceFile.Read(Info.TypeFlag, SizeOf(Info.TypeFlag));
    SourceFile.Read(Info.AbsolutePosition, SizeOf(Info.AbsolutePosition));
    SourceFile.Read(Info.Serial, SizeOf(Info.Serial));
    SourceFile.Read(Info.PageNumber, SizeOf(Info.PageNumber));
    SourceFile.Read(Info.Checksum, SizeOf(Info.Checksum));
    SourceFile.Read(Info.Segments, SizeOf(Info.Segments));

    (* Jump to OpusTags *)
    SourceFile.Seek(Info.Segments, soFromCurrent);
    SourceFile.Read(InfoTag.ID, SizeOf(InfoTag.ID));
    (* Start reading tags *)
    SourceFile.Read(Tagsize, 4); Readchars:=Tagsize;            (* Length Vendor String *)
    Temp:=''; SourceFile.Read(Temp, Readchars); FVendor:=temp;  (* Vendor String *)
    //ShowMessage('Vendor='+FVendor);
    SourceFile.Read(Tagsize, 4); FNumberOfTags:=Tagsize;        (* Number of Tags *)
   // ShowMessage('NumberOfTags='+Inttostr(FNumberOfTags));
    (* Repeat reading Tags for NumberOfTags-1 *)
    index:=0;
    repeat
      inc(index);
      SourceFile.Read(Tagsize, 4); Readchars:=Tagsize;          (* Length Tag *)
      If ReadChars>1024 then exit  (* Excluding Big Tags until loading Pictures Work *)
      else
      begin
        Temp:=''; SourceFile.Read(Temp, Readchars);
        If Pos('METADATA_BLOCK_PICTURE',Temp)=0 then FReadTag(Temp)
                                                else exit;
      end;
    until (index=FNumberOfTags) or (SourceFile.Position>FFilesize-260);

  finally
    SourceFile.Free;
  end;
end;

procedure TXiX_OpusTagReader.FResetData;
begin
  (* Reset variables *)
  FFileSize := 0;
  FTitle := '';
  FArtist := '';
  FAlbum := '';
  FTrack := 0;
  FDate := '';
  FGenre := '';
  FComment := '';
  FOriginalArtist := '';
  FVendor := '';
  FEncoder := '';
  FComposer := '';
  FCopyright := '';
  FLicense := '';
  FEncodedBy := '';
  FOrchestra := '';
  FConductor := '';
  FSubTitle := '';
  FGroupTitle := '';
  FOriginalTitle := '';
  FOriginalDate := '';
  FLyrics := '';
  FInterpreted := '';
end;

end.

