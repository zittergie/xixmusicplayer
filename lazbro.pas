(*

Title:    Lazbro.pas v0.4
Author:   Derek John Evans (derek.john.evans@hotmail.com)
Website:  http://www.wascal.net/

Copyright (C) 2013-2014 Derek John Evans
http://www.wascal.net/

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated 
documentation files (the "Software"), to deal in the Software without restriction, including without 
limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies 
of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following 
conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial 
portions of the Software. 

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT 
LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN 
NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, 
WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE 
OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

*)

unit Lazbro;

interface

uses
  Base64, Classes, ClipBrd, Controls, DOM, DOM_HTML, ExtCtrls, FileUtil, Forms, fpHttpClient, LazFileUtils,
  Graphics, HttpDefs, LCLIntf, LCLType, Math, Menus, Process, SAX_HTML, StdCtrls, StrUtils, SysUtils, Types, TypInfo, UriParser, Dialogs;

type

  ELazbro = class(Exception)

  end;

  TLazbroText = class(TControl)
  strict private
    FSelected: Boolean;
  strict private
    function GetCanvas: TCanvas;
  protected
    procedure Paint;
    procedure RealSetText(const AText: TCaption); override;
    procedure SetSelected(const ASelected: Boolean);
  public
    constructor Create(AOwner: TComponent); override;
    property Selected: Boolean read FSelected write SetSelected;
  published
    property Font;
  end;

  TLazbroTextWord = class(TLazbroText)

  end;

  TLazbroTextSpace = class(TLazbroText)

  end;

  TLazbroTextEnding = class(TLazbroText)

  end;

  TLazbroLayout = class(TPanel)
  strict private
    FArraysCreated: Boolean;
    FPoint: TPoint;
    FPoints: array of TPoint;
    FIndexLeft, FIndexRight, FIndexFlow: Integer;
    FControlsLeft, FControlsRight, FControlsFlow: array of TControl;
  strict private
    procedure CreateCacheArrays;
    procedure LayoutAlign(const ALow, AHigh, AMarginRight: Integer);
    procedure LayoutFlow(const AMarginLeft, AMarginRight, AMarginBottom: Integer);
    procedure LayoutLeftRight(const AMarginLeft, AMarginRight, AMarginBottom: Integer);
    procedure LayoutControls(const AControlIndex: Integer);
  protected
    procedure Paint; override;
  public
    constructor Create(AOwner: TComponent); override;
  public
    procedure LayoutAll(const AControlIndex: Integer);
    function IsPreformated: Boolean;
  end;

  TLazbro = class;

  TLazbroEvent = procedure(const ALazbro: TLazbro) of object;

  TLazbro = class(TScrollingWinControl)
  strict private
    FHTTPClient: TFPHTTPClient;
    FHistory: TStrings;
    FHistoryIndex: Integer;
    FContentTypes: TStrings;
    FBaseUrl, FDelayedUrl: String;
    FBodyControl: TLazbroLayout;
    FButtons: array[TMouseButton] of Boolean;
    FControls: TComponent;
    FDocument: THTMLDocument;
    FMouseDownPoint: TPoint;
    FOnStatusChange, FOnUrlChange, FOnComplete: TLazbroEvent;
    FSelectLow, FSelectHigh: Integer;
    FShowBorders: Boolean;
    FStatusText: TEdit;
    FTimer: TTimer;
  protected
    function CreateBevel(const ANode: TDOMNode; const AParent: TWinControl; const AShape: TBevelShape): TBevel; virtual;
    function CreateComboBox(const ANode: TDOMNode; const AParent: TWinControl): TComboBox; virtual;
    function CreateControl(const ANode: TDOMNode; const AParent: TWinControl): TControl; virtual;
    function CreateControlClass(const AClass: TControlClass; const ANode: TDOMNode; const AParent: TWinControl): TControl; virtual;
    function CreateDiv(const ANode: TDOMNode; const AParent: TWinControl): TControl; virtual;
    function CreateFlow(const ANode: TDOMNode; const AParent: TWinControl): TLazbroLayout; virtual;
    function CreateIFrame(const ANode: TDOMNode; const AParent: TWinControl): TLazbro; virtual;
    function CreateImage(const ANode: TDOMNode; const AParent: TWinControl): TImage; virtual;
    function CreateInput(const ANode: TDOMNode; const AParent: TWinControl): TControl; virtual;
    function CreateListBox(const ANode: TDOMNode; const AParent: TWinControl): TListBox; virtual;
    function CreateMenuItem(const ACaption: String; const AShortCut: TShortCut): TMenuItem;
    function CreateSelect(const ANode: TDOMNode; const AParent: TWinControl): TControl; virtual;
    function CreateTextArea(const ANode: TDOMNode; const AParent: TWinControl): TMemo; virtual;
  protected
    procedure CreateControls(const AList: TDOMNodeList; const AParent: TWinControl); virtual;
    procedure CreateText(const ANode: TDOMNode; const AParent: TWinControl); virtual;
  protected
    procedure DoOnClick(ASender: TObject); virtual;
    procedure DoOnEnter(ASender: TObject); virtual;
    procedure DoOnExit(ASender: TObject); virtual;
    procedure DoOnPaint(ASender: TObject); virtual;
    procedure DoOnResize; override;
    procedure DoOnTimer(ASender: TObject); virtual;
    procedure DoOnDocumentComplete(const ADocument: TLazbro); virtual;
  protected
    procedure DoOnMouseDown(ASender: TObject; AButton: TMouseButton; AShift: TShiftState; AX, AY: Integer); virtual;
    procedure DoOnMouseMove(ASender: TObject; AShift: TShiftState; AX, AY: Integer); virtual;
    procedure DoOnMouseUp(ASender: TObject; AButton: TMouseButton; AShift: TShiftState; AX, AY: Integer); virtual;
    procedure DoOnMouseWheel(ASender: TObject; AShift: TShiftState; AWheelDelta: Integer; AMousePos: TPoint;
      var AHandled: Boolean); virtual;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  protected
    procedure SetStatusText(const AString: String); virtual;
    function GetTopFrame: TLazbro;
    function GetParentFrame: TLazbro;
    function GetControlAt(const APoint: TPoint): TControl;
    function GetSelectedText: String; virtual;
    function GetSelectedCount: Integer; virtual;
    function GetStatusText: String; virtual;
    function FindWordBeforePoint(const APoint: TPoint): TLazbroTextWord;
    function FindWordAfterPoint(const APoint: TPoint): TLazbroTextWord;
  protected
    function CreateStreamFromUrl(const AUrl: String; out AContentType: String): TStream; virtual;
  public
    function GetContentTypeFromExt(const AExt: String): String; virtual;
    function GetContentTypeFromUrl(const AUrl: String): String; virtual;
  public
    procedure LoadPicture(const APicture: TPicture; const AUrl: String); virtual;
  public
    procedure SetBaseUrl(const AUrl: String); virtual;
    function ResolveUrl(const AUrl: String): String; virtual;
  public
    procedure ClearPage; virtual;
    procedure ClearSelection; virtual;
    procedure ClearHistory; virtual;
  public
    procedure SetSelection(ALow, AHigh: Integer); virtual;
    procedure SelectAll; virtual;
    procedure Refresh;
    procedure GoBack;
    procedure GoForward;
  public
    procedure LoadFromStream(const AStream: TStream; const ABaseUrl: String); virtual;
    procedure LoadFromString(const AString: String; const ABaseUrl: String); virtual;
    procedure LoadFromException(const AException: Exception; const ABaseUrl: String); virtual;
    procedure LoadFromFile(const AFilename: TFilename); virtual;
    procedure LoadFromUrl(const AUrl, ABaseUrl: String); virtual;
    procedure LoadFromUrl(const AUrl: String); virtual;
    procedure LoadFromUrlDelayed(const AUrl: String; const AInterval: Integer = 100); virtual;
  public
    function SubmitForm: String;
  public
    property ShowBorders: Boolean read FShowBorders write FShowBorders;
    property BaseUrl: String read FBaseUrl write SetBaseUrl;
    property Document: THTMLDocument read FDocument;
    property ContentTypes: TStrings read FContentTypes;
    property StatusText: String read GetStatusText;
    property SelectedText: String read GetSelectedText;
  public
    property OnStatusChange: TLazbroEvent read FOnStatusChange write FOnStatusChange;
    property OnUrlChange: TLazbroEvent read FOnUrlChange write FOnUrlChange;
    property OnComplete: TLazbroEvent read FOnComplete write FOnComplete;
  end;

implementation


