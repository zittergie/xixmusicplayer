{*******************************************************************************
* The contents of this file are used with permission, subject to the Mozilla *
* Public License Version 1.1 (the "License"); you may not use this file except *
* in compliance with the License. You may obtain a copy of the License at *
* http://www.mozilla.org/MPL/ *
* *
* Software distributed under the License is distributed on an "AS IS" basis, *
* WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License for *
* the specific language governing rights and limitations under the License. *
* *
* The Original Code is distributed as part of the "mediate" product and is *
* Copyright (C) @home media limited. All Rights Reserved. *
* *
* Email: support@athomemedia.co.uk *
* Web: http://www.athomemedia.co.uk *
*******************************************************************************}

unit M4ATags;

interface

uses
Classes, SysUtils, md5, dialogs;//, BufferedStream;

type
TAHMM4AFile = class(TObject)
private
FFile: TFileStream;
FFileName: WideString;
FTitle: String;
FArtist: String;
FAlbum: String;
FAlbumArtist: String;
FYear: String;
FGenre: String;
FComposer: String;
FTrack: Word;
FDuration: Word;
FBitrate: Word;
FImageURL: String;
FThumbPath: String;
FCreateThumb: Boolean;
function GetThumbnailURL: String;
protected
property Stream: TFileStream read FFile;
property ThumbnailURL: String read GetThumbnailURL;
public
constructor Create;
destructor Destroy; override;
procedure Clear;
function OpenFile(FileName: WideString): Boolean;
function ReadTags: Boolean;
procedure Close;
property ThumbnailPath: String read FThumbPath write FThumbPath;
property CreateThumbnails: Boolean read FCreateThumb write FCreateThumb;
property Title: String read FTitle;
property Artist: String read FArtist;
property Album: String read FAlbum;
property AlbumArtist: String read FAlbumArtist;
property Year: String read FYear;
property Composer: String read FComposer;
property Track: Word read FTrack;
property Duration: Word read FDuration;
property Bitrate: Word read FBitrate;
property Genre: String read FGenre;
property ImageURL: String read FImageURL;
end;

implementation

//uses TagUtils;
uses ID3v1;

type
// Physical structure of M4A header
TM4AHeader = record
Size: LongWord;
ID: array[1..4] of Char;
Filetype: array[1..4] of Char;
end;

// Physical structure of M4A atom header
TM4AAtom = record
Size: LongWord;
ID: array [1..4] of Char;
end;

TM4AAtomType = (atDuration, atTitle, atAlbumArtist, atComposer, atAlbum,
atGenreId, atGenreName, atTrackNum, atDiskNum, atArtist,
atYear, atCompilation, atCover, atBitrate);

TM4AAtoms = array[TM4AAtomType] of String;

const
ATOM_LEN = SizeOf(TM4AAtom);
HEADER_LEN = SizeOf(TM4AHeader);

// Helper functions

function Swap32(const Figure: Integer): Integer;
var
Bytes: array [1..4] of Byte absolute Figure;
begin
// Swap 4 bytes (convert big endian to Delphi format)
Result := Bytes[1] * $1000000 + Bytes[2] * $10000 + Bytes[3] * $100 + Bytes[4];
end;

function FixAtomSize(const Figure: Integer): Integer;
begin
Result := Swap32(Figure);

// We don't handle special case of Size = 1 (i.e. Int64 length)
if Result = 1 then Abort;
end;

function ReadM4AHeader(Owner: TAHMM4AFile; var TagData: TM4AHeader): Boolean;
begin
with Owner do
try
// M4A header at beginning of file
if Stream = nil then Abort;
if Stream.Read(TagData, HEADER_LEN) < HEADER_LEN then Abort;

// Check size is at least 12 bytes (big endian)
TagData.Size := FixAtomSize(TagData.Size);
if TagData.Size < HEADER_LEN then Abort;

// Check atom ID and filetype signature
Result := (TagData.ID = 'ftyp') and (TagData.FileType = 'M4A ');

// Skip to the end of the header
if Result and (TagData.Size > HEADER_LEN) then
Stream.Seek(TagData.Size - HEADER_LEN, soFromCurrent);
except
Result := False;
end;
end;

