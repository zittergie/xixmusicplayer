unit showmydialog;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, ExtCtrls, StdCtrls, CheckLst;

type

  { TFormShowMyDialog }

  TFormShowMyDialog = class(TForm)
    Bevel1: TBevel;
    CheckListBox1: TCheckListBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Panel1: TPanel;
    function ShowWith(c1, l1,l2,l3,b1,b2: string; ShowListBox: Boolean): Boolean; overload;
    function ShowWith(c1, l1,l2,l3: string; Btns:array of const; ShowListBox: Boolean): TModalResult; overload;
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  FormShowMyDialog: TFormShowMyDialog;

implementation

{$R *.lfm}

{ TFormShowMyDialog }
function TFormShowMyDialog.ShowWith(c1, l1, l2, l3, b1, b2: string; ShowListBox: Boolean): Boolean;
var
  mr: Integer;
begin
  result := ShowWith(c1, l1, l2, l3, [mrYes, b1, mrNo, b2], ShowListBox)=mrYes;
end;

function TFormShowMyDialog.ShowWith(c1, l1, l2, l3: string; Btns: array of const; ShowListBox: Boolean): TModalResult;
var
  n, spc, aValue: Integer;
  btn,defBtn,selBtn : TButton;
  i: Integer;
  aCaption: string;

  function GetStr(mustExist: boolean): string;
  begin
    case Btns[i].VType of
      vtString: result := Btns[i].VString^;
      vtAnsiString: result := ansistring(Btns[i].VAnsiString);
      vtWideString: result := ansistring(widestring(Btns[i].VWideString));
      else
        begin
          if mustExist then
            raise Exception.CreateFmt('A string was expected at position %d in Btns array',[i])
          else
            result := '';
        end;
    end;
  end;

begin

  if Length(Btns)=0 then
    raise Exception.Create('There are no items in Btns array');

  while Panel1.ControlCount>0 do
    Panel1.Controls[Panel1.ControlCount-1].Free;

  Caption:=c1;
  label1.Caption:=l1;
  label2.Caption:=l2;
  label3.Caption:=l3;

  If ShowListBox then Height:=460
                 else begin
                         CheckListBox1.Clear;
                         Height:=122;
                      end;

  defBtn := nil;
  selBtn := nil;
  n := 0;
  i := low(Btns);
  while (i<high(Btns)) do
  begin
    if Btns[i].VType <> vtInteger then
      raise Exception.CreateFmt('A integer was expected at position %d in Btns array',[i]);
    aValue := Btns[i].VInteger;
    inc(i);
    ACaption := GetStr(true);
    //
    if length(ACaption)>0 then
    begin
      Btn := TButton.Create(Self);
      btn.Caption := aCaption;
      btn.ModalResult := aValue;
      btn.Parent := Panel1;
      inc(i);
    end;
    //
    if (i<=high(Btns)) and (Btns[i].VType in [vtString,vtAnsiString,vtWideString])then
    begin
      aCaption := lowercase(GetStr(false));
      if pos('isdefault', aCaption)>0 then
        defBtn := btn;
      if pos('isselected', aCaption)>0 then
        selBtn := btn;
      inc(i);
    end;
    inc(n);
  end;

  // if just one button, show it at the most extreme side of the dialog
  Panel1.BiDiMode := Application.BidiMode;
  case n of
    1: if Panel1.BiDiMode=bdLeftToRight then Panel1.BiDiMode := bdRightToLeft
                                        else Panel1.BiDiMode := bdLeftToRight;
    2: Panel1.ChildSizing.HorizontalSpacing := 200;
    3: Panel1.ChildSizing.HorizontalSpacing := 90;
    4: Panel1.ChildSizing.HorizontalSpacing := 45
    else Panel1.ChildSizing.HorizontalSpacing := 30;
  end;

  if defBtn<>nil then defBtn.Default := true;
  if selBtn<>nil then FormShowMyDialog.ActiveControl := selBtn;

  Result := FormShowMyDialog.ShowModal;
end;

end.

