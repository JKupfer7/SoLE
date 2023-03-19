unit Models.Nullable;

interface

uses
  System.SysUtils;

type
  /// <summary>Generic record to hold a variable of type T, which can be nil.<summary>
  TNullable<T> = record
  private
    FIsNull: Boolean;
    FValue: T;
    function GetValue: T;
    procedure SetValue(const Value: T);
    function GetHasValue: Boolean;
  public
    procedure Clear;
    property IsNull: Boolean read FIsNull;
    property HasValue: Boolean read GetHasValue;
    property Value: T read GetValue write SetValue;
    /// <summary>Typecasts TNullable<T> to T or vice versa.<summary>
    class operator Implicit(A: T): TNullable<T>;
  end;

implementation

{ TNullable<T> }

procedure TNullable<T>.Clear;
begin
  FIsNull := true;
end;

function TNullable<T>.GetValue: T;
begin
  if HasValue then
    Result := FValue
  else
    raise Exception.Create('TNullable: Variable has no value');
end;

function TNullable<T>.GetHasValue: Boolean;
begin
  Result := not(IsNull);
end;

class operator TNullable<T>.Implicit(A: T): TNullable<T>;
begin
  Result.Value := A;
end;

procedure TNullable<T>.SetValue(const Value: T);
begin
  FValue := Value;
  FIsNull := false;
end;

end.
