lua_alchemist_craft_potion = class ({})

function lua_alchemist_craft_potion:OnToggle(keys)	
	local event_data = { active = self:GetToggleState(), items = GameRules.GameMode:GetItems(self:GetCaster()) }
	CustomGameEventManager:Send_ServerToPlayer(self:GetCaster().player, "event_craft_potion_ability_used", event_data)
end
