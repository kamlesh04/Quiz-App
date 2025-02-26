unit Main;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.ListView.Types, FMX.ListView.Appearances, FMX.ListView.Adapters.Base,
  FMX.ListView, FMX.Layouts, FMX.TabControl, FMX.Controls.Presentation,
  FMX.StdCtrls, System.Actions, FMX.ActnList, WrapFmxComCtrls,
  FMX.Styles.Objects, FMX.Objects, FMX.Memo.Types, FMX.ScrollBox, FMX.Memo,
  Spash;

type
  TfrmMain = class(TForm)
    tcMain: TTabControl;
    loMain: TLayout;
    lwFooter: TListView;
    lwHeader: TListView;
    btnNext: TSpeedButton;
    btnPrev: TSpeedButton;
    ActionList1: TActionList;
    NextTabAction1: TNextTabAction;
    PreviousTabAction1: TPreviousTabAction;
    btnScore: TSpeedButton;
    lblCaption: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure AnswerSelected(Sender: TObject);
    procedure btnScoreClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure tcMainChange(Sender: TObject);
  private
    { Private declarations }
    rectA, rectB, rectC, rectD : TRectangle;
    countAns, countCorrAns, tabcnt : integer;
    lblScore : TLabel;
  public
    { Public declarations }
  end;

var
  frmMain: TfrmMain;

implementation

{$R *.fmx}
{$R *.NmXhdpiPh.fmx ANDROID}

uses MainDataModule;
procedure TfrmMain.AnswerSelected(Sender: TObject);
begin
  if (Sender as TRectangle).Hint = 'true' then
  begin
    (Sender as TRectangle).Fill.Color := TAlphaColorRec.Green;
    countCorrAns := countCorrAns + 1;
  end
  else
   (Sender as TRectangle).Fill.Color := TAlphaColorRec.Red;
  ((Sender as TRectangle).GetParentComponent.GetParentComponent As TTabItem).Enabled := False;

  countAns := countAns + 1;
  tabcnt := tabcnt + 1;
  if tcMain.TabIndex <> 10 then
    btnNext.Action.ExecuteAction(NextTabAction1);
  if tcMain.TabCount = tabcnt  then
  begin
    tcMain.ActiveTab := tcMain.Tabs[tcMain.TabCount-1];
    lblScore.Text := IntToStr(countCorrAns);
  end;

end;

procedure TfrmMain.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if Assigned(frmSplash) then
    frmSplash.Close;
end;

procedure TfrmMain.FormCreate(Sender: TObject);
var
  tab : TTabItem;
  i : integer;
  panel : TPanel;
  lblQ,lblQue,lblA,lblB,lblC,lblD,lblScoreHeading : TLabel;
  lblrectA, lblrectB, lblrectC, lblrectD : TLabel;
  rectMain: TRectangle;
