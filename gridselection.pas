{ A multiselection plug-in for Lazarus TCustomDrawGrid and derivates

  Copyright (C) 2015 Jesús Reyes Aguilar jesusrmx@yahoo.com.mx

  This library is free software; you can redistribute it and/or modify it
  under the terms of the GNU Library General Public License as published by
  the Free Software Foundation; either version 2 of the License, or (at your
  option) any later version with the following modification:

  As a special exception, the copyright holders of this library give you
  permission to link this library with independent modules to produce an
  executable, regardless of the license terms of these independent modules,and
  to copy and distribute the resulting executable under terms of your choice,
  provided that you also meet, for each linked independent module, the terms
  and conditions of the license of that module. An independent module is a
  module which is not derived from or based on this library. If you modify
  this library, you may extend this exception to your version of the library,
  but you are not obligated to do so. If you do not wish to do so, delete this
  exception statement from your version.

  This program is distributed in the hope that it will be useful, but WITHOUT
  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
  FITNESS FOR A PARTICULAR PURPOSE. See the GNU Library General Public License
  for more details.

  You should have received a copy of the GNU Library General Public License
  along with this library; if not, write to the Free Software Foundation,
  Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
}

unit gridselection;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, LCLType, Graphics, Controls, Forms, Grids, LazLogger;

type
  TSelState = (SEL_UNSELECTED, SEL_SELECTED);

  TGridSelectionOptions = set of (
    gsoGrabMouseMove,
    gsoGrabMouseDown,
    gsoGrabMouseUp,
    gsoGrabPrepareCanvas,
    gsoGrabColRowExchanged,
    gsoGrabColRowDeleted,
    gsoGrabColRowInserted,
    gsoGrabColRowMoved,
    gsoGrabKeyboard,
    gsoUseObjectsArray,
    gsoUseSelection
    );

  TSelRect = record
    Rect: TRect;
    SelValue: TSelState;
  end;

  { TGridSelection }

  TGridSelection = class
  private
    fEnabled: boolean;
    fRange: TRect;
    fMap: array of array of TSelState;
    fSelRects: array of TSelRect;
    fGrid: TCustomDrawGrid;
    fMouseActive: boolean;
    fStartValue: TSelState;
    fUseObjects: boolean;
    fOldRowSelect: PBoolean;
    fKeySelectionActive: boolean;
    fDragStarted: boolean;
    // grid backup events
    fGridMouseDown, fGridMouseUp: TMouseEvent;
    fGridMouseMove: TMouseMoveEvent;
    fGridPrepareCanvas: TOnPrepareCanvasEvent;
    fGridOnColRowExchanged: TGridOperationEvent;
    fGridOnColRowDeleted: TGridOperationEvent;
    fGridOnColRowInserted: TGridOperationEvent;
    fGridOnColRowMoved: TGridOperationEvent;
    fGridOnKeyDown, fGridOnKeyUp: TKeyEvent;
    fGridOnSelection, fGridOnBeforeSelection: TOnSelectEvent;
    fGridOnStartDrag: TStartDragEvent;
    function GetRowSelection(aRow: Integer): TSelState;
    function GetSelection(aCol, aRow: Integer): TSelState;
    procedure SelectRange;
    procedure SetRowSelection(aRow: Integer; AValue: TSelState);
    procedure SetSelection(aCol, aRow: Integer; AValue: TSelState);
    function GetExpandedRange: TRect;
    procedure DoMouseDown(const aCol,aRow: Integer; const Shift: TShiftState);
    procedure DoMouseMoved(const aCol,aRow: Integer; Inicio: boolean);
    procedure Select(aRect: TRect; aValue: TSelState);
    procedure SelRectsAdd(aSelRect: TSelRect);
    procedure SelRectsClear;
    procedure UpdateGridOptions;
    procedure UpdateGridSize(withClear:boolean=true);
  public
    constructor create(aGrid: TCustomDrawGrid; Options: TGridSelectionOptions);
    destructor Destroy; override;
    procedure Clear;
    procedure Dump;
    procedure Update;
    function IsCellSelected(aCol, aRow: Integer): boolean;

    procedure ColRowExchanged(Sender: TObject; IsColumn: Boolean; sIndex, tIndex: Integer);
    procedure ColRowDeleted(Sender: TObject; IsColumn: Boolean; sIndex, tIndex: Integer);
    procedure ColRowInserted(Sender: TObject; IsColumn: Boolean; sIndex, tIndex: Integer);
    procedure ColRowMoved(Sender: TObject; IsColumn: Boolean; sIndex, tIndex: Integer);
    procedure PrepareCanvas(Sender: TObject; aCol, aRow: Integer; aState: TGridDrawState);
    procedure MouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure MouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure MouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure KeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure OnBeforeSelection(Sender: TObject; aCol, aRow: Integer);
    procedure OnSelection(Sender: TObject; aCol, aRow: Integer);
    procedure OnStartDrag(Sender: TObject; var DragObject: TDragObject);

    property Selection[aCol, aRow: Integer]: TSelState read GetSelection write SetSelection; default;
    property RowSelection[aRow: Integer]: TSelState read GetRowSelection write SetRowSelection;
    property Active: boolean read fMouseActive;
    property Enabled: boolean read fEnabled write fEnabled;
  end;

