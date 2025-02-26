object DataModule2: TDataModule2
  Height = 442
  Width = 486
  PixelsPerInch = 120
  object RESTClient2: TRESTClient
    Accept = 'application/json, text/plain; q=0.9, text/html;q=0.8,'
    AcceptCharset = 'utf-8, *;q=0.8'
    BaseURL = 
      'https://quizapi.io/api/v1/questions?apiKey=KQplsXxIM8Zy33OJokqtH' +
      'iDyU126pr8FNFtSrotO&category=code&difficulty=Easy&limit=10'
    Params = <>
    SynchronizedEvents = False
    Left = 32
    Top = 32
  end
  object RESTRequest2: TRESTRequest
    AssignedValues = [rvConnectTimeout, rvReadTimeout]
    Client = RESTClient2
    Params = <>
    Response = RESTResponse2
    SynchronizedEvents = False
    Left = 80
    Top = 144
  end
  object RESTResponse2: TRESTResponse
    ContentType = 'application/json'
    Left = 176
    Top = 32
  end
  object RESTResponseDataSetAdapter1: TRESTResponseDataSetAdapter
    Active = True
    Dataset = FDMemTable1
    FieldDefs = <>
    Response = RESTResponse2
    Left = 280
    Top = 136
  end
  object FDMemTable1: TFDMemTable
    Active = True
    FieldDefs = <
      item
        Name = 'id'
        DataType = ftWideString
        Size = 255
      end
      item
        Name = 'question'
        DataType = ftWideString
        Size = 255
      end
      item
        Name = 'description'
        DataType = ftWideString
        Size = 255
      end
      item
        Name = 'answers'
        DataType = ftWideString
        Size = 255
      end
      item
        Name = 'multiple_correct_answers'
        DataType = ftWideString
        Size = 255
      end
      item
        Name = 'correct_answers'
        DataType = ftWideString
        Size = 255
      end
      item
        Name = 'correct_answer'
        DataType = ftWideString
        Size = 255
      end
      item
        Name = 'explanation'
        DataType = ftWideString
        Size = 255
      end
      item
        Name = 'tip'
        DataType = ftWideString
        Size = 255
      end
      item
        Name = 'tags'
        DataType = ftWideString
        Size = 255
      end
      item
        Name = 'category'
        DataType = ftWideString
        Size = 255
      end
      item
        Name = 'difficulty'
        DataType = ftWideString
        Size = 255
      end>
    IndexDefs = <>
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvUpdateChngFields, uvUpdateMode, uvLockMode, uvLockPoint, uvLockWait, uvRefreshMode, uvFetchGeneratorsPoint, uvCheckRequired, uvCheckReadOnly, uvCheckUpdatable]
    UpdateOptions.LockWait = True
    UpdateOptions.FetchGeneratorsPoint = gpNone
    UpdateOptions.CheckRequired = False
    StoreDefs = True
    Left = 384
    Top = 32
  end
end
