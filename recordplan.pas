(* TODO:  If a recurring recording is busy and the recording is abrupt ended (eg. No Power) then the scheduling
is not updated to the new recurring date, but is deleted *)

unit recordplan;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ComCtrls,
  Grids, StdCtrls, Buttons, ExtCtrls, ExtDlgs;

type

  { TFormPlanRecording }

  TFormPlanRecording = class(TForm)
    CalendarDialog1: TCalendarDialog;
    CB_Period1: TComboBox;
    CB_Recur1: TCheckBox;
    CheckBox1: TCheckBox;
    CheckBox2: TCheckBox;
    CB_Recur: TCheckBox;
    CB_CopyFolder: TCheckBox;
    CB_RenameFile: TCheckBox;
    CB_Overwrite: TCheckBox;
    CB_DeleteAfterCopy: TCheckBox;
    ComboBox1: TComboBox;
    ComboBox2: TComboBox;
    CB_Period: TComboBox;
    ComboBoxTemp: TComboBox;
    Edit_Copy: TEdit;
    Edit_Rename: TEdit;
    Label1: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    Label2: TLabel;
    Label20: TLabel;
    Label33: TLabel;
    Label34: TLabel;
    Label_Copy: TLabel;
    Label22: TLabel;
    Label_Rename: TLabel;
    Label24: TLabel;
    Label25: TLabel;
    Label26: TLabel;
    Label27: TLabel;
    Label28: TLabel;
    Label29: TLabel;
    Label3: TLabel;
    Label30: TLabel;
    Label31: TLabel;
    Label32: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    LabelH1: TLabel;
    LabelH2: TLabel;
    LabelH3: TLabel;
    LabelH4: TLabel;
    LabelM1: TLabel;
    LabelM2: TLabel;
    LabelM3: TLabel;
    LabelM4: TLabel;
    PageControl1: TPageControl;
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    Panel4: TPanel;
    Panel5: TPanel;
    Panel6: TPanel;
    Panel7: TPanel;
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    RadioButton3: TRadioButton;
    RadioButton4: TRadioButton;
    RadioButton5: TRadioButton;
    RadioButton6: TRadioButton;
    SelectDirectoryDialog1: TSelectDirectoryDialog;
    Shape1: TShape;
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
    TabSheet4: TTabSheet;
    UpDown1: TUpDown;
    UpDown2: TUpDown;
    UpDown3: TUpDown;
    UpDown4: TUpDown;
    UpDown5: TUpDown;
    UpDown6: TUpDown;
    UpDown7: TUpDown;
    UpDown8: TUpDown;
    procedure CB_CopyFolderChange(Sender: TObject);
    procedure ComboBox1Select(Sender: TObject);
    procedure ComboBox2Select(Sender: TObject);
    procedure Edit_RenameChange(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: boolean);
    procedure FormShow(Sender: TObject);
    procedure Label17Click(Sender: TObject);
    procedure Label4Click(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);
    procedure SpeedButton4Click(Sender: TObject);
    procedure SpeedButton5Click(Sender: TObject);
    procedure SpeedButton6Click(Sender: TObject);
    procedure StringGrid1Click(Sender: TObject);
    procedure StringGrid1DblClick(Sender: TObject);
    procedure TabSheet3Show(Sender: TObject);
    procedure UpDown1Click(Sender: TObject; Button: TUDBtnType);
    procedure UpDown2Click(Sender: TObject; Button: TUDBtnType);
    procedure UpDown3Click(Sender: TObject; Button: TUDBtnType);
    procedure UpDown4Click(Sender: TObject; Button: TUDBtnType);
    procedure UpDown5Click(Sender: TObject; Button: TUDBtnType);
    procedure UpDown6Click(Sender: TObject; Button: TUDBtnType);
    procedure UpDown7Click(Sender: TObject; Button: TUDBtnType);
    procedure UpDown8Click(Sender: TObject; Button: TUDBtnType);
    procedure SortSchedule;
    Function CreateScheduleFilename(lijn, RS: string): String;
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  FormPlanRecording: TFormPlanRecording;

implementation

uses hoofd, dateutils;

var
  waar: integer;

{$R *.lfm}

{ TFormPlanRecording }

