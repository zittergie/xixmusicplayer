unit fillincd;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  MaskEdit, Buttons;

type

  { TFormFillInCD }

  TFormFillInCD = class(TForm)
    ComboBox1: TComboBox;
    Edit1: TEdit;
    Label1: TLabel;
    MaskEdit1: TMaskEdit;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    procedure Edit1EditingDone(Sender: TObject);
    procedure Edit1KeyPress(Sender: TObject; var Key: char);
    procedure MaskEdit1KeyPress(Sender: TObject; var Key: char);
    procedure SpeedButton1Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  FormFillInCD: TFormFillInCD;

implementation

uses Hoofd, ripcd;

{$R *.lfm}

{ TFormFillInCD }

procedure TFormFillInCD.SpeedButton1Click(Sender: TObject);
begin
  Close;
end;

procedure TFormFillInCD.Edit1EditingDone(Sender: TObject);
begin
end;

procedure TFormFillInCD.Edit1KeyPress(Sender: TObject; var Key: char);
begin
  if key=#13 then Speedbutton2Click(Self);
end;

procedure TFormFillInCD.MaskEdit1KeyPress(Sender: TObject; var Key: char);
begin
  if key=#13 then Speedbutton2Click(Self);
end;

procedure TFormFillInCD.SpeedButton2Click(Sender: TObject);
var I: byte;
begin
  if label1.Caption='Artist:' then
  begin
    for i :=1 to Form1.StringGridCD.RowCount-1 do
    begin
      Form1.StringGridCD.Cells[1,i]:=Edit1.Text;
      FormRip.Stringgrid1.Cells[2,i]:=Edit1.Text;
      FormRip.LB_Artist.Caption:=Edit1.Text;
    end;
  end;
  if label1.Caption='Album:' then
  begin
    for i :=1 to Form1.StringGridCD.RowCount-1 do
    begin
      Form1.StringGridCD.Cells[3,i]:=Edit1.Text;
      FormRip.StringGrid1.Cells[4,i]:=Edit1.Text;
      FormRip.LB_Album.Caption:=Edit1.Text;
    end;
  end;
  if label1.Caption='Year:' then
  begin
    for i :=1 to Form1.StringGridCD.RowCount-1 do
    begin
      if Form1.IsNumber(MaskEdit1.EditText) then Form1.StringGridCD.Cells[5,i]:=MaskEdit1.Text
                                            else Form1.StringGridCD.Cells[5,i]:='';
      FormRip.StringGrid1.Cells[5,i]:=Form1.StringGridCD.Cells[5,i];
      FormRip.LB_Year.Caption:=Form1.StringGridCD.Cells[5,i];
    end;
  end;
  if label1.Caption='Genre:' then
  begin
    for i :=1 to Form1.StringGridCD.RowCount-1 do
    begin
      Form1.StringGridCD.Cells[6,i]:=Combobox1.Text;
      FormRip.StringGrid1.Cells[6,i]:=Combobox1.Text;
      FormRip.LB_Genre.Caption:=ComboBox1.Text;
    end;
  end;
  if label1.Caption='Composer:' then
  begin
    for i :=1 to FormRip.StringGrid1.RowCount-1 do
    begin
      FormRip.StringGrid1.Cells[7,i]:=Edit1.Text;
    end;
  end;
  if label1.Caption='Original Artist:' then
  begin
    for i :=1 to FormRip.StringGrid1.RowCount-1 do
    begin
      FormRip.StringGrid1.Cells[8,i]:=Edit1.Text;
    end;
  end;
   if label1.Caption='Copyright:' then
  begin
    for i :=1 to FormRip.StringGrid1.RowCount-1 do
    begin
      FormRip.StringGrid1.Cells[9,i]:=Edit1.Text;
    end;
  end;
  if label1.Caption='Comment:' then
  begin
    for i :=1 to FormRip.StringGrid1.RowCount-1 do
    begin
      FormRip.StringGrid1.Cells[10,i]:=Edit1.Text;
    end;
  end;
  close;
end;

end.

