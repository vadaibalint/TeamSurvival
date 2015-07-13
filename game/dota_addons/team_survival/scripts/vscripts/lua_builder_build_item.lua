lua_builder_build_item = class ({})

function lua_builder_build_item:OnToggle(keys)
	local event_data = { active = self:GetToggleState(), items = GameRules.GameMode:GetItems(self:GetCaster()) }
	CustomGameEventManager:Send_ServerToPlayer(self:GetCaster().player, "event_craft_item_ability_used", event_data)
end