procedure TFormPlanRecording.SpeedButton5Click(Sender: TObject);
var myDate : TDateTime;
begin
  If Stringgrid1.Row>0 then
  begin
    if Sender = Form1.TimerSchedule then
    begin
      if StringGrid1.Cells[6,1]='*' then
      begin
        ShortDateFormat:='YYYY.MM.DD';
        Stringgrid1.RowCount:=StringGrid1.RowCount+1;
        Stringgrid1.Rows[StringGrid1.RowCount-1]:=Stringgrid1.Rows[1];
        StringGrid1.Cells[5,StringGrid1.RowCount-1]:=Stringgrid1.Cells[8,1];
        mydate:=StrtoDate(StringGrid1.Cells[1,1],'.');
        inc(plannedrecordings);
        Case StringGrid1.Cells[7,1] of
          '0': begin
                 mydate:=incday(mydate,1);
                 StringGrid1.Cells[1,StringGrid1.RowCount-1]:=FormatDateTime('YYYY.MM.DD',mydate);
               end;
          '1': begin
                 mydate:=incday(mydate,7);
                 StringGrid1.Cells[1,StringGrid1.RowCount-1]:=FormatDateTime('YYYY.MM.DD',mydate);
               end;
          '2': begin
                 mydate:=incday(mydate,14);
                 StringGrid1.Cells[1,StringGrid1.RowCount-1]:=FormatDateTime('YYYY.MM.DD',mydate);
               end;
          '3': begin
                 mydate:=incday(mydate,21);
                 StringGrid1.Cells[1,StringGrid1.RowCount-1]:=FormatDateTime('YYYY.MM.DD',mydate);
               end;
          '4': begin
                 mydate:=incday(mydate,28);
                 StringGrid1.Cells[1,StringGrid1.RowCount-1]:=FormatDateTime('YYYY.MM.DD',mydate);
               end;
        end;
        StringGrid1.Row:=1;
      end;
    end;
    dec(plannedrecordings);
    Stringgrid1.DeleteRow(Stringgrid1.Row);
    Label1.Caption:=inttostr(plannedRecordings)+' '+Form1.Vertaal('recording(s) planned');
    if plannedrecordings > 0  then SortSchedule
                              else DeleteFile(ConfigDir+DirectorySeparator+'radio'+DirectorySeparator+'schedule');
    Form1.LabelRecordings.caption:=inttostr(plannedrecordings);
    Form1.LabelRecordings.Hint:=Label1.Caption;
    Stringgrid1Click(self);
  end;
end;

procedure TFormPlanRecording.SpeedButton6Click(Sender: TObject);
begin
  If SelectDirectoryDialog1.Execute then Edit_Copy.Text:=SelectDirectoryDialog1.FileName;
end;

procedure TFormPlanRecording.ComboBox2Select(Sender: TObject);
begin
  waar:=strtoint(ComboboxTemp.Items[ComBoBox2.ItemIndex]);
  Label14.Caption:=RadioStation[waar].naam;
  Label15.Caption:=RadioStation[waar].land;
end;

Function TFormPlanRecording.CreateScheduleFilename(lijn, RS: string): String;
var Jaar, Maand, Dag: String;
    Str_Maand, Str_Dag, BeginUur, EindUur  : String;
    Tempstring: String;
    mydate: TDateTime;
begin
  ShortDateFormat:='YYYY.MM.DD';
  if Stringgrid1.RowCount>1 then
  begin
    mydate:=StrtoDate(StringGrid1.Cells[1,1],'.');
    BeginUur:=StringGrid1.Cells[3,1];
    EindUur:=StringGrid1.Cells[4,1];
  end
                            else
  begin
    mydate:=now;
    BeginUur:='07.00';
    EindUur:='08.00';
  end;
  Jaar:=FormatDateTime('YYYY',mydate);
  Maand:=FormatDateTime('MM',mydate);
  dag:=FormatDateTime('DD',mydate);
  Str_Maand:=Form1.Vertaal(LongMonthNames[strtointdef(Maand,1)]);
  Str_Dag:=Form1.Vertaal(LongDayNames[DayOfWeek(mydate)]);
  TempString:=lijn;
  TempString:=StringReplace(TempString,'%Y',jaar,[rfReplaceAll]);
  TempString:=StringReplace(TempString,'%M',maand,[rfReplaceAll]);
  TempString:=StringReplace(TempString,'%D',dag,[rfReplaceAll]);
  TempString:=StringReplace(TempString,'%R',RS,[rfReplaceAll]);
  TempString:=StringReplace(TempString,'%d',Str_Dag,[rfReplaceAll]);
  TempString:=StringReplace(TempString,'%m',Str_Maand,[rfReplaceAll]);
  TempString:=StringReplace(TempString,'%h',BeginUur,[rfReplaceAll]);
  TempString:=StringReplace(TempString,'%H',EindUur,[rfReplaceAll]);
  CreateScheduleFilename:=Tempstring;
