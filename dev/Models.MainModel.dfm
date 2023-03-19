object MainModel: TMainModel
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Height = 450
  Width = 542
  object DBConnection: TZConnection
    ControlsCodePage = cCP_UTF16
    AutoEncodeStrings = True
    ClientCodepage = 'utf16'
    Catalog = ''
    Properties.Strings = (
      'controls_cp=GET_ACP'
      'codepage=utf16'
      'AutoEncodeStrings=ON')
    Connected = True
    DesignConnection = True
    HostName = 'localhost'
    Port = 3306
    Database = 'sole_data_dev'
    User = 'sole_dev'
    Password = 'sole_dev'
    Protocol = 'mysql'
    LibraryLocation = 
      'C:\Users\Public\Documents\Embarcadero\Studio\Projekte\SoLE\Clien' +
      't\dev\libmysql.dll'
    Left = 40
    Top = 16
  end
  object CreateDBProcessor: TZSQLProcessor
    Params = <>
    Connection = CreateDBConnection
    Delimiter = ';'
    Left = 416
    Top = 64
  end
  object CreateDBConnection: TZConnection
    ControlsCodePage = cCP_UTF16
    AutoEncodeStrings = True
    ClientCodepage = 'utf16'
    Catalog = ''
    Properties.Strings = (
      'codepage=utf16'
      'AutoEncodeStrings=ON')
    HostName = ''
    Port = 0
    Database = ''
    User = ''
    Password = ''
    Protocol = ''
    Left = 416
    Top = 16
  end
  object SQLMonitor: TZSQLMonitor
    MaxTraceCount = 10000
    Left = 416
    Top = 120
  end
  object DeleteProcessor: TZSQLProcessor
    Params = <
      item
        DataType = ftString
        Name = 'ID'
        ParamType = ptInput
      end>
    Connection = DBConnection
    Delimiter = ';'
    Left = 416
    Top = 176
  end
end
