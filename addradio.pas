unit addradio;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  StdCtrls, Buttons {$if not defined(HAIKU)}, Bass{$ifend};

type

  { TFormAddRadio }

  TFormAddRadio = class(TForm)
    Button3: TButton;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Edit4: TEdit;
    Edit5: TEdit;
    Edit7: TEdit;
    Image1: TImage;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Panel1: TPanel;
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    procedure Button3Click(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: boolean);
    procedure FormShow(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  FormAddRadio: TFormAddRadio;

implementation

uses hoofd;

var playingtest: boolean;

{$R *.lfm}

{ TFormAddRadio }

procedure TFormAddRadio.SpeedButton2Click(Sender: TObject);
begin
  Edit1.Text:=''; Edit2.Text:=''; Edit3.Text:=''; Edit4.Text:='';
  Edit5.Text:=''; Edit7.Text:='';
  Close;
end;

procedure TFormAddRadio.SpeedButton1Click(Sender: TObject);
var Filevar: textfile;
begin
 If (Length(Edit1.Text)>0) and (Length(Edit7.Text)>0) then
 begin
  If not EditRadioStation then
  begin
    inc(personalradio);
    RadioStation[personalradio].internalnr:=inttostr(personalradio);
    Radiostation[personalradio].naam:=Edit1.Text;
    Radiostation[personalradio].land:=Edit2.Text;
    Radiostation[personalradio].genres:=Edit3.Text;
    Radiostation[personalradio].website:=Edit4.Text;
    Radiostation[personalradio].logo1:=Edit5.Text;
    Radiostation[personalradio].link:=Edit7.Text;
    If RadioButton1.Checked then Radiostation[personalradio].volgorde:='1'
                            else Radiostation[personalradio].volgorde:='0';

    Form1.StringGridRadioAir.RowCount:=Form1.StringGridRadioAir.RowCount+1;
    Form1.StringGridRadioAir.Cells[0,Form1.StringGridRadioAir.RowCount-1]:=inttostr(personalradio);
    Form1.StringGridRadioAir.Cells[1,Form1.StringGridRadioAir.RowCount-1]:=Edit1.Text;
    Form1.StringGridRadioAir.Cells[2,Form1.StringGridRadioAir.RowCount-1]:=Edit2.Text;
    Form1.StringGridRadioAir.Cells[3,Form1.StringGridRadioAir.RowCount-1]:=Edit3.Text;

    if fileexists(Settings.cacheDirRadio+'radio.prs') then
    begin
      AssignFile(Filevar,Settings.cacheDirRadio+'radio.prs');
      Append(Filevar);
    end
                                                           else
    begin
      AssignFile(Filevar,Settings.cacheDirRadio+'radio.prs');
      Rewrite(Filevar);
    end;
    Writeln(Filevar,Inttostr(personalradio));
    Writeln(Filevar,Edit1.Text);
    Writeln(Filevar,Edit2.Text);
    Writeln(Filevar,Edit3.Text);
    Writeln(Filevar,Edit4.Text);
    Writeln(Filevar,Edit5.Text);
    Writeln(Filevar,'');
    Writeln(Filevar,Edit7.Text);
    If RadioButton1.Checked then Writeln(Filevar,'1')
                            else Writeln(Filevar,'0');
    Writeln(Filevar,'');
    CloseFile(Filevar);
    Form1.StringgridRadioAir.AutoSizeColumns;
  end
  else
  begin
    Radiostation[gekozenradio].naam:=Edit1.Text;
    Radiostation[gekozenradio].land:=Edit2.Text;
    Radiostation[gekozenradio].genres:=Edit3.Text;
    Radiostation[gekozenradio].website:=Edit4.Text;
    Radiostation[gekozenradio].logo1:=Edit5.Text;
    Radiostation[gekozenradio].link:=Edit7.Text;

    If RadioButton1.Checked then Radiostation[gekozenradio].volgorde:='1'
                            else Radiostation[gekozenradio].volgorde:='0';
    form1.RadioStationsOpslaan;

    Form1.StringGridRadioAir.Cells[1,Form1.StringGridRadioAir.Row]:=Edit1.Text;
    Form1.StringGridRadioAir.Cells[2,Form1.StringGridRadioAir.Row]:=Edit2.Text;
    Form1.StringGridRadioAir.Cells[3,Form1.StringGridRadioAir.Row]:=Edit3.Text;
  end;

  Close;
 end
 else ShowMessage(Form1.Vertaal('Please fill all the required fields'));
end;

procedure TFormAddRadio.FormShow(Sender: TObject);
begin
  Playingtest:=False;
  If EditRadioStation then
  begin
    FormAddRadio.Caption:=Form1.Vertaal('Edit Radio Stream');
    Edit1.Text:=Radiostation[gekozenradio].naam;
    Edit2.Text:=Radiostation[gekozenradio].land;
    Edit3.Text:=Radiostation[gekozenradio].genres;
    Edit4.Text:=Radiostation[gekozenradio].website;
    Edit5.Text:=Radiostation[gekozenradio].logo1;
    Edit7.Text:=Radiostation[gekozenradio].link;
    If Radiostation[gekozenradio].volgorde='1' then RadioButton1.Checked:=True
                                               else RadioButton1.Checked:=False;
  end
                      else FormAddRadio.Caption:=Form1.Vertaal('Add Radio Stream');
  Label1.Caption:=Form1.Vertaal('Name')+':';
  Label2.Caption:=Form1.Vertaal('Country')+':';
  Label3.Caption:=Form1.Vertaal('Genres')+':';
  Label4.Caption:=Form1.Vertaal('Website')+':';
  Label5.Caption:=Form1.Vertaal('Logo Link')+':';
  Label7.Caption:=Form1.Vertaal('Stream URL')+':';
  Button3.Caption:=Form1.Vertaal('Test');
  RadioButton1.Caption:=Form1.Vertaal('Artist')+' - '+Form1.Vertaal('Title');
  RadioButton2.Caption:=Form1.Vertaal('Title')+' - '+Form1.Vertaal('Artist');
  SpeedButton1.Caption:=Form1.Vertaal('Save');
  SpeedButton2.Caption:=Form1.Vertaal('Cancel');
  Label6.Caption:=Form1.Vertaal('To show the right lyrics you must choose the right order of the ARTIST and TITLE in the radiostream');
end;

procedure TFormAddRadio.Button3Click(Sender: TObject);
begin;
  {$if not defined(HAIKU)}
  Playingtest:=True;
  BASS_ChannelStop(radiostream);
  radioStream := BASS_StreamCreateURL(pchar(Edit7.Text), 0, BASS_STREAM_STATUS, NIL, NIL);
  BASS_ChannelPlay(radiostream, False);
  {$ifend}
end;

procedure TFormAddRadio.FormCloseQuery(Sender: TObject; var CanClose: boolean);
begin
  {$if not defined(HAIKU)}
  if playingtest then BASS_ChannelStop(radiostream);
  {$ifend}
end;

end.