end;

procedure TFormPlanRecording.Edit_RenameChange(Sender: TObject);
begin
  Label32.Caption:=CreateScheduleFilename(Edit_Rename.Text, ComboBox1.Text)+'.mp3';
end;

procedure TFormPlanRecording.FormCloseQuery(Sender: TObject;
  var CanClose: boolean);
var Filevar: textfile;
    i: integer;
begin
  if not DirectoryExists(Edit_Copy.Text) then Edit_Copy.Text:=HomeDir;
  ScheduleSettings.CopyRec:=CB_CopyFolder.Checked;
  ScheduleSettings.RenameRec:=CB_RenameFile.Checked;
  ScheduleSettings.Overwrite:=CB_Overwrite.Checked;
  ScheduleSettings.CopyDir:=Edit_Copy.Text;
  ScheduleSettings.RenameFormat:=Edit_Rename.Text;
  ScheduleSettings.DeleteAfterCopy:=CB_DeleteAfterCopy.Checked;

  if plannedrecordings>0 then
  begin
    AssignFile(Filevar,ConfigDir+DirectorySeparator+'radio'+DirectorySeparator+'schedule');
    Rewrite(Filevar);
    for i:=1 to plannedrecordings do
      writeln(Filevar,Stringgrid1.Cells[0,i]+';'+Stringgrid1.Cells[1,i]+';'+Stringgrid1.Cells[3,i]+';'+Stringgrid1.Cells[4,i]+';'+Stringgrid1.Cells[5,i]+';'+Stringgrid1.Cells[6,i]+';'+Stringgrid1.Cells[7,i]+';'+Stringgrid1.Cells[8,i]);
    CloseFile(Filevar);
    Form1.TimerSchedule.Enabled:=True;
  end
  else
  begin
    DeleteFile(ConfigDir+DirectorySeparator+'radio'+DirectorySeparator+'schedule');
    if schedulehasstarted then Form1.TimerSchedule.Enabled:=False;
  end;
end;

procedure TFormPlanRecording.ComboBox1Select(Sender: TObject);
begin
  waar:=strtoint(ComboboxTemp.Items[ComBoBox1.ItemIndex]);
  Label10.Caption:=RadioStation[waar].naam;
  Label11.Caption:=RadioStation[waar].land;
end;

procedure TFormPlanRecording.CB_CopyFolderChange(Sender: TObject);
begin
  CB_RenameFile.Enabled:=CB_CopyFolder.Checked; Label_Rename.Enabled:=CB_CopyFolder.Checked;;
  CB_Overwrite.Enabled:=CB_CopyFolder.Checked; Edit_Rename.Enabled:=CB_CopyFolder.Checked;
  CB_DeleteAfterCopy.Enabled:=CB_CopyFolder.Checked;
end;