procedure SkipAtom(Owner: TAHMM4AFile; const Atom: TM4AAtom; Read: LongWord = 0);
begin
// If this atom contains data other than the header then skip it
if Atom.Size > ATOM_LEN + Read then
Owner.Stream.Seek(Atom.Size - ATOM_LEN - Read, soFromCurrent);
end;

procedure SaveImageAtom(Owner: TAHMM4AFile; Atom: TM4AAtom);
var
Target: String;
DataLen: Integer;
Save: TFileStream;
begin
with Owner do
begin
// Generate target URL for thumbnail
Target := ThumbnailURL;

// If target already exists then no point saving, just skip atom
if FileExists(Target) then
SkipAtom(Owner, Atom)
else
begin
// Image type - calculate data size
DataLen := Atom.Size - ATOM_LEN - 8;
if DataLen < 0 then Abort;

// Skip 8 byte preamble then read image
Stream.Seek(8, soFromCurrent);

// Copy image to a filestream
Save := TFileStream.Create(Target, fmCreate);
try
Save.CopyFrom(Stream, DataLen);
finally
Save.Free;
end;

// Skip remainder of atom in case there are more images
SkipAtom(Owner, Atom, DataLen + 8);
end;
end;
end;

procedure ReadDataAtom(Owner: TAHMM4AFile; AtomType: TM4AAtomType; var Atoms: TM4AAtoms);
var
Buffy: Byte;
Atom: TM4AAtom;
DataLen: Integer;
begin
with Owner do
begin
// Read data atom header & fix big endian atom size
if Stream.Read(Atom, ATOM_LEN) <> ATOM_LEN then Abort;
Atom.Size := FixAtomSize(Atom.Size);

case AtomType of
atTitle, atAlbumArtist, atComposer, atAlbum, atGenreName, atArtist, atYear:
begin
// String type - calculate data size
DataLen := Atom.Size - ATOM_LEN - 8;
if DataLen < 0 then Abort;

// Skip 8 byte preamble then read string
Stream.Seek(8, soFromCurrent);
SetLength(Atoms[AtomType], DataLen);
Stream.Read(Pointer(Atoms[AtomType])^, DataLen);
end;
atGenreId:
begin
// This is an ID3v1 Genre Id in a single byte
Stream.Seek(9, soFromCurrent);
Stream.Read(Buffy, 1);
Atoms[AtomType] := aTAG_MusicGenre[Buffy];
end;
atTrackNum:
begin
// Skip preamble then read track number
Stream.Seek(11, soFromCurrent);
Stream.Read(Buffy, 1);
Atoms[AtomType] := IntToStr(Buffy);
SkipAtom(Owner, Atom, 12);
end;
atCover:
begin
// Do we want to cache cover thumbnails?
if CreateThumbnails then
SaveImageAtom(Owner, Atom)
else
SkipAtom(Owner, Atom);
end
else SkipAtom(Owner, Atom);
end;
end;
end;

procedure ReadListAtom(Owner: TAHMM4AFile; Atom: TM4AAtom; var Atoms: TM4AAtoms);
var
MaxPos: Integer;
begin
with Owner do
begin
// Calculate end position for this atom
MaxPos := Stream.Position - ATOM_LEN + Atom.Size;

// Read atom header
while Stream.Read(Atom, ATOM_LEN) = ATOM_LEN do
begin
// Fix big endian atom size
Atom.Size := FixAtomSize(Atom.Size);

// Look for iTunes known meta atoms of interest. For a full list see
// http://atomicparsley.sourceforge.net/mpeg-4files.html
if Atom.ID = '©nam' then ReadDataAtom(Owner, atTitle, Atoms)
else if Atom.ID = '©ART' then ReadDataAtom(Owner, atAlbumArtist, Atoms)
else if Atom.ID = '©wrt' then ReadDataAtom(Owner, atComposer, Atoms)
else if Atom.ID = '©alb' then ReadDataAtom(Owner, atAlbum, Atoms)
else if Atom.ID = '©gen' then ReadDataAtom(Owner, atGenreName, Atoms)
else if Atom.ID = 'gnre' then ReadDataAtom(Owner, atGenreId, Atoms)
else if Atom.ID = 'trkn' then ReadDataAtom(Owner, atTrackNum, Atoms)
else if Atom.ID = 'disk' then ReadDataAtom(Owner, atDiskNum, Atoms)
else if Atom.ID = '©art' then ReadDataAtom(Owner, atArtist, Atoms)
else if Atom.ID = '©day' then ReadDataAtom(Owner, atYear, Atoms)
else if Atom.ID = 'cpil' then ReadDataAtom(Owner, atCompilation, Atoms)
else if Atom.ID = 'covr' then ReadDataAtom(Owner, atCover, Atoms)
else SkipAtom(Owner, Atom);