const

  // Supported HTML Tags (must be lowercase)

  tnA = 'a';
  tnB = 'b';
  tnBODY = 'body';
  tnBR = 'br';
  tnCENTER = 'center';
  tnCODE = 'code';
  tnDIV = 'div';
  tnFONT = 'font';
  tnFORM = 'form';
  tnH1 = 'h1';
  tnH2 = 'h2';
  tnH3 = 'h3';
  tnH4 = 'h4';
  tnHR = 'hr';
  tnI = 'i';
  tnIFRAME = 'iframe';
  tnIMG = 'img';
  tnINPUT = 'input';
  tnLI = 'li';
  tnP = 'p';
  tnPRE = 'pre';
  tnSELECT = 'select';
  tnSPAN = 'span';
  tnSTRONG = 'strong';
  tnSTYLE = 'style';
  tnTABLE = 'table';
  tnTBODY = 'tbody';
  tnTD = 'td';
  tnTEXTAREA = 'textarea';
  tnTH = 'th';
  tnTR = 'tr';
  tnUL = 'ul';

  // Standard Attributes (must be lowercase)

  anStandardAlign = 'align';
  anStandardBgColor = 'bgcolor';
  anStandardClass = 'class';
  anStandardColor = 'color';
  anStandardDisabled = 'disabled';
  anStandardFace = 'face';
  anStandardHeight = 'height';
  anStandardHref = 'href';
  anStandardMultiple = 'multiple';
  anStandardName = 'name';
  anStandardSelected = 'selected';
  anStandardSize = 'size';
  anStandardSrc = 'src';
  anStandardStyle = 'style';
  anStandardTarget = 'target';
  anStandardText = 'text';
  anStandardTitle = 'title';
  anStandardType = 'type';
  anStandardValue = 'value';
  anStandardWidth = 'width';

  // Property Attributes (must be prefixed with '_' and match published properties)

  an_Alignment = '_Alignment';
  an_AutoSize = '_AutoSize';
  an_BevelInner = '_BevelInner';
  an_BevelOuter = '_BevelOuter';
  an_BevelWidth = '_BevelWidth';
  an_BorderSpacing_Bottom = '_BorderSpacing.Bottom';
  an_BorderSpacing_Left = '_BorderSpacing.Left';
  an_BorderSpacing_Right = '_BorderSpacing.Right';
  an_BorderSpacing_Top = '_BorderSpacing.Top';
  an_BorderStyle = '_BorderStyle';
  an_BorderWidth = '_BorderWidth';
  an_Caption = '_Caption';
  an_Color = '_Color';
  an_Cursor = '_Cursor';
  an_Disabled = '_Disabled';
  an_HelpContext = '_HelpContext';
  an_Font_Bold = '_Font.Bold';
  an_Font_Color = '_Font.Color';
  an_Font_Italic = '_Font.Italic';
  an_Font_Name = '_Font.Name';
  an_Font_Pitch = '_Font.Pitch';
  an_Font_Size = '_Font.Size';
  an_Font_StrikeThrough = '_Font.Strikethrough';
  an_Font_Underline = '_Font.Underline';
  an_Height = '_Height';
  an_LeftRightSpacing = '_ChildSizing.LeftRightSpacing';
  an_TopBottomSpacing = '_ChildSizing.TopBottomSpacing';
  an_Visible = '_Visible';
  an_Width = '_Width';


  // Style Attributes (must be lowercase)

  snBackgroundColor = 'background-color';
  snBorderBottom = 'border-bottom';
  snBorderLeft = 'border-left';
  snBorderRight = 'border-right';
  snBorderTop = 'border-top';
  snColor = 'color';
  snFloat = 'float';
  snFontFamily = 'font-family';
  snHeight = 'height';
  snMargin = 'margin';
  snPadding = 'padding';
  snTextAlign = 'text-align';
  snWidth = 'width';

  // Attribute Values (must be lowercase)

  avBlock = 'block';
  avCenter = 'center';
  avCentre = 'centre';
  avCheckBox = 'checkbox';
  avEdit = 'edit';
  avHidden = 'hidden';
  avLeft = 'left';
  avPassword = 'password';
  avRight = 'right';
  avSubmit = 'submit';
  av_Blank = '_blank';

  protocolData = 'data';
  protocolAbout = 'about';
  protocolFile = 'file';
  protocolHttp = 'http';

  ctText = 'text/';
  ctTextHtml = ctText + 'html';
  ctTextPlain = ctText + 'plain';
  ctImage = 'image/';
  ctImageJpeg = ctImage + 'jpeg';
  ctImagePng = ctImage + 'png';
  ctImageGif = ctImage + 'gif';

  hcAlignFlow = 0;
  hcAlignLeft = 1;
  hcAlignRight = 2;
  hcAlignBlock = 3;

  // Default Values

  GDefaultFontName = 'Times New Roman';
  GDefaultFontSize = 12;

  // Short Cuts

  scRefresh = VK_F5;
  scSelectAll = scCtrl or VK_A;
  scCopyToClipboard = scCtrl or VK_C;
  scGoBack = scALT or VK_LEFT;
  scGoForward = scALT or VK_RIGHT;

  // Cgi Constants

  CgiQueryString = 'QUERY_STRING';
  CgiTimeOut = 60;
  CgiTimeSleep = 100;

resourcestring

  rsCopy = 'Copy';
  rsDone = 'Done';
  rsGoBack = 'Go Back';
  rsGoForward = 'Go Forward';
  rsHtmlException3 = '<HTML><HEAD><TITLE>%s</TITLE></HEAD><BODY><H1>Lazbro Exception %s:</H1><H3>%s</H3></BODY></HTML>';
  rsHtmlImage2 = '<HTML><HEAD><TITLE>%s</TITLE></HEAD><BODY bgcolor=#333333><CENTER><IMG src="%s"></CENTER></BODY></HTML>';
  rsLoading = 'Loading';
  rsRefresh = 'Refresh';
  rsSelectAll = 'Select All';
  rsUnableToResolveURL = 'Unable to Resolve URL.';
  rsUnableToResolveFilename = 'Unable to Resolve Filename.';
  rsCgiTimeOut = 'CGI Application Timeout.';
  rsUnknownProtocol = 'Unknown Protocol.';
  rsCGIContentTypeMissing = 'CGI ContentType Missing.';

  rsSrcBroken =
    'data:image/gif;base64,R0lGODlhIQAiAPcAAJkQZ/9rzYplzrqZ/3Zmm9vN/zplZgD9myWaZfT/zPHPmcCcZf///83Nzby8vKysrJqamomJiXh4eFRUVAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAACH5BAEAAAMALAAAAAAhACIAAAj+ABkIHEiwoMGDBiUoXMiwocOFCBlIiEhxoEKEEytSlNAgY8GMDkKKHEmS5MSOCQWWhLCw5MiMKAmCfCkBAYIBFCi4dOAxpsCZISNMTGBAggGdLj0y8AmUJ4IFCmoaOJq0IM+fKkVKjfDgwFSkJHOKFYuVwcsBRqceBUtygtu3FMqOhEDBAIKvFCZE2Bmhb9+4ErOKzLk25wQJO0UKBNw0qNi3exM7WCy3pFDIkkMy0Ft5pdC+DyXoFOg2glzEOyFcLcBaQAEBeTf3fXCabUkJrF+/JjCQs0WVE22/bP1aAOnSMoEv3onbtfHjs5ObnRiAgXCerY/rpf1ReYDqwj1wQuZ6ECT1AACsay5YmnxBxt7Rg9cOmbtB+NMZyJe/Wa/fB/bddxoDABRIkG8UTWbdaehN0B9kGimInwNjyTZbgAetN6EDb8mmkVmKLRgYiAoiVxFJlI3Ym38YfiiiUqW16KKIY+XlHkU15jjjjgMFBAA7';

type

  THackControl = class(TControl)
  public
    property OnMouseWheel;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
  end;

  THackComponent = class(TControl)
  public
    procedure ForceName(const AName: String);
  end;

constructor TLazbroText.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Cursor := crIBeam;
end;

function TLazbroText.GetCanvas: TCanvas;
begin
  Result := TPanel(Parent).Canvas;
  Result.Font.Size := Font.Size;
  Result.Font.Name := Font.Name;
  Result.Font.Style := Font.Style;
  if FSelected then
  begin
    Result.Brush.Color := clHighlight;
    Result.Font.Color := clHighlightText;
  end else begin
    Result.Brush.Style := bsClear;
    Result.Font.Color := Font.Color;
  end;
end;

procedure TLazbroText.Paint;
begin
  if Visible then
  begin
    with GetCanvas do
    begin
      FillRect(BoundsRect);
      TextRect(BoundsRect, Left, Top, Caption);
    end;
  end;
end;

procedure TLazbroText.RealSetText(const AText: TCaption);
begin
  with GetCanvas.TextExtent(AText) do
  begin
    SetBounds(0, 0, cx, cy);
  end;
  inherited RealSetText(AText);
end;

procedure TLazbroText.SetSelected(const ASelected: Boolean);
begin
  if FSelected <> ASelected then
  begin
    FSelected := ASelected;
    Invalidate;
  end;
end;


function HtmlToAlignment(const AString: String): TAlignment;
begin
  case LowerCase(Trim(AString)) of
    avRight: begin
      Result := taRightJustify;
    end;
    avCenter, avCentre: begin
      Result := taCenter;
    end else
    begin
      Result := taLeftJustify;
    end;
  end;
end;

function HtmlToHelpContext(const AString: String): THelpContext;
begin
  case LowerCase(AString) of
    avLeft: begin
      Result := hcAlignLeft;
    end;
    avRight: begin
      Result := hcAlignRight;
    end else
    begin
      Result := hcAlignFlow;
    end;
  end;
end;

function HtmlToColor(AString: String; out AColor: TColor): Boolean;
begin
  AString := Trim(AString);
  Result := AnsiStartsStr('#', AString);
  if Result then
  begin
    AColor := StrToIntDef('$' + Copy(AString, 2, MaxInt), 0);
    AColor := RGBToColor(Blue(AColor), Green(AColor), Red(AColor));
  end else begin
    Result := IdentToColor(AString, AColor);
  end;
end;

function ColorToHtml(const AColor: TColor): String;
begin
  Result := '#' + IntToHex(RGBToColor(Blue(AColor), Green(AColor), Red(AColor)), 6);
end;

function NodeIsProperty(const ANode: TDOMNode; out APropName: String): Boolean;
begin
  Result := AnsiStartsStr('_', ANode.NodeName);
  if Result then
  begin
    APropName := Copy(ANode.NodeName, 2, MaxInt);
  end;
end;

function NodeGetAttribute(const ANode: TDOMNode; const AName: String; out AValue: String): Boolean;
var
  LIdx: Integer;
begin
  Result := ANode.HasAttributes;
  if Result then
  begin
    for LIdx := 0 to ANode.Attributes.Length - 1 do
    begin
      if SameText(AName, ANode.Attributes.Item[LIdx].NodeName) then
      begin
        AValue := ANode.Attributes.Item[LIdx].NodeValue;
        Exit(True);
      end;
    end;
    Result := False;
  end;
end;

function NodeGetStringDef(const ANode: TDOMNode; const AName: String; const ADefault: String): String;
begin
  if not NodeGetAttribute(ANode, AName, Result) then
  begin
    Result := ADefault;
  end;
end;