procedure TFormPlanRecording.FormShow(Sender: TObject);
var I: integer;
begin
  FormPlanRecording.Caption:=Form1.Vertaal('Schedule');
  TabSheet1.Caption:=Form1.Vertaal('Overview');
  Tabsheet2.Caption:=Form1.Vertaal('Add Recording');
  Tabsheet3.Caption:=Form1.Vertaal('Modify Recording');
  Tabsheet4.Caption:=Form1.Vertaal('Settings');
  Stringgrid1.Cells[1,0]:=Form1.Vertaal('Date');
  Stringgrid1.Cells[2,0]:=Form1.Vertaal('Station');
  Stringgrid1.Cells[3,0]:=Form1.Vertaal('From');
  Stringgrid1.Cells[4,0]:=Form1.Vertaal('Until');
  Stringgrid1.Cells[5,0]:=Form1.Vertaal('Mode');
  Label2.Caption:=Form1.Vertaal('Radiostation')+':';
  Label12.Caption:=Form1.Vertaal('Radiostation')+':';
  Label3.Caption:=Form1.Vertaal('Date')+':';
  Label16.Caption:=Form1.Vertaal('Date')+':';
  Label5.Caption:=Form1.Vertaal('from');
  Label18.Caption:=Form1.Vertaal('from');
  Label22.Caption:=Form1.Vertaal('to');
  Label7.Caption:=Form1.Vertaal('to');
  RadioButton1.Caption:=Form1.Vertaal('Record');
  RadioButton4.Caption:=Form1.Vertaal('Record');
  RadioButton2.Caption:=Form1.Vertaal('Warning');
  RadioButton5.Caption:=Form1.Vertaal('Warning');
  RadioButton3.Caption:=Form1.Vertaal('Listen');
  RadioButton6.Caption:=Form1.Vertaal('Listen');
  Speedbutton2.Caption:=Form1.Vertaal('Cancel');
  Speedbutton4.Caption:=Form1.Vertaal('Cancel');
  Speedbutton1.Caption:=Form1.Vertaal('Add');
  Speedbutton3.Caption:=Form1.Vertaal('Update');

  Combobox1.Items.Clear; ComboBoxTemp.Items.Clear; Label4.Caption:=FormatDateTime('YYYY.MM.DD',now);
  if plannedrecordings>0 then Label1.Caption:=inttostr(plannedRecordings)+' '+Form1.Vertaal('recording(s) planned');
  for i:=1 to 2200 do if length(RadioStation[i].naam)>1 then
  begin
    Combobox1.Items.Add(RadioStation[i].naam);
    ComboboxTemp.Items.Add(RadioStation[i].internalnr);
  end;
  Combobox2.Items:=Combobox1.Items;
  Combobox1.ItemIndex:=ComboboxTemp.Items.IndexOf(Form1.StringgridRadioair.Cells[0,Form1.StringgridRadioair.row]);
  ComboBox1Select(self);
  Stringgrid1.AutoSizeColumns;
  If Stringgrid1.RowCount>1 then
  begin
    Stringgrid1.Row:=1;
    StringGrid1Click(Self);
  end;
  Edit_RenameChange(Self);
end;

procedure TFormPlanRecording.Label17Click(Sender: TObject);
begin
  if CalendarDialog1.Execute then Label17.Caption:=FormatDateTime('YYYY.MM.DD',calendardialog1.Date);
end;

procedure TFormPlanRecording.Label4Click(Sender: TObject);
begin
  CalendarDialog1.Date:=Now;
  if CalendarDialog1.Execute then Label4.Caption:=FormatDateTime('YYYY.MM.DD',calendardialog1.Date);
end;

procedure TFormPlanRecording.SpeedButton1Click(Sender: TObject);
var tijd1: string;
    verg_tijd, now_tijd: real;
begin
  //Nog controleren op conflicterende plannen

  tijd1:=label4.caption; Delete(tijd1,5,1); Delete(tijd1,7,1);
  tijd1:=tijd1+LabelH1.Caption+LabelM1.Caption;
  verg_tijd:=strtofloat(tijd1)-1;

  tijd1:=FormatDateTime('YYYYMMDDhhnn',now);
  now_tijd:=strtofloat(tijd1);

  if verg_tijd<now_tijd then
  begin
    Showmessage(Form1.Vertaal('Entered time is in the past.  Please check time.'));
    exit;
  end;

  if schedulehasstarted then
  begin
    if verg_tijd<endrecording then
    begin
      Showmessage(Form1.Vertaal('This recording would create a conflict with the recording that is busy. (You will need to select a different time)'));
      exit;
    end;
  end;

  inc(plannedRecordings);
  Stringgrid1.RowCount:=plannedRecordings+1;
  Stringgrid1.Cells[0,plannedrecordings]:=ComboboxTemp.Items[Combobox1.ItemIndex];
  Stringgrid1.Cells[1,plannedrecordings]:=Label4.Caption;
  Stringgrid1.Cells[2,plannedrecordings]:=Label10.Caption;
  Stringgrid1.Cells[3,plannedrecordings]:=LabelH1.Caption+'.'+LabelM1.Caption;
  Stringgrid1.Cells[4,plannedrecordings]:=LabelH2.Caption+'.'+LabelM2.Caption;
  if RadioButton1.Checked then Stringgrid1.Cells[5,plannedrecordings]:='0';
  if RadioButton2.Checked then Stringgrid1.Cells[5,plannedrecordings]:='1';
  if RadioButton3.Checked then Stringgrid1.Cells[5,plannedrecordings]:='2';
  if CB_Recur.Checked then Stringgrid1.Cells[6,plannedrecordings]:='*'
                      else Stringgrid1.Cells[6,plannedrecordings]:='';
  Stringgrid1.Cells[7,plannedrecordings]:=inttostr(CB_Period.ItemIndex);
  Stringgrid1.Cells[8,plannedrecordings]:=Stringgrid1.Cells[5,plannedrecordings];

  Stringgrid1.AutoSizeColumns; Stringgrid1.Row:=plannedrecordings;
  Label1.Caption:=inttostr(plannedRecordings)+' '+Form1.Vertaal('recording(s) planned');
  PageControl1.ActivePageIndex:=0;
  Stringgrid1Click(Self);
  SortSchedule;
