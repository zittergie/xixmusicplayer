{ *************************************************************************** }
{                                                                             }
{ Audio Tools Library                                                         }
{ Class TFLACfile - for manipulating with FLAC file information               }
{                                                                             }
{ http://mac.sourceforge.net/atl/                                             }
{ e-mail: macteam@users.sourceforge.net                                       }
{                                                                             }
{ Copyright (c) 2000-2002 by Jurgen Faul                                      }
{ Copyright (c) 2003-2005 by The MAC Team                                     }
{                                                                             }
{ Version 1.4-xix-1 (December 2013) by Bart Dezitter                          }
{ e-mail: info@xixmusicplayer.org                                             }
{   - Tested and updated for LAZARUS                                          }
{   - Removed uses of TntClasses, TntSysUtils, CommonATL                      }
{                                                                             }
{ Version 1.4 (April 2005) by Gambit                                          }
{   - updated to unicode file access                                          }
{                                                                             }
{ Version 1.3 (13 August 2004) by jtclipper                                   }
{   - unit rewritten, VorbisComment is obsolete now                           }
{                                                                             }
{ Version 1.2 (23 June 2004) by sundance                                      }
{   - Check for ID3 tags (although not supported)                             }
{   - Don't parse for other FLAC metablocks if FLAC header is missing         }
{                                                                             }
{ Version 1.1 (6 July 2003) by Erik                                           }
{   - Class: Vorbis comments (native comment to FLAC files) added             }
{                                                                             }
{ Version 1.0 (13 August 2002)                                                }
{   - Info: channels, sample rate, bits/sample, file size, duration, ratio    }
{   - Class TID3v1: reading & writing support for ID3v1 tags                  }
{   - Class TID3v2: reading & writing support for ID3v2 tags                  }
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

unit FLACfile;

interface

uses
  Classes, SysUtils, StrUtils, lazutf8classes;

const
  META_STREAMINFO      = 0;
  META_PADDING         = 1;
  META_APPLICATION     = 2;
  META_SEEKTABLE       = 3;
  META_VORBIS_COMMENT  = 4;
  META_CUESHEET        = 5;
  META_COVER_ART       = 6;

type
  TFlacHeader = record
    StreamMarker: array[1..4] of Char; //should always be 'fLaC'
    MetaDataBlockHeader: array[1..4] of Byte;
    Info: array[1..18] of Byte;
    MD5Sum: array[1..16] of Byte;
  end;

  TFlacTagCoverArtInfo = record
        PictureType: Cardinal;
        MIMEType: String;
        Description: String;
        Width: Cardinal;
        Height: Cardinal;
        ColorDepth: Cardinal;
        NoOfColors: Cardinal;
        PictureData: Pointer;
        SizeOfPictureData: Cardinal;
        Filename: string;
    end;

  TMetaData = record
    MetaDataBlockHeader: array[1..4] of Byte;
    Data: TMemoryStream;
    //* Only for cover art meta blocks
    CoverArtInfo: TFlacTagCoverArtInfo;
  end;


  TFLACfile = class(TObject)
  private

    FHeader: TFlacHeader;
    FFileName: String;
    FPaddingIndex: integer;
    FPaddingLast: boolean;
    FPaddingFragments: boolean;
    FVorbisIndex: integer;
    FPadding: integer;
    FVCOffset: integer;
    FAudioOffset: integer;
    FChannels: byte;
    FSampleRate: integer;
    FBitsPerSample: byte;
    FBitrate: integer;
    FFileLength: longint;
    FSamples: Int64;

    aMetaBlockOther: array of TMetaData;
    MetaBlocksCoverArts: array of TMetaData;
    FMetaBlocksSize: Integer;
    TmpSize: LongInt;


    // tag data
    FVendor2: string;
    FTagSize: LongInt;
    FExists: boolean;

  //  FID3v2: TID3v2;

    function FGetHasLyrics: boolean;

    procedure FResetData( const bHeaderInfo, bTagFields :boolean );
    function FIsValid: Boolean;
    function FGetDuration: Double;
    function FGetRatio: Double;
    function FGetChannelMode: string;

    function GetInfo( sFile: String; bSetTags: boolean ): boolean;
    procedure AddMetaDataOther( aMetaHeader: array of Byte; stream: TFileStreamUTF8; const iBlocklength,iIndex: integer );
    procedure ReadTag( Source: TFileStreamUTF8; bSetTagFields: boolean );
    function RebuildFile( const sFile: String; VorbisBlock: TStringStream ): Boolean;

    function DecodeUTF8(const Source: string): String;
  //  function EncodeUTF8(const Source: String): string;

    function CoverArtCount: Integer;
    function GetCoverArtInfoPointer(Index: Integer; var FlacTagCoverArtInfo: TFlacTagCoverArtInfo): Boolean;
    function CalculateMetaBlocksSize(IncludePadding: Boolean): Integer;


  public


    TrackString: string;
    Title: string;
    GroupTitle: string;
    SubTitle: string;
    Artist: string;
    Album: string;
    Year: string;
    Genre: string;
    Comment: string;
    //extra
    xTones: string;
    xStyles: string;
    xMood: string;
    xSituation: string;
    xRating: string;
    xQuality: string;
    xTempo: string;
    xType: string;
    //
    Composer: string;
    Language: string;
    Copyright: string;
    Link: string;
    Encoder: string;
    Lyrics: string;
    Performer: string;    (*OriginalArtist*)
    License: string;
    Organization: string;
    Description: string;
    Location: string;
    Contact: string;
    ISRC: string;
    OriginalTitle: string;
    OriginalYear: string;
    Orchestra: string;
    Conductor: string;
    Interpreted: string;
    aExtraFields: array of array of string;
    idVendor: string;
    SaveCDCover: boolean;
    CDCover: TFlacTagCoverArtInfo;

    ForceReWrite: boolean;

    constructor Create;
    destructor Destroy; override;

    function ReadFromFile( const sFile: String ): boolean;
    function SaveToFile( const sFile: String; const bBasicOnly: boolean = false ): boolean;
    function RemoveFromFile( const sFile: String ):boolean;
    procedure AddExtraField(const sID, sValue: string);
   // function SetCoverArt(Index: Integer; PictureStream: TStream; FlacTagCoverArtInfo: TFlacTagCoverArtInfo): Boolean;
    function SetCoverArt2(PictureType: integer;Filename: string; width, height: integer): Boolean;
    function GetCoverArt(Index: Integer; var PictureStream: TStream; var FlacTagCoverArtInfo: TFlacTagCoverArtInfo): Boolean;
    function AddMetaDataCoverArt(Stream: TStream; const Blocklength: Integer): Integer;

    property Channels: Byte read FChannels;                     // Number of channels
    property SampleRate: Integer read FSampleRate;              // Sample rate (hz)
    property BitsPerSample: Byte read FBitsPerSample;           // Bits per sample
    property FileLength: integer read FFileLength;              // File length (bytes)
    property Samples: Int64 read FSamples;                      // Number of samples
    property Valid: Boolean read FIsValid;                      // True if header valid
    property Duration: Double read FGetDuration;                // Duration (seconds)
    property Ratio: Double read FGetRatio;                      // Compression ratio (%)
    property Bitrate: integer read FBitrate;
    property ChannelMode: string read FGetChannelMode;
    property Exists: boolean read FExists;
    property Vendor2: string read FVendor2;
    property FileName: String read FFileName;
    property AudioOffset: integer read FAudioOffset;           //offset of audio data
    property HasLyrics: boolean read FGetHasLyrics;
  end;

var
  bTAG_PreserveDate: boolean;


implementation

function ReverseBytes(Value: Cardinal): Cardinal;
begin
    Result := (Value SHR 24) OR (Value SHL 24) OR ((Value AND $00FF0000) SHR 8) OR ((Value AND $0000FF00) SHL 8);
end;

(* -------------------------------------------------------------------------- *)

procedure TFLACfile.FResetData( const bHeaderInfo, bTagFields :boolean );
var
  i: integer;
begin
   ForceReWrite:=False;
   if bHeaderInfo then begin
      FFileName := '';
      FPadding := 0;
      FPaddingLast := false;
      FPaddingFragments := false;
      FChannels := 0;
      FSampleRate := 0;
      FBitsPerSample := 0;
      FFileLength := 0;
      FSamples := 0;
      FVorbisIndex := 0;
      FPaddingIndex := 0;
      FVCOffset := 0;
      FAudioOffset := 0;
      FMetaBlocksSize := 0;
    //  showMessage('In ResetData before cleaning MetaBlocks');
     for i := 0 to Length( aMetaBlockOther ) - 1 do aMetaBlockOther[ i ].Data.Free;
      SetLength( aMetaBlockOther, 0 );
      for i := 0 to Length(MetaBlocksCoverArts ) - 1 do begin
            if Assigned(MetaBlocksCoverArts[ i ].Data) then begin
                FreeAndNil(MetaBlocksCoverArts[ i ].Data);
            end;
        end;
        SetLength( MetaBlocksCoverArts, 0 );
   end;

   //tag data
   if bTagFields then begin
      FVendor2 := '';
      FTagSize := 0;
      FExists := false;
      Title := '';
      GroupTitle := '';
      SubTitle := '';
      Artist := '';
      Album := '';
      TrackString := '';
      Year := '';
      Genre := '';
      Comment := '';
      //extra
      xTones := '';
      xStyles := '';
      xMood := '';
      xSituation := '';
      xRating := '';
      xQuality := '';
      xTempo := '';
      xType := '';
      //
      Composer := '';
      Language := '';
      Copyright := '';
      Link := '';
      Encoder := '';
      Lyrics := '';
      Performer := '';     //ORIGINALARTIST
      License := '';
      Organization := '';
      Description := '';
      Location := '';
      Contact := '';
      ISRC := '';
      OriginalTitle := '';
      OriginalYear := '';
      Orchestra := '';    // ORCHESTRA
      Conductor := '';    // CONDUCTOR
      Interpreted := '';  // REMIXER
      SetLength( aExtraFields, 0 );
  end;    
end;

(* -------------------------------------------------------------------------- *)
// Check for right FLAC file data
function TFLACfile.FIsValid: Boolean;
begin
  result := (FHeader.StreamMarker = 'fLaC') and
            (FChannels > 0) and
            (FSampleRate > 0) and
            (FBitsPerSample > 0) and
            (FSamples > 0);
end;

(* -------------------------------------------------------------------------- *)

function TFLACfile.FGetDuration: Double;
begin
  if (FIsValid) and (FSampleRate > 0) then begin
     result := FSamples / FSampleRate
  end else begin
     result := 0;
  end;
end;

(* -------------------------------------------------------------------------- *)
//   Get compression ratio
function TFLACfile.FGetRatio: Double;
begin
  if FIsValid then begin
     result := FFileLength / (FSamples * FChannels * FBitsPerSample / 8) * 100
  end else begin
     result := 0;
  end;
end;


(* -------------------------------------------------------------------------- *)
//   Get channel mode
function TFLACfile.FGetChannelMode: string;
begin
  if FIsValid then begin
     case FChannels of
      1 : result := 'Mono';
      2 : result := 'Stereo';
      else result := 'Multi Channel';
     end;
  end else begin
     result := '';
  end;
end;

(* -------------------------------------------------------------------------- *)

function TFLACfile.FGetHasLyrics: boolean;
begin
  result := ( Trim( Lyrics ) <> '' );
end;

(* -------------------------------------------------------------------------- *)

constructor TFLACfile.Create;
begin
  inherited;
  FResetData( true, true );
end;
destructor TFLACfile.Destroy;
begin
  FResetData( true, true );
  inherited;
end;

(* -------------------------------------------------------------------------- *)

function TFLACfile.ReadFromFile( const sFile: String ): boolean;
begin
  FResetData( true, true );  // FResetData( false, true );
  result := GetInfo( sFile, true );
end;

(* -------------------------------------------------------------------------- *)
function StrToByte(const Value: String): TBytes;
var
    I: integer;
begin
    SetLength(Result, Length(Value));
    for I := 0 to Length(Value) - 1 do
        Result[I] := ord(Value[I + 1]);
end;

function TFLACfile.SetCoverArt2(PictureType: Integer; filename:string; width, height: integer): Boolean;
begin
  if fileexists(filename) then
  begin
    if pos('.jp',filename)>0 then CDCover.MIMEType:='image/jpeg';
    if pos('.png',filename)>0 then CDCover.MIMEType:='image/png';
    CDCover.PictureType:=PictureType;
    CDCover.Filename:=Filename;
    CDCover.Width:=width;
    CDcover.Height:=height;
    Result:=True; ForceRewrite:=True;
  end
  else Result:=False;
end;

function TFlacFile.CoverArtCount: Integer;
begin
    Result := Length(MetaBlocksCoverArts);
end;

function TFlacFile.AddMetaDataCoverArt(Stream: TStream; const Blocklength: Integer): Integer;
var
    iMetaLen: integer;
begin
    // enlarge array
    iMetaLen := Length(MetaBlocksCoverArts) + 1;
    SetLength(MetaBlocksCoverArts, iMetaLen);
    // save header
    MetaBlocksCoverArts[iMetaLen - 1].MetaDataBlockHeader[1] := META_COVER_ART; //aMetaHeader[0];
    // save content in a stream
    MetaBlocksCoverArts[iMetaLen - 1].Data := TMemoryStream.Create;
    if Assigned(Stream) then begin
        MetaBlocksCoverArts[iMetaLen - 1].Data.CopyFrom(Stream, Blocklength);
    end;
    Result := iMetaLen - 1;
end;

function TFlacFile.GetCoverArtInfoPointer(Index: Integer; var FlacTagCoverArtInfo: TFlacTagCoverArtInfo): Boolean;
var
    i: Integer;
    Stream: TStream;
    MIMETypeLength: Cardinal;
    Data: Byte;
    DescriptionLength: Cardinal;
    Bytes: TBytes;
    Offset: Cardinal;
begin
    Result := False;
    with FlacTagCoverArtInfo do begin
        PictureType := 0;
        MIMEType := '';
        Description := '';
        Width := 0;
        Height := 0;
        ColorDepth := 0;
        NoOfColors := 0;
        PictureData := nil;
        SizeOfPictureData := 0;
    end;
    if (Index < 0)
    OR (Index >= Length(MetaBlocksCoverArts))
    then begin
        Exit;
    end;
    with FlacTagCoverArtInfo do begin
        Stream := MetaBlocksCoverArts[Index].Data;
        Stream.Seek(0, soBeginning);
        Stream.Read(PictureType, 4);
        PictureType := ReverseBytes(PictureType);
        Stream.Read(MIMETypeLength, 4);
        MIMETypeLength := ReverseBytes(MIMETypeLength);
        for i := 0 to MIMETypeLength - 1 do begin
            Stream.Read(Data, 1);
            MIMEType := MIMEType + Char(Data);
        end;
        Stream.Read(DescriptionLength, 4);
        DescriptionLength := ReverseBytes(DescriptionLength);
        if DescriptionLength > 0 then begin
            SetLength(Bytes, DescriptionLength);
            for i := 0 to DescriptionLength - 1 do begin
                Stream.Read(Data, 1);
                Bytes[i] := Data;
            end;
            Description :='';
            for i:=0 to descriptionlength-1 do Description := Description+chr(Bytes[i]);
        end else begin
            Description := '';
        end;
        Stream.Read(Width, 4);
        Width := ReverseBytes(Width);
        Stream.Read(Height, 4);
        Height := ReverseBytes(Height);
        Stream.Read(ColorDepth, 4);
        ColorDepth := ReverseBytes(ColorDepth);
        Stream.Read(NoOfColors, 4);
        NoOfColors := ReverseBytes(NoOfColors);
        Stream.Read(SizeOfPictureData, 4);
        SizeOfPictureData := ReverseBytes(SizeOfPictureData);
        PictureData := TMemoryStream(Stream).Memory;
        Offset := Stream.Position;
        PictureData := Pointer(NativeUInt(PictureData) + Offset);
    end;
    Result := True;
end;

function TFlacFile.GetCoverArt(Index: Integer; var PictureStream: TStream; var FlacTagCoverArtInfo: TFlacTagCoverArtInfo): Boolean;
var
    i: Integer;
    Stream: TStream;
    MIMETypeLength: Cardinal;
    Data: Byte;
    Bytes: TBytes;
    DescriptionLength: Cardinal;
    LengthOfPictureData: Cardinal;
begin
    Result := False;
    with FlacTagCoverArtInfo do begin
        PictureType := 0;
        MIMEType := '';
        Description := '';
        Width := 0;
        Height := 0;
        ColorDepth := 0;
        NoOfColors := 0;
        SizeOfPictureData := 0;
    end;
    if (Index < 0)
    OR (Index >= Length(MetaBlocksCoverArts))
    then begin
        Exit;
    end;
    Stream := MetaBlocksCoverArts[Index].Data;
    Stream.Seek(0, soBeginning);
    with FlacTagCoverArtInfo do begin
        Stream.Read(PictureType, 4);
        PictureType := ReverseBytes(PictureType);
        Stream.Read(MIMETypeLength, 4);
        MIMETypeLength := ReverseBytes(MIMETypeLength);
        for i := 0 to MIMETypeLength - 1 do begin
            Stream.Read(Data, 1);
            MIMEType := MIMEType + Char(Data);
        end;
        Stream.Read(DescriptionLength, 4);
        DescriptionLength := ReverseBytes(DescriptionLength);
        if DescriptionLength > 0 then begin
            SetLength(Bytes, DescriptionLength);
            for i := 0 to DescriptionLength - 1 do begin
                Stream.Read(Data, 1);
                Bytes[i] := Data;
            end;
            Description :='';
            for i:=0 to descriptionlength-1 do Description := Description+chr(Bytes[i]);
        end else begin
            Description := '';
        end;
        Stream.Read(Width, 4);      Width := ReverseBytes(Width);
        Stream.Read(Height, 4);     Height := ReverseBytes(Height);
        Stream.Read(ColorDepth, 4); ColorDepth := ReverseBytes(ColorDepth);
        Stream.Read(NoOfColors, 4); NoOfColors := ReverseBytes(NoOfColors);
        Stream.Read(LengthOfPictureData, 4);
        LengthOfPictureData := ReverseBytes(LengthOfPictureData);
        SizeOfPictureData := LengthOfPictureData;
        PictureStream.CopyFrom(Stream, LengthOfPictureData);
        PictureStream.Seek(0, soBeginning);
    end;
    Result := True;
end;

function TFLACfile.GetInfo( sFile: String; bSetTags: boolean ): boolean;
var
  SourceFile: TFileStreamutf8;
  aMetaDataBlockHeader: array[1..4] of byte;
  iBlockLength, iMetaType, iIndex: longint;
  bPaddingFound: boolean;
  CoverArtIndex: Integer;
begin

  result := true;
  bPaddingFound := false;
  FResetData( true, false );  
  try
 (* Read data from ID3 tags  -  Removed until FID3v2
    FID3v2.ReadFromFile(sFile); *)

    // Set read-access and open file
    SourceFile := TFileStreamutf8.Create( sFile, fmOpenRead or fmShareDenyWrite);
    FFileLength := SourceFile.Size;
    FFileName := sFile;

 (* Seek past the ID3v2 tag, if there is one -  Removed until FID3v2

    if FID3v2.Exists then begin
      SourceFile.Seek(FID3v2.Size, soFromBeginning)     end;  *)

    // Read header data
    FillChar( FHeader, SizeOf(FHeader), 0 );
    //ShowMessage('FHeader',inttostr(Sizeof(FHeader)));
    SourceFile.Read( FHeader, SizeOf(FHeader) );

    // Process data if loaded and header valid
    if FHeader.StreamMarker = 'fLaC' then begin

       with FHeader do begin
         FChannels      := ( Info[13] shr 1 and $7 + 1 );
         FSampleRate    := ( Info[11] shl 12 or Info[12] shl 4 or Info[13] shr 4 );
         FBitsPerSample := ( Info[13] and 1 shl 4 or Info[14] shr 4 + 1 );
         FSamples       := ( Info[15] shl 24 or Info[16] shl 16 or Info[17] shl 8 or Info[18] );
       end;

       if (FHeader.MetaDataBlockHeader[1] and $80) <> 0 then exit; //no metadata blocks exist
       iIndex := 0;
       repeat // read more metadata blocks if available
          SourceFile.Read( aMetaDataBlockHeader, 4 );

          iIndex := iIndex + 1; // metadatablock index
          iBlockLength := (aMetaDataBlockHeader[2] shl 16 or aMetaDataBlockHeader[3] shl 8 or aMetaDataBlockHeader[4]); //decode length

          if iBlockLength <= 0 then
          begin
            FMetaBlocksSize := FMetaBlocksSize + 4;
            Continue; // can it be 0 ?
          end;

          iMetaType := (aMetaDataBlockHeader[1] and $7F); // decode metablock type

          if iMetaType = META_VORBIS_COMMENT then
          begin  // read vorbis block
             FVCOffset := SourceFile.Position;
             FTagSize := iBlockLength;
             FVorbisIndex := iIndex;
           (*  if (FTagSize>4096) then
             begin
               ShowMessage('SourceFile='+SourceFile.FileName);
               ShowMessage('Size Tag='+inttostr(FTagSize));
              // exit;  //Find out why FTagsize can be wrong       // CHECK IS NOW IN THE READTAG
             end;      *)

             ReadTag(SourceFile, bSetTags); // set up fields
          end
                                              else
             if (iMetaType = META_PADDING) and not bPaddingFound then
             begin // we have padding block
               FPadding := iBlockLength;                                            // if we find more skip & put them in metablock array
               FPaddingLast := ((aMetaDataBlockHeader[1] and $80) <> 0);
               FPaddingIndex := iIndex;
               bPaddingFound := true;
               SourceFile.Seek(FPadding, soCurrent); // advance into file till next block or audio data start
             end
                                                                  else
             begin // all other
               if iMetaType <= 6 then
               begin // is it a valid metablock ?
                 if (iMetaType = META_PADDING) then
                 begin // set flag for fragmented padding blocks
                    FPaddingFragments := true;
                 end;
                 if iMetaType = META_COVER_ART then
                 begin
                   if bSetTags then begin
                                     CoverArtIndex := AddMetaDataCoverArt({aMetaDataBlockHeader,} SourceFile, iBlocklength {, iIndex});
                                     GetCoverArtInfoPointer(CoverArtIndex, Self.MetaBlocksCoverArts[CoverArtIndex].CoverArtInfo);
                                   end
                              else begin
                                     SourceFile.Seek(iBlocklength, soCurrent);
                                   end;

                 end
                 else
                 begin
                   AddMetaDataOther(aMetaDataBlockHeader, SourceFile, iBlocklength, iIndex);
                 end;
                 FMetaBlocksSize := FMetaBlocksSize + iBlocklength + 4;
               end
                                  else
               begin
                 //ShowMessage('Something went wrong'+#13+'Metatype='+inttostr(iMetaType));
                 FSamples := 0; //ops...
                 exit;
               end;
             end;
      //    end;

       until ((aMetaDataBlockHeader[1] and $80) <> 0); // until is last flag ( first bit = 1 )

    end;
  finally
    if FIsValid then
    begin
      //ShowMessage('SourceFile.Position='+inttostr(SourceFile.Position));
       FAudioOffset := SourceFile.Position;  // we need that to rebuild the file if nedeed
       FBitrate := Round( ( ( FFileLength - FAudioOffset ) / 1000 ) * 8 / FGetDuration ); //time to calculate average bitrate
    end
                else
    begin
      result := false;
    end;
    FreeAndNil(SourceFile);
  end;

end;

(* -------------------------------------------------------------------------- *)

procedure TFLACfile.AddMetaDataOther( aMetaHeader: array of Byte; stream: TFileStreamUTF8; const iBlocklength,iIndex: integer );
var
  iMetaLen: integer;
begin
  // enlarge array
  iMetaLen := Length( aMetaBlockOther ) + 1;
  SetLength( aMetaBlockOther, iMetaLen );
  // save header
  aMetaBlockOther[ iMetaLen - 1 ].MetaDataBlockHeader[1] := aMetaHeader[0];
  aMetaBlockOther[ iMetaLen - 1 ].MetaDataBlockHeader[2] := aMetaHeader[1];
  aMetaBlockOther[ iMetaLen - 1 ].MetaDataBlockHeader[3] := aMetaHeader[2];
  aMetaBlockOther[ iMetaLen - 1 ].MetaDataBlockHeader[4] := aMetaHeader[3];
  // save content in a stream
  aMetaBlockOther[ iMetaLen - 1 ].Data := TMemoryStream.Create;
  aMetaBlockOther[ iMetaLen - 1 ].Data.Position := 0;
  aMetaBlockOther[ iMetaLen - 1 ].Data.CopyFrom( stream, iBlocklength );
end;

(* -------------------------------------------------------------------------- *)

procedure TFLACfile.ReadTag( Source: TFileStreamUTF8; bSetTagFields: boolean );
var
  i, iCount, iSize, iSepPos: longInt;
  Data: array of Char;
  sFieldID, sFieldData: string;
begin

  Source.Read( iSize, SizeOf( iSize ) ); // vendor
  SetLength( Data, iSize );
  Source.Read( Data[ 0 ], iSize );
 // try  FVendor2 := String( Data );
   FVendor2 := copy(string(Data),1,iSize);
   idVendor:= FVendor2;
 // except ShowMessage('Error String()');  end;
  Source.Read( iCount, SizeOf( iCount ) ); //fieldcount
  If icount>255 then icount:=0;

  FExists := ( iCount > 0 );

  for i := 0 to iCount - 1 do begin
      Source.Read( iSize, SizeOf( iSize ) );
      SetLength( Data , iSize+1 ); // Add one to setlength, otherwise we lose last char
      Source.Read( Data[ 0], iSize );

      if not bSetTagFields then Continue; // if we don't want to re asign fields we skip
      
      iSepPos := Pos( '=', String( Data ) );
      if iSepPos > 0 then begin

         sFieldID := UpperCase( Copy( String( Data ), 1, iSepPos - 1) );
         If (length(Data)>8000) or (sFieldID='COVERART_UUENCODED')
            then sFieldData := Copy( String( Data ), iSepPos + 1, MaxInt)
            else sFieldData := DecodeUTF8(Copy( String( Data ), iSepPos + 1, MaxInt));

         if (sFieldID = 'TRACKNUMBER') and (TrackString = '') then begin
            TrackString := sFieldData;
         end else if (sFieldID = 'ARTIST') and (Artist = '') then begin
            Artist := sFieldData;
         end else if (sFieldID = 'ALBUM') and (Album = '') then begin
            Album := sFieldData;
         end else if (sFieldID = 'TITLE') and (Title = '') then begin
            Title := sFieldData;
         end else if (sFieldID = 'GROUPING') and (GroupTitle = '') then begin
            GroupTitle := sFieldData;
         end else if (sFieldID = 'SUBTITLE') and (SubTitle = '') then begin
            SubTitle := sFieldData;
         end else if (sFieldID = 'DATE') and (Year = '') then begin
            Year := sFieldData;
         end else if (sFieldID = 'GENRE') and (Genre = '') then begin
            Genre := sFieldData;
         end else if (sFieldID = 'COMMENT') and (Comment = '') then begin
            Comment := sFieldData;
         end else if (sFieldID = 'COMPOSER') and (Composer = '') then begin
            Composer := sFieldData;
         end else if (sFieldID = 'LANGUAGE') and (Language = '') then begin
            Language := sFieldData;
         end else if (sFieldID = 'COPYRIGHT') and (Copyright = '') then begin
            Copyright := sFieldData;
         end else if (sFieldID = 'URL') and (Link = '') then begin
            Link := sFieldData;
         end else if (sFieldID = 'ENCODER') and (Encoder = '') then begin
            Encoder := sFieldData;
         end else if (sFieldID = 'TONES') and (xTones = '') then begin
            xTones := sFieldData;
         end else if (sFieldID = 'STYLES') and (xStyles = '') then begin
            xStyles := sFieldData;
         end else if (sFieldID = 'MOOD') and (xMood = '') then begin
            xMood := sFieldData;
         end else if (sFieldID = 'SITUATION') and (xSituation = '') then begin
            xSituation := sFieldData;
         end else if (sFieldID = 'RATING') and (xRating = '') then begin
            xRating := sFieldData;
         end else if (sFieldID = 'QUALITY') and (xQuality = '') then begin
            xQuality := sFieldData;
         end else if (sFieldID = 'TEMPO') and (xTempo = '') then begin
            xTempo := sFieldData;
         end else if (sFieldID = 'TYPE') and (xType = '') then begin
            xType := sFieldData;
         end else if (sFieldID = 'LYRICS') and (Lyrics = '') then begin
            Lyrics := sFieldData;
         end else if (sFieldID = 'PERFORMER') and (Performer = '') then begin
            Performer := sFieldData;
         end else if (sFieldID = 'LICENSE') and (License = '') then begin
            License := sFieldData;
         end else if (sFieldID = 'ORGANIZATION') and (Organization = '') then begin
            Organization := sFieldData;
         end else if (sFieldID = 'DESCRIPTION') and (Description = '') then begin
            Description := sFieldData;
         end else if (sFieldID = 'LOCATION') and (Location = '') then begin
            Location := sFieldData;
         end else if (sFieldID = 'CONTACT') and (Contact = '') then begin
            Contact := sFieldData;
         end else if (sFieldID = 'ISRC') and (ISRC = '') then begin
            ISRC := sFieldData;
         end else if (sFieldID = 'ORCHESTRA') and (Orchestra = '') then begin
            Orchestra := sFieldData;
         end else if (sFieldID = 'ENSEMBLE') and (Orchestra = '') then begin
            Orchestra := sFieldData;
         end else if (sFieldID = 'CONDUCTOR') and (Conductor = '') then begin
            Conductor := sFieldData;
         end else if (sFieldID = 'REMIXER') and (Interpreted = '') then begin
            Interpreted := sFieldData;
         end else if (sFieldID = 'ORIGINAL TITLE') and (OriginalTitle = '') then begin
            OriginalTitle := sFieldData;
         end else if (sFieldID = 'ORIGINAL YEAR') and (OriginalYear = '') then begin
            OriginalYear := sFieldData;
         end else begin // more fields
            AddExtraField( sFieldID, sFieldData );
         end;
      end;
  end;
end;

(* -------------------------------------------------------------------------- *)

procedure TFLACfile.AddExtraField(const sID, sValue: string);
var
  iExtraLen: integer;
begin
  iExtraLen := Length( aExtraFields ) + 1;
  SetLength( aExtraFields, iExtraLen );
  SetLength( aExtraFields[ iExtraLen - 1 ], 2 );

  aExtraFields[ iExtraLen - 1, 0 ] := sID;
  aExtraFields[ iExtraLen - 1, 1 ] := sValue;
end;

(* -------------------------------------------------------------------------- *)

function TFLACfile.SaveToFile( const sFile: String; const bBasicOnly: boolean = false ): boolean;
var
  i, iFieldCount, iSize: Integer;
  VorbisBlock, Tag: TStringStream;
  TempStr: TStringstream;
  TempFile: TFileStreamUTF8;

  procedure _WriteTagBuff( sID, sData: string );
  var
    sTmp: string;
    iTmp: integer;
  begin
    if sData <> '' then  begin
       sTmp := sID + '=' + {EncodeUTF8}( sData );
       iTmp := Length( sTmp );
       Tag.Write( iTmp, SizeOf( iTmp ) );
       Tag.WriteString( sTmp );
       iFieldCount := iFieldCount + 1;
    end;
  end;

  procedure _WritePictureBuff( sID: string );
  var
    sTmp: string;
    iTmp: integer;
    temp: string;
    HexTemp: string[4];
  begin
    if sID <> '' then
    begin
       //Type van Picture.  3= CDCover
       temp:=HexStr(CDCover.PictureType,8);
       HexTemp[1]:=chr(Hex2Dec(copy(temp,1,2)));HexTemp[2]:=chr(Hex2Dec(copy(temp,3,2)));
       HexTemp[3]:=chr(Hex2Dec(copy(temp,5,2)));HexTemp[4]:=chr(Hex2Dec(copy(temp,7,2)));
       sTmp := HexTemp[1]+HexTemp[2]+HexTemp[3]+HexTemp[4];
       //Mime van Picture.  Momenteel enkel JPG
       if cdcover.mimetype='image/png' then  sTmp := sTMP+#00+#00+#00+chr(Byte(9))+'image/png'
                                       else  sTmp := sTMP+#00+#00+#00+chr(Byte(10))+'image/jpeg';  // MimeType
       //Omschrijving van Picture.  Voorlopig enkel CD Cover
       temp:=HexStr(length('CD Cover'),8);   // Discription
       HexTemp[1]:=chr(Hex2Dec(copy(temp,1,2)));HexTemp[2]:=chr(Hex2Dec(copy(temp,3,2)));
       HexTemp[3]:=chr(Hex2Dec(copy(temp,5,2)));HexTemp[4]:=chr(Hex2Dec(copy(temp,7,2)));
       sTmp := sTMP+HexTemp[1]+HexTemp[2]+HexTemp[3]+HexTemp[4]+'CD Cover';
       //Width
       temp:=HexStr(CDCover.Width,8);    // Width
                                         // ShowMessage('CDCover.Width='+inttostr(CDCover.Width));
       HexTemp[1]:=chr(Hex2Dec(copy(temp,1,2)));HexTemp[2]:=chr(Hex2Dec(copy(temp,3,2)));
       HexTemp[3]:=chr(Hex2Dec(copy(temp,5,2)));HexTemp[4]:=chr(Hex2Dec(copy(temp,7,2)));
       sTmp := sTMP+HexTemp[1]+HexTemp[2]+HexTemp[3]+HexTemp[4];
       //Heigth
       temp:=HexStr(CDCover.Height,8);    // Hight
       HexTemp[1]:=chr(Hex2Dec(copy(temp,1,2)));HexTemp[2]:=chr(Hex2Dec(copy(temp,3,2)));
       HexTemp[3]:=chr(Hex2Dec(copy(temp,5,2)));HexTemp[4]:=chr(Hex2Dec(copy(temp,7,2)));
       sTmp := sTMP+HexTemp[1]+HexTemp[2]+HexTemp[3]+HexTemp[4];
       sTMP := sTMP+#00+#00+#00+chr(Byte(32)); // Bit
       sTMP := sTMP+#00+#00+#00+chr(Byte(0));  //Colordepth

       //CDCover
       TempStr:=TStringStream.Create('');
       TempFile:=TFileStreamUTF8.create(CDCover.filename,fmOpenRead);
       TempFile.Seek(0,soFromBeginning);
       TempStr.CopyFrom(TempFile,TempFile.Size);
       temp:=HexStr(TempFile.Size,8);  //ShowMessage('FileSize='+inttostr(TempFile.Size));
       HexTemp[1]:=chr(Hex2Dec(copy(temp,1,2)));HexTemp[2]:=chr(Hex2Dec(copy(temp,3,2)));
       HexTemp[3]:=chr(Hex2Dec(copy(temp,5,2)));HexTemp[4]:=chr(Hex2Dec(copy(temp,7,2)));
       sTmp := sTMP+HexTemp[1]+HexTemp[2]+HexTemp[3]+HexTemp[4];
       sTmp := sTMP + Tempstr.DataString;

       //Volledige grote Tag
       iTmp := Length( sTmp );  //ShowMessage('TagSize='+inttostr(iTmp));
       temp:=HexStr(itmp,8);    //ShowMessage('HEX='+temp);
       HexTemp[1]:=chr(Hex2Dec(copy(temp,1,2)));HexTemp[2]:=chr(Hex2Dec(copy(temp,3,2)));
       HexTemp[3]:=chr(Hex2Dec(copy(temp,5,2)));HexTemp[4]:=chr(Hex2Dec(copy(temp,7,2)));
       Tag.WriteString( chr(134)+HexTemp[2]+HexTemp[3]+HexTemp[4] );

       //Effectieve TAG
       Tag.WriteString( sTmp );

       Tempstr.Destroy; TempFile.Destroy;
    end;
  end;

begin

  try
    result := false;

    Tag := TStringStream.Create('');
    VorbisBlock := TStringStream.Create('');

    if not GetInfo( sFile, false ) then
    begin
       //ShowMessage('Something went wrong re-reading TAG info');
       exit; //reload all except tag fields
    end;
    iFieldCount := 0;

    _WriteTagBuff( 'TRACKNUMBER', TrackString );
    _WriteTagBuff( 'ARTIST', Artist );
    _WriteTagBuff( 'ALBUM', Album );
    _WriteTagBuff( 'TITLE', Title );
    _WriteTagBuff( 'DATE', Year );
    _WriteTagBuff( 'GENRE', Genre );
    _WriteTagBuff( 'COMMENT', Comment );
    _WriteTagBuff( 'COMPOSER', Composer );
    _WriteTagBuff( 'LANGUAGE', Language );
    _WriteTagBuff( 'COPYRIGHT', Copyright );
    _WriteTagBuff( 'URL', Link );
    _WriteTagBuff( 'ENCODER', Encoder );

    _WriteTagBuff( 'TONES', xTones );
    _WriteTagBuff( 'STYLES', xStyles );
    _WriteTagBuff( 'MOOD', xMood );
    _WriteTagBuff( 'SITUATION', xSituation );
    _WriteTagBuff( 'RATING', xRating );
    _WriteTagBuff( 'QUALITY', xQuality );
    _WriteTagBuff( 'TEMPO', xTempo );
    _WriteTagBuff( 'TYPE', xType );

    if not bBasicOnly then begin
       _WriteTagBuff( 'PERFORMER', Performer );
       _WriteTagBuff( 'LICENSE', License );
       _WriteTagBuff( 'ORGANIZATION', Organization );
       _WriteTagBuff( 'DESCRIPTION', Description );
       _WriteTagBuff( 'LOCATION', Location );
       _WriteTagBuff( 'CONTACT', Contact );
       _WriteTagBuff( 'ISRC', ISRC );
       _WriteTagBuff( 'LYRICS', Lyrics );
       _WriteTagBuff( 'ORCHESTRA', Orchestra );
       _WriteTagBuff( 'CONDUCTOR', Conductor );
       _WriteTagBuff( 'REMIXER', Interpreted );
       _WriteTagBuff( 'GROUPING', GroupTitle );
       _WriteTagBuff( 'SUBTITLE', SubTitle );
       _WriteTagBuff( 'ORIGINAL TITLE', OriginalTitle );
       _WriteTagBuff( 'ORIGINAL YEAR', OriginalYear );

       for i := 0 to Length( aExtraFields ) - 1 do begin
           if Trim( aExtraFields[ i, 0 ] ) <> '' then _WriteTagBuff( aExtraFields[ i, 0 ], aExtraFields[ i, 1 ] );
       end;

       TmpSize := Tag.Size;

       if SaveCDCover then
       begin
         _WritePictureBuff('Write me');
       end;
    end;

    // Write vendor info and number of fields
    with VorbisBlock do begin
      if FVendor2 = '' then FVendor2 := idVendor;
      if FVendor2 = '' then FVendor2 := 'reference libFLAC 1.1.0 20030126'; // guess it
      iSize := Length(FVendor2)+1;
      Write(iSize, SizeOf(iSize));
      WriteString(FVendor2+' ');
      Write(iFieldCount, SizeOf(iFieldCount));
    end;

    VorbisBlock.CopyFrom( Tag, 0 ); // All tag data is here now
    VorbisBlock.Position := 0;

    result := RebuildFile( sFile, VorbisBlock );
    FExists := result and (Tag.Size > 0 );

  finally
    FreeAndNil( Tag );
    FreeAndNil( VorbisBlock );
  end;

end;

(* -------------------------------------------------------------------------- *)

function TFLACfile.RemoveFromFile( const sFile: String ):boolean;
begin
  FResetData( false, true );
  result := SaveToFile( sFile );
  if FExists then FExists := not result;
end;

(* -------------------------------------------------------------------------- *)

function TFlacFile.CalculateMetaBlocksSize(IncludePadding: Boolean): Integer;
var
    i: Integer;
begin
    Result := 0;
    for i := 0 to Length(aMetaBlockOther) - 1 do begin
        if ((aMetaBlockOther[i].MetaDataBlockHeader[1] and $7F) = META_PADDING) then begin
            if IncludePadding then begin
                Result := Result + aMetaBlockOther[i].Data.Size + 4;
            end;
        end else begin
            Result := Result + aMetaBlockOther[i].Data.Size + 4;
        end;
    end;
end;

// saves metablocks back to the file
// always tries to rebuild header so padding exists after comment block and no more than 1 padding block exists
function TFLACfile.RebuildFile( const sFile: {Wide}String; VorbisBlock: TStringStream ): Boolean;
var
  Source, Destination: TFileStreamUTF8;
  i, iFileAge, iNewPadding, iMetaCount, iExtraPadding: Integer;
  BufferName, sTmp: string;
  MetaDataBlockHeader: array[1..4] of Byte;
  oldHeader: TFlacHeader;
  MetaBlocks: TMemoryStream;
  bRebuild, bRearange: boolean;
  NewMetaBlocksSize: Integer;
  temp: string;
  HexTemp: string[4];

begin
  //if savecdcover then ShowMessage('Save cover');

  result := false;
  bRearange := false;
  iExtraPadding := 0;
  if (not FileExists(sFile)) then exit;

  NewMetaBlocksSize := CalculateMetaBlocksSize(True);

  try
    iFileAge := 0;
    if bTAG_PreserveDate then iFileAge := FileAge( sFile );

    // re arrange other metadata in case of
    // 1. padding block is not aligned after vorbis comment
    // 2. insufficient padding - rearange upon file rebuild
    // 3. fragmented padding blocks
    iMetaCount := Length( aMetaBlockOther );
    if (FPaddingIndex <> FVorbisIndex + 1)
      or (FPadding <= VorbisBlock.Size - FTagSize )
      or (FMetaBlocksSize <> NewMetaBlocksSize)
      or FPaddingFragments
      or saveCDCover
      then
      begin
       MetaBlocks := TMemoryStream.Create;

       for i := 0 to iMetaCount - 1 do
       begin
           aMetaBlockOther[ i ].MetaDataBlockHeader[ 1 ] := ( aMetaBlockOther[ i ].MetaDataBlockHeader[ 1 ] and $7f ); // not last

           if aMetaBlockOther[ i ].MetaDataBlockHeader[ 1 ] = META_PADDING then begin
              iExtraPadding := iExtraPadding + aMetaBlockOther[ i ].Data.Size + 4; // add padding size plus 4 bytes of header block
           end else begin
                      aMetaBlockOther[ i ].Data.Position := 0;
                      MetaBlocks.Write( aMetaBlockOther[ i ].MetaDataBlockHeader[ 1 ], 4 );
                      MetaBlocks.CopyFrom( aMetaBlockOther[ i ].Data, 0 );
                    end;
       end;

       MetaBlocks.Position := 0;
       bRearange := true;
    end;

    // set up file
    if (FPadding <= VorbisBlock.Size - FTagSize ) or ForceRewrite or SaveCDCover then
    begin // no room rebuild the file from scratch
      // ShowMessage('No room, rebuild');
       bRebuild := true;
       BufferName := sFile + '~';
       Source := TFileStreamUTF8.Create( sFile, fmOpenRead ); // Set read-only and open old file, and create new
       Destination := TFileStreamUTF8.Create( BufferName, fmCreate );
       Source.Read( oldHeader, sizeof( oldHeader ) );
       oldHeader.MetaDataBlockHeader[ 1 ] := (oldHeader.MetaDataBlockHeader[ 1 ] and $7f ); //just in case no metadata existed
       Destination.Write( oldHeader, Sizeof( oldHeader ) );
       Destination.CopyFrom( MetaBlocks, 0 );
    end
    else
    begin
      // ShowMessage('Room, no rebuild, should not happen with CD Cover');
       bRebuild := false;
       Source := nil;
       Destination := TFileStreamUTF8.Create( sFile, fmOpenWrite); // Set write-access and open file
       if bRearange then begin
          Destination.Seek( SizeOf( FHeader ), soFromBeginning );
          Destination.CopyFrom( MetaBlocks, 0 );
       end else begin
          Destination.Seek( FVCOffset - 4, soFromBeginning );
       end;
    end;

    // finally write vorbis block
    temp:=HexStr(TmpSize+8+length(FVendor2),8);   // Size without Picture
    HexTemp[1]:=chr(Hex2Dec(copy(temp,1,2)));HexTemp[2]:=chr(Hex2Dec(copy(temp,3,2)));
    HexTemp[3]:=chr(Hex2Dec(copy(temp,5,2)));HexTemp[4]:=chr(Hex2Dec(copy(temp,7,2)));

    MetaDataBlockHeader[1] := META_VORBIS_COMMENT;
    MetaDataBlockHeader[2] := Byte(HexTemp[2]);
    MetaDataBlockHeader[3] := Byte(HexTemp[3]);
    MetaDataBlockHeader[4] := Byte(HexTemp[4]);

  (*  MetaDataBlockHeader[1] := META_VORBIS_COMMENT;
    MetaDataBlockHeader[2] := Byte(( VorbisBlock.Size shr 16 ) and 255 );
    MetaDataBlockHeader[3] := Byte(( VorbisBlock.Size shr 8 ) and 255 );
    MetaDataBlockHeader[4] := Byte( VorbisBlock.Size and 255 );     *)

    Destination.Write( MetaDataBlockHeader[ 1 ], SizeOf( MetaDataBlockHeader ) );
    Destination.CopyFrom( VorbisBlock, VorbisBlock.Size );

    // and add padding
    if FPaddingLast or bRearange then begin
       MetaDataBlockHeader[1] := META_PADDING or $80;
    end else begin
       MetaDataBlockHeader[1] := META_PADDING;
    end;

    if bRebuild or savecdcover then
    begin
       //ShowMessage('Rebuild');
       if not savecdcover then iNewPadding := 2048
                          else iNewPadding :=0; // why not...
       //ShowMessage('iNewPadding='+inttostr(iNewPadding));
    end
                              else
    begin
                  //ShowMessage('Not Rebuild');
       if FTagSize > VorbisBlock.Size then begin // tag got smaller increase padding
          iNewPadding := (FPadding + FTagSize - VorbisBlock.Size) + iExtraPadding;
       end else begin // tag got bigger shrink padding
          iNewPadding := (FPadding - VorbisBlock.Size + FTagSize ) + iExtraPadding;
       end;
    end;
    MetaDataBlockHeader[2] := Byte(( iNewPadding shr 16 ) and 255 );
    MetaDataBlockHeader[3] := Byte(( iNewPadding shr 8 ) and 255 );
    MetaDataBlockHeader[4] := Byte( iNewPadding and 255 );
    Destination.Write(MetaDataBlockHeader[ 1 ], 4);
    if ((FPadding <> iNewPadding) or bRearange) and not savecdcover then
    begin // fill the block with zeros
       sTmp := DupeString( #0, iNewPadding );
       Destination.Write( sTmp[1], iNewPadding );
    end;

    // finish
    if bRebuild or SaveCDCover then
    begin // time to put back the audio data...
       Source.Seek( FAudioOffset, soFromBeginning );
       Destination.CopyFrom( Source, Source.Size - FAudioOffset );
       Source.Free;
       Destination.Free;
       if ( DeleteFile( sFile ) ) and ( RenameFile( BufferName, sFile ) ) then begin //Replace old file and delete temporary file
          result := true
       end else begin
          raise Exception.Create('');
       end;
    end
    else
    begin
       result := true;
       Destination.Free;
    end;

    // post save tasks
    if bTAG_PreserveDate then {Wide}FileSetDate( sFile, iFileAge );
    if bRearange then FreeAndNil( MetaBlocks );

  except
    // Access error
    if FileExists( BufferName ) then DeleteFile( BufferName );
  end;
end;

(* -------------------------------------------------------------------------- *)

function TFLACfile.DecodeUTF8(const Source: string): String;
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

(*
function TFLACfile.EncodeUTF8(const Source: String): string;
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
*)
(* -------------------------------------------------------------------------- *)

end.
