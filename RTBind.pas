unit RTBind;

interface

uses
  System.Generics.Collections, System.Bindings.Expression, System.Bindings.EvalProtocol, System.Bindings.Helper,
  Data.Bind.Components, System.Classes;

type
  TRTBindEmpressionList = TObjectList<TBindingExpression>;

  TRTBindManager = class
  private
    FSourceBindings: TRTBindEmpressionList;
    FControlsBindings: TRTBindEmpressionList;
  public
    constructor Create; virtual;
    destructor Destroy; override;

    procedure Clear;
    procedure Notify(ASource: TObject; const APropName: string = '');
    procedure NotifyControls;

    procedure Link(ASource: TObject; const ASourcePropName: string; const ALinkTo: TObject; const ALinkToProp: string;
      const ACreateOptions: TBindings.TCreateOptions = [coNotifyOutput, coEvaluate]); overload;

    procedure Link(ASource: TObject; ASourcePropName: string; ALinkTo: TComponent); overload;
  end;

implementation

uses
  System.SysUtils, RTBind.Mapping;

constructor TRTBindManager.Create;
begin
  FSourceBindings := TRTBindEmpressionList.Create(false);
  FControlsBindings := TRTBindEmpressionList.Create(false);
end;

destructor TRTBindManager.Destroy;
begin
  Clear;
  FControlsBindings.Free;
  FSourceBindings.Free;
  inherited;
end;

procedure TRTBindManager.Clear;
var
  Exp: TBindingExpression;
begin
  for Exp in FSourceBindings do
    TBindings.RemoveBinding(Exp);
  FSourceBindings.Clear;
  for Exp in FControlsBindings do
    TBindings.RemoveBinding(Exp);
  FControlsBindings.Clear;
end;

procedure TRTBindManager.Notify(ASource: TObject; const APropName: string);
begin
  TBindings.Notify(ASource, APropName);
end;

procedure TRTBindManager.NotifyControls;
var
  I: Integer;
begin
  for I := 0 to Pred(FControlsBindings.Count) do
    FControlsBindings.Items[I].EvaluateOutputs;
end;

procedure TRTBindManager.Link(ASource: TObject; const ASourcePropName: string; const ALinkTo: TObject;
  const ALinkToProp: string; const ACreateOptions: TBindings.TCreateOptions);

  function Expression(Obj: TObject; const StrID: string): IScope;
  begin
    Result := TBindings.CreateAssociationScope([Associate(Obj, StrID)]);
  end;

begin
  FSourceBindings.Add(TBindings.CreateManagedBinding([
    Expression(ASource, 'src')], 'src.' + ASourcePropName, [
    Expression(ALinkTo, 'lnk')], 'lnk.' + ALinkToProp, nil, nil, ACreateOptions));

  FControlsBindings.Add(TBindings.CreateManagedBinding([
    Expression(ALinkTo, 'src')], 'src.' + ALinkToProp, [
    Expression(ASource, 'lnk')], 'lnk.' + ASourcePropName, nil, nil, ACreateOptions));
end;

procedure TRTBindManager.Link(ASource: TObject; ASourcePropName: string; ALinkTo: TComponent);
begin
  Link(ASource, ASourcePropName, ALinkTo, TRTBindMapping.Prop(ALinkTo));
end;

end.