end;

procedure TFormPlanRecording.SpeedButton2Click(Sender: TObject);
begin
  PageControl1.ActivePageIndex:=0;
end;

procedure TFormPlanRecording.SpeedButton3Click(Sender: TObject);
begin
  If stringgrid1.Row>0 then
  begin
    if RadioButton4.Checked then Stringgrid1.Cells[5,Stringgrid1.Row]:='0';
    if RadioButton5.Checked then Stringgrid1.Cells[5,Stringgrid1.Row]:='1';
    if RadioButton6.Checked then Stringgrid1.Cells[5,Stringgrid1.Row]:='2';
    Stringgrid1.Cells[0,Stringgrid1.Row]:=ComboboxTemp.Items[Combobox2.ItemIndex];
    Stringgrid1.Cells[1,Stringgrid1.Row]:=Label17.Caption;
    Stringgrid1.Cells[2,Stringgrid1.Row]:=Label14.Caption;
    Stringgrid1.Cells[3,Stringgrid1.Row]:=LabelH3.Caption+'.'+LabelM3.Caption;
    Stringgrid1.Cells[4,Stringgrid1.Row]:=LabelH4.Caption+'.'+LabelM4.Caption;
    if CB_Recur1.Checked then Stringgrid1.Cells[6,Stringgrid1.Row]:='*'
                         else Stringgrid1.Cells[6,Stringgrid1.Row]:='';
    Stringgrid1.Cells[7,Stringgrid1.Row]:=inttostr(CB_Period.ItemIndex);
    if RadioButton4.Checked then Stringgrid1.Cells[8,Stringgrid1.Row]:='0';
    if RadioButton5.Checked then Stringgrid1.Cells[8,Stringgrid1.Row]:='1';
    if RadioButton6.Checked then Stringgrid1.Cells[8,Stringgrid1.Row]:='2';
    Stringgrid1.AutoSizeColumns;
  end;
  PageControl1.ActivePageIndex:=0;
  SortSchedule;
end;

procedure TFormPlanRecording.SpeedButton4Click(Sender: TObject);
begin
  Stringgrid1Click(Self);
  PageControl1.ActivePageIndex:=0;
end;

procedure TFormPlanRecording.SortSchedule;
var i: integer;
    tijd1, tijd2: string;