// Don't read past end of meta atom
if Stream.Position >= MaxPos then Exit;
end;
end;
end;

procedure ReadMetaAtom(Owner: TAHMM4AFile; Atom: TM4AAtom; var Atoms: TM4AAtoms);
var
MaxPos: Integer;
begin
with Owner do
begin
// Calculate end position for this atom
MaxPos := Stream.Position - ATOM_LEN + Atom.Size;

// Skip 4 byte padding at start of meta atom
Stream.Seek(4, soFromCurrent);

// Read atom header
while Stream.Read(Atom, ATOM_LEN) = ATOM_LEN do
begin
// Fix big endian atom size
Atom.Size := FixAtomSize(Atom.Size);

// Look for iTunes list atom
if Atom.ID = 'ilst' then ReadListAtom(Owner, Atom, Atoms)
else SkipAtom(Owner, Atom);

// Don't read past end of meta atom
if Stream.Position >= MaxPos then Exit;
end;
end;
end;

procedure ReadITunesAtom(Owner: TAHMM4AFile; Atom: TM4AAtom; var Atoms: TM4AAtoms);
var
MaxPos: Integer;
begin
with Owner do
begin
// Calculate end position for this atom
MaxPos := Stream.Position - ATOM_LEN + Atom.Size;

// Read atom header
while Stream.Read(Atom, ATOM_LEN) = ATOM_LEN do
begin
// Fix big endian atom size
Atom.Size := FixAtomSize(Atom.Size);

// Look for iTunes meta atom
if Atom.ID = 'meta' then ReadMetaAtom(Owner, Atom, Atoms)
else SkipAtom(Owner, Atom);

// Don't read past end of iTunes atom
if Stream.Position >= MaxPos then Exit;
end;
end;
end;

procedure ReadMediaHeaderAtom(Owner: TAHMM4AFile; const Atom: TM4AAtom; var Atoms: TM4AAtoms);
var
Version: Byte;
iTimescale, iDuration: Integer;
begin
with Owner do
begin
// Read first byte - version
if Stream.Read(Version, 1) < 1 then Abort;

case Version of
0: begin
// Version 0 - skip to timescale
Stream.Seek(11, soFromCurrent);
Stream.Read(iTimescale, 4); // Sample rate
Stream.Read(iDuration, 4); // Number of samples
Atoms[atDuration] := IntToStr(Swap32(iDuration) div Swap32(iTimescale));
SkipAtom(Owner, Atom, 20);
end;
1: begin
// Version 1 - skip to timescale
Stream.Seek(19, soFromCurrent);
Stream.Read(iTimescale, 4); // Sample rate
Stream.Seek(4, soFromCurrent); // ignore first 4 bytes of duration
Stream.Read(iDuration, 4); // Number of samples
Atoms[atDuration] := IntToStr(Swap32(iDuration) div Swap32(iTimescale));
SkipAtom(Owner, Atom, 32);
end
else
begin
// Unsupported version - skip tag
SkipAtom(Owner, Atom, 1);
end;
end;
end;
end;

procedure ReadEncoderSettingsAtom(Owner: TAHMM4AFile; const Atom: TM4AAtom; var Atoms: TM4AAtoms);
var
iBitRate: Integer;
begin
with Owner do
begin
// Skip header stuff - just want the bitrate
Stream.Seek(26, soFromCurrent);

// Read average bitrate
Stream.Read(iBitRate, 4);
Atoms[atBitrate] := IntToStr(Swap32(iBitRate));

// Ignore the rest of this atom
SkipAtom(Owner, Atom, 30);
end;
end;

procedure ReadSampleDescriptionAtom(Owner: TAHMM4AFile; Atom: TM4AAtom; var Atoms: TM4AAtoms);
var
MaxPos: Integer;
MediaFormat: array[1..4] of Char;
begin
with Owner do
begin
// Calculate end position for this atom
MaxPos := Stream.Position - ATOM_LEN + Atom.Size;

