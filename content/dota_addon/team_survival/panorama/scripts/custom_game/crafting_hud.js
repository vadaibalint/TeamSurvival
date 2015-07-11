GameEvents.Subscribe( "event_craft_item_ability_used", OnCraftItemAbilityEvent);
GameEvents.Subscribe( "event_craft_building_ability_used", OnCraftBuildingAbilityEvent);
GameEvents.Subscribe( "event_craft_potion_ability_used", OnCraftPotionAbilityEvent);

function OnCraftItemAbilityEvent(event_data)
{
	if (event_data.active){
		$("#itemCrafting").visible = true;
	} else{
		$("#itemCrafting").visible = false;
	}
}

function OnCraftBuildingAbilityEvent(event_data)
{
	if (event_data.active){
		$("#buildingCrafting").visible = true;
	} else{
		$("#buildingCrafting").visible = false;
	}
}

function OnCraftPotionAbilityEvent(event_data)
{
	if (event_data.active){
		$("#potionCrafting").visible = true;
	} else{
		$("#potionCrafting").visible = false;
	}
}
 
function OnButtonPressed(button)
{
	$.Msg("OnButtonPressed -> ", button);
}