begin
  if plannedrecordings>1 then
  begin
    Stringgrid1.ColCount:=Stringgrid1.ColCount+1;
    for i:=1 to plannedrecordings do
      begin
        if stringgrid1.Cells[5,i]='9' then Stringgrid1.Cells[9,i]:='0'     //Opname bezig, deze moet vooraan blijven
                                      else Stringgrid1.Cells[9,i]:=Stringgrid1.Cells[1,i]+Stringgrid1.Cells[3,i];
      end;
    Stringgrid1.SortColRow(true,9);
    Stringgrid1.DeleteCol(9);
  end;
  if plannedrecordings>0 then
  begin
    tijd1:=FormPlanRecording.StringGrid1.Cells[1,1]; Delete(tijd1,5,1); Delete(tijd1,7,1);
    tijd2:=FormPlanRecording.StringGrid1.Cells[3,1]; Delete(tijd2,3,1);
    tijd1:=tijd1+tijd2;
    Beginrecording:=strtofloat(tijd1)-1;

    tijd1:=FormPlanRecording.StringGrid1.Cells[1,1]; Delete(tijd1,5,1); Delete(tijd1,7,1);
    tijd2:=FormPlanRecording.StringGrid1.Cells[4,1]; Delete(tijd2,3,1);
    tijd1:=tijd1+tijd2;
    Endrecording:=strtofloat(tijd1)-1;
    if endrecording<beginrecording then endrecording:=endrecording+10000;
    Form1.TimerSchedule.Enabled:=True;
  end
  else Form1.TimerSchedule.Enabled:=false;
  Form1.LabelRecordings.caption:=inttostr(plannedrecordings);
  Form1.LabelRecordings.Hint:=Label1.Caption;
end;

procedure TFormPlanRecording.StringGrid1Click(Sender: TObject);
begin
  If (Stringgrid1.Row>0) and (Stringgrid1.RowCount>1) then
  begin
    Combobox2.ItemIndex:=ComboboxTemp.Items.IndexOf(Stringgrid1.Cells[0,Stringgrid1.row]);
    if Stringgrid1.Cells[8,Stringgrid1.Row]='0' then RadioButton4.Checked:=true;
    if Stringgrid1.Cells[8,Stringgrid1.Row]='1' then RadioButton5.Checked:=true;
    if Stringgrid1.Cells[8,Stringgrid1.Row]='2' then RadioButton6.Checked:=true;
    if Stringgrid1.Cells[6,Stringgrid1.Row]='*' then CB_Recur1.Checked:=True
                                                else CB_Recur1.Checked:=False;
    CB_Period1.ItemIndex:=Strtointdef(Stringgrid1.Cells[7,Stringgrid1.Row],0);
    Label17.Caption:=Stringgrid1.Cells[1,Stringgrid1.row];
    LabelH3.Caption:=Copy(Stringgrid1.Cells[3,Stringgrid1.Row],1,2);
    LabelH4.Caption:=Copy(Stringgrid1.Cells[4,Stringgrid1.Row],1,2);
    LabelM3.Caption:=Copy(Stringgrid1.Cells[3,Stringgrid1.Row],4,2);
    LabelM4.Caption:=Copy(Stringgrid1.Cells[4,Stringgrid1.Row],4,2);
    ComboBox2Select(self);
  end;
end;

procedure TFormPlanRecording.StringGrid1DblClick(Sender: TObject);
begin
  If stringgrid1.Row>0 then
  begin
     PageControl1.ActivePageIndex:=2;
  end;
end;

procedure TFormPlanRecording.TabSheet3Show(Sender: TObject);
begin
  If stringgrid1.Row>0 then
  begin
    Speedbutton3.Enabled:=true; ComboBox2.Enabled:=True;
    Label17.Enabled:=True; CB_Recur1.Enabled:=True; CB_Period1.Enabled:=True;
    UpDown7.Enabled:=True; UpDown8.Enabled:=True;
    if schedulehasstarted then
    begin
      UpDown5.Enabled:=False;
      UpDown6.Enabled:=False;
      Label17.Enabled:=False;
    end
       else
    begin
      UpDown5.Enabled:=True;
      UpDown6.Enabled:=True;
      Label17.Enabled:=True;
    end
  end
                      else
  begin
    Speedbutton3.Enabled:=false; ComboBox2.Enabled:=False;
    Label17.Enabled:=false; CB_Recur1.Enabled:=False; CB_Period1.Enabled:=False;
    UpDown5.Enabled:=False; UpDown6.Enabled:=False;
    UpDown7.Enabled:=False; UpDown8.Enabled:=False;
  end;
end;

procedure TFormPlanRecording.UpDown1Click(Sender: TObject; Button: TUDBtnType);
var uur: integer;
begin
  uur:=strtoint(LabelH1.Caption);
  If Button=btNext then
  begin
    Inc(uur);
    if uur > 23 then uur:=0;
  end;
  If Button=btPrev then
  begin
    Dec(uur);
    if uur < 0 then uur:=23;
  end;
  LabelH1.Caption:=inttostr(uur);
  if length(LabelH1.Caption)=1 then LabelH1.Caption:='0'+LabelH1.Caption;
