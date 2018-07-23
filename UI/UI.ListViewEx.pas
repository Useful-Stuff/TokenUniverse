unit UI.ListViewEx;

interface

uses
  System.SysUtils, System.Classes, Vcl.Controls, Vcl.ComCtrls, Vcl.Graphics;

type
  TListItemsEx = class;
  TListItemEx = class(TListItem)
  private
    FColor: TColor;
    FColorEnabled: Boolean;
    procedure SetColor(const Value: TColor);
    function GetOwnerItems: TListItemsEx;
  public
    constructor Create(AOwner: TListItems); override;
    property Color: TColor read FColor write SetColor;
    property ColorEnabled: Boolean read FColorEnabled write FColorEnabled;
    property Owner: TListItemsEx read GetOwnerItems;
  end;

  TListViewEx = class;
  TListItemsEx = class(TListItems)
  private
    function GetOwnerListView: TListViewEx;
  protected
    function GetItem(Index: Integer): TListItemEx;
  procedure SetItem(Index: Integer; Value: TListItemEx);
  public
    function Add: TListItemEx;
    function AddItem(Item: TListItemEx; Index: Integer = -1): TListItemEx;
    function Insert(Index: Integer): TListItemEx;
    property Item[Index: Integer]: TListItemEx read GetItem write SetItem; default;
    property Owner: TListViewEx read GetOwnerListView;
  end;

  TListViewEx = class(TListView)
  private
    FColoringItems: Boolean;
    function GetItems: TListItemsEx;
    procedure SetItems(const Value: TListItemsEx);
    procedure SetItemsColoring(const Value: Boolean);
  protected
    function CreateListItem: TListItem; override;
    function CreateListItems: TListItems; override;
    function CustomDrawItem(Item: TListItem; State: TCustomDrawState;
      Stage: TCustomDrawStage): Boolean; override;
    function IsCustomDrawn(Target: TCustomDrawTarget; Stage: TCustomDrawStage):
      Boolean; override;
  public
    property Items: TListItemsEx read GetItems write SetItems;
  published
    property ColoringItems: Boolean read FColoringItems write SetItemsColoring;
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('Token Universe', [TListViewEx]);
end;

{ TListViewEx }

function TListViewEx.CreateListItem: TListItem;
var
  LClass: TListItemClass;
begin
  LClass := TListItemEx;
  if Assigned(OnCreateItemClass) then
    OnCreateItemClass(Self, LClass);
  Result := LClass.Create(Items);
end;

function TListViewEx.CreateListItems: TListItems;
begin
  Result := TListItemsEx.Create(Self);
end;

function TListViewEx.CustomDrawItem(Item: TListItem; State: TCustomDrawState;
  Stage: TCustomDrawStage): Boolean;
begin
  if FColoringItems then
  begin
    if (Item as TListItemEx).FColorEnabled then
      Canvas.Brush.Color := (Item as TListItemEx).FColor
    else
      Canvas.Brush.Color := Color;
  end;
  Result := inherited;
end;

function TListViewEx.GetItems: TListItemsEx;
begin
  Result := inherited Items as TListItemsEx
end;

function TListViewEx.IsCustomDrawn(Target: TCustomDrawTarget;
  Stage: TCustomDrawStage): Boolean;
begin
  if Target = dtItem then
    Result := FColoringItems or inherited
  else
    Result := inherited;
end;

procedure TListViewEx.SetItems(const Value: TListItemsEx);
begin
  inherited Items := Value;
end;

procedure TListViewEx.SetItemsColoring(const Value: Boolean);
begin
  FColoringItems := Value;
  if FColoringItems then
    Repaint;
end;

{ TListItemsEx }

function TListItemsEx.Add: TListItemEx;
begin
  Result := AddItem(nil, -1);
end;

function TListItemsEx.AddItem(Item: TListItemEx; Index: Integer): TListItemEx;
begin
  Result := inherited AddItem(Item, Index) as TListItemEx;
end;

function TListItemsEx.GetItem(Index: Integer): TListItemEx;
begin
  Result := inherited GetItem(Index) as TListItemEx;
end;

function TListItemsEx.GetOwnerListView: TListViewEx;
begin
  Result := inherited Owner as TListViewEx;
end;

function TListItemsEx.Insert(Index: Integer): TListItemEx;
begin
  Result := inherited Insert(Index) as TListItemEx;
end;

procedure TListItemsEx.SetItem(Index: Integer; Value: TListItemEx);
begin
  inherited SetItem(Index, Value);
end;

{ TListItemEx }

constructor TListItemEx.Create(AOwner: TListItems);
begin
  inherited;
  FColor := clWindow;
end;

function TListItemEx.GetOwnerItems: TListItemsEx;
begin
  Result := inherited Owner as TListItemsEx;
end;

procedure TListItemEx.SetColor(const Value: TColor);
begin
  FColorEnabled := True;
  FColor := Value;
  if Owner.Owner.ColoringItems then
    Owner.Owner.Repaint;
end;

end.