begin
  countAns := 0;
  countCorrAns := 0;
  tabcnt := 1;
   DataModule2.FetchData;
    //Create Tabs
    for I := 1 to Length(DataModule2.QuizData)  do
    begin
      if DataModule2.QuizData[i].Questions <> '' then
      begin
        tab := TTabItem.Create(Application);
        tab.Text := 'Tab'+ IntToStr(i);
        tab.Name := 'tab'+ IntToStr(i);
        tab.Parent:= tcMain;
        tab.TextAlign := TTextAlign.Leading;
        tab.Width := (Length(tab.Text) * 6 ) + 60;
        tab.Font.Size := 15;
        tcMain.ActiveTab := tcMain.Tabs[0];

        //Create Panel
        panel := TPanel.Create(Application);
        panel.Parent := tab;
        panel.Align := TAlignLayout.Client;
        panel.Name := 'panel' + IntToStr(i);

        //Create Rectangle
        rectMain := TRectangle.Create(Application);
        rectMain.Parent := tab;
        rectMain.Name := 'Rectangle' + IntToStr(i);
        rectMain.Fill.Color := TAlphaColorRec.Lavender;
        rectMain.Width := 375;
        rectMain.Height := 281;
        rectMain.Position.X := 16;
        rectMain.Position.Y := 39;

         //Create label Q
        lblQ := TLabel.Create(Application);
        lblQ.Name := 'lblQ'+  IntToStr(i);
        lblQ.Parent := rectMain;
        lblQ.Text := 'Q'+  IntToStr(i) + '.';
        lblQ.TextSettings.VertAlign := TTextAlign.Center;
        lblQ.TextSettings.HorzAlign := TTextAlign.Leading;
        lblQ.TextSettings.Font.Style := [TFontStyle.fsBold];
        lblQ.TextSettings.Font.Size := 15;
        lblQ.StyledSettings := [TStyledSetting.Family, TStyledSetting.FontColor];
        lblQ.Width := 35;
        lblQ.Height := 17;
        lblQ.Position.X := 5;
        lblQ.Position.Y := 20;

        //Create label Questions
        lblQue := TLabel.Create(Application);
        lblQue.Name := 'lblQue'+  IntToStr(i);
        lblQue.Parent := rectMain;
        lblQue.Text := DataModule2.QuizData[i].Questions;
        lblQue.TextSettings.VertAlign := TTextAlign.Center;
        lblQue.TextSettings.HorzAlign := TTextAlign.Leading;
        lblQue.TextSettings.Font.Style := [TFontStyle.fsBold];
        lblQue.TextSettings.Font.Size := 15;
        lblQue.StyledSettings := [TStyledSetting.Family, TStyledSetting.FontColor];
        lblQue.Width := 273;
        lblQue.Height := 95;
        lblQue.Position.X := 45;
        lblQue.Position.Y := 0;

        //Create label A
        lblA := TLabel.Create(Application);
        lblA.Name := 'lblA'+  IntToStr(i);
        lblA.Parent := rectMain;
        lblA.Text := 'A.';
        lblA.TextSettings.VertAlign := TTextAlign.Center;
        lblA.TextSettings.HorzAlign := TTextAlign.Leading;
        lblA.TextSettings.Font.Style := [TFontStyle.fsBold];
        lblA.TextSettings.Font.Size := 15;
        lblA.StyledSettings := [TStyledSetting.Family, TStyledSetting.FontColor];
        lblA.Width := 35;
        lblA.Height := 17;
        lblA.Position.X := 10;
        lblA.Position.Y := 145;

        //Create label B
        lblB := TLabel.Create(Application);
        lblB.Name := 'lblB'+  IntToStr(i);
        lblB.Parent := rectMain;
        lblB.Text := 'B.';
        lblB.TextSettings.VertAlign := TTextAlign.Center;
        lblB.TextSettings.HorzAlign := TTextAlign.Leading;
        lblB.TextSettings.Font.Style := [TFontStyle.fsBold];
        lblB.TextSettings.Font.Size := 15;
        lblB.StyledSettings := [TStyledSetting.Family, TStyledSetting.FontColor];
        lblB.Width := 35;
        lblB.Height := 17;
        lblB.Position.X := 190;
        lblB.Position.Y := 146;

        //Create label C
        lblC := TLabel.Create(Application);
        lblC.Name := 'lblC'+  IntToStr(i);
        lblC.Parent := rectMain;
        lblC.Text := 'C.';
        lblC.TextSettings.VertAlign := TTextAlign.Center;
        lblC.TextSettings.HorzAlign := TTextAlign.Leading;
        lblC.TextSettings.Font.Style := [TFontStyle.fsBold];
        lblC.TextSettings.Font.Size := 15;
        lblC.StyledSettings := [TStyledSetting.Family, TStyledSetting.FontColor];
        lblC.Width := 35;
        lblC.Height := 17;
        lblC.Position.X := 10;
        lblC.Position.Y := 223;

        //Create label D
        lblD := TLabel.Create(Application);
        lblD.Name := 'lblD'+  IntToStr(i);
        lblD.Parent := rectMain;
        lblD.Text := 'D.';
        lblD.TextSettings.VertAlign := TTextAlign.Center;
        lblD.TextSettings.HorzAlign := TTextAlign.Leading;
        lblD.TextSettings.Font.Style := [TFontStyle.fsBold];
        lblD.TextSettings.Font.Size := 15;
        lblD.StyledSettings := [TStyledSetting.Family, TStyledSetting.FontColor];
        lblD.Width := 35;
        lblD.Height := 17;
        lblD.Position.X := 190;
        lblD.Position.Y := 220;

        //Create Rectangle A
        rectA := TRectangle.Create(Application);
        rectA.Parent := rectMain;
        rectA.Name := 'RectA' + IntToStr(i);
        rectA.Fill.Color := TAlphaColorRec.Lavenderblush;
        rectA.Width := 150;
        rectA.Height := 70;
        rectA.Position.X := 30;
        rectA.Position.Y := 125;
        rectA.OnClick := AnswerSelected;
        rectA.Hint :=  DataModule2.QuizData[i].FirstCorrAns;

        //Create Rectangle B
        rectB := TRectangle.Create(Application);
        rectB.Parent := rectMain;
        rectB.Name := 'RectB' + IntToStr(i);
        rectB.Fill.Color := TAlphaColorRec.Lavenderblush;
        rectB.Width := 150;
        rectB.Height := 70;
        rectB.Position.X := 210;
        rectB.Position.Y := 126;
        rectB.OnClick := AnswerSelected;
        rectB.Hint :=  DataModule2.QuizData[i].SecondCorrAns;

        //Create Rectangle C
        rectC := TRectangle.Create(Application);
        rectC.Parent := rectMain;
        rectC.Name := 'RectC' + IntToStr(i);
        rectC.Fill.Color := TAlphaColorRec.Lavenderblush;
        rectC.Width := 150;
        rectC.Height := 70;
        rectC.Position.X := 30;
        rectC.Position.Y := 203;
        rectC.OnClick := AnswerSelected;
        rectC.Hint :=  DataModule2.QuizData[i].ThirdCorrAns;

        //Create Rectangle D
        rectD := TRectangle.Create(Application);
        rectD.Parent := rectMain;
        rectD.Name := 'RectD' + IntToStr(i);
        rectD.Fill.Color := TAlphaColorRec.Lavenderblush;
        rectD.Width := 150;
        rectD.Height := 70;
        rectD.Position.X := 210;
        rectD.Position.Y := 205;
        rectD.OnClick := AnswerSelected;
        rectD.Hint :=  DataModule2.QuizData[i].FourthCorrAns;

        //Create label lblrectA
        lblrectA := TLabel.Create(Application);
        lblrectA.Name := 'lblrectA'+  IntToStr(i);
        lblrectA.Parent := rectA;
        lblrectA.Text :=  DataModule2.QuizData[i].FirstOpt;
        lblrectA.TextSettings.VertAlign := TTextAlign.Center;
        lblrectA.TextSettings.HorzAlign := TTextAlign.Leading;
        lblrectA.TextSettings.Font.Style := [TFontStyle.fsBold];
        lblrectA.TextSettings.Font.Size := 15;
        lblrectA.TextSettings.WordWrap := True;
        lblrectA.StyledSettings := [TStyledSetting.Family,TStyledSetting.Size,TStyledSetting.Style, TStyledSetting.FontColor];
        lblrectA.Width := 120;
        lblrectA.Height := 70;
        lblrectA.Position.X := 10;
        lblrectA.Position.Y := 0;

        //Create label lblrectB
        lblrectB := TLabel.Create(Application);
        lblrectB.Name := 'lblrectB'+  IntToStr(i);
        lblrectB.Parent := rectB;
        lblrectB.Text := DataModule2.QuizData[i].SecondOpt;
        lblrectB.TextSettings.VertAlign := TTextAlign.Center;
        lblrectB.TextSettings.HorzAlign := TTextAlign.Leading;
        lblrectB.TextSettings.Font.Style := [TFontStyle.fsBold];
        lblrectB.TextSettings.Font.Size := 15;
        lblrectB.TextSettings.WordWrap := True;
        lblrectB.StyledSettings := [TStyledSetting.Family,TStyledSetting.Size,TStyledSetting.Style, TStyledSetting.FontColor];
        lblrectB.Width := 120;
        lblrectB.Height := 70;
        lblrectB.Position.X := 10;
        lblrectB.Position.Y := 0;

        //Create label lblrectC
        lblrectC := TLabel.Create(Application);
        lblrectC.Name := 'lblrectC'+  IntToStr(i);
        lblrectC.Parent := rectC;
        if DataModule2.QuizData[i].ThirdOpt <> '' then
          lblrectC.Text := DataModule2.QuizData[i].ThirdOpt
        else
          lblrectC.Text := '-';
        lblrectC.TextSettings.VertAlign := TTextAlign.Center;
        lblrectC.TextSettings.HorzAlign := TTextAlign.Leading;
        lblrectC.TextSettings.Font.Style := [TFontStyle.fsBold];
        lblrectC.TextSettings.Font.Size := 15;
        lblrectC.TextSettings.WordWrap := True;
        lblrectC.StyledSettings := [TStyledSetting.Family,TStyledSetting.Size,TStyledSetting.Style, TStyledSetting.FontColor];
        lblrectC.Width := 120;
        lblrectC.Height := 70;
        lblrectC.Position.X := 10;
        lblrectC.Position.Y := 0;

        //Create label lblrectD
        lblrectD := TLabel.Create(Application);
        lblrectD.Name := 'lblrectD'+  IntToStr(i);
        lblrectD.Parent := rectD;
        if DataModule2.QuizData[i].FourthOpt <> '' then
          lblrectD.Text := DataModule2.QuizData[i].FourthOpt
        else if (DataModule2.QuizData[i].ThirdOpt = '') and (DataModule2.QuizData[i].FourthOpt = '')  then
          lblrectD.Text := '-'
        else
          lblrectD.Text := 'Not sure';
        lblrectD.TextSettings.VertAlign := TTextAlign.Center;
        lblrectD.TextSettings.HorzAlign := TTextAlign.Leading;
        lblrectD.TextSettings.Font.Style := [TFontStyle.fsBold];
        lblrectD.TextSettings.Font.Size := 15;
        lblrectD.TextSettings.WordWrap := True;
        lblrectD.StyledSettings := [TStyledSetting.Family,TStyledSetting.Size,TStyledSetting.Style, TStyledSetting.FontColor];
        lblrectD.Width := 120;
        lblrectD.Height := 70;
        lblrectD.Position.X := 10;
        lblrectD.Position.Y := 0;
      end
      else
        break;
   end;
   //Create score tab
  tab := TTabItem.Create(Application);
  tab.Text := 'Score';
  tab.Name := 'tbScore';
  tab.Parent:= tcMain;
  tab.TextAlign := TTextAlign.Leading;
  tab.Width := (Length(tab.Text) * 6 ) + 60;
  tab.Font.Size := 15;

  //Create Score labels
  lblScoreHeading := TLabel.Create(Application);
  lblScoreHeading.Name := 'lblScoreHeading';
  lblScoreHeading.Parent := tab;
  lblScoreHeading.Text := 'Your score is:';
  lblScoreHeading.TextSettings.VertAlign := TTextAlign.Center;
  lblScoreHeading.TextSettings.HorzAlign := TTextAlign.Leading;
  lblScoreHeading.TextSettings.Font.Style := [TFontStyle.fsBold];
  lblScoreHeading.TextSettings.Font.Size := 30;
  lblScoreHeading.TextSettings.WordWrap := true;
  lblScoreHeading.StyledSettings := [TStyledSetting.Family, TStyledSetting.FontColor];
  lblScoreHeading.Width := 365;
  lblScoreHeading.Height := 72;
  lblScoreHeading.Position.X := 100;
  lblScoreHeading.Position.Y := 126;

  lblScore := TLabel.Create(Application);
  lblScore.Name := 'lblScore';
  lblScore.Parent := tab;
  lblScore.Text := '0';
  lblScore.TextSettings.VertAlign := TTextAlign.Center;
  lblScore.TextSettings.HorzAlign := TTextAlign.Leading;
  lblScore.TextSettings.Font.Style := [TFontStyle.fsBold];
  lblScore.TextSettings.Font.Size := 30;
  lblScore.TextSettings.WordWrap := true;
  lblScore.StyledSettings := [TStyledSetting.Family, TStyledSetting.FontColor];
  lblScore.Width := 365;
  lblScore.Height := 72;
  lblScore.Position.X := 180;
  lblScore.Position.Y := 160;



end;

procedure TfrmMain.tcMainChange(Sender: TObject);
begin
  if (countAns <> 10) and (tcMain.TabIndex = 10) then
    tcMain.ActiveTab := tcMain.Tabs[tcMain.TabCount -2 ];

end;

procedure TfrmMain.btnScoreClick(Sender: TObject);
begin
  if countAns <> 10 then
    ShowMessage('Answer all the questions!')
  else
    tcMain.ActiveTab := tcMain.Tabs[tcMain.TabCount-1];

end;

end.
