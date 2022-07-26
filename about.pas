unit about;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Dialogs, ExtCtrls,
  ComCtrls, StdCtrls;

type

  { TFormAbout }

  TFormAbout = class(TForm)
    Button1: TButton;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    Image2: TImage;
    Image3: TImage;
    Label1: TLabel;
    Label100: TLabel;
    Label101: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label40: TLabel;
    Label49: TLabel;
    Label50: TLabel;
    Label51: TLabel;
    Label52: TLabel;
    Label53: TLabel;
    Label54: TLabel;
    Label55: TLabel;
    Label56: TLabel;
    Label57: TLabel;
    Label58: TLabel;
    Label59: TLabel;
    Label6: TLabel;
    Label60: TLabel;
    Label61: TLabel;
    Label62: TLabel;
    Label63: TLabel;
    Label64: TLabel;
    Label65: TLabel;
    Label66: TLabel;
    Label67: TLabel;
    Label68: TLabel;
    Label69: TLabel;
    Label7: TLabel;
    Label70: TLabel;
    Label71: TLabel;
    Label72: TLabel;
    Label73: TLabel;
    Label74: TLabel;
    Label75: TLabel;
    Label76: TLabel;
    Label77: TLabel;
    Label78: TLabel;
    Label79: TLabel;
    Label8: TLabel;
    Label80: TLabel;
    Label81: TLabel;
    Label82: TLabel;
    Label83: TLabel;
    Label84: TLabel;
    Label85: TLabel;
    Label86: TLabel;
    Label87: TLabel;
    Label88: TLabel;
    Label89: TLabel;
    Label9: TLabel;
    Label90: TLabel;
    Label91: TLabel;
    Label97: TLabel;
    Label98: TLabel;
    Label99: TLabel;
    LabelVersion: TLabel;
    Memo1: TMemo;
    Memo2: TMemo;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
    TabSheet4: TTabSheet;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Image2Click(Sender: TObject);
    procedure Image3Click(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  FormAbout: TFormAbout;

implementation

uses hoofd;

{$R *.lfm}

{ TFormAbout }

procedure TFormAbout.Button1Click(Sender: TObject);
begin
  Close;
end;

procedure TFormAbout.FormCreate(Sender: TObject);
begin

end;

procedure TFormAbout.FormShow(Sender: TObject);
begin
  TabSheet1.Caption:=Form1.Vertaal('About')+' ...';
  Tabsheet4.Caption:=Form1.Vertaal('Translations');
  Tabsheet3.Caption:=Form1.Vertaal('Help');
  TabSheet2.Caption:=Form1.Vertaal('Shortcuts');
  Label3.Caption:=form1.Vertaal('A free multi-platform MP3, OGG, M4A APE, OPUS, DSD & FLAC player.');
  Label7.Caption:=Form1.Vertaal('-  Switch to Fullscreen');
  Label4.Caption:=Form1.Vertaal('Programmed in FreePascal/Lazarus and uses the third-party library BASS.  Encoding uses LAME and/or FLAC binaries.  MPLAYER binary is used to rip DVD tracks.  Most of development is done on Linux.');
  Label1.Caption:=Form1.Vertaal('Thanks to')+':';
  Label9.Caption:='('+Form1.Vertaal('visit website')+')';
  Button1.Caption:=Form1.Vertaal('OK, thanks');
  LabelVersion.Caption:=versie;
end;

procedure TFormAbout.Image2Click(Sender: TObject);
begin
  Form1.BrowseTo('http://www.lazarus.freepascal.org/');
end;

procedure TFormAbout.Image3Click(Sender: TObject);
begin
  Form1.BrowseTo('http://www.un4seen.com');
end;

end.

