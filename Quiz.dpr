program Quiz;

uses
  System.StartUpCopy,
  FMX.Forms,
  Main in 'Main.pas' {frmMain},
  MainDataModule in 'MainDataModule.pas' {DataModule2: TDataModule},
  Spash in 'Spash.pas' {frmSplash};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TDataModule2, DataModule2);
  Application.CreateForm(TfrmSplash, frmSplash);
  Application.CreateForm(TfrmMain, frmMain);


  Application.Run;
end.