const
  gsoGrabAll: TGridSelectionOptions = [
    gsoGrabMouseMove,
    gsoGrabMouseDown,
    gsoGrabMouseUp,
    gsoGrabKeyboard,
    gsoGrabPrepareCanvas,
    gsoGrabColRowExchanged,
    gsoGrabColRowDeleted,
    gsoGrabColRowInserted,
    gsoGrabColRowMoved];

implementation

type
  TGridAccess=class(TCustomDrawGrid)
  end;

const
  MULTISEL_MODIFIER = {$IFDEF Darwin}ssMeta{$ELSE}ssCtrl{$ENDIF};


function NormRect(const R: TRect): TRect; overload;
begin
  if R.Left<=R.Right then begin
    result.Left := R.Left;
    result.Right := R.Right;
  end else begin
    result.Left := R.Right;
    result.Right := R.Left;
  end;
  if R.Top<=R.Bottom then begin
    result.Top := R.Top;
    result.Bottom := R.Bottom;
  end else begin
    result.Top := R.Bottom;
    result.Bottom := R.Top;
  end;
end;

function CellInRange(const aCol, aRow: Integer; const Range: TRect): boolean;
begin
  with Range do
    result := (aCol>=Left) and (aCol<=Right) and (aRow>=Top) and (aRow<=Bottom);
end;

{ TGridSelection }

function TGridSelection.GetExpandedRange: TRect;
begin
  result := NormRect(fRange);
  if goRowSelect in fGrid.Options then begin
    result.Left := fGrid.FixedCols;
    result.Right := fGrid.ColCount-1;
  end;
end;

function TGridSelection.GetSelection(aCol, aRow: Integer): TSelState;
var
  PCell: PCellProps;
begin
  if fUseObjects then begin
    PCell := TGridAccess(fGrid).FGrid.Celda[aCol, aRow];
    if PCell=nil then
      result := SEL_UNSELECTED
    else
      result := TSelState(PtrInt(PCell^.Data));
  end else
    result := fMap[aRow, aCol];
end;

procedure TGridSelection.SelectRange;
var
  SelRect: TSelRect;
begin
  SelRect.Rect := GetExpandedRange;
  SelRect.SelValue := fStartValue;
  SelRectsAdd(SelRect);

  Select(SelRect.Rect, fStartValue);
end;

procedure TGridSelection.OnSelection(Sender: TObject; aCol, aRow: Integer);
begin
  if Assigned(FGridOnSelection) then
    fGridOnSelection(Sender, aCol, aRow);

  if fKeySelectionActive then begin
    Clear; // TODO: optimize this should only unselect previously selected areas
           //       if previous action was keyboard then clear old fGrid.Selection
    Select(fGrid.Selection, SEL_SELECTED);
  end;
end;

procedure TGridSelection.OnBeforeSelection(Sender: TObject; aCol, aRow: Integer);
begin
  if Assigned(FGridOnBeforeSelection) then
    fGridOnBeforeSelection(Sender, aCol, aRow);
end;

procedure TGridSelection.OnStartDrag(Sender: TObject;
  var DragObject: TDragObject);
begin
  if Assigned(fGridOnStartDrag) then
    fGridOnStartDrag(Sender, DragObject);

  fDragStarted := true;
end;

