lua_builder_craft_building = class ({})

function lua_builder_craft_building:OnToggle(keys)	
	local event_data = { active = self:GetToggleState(), items = GameRules.GameMode:GetItems(self:GetCaster()) }
	CustomGameEventManager:Send_ServerToPlayer(self:GetCaster().player, "event_craft_building_ability_used", event_data)
end
