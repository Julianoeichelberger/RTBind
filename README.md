# RTBind

It's a simple lib to use livebindings in runtime

Example:

TObjectDTO = class  
    id: Integer;    
    name: string;   
    last_updated: TDatetime;    
    active: boolean;    
    obs: string;    
end;    
    


TForm1 = class(TForm)   
     edtName: TEdit;  
     edtDate: TDateTimePicker;    
      mmoObs: TMemo;   
     ckbAtivo: TCheckBox; 
      procedure FormCreate(Sender: TObject);   
      procedure BtSaveClick(Sender: TObject);  
private 
      FObject: TObjectDTO  
      FBind: TRTBindManager;   
end;    

procedure TForm1.FormCreate(Sender: TObject);   
begin   
  TRTBindMapping.Register<IRTBindMappingDelphi>;        
    
  FObject := TObjectDTO.Create;         
  FObject.name := 'Name';   
  FObject.last_updated := now;  
  FObject.active := true;   
  FObject.obs := 'Just for test';   
     
  FBind := TRTBindManager.Create;   
  FBind.Link(FObject, 'name', edtName); 
  FBind.Link(FObject, 'obs', mmoObs);   
  FBind.Link(FObject, 'active', ckbAtivo);  
  FBind.Link(FObject, 'last_updated', edtDate);     
end;

procedure TForm1.BtSaveClick(Sender: TObject);  
begin   
  FBind.NotifyControls;     
end;    