function TGridSelection.GetRowSelection(aRow: Integer): TSelState;
var
  aCol: Integer;
begin
  for aCol:=fGrid.FixedCols to fGrid.ColCount-1 do begin
    result := GetSelection(aCol, aRow);
    if result=SEL_SELECTED then
      exit;
  end;
  result := SEL_UNSELECTED;
end;

procedure TGridSelection.SetRowSelection(aRow: Integer; AValue: TSelState);
var
  aCol: Integer;
begin
  for aCol:=fGrid.FixedCols to fGrid.ColCount-1 do
    SetSelection(aCol, aRow, AValue);
end;

procedure TGridSelection.SetSelection(aCol, aRow: Integer; AValue: TSelState);
var
  PCell: PCellProps;
begin
  if fUseObjects then begin
    PCell := TGridAccess(fGrid).FGrid.Celda[aCol, aRow];
    if PCell<>nil then
      PCell^.Data:=TObject(PtrInt(AValue))
    else
    if AValue=SEL_SELECTED then begin
      PCell:=TGridAccess(fGrid).FGrid.GetDefaultCell;
      PCell^.Data:=TObject(PtrInt(AValue));
      TGridAccess(fGrid).FGrid.Celda[aCol, aRow]:=PCell;
    end;
  end
  else
    fMap[aRow, aCol] := AValue;
end;

procedure TGridSelection.ColRowExchanged(Sender: TObject; IsColumn: Boolean;
  sIndex, tIndex: Integer);
var
  i: Integer;
  Value: TSelState;
begin
  if Assigned(fGridOnColRowExchanged) then
     fGridOnColRowExchanged(Sender, IsColumn, sIndex, tIndex);

  if not fEnabled then
    exit;

  if IsColumn then
    for i:=0 to fGrid.RowCount-1 do begin
      Value := fMap[i, tIndex];
      fMap[i, tIndex] := fMap[i, sIndex];
      fMap[i, sIndex] := Value;
    end
  else
    for i:=0 to fGrid.ColCount-1 do begin
      Value := fMap[tIndex, i];
      fMap[tIndex, i] := fMap[sIndex, i];
      fMap[sIndex, i] := Value;
    end;
end;

procedure TGridSelection.ColRowDeleted(Sender: TObject; IsColumn: Boolean;
  sIndex, tIndex: Integer);
var
  aCol, aRow: Integer;
begin
  if Assigned(fGridOnColRowDeleted) then
     fGridOnColRowDeleted(Sender, IsColumn, sIndex, tIndex);

  if not fEnabled then
    exit;

  //DebugLn('ColRowDeleted: IsColumn=%s sIndex=%d tIndex=%d', [dbgs(IsColumn), sIndex, tIndex]);

  if IsColumn then
    for aCol:=sIndex to fGrid.ColCount-2 do begin
      for aRow := 0 to fGrid.RowCount-1 do
        fMap[aRow, aCol] := fMap[aRow, aCol+1];
    end
  else
    for aRow:=sIndex to fGrid.RowCount-2 do begin
      for aCol := 0 to fGrid.ColCount-1 do
        fMap[aRow,aCol] := fMap[aRow+1, aCol];
    end;

  UpdateGridSize(false);
end;

procedure TGridSelection.ColRowInserted(Sender: TObject; IsColumn: Boolean;
  sIndex, tIndex: Integer);
var
  aCol, aRow: Integer;
begin
  if Assigned(fGridOnColRowInserted) then
     fGridOnColRowInserted(Sender, IsColumn, sIndex, tIndex);

  if not fEnabled then
    exit;

  //DebugLn('ColRowInserted: IsColumn=%s sIndex=%d tIndex=%d', [dbgs(IsColumn), sIndex, tIndex]);

  UpdateGridSize(false);
  if IsColumn then begin
    for aCol := fGrid.ColCount-1 downto sIndex+1 do begin
      for aRow := 0 to fGrid.RowCount-1 do
        fMap[aRow, aCol] := fMap[aRow, aCol-1];
    end;
    for aRow := 0 to fGrid.RowCount-1 do
      fMap[aRow, sIndex] := SEL_UNSELECTED;
  end else begin
    for aRow := fGrid.RowCount-1 downto sIndex+1 do begin
      for aCol := 0 to fGrid.ColCount-1 do
        fMap[aRow, aCol] := fMap[aRow-1, aCol];
    end;
    for aCol := 0 to fGrid.ColCount-1 do
      fMap[sIndex, aCol] := SEL_UNSELECTED;
  end;
