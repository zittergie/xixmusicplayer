program XiXMusicPlayer;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}//{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}//{$ENDIF}
  Interfaces, // this includes the LCL widgetset
  Forms, hoofd, wizard, splash, songdetails, configuration,
  showmydialog, renamesong, newplaylist, addradio, recordplan, nieuwepodcast,
  downloadlist, eq, search, ripcd, fillincd, about, lameconfig,
  fx_echo, fx_flanger, fx_reverb, coverplayer, id3tagger,
  filltagfromfile, debuglog, thumbctrl, uecontrols, VuViewer, filetools,
  filecheckingsettings, ThemePrefs;

{$R *.res}

begin
  RequireDerivedFormResource := True;
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TFormWizard, FormWizard);
  Application.CreateForm(TFormSplash, FormSplash);
  Application.CreateForm(TFormDetails, FormDetails);
  Application.CreateForm(TFormConfig, FormConfig);
  Application.CreateForm(TFormShowMyDialog, FormShowMyDialog);
  Application.CreateForm(TFormRenameSong, FormRenameSong);
  Application.CreateForm(TFormNewPlaylist, FormNewPlaylist);
  Application.CreateForm(TFormAddRadio, FormAddRadio);
  Application.CreateForm(TFormPlanRecording, FormPlanRecording);
  Application.CreateForm(TFormnieuwepodcast, Formnieuwepodcast);
  Application.CreateForm(TFormDownLoadOverView, FormDownLoadOverView);
  Application.CreateForm(TFormEQ, FormEQ);
  Application.CreateForm(TFormSearch, FormSearch);
  Application.CreateForm(TFormRip, FormRip);
  Application.CreateForm(TFormFillInCD, FormFillInCD);
  Application.CreateForm(TFormAbout, FormAbout);
  Application.CreateForm(TFormLameConfig, FormLameConfig);
  Application.CreateForm(TFormEcho, FormEcho);
  Application.CreateForm(TFormFlanger, FormFlanger);
  Application.CreateForm(TFormReverb, FormReverb);
  Application.CreateForm(TFormCoverPlayer, FormCoverPlayer);
  Application.CreateForm(TFormID3Tagger, FormID3Tagger);
  Application.CreateForm(TFormFillTagFromFile, FormFillTagFromFile);
  Application.CreateForm(TFormLog, FormLog);
  Application.CreateForm(TFormFileTools, FormFileTools);
  Application.CreateForm(TFormFileCheckingSettings, FormFileCheckingSettings);
  Application.CreateForm(TFormThemePrefs, FormThemePrefs);
  Application.Run;
end.

