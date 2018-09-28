object DialogRestrictToken: TDialogRestrictToken
  Left = 0
  Top = 0
  Caption = 'Create Restricted Token'
  ClientHeight = 410
  ClientWidth = 355
  Color = clBtnFace
  DoubleBuffered = True
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  ShowHint = True
  OnClose = FormClose
  OnCreate = FormCreate
  DesignSize = (
    355
    410)
  PixelsPerInch = 96
  TextHeight = 13
  object ButtonOK: TButton
    Left = 276
    Top = 380
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = 'OK'
    Default = True
    TabOrder = 0
    OnClick = ButtonOKClick
  end
  object ButtonCancel: TButton
    Left = 195
    Top = 380
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = 'Cancel'
    TabOrder = 1
    OnClick = DoCloseForm
  end
  object PageControl1: TPageControl
    Left = 4
    Top = 6
    Width = 347
    Height = 351
    ActivePage = TabSheetSidDisable
    Anchors = [akLeft, akTop, akRight, akBottom]
    TabOrder = 2
    object TabSheetSidDisable: TTabSheet
      Caption = 'SIDs to disable'
      object ListViewDisableSID: TGroupListViewEx
        AlignWithMargins = True
        Left = 3
        Top = 3
        Width = 333
        Height = 317
        Align = alClient
        Checkboxes = True
        Columns = <
          item
            Caption = 'SID'
            Width = 220
          end
          item
            Caption = 'State'
            Width = 110
          end
          item
            Caption = 'Flags'
            Width = 120
          end>
        FullDrag = True
        GridLines = True
        MultiSelect = True
        ReadOnly = True
        RowSelect = True
        TabOrder = 0
        ViewStyle = vsReport
        ColoringItems = True
      end
    end
    object TabSheetSidRestict: TTabSheet
      Caption = 'SIDs to restrict'
      ImageIndex = 1
      DesignSize = (
        339
        323)
      object CheckBoxWriteRestrict: TCheckBox
        Left = 187
        Top = 299
        Width = 149
        Height = 17
        Hint = 'Consider restricting SIDs only when evaluating write access.'
        Anchors = [akRight, akBottom]
        Caption = 'Write restricted'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 0
      end
      object ListViewRestrictSID: TGroupListViewEx
        AlignWithMargins = True
        Left = 3
        Top = 3
        Width = 333
        Height = 289
        Margins.Bottom = 31
        Align = alClient
        Checkboxes = True
        Columns = <
          item
            Caption = 'SID'
            Width = 220
          end
          item
            Caption = 'State'
            Width = 110
          end
          item
            Caption = 'Flags'
            Width = 120
          end>
        FullDrag = True
        GridLines = True
        MultiSelect = True
        ReadOnly = True
        RowSelect = True
        PopupMenu = PopupMenu
        TabOrder = 1
        ViewStyle = vsReport
        OnContextPopup = ListViewRestrictSIDContextPopup
        ColoringItems = True
        PopupOnItemsOnly = True
      end
      object ButtonAddSID: TButton
        Left = 3
        Top = 295
        Width = 78
        Height = 25
        Hint = 'Add a new restricted SID that is not present in the list.'
        Anchors = [akLeft, akBottom]
        Caption = 'Add SID'
        ImageIndex = 1
        ImageMargins.Left = 3
        ImageMargins.Top = 1
        Images = FormMain.SmallIcons
        TabOrder = 2
        OnClick = ButtonAddSIDClick
      end
    end
    object TabSheetPrivDelete: TTabSheet
      Caption = 'Privileges to delete'
      ImageIndex = 2
      DesignSize = (
        339
        323)
      object CheckBoxDisableMaxPriv: TCheckBox
        Left = 6
        Top = 4
        Width = 330
        Height = 17
        Hint = 
          'Ignore the list below and disable all the privileges in the toke' +
          'n except `SeChangeNotifyPrivilege`.'
        Anchors = [akLeft, akTop, akRight]
        Caption = 'Disable maximum privileges'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 0
      end
      object ListViewPrivileges: TPrivilegesListViewEx
        AlignWithMargins = True
        Left = 3
        Top = 26
        Width = 333
        Height = 294
        Margins.Top = 26
        Align = alClient
        Checkboxes = True
        Columns = <
          item
            Caption = 'Privilege name'
            Width = 180
          end
          item
            Caption = 'State'
            Width = 110
          end
          item
            Caption = 'Description'
            Width = 220
          end
          item
            Alignment = taCenter
            Caption = 'LUID'
            Width = 40
          end>
        FullDrag = True
        GridLines = True
        MultiSelect = True
        ReadOnly = True
        RowSelect = True
        TabOrder = 1
        ViewStyle = vsReport
        ColoringItems = True
      end
    end
  end
  object CheckBoxLUA: TCheckBox
    Left = 14
    Top = 363
    Width = 120
    Height = 15
    Hint = 
      'Disable administrative SIDs and delete some privileges as UAC do' +
      'es.'
    Anchors = [akLeft, akBottom]
    Caption = 'LUA token'
    TabOrder = 3
  end
  object CheckBoxSandboxInert: TCheckBox
    Left = 14
    Top = 384
    Width = 120
    Height = 17
    Hint = 
      'Does not check AppLocker rules or apply Software Restriction Pol' +
      'icies for the process with this token.'#13#10#13#10'This action might requ' +
      'ire SeTcbPrivilege to take effect.'
    Anchors = [akLeft, akBottom]
    Caption = 'Sandbox inert'
    TabOrder = 4
  end
  object PopupMenu: TPopupMenu
    Left = 232
    Top = 128
    object MenuEdit: TMenuItem
      Caption = 'Edit'
      OnClick = MenuEditClick
    end
    object MenuRemove: TMenuItem
      Caption = 'Remove'
      OnClick = MenuRemoveClick
    end
  end
end
