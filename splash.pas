unit splash;

{$mode objfpc}{$H+}

interface

uses
  Classes, Forms, Controls, ExtCtrls, StdCtrls, ComCtrls;

type

  { TFormSplash }

  TFormSplash = class(TForm)
    Image1: TImage;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    LabelVersie: TLabel;
    Panel1: TPanel;
    ProgressBar1: TProgressBar;
    procedure FormShow(Sender: TObject);
    procedure Label3Click(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  FormSplash: TFormSplash;

implementation

{$R *.lfm}

{ TFormSplash }

procedure TFormSplash.FormShow(Sender: TObject);
begin
  ProgressBar1.Position:=0; Application.ProcessMessages;
end;

procedure TFormSplash.Label3Click(Sender: TObject);
begin

end;

end.

