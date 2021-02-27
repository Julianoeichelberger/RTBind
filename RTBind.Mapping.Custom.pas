unit RTBind.Mapping.Custom;

interface

Uses
  System.Classes, System.Rtti, System.Generics.Collections;

type
  TClassName = string;
  TPropertyName = string;

  Control = class(TCustomAttribute)
  private
    FPropName: TPropertyName;
    FControlClass: TClassName;
  public
    constructor Create(AControlClass: TClassName; APropName: TPropertyName = 'Text');

    property ControlClass: TClassName read FControlClass;
    property PropName: TPropertyName read FPropName;
  end;

implementation


{ Control }

constructor Control.Create(AControlClass: TClassName; APropName: TPropertyName);
begin
  FControlClass := AControlClass;
  FPropName := APropName;
end;

end.