end;

procedure TGridSelection.ColRowMoved(Sender: TObject; IsColumn: Boolean;
  sIndex, tIndex: Integer);
var
  aCol, aRow: Integer;
  Value: TSelState;
begin

  if Assigned(fGridOnColRowMoved) then
     fGridOnColRowMoved(Sender, IsColumn, sIndex, tIndex);

  if not fEnabled then
    exit;

  //DebugLn('ColRowMoved: IsColumn=%s sIndex=%d tIndex=%d', [dbgs(IsColumn), sIndex, tIndex]);

  if IsColumn then
    for aRow := 0 to fGrid.RowCount-1 do begin
      Value := fMap[aRow, sIndex];
      if tIndex>sIndex then
        for aCol := sIndex+1 to tIndex do
          fMap[aRow, aCol-1] := fMap[aRow, aCol]
      else
        for aCol := sIndex-1 downto tIndex do
          fMap[aRow, aCol+1] := fMap[aRow, aCol];
      fMap[aRow, tIndex] := Value;
    end
  else
    for aCol := 0 to fGrid.ColCount-1 do begin
      Value := fMap[sIndex, aCol];
      if tIndex>sIndex then
        for aRow := sIndex+1 to tIndex do
          fMap[aRow-1, aCol] := fMap[aRow, aCol]
      else
        for aRow := sIndex-1 downto tIndex do
          fMap[aRow+1, aCol] := fMap[aRow, aCol];
      fMap[tIndex, aCol] := Value;
    end;
end;



constructor TGridSelection.create(aGrid: TCustomDrawGrid;
  Options: TGridSelectionOptions);
begin
  inherited Create;

  fGrid := aGrid;
  fUseObjects := gsoUseObjectsArray in Options;
  fEnabled := true;

  FGridOnSelection := fGrid.OnSelection;
  fGrid.OnSelection := @OnSelection;
  fGridOnBeforeSelection := fGrid.OnBeforeSelection;
  fGrid.OnBeforeSelection := @OnBeforeSelection;
  fGridOnStartDrag := fGrid.OnStartDrag;
  fGrid.OnStartDrag := @OnStartDrag;

  if not (gsoUseSelection in Options) then begin
    if gsoGrabMouseDown in Options then begin
      fGridMouseDown := fGrid.OnMouseDown;
      fGrid.OnMouseDown := @MouseDown;
    end;
    if gsoGrabMouseMove in Options then begin
      fGridMouseMove := fGrid.OnMouseMove;
      fGrid.OnMouseMove := @MouseMove;
    end;
    if gsoGrabMouseUp in Options then begin
      fGridMouseUp := fGrid.OnMouseUp;
      fGrid.OnMouseUp := @MouseUp;
    end;
    if gsoGrabKeyboard in Options then begin
      fGridOnKeyDown := fGrid.OnKeyDown;
      fGrid.OnKeyDown := @KeyDown;
      fGridOnKeyUp := fGrid.OnKeyUp;
      fGrid.OnKeyUp := @KeyUp;
    end;
  end;

  if gsoGrabPrepareCanvas in Options then begin
    fGridPrepareCanvas := fGrid.OnPrepareCanvas;
    fGrid.OnPrepareCanvas := @PrepareCanvas;
  end;

  if not fUseObjects then begin
    if gsoGrabColRowExchanged in Options then begin
      fGridOnColRowExchanged := fgrid.OnColRowExchanged;
      fGrid.OnColRowExchanged := @ColRowExchanged;
    end;
    if gsoGrabColRowDeleted in Options then begin
      fGridOnColRowDeleted := fGrid.OnColRowDeleted;
      fGrid.OnColRowDeleted := @ColRowDeleted;
    end;
    if gsoGrabColRowInserted in Options then begin
      fGridOnColRowInserted := fGrid.OnColRowInserted;
      fGrid.OnColRowInserted := @ColRowInserted;
    end;
    if gsoGrabColRowMoved in Options then begin
      fGridOnColRowMoved := fGrid.OnColRowMoved;
      fGrid.OnColRowMoved := @ColRowMoved;
    end;
  end;

  UpdateGridSize(true);
  UpdateGridOptions;
