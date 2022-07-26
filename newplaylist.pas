unit newplaylist;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  StdCtrls, Buttons;

type

  { TFormNewPlaylist }

  TFormNewPlaylist = class(TForm)
    Edit1: TEdit;
    Label1: TLabel;
    Panel1: TPanel;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    procedure Edit1KeyPress(Sender: TObject; var Key: char);
    procedure FormShow(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  FormNewPlaylist: TFormNewPlaylist;

implementation

uses hoofd;

{$R *.lfm}

{ TFormNewPlaylist }

procedure TFormNewPlaylist.SpeedButton2Click(Sender: TObject);
begin
  Close;
end;

procedure TFormNewPlaylist.SpeedButton1Click(Sender: TObject);
var Filevar: TextFile;
    i: longint;
begin
  if fileexists(Configdir+DirectorySeparator+'playlist'+DirectorySeparator+Edit1.Text+'.xix') then ShowMessage('"'+Edit1.Text+'" does already exists.  Please choose another name.')
  else
  begin
    if modespeellijst=1 then
    begin
      AssignFile(Filevar, Configdir+DirectorySeparator+'playlist'+DirectorySeparator+Edit1.Text+'.xix');
      Rewrite(Filevar);
      CloseFile(Filevar);
      Form1.LB_Playlist.Items.Add(edit1.Text);
      Close;
    end;
    if modespeellijst=2 then
    begin
      CopyFile(Configdir+DirectorySeparator+'playlist'+DirectorySeparator+Form1.LB_Playlist.Items[Form1.LB_Playlist.ItemIndex]+'.xix',Configdir+DirectorySeparator+'playlist'+DirectorySeparator+Edit1.Text+'.xix');
      Form1.LB_Playlist.Items.Add(edit1.Text);
      Close;
    end;
    if modespeellijst=3 then
    begin
      RenameFile(Configdir+DirectorySeparator+'playlist'+DirectorySeparator+Form1.LB_Playlist.Items[Form1.LB_Playlist.ItemIndex]+'.xix',Configdir+DirectorySeparator+'playlist'+DirectorySeparator+Edit1.Text+'.xix');
      Form1.LB_Playlist.Items[Form1.LB_Playlist.ItemIndex]:=Edit1.Text;
      Close;
    end;
    if modespeellijst=4 then
    begin
      AssignFile(Filevar, Configdir+DirectorySeparator+'playlist'+DirectorySeparator+Edit1.Text+'.xix');
      Rewrite(Filevar);
      For i := 1 to Form1.SG_Play.RowCount-1 do
      begin
         Writeln(Filevar,Liedjes[strtoint(Form1.SG_Play.Cells[6,i])].Pad+Liedjes[strtoint(Form1.SG_Play.Cells[6,i])].Bestandsnaam);
      end;
      CloseFile(Filevar);
      Form1.LB_Playlist.Items.Add(edit1.Text);
      Close;
    end;
  end;

end;

procedure TFormNewPlaylist.FormShow(Sender: TObject);
begin
  Label1.Caption:=Form1.Vertaal('Name');
end;

procedure TFormNewPlaylist.Edit1KeyPress(Sender: TObject; var Key: char);
begin
  if key=#13 then Speedbutton1Click(Self);
end;

end.