// Skip preamble to find media format
Stream.Seek(12, soFromCurrent);

// Read audio format type
Stream.Read(MediaFormat, 4);

If MediaFormat = 'mp4a' then
begin
// Skip remainder of mp4a description
Stream.Seek(28, soFromCurrent);

// Read atom header
while Stream.Read(Atom, ATOM_LEN) = ATOM_LEN do
begin
// Fix big endian atom size
Atom.Size := FixAtomSize(Atom.Size);

// Look for encoder settings atom
if Atom.ID = 'esds' then ReadEncoderSettingsAtom(Owner, Atom, Atoms)
else if Atom.ID = 'm4ds' then ReadEncoderSettingsAtom(Owner, Atom, Atoms)
else SkipAtom(Owner, Atom);

// Don't read past end of sample description atom
if Stream.Position >= MaxPos then Exit;
end;
end
else
// Unknown audio format, so ignore sample description
SkipAtom(Owner, Atom, 16);
end;
end;

procedure ReadSampleFramingAtom(Owner: TAHMM4AFile; Atom: TM4AAtom; var Atoms: TM4AAtoms);
var
MaxPos: Integer;
begin
with Owner do
begin
// Calculate end position for this atom
MaxPos := Stream.Position - ATOM_LEN + Atom.Size;

// Read atom header
while Stream.Read(Atom, ATOM_LEN) = ATOM_LEN do
begin
// Fix big endian atom size
Atom.Size := FixAtomSize(Atom.Size);

// Look for sample description atom
if Atom.ID = 'stsd' then ReadSampleDescriptionAtom(Owner, Atom, Atoms)
else SkipAtom(Owner, Atom);

// Don't read past end of sample framing atom
if Stream.Position >= MaxPos then Exit;
end;
end;
end;

procedure ReadMediaInfoAtom(Owner: TAHMM4AFile; Atom: TM4AAtom; var Atoms: TM4AAtoms);
var
MaxPos: Integer;
begin
with Owner do
begin
// Calculate end position for this atom
MaxPos := Stream.Position - ATOM_LEN + Atom.Size;

// Read atom header
while Stream.Read(Atom, ATOM_LEN) = ATOM_LEN do
begin
// Fix big endian atom size
Atom.Size := FixAtomSize(Atom.Size);

// Look for sample table framing atom
if Atom.ID = 'stbl' then ReadSampleFramingAtom(Owner, Atom, Atoms)
else SkipAtom(Owner, Atom);

// Don't read past end of media info atom
if Stream.Position >= MaxPos then Exit;
end;
end;
end;

procedure ReadMediaAtom(Owner: TAHMM4AFile; Atom: TM4AAtom; var Atoms: TM4AAtoms);
var
MaxPos: Integer;
begin
with Owner do
begin
// Calculate end position for this atom
MaxPos := Stream.Position - ATOM_LEN + Atom.Size;

// Read atom header
while Stream.Read(Atom, ATOM_LEN) = ATOM_LEN do
begin
// Fix big endian atom size
Atom.Size := FixAtomSize(Atom.Size);

// Look for media header atom
if Atom.ID = 'mdhd' then ReadMediaHeaderAtom(Owner, Atom, Atoms)
else if Atom.ID = 'minf' then ReadMediaInfoAtom(Owner, Atom, Atoms)
else SkipAtom(Owner, Atom);

// Don't read past end of media atom
if Stream.Position >= MaxPos then Exit;
end;
end;
end;

procedure ReadTrackAtom(Owner: TAHMM4AFile; Atom: TM4AAtom; var Atoms: TM4AAtoms);
var
MaxPos: Integer;
begin
with Owner do
begin
// Calculate end position for this atom
MaxPos := Stream.Position - ATOM_LEN + Atom.Size;

// Read atom header
while Stream.Read(Atom, ATOM_LEN) = ATOM_LEN do
begin
// Fix big endian atom size
Atom.Size := FixAtomSize(Atom.Size);

// Look for media atom
if Atom.ID = 'mdia' then ReadMediaAtom(Owner, Atom, Atoms)
else SkipAtom(Owner, Atom);

// Don't read past end of track atom
if Stream.Position >= MaxPos then Exit;
end;
end;
end;