end;

destructor TGridSelection.Destroy;
begin
  SelRectsClear;
  if fOldRowSelect<>nil then
    Dispose(fOldRowSelect);
  SetLength(fMap, 0, 0);
  inherited Destroy;
end;

procedure TGridSelection.Clear;
begin
  Select(Rect(0, 0, fGrid.ColCount-1, fGrid.RowCount-1), SEL_UNSELECTED);
  SelRectsClear;
end;

procedure TGridSelection.Dump;
var
  i,j: Integer;
begin
  DebugLn('Selected Cells:');
  for j:=0 to fGrid.RowCount-1 do begin
    DbgOut('Row %d: ',[j]);
    for i:=0 to fGrid.ColCount-1 do
      DbgOut('%d ',[Selection[i,j]]);
    DebugLn;
  end;

  DebugLn('SelRects: %d',[length(fSelRects)]);
  if length(fSelRects)>0 then begin
    for i:=0 to length(fSelRects)-1 do
      DebugLn('%d %s sel=%d',[i, dbgs(fSelRects[i].Rect), fSelRects[i].SelValue]);
  end;
end;

procedure TGridSelection.Update;
begin
  if fOldRowSelect<>nil then begin
    Dispose(fOldRowSelect);
    fOldRowSelect := nil;
  end;
  UpdateGridSize(true);
  UpdateGridOptions;
end;

function TGridSelection.IsCellSelected(aCol, aRow: Integer): boolean;
begin
  result := Selection[aCol, aRow] <> SEL_UNSELECTED;
end;

// Should be called manually in case some grid options had changed
procedure TGridSelection.UpdateGridOptions;
begin
  if TGridAccess(fGrid).FixedGrid then
    exit;
  if (fOldRowSelect=nil) or (fOldRowSelect^ <> (goRowSelect in fGrid.Options)) then begin
    Clear;
    fRange := Rect(fGrid.Col, fGrid.Row, fGrid.Col, fGrid.Row);
    fStartValue := SEL_SELECTED;
    SelectRange;

    if (fOldRowSelect=nil) then
      New(fOldRowSelect);
    fOldRowSelect^ := (goRowSelect in fGrid.Options);
  end;
end;

procedure TGridSelection.Select(aRect: TRect; aValue: TSelState);
var
  i,j: Integer;
begin
  for i:=aRect.top to aRect.Bottom do
    for j:=aRect.Left to aRect.Right do
      Selection[j, i] := AValue
end;

procedure TGridSelection.SelRectsAdd(aSelRect: TSelRect);
var
  i: Integer;
begin
  i := Length(fSelRects);
  SetLength(fSelRects, i+1);
  fSelRects[i] := aSelRect;
end;

procedure TGridSelection.SelRectsClear;
begin
  SetLength(fSelRects, 0);
end;

// called manually in case grid dimesions had changed
// if col/row "grab" options are specified, this is called automatically
procedure TGridSelection.UpdateGridSize(withClear: boolean);
var
  oldCols,oldRows: Integer;
begin
  if not fUseObjects then begin
    oldRows := Length(fMap);
    if oldRows>0 then
      oldCols := Length(fMap[0])
    else
      oldCols := 0;
    if (oldRows<>fGrid.RowCount) or (oldCols<>fGrid.ColCount) then
      SetLength(fMap, fGrid.RowCount, fGrid.ColCount);
    if withClear then
      Clear;
  end;
end;

procedure TGridSelection.DoMouseDown(const aCol, aRow: Integer;
  const Shift: TShiftState);
begin
  fMouseActive := true;
  if MULTISEL_MODIFIER in Shift then begin
    if Selection[aCol, aRow]<>SEL_UNSELECTED then
      fStartValue := SEL_UNSELECTED
    else
      fStartValue := SEL_SELECTED;
  end else
    fStartValue := SEL_SELECTED;

  if ssShift in Shift then begin
    fRange.TopLeft := Point(fGrid.Col, fGrid.Row);
  end else
    fRange.TopLeft := Point(aCol, aRow);

  if not (MULTISEL_MODIFIER in Shift) then begin
    fRange.BottomRight := Point(aCol, aRow);
    Clear;
    fGrid.Invalidate;
  end else begin
    fRange.BottomRight := Point(-1, -1);
    DoMouseMoved(aCol, aRow, true);
  end;
