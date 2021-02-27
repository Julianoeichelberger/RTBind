unit RTBind.Mapping.Defaults;

interface

uses RTBind.Mapping.Custom;

type

  [Control('TEdit')]
  [Control('TMaskEdit')]
  [Control('TButtonedEdit')]
  [Control('TSpinEdit', 'Value')]
  [Control('TCheckBox', 'Checked')]
  [Control('TRadioGroup', 'ItemIndex')]
  [Control('TComboBox', 'ItemIndex')]
  [Control('TColorBox', 'Selected')]
  [Control('TDateTimePicker', 'Date')]
  [Control('TListBox', 'Lines.Text')]
  [Control('TStaticText', 'Caption')]
  [Control('TMemo', 'Lines.Text')]
  [Control('TCheckListBox', 'Items.Text')]
  [Control('TRichEdit', 'Lines.Text')]
  IRTBindMappingDelphi = Interface
    ['{55822394-425E-4CDA-8C65-3136B2153903}']
  End;

  [Control('TcxTextEdit')]
  [Control('TcxMaskEdit')]
  [Control('TcxButtonEdit')]
  [Control('TcxHyperLinkEdit')]
  [Control('TcxFontNameComboBox')]
  [Control('TdxTokenEdit')]
  [Control('TcxCheckBox', 'Checked')]
  [Control('TcxRadioGroup', 'ItemIndex')]
  [Control('TcxComboBox', 'ItemIndex')]
  [Control('TcxTrackBar', 'Position')]
  [Control('TcxMemo', 'Lines.Text')]
  [Control('TcxRichEdit', 'Lines.Text')]
  [Control('TcxColorComboBox', 'ColorValue')]
  [Control('TdxColorEdit', 'ColorValue')]
  [Control('TdxRatingControl', 'Rating')]
  [Control('TcxSpinEdit', 'Value')]
  [Control('TcxCalcEdit', 'Value')]
  [Control('TcxCurrencyEdit', 'Value')]
  [Control('TcxListBox', 'Lines.Text')]
  [Control('TcxDateEdit', 'Date')]
  [Control('TcxTimeEdit', 'Time')]
  IRTBindMappingDevExpress = Interface
    ['{FD4BC29C-0572-49E8-A8C5-E20170F13E20}']
  End;

  [Control('TAdvSearchEdit')]
  [Control('TAdvSmoothCalculator', 'FloatValue')]
  [Control('TAdvSmoothSpinEdit', 'Value')]
  [Control('TAdvRichEditor', 'Lines.Text')]
  [Control('TAdvSmoothListBox', 'SelectedItemIndex')]
  [Control('TAdvSmoothComboBox', 'SelectedItemIndex')]
  [Control('TAdvSmoothTrackBar', 'Position')]
  [Control('TAdvSmoothDatePicker', 'Date')]
  IRTBindMappingTMSAdv = Interface
    ['{FD4BC29C-0572-49E8-A8C5-E20170F13E20}']
  End;

  [Control('TCurvyEdit')]
  [Control('TCurvyMemo', 'Lines.Text')]
  [Control('TCurvyCombo', 'ItemIndex')]
  IRTBindMappingTMSCurvy = Interface
    ['{0D124839-8AB9-497D-8C60-595437F681EE}']
  End;

implementation

end.
