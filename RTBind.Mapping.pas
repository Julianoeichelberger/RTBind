unit RTBind.Mapping;

interface

Uses
  System.Classes, System.Generics.Collections, Controls, RTBind.Mapping.Custom;

type
  TRTBindMapping = class
  strict private
    class var FList: TDictionary<TClassName, TPropertyName>;
  private
    class procedure Initialize;
    class procedure ReleaseInstances;
  public
    class procedure Register<I>; overload;
    class procedure Register(const AControlClass: string; const APropName: string = 'Text'); overload;
    class procedure UnRegister<I>; overload;
    class procedure UnRegister(const AControlClass: string); overload;

    class procedure UnRegisterAll;

    class function Prop(const Sender: TCustomControl): string;
  end;

implementation

Uses
  System.TypInfo, System.Rtti, System.SysUtils;

{ TRTBindMapping }

class procedure TRTBindMapping.Initialize;
begin
  FList := TDictionary<TClassName, TPropertyName>.Create;
end;

class procedure TRTBindMapping.ReleaseInstances;
begin
  FList.Free;
end;

class function TRTBindMapping.Prop(const Sender: TCustomControl): string;
begin
  if FList.ContainsKey(Sender.ClassName) then
    Exit(FList.Items[Sender.ClassName]);

  if FList.ContainsKey(Sender.Parent.ClassName) then
    Exit(FList.Items[Sender.Parent.ClassName]);

  raise Exception.Create('Control class not found! Verify your Mappings...');
end;

class procedure TRTBindMapping.Register(const AControlClass, APropName: string);
begin
  FList.Add(AControlClass, APropName);
end;

class procedure TRTBindMapping.Register<I>;
var
  Context: TRttiContext;
  AttrList: TArray<TCustomAttribute>;
  Attr: TCustomAttribute;
begin
  AttrList := Context.GetType(TypeInfo(I)).GetAttributes;
  for Attr in AttrList do
    FList.Add(Control(Attr).ControlClass, Control(Attr).PropName)
end;

class procedure TRTBindMapping.UnRegister(const AControlClass: string);
begin
  FList.Remove(AControlClass);
end;

class procedure TRTBindMapping.UnRegister<I>;
var
  Context: TRttiContext;
  AttrList: TArray<TCustomAttribute>;
  Attr: TCustomAttribute;
begin
  AttrList := Context.GetType(TypeInfo(I)).GetAttributes;
  for Attr in AttrList do
    FList.Remove(Control(Attr).ControlClass)
end;

class procedure TRTBindMapping.UnRegisterAll;
begin
  FList.Clear;
end;

initialization

TRTBindMapping.Initialize;

finalization

TRTBindMapping.ReleaseInstances;

end.
