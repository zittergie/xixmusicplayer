{ *************************************************************************** }
{                                                                             }
{ Audio Tools Library                                                         }
{ Class TOggVorbis - for manipulating with Ogg Vorbis file information        }
{                                                                             }
{ http://mac.sourceforge.net/atl/                                             }
{ e-mail: macteam@users.sourceforge.net                                       }
{                                                                             }
{ Copyright (c) 2000-2002 by Jurgen Faul                                      }
{ Copyright (c) 2003-2005 by The MAC Team                                     }
{                                                                             }
{ Version 1.9-xix-1 (December 2013) by Bart Dezitter                          }
{ e-mail: info@xixmusicplayer.org                                             }
{   - Add Tag support for COMPOSER, LICENSE, COPYRIGHT, ENCODED-BY            }
{   - Tested and updated for LAZARUS                                          }
{   - Removed uses of TntClasses, TntSysUtils                                 }
{                                                                             }
{ Version 1.9 (April 2005) by Gambit                                          }
{   - updated to unicode file access                                          }
{                                                                             }
{ Version 1.83 (26 march 2005) by Kurtnoise                                   }
{   - Added multichannel support                                              }
{                                                                             }
{ Version 1.82 (23 March 2005) by Gambit                                      }
{   - fixed nominal bitrate info (eg 192 was 193 sometimes)                   }
{                                                                             }
{ Version 1.81 (21 June 2004) by Gambit                                       }
{   - Added Encoder property                                                  }
{                                                                             }
{ Version 1.8 (13 April 2004) by Gambit                                       }
{   - Added Ratio property                                                    }
{                                                                             }
{ Version 1.7 (20 August 2003) by Madah                                       }
{   - Minor fix: changed FSampleRate into Integer                             }
{     ... so that samplerates>65535 works.                                    }
{                                                                             }
{ Version 1.6 (2 October 2002)                                                }
{   - Writing support for Vorbis tag                                          }
{   - Changed several properties                                              }
{   - Fixed bug with long Vorbis tag fields                                   }
{                                                                             }
{ Version 1.2 (18 February 2002)                                              }
{   - Added property BitRateNominal                                           }
{   - Fixed bug with Vorbis tag fields                                        }
{                                                                             }
{ Version 1.1 (21 October 2001)                                               }
{   - Support for UTF-8                                                       }
{   - Fixed bug with vendor info detection                                    }
{                                                                             }
{ Version 1.0 (15 August 2001)                                                }
{   - File info: file size, channel mode, sample rate, duration, bit rate     }
{   - Vorbis tag: title, artist, album, track, date, genre, comment, vendor   }
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

unit OpusVorbis;

interface

uses
  Classes, SysUtils, Dialogs;

const
  { Used with ChannelModeID property }
  VORBIS_CM_MONO = 1;                                    { Code for mono mode }
  VORBIS_CM_STEREO = 2;                                { Code for stereo mode }
  VORBIS_CM_MULTICHANNEL = 6;                    { Code for Multichannel Mode }

  { Channel mode names }
  VORBIS_MODE: array [0..3] of string = ('Unknown', 'Mono', 'Stereo', 'Multichannel');

type
  { Class TOggVorbis }
  TOpusVorbis = class(TObject)
    private
      { Private declarations }
      FFileSize: longInt;
      FChannelModeID: Byte;
      FSampleRate: integer;
      FBitRateNominal: Word;
      FSamples: Integer;
      FID3v2Size: Integer;
      FTitle: string;
      FArtist: string;
      FAlbum: string;
      FTrack: Word;
      FDate: string;
      FGenre: string;
      FComment: string;
      FOriginalArtist: string;
      FOriginalTitle: String;
      FOriginalDate: String;
      FVendor: string;
      FEncoder: string;
      FComposer: String;
      FCopyright: String;
      FLicense: String;
      FEncodedBy: String;
      FOrchestra: String;
      FConductor: String;
      FSubTitle: String;
      FGroupTitle: String;
      FInterpreted: String;
      FLyrics: String;
   //   FArtist2: TStringlist;
      procedure FResetData;
      function FGetChannelMode: string;
      function FGetDuration: Double;
      function FGetBitRate: Word;
      function FHasID3v2: Boolean;
      function FIsValid: Boolean;
      function FGetRatio: Double;
      function FGetEncoder: String;
    public
      { Public declarations }
      constructor Create;                                     { Create object }
      destructor Destroy; override;                          { Destroy object }
      function ReadFromFile(const FileName: String): Boolean;     { Load data }
      function SaveTag(const FileName: String): Boolean;      { Save tag data }
      function ClearTag(const FileName: String): Boolean;    { Clear tag data }
      property FileSize: longInt read FFileSize;          { File size (bytes) }
      property ChannelModeID: Byte read FChannelModeID;   { Channel mode code }
      property ChannelMode: string read FGetChannelMode;  { Channel mode name }
      property SampleRate: integer read FSampleRate;       { Sample rate (hz) }
      property BitRateNominal: Word read FBitRateNominal;  { Nominal bit rate }
      property Title: string read FTitle write FTitle;           { Song title }
      property Artist: string read FArtist write FArtist;       { Artist name }
      property Album: string read FAlbum write FAlbum;           { Album name }
      property Track: Word read FTrack write FTrack;           { Track number }
      property Date: string read FDate write FDate;                    { Year }
      property Genre: string read FGenre write FGenre;           { Genre name }
      property Comment: string read FComment write FComment;        { Comment }
      property OriginalArtist: string read FOriginalArtist write FOriginalArtist;  { Original Artist string }
      property OriginalTitle: string read FOriginalTitle write FOriginalTitle;  { Original Artist string }
      property OriginalDate: string read FOriginalDate write FOriginalDate;  { Original Artist string }
      property Vendor: string read FVendor;                   { Vendor string }
      property Encoder: string read FEncoder write FEncoder; { Encoder string }
      property Composer: string read FComposer write FComposer;             { Composer string }
      property Copyright: string read FCopyright write FCopyright;           { Copyright string }
      property License: string read FLicense write FLicense;            { License/URL string }
      property EncodedBy: string read FEncodedBy write FEncodedBy;        { License/URL string }
      property Orchestra: string read FOrchestra write FOrchestra;             { Composer string }
      property Conductor: string read FConductor write FConductor;           { Copyright string }
      property SubTitle: string read FSubTitle write FSubTitle;            { License/URL string }
      property GroupTitle: string read FGroupTitle write FGroupTitle;        { License/URL string }
      property Interpreted: string read FInterpreted write FInterpreted;        { License/URL string }
      property Lyrics: string read FLyrics write FLyrics;        { License/URL string }
   //   property Artist2: Tstringlist read FArtist2 write FArtist2;        { License/URL string }
      property Duration: Double read FGetDuration;       { Duration (seconds) }
     // property BitRate: Integer read FGetBitRate;             { Average bit rate }
      property ID3v2: Boolean read FHasID3v2;      { True if ID3v2 tag exists }
      property Valid: Boolean read FIsValid;             { True if file valid }
      property Ratio: Double read FGetRatio;          { Compression ratio (%) }
      property Encoder2: String read FGetEncoder;            { Encoder string }
  end;

implementation

const
  { Ogg page header ID }
  OGG_PAGE_ID = 'OggS';

  { Vorbis parameter frame ID }
  VORBIS_PARAMETERS_ID = 'OpusHead';

  { Vorbis tag frame ID }
  VORBIS_TAG_ID = 'OpusTags';

  { Max. number of supported comment fields }
  VORBIS_FIELD_COUNT = 26;

  { Names of supported comment fields }
  VORBIS_FIELD: array [1..VORBIS_FIELD_COUNT] of string =
    ('TITLE', 'ARTIST', 'ALBUM', 'TRACKNUMBER', 'DATE', 'GENRE', 'COMMENT',
    'PERFORMER', 'DESCRIPTION', 'ENCODER', 'COMPOSER', 'COPYRIGHT', 'LICENSE',
    'ENCODED-BY', 'ENSEMBLE', 'CONDUCTOR', 'OPUS', 'PART', 'VERSION',
    'ORIGINAL_ARTIST', 'ORIGINAL_TITLE', 'ORIGINAL_DATE', 'SUBTITLE', 'REMIXER',
    'LYRICS', 'UNSYNCED LYRICS');

  { CRC table for checksum calculating }
  CRC_TABLE: array [0..$FF] of Cardinal = (
    $00000000, $04C11DB7, $09823B6E, $0D4326D9, $130476DC, $17C56B6B,
    $1A864DB2, $1E475005, $2608EDB8, $22C9F00F, $2F8AD6D6, $2B4BCB61,
    $350C9B64, $31CD86D3, $3C8EA00A, $384FBDBD, $4C11DB70, $48D0C6C7,
    $4593E01E, $4152FDA9, $5F15ADAC, $5BD4B01B, $569796C2, $52568B75,
    $6A1936C8, $6ED82B7F, $639B0DA6, $675A1011, $791D4014, $7DDC5DA3,
    $709F7B7A, $745E66CD, $9823B6E0, $9CE2AB57, $91A18D8E, $95609039,
    $8B27C03C, $8FE6DD8B, $82A5FB52, $8664E6E5, $BE2B5B58, $BAEA46EF,
    $B7A96036, $B3687D81, $AD2F2D84, $A9EE3033, $A4AD16EA, $A06C0B5D,
    $D4326D90, $D0F37027, $DDB056FE, $D9714B49, $C7361B4C, $C3F706FB,
    $CEB42022, $CA753D95, $F23A8028, $F6FB9D9F, $FBB8BB46, $FF79A6F1,
    $E13EF6F4, $E5FFEB43, $E8BCCD9A, $EC7DD02D, $34867077, $30476DC0,
    $3D044B19, $39C556AE, $278206AB, $23431B1C, $2E003DC5, $2AC12072,
    $128E9DCF, $164F8078, $1B0CA6A1, $1FCDBB16, $018AEB13, $054BF6A4,
    $0808D07D, $0CC9CDCA, $7897AB07, $7C56B6B0, $71159069, $75D48DDE,
    $6B93DDDB, $6F52C06C, $6211E6B5, $66D0FB02, $5E9F46BF, $5A5E5B08,
    $571D7DD1, $53DC6066, $4D9B3063, $495A2DD4, $44190B0D, $40D816BA,
    $ACA5C697, $A864DB20, $A527FDF9, $A1E6E04E, $BFA1B04B, $BB60ADFC,
    $B6238B25, $B2E29692, $8AAD2B2F, $8E6C3698, $832F1041, $87EE0DF6,
    $99A95DF3, $9D684044, $902B669D, $94EA7B2A, $E0B41DE7, $E4750050,
    $E9362689, $EDF73B3E, $F3B06B3B, $F771768C, $FA325055, $FEF34DE2,
    $C6BCF05F, $C27DEDE8, $CF3ECB31, $CBFFD686, $D5B88683, $D1799B34,
    $DC3ABDED, $D8FBA05A, $690CE0EE, $6DCDFD59, $608EDB80, $644FC637,
    $7A089632, $7EC98B85, $738AAD5C, $774BB0EB, $4F040D56, $4BC510E1,
    $46863638, $42472B8F, $5C007B8A, $58C1663D, $558240E4, $51435D53,
    $251D3B9E, $21DC2629, $2C9F00F0, $285E1D47, $36194D42, $32D850F5,
    $3F9B762C, $3B5A6B9B, $0315D626, $07D4CB91, $0A97ED48, $0E56F0FF,
    $1011A0FA, $14D0BD4D, $19939B94, $1D528623, $F12F560E, $F5EE4BB9,
    $F8AD6D60, $FC6C70D7, $E22B20D2, $E6EA3D65, $EBA91BBC, $EF68060B,
    $D727BBB6, $D3E6A601, $DEA580D8, $DA649D6F, $C423CD6A, $C0E2D0DD,
    $CDA1F604, $C960EBB3, $BD3E8D7E, $B9FF90C9, $B4BCB610, $B07DABA7,
    $AE3AFBA2, $AAFBE615, $A7B8C0CC, $A379DD7B, $9B3660C6, $9FF77D71,
    $92B45BA8, $9675461F, $8832161A, $8CF30BAD, $81B02D74, $857130C3,
    $5D8A9099, $594B8D2E, $5408ABF7, $50C9B640, $4E8EE645, $4A4FFBF2,
    $470CDD2B, $43CDC09C, $7B827D21, $7F436096, $7200464F, $76C15BF8,
    $68860BFD, $6C47164A, $61043093, $65C52D24, $119B4BE9, $155A565E,
    $18197087, $1CD86D30, $029F3D35, $065E2082, $0B1D065B, $0FDC1BEC,
    $3793A651, $3352BBE6, $3E119D3F, $3AD08088, $2497D08D, $2056CD3A,
    $2D15EBE3, $29D4F654, $C5A92679, $C1683BCE, $CC2B1D17, $C8EA00A0,
    $D6AD50A5, $D26C4D12, $DF2F6BCB, $DBEE767C, $E3A1CBC1, $E760D676,
    $EA23F0AF, $EEE2ED18, $F0A5BD1D, $F464A0AA, $F9278673, $FDE69BC4,
    $89B8FD09, $8D79E0BE, $803AC667, $84FBDBD0, $9ABC8BD5, $9E7D9662,
    $933EB0BB, $97FFAD0C, $AFB010B1, $AB710D06, $A6322BDF, $A2F33668,
    $BCB4666D, $B8757BDA, $B5365D03, $B1F740B4);

type
  { Ogg page header }
  OggHeader = packed record
    ID: array [1..4] of Char;                                 { Always "OggS" }
    StreamVersion: Byte;                           { Stream structure version }
    TypeFlag: Byte;                                        { Header type flag }
    AbsolutePosition: Int64;                      { Absolute granule position }
    Serial: Integer;                                   { Stream serial number }
    PageNumber: Integer;                               { Page sequence number }
    Checksum: Integer;                                        { Page checksum }
    Segments: Byte;                                 { Number of page segments }
    LacingValues: array [1..$FF] of Byte;     { Lacing values - segment sizes }
  end;

  { Vorbis parameter header }
  VorbisHeader = packed record
    ID: array [1..8] of Char;                             { Always "OpusHead" }
    BitstreamVersion: Byte;                        { Bitstream version number }
    ChannelMode: Byte;                                   { Number of channels }
    PreSkip: Word;
    SampleRate: LongWord;                                   { Sample rate (hz) }
    OutputGain: Word;                                   { Bit rate upper limit }
    MappingFamily: Byte;                                            { 0,1,255 }
  end;

  { Vorbis tag data }
  VorbisTag = record
    ID: array [1..8] of Char;                             { Always "OpusTags" }
    Fields: Integer;                                   { Number of tag fields }
    FieldData: array [0..VORBIS_FIELD_COUNT] of string;      { Tag field data }
  end;

  { File data }
  FileInfo = record
    FPage, SPage, LPage: OggHeader;             { First, second and last page }
    Parameters: VorbisHeader;                       { Vorbis parameter header }
    Tag: VorbisTag;                                         { Vorbis tag data }
    FileSize: longInt;                                    { File size (bytes) }
    Samples: Integer;                               { Total number of samples }
    ID3v2Size: Integer;                              { ID3v2 tag size (bytes) }
    SPagePos: Integer;                          { Position of second Ogg page }
    TagEndPos: Integer;                                    { Tag end position }
  end;

//var
 // TempArtiest: TStringlist;

{ ********************* Auxiliary functions & procedures ******************** }

function DecodeUTF8(const Source: string): WideString;
var
  Index, SourceLength, FChar, NChar: Cardinal;
begin
  { Convert UTF-8 to unicode }
  Result := '';
  Index := 0;
  SourceLength := Length(Source);
  while Index < SourceLength do
  begin
    Inc(Index);
    FChar := Ord(Source[Index]);
    if FChar >= $80 then
    begin
      Inc(Index);
      if Index > SourceLength then exit;
      FChar := FChar and $3F;
      if (FChar and $20) <> 0 then
      begin
        FChar := FChar and $1F;
        NChar := Ord(Source[Index]);
        if (NChar and $C0) <> $80 then  exit;
        FChar := (FChar shl 6) or (NChar and $3F);
        Inc(Index);
        if Index > SourceLength then exit;
      end;
      NChar := Ord(Source[Index]);
      if (NChar and $C0) <> $80 then exit;
      Result := Result + WideChar((FChar shl 6) or (NChar and $3F));
    end
    else
      Result := Result + WideChar(FChar);
  end;
end;

{ --------------------------------------------------------------------------- }

function EncodeUTF8(const Source: WideString): string;
var
  Index, SourceLength, CChar: Cardinal;
begin
  { Convert unicode to UTF-8 }
  Result := '';
  Index := 0;
  SourceLength := Length(Source);
  while Index < SourceLength do
  begin
    Inc(Index);
    CChar := Cardinal(Source[Index]);
    if CChar <= $7F then
      Result := Result + Source[Index]
    else if CChar > $7FF then
    begin
      Result := Result + Char($E0 or (CChar shr 12));
      Result := Result + Char($80 or ((CChar shr 6) and $3F));
      Result := Result + Char($80 or (CChar and $3F));
    end
    else
    begin
      Result := Result + Char($C0 or (CChar shr 6));
      Result := Result + Char($80 or (CChar and $3F));
    end;
  end;
end;

{ --------------------------------------------------------------------------- }

function GetID3v2Size(const Source: TFileStream): Integer;
type
  ID3v2Header = record
    ID: array [1..3] of Char;
    Version: Byte;
    Revision: Byte;
    Flags: Byte;
    Size: array [1..4] of Byte;
  end;
var
  Header: ID3v2Header;
begin
  { Get ID3v2 tag size (if exists) }
  Result := 0;
  Source.Seek(0, soFromBeginning);
  Source.Read(Header, SizeOf(Header));
  if Header.ID = 'ID3' then
  begin
    Result :=
      Header.Size[1] * $200000 +
      Header.Size[2] * $4000 +
      Header.Size[3] * $80 +
      Header.Size[4] + 10;
    if Header.Flags and $10 = $10 then Inc(Result, 10);
    if Result > Source.Size then Result := 0;
  end;
end;

{ --------------------------------------------------------------------------- }

procedure SetTagItem(const Data: string; var Info: FileInfo);
var
  Separator, Index: Integer;
  FieldID, FieldData: string;
begin
  { Set Vorbis tag item if supported comment field found }
  Separator := Pos('=', Data);
  if Separator > 0 then
  begin
    FieldID := UpperCase(Copy(Data, 1, Separator - 1));
    FieldData := Copy(Data, Separator + 1, Length(Data) - Length(FieldID));
    for Index := 1 to VORBIS_FIELD_COUNT do
      if VORBIS_FIELD[Index] = FieldID then
        begin
          case
            index of
               2: if Info.Tag.FieldData[Index]='' then Info.Tag.FieldData[Index] := DecodeUTF8(Trim(FieldData))    //ARTIST
                                                  else Info.Tag.FieldData[Index] := Info.Tag.FieldData[Index]+', '+DecodeUTF8(Trim(FieldData));
               //else TempArtiest.Add(DecodeUTF8(Trim(FieldData)));
              11: if Info.Tag.FieldData[Index]='' then Info.Tag.FieldData[Index] := DecodeUTF8(Trim(FieldData))    //COMPOSER
                                                  else Info.Tag.FieldData[Index] := Info.Tag.FieldData[Index]+', '+DecodeUTF8(Trim(FieldData));
              26: Info.Tag.FieldData[Index] := Info.Tag.FieldData[Index]+#10+DecodeUTF8(Trim(FieldData))           //UNSYNC LYRICS
              else Info.Tag.FieldData[Index] := DecodeUTF8(Trim(FieldData))
          end; //of case;
        end;
  end
  else
    if Info.Tag.FieldData[0] = '' then Info.Tag.FieldData[0] := Data;
end;

{ --------------------------------------------------------------------------- }

procedure ReadTag(const Source: TFileStream; var Info: FileInfo);
var
  Index, Size, Position: Integer;
  Data: array [1..250] of Char;
begin
  { Read Vorbis tag }
  Index := 0;
  repeat
    FillChar(Data, SizeOf(Data), 0);
    Source.Read(Size, SizeOf(Size));
    Position := Source.Position;
    ShowMessage('Size='+Inttostr(Size));
    ShowMessage('SizeOf='+Inttostr(Sizeof(Data)));
  //  if Size > SizeOf(Data) then
    Source.Read(Data, SizeOf(Data));
    //                       else Source.Read(Data, Size);
    ShowMessage('Data='+Data);
    { Set Vorbis tag item }
    SetTagItem(Trim(Data), Info);
    Source.Seek(Position + Size, soFromBeginning);
    if Index = 0 then Source.Read(Info.Tag.Fields, SizeOf(Info.Tag.Fields));
    Inc(Index);
  until Index > Info.Tag.Fields;
  Info.TagEndPos := Source.Position;
end;

{ --------------------------------------------------------------------------- }

function GetSamples(const Source: TFileStream): Integer;
var
  Index, DataIndex, Iterator: Integer;
  Data: array [0..250] of Char;
  Header: OggHeader;
begin
  { Get total number of samples }
  Result := 0;
  for Index := 1 to 50 do
  begin
    DataIndex := Source.Size - (SizeOf(Data) - 10) * Index - 10;
    Source.Seek(DataIndex, soFromBeginning);
    Source.Read(Data, SizeOf(Data));
    { Get number of PCM samples from last Ogg packet header }
    for Iterator := SizeOf(Data) - 10 downto 0 do
      if Data[Iterator] +
        Data[Iterator + 1] +
        Data[Iterator + 2] +
        Data[Iterator + 3] = OGG_PAGE_ID then
      begin
        Source.Seek(DataIndex + Iterator, soFromBeginning);
        Source.Read(Header, SizeOf(Header));
        Result := Header.AbsolutePosition;
        exit;
      end;
  end;
end;

{ --------------------------------------------------------------------------- }

function GetInfo(const FileName; var Info: FileInfo): Boolean;
var
  SourceFile: TFileStream;
begin
  { Get info from file }
  Result := false;
  SourceFile := nil;
  try
    SourceFile := TFileStream.Create(string(FileName), fmOpenRead or fmShareDenyWrite);
    Info.FileSize := SourceFile.Size;
    Info.ID3v2Size := GetID3v2Size(SourceFile);
    SourceFile.Seek(Info.ID3v2Size, soFromBeginning);
    SourceFile.Read(Info.FPage, SizeOf(Info.FPage));
    ShowMessage('Info.FPage.ID='+Info.FPage.ID+#13+'OGG_PAGE_ID='+OGG_PAGE_ID);
    if Info.FPage.ID <> OGG_PAGE_ID then exit;
    SourceFile.Seek(Info.ID3v2Size + Info.FPage.Segments + 27, soFromBeginning);
    { Read Vorbis parameter header }
    SourceFile.Read(Info.Parameters, SizeOf(Info.Parameters));
    ShowMessage('Info.Parameters.ID='+Info.Parameters.ID+#13+'VORBIS_PARAMETERS_ID='+VORBIS_PARAMETERS_ID);
    if Info.Parameters.ID <> VORBIS_PARAMETERS_ID then exit;
    Info.SPagePos := SourceFile.Position;
 //   SourceFile.Read(Info.SPage, SizeOf(Info.SPage));
    SourceFile.Seek(Info.SPagePos + Info.SPage.Segments + 27 + 8, soFromBeginning);
 //  Writeln(inttostr(SourceFile.Position));
    SourceFile.Read(Info.Tag.ID, SizeOf(Info.Tag.ID));
    ShowMessage('Info.Tag.ID='+Info.Tag.ID);
    ShowMessage('VORBIS_TAG_ID='+VORBIS_TAG_ID);
    ShowMessage('Position='+inttostr(SourceFile.Position));
    { Read Vorbis tag }
  // if Info.Tag.ID = VORBIS_TAG_ID then
   ReadTag(SourceFile, Info);
    { Get total number of samples }
    Info.Samples := GetSamples(SourceFile);
    Result := true;
   //test := Round( ( ( FFileLength - FAudioOffset ) / 1000 ) * 8 / FGetDuration );
  finally
    SourceFile.Free;
  end;
end;

{ --------------------------------------------------------------------------- }

function GetTrack(const TrackString: string): Byte;
var
  Index, Value, Code: Integer;
begin
  { Extract track from string }
  Index := Pos('/', TrackString);
  if Index = 0 then Val(TrackString, Value, Code)
  else Val(Copy(TrackString, 1, Index), Value, Code);
  if Code = 0 then Result := Value
  else Result := 0;
end;

{ --------------------------------------------------------------------------- }

function BuildTag(const Info: FileInfo): TStringStream;
var
  Index, Fields, Size: Integer;
  FieldData: string;
begin
  { Build Vorbis tag }
  Result := TStringStream.Create('');
  Fields := 0;
  for Index := 1 to VORBIS_FIELD_COUNT do
    if Info.Tag.FieldData[Index] <> '' then Inc(Fields);
  { Write frame ID, vendor info and number of fields }
  Result.Write(Info.Tag.ID, SizeOf(Info.Tag.ID));
  Size := Length(Info.Tag.FieldData[0]);
  Result.Write(Size, SizeOf(Size));
  Result.WriteString(Info.Tag.FieldData[0]);
  Result.Write(Fields, SizeOf(Fields));
  { Write tag fields }
  for Index := 1 to VORBIS_FIELD_COUNT do
    if Info.Tag.FieldData[Index] <> '' then
    begin
      FieldData := VORBIS_FIELD[Index] +
        '=' + EncodeUTF8(Info.Tag.FieldData[Index]);
      Size := Length(FieldData);
      Result.Write(Size, SizeOf(Size));
      Result.WriteString(FieldData);
    end;
end;

{ --------------------------------------------------------------------------- }

procedure SetLacingValues(var Info: FileInfo; const NewTagSize: Integer);
var
  Index, Position, Value: Integer;
  Buffer: array [1..$FF] of Byte;
begin
  { Set new lacing values for the second Ogg page }
  Position := 1;
  Value := 0;
  for Index := Info.SPage.Segments downto 1 do
  begin
    if Info.SPage.LacingValues[Index] < $FF then
    begin
      Position := Index;
      Value := 0;
    end;
    Inc(Value, Info.SPage.LacingValues[Index]);
  end;
  Value := Value + NewTagSize -
    (Info.TagEndPos - Info.SPagePos - Info.SPage.Segments - 27);
  { Change lacing values at the beginning }
  for Index := 1 to Value div $FF do Buffer[Index] := $FF;
  Buffer[(Value div $FF) + 1] := Value mod $FF;
  if Position < Info.SPage.Segments then
    for Index := Position + 1 to Info.SPage.Segments do
      Buffer[Index - Position + (Value div $FF) + 1] :=
        Info.SPage.LacingValues[Index];
  Info.SPage.Segments := Info.SPage.Segments - Position + (Value div $FF) + 1;
  for Index := 1 to Info.SPage.Segments do
    Info.SPage.LacingValues[Index] := Buffer[Index];
end;

{ --------------------------------------------------------------------------- }

procedure CalculateCRC(var CRC: Cardinal; const Data; Size: Cardinal);
var
  Buffer: ^Byte;
  Index: Cardinal;
begin
  { Calculate CRC through data }
  Buffer := Addr(Data);
  for Index := 1 to Size do
  begin
    CRC := (CRC shl 8) xor CRC_TABLE[((CRC shr 24) and $FF) xor Buffer^];
    Inc(Buffer);
  end;
end;

{ --------------------------------------------------------------------------- }

procedure SetCRC(const Destination: TFileStream; Info: FileInfo);
var
  Index: Integer;
  Value: Cardinal;
  Data: array [1..$FF] of Byte;
begin
  { Calculate and set checksum for Vorbis tag }
  Value := 0;
  CalculateCRC(Value, Info.SPage, Info.SPage.Segments + 27);
  Destination.Seek(Info.SPagePos + Info.SPage.Segments + 27, soFromBeginning);
  for Index := 1 to Info.SPage.Segments do
    if Info.SPage.LacingValues[Index] > 0 then
    begin
      Destination.Read(Data, Info.SPage.LacingValues[Index]);
      CalculateCRC(Value, Data, Info.SPage.LacingValues[Index]);
    end;
  Destination.Seek(Info.SPagePos + 22, soFromBeginning);
  Destination.Write(Value, SizeOf(Value));
end;

{ --------------------------------------------------------------------------- }

function RebuildFile(FileName: WideString; Tag: TStream; Info: FileInfo): Boolean;
var
  Source, Destination: TFileStream;
  BufferName: WideString;
begin
  { Rebuild the file with the new Vorbis tag }
  Result := false;
  if (not FileExists(FileName)) { or (FileSetAttr(FileName, 0) <> True} then exit;
  try
    { Create file streams }
    BufferName := FileName + '~';
    Source := TFileStream.Create(FileName, fmOpenRead);
    Destination := TFileStream.Create(BufferName, fmCreate);
    { Copy data blocks }
    Destination.CopyFrom(Source, Info.SPagePos);
    Destination.Write(Info.SPage, Info.SPage.Segments + 27);
    Destination.CopyFrom(Tag, 0);
    Source.Seek(Info.TagEndPos, soFromBeginning);
    Destination.CopyFrom(Source, Source.Size - Info.TagEndPos);
    SetCRC(Destination, Info);
    Source.Free;
    Destination.Free;
    { Replace old file and delete temporary file }
    if (DeleteFile(FileName)) and (RenameFile(BufferName, FileName)) then
      Result := true
    else
      raise Exception.Create('');
  except
    { Access error }
    if FileExists(BufferName) then DeleteFile(BufferName);
  end;
end;

{ ********************** Private functions & procedures ********************* }

procedure TopusVorbis.FResetData;
begin
  { Reset variables }
  FFileSize := 0;
  FChannelModeID := 0;
  FSampleRate := 0;
  FBitRateNominal := 0;
  FSamples := 0;
  FID3v2Size := 0;
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

{ --------------------------------------------------------------------------- }

function TOpusVorbis.FGetChannelMode: string;
begin
  if FChannelModeID > 2 then Result := VORBIS_MODE[3] else
     Result := VORBIS_MODE[FChannelModeID];
end;

{ --------------------------------------------------------------------------- }

function TOpusVorbis.FGetDuration: Double;
begin
  { Calculate duration time }
  if FSamples > 0 then
    if FSampleRate > 0 then
      Result := FSamples / FSampleRate
    else
      Result := 0
  else
    if (FBitRateNominal > 0) and (FChannelModeID > 0) then
      Result := (FFileSize - FID3v2Size) /
        FBitRateNominal / FChannelModeID / 125 * 2
    else
      Result := 0;
end;

{ --------------------------------------------------------------------------- }

function TOpusVorbis.FGetBitRate: Word;
begin
  { Calculate average bit rate }
  Result := 0;
  if FGetDuration > 0 then
    Result := Round((FFileSize - FID3v2Size) / FGetDuration / 125);
 // FBitrate := Round( ( ( FFileSize - FID3v2Size ) / 1000 ) * 8 / FGetDuration );
end;

{ --------------------------------------------------------------------------- }

function TOpusVorbis.FHasID3v2: Boolean;
begin
  { Check for ID3v2 tag }
  Result := FID3v2Size > 0;
end;

{ --------------------------------------------------------------------------- }

function TOpusVorbis.FIsValid: Boolean;
begin
  { Check for file correctness }
  Result := (FChannelModeID in [VORBIS_CM_MONO, VORBIS_CM_STEREO, VORBIS_CM_MULTICHANNEL]) and
    (FSampleRate > 0) and (FGetDuration > 0.1) and (FGetBitRate > 0);
end;

{ ********************** Public functions & procedures ********************** }

constructor TOpusVorbis.Create;
begin
  { Object constructor }
  FResetData;
  inherited;
end;

{ --------------------------------------------------------------------------- }

destructor TOpusVorbis.Destroy;
begin
  { Object destructor }
  inherited;
end;

{ --------------------------------------------------------------------------- }

function TOpusVorbis.ReadFromFile(const FileName: string): Boolean;
var
  Info: FileInfo;
begin
  { Read data from file }
  Result := false;
  FResetData;
  FillChar(Info, SizeOf(Info), 0);
  if GetInfo(FileName, Info) then
  begin
    { Fill variables }
    FFileSize := Info.FileSize;
    FChannelModeID := Info.Parameters.ChannelMode;
    FSampleRate := Info.Parameters.SampleRate;
   // FBitRateNominal := Info.Parameters.BitRateNominal div 1000;
    FSamples := Info.Samples;
    FID3v2Size := Info.ID3v2Size;
    FTitle := Info.Tag.FieldData[1];
    if Info.Tag.FieldData[2] <> '' then FArtist := Info.Tag.FieldData[2]
    else FArtist := Info.Tag.FieldData[8];
    FAlbum := Info.Tag.FieldData[3];
    FTrack := GetTrack(Info.Tag.FieldData[4]);
    FDate := Info.Tag.FieldData[5];
    FGenre := Info.Tag.FieldData[6];
    if Info.Tag.FieldData[7] <> '' then FComment := Info.Tag.FieldData[7]
    else FComment := Info.Tag.FieldData[9];
    FVendor := Info.Tag.FieldData[0];
    FOriginalArtist := Info.Tag.FieldData[8];
    if FOriginalArtist='' then FOriginalArtist := Info.Tag.FieldData[20];
    FEncoder := Info.Tag.FieldData[10];
    FComposer := Info.Tag.FieldData[11];
    FCopyright := Info.Tag.FieldData[12];
    FLicense :=  Info.Tag.FieldData[13];
    FEncodedBy :=  Info.Tag.FieldData[14];
    FOrchestra :=  Info.Tag.FieldData[15];
    FConductor :=  Info.Tag.FieldData[16];
    FSubTitle :=  Info.Tag.FieldData[17];
    FGroupTitle :=  Info.Tag.FieldData[18];
    FInterpreted :=  Info.Tag.FieldData[19];
    FOriginalTitle:=  Info.Tag.FieldData[21];
    FOriginalDate:=  Info.Tag.FieldData[22];
    if FSubTitle='' then FSubTitle :=  Info.Tag.FieldData[23];
    If FInterpreted='' then FInterpreted :=  Info.Tag.FieldData[24];
    FLyrics :=  Info.Tag.FieldData[25];
    if FLyrics='' then FLyrics := Info.Tag.FieldData[26];
    //FArtist2:=TempArtiest;
    Result := true; //TempArtiest.free;
  end;
end;

{ --------------------------------------------------------------------------- }

function TOpusVorbis.SaveTag(const FileName: String): Boolean;
var
  Info: FileInfo;
  Tag: TStringStream;
begin
  { Save Vorbis tag }
  Result := false;
  FillChar(Info, SizeOf(Info), 0);
  if GetInfo(FileName, Info) then
  begin
    { Prepare tag data and save to file }
    Info.Tag.FieldData[1] := Trim(FTitle);
    Info.Tag.FieldData[2] := Trim(FArtist);
    Info.Tag.FieldData[3] := Trim(FAlbum);
    if FTrack > 0 then Info.Tag.FieldData[4] := IntToStr(FTrack)
    else Info.Tag.FieldData[4] := '';
    Info.Tag.FieldData[5] := Trim(FDate);
    Info.Tag.FieldData[6] := Trim(FGenre);
    Info.Tag.FieldData[7] := Trim(FComment);
    Info.Tag.FieldData[8] := Trim(FOriginalArtist);
    Info.Tag.FieldData[9] := '';
    Info.Tag.FieldData[10] := Trim(FEncoder);
    Info.Tag.FieldData[11] := Trim(FComposer);
    Info.Tag.FieldData[12] := Trim(FCopyright);
    Info.Tag.FieldData[13] := Trim(FLicense);
    Info.Tag.FieldData[14] := Trim(FEncodedBy);
    Info.Tag.FieldData[15] := Trim(FOrchestra);
    Info.Tag.FieldData[16] := Trim(FConductor);
    Info.Tag.FieldData[23] := Trim(FSubTitle);
    Info.Tag.FieldData[18] := Trim(FGroupTitle);
    Info.Tag.FieldData[24] := Trim(FInterpreted);
    Info.Tag.FieldData[20] := '';
    Info.Tag.FieldData[21] := Trim(FOriginalTitle);
    Info.Tag.FieldData[22] := Trim(FOriginalDate);
    Info.Tag.FieldData[25] := Trim(FLyrics);
    Tag := BuildTag(Info);
    Info.SPage.Checksum := 0;
    SetLacingValues(Info, Tag.Size);
    Result := RebuildFile(FileName, Tag, Info);
    Tag.Free;
  end;
end;

{ --------------------------------------------------------------------------- }

function TOpusVorbis.ClearTag(const FileName: String): Boolean;
begin
  { Clear Vorbis tag }
  FTitle := '';
  FArtist := '';
  FAlbum := '';
  FTrack := 0;
  FDate := '';
  FGenre := '';
  FComment := '';
  FEncoder := '';
  FComposer := '';
  FCopyright := '';
  FOriginalArtist := '';
  FLicense := '';
  FEncodedBy := '';
  FOrchestra := '';
  FConductor := '';
  FSubTitle := '';
  FGroupTitle := '';
  FInterpreted := '';
  FOriginalTitle := '';
  FOriginalDate := '';
  FLyrics := '';
  Result := SaveTag(FileName);
end;

{ --------------------------------------------------------------------------- }

function TOpusVorbis.FGetRatio: Double;
begin
  { Get compression ratio }
  if FIsValid then
    //Result := FFileSize / (FSamples * FChannelModeID * FBitsPerSample / 8 + 44) * 100
    Result := FFileSize / (FSamples * (FChannelModeID * 16 / 8) + 44) * 100
  else
    Result := 0;
end;

{ --------------------------------------------------------------------------- }

function TOpusVorbis.FGetEncoder: String;
begin
  if FVendor = 'Xiphophorus libVorbis I 20000508' then Result := '1.0 beta 1 or beta 2'
  else if Fvendor = 'libopus 1.0.1' then Result := 'Opus 1.0.1'
  else Result := FVendor;
end;

{ --------------------------------------------------------------------------- }

end.