function NodeGetValueDef(const ANode: TDOMNode; const ADefault: String): String;
  // NOTE: There is a small bug in HtmlElements.UnescapeHTML(). So we need to place a bug free copy here for now.
  function UnescapeHTML(const S: String): String;
  begin
    Result := StringsReplace(S, ['&amp;', '&lt;', '&gt;', '&quot;', '&apos;', '&#39;'], ['&', '<', '>', '"', #39, #39], [rfReplaceAll]);
  end;

begin
  if NodeGetAttribute(ANode, anStandardValue, Result) then
  begin
    Result := UnescapeHTML(Result);
  end else begin
    Result := ADefault;
  end;
end;

function NodeHasAttribute(const ANode: TDOMNode; const AName: String): Boolean;
var
  LString: String;
begin
  Result := NodeGetAttribute(ANode, AName, LString);
end;

function NodeGetBooleanDef(const ANode: TDOMNode; const AName: String; const ADefault: Boolean): Boolean;
var
  LString: String;
begin
  if NodeGetAttribute(ANode, AName, LString) then
  begin
    Result := StrToBoolDef(LString, ADefault);
  end else begin
    Result := ADefault;
  end;
end;

function NodeGetSize(const ANode: TDOMNode; const AName: String; const AParentWidth, ADefault: Integer): Integer;
var
  LString: String;
begin
  if NodeGetAttribute(ANode, AName, LString) then
  begin
    LString := Trim(LString);
    if AnsiEndsStr('%', LString) then
    begin
      Result := AParentWidth * StrToIntDef(Copy(LString, 1, Length(LString) - 1), ADefault) div 100;
    end else if AnsiEndsStr('px', LString) then
    begin
      Result := StrToIntDef(Copy(LString, 1, Length(LString) - 2), ADefault);
    end else begin
      Result := StrToIntDef(LString, ADefault);
    end;
  end else begin
    Result := ADefault;
  end;
end;

function NodeGetIntegerDef(const ANode: TDOMNode; const AName: String; const ADefault: Integer): Integer;
var
  LString: String;
begin
  if NodeGetAttribute(ANode, AName, LString) then
  begin
    LString := Trim(LString);
    if AnsiEndsStr('px', LString) then
    begin
      LString := Trim(Copy(LString, 1, Length(LString) - 2));
    end;
    if AnsiStartsStr('+', LString) or AnsiStartsStr('-', LString) then
    begin
      Result := StrToIntDef(LString, 0) + ADefault;
    end else begin
      Result := StrToIntDef(LString, ADefault);
    end;
  end else begin
    Result := ADefault;
  end;
end;

function NodeGetColorDef(const ANode: TDOMNode; const AName: String; const ADefault: TColor): TColor;
begin
  if not HtmlToColor(NodeGetStringDef(ANode, AName, EmptyStr), Result) then
  begin
    Result := ADefault;
  end;
end;

procedure NodeSetDefaultString(const ANode: TDOMNode; const AName, AValue: String);
begin
  if (ANode is TDOMElement) and not NodeHasAttribute(ANode, AName) then
  begin
    TDOMElement(ANode).SetAttribute(AName, AValue);
  end;
end;

procedure NodeSetDefaultInteger(const ANode: TDOMNode; const AName: String; const AValue: Integer);
begin
  NodeSetDefaultString(ANode, AName, IntToStr(AValue));
end;

procedure NodeSetDefaultColor(const ANode: TDOMNode; const AName: String; const AValue: TColor);
begin
  NodeSetDefaultString(ANode, AName, ColorToHtml(AValue));
end;

function NodeSetDefaultStringFromAttr(const ANode: TDOMNode; const ADstName, ASrcName: String): Boolean;
var
  LString: String;
begin
  Result := NodeGetAttribute(ANode, ASrcName, LString);
  if Result then
  begin
    NodeSetDefaultString(ANode, ADstName, LString);
  end;
end;

function NodeFindRootByTagName(const ANode: TDOMNode; const ATagName: String): TDOMNode;
begin
  Result := ANode;
  repeat
    if (Result is TDOMElement) and SameText(TDOMElement(Result).TagName, ATagName) then
    begin
      Exit;
    end;
    Result := Result.ParentNode;
  until not Assigned(Result);
  Abort;
end;

function CreateStringsFromStyle(const AStyle: String): TStrings;
begin
  Result := TStringList.Create;
  try
    Result.NameValueSeparator := ':';
    Result.StrictDelimiter := True;
    Result.Delimiter := ';';
    Result.DelimitedText := AStyle;
  except
    FreeAndNil(Result);
    raise;
  end;
end;

function CreateStringsFromStyleSheet(const AStyleSheet: String): TStrings;
begin
  Result := TStringList.Create;
  try
    Result.NameValueSeparator := '{';
    Result.StrictDelimiter := True;
    Result.Delimiter := '}';
    Result.DelimitedText := AStyleSheet;
  except
    FreeAndNil(Result);
    raise;
  end;
end;

function CreateStringsFromStyleSheet(const AStyleSheet, AIdent: String): TStrings;
var
  LIdx, LPos, LSub: Integer;
  LString: String;
begin
  with CreateStringsFromStyleSheet(AStyleSheet) do
  begin
    try
      for LIdx := 0 to Count - 1 do
      begin
        LPos := Pos(NameValueSeparator, Strings[LIdx]);
        if LPos > 0 then
        begin
          LString := Copy(Strings[LIdx], 1, LPos - 1);
          LSub := 1;
          while LSub <= Length(LString) do
          begin
            if SameText(AIdent, ExtractSubstr(LString, LSub, WordDelimiters - ['.'])) then
            begin
              Exit(CreateStringsFromStyle(Copy(Strings[LIdx], LPos + 1, MaxInt)));
            end;
          end;
        end;
      end;
    finally
      Free;
    end;
  end;
  Result := nil;
end;

function StringsGetValue(const AStrings: TStrings; const AName: String; out AValue: String): Boolean;
var
  LIdx, LPos: Integer;
begin
  for LIdx := AStrings.Count - 1 downto 0 do
  begin
    LPos := Pos(AStrings.NameValueSeparator, AStrings[LIdx]);
    if LPos > 0 then
    begin
      if SameText(AName, Trim(Copy(AStrings[LIdx], 1, LPos - 1))) then
      begin
        AValue := Trim(Copy(AStrings[LIdx], LPos + 1, MaxInt));
        Exit(True);
      end;
    end;
  end;
  Result := False;
end;

function NodeSetDefaultStringFromStrings(const ANode: TDOMNode; const AAttrName: String; const AStrings: TStrings;
  const AStringsName: String): Boolean;
var
  LString: String;
begin
  Result := StringsGetValue(AStrings, AStringsName, LString);
  if Result then
  begin
    NodeSetDefaultString(ANode, AAttrName, LString);
  end;
end;

procedure NodeApplyStyles(const ANode: TDOMNode; const AStyles: TStrings);
var
  LString: String;
begin
  if StringsGetValue(AStyles, snTextAlign, LString) then
  begin
    NodeSetDefaultInteger(ANode, an_Alignment, Ord(HtmlToAlignment(LString)));
  end;
  if StringsGetValue(AStyles, snFloat, LString) then
  begin
    NodeSetDefaultInteger(ANode, an_HelpContext, Ord(HtmlToHelpContext(LString)));
  end;
  NodeSetDefaultStringFromStrings(ANode, an_BorderStyle, AStyles, an_BorderStyle);
  NodeSetDefaultStringFromStrings(ANode, an_BorderSpacing_Bottom, AStyles, snBorderBottom);
  NodeSetDefaultStringFromStrings(ANode, an_BorderSpacing_Bottom, AStyles, snMargin);
  NodeSetDefaultStringFromStrings(ANode, an_BorderSpacing_Left, AStyles, snBorderLeft);
  NodeSetDefaultStringFromStrings(ANode, an_BorderSpacing_Left, AStyles, snMargin);
  NodeSetDefaultStringFromStrings(ANode, an_BorderSpacing_Right, AStyles, snBorderRight);
  NodeSetDefaultStringFromStrings(ANode, an_BorderSpacing_Right, AStyles, snMargin);
  NodeSetDefaultStringFromStrings(ANode, an_BorderSpacing_Top, AStyles, snBorderTop);
  NodeSetDefaultStringFromStrings(ANode, an_BorderSpacing_Top, AStyles, snMargin);
  NodeSetDefaultStringFromStrings(ANode, an_Color, AStyles, snBackgroundColor);
  NodeSetDefaultStringFromStrings(ANode, an_Font_Color, AStyles, snColor);
  NodeSetDefaultStringFromStrings(ANode, an_Font_Name, AStyles, snFontFamily);
  NodeSetDefaultStringFromStrings(ANode, an_Height, AStyles, snHeight);
  NodeSetDefaultStringFromStrings(ANode, an_LeftRightSpacing, AStyles, snPadding);
  NodeSetDefaultStringFromStrings(ANode, an_TopBottomSpacing, AStyles, snPadding);
  NodeSetDefaultStringFromStrings(ANode, an_Width, AStyles, snWidth);
end;

procedure NodeApplyStyleSheets(const ANode: TDOMNode);
var
  LIdx: Integer;
  LStyles: TStrings;
  LString: String;
  LParent, LChildNode: TDOMNode;
begin
  if NodeGetAttribute(ANode, anStandardClass, LString) then
  begin
    LParent := ANode.ParentNode;
    while Assigned(LParent) do
    begin
      for LIdx := 0 to LParent.ChildNodes.Count - 1 do
      begin
        LChildNode := LParent.ChildNodes[LIdx];
        if (LChildNode is TDOMElement) and SameText(TDOMElement(LChildNode).TagName, tnSTYLE) then
        begin
          LStyles := CreateStringsFromStyleSheet(TDOMElement(LChildNode).TextContent, '.' + LString);
          if Assigned(LStyles) then
          begin
            try
              NodeApplyStyles(ANode, LStyles);
            finally
              FreeAndNil(LStyles);
            end;
          end;
        end;
      end;
      LParent := LParent.ParentNode;
    end;
  end;
end;

procedure NodeStandardize(const ANode: TDOMNode);
var
  LStyles: TStrings;
  LString: String;
begin
  NodeApplyStyleSheets(ANode);
  NodeSetDefaultStringFromAttr(ANode, an_Font_Color, anStandardText);
  NodeSetDefaultStringFromAttr(ANode, an_Color, anStandardBgColor);
  NodeSetDefaultStringFromAttr(ANode, an_Disabled, anStandardDisabled);
  NodeSetDefaultStringFromAttr(ANode, an_Height, anStandardHeight);
  NodeSetDefaultStringFromAttr(ANode, an_Width, anStandardWidth);
  if NodeGetAttribute(ANode, anStandardStyle, LString) then
  begin
    LStyles := CreateStringsFromStyle(LString);
    try
      NodeApplyStyles(ANode, LStyles);
    finally
      FreeAndNil(LStyles);
    end;
  end;
  if ANode is TDOMElement then
  begin
    case LowerCase(TDOMElement(ANode).TagName) of
      tnFORM, tnTR, tnDIV, tnCODE: begin
        NodeSetDefaultString(ANode, an_Width, '100%');
      end;
      tnIMG: begin
        NodeSetDefaultInteger(ANode, an_HelpContext, HtmlToHelpContext(NodeGetStringDef(ANode, anStandardAlign, EmptyStr)));
      end;
      tnPRE: begin
        NodeSetDefaultString(ANode, an_Width, '100%');
        NodeSetDefaultString(ANode, an_Font_Name, 'Courier New');
        NodeSetDefaultInteger(ANode, an_Font_Pitch, 2);
        NodeSetDefaultInteger(ANode, an_Font_Size, 10);
      end;
      tnBR: begin
        NodeSetDefaultString(ANode, an_Width, '100%');
        NodeSetDefaultString(ANode, an_Height, '21');
      end;
      tnHR: begin
        NodeSetDefaultString(ANode, an_Width, '100%');
        NodeSetDefaultString(ANode, an_Height, '10');
      end;
      tnCENTER: begin
        NodeSetDefaultString(ANode, an_Width, '100%');
        NodeSetDefaultInteger(ANode, an_Alignment, Ord(taCenter));
      end;
      tnUL: begin
        NodeSetDefaultString(ANode, an_Width, '100%');
        NodeSetDefaultInteger(ANode, an_LeftRightSpacing, 24);
      end;
      tnLI: begin
        NodeSetDefaultString(ANode, an_Width, '100%');
      end;
      tnBODY: begin
        NodeSetDefaultString(ANode, an_Width, '100%');
        NodeSetDefaultString(ANode, an_Font_Name, GDefaultFontName);
        NodeSetDefaultInteger(ANode, an_Font_Size, GDefaultFontSize);
        NodeSetDefaultInteger(ANode, an_LeftRightSpacing, 16);
        NodeSetDefaultInteger(ANode, an_TopBottomSpacing, 16);
        NodeSetDefaultColor(ANode, an_Color, clWhite);
      end;
      tnA: begin
        NodeSetDefaultColor(ANode, an_Font_Color, clBlue);
        NodeSetDefaultInteger(ANode, an_Font_Underline, 1);
        NodeSetDefaultInteger(ANode, an_Cursor, Ord(crHandPoint));
      end;
      tnB: begin
        NodeSetDefaultInteger(ANode, an_Font_Bold, 1);
      end;
      tnSTRONG: begin
        NodeSetDefaultInteger(ANode, an_Font_Bold, 1);
      end;
      tnI: begin
        NodeSetDefaultInteger(ANode, an_Font_Italic, 1);
      end;
      tnP: begin
        NodeSetDefaultString(ANode, an_Width, '100%');
        NodeSetDefaultInteger(ANode, an_BorderSpacing_Top, 10);
        NodeSetDefaultInteger(ANode, an_BorderSpacing_Bottom, 10);
      end;
      tnH1: begin
        NodeSetDefaultString(ANode, an_Width, '100%');
        NodeSetDefaultInteger(ANode, an_Font_Bold, 1);
        NodeSetDefaultInteger(ANode, an_Font_Size, 24);
        NodeSetDefaultInteger(ANode, an_BorderSpacing_Top, 10);
        NodeSetDefaultInteger(ANode, an_BorderSpacing_Bottom, 10);
      end;
      tnH2: begin
        NodeSetDefaultString(ANode, an_Width, '100%');
        NodeSetDefaultInteger(ANode, an_Font_Bold, 1);
        NodeSetDefaultInteger(ANode, an_Font_Size, 18);
        NodeSetDefaultInteger(ANode, an_BorderSpacing_Top, 8);
        NodeSetDefaultInteger(ANode, an_BorderSpacing_Bottom, 8);
      end;
      tnH3: begin
        NodeSetDefaultString(ANode, an_Width, '100%');
        NodeSetDefaultInteger(ANode, an_Font_Bold, 1);
        NodeSetDefaultInteger(ANode, an_Font_Size, 14);
        NodeSetDefaultInteger(ANode, an_BorderSpacing_Top, 8);
        NodeSetDefaultInteger(ANode, an_BorderSpacing_Bottom, 8);
      end;
      tnTABLE: begin
        NodeSetDefaultString(ANode, an_Width, '100%');
        NodeSetDefaultInteger(ANode, an_HelpContext, hcAlignBlock);
      end;
      tnTH: begin
        NodeSetDefaultInteger(ANode, an_AutoSize, 1);
        NodeSetDefaultInteger(ANode, an_Font_Bold, 1);
        NodeSetDefaultInteger(ANode, an_LeftRightSpacing, 4);
        NodeSetDefaultInteger(ANode, an_TopBottomSpacing, 4);
      end;
      tnTD: begin
        NodeSetDefaultInteger(ANode, an_AutoSize, 1);
        NodeSetDefaultInteger(ANode, an_LeftRightSpacing, 4);
        NodeSetDefaultInteger(ANode, an_TopBottomSpacing, 4);
      end;
      tnFONT: begin
        NodeSetDefaultStringFromAttr(ANode, an_Font_Name, anStandardFace);
        NodeSetDefaultStringFromAttr(ANode, an_Font_Color, anStandardColor);
        NodeSetDefaultInteger(ANode, an_Font_Size, NodeGetIntegerDef(ANode, anStandardSize, 3) * 3);
      end;
      tnTEXTAREA: begin
        NodeSetDefaultColor(ANode, an_Color, clWhite);
      end;
      tnSELECT: begin
        NodeSetDefaultColor(ANode, an_Color, clWhite);
      end;
      tnIFRAME: begin
        NodeSetDefaultInteger(ANode, an_BorderStyle, 1);
      end;
      tnINPUT: begin
        case LowerCase(NodeGetStringDef(ANode, anStandardType, EmptyStr)) of
          avSubmit: begin
            NodeSetDefaultInteger(ANode, an_AutoSize, 1);
          end;
          avHidden: begin
            NodeSetDefaultInteger(ANode, an_Visible, 0);
          end;
          avCheckBox: begin
          end else
          begin
            NodeSetDefaultColor(ANode, an_Color, clWhite);
          end;
        end;
      end;
    end;
  end;
end;

procedure THackComponent.ForceName(const AName: String);
begin
  ChangeName(AName);
end;

function ControlGetNode(const AControl: TControl): TDOMNode;
begin
  Result := TObject(AControl.Tag) as TDOMNode;
end;

function ControlFindRootByTagName(const AControl: TControl; const ATagName: String): TDOMNode;
begin
  Result := NodeFindRootByTagName(ControlGetNode(AControl), ATagName);
end;

function ControlFindRootAnchor(const AControl: TControl): TDOMNode;
begin
  Result := ControlFindRootByTagName(AControl, tnA);
end;

function HttpNameValue(const AName, AValue: String): String;
begin
  Result := HttpEncode(AName) + '=' + HttpEncode(AValue) + '&';
end;

function ControlCreateQueryString(const AControl: TControl): String;
var
  LIdx: Integer;
begin
  Result := EmptyStr;
  if (AControl is TCustomEdit) or (AControl is TButton) or (AControl is TComboBox) then
  begin
    Result := HttpNameValue(AControl.Name, AControl.Caption);
  end else if AControl is TCheckBox then
  begin
    if (AControl as TCheckBox).Checked then
    begin
      Result := HttpNameValue(AControl.Name, AControl.Hint);
    end;
  end else if AControl is TListBox then
  begin
    Result := HttpNameValue(AControl.Name, TListBox(AControl).Items[TListBox(AControl).ItemIndex]);
  end;
  if AControl is TWinControl then
  begin
    for LIdx := 0 to TWinControl(AControl).ControlCount - 1 do
    begin
      Result += ControlCreateQueryString(TWinControl(AControl).Controls[LIdx]);
    end;
  end;
end;

procedure ObjectSetPropValue(AObject: TObject; AName, AValue: String);
var
  LColor: TColor;
  LPos: Integer;
begin
  repeat
    LPos := Pos('.', AName);
    if LPos = 0 then
    begin
      AName := Trim(AName);
      case PropType(AObject, AName) of
        tkInteger, tkInt64: begin
          AValue := Trim(AValue);
          if HtmlToColor(AValue, LColor) then
          begin
            SetInt64Prop(AObject, AName, LColor);
          end else if AnsiEndsStr('px', AValue) then
          begin
            SetInt64Prop(AObject, AName, StrToInt64(Copy(AValue, 1, Length(AValue) - 2)));
          end else begin
            SetInt64Prop(AObject, AName, StrToInt64(AValue));
          end;
        end;
        tkString, tkAString: begin
          SetStrProp(AObject, AName, AValue);
        end;
        tkBool, tkEnumeration: begin
          SetInt64Prop(AObject, AName, StrToInt64(Trim(AValue)));
        end;
      end;
    end else begin
      AObject := GetObjectProp(AObject, Trim(Copy(AName, 1, LPos - 1)));
      AName := Trim(Copy(AName, LPos + 1, MaxInt));
    end;
  until (LPos = 0) or not Assigned(AObject);
end;

procedure ObjectSetPropValues(const AObject: TObject; const ANode: TDOMNode; const AInclude: array of String);
var
  LIdx: Integer;
  LPropName: String;
begin
  if ANode is TDOMElement then
  begin
    for LIdx := 0 to ANode.Attributes.Length - 1 do
    begin
      if NodeIsProperty(ANode.Attributes.Item[LIdx], LPropName) and ((Length(AInclude) = 0) or
        AnsiMatchText(ANode.Attributes.Item[LIdx].NodeName, AInclude)) then
      begin
        try
          ObjectSetPropValue(AObject, LPropName, ANode.Attributes.Item[LIdx].NodeValue);
        except
        end;
      end;
    end;
  end;
end;

procedure ControlStyleInherited(const AControl: TControl; const ANode: TDOMNode);
begin
  if Assigned(ANode) then
  begin
    ControlStyleInherited(AControl, ANode.ParentNode);
    if ANode is TDOMElement then
    begin
      ObjectSetPropValues(AControl, ANode, [an_Color, an_Font_Color, an_Font_Name, an_Font_Size, an_Font_Pitch,
        an_Cursor]);
      AControl.Font.Bold := NodeGetBooleanDef(ANode, an_Font_Bold, AControl.Font.Bold);
      AControl.Font.Italic := NodeGetBooleanDef(ANode, an_Font_Italic, AControl.Font.Italic);
      AControl.Font.StrikeThrough := NodeGetBooleanDef(ANode, an_Font_StrikeThrough, AControl.Font.StrikeThrough);
      AControl.Font.Underline := NodeGetBooleanDef(ANode, an_Font_Underline, AControl.Font.Underline);
      AControl.Enabled := not NodeGetBooleanDef(ANode, an_Disabled, not AControl.Enabled);
    end;
  end;
end;

procedure ControlApplyAttributes(const AControl: TControl);
var
  LNode: TDOMNode;
begin
  LNode := ControlGetNode(AControl);
  THackComponent(AControl).ForceName(NodeGetStringDef(LNode, anStandardName, EmptyStr));
  try
    ObjectSetPropValues(AControl, LNode, []);
  except
  end;
  ControlStyleInherited(AControl, LNode);
end;

constructor TLazbroLayout.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  BevelOuter := bvNone;
  Alignment := taLeftJustify;
  Color := clWhite;
end;

function TLazbroLayout.IsPreformated: Boolean;
begin
  Result := Font.Pitch = fpFixed;
end;

procedure TLazbroLayout.LayoutAlign(const ALow, AHigh, AMarginRight: Integer);
var
  LIdx, LOffset: Integer;
begin
  if (Alignment <> taLeftJustify) and (ALow <= AHigh) then
  begin
    LOffset := AMarginRight - FPoints[AHigh].X - FControlsFlow[AHigh].Width;
    if Alignment = taCenter then
    begin
      LOffset := LOffset div 2;
    end;
    for LIdx := ALow to AHigh do
    begin
      FPoints[LIdx].X += LOffset;
    end;
  end;
end;

procedure TLazbroLayout.LayoutFlow(const AMarginLeft, AMarginRight, AMarginBottom: Integer);
var
  LNextLine, LIndexFirst: Integer;
  LControl: TControl;
begin
  if FIndexFlow < Length(FControlsFlow) then
  begin
    LIndexFirst := FIndexFlow;
    FPoint.X := AMarginLeft;
    LNextLine := FPoint.Y;
    while (FIndexFlow < Length(FControlsFlow)) and (FPoint.Y < AMarginBottom) do
    begin
      LControl := FControlsFlow[FIndexFlow];
      if (FPoint.X > (AMarginRight - LControl.Width)) or (IsPreformated and (LControl is TLazbroTextEnding)) or
        (LControl.HelpContext = hcAlignBlock) then
      begin
        FPoint := Point(AMarginLeft, LNextLine);
        if FPoint.Y >= AMarginBottom then
        begin
          Break;
        end;
        LayoutAlign(LIndexFirst, FIndexFlow - 1, AMarginRight);
        LIndexFirst := FIndexFlow;
      end;
      FPoints[FIndexFlow] := FPoint;
      FPoint.X += LControl.Width;
      LNextLine := Max(LNextLine, FPoint.Y + LControl.Height + LControl.BorderSpacing.Bottom);
      Inc(FIndexFlow);
      if FIndexFlow < Length(FControlsFlow) then
      begin
        LNextLine += FControlsFlow[FIndexFlow].BorderSpacing.Top;
      end;
    end;
    LayoutAlign(LIndexFirst, FIndexFlow - 1, AMarginRight);
  end;
end;

procedure TLazbroLayout.LayoutLeftRight(const AMarginLeft, AMarginRight, AMarginBottom: Integer);
var
  LControl: TControl;
begin
  if Length(FControlsLeft) > FIndexLeft then
  begin
    LControl := FControlsLeft[FIndexLeft];
    LControl.SetBounds(AMarginLeft + LControl.BorderSpacing.Left, FPoint.Y + LControl.BorderSpacing.Top, LControl.Width, LControl.Height);
    Inc(FIndexLeft);
    LayoutLeftRight(LControl.BoundsRect.Right + LControl.BorderSpacing.Right, AMarginRight,
      LControl.BoundsRect.Bottom + LControl.BorderSpacing.Bottom);
  end;
  if Length(FControlsRight) > FIndexRight then
  begin
    LControl := FControlsRight[FIndexRight];
    LControl.SetBounds(AMarginRight - LControl.Width - LControl.BorderSpacing.Right, FPoint.Y + LControl.BorderSpacing.Top,
      LControl.Width, LControl.Height);
    Inc(FIndexRight);
    LayoutLeftRight(AMarginLeft, LControl.Left - LControl.BorderSpacing.Left, LControl.BoundsRect.Bottom + LControl.BorderSpacing.Bottom);
  end;
  LayoutFlow(AMarginLeft, AMarginRight, AMarginBottom);
end;

procedure TLazbroLayout.CreateCacheArrays;
var
  LIdx: Integer;
  LControl: TControl;
begin
  if not FArraysCreated then
  begin
    FArraysCreated := True;
    SetLength(FControlsLeft, 0);
    SetLength(FControlsRight, 0);
    SetLength(FControlsFlow, 0);
    for LIdx := 0 to ControlCount - 1 do
    begin
      LControl := Controls[LIdx];
      if LControl is TLazbroText then
      begin
        LControl.Visible := IsPreformated or not ((LControl is TLazbroTextEnding) or (LControl is TLazbroTextSpace));
      end;
      if LControl.Visible then
      begin
        case LControl.HelpContext of
          hcAlignLeft: begin
            SetLength(FControlsLeft, Length(FControlsLeft) + 1);
            FControlsLeft[High(FControlsLeft)] := LControl;
          end;
          hcAlignRight: begin
            SetLength(FControlsRight, Length(FControlsRight) + 1);
            FControlsRight[High(FControlsRight)] := LControl;
          end else
          begin
            SetLength(FControlsFlow, Length(FControlsFlow) + 1);
            FControlsFlow[High(FControlsFlow)] := LControl;
          end;
        end;
      end;
    end;
    SetLength(FPoints, Length(FControlsFlow));
  end;
end;

procedure TLazbroLayout.LayoutControls(const AControlIndex: Integer);
var
  LIdx, LHeight: Integer;
  LControl: TControl;
  LNode: TDOMNode;
begin
  LNode := ControlGetNode(Self);
  if LNode is TDOMElement then
  begin
    case LowerCase(TDOMElement(LNode).TagName) of
      tnTD, tnTH: begin
        if AControlIndex > 0 then
        begin
          SetBounds(BorderSpacing.Left + Parent.Controls[AControlIndex - 1].BoundsRect.Right, BorderSpacing.Top, Width, Height);
        end else begin
          SetBounds(BorderSpacing.Left, BorderSpacing.Top, Width, Height);
        end;
        Width := NodeGetSize(LNode, an_Width, Parent.ClientWidth, Parent.ClientWidth div Parent.ControlCount);
      end;
    end;
  end;
  CreateCacheArrays;
  for LIdx := 0 to ControlCount - 1 do
  begin
    LControl := Controls[LIdx];
    if LControl.Visible then
    begin
      LNode := ControlGetNode(LControl);
      if LNode is TDOMElement then
      begin
        LControl.Width := NodeGetSize(LNode, an_Width, ClientWidth - ChildSizing.LeftRightSpacing * 2, LControl.Width);
      end;
    end;
  end;

  FPoint := Point(0, ChildSizing.TopBottomSpacing);

  FIndexLeft := 0;
  FIndexRight := 0;
  FIndexFlow := 0;

  LayoutLeftRight(ChildSizing.LeftRightSpacing, ClientWidth - ChildSizing.LeftRightSpacing * 2, MaxInt);

  for LIdx := 0 to High(FControlsFlow) do
  begin
    with FControlsFlow[LIdx] do
    begin
      Left := FPoints[LIdx].x;
      Top := FPoints[LIdx].y;
    end;
  end;

  LHeight := NodeGetIntegerDef(LNode, an_Height, 0);

  for LIdx := 0 to ControlCount - 1 do
  begin
    if Controls[LIdx].Visible then
    begin
      LHeight := Max(LHeight, Controls[LIdx].BoundsRect.Bottom + Controls[LIdx].BorderSpacing.Bottom +
        ChildSizing.TopBottomSpacing);
    end;
  end;
  Height := LHeight + 1;
end;

procedure TLazbroLayout.LayoutAll(const AControlIndex: Integer);
var
  LIdx: Integer;
begin
  DisableAutoSizing;
  try
    LayoutControls(AControlIndex);
    for LIdx := 0 to ControlCount - 1 do
    begin
      try
        (Controls[LIdx] as TLazbroLayout).LayoutAll(LIdx);
      except
      end;
    end;
  finally
    EnableAutoSizing;
  end;
end;

procedure TLazbroLayout.Paint;
var
  LIdx: Integer;
begin
  inherited Paint;
  for LIdx := 0 to ControlCount - 1 do
  begin
    if Controls[LIdx] is TLazbroText then
    begin
      TLazbroText(Controls[LIdx]).Paint;
    end;
  end;
end;

constructor TLazbro.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  FSelectHigh := -1;
  BorderStyle := bsSingle;
  HorzScrollBar.Tracking := True;
  HorzScrollBar.Visible := False;
  VertScrollBar.Tracking := True;
  AutoScroll := True;

  FHistory := TStringList.Create;
  ClearHistory;

  FContentTypes := TStringList.Create;
  FContentTypes.Values['.htm'] := ctTextHtml;
  FContentTypes.Values['.html'] := ctTextHtml;
  FContentTypes.Values['.jpeg'] := ctImageJpeg;
  FContentTypes.Values['.jpg'] := ctImageJpeg;
  FContentTypes.Values['.png'] := ctImagePng;
  FContentTypes.Values['.gif'] := ctImageGif;

  FHTTPClient := TFPHTTPClient.Create(Self);

  PopupMenu := TPopupMenu.Create(Self);

  FControls := TComponent.Create(Self);

  FStatusText := TEdit.Create(Self);
  FStatusText.AutoSelect := False;
  FStatusText.ReadOnly := True;
  FStatusText.Color := clSkyBlue;
  FStatusText.Font.Height := 21;
  FStatusText.BorderStyle := bsNone;
  FStatusText.Parent := Self;
  FStatusText.OnEnter := @DoOnEnter;
  FStatusText.OnExit := @DoOnExit;
  FStatusText.PopupMenu := PopupMenu;

  CreateMenuItem(rsGoBack, scGoBack);
  CreateMenuItem(rsGoForward, scGoForward);
  CreateMenuItem('-', 0);
  CreateMenuItem(rsCopy, scCopyToClipboard);
  CreateMenuItem(rsSelectAll, scSelectAll);
  CreateMenuItem('-', 0);
  CreateMenuItem(rsRefresh, scRefresh);

  FTimer := TTimer.Create(Self);
  FTimer.Enabled := False;
  FTimer.OnTimer := @DoOnTimer;

  ClearPage;
end;

destructor TLazbro.Destroy;
begin

  FHistory.Free;
  FDocument.Free;
  FContentTypes.Free;
  //FreeAndNil(FTimer);
  inherited Destroy;
end;

procedure TLazbro.CreateText(const ANode: TDOMNode; const AParent: TWinControl);
const
  LSetOfAllow = [#33..#126];
var
  LStr, LCaption: String;
  LToken, LPtr: PChar;
begin
  LStr := ANode.TextContent;
  //ShowMessage(LStr);
  LPtr := PChar(LStr);
  while LPtr[0] <> #0 do
  begin
    if LPtr[0] = #32 then
    begin
      LToken := LPtr;
      repeat
        Inc(LPtr)
      until LPtr[0] <> #32;
      if (LPtr - LToken) > 1 then
      begin
        SetString(LCaption, LToken, LPtr - LToken - 1);
        CreateControlClass(TLazbroTextSpace, ANode, AParent).Caption := LCaption;
      end;
    end else if LPtr[0] in [#10] then
    begin
      LToken := LPtr;
      Inc(LPtr);
      CreateControlClass(TLazbroTextEnding, ANode, AParent).Caption := EmptyStr;
    end else if LPtr[0] in LSetOfAllow then
    begin
      LToken := LPtr;
      repeat
        Inc(LPtr);
      until not (LPtr[0] in LSetOfAllow);
      SetString(LCaption, LToken, LPtr - LToken);
      CreateControlClass(TLazbroTextWord, ANode, AParent).Caption := LCaption + ' ';
    end else begin
      Inc(LPtr);
    end;
  end;
end;

function TLazbro.CreateControlClass(const AClass: TControlClass; const ANode: TDOMNode; const AParent: TWinControl): TControl;
begin
  Result := AClass.Create(FControls);
  Result.Tag := PtrInt(ANode);
  Result.Parent := AParent;
  if not (Result is TLazbro) then
  begin
    Result.OnClick := @DoOnClick;
    THackControl(Result).OnMouseWheel := @DoOnMouseWheel;
  end;
  if (Result is TLazbroText) or (Result is TLazbroLayout) or (Result is TBevel) then
  begin
    THackControl(Result).OnMouseMove := @DoOnMouseMove;
    THackControl(Result).OnMouseUp := @DoOnMouseUp;
    THackControl(Result).OnMouseDown := @DoOnMouseDown;
  end;
  ControlApplyAttributes(Result);
  if FShowBorders and (Result is TCustomControl) then
  begin
    TCustomControl(Result).BorderStyle := bsSingle;
  end;
end;

function TLazbro.CreateInput(const ANode: TDOMNode; const AParent: TWinControl): TControl;

begin
  case LowerCase(NodeGetStringDef(ANode, anStandardType, EmptyStr)) of
    avCheckBox: begin
      Result := CreateControlClass(TCheckBox, ANode, AParent);
      (Result as TCheckBox).Hint := NodeGetValueDef(ANode, EmptyStr);
    end;
    avPassword: begin
      Result := CreateControlClass(TEdit, ANode, AParent);
      (Result as TEdit).PasswordChar := '*';
      (Result as TEdit).Caption := NodeGetValueDef(ANode, EmptyStr);
    end;
    avSubmit: begin
      Result := CreateControlClass(TButton, ANode, AParent);
      (Result as TButton).Caption := NodeGetValueDef(ANode, EmptyStr);
    end else
    begin
      Result := CreateControlClass(TEdit, ANode, AParent);
      (Result as TEdit).Caption := NodeGetValueDef(ANode, EmptyStr);
    end;
  end;
end;

function TLazbro.CreateDiv(const ANode: TDOMNode; const AParent: TWinControl): TControl;
begin
  Result := CreateFlow(ANode, AParent);
end;

function TLazbro.CreateBevel(const ANode: TDOMNode; const AParent: TWinControl; const AShape: TBevelShape): TBevel;
begin
  Result := CreateControlClass(TBevel, ANode, AParent) as TBevel;
  if FShowBorders then
  begin
    Result.Shape := bsBox;
  end else begin
    Result.Shape := AShape;
  end;
  Result.Enabled := False;
end;

function TLazbro.CreateTextArea(const ANode: TDOMNode; const AParent: TWinControl): TMemo;
begin
  Result := CreateControlClass(TMemo, ANode, AParent) as TMemo;
  Result.ScrollBars := ssVertical;
  Result.Text := ANode.TextContent;
end;

function TLazbro.CreateIFrame(const ANode: TDOMNode; const AParent: TWinControl): TLazbro;
begin
  Result := CreateControlClass(TLazbro, ANode, AParent) as TLazbro;
  Result.LoadFromUrl(ResolveUrl(NodeGetStringDef(ANode, anStandardSrc, EmptyStr)));
end;

function TLazbro.CreateListBox(const ANode: TDOMNode; const AParent: TWinControl): TListBox;
var
  LIdx: Integer;
  LOption: TDOMElement;
begin
  Result := CreateControlClass(TListBox, ANode, AParent) as TListBox;
  for LIdx := 0 to ANode.ChildNodes.Count - 1 do
  begin
    LOption := ANode.ChildNodes[LIdx] as TDOMElement;
    Result.Items.Add(LOption.TextContent);
    if NodeHasAttribute(LOption, anStandardSelected) then
    begin
      Result.ItemIndex := Result.Items.Count - 1;
    end;
  end;
  if Result.ItemIndex < 0 then
  begin
    Result.ItemIndex := 0;
  end;
end;

function TLazbro.CreateComboBox(const ANode: TDOMNode; const AParent: TWinControl): TComboBox;
var
  LIdx: Integer;
  LOption: TDOMElement;
begin
  Result := CreateControlClass(TComboBox, ANode, AParent) as TComboBox;
  Result.Style := csDropDownList;
  for LIdx := 0 to ANode.ChildNodes.Count - 1 do
  begin
    LOption := ANode.ChildNodes[LIdx] as TDOMElement;
    Result.Items.Add(LOption.TextContent);
    if NodeHasAttribute(LOption, anStandardSelected) then
    begin
      Result.ItemIndex := Result.Items.Count - 1;
    end;
  end;
  if Result.ItemIndex < 0 then
  begin
    Result.ItemIndex := 0;
  end;
end;

function TLazbro.CreateSelect(const ANode: TDOMNode; const AParent: TWinControl): TControl;
begin
  if NodeHasAttribute(ANode, anStandardMultiple) then
  begin
    Result := CreateListBox(ANode, AParent);
  end else begin
    Result := CreateComboBox(ANode, AParent);
  end;
end;

function TLazbro.CreateImage(const ANode: TDOMNode; const AParent: TWinControl): TImage;
var
  LPicture: TPicture;
begin
  LPicture := TPicture.Create;
  try
    try
      LoadPicture(LPicture, ResolveUrl(NodeGetStringDef(ANode, anStandardSrc, EmptyStr)));
    except
      LoadPicture(LPicture, rsSrcBroken);
    end;
    if not NodeHasAttribute(ANode, an_Width) then
    begin
      NodeSetDefaultInteger(ANode, an_Width, LPicture.Width * NodeGetIntegerDef(ANode, an_Height, LPicture.Height) div
        Max(LPicture.Height, 1));
    end;
    if not NodeHasAttribute(ANode, an_Height) then
    begin
      NodeSetDefaultInteger(ANode, an_Height, LPicture.Height * NodeGetIntegerDef(ANode, an_Width, LPicture.Width) div
        Max(LPicture.Width, 1));
    end;
    Result := CreateControlClass(TImage, ANode, AParent) as TImage;
    Result.ShowHint := True;
    Result.Hint := NodeGetStringDef(ANode, anStandardTitle, Result.Hint);
    Result.Stretch := True;
    Result.Picture.Assign(LPicture);
  finally
    FreeAndNil(LPicture);
  end;
end;

function TLazbro.CreateFlow(const ANode: TDOMNode; const AParent: TWinControl): TLazbroLayout;
begin
  Result := CreateControlClass(TLazbroLayout, ANode, AParent) as TLazbroLayout;
  Result.OnPaint := @DoOnPaint;
  CreateControls(ANode.ChildNodes, Result);
end;

procedure TLazbro.CreateControls(const AList: TDOMNodeList; const AParent: TWinControl);
var
  LIdx: Integer;
begin
  for LIdx := 0 to AList.Count - 1 do
  begin
    CreateControl(AList[LIdx], AParent);
  end;
end;

function TLazbro.CreateControl(const ANode: TDOMNode; const AParent: TWinControl): TControl;
begin
  Result := nil;
  if ANode is TDOMText then
  begin
    CreateText(ANode, AParent);
  end else begin
    if ANode is TDOMElement then
    begin
      NodeStandardize(ANode);
      case LowerCase(TDOMElement(ANode).TagName) of
        tnSTYLE: begin
        end;
        tnTBODY, tnFONT, tnSPAN, tnA, tnB, tnI, tnSTRONG: begin
          CreateControls(ANode.ChildNodes, AParent);
        end;
        tnDIV: begin
          Result := CreateDiv(ANode, AParent);
        end;
        tnHR: begin
          Result := CreateBevel(ANode, AParent, bsBottomLine);
        end;
        tnBR: begin
          Result := CreateBevel(ANode, AParent, bsSpacer);
        end;
        tnIMG: begin
          Result := CreateImage(ANode, AParent);
        end;
        tnINPUT: begin
          Result := CreateInput(ANode, AParent);
        end;
        tnTEXTAREA: begin
          Result := CreateTextArea(ANode, AParent);
        end;
        tnSELECT: begin
          Result := CreateSelect(ANode, AParent);
        end;
        tnIFRAME: begin
          Result := CreateIFrame(ANode, AParent);
        end else
        begin
          Result := CreateFlow(ANode, AParent);
        end;
      end;
    end;
  end;
end;

function TLazbro.CreateMenuItem(const ACaption: String; const AShortCut: TShortCut): TMenuItem;
begin
  Result := TMenuItem.Create(PopupMenu);
  Result.Caption := ACaption;
  Result.ShortCut := AShortCut;
  Result.OnClick := @DoOnClick;
  PopupMenu.Items.Add(Result);
end;

procedure TLazbro.DoOnPaint(ASender: TObject);
begin
end;

procedure TLazbro.DoOnClick(ASender: TObject);
var
  LAnchor: TDOMNode;
begin
  if ASender is TMenuItem then
  begin
    case TMenuItem(ASender).ShortCut of
      scSelectAll: begin
        SelectAll;
      end;
      scRefresh: begin
        Refresh;
      end;
      scGoBack: begin
        GoBack;
      end;
      scGoForward: begin
        GoForward;
      end;
      scCopyToClipboard: begin
        ClipBoard.AsText := GetSelectedText;
      end;
    end;
  end else if ASender is TButton then
  begin
    SubmitForm;
  end else begin
    if GetSelectedCount = 0 then
    begin
      try
        LAnchor := ControlFindRootAnchor(ASender as TControl);
        if SameText(NodeGetStringDef(LAnchor, anStandardTarget, EmptyStr), av_Blank) then
        begin
          OpenUrl(ResolveUrl(NodeGetStringDef(LAnchor, anStandardHref, EmptyStr)));
        end else begin
          LoadFromUrlDelayed(ResolveUrl(NodeGetStringDef(LAnchor, anStandardHref, EmptyStr)));
        end;
      except
      end;
    end;
  end;
end;

procedure TLazbro.DoOnTimer(ASender: TObject);
begin
  FTimer.Enabled := False;
  LoadFromUrl(FDelayedUrl);
end;

procedure TLazbro.DoOnDocumentComplete(const ADocument: TLazbro);
var
  LParent: TLazbro;
begin
  if Assigned(FOnComplete) then
  begin
    FOnComplete(ADocument);
  end;
  LParent := GetParentFrame;
  if Assigned(LParent) then
  begin
    LParent.DoOnDocumentComplete(ADocument);
  end;
end;

procedure TLazbro.DoOnEnter(ASender: TObject);
begin
end;

procedure TLazbro.DoOnExit(ASender: TObject);
begin
  ClearSelection;
end;

procedure TLazbro.DoOnMouseWheel(ASender: TObject; AShift: TShiftState; AWheelDelta: Integer; AMousePos: TPoint; var AHandled: Boolean);
begin
  AHandled := not (ASender is TMemo);
  if AHandled then
  begin
    VertScrollBar.Position := Min(VertScrollBar.Position - (AWheelDelta div 2), VertScrollBar.Range);
  end;
end;

procedure TLazbro.DoOnMouseDown(ASender: TObject; AButton: TMouseButton; AShift: TShiftState; AX, AY: Integer);
begin
  if AButton = mbLeft then
  begin
    if FStatusText.Focused then
    begin
      ClearSelection;
    end else begin
      FStatusText.SetFocus;
    end;
  end;
  FButtons[AButton] := True;
  FMouseDownPoint := Point(AX, AY);
end;

procedure TLazbro.DoOnMouseMove(ASender: TObject; AShift: TShiftState; AX, AY: Integer);
var
  LWord1, LWord2: TLazbroTextWord;
  LControl: TControl;
  LPoint: TPoint;
begin
  if ASender is TLazbroText then
  begin
    if FButtons[mbLeft] then
    begin
      if ASender is TLazbroTextWord then
      begin
        LControl := GetControlAt(ScreenToClient(Mouse.CursorPos));
        if Assigned(LControl) and (LControl.Owner = FControls) then
        begin
          LWord1 := TLazbroTextWord(ASender);
          if (Sqr(AX - FMouseDownPoint.X) + Sqr(AY - FMouseDownPoint.Y)) < ((Sqr(LWord1.Width) + Sqr(LWord1.Height)) div 30) then
          begin
            ClearSelection;
          end else begin
            if LControl is TLazbroTextWord then
            begin
              LWord2 := TLazbroTextWord(LControl);
            end else begin
              LPoint := LWord1.Parent.ClientToScreen(Point(LWord1.Left, LWord1.Top));
              if (Mouse.CursorPos.X >= LPoint.X) and (Mouse.CursorPos.Y >= LPoint.Y) then
              begin
                LWord2 := FindWordAfterPoint(Mouse.CursorPos);
              end else begin
                LWord2 := FindWordBeforePoint(Mouse.CursorPos);
              end;
            end;
            if Assigned(LWord2) then
            begin
              SetSelection(Min(LWord1.ComponentIndex, LWord2.ComponentIndex), Max(LWord1.ComponentIndex, LWord2.ComponentIndex));
            end;
          end;
        end;
      end;
    end;
  end;
end;

procedure TLazbro.DoOnMouseUp(ASender: TObject; AButton: TMouseButton; AShift: TShiftState; AX, AY: Integer);
begin
  FButtons[AButton] := False;
end;

procedure TLazbro.DoOnResize;
begin
  if Assigned(FBodyControl) then
  begin
    FBodyControl.Width := ClientWidth;
    FBodyControl.LayoutAll(0);
    FBodyControl.LayoutAll(0);
    FBodyControl.Height := Max(FBodyControl.Height, ClientHeight);
    VertScrollBar.Range := FBodyControl.Height - ClientHeight + VertScrollBar.Size + 64;
    VertScrollBar.Position := Min(VertScrollBar.Position, VertScrollBar.Range);
  end;
  inherited DoOnResize;
end;

procedure TLazbro.SetStatusText(const AString: String);
var
  LParent: TLazbro;
begin
  FStatusText.Text := AString;
  if AString = EmptyStr then
  begin
    FStatusText.SendToBack;
  end else begin
    FStatusText.Top := VertScrollBar.Position;
    FStatusText.Width := ClientWidth;
    FStatusText.BringToFront;
    FStatusText.Refresh;
    if Assigned(FOnStatusChange) then
    begin
      FOnStatusChange(Self);
    end;
    LParent := GetParentFrame;
    if Assigned(LParent) then
    begin
      LParent.SetStatusText(AString);
    end;
  end;
end;

function TLazbro.GetParentFrame: TLazbro;
begin
  Result := Self;
  repeat
    Result := TLazbro(Result.Parent);
  until not Assigned(Result) or (Result is TLazbro);
end;

function TLazbro.GetTopFrame: TLazbro;
begin
  Result := GetParentFrame;
  if Assigned(Result) then
  begin
    Result := Result.GetTopFrame;
  end else begin
    Result := Self;
  end;
end;

function TLazbro.GetControlAt(const APoint: TPoint): TControl;
begin
  Result := ControlAtPos(APoint, [capfAllowDisabled, capfAllowWinControls, capfHasScrollOffset, capfRecursive]);
end;

function TLazbro.FindWordBeforePoint(const APoint: TPoint): TLazbroTextWord;
var
  LIdx: Integer;
begin
  for LIdx := 0 to FControls.ComponentCount - 1 do
  begin
    if FControls.Components[LIdx] is TLazbroTextWord then
    begin
      Result := TLazbroTextWord(FControls.Components[LIdx]);
      with Result.Parent.ClientToScreen(Point(Result.BoundsRect.Right, Result.BoundsRect.Bottom)) do
      begin
        if (APoint.X < X) and (APoint.Y < Y) then
        begin
          Exit;
        end;
      end;
    end;
  end;
  Result := nil;
end;

function TLazbro.FindWordAfterPoint(const APoint: TPoint): TLazbroTextWord;
var
  LIdx: Integer;
begin
  for LIdx := FControls.ComponentCount - 1 downto 0 do
  begin
    if FControls.Components[LIdx] is TLazbroTextWord then
    begin
      Result := TLazbroTextWord(FControls.Components[LIdx]);
      with Result.Parent.ClientToScreen(Point(Result.Left, Result.Top)) do
      begin
        if (APoint.X >= X) and (APoint.Y >= Y) then
        begin
          Exit;
        end;
      end;
    end;
  end;
  Result := nil;
end;

procedure TLazbro.SetBaseUrl(const AUrl: String);
begin
  FBaseUrl := AUrl;
  if Assigned(FOnUrlChange) then
  begin
    FOnUrlChange(Self);
  end;
end;

function TLazbro.ResolveUrl(const AUrl: String): String;
begin
  if not ResolveRelativeURI(FBaseUrl, AUrl, Result) then
  begin
    raise ELazbro.Create(rsUnableToResolveURL);
  end;
end;

procedure TLazbro.ClearSelection;
begin
  SetSelection(0, -1);
end;

procedure TLazbro.ClearHistory;
begin
  FHistory.Clear;
  FHistoryIndex := -1;
end;

procedure TLazbro.SetSelection(ALow, AHigh: Integer);
var
  LIdx: Integer;
begin
  ALow := Max(ALow, 0);
  AHigh := Min(AHigh, FControls.ComponentCount - 1);
  for LIdx := FSelectLow to Min(FSelectHigh, ALow - 1) do
  begin
    if FControls.Components[LIdx] is TLazbroText then
    begin
      TLazbroText(FControls.Components[LIdx]).Selected := False;
    end;
  end;
  for LIdx := Max(AHigh + 1, FSelectLow) to FSelectHigh do
  begin
    if FControls.Components[LIdx] is TLazbroText then
    begin
      TLazbroText(FControls.Components[LIdx]).Selected := False;
    end;
  end;
  for LIdx := ALow to AHigh do
  begin
    if FControls.Components[LIdx] is TLazbroText then
    begin
      TLazbroText(FControls.Components[LIdx]).Selected := True;
    end;
  end;
  FSelectLow := ALow;
  FSelectHigh := AHigh;
end;

procedure TLazbro.SelectAll;
begin
  SetSelection(0, FControls.ComponentCount - 1);
end;

function TLazbro.GetSelectedText: String;
var
  LIdx: Integer;
begin
  Result := EmptyStr;
  for LIdx := FSelectLow to FSelectHigh do
  begin
    if FControls.Components[LIdx] is TLazbroTextEnding then
    begin
      Result += LineEnding;
    end else if FControls.Components[LIdx] is TLazbroText then
    begin
      Result += TLazbroText(FControls.Components[LIdx]).Caption;
    end;
  end;
end;

function TLazbro.GetSelectedCount: Integer;
begin
  Result := Max(FSelectHigh - FSelectLow + 1, 0);
end;

function TLazbro.GetStatusText: String;
begin
  Result := FStatusText.Text;
end;

procedure TLazbro.ClearPage;
begin
  ClearSelection;
  DisableAutoSizing;
  try
    FControls.DestroyComponents;
  finally
    EnableAutoSizing;
  end;
  FBodyControl := nil;
  FreeAndNil(FDocument);
  VertScrollBar.Position := 0;
  VertScrollBar.Range := 0;
  SetStatusText(EmptyStr);
end;

procedure TLazbro.Refresh;
var
  LHistoryIndex: Integer;
begin
  LHistoryIndex := FHistoryIndex;
  LoadFromUrl(FBaseUrl);
  FHistory.Delete(FHistoryIndex);
  FHistoryIndex := LHistoryIndex;
end;

procedure TLazbro.GoBack;
var
  LHistoryIndex: Integer;
begin
  if FHistoryIndex > 0 then
  begin
    LHistoryIndex := FHistoryIndex - 1;
    FHistoryIndex := FHistory.Count - 1;
    LoadFromUrl(FHistory[LHistoryIndex]);
    FHistory.Delete(FHistoryIndex);
    FHistoryIndex := LHistoryIndex;
  end;
end;

procedure TLazbro.GoForward;
var
  LHistoryIndex: Integer;
begin
  if FHistoryIndex < FHistory.Count - 1 then
  begin
    LHistoryIndex := FHistoryIndex + 1;
    FHistoryIndex := FHistory.Count - 1;
    LoadFromUrl(FHistory[LHistoryIndex]);
    FHistory.Delete(FHistoryIndex);
    FHistoryIndex := LHistoryIndex;
  end;
end;

procedure ProcessExecuteCgi(const AStream: TStream; const AExecutable, AUrl: String; out AContentType: String);
var
  LIdx, LSize: Integer;
  LBuffer: String;
begin
  SetLength(LBuffer, 256);
  with TProcess.Create(nil) do
  begin
    try
      Options := [poUsePipes, poStderrToOutPut, poNoConsole];
      Executable := AExecutable;
      CurrentDirectory := ExtractFileDir(AExecutable);
      Environment.Values[CgiQueryString] := ParseURI(AUrl, False).Params;
      Execute;
      for LIdx := 1 to (CgiTimeOut * 1000 div CgiTimeSleep) do
      begin
        Sleep(CgiTimeSleep);
        LSize := Output.Read(LBuffer[1], Length(LBuffer));
        AStream.WriteBuffer(LBuffer[1], LSize);
        if (LSize = 0) and not Running then
        begin
          Break;
        end;
      end;
      if Running then
      begin
        Terminate(0);
        raise ELazbro.Create(rsCgiTimeOut);
      end;
      AStream.Position := 0;
      AStream.Read(LBuffer[1], Length(LBuffer));
      LIdx := 1;
      if SameText(Trim(ExtractSubstr(LBuffer, LIdx, [':'])), fieldContentType) then
      begin
        AContentType := Trim(ExtractSubstr(LBuffer, LIdx, [#10, #13]));
      end else begin
        raise ELazbro.Create(rsCGIContentTypeMissing);
      end;
      ExtractSubstr(LBuffer, LIdx, [#10, #13]);
      AStream.Position := LIdx;
    finally
      Free;
    end;
  end;
end;

function TLazbro.CreateStreamFromUrl(const AUrl: String; out AContentType: String): TStream;
const
  LDelims = [':', ';', ','];
var
  LPos: Integer;
  LFilename, LFileExt: String;
begin
  AContentType := EmptyStr;
  LPos := 1;
  case LowerCase(ExtractSubstr(AUrl, LPos, LDelims)) of
    protocolData: begin
      AContentType := ExtractSubstr(AUrl, LPos, LDelims);
      ExtractSubstr(AUrl, LPos, LDelims);
      Result := TStringStream.Create(DecodeStringBase64(Copy(AUrl, LPos, MaxInt)));
    end;
    protocolAbout: begin
      AContentType := ctTextHtml;
      Result := TStringStream.Create(Copy(AUrl, LPos, MaxInt));
    end;
    protocolFile: begin
      if URIToFilename(ResolveUrl(AUrl), LFilename) then
      begin
        LFileExt := ExtractFileExt(LFilename);
        if SameText(LFileExt, '.cgi') then
        begin
          Result := TMemoryStream.Create;
          try
            ProcessExecuteCgi(Result, LFilename, AUrl, AContentType);
          except
            FreeAndNil(Result);
            raise;
          end;
        end else begin
          AContentType := GetContentTypeFromExt(LFileExt);
          Result := TFileStream.Create(LFilename, fmOpenRead);
        end;
      end else begin
        raise ELazbro.Create(rsUnableToResolveFilename);
      end;
    end;
    protocolHttp: begin
      Result := TMemoryStream.Create;
      try
        SetStatusText(rsLoading + ': ' + AUrl);
        try
          FHTTPClient.Get(AUrl, Result);
        finally
          SetStatusText(EmptyStr);
        end;
        AContentType := FHTTPClient.ResponseHeaders.Values[fieldContentType];
      except
        FreeAndNil(Result);
        raise;
      end;
    end else
    begin
      raise ELazbro.Create(rsUnknownProtocol);
    end;
  end;
  Result.Position := 0;
end;

procedure TLazbro.LoadPicture(const APicture: TPicture; const AUrl: String);
var
  LStream: TStream;
  LContentType: String;
begin
  LStream := CreateStreamFromUrl(AUrl, LContentType);
  try
    APicture.LoadFromStream(LStream);
  finally
    FreeAndNil(LStream);
  end;
end;

procedure TLazbro.LoadFromStream(const AStream: TStream; const ABaseUrl: String);
var
  LReader: THTMLReader;
  LConverter: THTMLToDOMConverter;
begin
  try
    ClearPage;
    SetBaseUrl(ABaseUrl);
    SetStatusText(ABaseUrl);
    try
      FDocument := THTMLDocument.Create;
      LReader := THTMLReader.Create;
      try
        LConverter := THTMLToDOMConverter.Create(LReader, FDocument);
        try
          LReader.ParseStream(AStream);
        finally
          FreeAndNil(LConverter);
        end;
      finally
        FreeAndNil(LReader);
      end;
      DisableAutoSizing;
      try
        FBodyControl := CreateControl(FDocument.Body, Self) as TLazbroLayout;
        DoOnResize;
      finally
        EnableAutoSizing;
      end;
      DoOnResize;
      SetStatusText(rsDone);
      DoOnDocumentComplete(Self);
    finally
      SetStatusText(EmptyStr);
    end;
  except
    on AException: Exception do LoadFromException(AException, FBaseUrl);
  end;
end;

function TLazbro.GetContentTypeFromExt(const AExt: String): String;
begin
  Result := FContentTypes.Values[LowerCase(AExt)];
end;

function TLazbro.GetContentTypeFromUrl(const AUrl: String): String;
begin
  Result := GetContentTypeFromExt(ExtractFileExt(ParseURI(AUrl).Document));
end;

procedure TLazbro.LoadFromUrl(const AUrl, ABaseUrl: String);
var
  LContentType: String;
  LStream: TStream;
begin
  if not AnsiStartsStr(protocolAbout + ':', AUrl) then
  begin
    while FHistoryIndex < FHistory.Count - 1 do
    begin
      FHistory.Delete(FHistoryIndex + 1);
    end;
    FHistoryIndex := FHistory.Add(AUrl);
  end;
  try
    LContentType := GetContentTypeFromUrl(AUrl);
    if AnsiStartsStr(ctImage, LContentType) then
    begin
      LoadFromString(Format(rsHtmlImage2, [AUrl, AUrl]), ABaseUrl);
    end else begin
      LStream := CreateStreamFromUrl(AUrl, LContentType);
      try
        LoadFromStream(LStream, ABaseUrl);
      finally
        FreeAndNil(LStream);
      end;
    end;
  except
    on AException: Exception do LoadFromException(AException, AUrl);
  end;
end;

procedure TLazbro.LoadFromUrl(const AUrl: String);
begin
  LoadFromUrl(AUrl, AUrl);
end;

procedure TLazbro.LoadFromString(const AString: String; const ABaseUrl: String);
begin
  LoadFromUrl(protocolAbout + ':' + AString, ABaseUrl);
end;

procedure TLazbro.LoadFromException(const AException: Exception; const ABaseUrl: String);
begin
  LoadFromString(Format(rsHtmlException3, [AException.ClassName, AException.ClassName, AException.Message]), ABaseUrl);
end;

procedure TLazbro.LoadFromFile(const AFilename: TFilename);
begin
  LoadFromUrl(FilenameToURI(CleanAndExpandFilename(AFilename)));
end;

procedure TLazbro.LoadFromUrlDelayed(const AUrl: String; const AInterval: Integer);
begin
  FDelayedUrl := AUrl;
  FTimer.Interval := AInterval;
  FTimer.Enabled := True;
end;

function TLazbro.SubmitForm: String;
var
  LPos: Integer;
begin
  LPos := Pos('?', FBaseUrl);
  if LPos = 0 then
  begin
    LPos := Length(FBaseUrl) + 1;
  end;
  Result := Copy(FBaseUrl, 1, LPos - 1) + '?' + ControlCreateQueryString(FBodyControl);
  LoadFromUrlDelayed(Result);
end;

end.
