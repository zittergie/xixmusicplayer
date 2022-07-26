unit filecheckingsettings;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  StdCtrls, Buttons, ComCtrls, Grids;

type

  { TFormFileCheckingSettings }

  TFormFileCheckingSettings = class(TForm)
    BitBtn1: TBitBtn;
    CheckBox1: TCheckBox;
    CheckBox2: TCheckBox;
    CheckBox3: TCheckBox;
    CheckBox4: TCheckBox;
    CheckBox5: TCheckBox;
    CheckBox6: TCheckBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    ListBox1: TListBox;
    ListBox2: TListBox;
    PageControl1: TPageControl;
    Panel1: TPanel;
    Panel2: TPanel;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    SpeedButton3: TSpeedButton;
    SpeedButton4: TSpeedButton;
    SpeedButton5: TSpeedButton;
    SpeedButton6: TSpeedButton;
    StringGrid1: TStringGrid;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
    procedure BitBtn1Click(Sender: TObject);
    procedure ListBox1Click(Sender: TObject);
    procedure ValueListEditor1Click(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  FormFileCheckingSettings: TFormFileCheckingSettings;

implementation

{$R *.lfm}

{ TFormFileCheckingSettings }

procedure TFormFileCheckingSettings.BitBtn1Click(Sender: TObject);
begin
  Close;
end;

procedure TFormFileCheckingSettings.ListBox1Click(Sender: TObject);
begin

end;

procedure TFormFileCheckingSettings.ValueListEditor1Click(Sender: TObject);
begin

end;

end.

