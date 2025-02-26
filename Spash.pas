unit Spash;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  System.Math.Vectors, FMX.Controls.Presentation, FMX.StdCtrls, FMX.Controls3D,
  FMX.Layers3D, FMX.Objects;

type
  TfrmSplash = class(TForm)
    tmDelay: TTimer;
    rectMain: TRectangle;
    lblInfo: TLabel;
    procedure tmDelayTimer(Sender: TObject);
  private
    { Private declarations }
    I: Integer;
  public
    { Public declarations }
  end;

var
  frmSplash: TfrmSplash;

implementation

{$R *.fmx}

uses Main;

procedure TfrmSplash.tmDelayTimer(Sender: TObject);
begin
  lblInfo.TextSettings.Font.Size := 60;
  if I = 0 then
    lblInfo.Text := '3'
  else if I = 1 then
    lblInfo.Text := '2'
  else if I = 2 then
    lblInfo.Text := '1'
  else
    lblInfo.Text := 'Lets Go...';
  sleep(1000);
  if I = 4 then
  begin
    tmDelay.Enabled := false;
    frmSplash.hide;
    frmMain.Show;
  end;

  I := I + 1;
end;

end.
