unit MainDataModule;

interface

uses
  System.SysUtils, System.Classes, REST.Types, REST.Client,
  Data.Bind.Components, Data.Bind.ObjectScope, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, REST.Response.Adapter, JSON;

type

  TQuizData = record
    Questions : string;
    FirstOpt,SecondOpt,ThirdOpt, FourthOpt  : string;
    FirstCorrAns,SecondCorrAns,ThirdCorrAns,FourthCorrAns : string;
  end;

  TDataModule2 = class(TDataModule)
    RESTClient2: TRESTClient;
    RESTRequest2: TRESTRequest;
    RESTResponse2: TRESTResponse;
    RESTResponseDataSetAdapter1: TRESTResponseDataSetAdapter;
    FDMemTable1: TFDMemTable;
  private
    { Private declarations }
  public
    { Public declarations }
    QuizData : Array[1..100] of TQuizData;
    function FetchData:  String;

  end;




var
  DataModule2: TDataModule2;

implementation

{%CLASSGROUP 'FMX.Controls.TControl'}

{$R *.dfm}

{ TDataModule2 }

function TDataModule2.FetchData: String;
var
  jsVal,jsName : TJSONValue;
  jsArr : TJSONArray;
  jsObj : TJSONObject;
  i : integer;
  k : string;
begin
  RESTRequest2.Execute;
  jsVal := TJSONObject.ParseJSONValue(RESTResponse2.Content);
  jsArr := jsVal as TJSONArray;
  i := 1;
  for jsName in jsArr do
  begin
    QuizData[i].Questions := jsName.GetValue<string>('question');

    QuizData[i].FirstOpt := jsName.GetValue<string>('answers'+'.'+'answer_a');
    QuizData[i].SecondOpt := jsName.GetValue<string>('answers'+'.'+'answer_b');
    QuizData[i].ThirdOpt := jsName.GetValue<string>('answers'+'.'+'answer_c');
    QuizData[i].FourthOpt := jsName.GetValue<string>('answers'+'.'+'answer_d');

    QuizData[i].FirstCorrAns := jsName.GetValue<string>('correct_answers'+'.'+'answer_a_correct');
    QuizData[i].SecondCorrAns := jsName.GetValue<string>('correct_answers'+'.'+'answer_b_correct');
    QuizData[i].ThirdCorrAns := jsName.GetValue<string>('correct_answers'+'.'+'answer_c_correct');
    QuizData[i].FourthCorrAns := jsName.GetValue<string>('correct_answers'+'.'+'answer_d_correct');
    i := i + 1;
  end;
end;

end.