end;

procedure TFormPlanRecording.UpDown2Click(Sender: TObject; Button: TUDBtnType);
var minuten:integer;
    ch: string;
begin
  minuten:=strtoint(LabelM1.Caption);
  If Button=btNext then
  begin
    Inc(minuten);
    if minuten > 59 then minuten:=0;
  end;
  If Button=btPrev then
  begin
    Dec(minuten);
    if minuten < 0 then minuten:=59;
  end;
  if minuten<10 then ch:='0'
                else ch:='';
  LabelM1.Caption:=ch+inttostr(minuten);
end;

procedure TFormPlanRecording.UpDown3Click(Sender: TObject; Button: TUDBtnType);
var uur: integer;
begin
  uur:=strtoint(LabelH2.Caption);
  If Button=btNext then
  begin
    Inc(uur);
    if uur > 23 then uur:=0;
  end;
  If Button=btPrev then
  begin
    Dec(uur);
    if uur < 0 then uur:=23;
  end;
  LabelH2.Caption:=inttostr(uur);
  if length(LabelH2.Caption)=1 then LabelH2.Caption:='0'+LabelH2.Caption;
end;

procedure TFormPlanRecording.UpDown4Click(Sender: TObject; Button: TUDBtnType);
var minuten: integer;
    ch: string;
begin
  minuten:=strtoint(LabelM2.Caption);
  If Button=btNext then
  begin
    Inc(minuten);
    if minuten > 59 then minuten:=0;
  end;
  If Button=btPrev then
  begin
    Dec(minuten);
    if minuten < 0 then minuten:=59;
  end;
  if minuten<10 then ch:='0'
                else ch:='';
  LabelM2.Caption:=ch+inttostr(minuten);
end;

procedure TFormPlanRecording.UpDown5Click(Sender: TObject; Button: TUDBtnType);
var uur: integer;
begin
  uur:=strtoint(LabelH3.Caption);
  If Button=btNext then
  begin
    Inc(uur);
    if uur > 23 then uur:=0;
  end;
  If Button=btPrev then
  begin
    Dec(uur);
    if uur < 0 then uur:=23;
  end;
  LabelH3.Caption:=inttostr(uur);
  if length(LabelH3.Caption)=1 then LabelH3.Caption:='0'+LabelH3.Caption;
end;

procedure TFormPlanRecording.UpDown6Click(Sender: TObject; Button: TUDBtnType);
var minuten:integer;
    ch: string;
begin
  minuten:=strtoint(LabelM3.Caption);
  If Button=btNext then
  begin
    Inc(minuten);
    if minuten > 59 then minuten:=0;
  end;
  If Button=btPrev then
  begin
    Dec(minuten);
    if minuten < 0 then minuten:=59;
  end;
  if minuten<10 then ch:='0'
                else ch:='';
  LabelM3.Caption:=ch+inttostr(minuten);
end;

procedure TFormPlanRecording.UpDown7Click(Sender: TObject; Button: TUDBtnType);
var uur:integer;
begin
  uur:=strtoint(LabelH4.Caption);
  If Button=btNext then
  begin
    Inc(uur);
    if uur > 23 then uur:=0;
  end;
  If Button=btPrev then
  begin
    Dec(uur);
    if uur < 0 then uur:=23;
  end;
  LabelH4.Caption:=inttostr(uur);
  if length(LabelH4.Caption)=1 then LabelH4.Caption:='0'+LabelH4.Caption;
end;

procedure TFormPlanRecording.UpDown8Click(Sender: TObject; Button: TUDBtnType);
var minuten:integer;
    ch: string;
begin
  minuten:=strtoint(LabelM4.Caption);
  If Button=btNext then
  begin
    Inc(minuten);
    if minuten > 59 then minuten:=0;
  end;
  If Button=btPrev then
  begin
    Dec(minuten);
    if minuten < 0 then minuten:=59;
  end;
  if minuten<10 then ch:='0'
                else ch:='';
  LabelM4.Caption:=ch+inttostr(minuten);
end;

end.