end;

procedure TGridSelection.DoMouseMoved(const aCol, aRow: Integer; Inicio: boolean);
begin
  if (aCol<>fRange.Right) or (aRow<>fRange.Bottom) then begin
    if not Inicio then
      fGrid.InvalidateRange(GetExpandedRange);
    fRange.Right := aCol;
    fRange.Bottom := aRow;
    fGrid.InvalidateRange(GetExpandedRange);
  end;
end;

procedure TGridSelection.PrepareCanvas(Sender: TObject; aCol, aRow: Integer;
  aState: TGridDrawState);
var
  altColor, defColor: TColor;
begin
  if Assigned(fGridPrepareCanvas) then
     fGridPrepareCanvas(Sender, aCol, aRow, aState);

  if not fEnabled then
    exit;

  if (aCol>=fGrid.FixedCols) and (aRow>=fGrid.FixedRows) then begin

    if [gdSelected,gdFocused]*aState<>[] then begin
      // override the focused/selected color with the color it would be
      // if this cell were not focused/selected
      defColor := fGrid.Color;
      altColor := TGridAccess(fGrid).AlternateColor;
      if (altColor<>defColor) then begin
        defColor := TGridAccess(fGrid).GetColumnColor(aCol, false);
        if defColor=fGrid.Color then begin
          if (fGrid.AltColorStartNormal and Odd(aRow-fGrid.FixedRows)) or
             (not fGrid.AltColorStartNormal and Odd(ARow)) then
              defColor := altColor;
        end;
      end;
      fGrid.Canvas.Brush.Color := defColor;
    end;
    defColor := fGrid.Canvas.Brush.Color;

    if Selection[aCol, aRow] <> SEL_UNSELECTED then
      fGrid.Canvas.Brush.Color := fGrid.SelectedColor;

    if fMouseActive then begin
      // mouse selection layer has bigger priority
      if CellInRange(aCol, aRow, GetExpandedRange) then begin
        if fStartValue=SEL_UNSELECTED then
          fGrid.Canvas.Brush.Color := defColor
        else
          fGrid.Canvas.Brush.Color := fGrid.SelectedColor;
      end;
    end;

  end;
end;

procedure TGridSelection.MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  aCol, aRow: Integer;
  PForm: TCustomForm;
begin
  fDragStarted := false;

  if Assigned(fGridMouseDown) then
     fGridMouseDown(Sender, Button, Shift, X, Y);

  if fEnabled and (Button=mbLeft) then begin

    PForm := GetParentForm(fGrid);
    if not PForm.Active then
      exit; // do not unintentionally select something
    if not fGrid.Focused then
      fGrid.SetFocus;

    fGrid.MouseToCell(X, Y, aCol, aRow);
    if (aCol>=fGrid.FixedCols) and (aRow>=fGrid.FixedRows) then begin
      doMouseDown(aCol, aRow, Shift);
    end;
  end;

end;

procedure TGridSelection.MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
var
  aCol, aRow: Longint;
begin
  if assigned(fGridMouseMove) then
     fGridMouseMove(Sender, Shift, X, Y);

  if fEnabled and fMouseActive and not fDragStarted then begin
    fGrid.MouseToCell(X, Y, aCol, aRow);
    if (aCol>=fGrid.FixedCols) and (aRow>=fGrid.FixedRows) then
      doMouseMoved(aCol, aRow, false);
  end;
end;

procedure TGridSelection.MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if Assigned(fGridMouseUp) then
    fGridMouseUp(Self, Button, Shift, X, Y);

  if fEnabled and fMouseActive then begin
    SelectRange;
    fMouseActive := false;
  end;
end;

procedure TGridSelection.KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Assigned(fGridOnKeyDown) then
    fGridOnKeyDown(Sender, Key, Shift);

  if not fEnabled then
     exit;

  if Key in [VK_LEFT, VK_RIGHT, VK_UP, VK_DOWN, VK_PRIOR, VK_NEXT, VK_HOME, VK_END] then begin
    if not fKeySelectionActive then begin
      fKeySelectionActive := true;
      fMouseActive := false;
    end;
  end;
end;

procedure TGridSelection.KeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if fKeySelectionActive then begin
    fKeySelectionActive := false;
  end;
end;

end.

