unit RTBind.Mapping;

interface

Uses
  System.Classes, System.Generics.Collections, Controls, RTBind.Mapping.Custom;

type
  TRTBindMapping = class
  strict private
    class var FClassList: TDictionary<TClassName, TPropertyName>;
  private
    class procedure Initialize;
    class procedure ReleaseInstances;
  public
    class procedure Register<I>; overload;
    class procedure Register(const AControlClass: string; const APropName: string = 'Text'); overload;
    class procedure UnRegister<I>; overload;
    class procedure UnRegister(const AControlClass: string); overload;

    class procedure UnRegisterAll;

    class function Prop(const Sender: TControl): string;
  end;

implementation

Uses
  System.TypInfo, System.Rtti, System.SysUtils;

{ TRTBindMapping }

class procedure TRTBindMapping.Initialize;
begin
  FClassList := TDictionary<TClassName, TPropertyName>.Create;
end;

class procedure TRTBindMapping.ReleaseInstances;
begin
  FClassList.Free;
end;

class function TRTBindMapping.Prop(const Sender: TControl): string;
begin
  if FClassList.ContainsKey(Sender.ClassName) then
    Exit(FClassList.Items[Sender.ClassName]);

  if FClassList.ContainsKey(Sender.Parent.ClassName) then
    Exit(FClassList.Items[Sender.Parent.ClassName]);

  raise Exception.Create('Control class not found! Verify your Mappings...');
end;

class procedure TRTBindMapping.Register(const AControlClass, APropName: string);
begin
  FClassList.Add(AControlClass, APropName);
end;

class procedure TRTBindMapping.Register<I>;
var
  Context: TRttiContext;
  AttrList: TArray<TCustomAttribute>;
  Attr: TCustomAttribute;
begin
  AttrList := Context.GetType(TypeInfo(I)).GetAttributes;
  for Attr in AttrList do
    FClassList.Add(Control(Attr).ControlClass, Control(Attr).PropName)
end;

class procedure TRTBindMapping.UnRegister(const AControlClass: string);
begin
  FClassList.Remove(AControlClass);
end;

class procedure TRTBindMapping.UnRegister<I>;
var
  Context: TRttiContext;
  AttrList: TArray<TCustomAttribute>;
  Attr: TCustomAttribute;
begin
  AttrList := Context.GetType(TypeInfo(I)).GetAttributes;
  for Attr in AttrList do
    FClassList.Remove(Control(Attr).ControlClass)
end;

class procedure TRTBindMapping.UnRegisterAll;
begin
  FClassList.Clear;
end;

initialization

TRTBindMapping.Initialize;

finalization

TRTBindMapping.ReleaseInstances;

end.