procedure ReadMovieAtom(Owner: TAHMM4AFile; Atom: TM4AAtom; var Atoms: TM4AAtoms);
var
MaxPos: Integer;
begin
with Owner do
begin
// Calculate end position for this atom
MaxPos := Stream.Position - ATOM_LEN + Atom.Size;

// Read atom header
while Stream.Read(Atom, ATOM_LEN) = ATOM_LEN do
begin
// Fix big endian atom size
Atom.Size := FixAtomSize(Atom.Size);

// Look for iTunes or Track header atom
if Atom.ID = 'udta' then ReadITunesAtom(Owner, Atom, Atoms)
else if Atom.ID = 'trak' then ReadTrackAtom(Owner, Atom, Atoms)
else SkipAtom(Owner, Atom);

// Don't read past end of movie atom
if Stream.Position >= MaxPos then Exit;
end;
end;
end;

procedure ReadM4AAtoms(Owner: TAHMM4AFile; var Atoms: TM4AAtoms);
var
Atom: TM4AAtom;
i: TM4AAtomType;
begin
// Clear current atom contents
for i := atDuration to atCover do Atoms[i] := '';

// Read atom header
while Owner.Stream.Read(Atom, ATOM_LEN) = ATOM_LEN do
begin
// Fix big endian atom size
Atom.Size := FixAtomSize(Atom.Size);

// Top level atoms - look for movie
if Atom.ID = 'moov' then
begin
ReadMovieAtom(Owner, Atom, Atoms);
Exit; // done once we have found movie
end
else SkipAtom(Owner, Atom);
end;
end;


// TAHMM4AFile

constructor TAHMM4AFile.Create;
begin
inherited;

Clear;
end;

destructor TAHMM4AFile.Destroy;
begin
FFile.Free;

inherited;
end;

function GetThumbnailName(const SourceURL: String): String;
begin
// Create printable MD5 hash of source URL with .thumb extension
Result := Lowercase(MD5Print(MD5String(SourceURL)) + '.thumb');
end;

function TAHMM4AFile.GetThumbnailURL: String;
begin
FImageURL := FThumbPath + GetThumbnailName(FFileName);
Result := FImageURL;
end;

procedure TAHMM4AFile.Clear;
begin
FTitle := '';
FArtist := '';
FAlbum := '';
FAlbumArtist := '';
FYear := '';
FGenre := '';
FComposer := '';
FTrack := 0;
FDuration := 0;
FBitrate := 0;
FImageURL := '';
end;

function TAHMM4AFile.OpenFile(FileName: WideString): Boolean;
begin
try
FFileName := FileName;
FFile := TFileStream.Create(FileName, fmOpenRead or fmShareDenyWrite);
Result := True;
except
Result := False;
end;
 if result then Writeln('File opened succesfull');
end;

function TAHMM4AFile.ReadTags: Boolean;
var
TagData: TM4AHeader;
Atoms: TM4AAtoms;
begin
// Set default result - failed
Result := False;
Clear;

try
// Attempt to read M4A tags. For details of M4A file structure see
// http://www.geocities.com/xhelmboyx/quicktime/formats/mp4-layout.txt
if ReadM4AHeader(Self, TagData) then
begin
ReadM4AAtoms(Self, Atoms);

// Populate properties from v2 atoms
FTitle := Atoms[atTitle];
Writeln('FTitle='+FTitle);
FAlbum := Atoms[atAlbum];
FYear := Atoms[atYear];
FTrack := StrToIntDef(Atoms[atTrackNum], 0);
FComposer := Atoms[atComposer];
FDuration := StrToIntDef(Atoms[atDuration], 0);
FBitrate := StrToIntDef(Atoms[atBitrate], 0);
if Atoms[atArtist] = '' then FArtist := Atoms[atAlbumArtist]
else FArtist := Atoms[atArtist];
if Atoms[atAlbumArtist] = '' then FAlbumArtist := Atoms[atArtist]
else FAlbumArtist := Atoms[atAlbumArtist];
if Atoms[atGenreId] = '' then FGenre := Atoms[atGenreName]
else FGenre := Atoms[atGenreId];
// Success
Result := True;
end;
except
  Writeln('Reading Tags went wrong');
// Damaged file structure - parsing failed
end;
end;

procedure TAHMM4AFile.Close;
begin
FreeAndNil(FFile);
end;


end.
