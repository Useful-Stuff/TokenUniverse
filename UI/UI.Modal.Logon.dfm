object LogonDialog: TLogonDialog
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  Caption = 'Logon user'
  ClientHeight = 344
  ClientWidth = 312
  Color = clBtnFace
  Constraints.MinHeight = 320
  Constraints.MinWidth = 266
  DoubleBuffered = True
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  ShowHint = True
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object LabelType: TLabel
    Left = 8
    Top = 8
    Width = 58
    Height = 13
    Caption = 'Logon type:'
  end
  object LabelGroups: TLabel
    Left = 8
    Top = 116
    Width = 296
    Height = 17
    Alignment = taCenter
    Anchors = [akLeft, akTop, akRight]
    AutoSize = False
    Caption = 'Additional groups (requires Tcb privilege)'
  end
  object ComboLogonType: TComboBox
    Left = 8
    Top = 27
    Width = 296
    Height = 21
    Style = csDropDownList
    Anchors = [akLeft, akTop, akRight]
    ItemIndex = 1
    TabOrder = 0
    Text = 'Interactive'
    OnChange = ComboLogonTypeChange
    Items.Strings = (
      'S4U (without a password)'
      'Interactive'
      'Network'
      'Network clear text'
      'New credentials'
      'Unlock'
      'Batch'
      'Service')
  end
  object ButtonCancel: TButton
    Left = 8
    Top = 311
    Width = 75
    Height = 25
    Anchors = [akLeft, akBottom]
    Cancel = True
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 5
  end
  object ButtonContinue: TButton
    Left = 229
    Top = 311
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = 'Continue'
    Default = True
    TabOrder = 3
    OnClick = ButtonContinueClick
  end
  object ButtonAddSID: TButton
    Left = 118
    Top = 311
    Width = 78
    Height = 25
    Anchors = [akBottom]
    Caption = 'Add SID'
    ImageIndex = 1
    ImageMargins.Left = 3
    ImageMargins.Top = 1
    Images = FormMain.SmallIcons
    TabOrder = 2
    OnClick = ButtonAddSIDClick
  end
  object GroupBoxSource: TGroupBox
    Left = 8
    Top = 54
    Width = 296
    Height = 54
    Anchors = [akLeft, akTop, akRight]
    Caption = 'Token Source '
    TabOrder = 1
    object EditSourceName: TEdit
      Left = 45
      Top = 21
      Width = 83
      Height = 21
      Enabled = False
      MaxLength = 8
      TabOrder = 0
      Text = 'TOK_UNIV'
    end
    object StaticSourceName: TStaticText
      Left = 8
      Top = 24
      Width = 35
      Height = 17
      Caption = 'Name:'
      TabOrder = 1
    end
    object StaticSourceLuid: TStaticText
      Left = 135
      Top = 24
      Width = 31
      Height = 17
      Caption = 'LUID:'
      TabOrder = 2
    end
    object EditSourceLuid: TEdit
      Left = 167
      Top = 21
      Width = 89
      Height = 21
      Anchors = [akLeft, akTop, akRight]
      Enabled = False
      TabOrder = 3
      Text = '0'
    end
    object ButtonAllocLuid: TButton
      Left = 262
      Top = 20
      Width = 25
      Height = 23
      Hint = 'Allocate new Locally Unique Identifier'
      Anchors = [akTop, akRight]
      Enabled = False
      ImageIndex = 4
      ImageMargins.Left = 2
      ImageMargins.Top = 1
      Images = FormMain.SmallIcons
      TabOrder = 4
      OnClick = ButtonAllocLuidClick
    end
  end
  inline FrameGroups: TFrameGroups
    Left = 8
    Top = 137
    Width = 296
    Height = 168
    Anchors = [akLeft, akTop, akRight, akBottom]
    TabOrder = 4
    inherited ListView: TListViewEx
      AlignWithMargins = False
      Left = 0
      Top = 0
      Width = 296
      Height = 168
      PopupMenu = PopupMenu
      OnDblClick = MenuEditClick
    end
  end
  object PopupMenu: TPopupMenu
    Left = 208
    Top = 64
    object MenuEdit: TMenuItem
      Caption = 'Edit'
      ShortCut = 113
      OnClick = MenuEditClick
    end
    object MenuRemove: TMenuItem
      Caption = 'Remove'
      ShortCut = 46
      OnClick = MenuRemoveClick
    end
  end
end
