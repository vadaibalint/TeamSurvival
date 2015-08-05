lua_miner_refine_resource = class ({})

function lua_miner_refine_resource:OnToggle(keys)
	local event_data = { active = self:GetToggleState(), items = GameRules.GameMode:GetItems(self:GetCaster()) }
	CustomGameEventManager:Send_ServerToPlayer(self:GetCaster().player, "event_refine_resource_ability_used", event_data)
end
