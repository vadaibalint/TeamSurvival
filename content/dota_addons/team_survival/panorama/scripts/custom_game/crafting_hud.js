var isUIActive = false;

(function()
{
	GameEvents.Subscribe( "event_craft_item_ability_used", OnCraftItemAbilityEvent);
	GameEvents.Subscribe( "event_craft_building_ability_used", OnCraftBuildingAbilityEvent);
	GameEvents.Subscribe( "event_craft_potion_ability_used", OnCraftPotionAbilityEvent);
	// TODO listen to inventory change event -> update the buttons
	// if inventory change event is listened to hten scheduled update can be disregarded
})();

function UpdateCraftingUI()
{
	
	var items = GetItemsInInventory();
	var buttons = $("#itemCrafting").FindChildrenWithClassTraverse("craftingButton");
	for (var i = 0; i < buttons.length; i++) {
		// CraftItem lvl can be passed so lvlreq can be checked as well
		UpdateCraftingButton(buttons[i], items);
	};

	buttons = $("#buildingCrafting").FindChildrenWithClassTraverse("craftingButton");
	for (var i = 0; i < buttons.length; i++) {
		// CraftItem lvl can be passed so lvlreq can be checked as well
		UpdateCraftingButton(buttons[i], items);
	};

	if(isUIActive) {
		$.Schedule(0.1, UpdateCraftingUI);
	};
}

function GetItemsInInventory()
{
	var inventory = Game.GetPlayerItems(Players.GetLocalPlayer()).inventory;
	var items = {};
	for (var i = 0; i <= 5; i++) {
		if(inventory[i]){
			var itemName = inventory[i].item_name;
			items[itemName] = items[itemName] || 0;
			items[itemName]++;
		} else {
			continue;
		}
	};

	return items;
}

function UpdateCraftingButton(button, items)
{
	switch(button.id){
		// ----------- ITEMS -----------
		case "item_team_survival_wooden_hammer":
			SetCraftableFlag(button, items, ["item_team_survival_wood", "4"]);
			break;
		case "item_team_survival_wooden_axe":
			SetCraftableFlag(button, items, ["item_team_survival_wood", "3"]);
			break;
		case "item_team_survival_wooden_sword":
			SetCraftableFlag(button, items, ["item_team_survival_wood", "3"]);
			break;
		case "item_team_survival_stone_hammer":
			SetCraftableFlag(button, items, ["item_team_survival_wood", "2", "item_team_survival_rock", "2"]);
			break;
		case "item_team_survival_stone_axe":
			SetCraftableFlag(button, items, ["item_team_survival_wood", "2", "item_team_survival_rock", "1"]);
			break;
		case "item_team_survival_stone_sword":
			SetCraftableFlag(button, items, ["item_team_survival_wood", "1", "item_team_survival_rock", "2"]);
			break;
		// ----------- BUIDLINGS -----------
		case "item_team_survival_building_campfire":
			SetCraftableFlag(button, items, ["item_team_survival_wood", "1", "item_team_survival_rock", "1"]);
			break;
		// ----------- POTIONS -----------
		default:
			break;
	}
}

function SetCraftableFlag(button, items, req)
{
	var craftable = true;
	for (var i = 0; i < req.length; i+=2) {
        if (!items[req[i]] || items[req[i]] < req[i+1]){
        	craftable = false;
        	break;
        }
    }

    button.SetHasClass("craftable", craftable);
    button.iscraftable = craftable;
    button.requirement = req;
}

function OnCraftItemAbilityEvent(event_data)
{
	if (event_data.active){
		$("#itemCrafting").visible = true;
	} else{
		$("#itemCrafting").visible = false;
	}

	isUIActive = !isUIActive;
	UpdateCraftingUI();
}

function OnCraftBuildingAbilityEvent(event_data)
{
	if (event_data.active){
		$("#buildingCrafting").visible = true;
	} else{
		$("#buildingCrafting").visible = false;
	}

	isUIActive = !isUIActive;
	UpdateCraftingUI();
}

function OnCraftPotionAbilityEvent(event_data)
{
	if (event_data.active){
		$("#potionCrafting").visible = true;
	} else{
		$("#potionCrafting").visible = false;
	}
}
 
function OnButtonPressed(id)
{
	$.Msg("OnButtonPressed -> ", id);
	var button = $("#" + id);
	$.Msg("isCraftable -> ", button.iscraftable);
	if (button.iscraftable){
		// do smth
		// send cost?
		$.Msg("Button req. -> ", button.requirement);
		GameEvents.SendCustomGameEventToServer( "event_craft_ability_used", { "id" : id, "requirement" : button.requirement } );
	}
}