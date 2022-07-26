unit ThemePrefs;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, StdCtrls,
  Buttons;

type

  { TFormThemePrefs }

  TFormThemePrefs = class(TForm)
    Bevel1: TBevel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    ComboBox1: TComboBox;
    Label1: TLabel;
    Panel1: TPanel;
    Panel2: TPanel;
    procedure BitBtn3Click(Sender: TObject);
  private

  public

  end;

var
  FormThemePrefs: TFormThemePrefs;

implementation

{$R *.lfm}

{ TFormThemePrefs }

procedure TFormThemePrefs.BitBtn3Click(Sender: TObject);
begin
  Close;
end;

end.

