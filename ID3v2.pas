{ *************************************************************************** }
{                                                                             }
{ Compared and adapted to version from:					      }
{ Audio Tools Library                                                         }
{ Class TID3v2 - for manipulating with ID3v2 tags                             }
{                                                                             }
{ http://mac.sourceforge.net/atl/                                             }
{ e-mail: macteam@users.sourceforge.net                                       }
{									      }
{ Version 1.2-xix-5 (Aug 2015) by Bart Dezitter                               }
{ e-mail: info@xixmusicplayer.org                                             }
{   - Better COMM, TRCK & USLT support                                        }
{									      }
{ Version 1.2-xix-4 (Jan 2015) by Bart Dezitter                               }
{ e-mail: info@xixmusicplayer.org                                             }
{   - Reading some tags render some fields incorrect or cannot read at all,   }
{    saving tags cause also problem when texts are bigger than some values.   }
{    The problem is that xix MP is not using SynchSafe integers.              }
{    Another problem is that it supposed to produce v2.4 tags but it uses     }
{    TYER and TORY for dates instead of TDRC and TDOR  (JesusR)               }
{									      }
{ Version 1.2-xix-3 (Jan 2015) by Bart Dezitter                               }
{ e-mail: info@xixmusicplayer.org                                             }
{   - When opening filename fails in windows, try opening it by its DOS 8.3   }
{     name                                                                    }
{									      }
{ Version 1.2-xix-2 (November 2014) by Bart Dezitter                          }
{ e-mail: info@xixmusicplayer.org                                             }
{   - Start CD Cover Support						      }
{   - Add Tag support for LYRICS                                              }
{   - Removed function GetContent(const Content1, Content2: string);          }
{   - Added ORIGNALARTIST, ORIGINALTITLE, ORIGINALALBUM, ORIGINALYEAR         }
{									      }
{ Version 1.2-xix-1 (December 2013) by Bart Dezitter                          }
{   - Add Tag support for COMPOSER, LICENSE, COPYRIGHT, ENCODED-BY            }
{   - Tested and updated for LAZARUS                                          }
{   - Adapted as much as possible to ATL Version 1.8                          }
{									      }
{ Version from ATL does not work for me, latest working version:	      }
{                                                                             }
{ Version 1.2 (17 October 2001)                                               }
{   - Writing support for ID3v2.3.x tags                                      }
{   - Fixed bug with track number detection                                   }
{   - Fixed bug with tag reading                                              }
{                                                                             }
{ Version 1.1 (31 August 2001)                                                }
{   - Added public procedure ResetData                                        }
{                                                                             }
{ Version 1.0 (14 August 2001)                                                }
{   - Reading support for ID3v2.3.x tags                                      }
{   - Tag info: title, artist, album, track, year, genre, comment             }
{                                                                             }
{ This library is free software; you can redistribute it and/or               }
{ modify it under the terms of the GNU Lesser General Public                  }
{ License as published by the Free Software Foundation; either                }
{ version 2.1 of the License, or (at your option) any later version.          }
{                                                                             }
{ This library is distributed in the hope that it will be useful,             }
{ but WITHOUT ANY WARRANTY; without even the implied warranty of              }
{ MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU           }
{ Lesser General Public License for more details.                             }
{                                                                             }
{ You should have received a copy of the GNU Lesser General Public            }
{ License along with this library; if not, write to the Free Software         }
{ Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA   }
{                                                                             }
{ *************************************************************************** }


unit ID3v2;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, LazUTF8, LazFileUtils;

const
TAG_VERSION_2_2 = 2; { Code for ID3v2.2.x tag }
TAG_VERSION_2_3 = 3; { Code for ID3v2.3.x tag }
TAG_VERSION_2_4 = 4; { Code for ID3v2.4.x tag }

type
{ Class TID3v2 }
  TID3v2 = class(TObject)
private
{ Private declarations }
  FExists: Boolean;
  FVersionID: Byte;
  FSize: longint;
  FGroupTitle     : string;
  FTitle          : string;
  FSubTitle       : String;
  FArtist         : string;
  FOrchestra      : string;
  FConductor      : string;
  FInterpreted    : string;
  FOriginalArtist : String;
  FAlbum          : string;
  FOriginalTitle  : string;
  FTrack          : Byte;
  FYear           : string;
  FOriginalYear   : string;
  FGenre          : string;
  FComment        : string;
  FCommentDiscript: string;
  FComposer       : string;
  FEncoder        : string;
  FCopyright      : string;
  FLanguage       : string;
  FLink           : string;
  FSoftware       : string;
  FTSIZ           : string;
  FLyric          : string;
  FLyricDiscript  : string;
  FCDCoverStr     : string;
  FCDPicture      : string;
  FFileSize       : longint;
  procedure FSetGroupTitle(const NewGroupTitle: string);
  procedure FSetTitle(const NewTitle: string);
  procedure FSetSubTitle(const NewSubTitle: string);
  procedure FSetArtist(const NewArtist: string);
  procedure FSetOriginalArtist(const NewOriginalArtist: string);
  procedure FSetAlbum(const NewAlbum: string);
  procedure FSetOriginalTitle(const NewOriginalTitle: string);
  procedure FSetTrack(const NewTrack: Byte);
  procedure FSetYear(const NewYear: string);
  procedure FSetOriginalYear(const NewOriginalYear: string);
  procedure FSetGenre(const NewGenre: string);
  procedure FSetComment(const NewComment: string);
  procedure FSetComposer(const NewComposer: string);
  procedure FSetEncoder(const NewEncoder: string);
  procedure FSetCopyright(const NewCopyright: string);
  procedure FSetLanguage(const NewLanguage: string);
  procedure FSetLink(const NewLink: string);
  procedure FSetSoftware(const NewSoftware: string);
  procedure FSetLyric(const NewLyric: string);
  procedure FSetOrchestra(const NewOrchestra: string);
  procedure FSetConductor(const NewConductor: string);
  procedure FSetInterpreted(const NewInterpreted: string);
public
{ Public declarations }
  constructor Create; { Create object }
  procedure ResetData; { Reset all data }
  function ReadFromFile(const FileName: string): Boolean; { Load tag }
  function SaveToFile(const FileName: string): Boolean; { Save tag }
  function RemoveFromFile(const FileName: string): Boolean; { Delete tag }
  function SetCoverArt2(filename: string): Byte;
  property Exists: Boolean read FExists; { True if tag found }
  property VersionID: Byte read FVersionID; { Version code }
  property Size: Longint read FSize; { Total tag size }
  property GroupTitle: string read FGroupTitle write FSetGroupTitle; { Song Grouptitle}
  property Title: string read FTitle write FSetTitle; { Song title}
  property SubTitle: string read FSubTitle write FSetSubTitle; { Song subtitle}
  property Artist: string read FArtist write FSetArtist;                  { TPE1: Artist name }
  property Album: string read FAlbum write FSetAlbum; { Album title }
  property OriginalTitle: string read FOriginalTitle write FSetOriginalTitle; { Original title }
  property Track: Byte read FTrack write FSetTrack; { Track number }
  property Year: string read FYear write FSetYear; { Release year }
  property OriginalYear: string read FOriginalYear write FSetOriginalYear; { Release year }
  property Genre: string read FGenre write FSetGenre; { Genre name }
  property Comment: string read FComment write FSetComment; { Comment }
  property Composer: string read FComposer write FSetComposer; { Composer }
  property Encoder: string read FEncoder write FSetEncoder; { Encoder }
  property Copyright: string read FCopyright write FSetCopyright; { (c) }
  property Language: string read FLanguage write FSetLanguage; { Language }
  property Link: string read FLink write FSetLink; { URL link }
  property Software: string read FSoftware write FSetSoftware; { Used Software }
  property OriginalArtist: string read FOriginalArtist write FSetOriginalArtist; { TOAL: Original Artist }
  property Lyric: string read FLyric write FSetLyric;                            { Lyrics }
  property Orchestra: string read FOrchestra write FSetOrchestra;                { TPE2: Orchestra }
  property Conductor: string read FConductor write FSetConductor;                { TPE3: Conductor }
  property Interpreted: string read FInterpreted write FSetInterpreted;          { TPE4: Interpreter }
  property CDPicture: string read FCDPicture;
  function ConvertID3(const id3tag: string; FrSize: integer): String;
  property TSIZ: string read FTSIZ;
  property Filesize: Longint read FFilesize;
end;

implementation

const
{ ID3v2 tag ID }
ID3V2_ID = 'ID3';

{ Max. number of supported tag frames }
ID3V2_FRAME_COUNT = 26;

{ Names of supported tag frames (ID3v2.3.x & ID3v2.4.x)
 v2.3 TORY  <->  v2.4 TDOR
 v2.3 TYER   ->  v2.4 TDRC
 }
ID3V2_FRAME_NEW: array [1..ID3V2_FRAME_COUNT] of string =
('TIT2', 'TPE1', 'TALB', 'TRCK', 'TYER', 'TCON', 'COMM', 'TCOM', 'TENC',
'TCOP', 'TLAN', 'WXXX', 'TDRC', 'TOPE', 'TIT1', 'TOAL', 'TSSE', 'TSIZ', 'USLT',
'TIT3', 'TORY', 'TPE2', 'TPE3', 'TPE4', 'APIC', 'TDOR');

{ Names of supported tag frames (ID3v2.2.x) }
ID3V2_FRAME_OLD: array [1..ID3V2_FRAME_COUNT] of string =
('TT2', 'TP1', 'TAL', 'TRK', 'TYE', 'TCO', 'COM', 'TCM', 'TEN',
'TCR', 'TLA', 'WXX', 'TOR', 'TOA', 'TT1', 'TOT', 'TSE', 'TSI', 'USL',
'TT3', 'TRY', 'TP2', 'TP3', 'TP4', 'PIC', 'TOR');   // Need to check these last one

type
{ Frame header (ID3v2.3.x & ID3v2.4.x) }
  FrameHeaderNew = record
    ID: array [1..4] of Char; { Frame ID }
    Size: Integer; { Size excluding header }
    Flags: Word; { Flags }
  end;

{ Frame header (ID3v2.2.x) }
  FrameHeaderOld = record
    ID: array [1..3] of Char; { Frame ID }
    Size: array [1..3] of Byte; { Size excluding header }
  end;

{ ID3v2 header data - for internal use }
  TagInfo = record
{ Real structure of ID3v2 header }
    ID: array [1..3] of Char; { Always "ID3" }
    Version: Byte; { Version number }
    Revision: Byte; { Revision number }
    Flags: Byte; { Flags of tag }
    Size: array [1..4] of Byte; { Tag size excluding header }
{ Extended data }
    FileSize: Longint; { File size (bytes) }
    Frame: array [1..ID3V2_FRAME_COUNT] of string; { Information from frames }
    Framesize: array [1..ID3V2_FRAME_COUNT] of integer;
  end;

  TMP3TagCoverArtInfo = record
        Internal: Boolean;
        Encoding: Byte;
        MIMEType: String;
        PictureType: Byte;
        Description: String;
        PictureData: String;
    end;


var
  CDCover: TMP3TagCoverArtInfo;
 {$IFDEF WINDOWS} ShortFilename: string; {$ENDIF WINDOWS}

{ ********************* Auxiliary functions & procedures ******************** }

function ReadHeader(const FileName: string; var Tag: TagInfo): Boolean;
var
  SourceFile: file;
  Transferred: Integer;
  {$IFDEF WINDOWS}
  ShortName: String;
  R: TSearchRec;
  {$ENDIF}
begin
  try
    Result := true;
  {$IFDEF WINDOWS}
    AssignFile(SourceFile, utf8tosys(FileName));
    ShortFilename:='x';
  {$ELSE}
    AssignFile(SourceFile, FileName);
  {$ENDIF}
    FileMode := 0;
    Reset(SourceFile, 1);
(* Read header and get file size *)
    BlockRead(SourceFile, Tag, 10, Transferred);
    Tag.FileSize := System.FileSize(SourceFile);
    //FileSize(SourceFile);
    CloseFile(SourceFile);
(* if transfer is not complete *)
    if Transferred < 10 then Result := false;
  except
    (* Opening file failed, try the DOS 8.3 filename *)
    {$IFDEF WINDOWS}
    FindFirstUTF8(Filename, faAnyFile, R);
    ShortName:=R.Finddata.cAlternateFilename;
    FindCloseUTF8(R);
    try
      ShortFilename:=ExtractFilepath(filename)+ShortName;
      AssignFile(SourceFile, ShortFilename);
      Filemode:=0;
      Reset(SourceFile,1);
      BlockRead(SourceFile, Tag, 10, Transferred);
      Tag.FileSize := FileSize(SourceFile);
      CloseFile(SourceFile);
      if Transferred < 10 then Result := false;
    except
      ShortFilename:='x';
      Result:=False;
    end;
    {$ENDIF}
    Result := false;
  end;
end;

{ --------------------------------------------------------------------------- }

function GetTagSize(const Tag: TagInfo): Integer;
begin
{ Get total tag size }
  Result :=
  Tag.Size[1] * $200000 +
  Tag.Size[2] * $4000 +
  Tag.Size[3] * $80 +
  Tag.Size[4] + 10;
  if Tag.Flags and $10 > 0 then Inc(Result, 10);
  if Result > Tag.FileSize then Result := 0;
end;

{ --------------------------------------------------------------------------- }

procedure SetTagItem(const ID, Data: string; var Tag: TagInfo; Datasize: integer);
var
  Iterator: Byte;
  FrameID: string;
begin
{ Set tag item if supported frame found }
  for Iterator := 1 to ID3V2_FRAME_COUNT do
  begin
    if Tag.Version > TAG_VERSION_2_2 then FrameID := ID3V2_FRAME_NEW[Iterator]
                                     else FrameID := ID3V2_FRAME_OLD[Iterator];
    if FrameID = ID then begin
                           if Tag.Frame[Iterator]='' then    // If tag already existed, only save the first
                           begin
                             Tag.Frame[Iterator] := Data;
                             Tag.Framesize[Iterator] := DataSize;
                           end;
                         end;
  end;
end;

function Swap32(const Figure: Integer): Integer;
var
  ByteArray: array [1..4] of Byte absolute Figure;
begin
{ Swap 4 bytes }
  Result :=
  ByteArray[1] * $1000000 +
  ByteArray[2] * $10000 +
  ByteArray[3] * $100 +
  ByteArray[4];
end;

function FromSynchSafe(i: Integer):Integer;
var
  q: Pbyte;
begin
  q := @i;
  result := 0;
  result := result or (q[0] and $7F) shl (7*3);
  result := result or (q[1] and $7F) shl (7*2);
  result := result or (q[2] and $7F) shl (7*1);
  result := result or (q[3] and $7F) shl (7*0);
end;

function ToSynchSafe(i: Integer): Integer;
var
  p: Pbyte;
begin
  p := @result;
  p[3] := (i shr (7*0)) and $7F;
  p[2] := (i shr (7*1)) and $7F;
  p[1] := (i shr (7*2)) and $7F;
  P[0] := (i shr (7*3)) and $7F;
end;

{ --------------------------------------------------------------------------- }

procedure ReadFramesNew(const FileName: string; var Tag: TagInfo; Version: Integer);
var
  SourceFile: file;
  Frame: FrameHeaderNew;
  Data: array [1..12000] of Char;  //Needed for Lyrics
  DataPosition, DataSize, Size: Integer;
begin
{ Get information from frames (ID3v2.3.x & ID3v2.4.x) }
  try
{ Set read-access, open file }
  {$IFDEF WINDOWS}
  if ShortFilename='x' then AssignFile(SourceFile, utf8tosys(FileName))
                       else AssignFile(SourceFile, ShortFilename);
  {$ELSE}
  AssignFile(SourceFile, FileName);
  {$ENDIF}
  FileMode := 0;
  Reset(SourceFile, 1);
  Seek(SourceFile, 10);
  while (FilePos(SourceFile) < GetTagSize(Tag)) and (not EOF(SourceFile)) do
  begin
    FillChar(Data, SizeOf(Data), 0);
{ Read frame header and check frame ID }
    BlockRead(SourceFile, Frame, 10);
    if not (Frame.ID[1] in ['A'..'Z']) then break;
{ Note data position and determine significant data size }
    DataPosition := FilePos(SourceFile);
    if Version=TAG_VERSION_2_3 then Size := Swap32(Frame.Size)
                               else Size := FromSynchSafe(Frame.Size);
    if Size > SizeOf(Data) then DataSize := SizeOf(Data)
                           else DataSize := Size;
{ Read frame data and set tag item if frame supported }
    BlockRead(SourceFile, Data, DataSize);
    SetTagItem(Frame.ID, Data, Tag, DataSize) ;
    Seek(SourceFile, DataPosition + Size);
  end;
  CloseFile(SourceFile);
  except
  end;
end;

{ --------------------------------------------------------------------------- }

procedure ReadFramesOld(const FileName: string; var Tag: TagInfo);
var
  SourceFile: file;
  Frame: FrameHeaderOld;
  Data: array [1..12000] of Char;
  DataPosition, FrameSize, DataSize: Integer;
begin
{ Get information from frames (ID3v2.2.x) }
  try
{ Set read-access, open file }
  {$IFDEF WINDOWS}
    if ShortFilename='x' then AssignFile(SourceFile, utf8tosys(FileName))
                         else AssignFile(SourceFile, ShortFilename);
  {$ELSE}
    AssignFile(SourceFile, FileName);
  {$ENDIF}
    FileMode := 0;
    Reset(SourceFile, 1);
    Seek(SourceFile, 10);
    while (FilePos(SourceFile) < GetTagSize(Tag)) and (not EOF(SourceFile)) do
    begin
      FillChar(Data, SizeOf(Data), 0);
{ Read frame header and check frame ID }
      BlockRead(SourceFile, Frame, 6);
      if not (Frame.ID[1] in ['A'..'Z']) then break;
{ Note data position and determine significant data size }
      DataPosition := FilePos(SourceFile);
      FrameSize := Frame.Size[1] shl 16 + Frame.Size[2] shl 8 + Frame.Size[3];
      if FrameSize > SizeOf(Data) then DataSize := SizeOf(Data)
                                  else DataSize := FrameSize;
{ Read frame data and set tag item if frame supported }
      BlockRead(SourceFile, Data, DataSize);
      SetTagItem(Frame.ID, Data, Tag, Datasize);
      Seek(SourceFile, DataPosition + FrameSize);
    end;
    CloseFile(SourceFile);
  except
  end;
end;

{ --------------------------------------------------------------------------- }


function ExtractTrack(const TrackString: string): Byte;
var
  Index, Value, Code: Integer;
begin
{ Extract track from string }
  Index := Pos('/', Trim(TrackString));
  if Index = 0 then Val(Trim(TrackString), Value, Code)
               else Val(Copy(Trim(TrackString), 1, Index - 1), Value, Code);
  if Code = 0 then Result := Value
              else Result := 0;
end;

{ --------------------------------------------------------------------------- }

function ExtractGenre(const GenreString: string): string;
begin
{ Extract genre from string }
  Result := Trim(GenreString);
  if Pos(')', Result) > 0 then Delete(Result, 1, LastDelimiter(')', Result));
end;

{ --------------------------------------------------------------------------- }

function ExtractComment(const CommentString: string): string;
var
  Comment: string;
begin
{ Extract comment from string }
  Comment := CommentString;
  Delete(Comment, 1, 4);
  Delete(Comment, 1, Pos(#0, Comment));
  Result := Comment;
end;

{ --------------------------------------------------------------------------- }

function ExtractLink(const LinkString: string): string;
var
  Link: string;
begin
{ Extract URL link from string }
  Link := LinkString;
  Delete(Link, 1, 1);
  Delete(Link, 1, Pos(#0, Link));
  Result := Trim(Link);
end;

{ --------------------------------------------------------------------------- }

function ExtractOriginalArtist(const OriginalArtistString: string): string;
begin
  Result := Trim(OriginalArtistString);
end;

{ --------------------------------------------------------------------------- }
function ExtractLyric(const LyricString: string): string;
var
  Lyric: string;
begin
{ Extract Lyric from string }
  Lyric := LyricString;
  Delete(Lyric, 1, 4);
  Delete(Lyric, 1, Pos(#0, Lyric));
  Result := Trim(Lyric);
end;
{ --------------------------------------------------------------------------- }

function ExtractCDCover(const CDCoverString: string): string;
var TempCDCover: string;
begin
  TempCDCover:=CDCoverString; // Extract Lyric from string
  CDCover.Internal:=True;     // CDCover.Encoding:=00;
  Delete(TempCDCover, 1, Pos('i', TempCDCover)-1);
  CDCover.MIMEType:=copy(TempCDCover,1,pos(#0, TempCDCover)-1);
  Delete(TempCDCover, 1, Pos(#0, TempCDCover)+1);    // PictureType ook al wissen
  CDCover.PictureType:=3;                            // Voorlopig enkel als CDCover
  CDCover.Description:=copy(TempCDCover,1,pos(#0, TempCDCover)-1);   //ShowMessage('"'+CDCover.Description+'"');
  Delete(TempCDCover, 1, Pos(#0, TempCDCover));                      //showmessage(inttostr(sizeof(TempCDCover)));
  CDCover.PictureData:=TempCDCover;
  Result:=CDCover.MIMEType+#0+chr(CDCover.PictureType)+CDCover.Description+#0+CDCover.PictureData;
  If length(CDCover.PictureData)<5 then
  begin
    Result:='';  (* No Picture DATA *)
  end;
end;

procedure BuildHeader(var Tag: TagInfo);
var
  Iterator, TagSize: Integer;
begin
{ Build tag header }
  Tag.ID := ID3V2_ID;
  Tag.Version := TAG_VERSION_2_4;
  Tag.Revision := 0;
  Tag.Flags := 0;
  TagSize := 0;
  for Iterator := 1 to ID3V2_FRAME_COUNT do
  if Tag.Frame[Iterator] <> '' then
  Inc(TagSize, Length(Tag.Frame[Iterator]) + 11);
{ Convert tag size }
  Tag.Size[1] := TagSize div $200000;
  Tag.Size[2] := TagSize div $4000;
  Tag.Size[3] := TagSize div $80;
  Tag.Size[4] := TagSize mod $80;
end;

{ --------------------------------------------------------------------------- }

function RebuildFile(const FileName: string; TagData: TStream): Boolean;
var
  Tag: TagInfo;
  Source, Destination: TFileStream;
  BufferName: string;
begin
{ Rebuild file with old file data and new tag data (optional) }
  Result := false;
  if (not FileExistsutf8(FileName)) {or (FileSetAttr(FileName, 0) <> 0) } then exit;

  if not ReadHeader(FileName, Tag) then exit;
  if (TagData = nil) and (Tag.ID <> ID3V2_ID) then exit;
  try
{ Create file streams }
    BufferName := FileName + '~';
    Source := TFileStream.Create(FileName, fmOpenRead or fmShareExclusive);
    Destination := TFileStream.Create(BufferName, fmCreate); //  Showmessage(Buffername);
{ Copy data blocks }
    if Tag.ID = ID3V2_ID then Source.Seek(GetTagSize(Tag), soFromBeginning);
    if TagData <> nil then Destination.CopyFrom(TagData, 0);
    Destination.CopyFrom(Source, Source.Size - Source.Position);
{ Free resources }
    Source.Free;
    Destination.Free;
{ Replace old file and delete temporary file }
    if (DeleteFile(FileName)) and (RenameFile(BufferName, FileName)) then Result := true
        else raise Exception.Create('');
  except
{ Access error }
    if FileExistsutf8(BufferName) then DeleteFileutf8(BufferName);
  end;
end;

{ --------------------------------------------------------------------------- }

function SaveTag(const FileName: string; Tag: TagInfo): Boolean;
var
  TagData: TStringStream;
  Iterator, FrameSize: Integer;
begin
{ Build and write tag header and frames to stream }
  TagData := TStringStream.Create('');
  BuildHeader(Tag);
  TagData.Write(Tag, 10);
  for Iterator := 1 to ID3V2_FRAME_COUNT do
  if Tag.Frame[Iterator] <> '' then
  begin
    TagData.WriteString(ID3V2_FRAME_NEW[Iterator]);
    FrameSize := ToSynchSafe(Length(Tag.Frame[Iterator]) + 1);
    TagData.Write(FrameSize, SizeOf(FrameSize));
    TagData.WriteString(#0#0#3 + Tag.Frame[Iterator]);  //UTF8
  end;
{ Rebuild file with new tag data }
  Result := RebuildFile(FileName, TagData);
  TagData.Free;
end;

{ ********************** Private functions & procedures ********************* }

procedure TID3v2.FSetGroupTitle(const NewGroupTitle: string);
begin
  FGroupTitle := Trim(NewGroupTitle);
end;

{ --------------------------------------------------------------------------- }
procedure TID3v2.FSetTitle(const NewTitle: string);
begin
  FTitle := Trim(NewTitle);
end;

{ --------------------------------------------------------------------------- }
procedure TID3v2.FSetSUbTitle(const NewSubTitle: string);
begin
  FSubTitle := Trim(NewSubTitle);
end;

{ --------------------------------------------------------------------------- }

procedure TID3v2.FSetArtist(const NewArtist: string);
begin
  FArtist := Trim(NewArtist);
end;

{ --------------------------------------------------------------------------- }

procedure TID3v2.FSetAlbum(const NewAlbum: string);
begin
  FAlbum := Trim(NewAlbum);
end;

{ --------------------------------------------------------------------------- }

procedure TID3v2.FSetOriginalTitle(const NewOriginalTitle: string);
begin
  FOriginalTitle := Trim(NewOriginalTitle);
end;

{ --------------------------------------------------------------------------- }

procedure TID3v2.FSetTrack(const NewTrack: Byte);
begin
FTrack := NewTrack;
end;

{ --------------------------------------------------------------------------- }

procedure TID3v2.FSetYear(const NewYear: string);
begin
FYear := Trim(NewYear);
end;

{ --------------------------------------------------------------------------- }

procedure TID3v2.FSetOriginalYear(const NewOriginalYear: string);
begin
FOriginalYear := Trim(NewOriginalYear);
end;

{ --------------------------------------------------------------------------- }

procedure TID3v2.FSetGenre(const NewGenre: string);
begin
FGenre := Trim(NewGenre);
end;

{ --------------------------------------------------------------------------- }

procedure TID3v2.FSetComment(const NewComment: string);
begin
FComment := Trim(NewComment);
end;

{ --------------------------------------------------------------------------- }

procedure TID3v2.FSetComposer(const NewComposer: string);
begin
FComposer := Trim(NewComposer);
end;

{ --------------------------------------------------------------------------- }

procedure TID3v2.FSetEncoder(const NewEncoder: string);
begin
FEncoder := Trim(NewEncoder);
end;

{ --------------------------------------------------------------------------- }

procedure TID3v2.FSetCopyright(const NewCopyright: string);
begin
FCopyright := Trim(NewCopyright);
end;

{ --------------------------------------------------------------------------- }

procedure TID3v2.FSetLanguage(const NewLanguage: string);
begin
FLanguage := Trim(NewLanguage);
end;

{ --------------------------------------------------------------------------- }

procedure TID3v2.FSetLink(const NewLink: string);
begin
FLink := Trim(NewLink);
end;

{ --------------------------------------------------------------------------- }

procedure TID3v2.FSetOriginalArtist(const NewOriginalArtist: string);
begin
FOriginalArtist := Trim(NewOriginalArtist);
end;

{ --------------------------------------------------------------------------- }

procedure TID3v2.FSetSoftware(const NewSoftware: string);
begin
FSoftware := Trim(NewSoftware);
end;

{ --------------------------------------------------------------------------- }

procedure TID3v2.FSetLyric(const NewLyric: string);
begin
FLyric := Trim(NewLyric);
end;
{ --------------------------------------------------------------------------- }

procedure TID3v2.FSetOrchestra(const NewOrchestra: string);
begin
FOrchestra := Trim(NewOrchestra);
end;

{ --------------------------------------------------------------------------- }

procedure TID3v2.FSetConductor(const NewConductor: string);
begin
FConductor := Trim(NewConductor);
end;
{ --------------------------------------------------------------------------- }

procedure TID3v2.FSetInterpreted(const NewInterpreted: string);
begin
FInterpreted := Trim(NewInterpreted);
end;

function TID3v2.SetCoverArt2(filename: string): Byte;
var TempStr: TStringstream;
    TempFile: TFileStream;
begin
  if fileexistsutf8(filename) then
  begin
    CDCover.Internal:=False;
    CDCover.encoding:=0;
    CDCover.Description:='CD Cover';
    if pos('.jp',filename)>0 then CDCover.MIMEType:='image/jpeg';
    if pos('.png',filename)>0 then CDCover.MIMEType:='image/png';
    CDCover.PictureType:=3;
    TempStr:=TStringStream.Create('');
    TempFile:=TFileStream.create(filename,fmOpenRead);
    TempFile.Seek(0,soFromBeginning);
    if TempFile.Size<810000 then
    begin
      TempStr.CopyFrom(TempFile,TempFile.Size);
      CDCover.PictureData:=Tempstr.DataString;
      FCDCoverStr:=CDCover.MIMEType+#0+chr(CDCover.PictureType)+CDCover.Description+#0+CDCover.PictureData;
      Result:=0;
    end
    else
    begin
      CDCover.Description:=''; CDCover.Internal:=False;
      CDCover.PictureData:=''; CDCover.MIMEType:='';FCDCoverStr:='';
      Result:=1;
    end;
    Tempstr.Free; TempFile.Free;
  end
  else
  begin
    CDCover.Description:=''; CDCover.Internal:=False;
    CDCover.PictureData:=''; CDCover.MIMEType:='';
    FCDCoverStr:='';
    Result:=2;
  end;
end;

{ ********************** Public functions & procedures ********************** }

constructor TID3v2.Create;
begin
{ Create object }
  inherited;
  ResetData;
end;

{ --------------------------------------------------------------------------- }

procedure TID3v2.ResetData;
begin
{ Reset all variables }
  FExists := false;
  FVersionID := 0;
  FSize := 0;
  FGroupTitle:= '';
  FTitle := '';
  FSubTitle := '';
  FArtist := '';
  FAlbum := '';
  FTrack := 0;
  FYear := '';
  FGenre := '';
  FComment := '';
  FComposer := '';
  FEncoder := '';
  FCopyright := '';
  FLanguage := '';
  FLink := '';
  FSoftware := '';
  FOriginalArtist := '';
  FOriginalTitle := '';
  FOriginalYear := '';
  FTSIZ := '';
  FLyric:='';
  FOrchestra:='';
  FConductor:='';
  FInterpreted:='';
  FCDCoverStr:='';
  FCDPicture:='';
end;


function TID3v2.ConvertID3(const id3tag: string; FrSize: integer): string;
var mode: byte;
    id3tag2, temp2: string;
    i: integer;
begin
  if length(id3tag)>1 then
  begin
  mode:=byte(id3tag[1]);
  case mode of
   0: begin
        temp2:='';
        id3tag2:=trim(copy(id3tag,2,length(id3tag)));
        for i:=1 to length(id3tag2) do
        begin
         case id3tag2[i] of
          #214: temp2:=temp2+'Ö';
          #216: temp2:=temp2+'Ø';
          #223: temp2:=temp2+'ß';
          #224: temp2:=temp2+'à';
          #225: temp2:=temp2+'á';
          #226: temp2:=temp2+'â';
          #227: temp2:=temp2+'ã';
          #228: temp2:=temp2+'ä';
          #229: temp2:=temp2+'å';
          #230: temp2:=temp2+'æ';
          #231: temp2:=temp2+'ç';
          #232: temp2:=temp2+'è';
          #233: temp2:=temp2+'é';
          #234: temp2:=temp2+'ê';
          #235: temp2:=temp2+'ë';
          #236: temp2:=temp2+'ì';
          #237: temp2:=temp2+'í';
          #238: temp2:=temp2+'î';
          #239: temp2:=temp2+'ï';
          #240: temp2:=temp2+'ð';
          #241: temp2:=temp2+'ñ';
          #242: temp2:=temp2+'ò';
          #243: temp2:=temp2+'ó';
          #244: temp2:=temp2+'ô';
          #245: temp2:=temp2+'õ';
          #246: temp2:=temp2+'ö';
          #248: temp2:=temp2+'ø';
          #249: temp2:=temp2+'ù';
          #250: temp2:=temp2+'ú';
          #251: temp2:=temp2+'û';
          #252: temp2:=temp2+'ü';
          #253: temp2:=temp2+'ý';
          else temp2:=temp2+id3tag2[i];
          end;
        end;
        ConvertId3:=temp2;
      end;
   1: begin
        id3tag2:='';
        if (ord(id3tag[2])=255) and (ord(id3tag[3])=254) then i:=4  // BOM found
                                                         else i:=2; // No BOM found
        repeat
          id3tag2:=id3tag2+utf16toutf8(WideChar(Ord(id3tag[i]) or (Ord(id3tag[i+1]) shl 8)));
          i:=i+2;
        until i>FrSize-1;

        ConvertId3:=trim(id3tag2);
      end;
   2: begin
        id3tag2:='';
        if (ord(id3tag[2])=254) and (ord(id3tag[3])=255) then i:=4  // BOM found
                                                         else i:=2; // No BOM found
        repeat
          id3tag2:=id3tag2+utf16toutf8(WideChar(Ord(id3tag[i+1]) or (Ord(id3tag[i]) shl 8)));
          i:=i+2;
        until i>FrSize-1;
        ConvertId3:=trim(id3tag2);
      end;
   3: begin
        id3tag2:=copy(id3tag,2,utf8length(id3tag));
        ConvertId3:=trim(id3tag2);
      end;
      else ConvertId3:=trim(id3tag);
    end;
  end
  else ConvertId3:=trim(id3tag);
end;

function TID3v2.ReadFromFile(const FileName: string): Boolean;
var
  Tag: TagInfo;
  i, start: integer;
  zeros: byte;
begin
{ Reset data and load header from file to variable }
  ResetData; zeros:=0;
  for i:=1 to ID3V2_FRAME_COUNT do Tag.Framesize[i]:=0;

  Result := ReadHeader(FileName, Tag);
  FFileSize := Tag.FileSize;

{ Process data if loaded and header valid }
  if (Result) and (Tag.ID = ID3V2_ID) then
  begin
  FExists := true;
  { Fill properties with header data }
  FVersionID := Tag.Version;
  FSize := GetTagSize(Tag);

  { Get information from frames if version supported }
  if (FVersionID in [TAG_VERSION_2_2..TAG_VERSION_2_4]) and (FSize > 0) then
  begin
  if FVersionID > TAG_VERSION_2_2 then ReadFramesNew(FileName, Tag, FVersionID)
                                  else ReadFramesOld(FileName, Tag);
  FGroupTitle := ConvertID3(Tag.Frame[15],Tag.Framesize[15]);
  FTitle := ConvertID3(Tag.Frame[1],Tag.Framesize[1]);
  FArtist := ConvertID3(Tag.Frame[2],Tag.Framesize[2]);
  FAlbum := ConvertID3(Tag.Frame[3],Tag.Framesize[3]);
  FTrack := ExtractTrack(ConvertID3(Tag.Frame[4], Tag.Framesize[4]));
  FYear := ConvertID3(Tag.Frame[5],Tag.Framesize[5]);
  if FYear='' then FYear := ConvertID3(Tag.Frame[13],Tag.Framesize[13]);
  FGenre := ExtractGenre(ConvertID3(Tag.Frame[6],Tag.Framesize[6]));

(* <Header for 'Comment', ID: "COMM">
   Text encoding           $xx
   Language                $xx xx xx
   Short content descrip.  <text string according to encoding> $00 (00)
   The actual text         <full text string according to encoding> *)

  if Tag.Framesize[7]>4 then
  begin
    If (Tag.Frame[7][1]=#01) or (Tag.Frame[7][1]=#02) then  // If Textencoding = 1 or 2; not needed for 0 or 3
    begin

    (*  if (Tag.Frame[7][9]=#255) or (Tag.Frame[7][9]=#254) then start:=9   // Here we have to search where the actual text begins by filtering out the discription
                                                          else start:=5;  // So now it is still buggy

                                                           Tag.Frame[7][start-1]:=Tag.Frame[7][1];
      For i:=start to Tag.Framesize[7]-start-1 do
      begin
        Tag.Frame[7][i-start+2]:=Tag.Frame[7][i];
      end;
      For i:=Tag.Framesize[7]-((start-1)*2) to Tag.Framesize[7] do
      begin
        Tag.Frame[7][i]:=#00;
      end; *)
      start:=4;                                         // DESCRIPTION starts at the 5th bit
      FCommentDiscript:=Tag.Frame[7][1];                // Setting encoding for Discription
      repeat
        inc(start);
        FCommentDiscript:=FCommentDiscript+Tag.Frame[7][start];
        if Tag.Frame[7][start]=#00 then inc(zeros)       // Filtering out bad ID3-tags
                                   else zeros:=0;
        if zeros=4 then break;
      until (Tag.Frame[7][start]=#00) and ((Tag.Frame[7][start+1]=#255) or (Tag.Frame[7][start+1]=#254));
      inc(start);

      Tag.Frame[7][start-1]:=Tag.Frame[7][1];        // Setting encoding for Comment
      For i:=start to Tag.Framesize[7]-1 do
      begin
        if Tag.Frame[7][i]=#254 then Tag.Frame[7][i-start+2]:=#00
                                else if Tag.Frame[7][i]=#255 then Tag.Frame[7][i-start+2]:=#13
                                                             else Tag.Frame[7][i-start+2]:=Tag.Frame[7][i];
      end;
      For i:=Tag.Framesize[7]-length(FCommentDiscript)-2 to Tag.Framesize[7] do Tag.Frame[7][i]:=#00;
      FComment := ConvertID3(Tag.Frame[7],Tag.Framesize[7]);
    end
    else FComment := ExtractComment(Tag.Frame[7]);
  end;
 // FComment := ExtractComment(Tag.Frame[7]);
  FComposer := ConvertID3(Tag.Frame[8],Tag.Framesize[8]);
  FEncoder := ConvertID3(Tag.Frame[9],Tag.Framesize[9]);
  FCopyright := ConvertID3(Tag.Frame[10],Tag.Framesize[10]);
  FLanguage := Tag.Frame[11];
  FLink := ExtractLink(Tag.Frame[12]);
  FOriginalArtist := ConvertID3(Tag.Frame[14],Tag.Framesize[14]);
  ForiginalTitle := ConvertID3(Tag.Frame[16],Tag.Framesize[16]);
  FSoftware := ConvertID3(Tag.Frame[17],Tag.Framesize[17]);
  FTSIZ := Trim(Tag.Frame[18]);

(* LYRICS - ID3 Specs
   <Header for 'Unsynchronised lyrics/text transcription', ID: "USLT">
   Text encoding       $xx
   Language            $xx xx xx
   Content descriptor  <text string according to encoding> $00 (00)
   Lyrics/text         <full text string according to encoding>      *)

 if Tag.Framesize[19]>4 then
  begin
    If (Tag.Frame[19][1]=#01) or (Tag.Frame[19][1]=#02) then  // If Textencoding = 1 or 2; not needed for 0 or 3
    begin
      start:=4;                                         // DESCRIPTION starts at the 5th bit
      FLyricDiscript:=Tag.Frame[19][1];                 // Setting encoding for Discription
      repeat
        inc(start);
        FLyricDiscript:=FLyricDiscript+Tag.Frame[19][start];
      until (Tag.Frame[19][start]=#00) and ((Tag.Frame[19][start+1]=#255) or (Tag.Frame[19][start+1]=#254)) ;
      inc(start);
      Tag.Frame[19][start-1]:=Tag.Frame[19][1];        // Setting encoding for Lyric
      For i:=start to Tag.Framesize[19]-1 do
      begin
        if Tag.Frame[19][i]=#254 then Tag.Frame[19][i-start+2]:=#00
                                 else if Tag.Frame[19][i]=#255 then Tag.Frame[19][i-start+2]:=#13
                                                               else Tag.Frame[19][i-start+2]:=Tag.Frame[19][i];
      end;
      For i:=Tag.Framesize[19]-length(FLyricDiscript)-2 to Tag.Framesize[19] do Tag.Frame[19][i]:=#00;
      FLyric := ConvertID3(Tag.Frame[19],Tag.Framesize[19]);
    end
    else FLyric := ExtractLyric(Tag.Frame[19]);        // Textencoding is 0 or 3
  end;

  FSubTitle := ConvertID3(Tag.Frame[20],Tag.Framesize[20]);
  FOriginalYear := ConvertID3(Tag.Frame[21],Tag.Framesize[21]);
  if FOriginalYear='' then FOriginalYear := ConvertID3(Tag.Frame[26],Tag.Framesize[26]);
  FOrchestra:= ConvertID3(Tag.Frame[22],Tag.Framesize[22]);
  FConductor:= ConvertID3(Tag.Frame[23],Tag.Framesize[23]);
  FInterpreted:= ConvertID3(Tag.Frame[24],Tag.Framesize[24]);

  if pos('iTunes',FEncoder)=1 then FSoftware:='iTunes';
  end;
end;
end;

{ --------------------------------------------------------------------------- }

function TID3v2.SaveToFile(const FileName: string): Boolean;
var
Tag: TagInfo;
begin
(*  ('TIT2', 'TPE1', 'TALB', 'TRCK', 'TYER', 'TCON', 'COMM', 'TCOM', 'TENC',
'TCOP', 'TLAN', 'WXXX', 'TDRC', 'TOPE', 'TIT1', 'TOAL', 'TSSE', 'TSIZ', 'USLT',
'TIT3', 'TORY', 'TPE2', 'TPE3', 'TPE4', 'APIC', 'TDOR');     *)

{ Prepare tag data and save to file }
  FillChar(Tag, SizeOf(Tag), 0);
  Tag.Frame[1] := FTitle;                                        // TIT2
  Tag.Frame[2] := FArtist;                                       // TPE1
  Tag.Frame[3] := FAlbum;                                        // TALB
  if FTrack > 0 then Tag.Frame[4] := IntToStr(FTrack)            // TRCK
                else Tag.Frame[4] :='';
  Tag.Frame[5] := '';                                            // TYER, use TDRC in v2.4
  Tag.Frame[6] := FGenre;                                        // TCON
  if FComment <> '' then Tag.Frame[7] := 'eng' + #0 + FComment   // COMM
                    else Tag.Frame[7] := '';
  Tag.Frame[8] := FComposer;                                     // TCOM
  Tag.Frame[9] := FEncoder;                                      // TENC
  Tag.Frame[10] := FCopyright;                                   // TCOP
  Tag.Frame[11] := FLanguage;                                    // TLAN
  if FLink <> '' then Tag.Frame[12] := #0 + FLink;               // WXXX
  Tag.Frame[13] := FYear;                                        // TDRC, as TYER is not valid in v2.4
  Tag.Frame[14] := FOriginalArtist;                              // TOPE
  Tag.Frame[15] := FGroupTitle;                                  // TIT1
  Tag.Frame[16] := FOriginalTitle;                               // TOAL
  Tag.Frame[17] := Fsoftware;                                    // TSSE
  Tag.Frame[18] := FTSIZ;                                        // TSIZ
  if FLyric <> '' then Tag.Frame[19] := 'eng' + #0 + FLyric      // USLT
                  else Tag.Frame[19] := '';
  Tag.Frame[20] := FSubTitle;                                    // TIT3
  Tag.Frame[21] := '';                                           // TORY, use TDOR in v2.4
  Tag.Frame[22] := FOrchestra;                                   // TPE2
  Tag.Frame[23] := FConductor;                                   // TPE3
  Tag.Frame[24] := FInterpreted;                                 // TPE4
  Tag.Frame[25] := FCDCoverSTr;                                  // APIC
  Tag.Frame[26] := FOriginalYear;                                // TDOR as TORY is not valid in v2.4

  Result := SaveTag(FileName, Tag);

end;

{ --------------------------------------------------------------------------- }

function TID3v2.RemoveFromFile(const FileName: string): Boolean;
begin
{ Remove tag from file }
  Result := RebuildFile(FileName, nil);
end;

end.


