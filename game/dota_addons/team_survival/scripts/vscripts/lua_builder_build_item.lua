lua_builder_build_item = class ({})

function lua_builder_build_item:OnSpellStart(keys)
	print("Trying to build item")
	--local caster = self:GetCaster()
	local items = GameRules.GameMode:GetItems(self:GetCaster())
	DeepPrintTable(items)
	if items["item_team_survival_wood"] > 2 and items["item_team_survival_rock"] > 0 then
		print("2,1 -> spear")
	elseif items["item_team_survival_wood"] > 0 and items["item_team_survival_rock"] > 1 then
		print("1,2 -> axe")
	end
end
