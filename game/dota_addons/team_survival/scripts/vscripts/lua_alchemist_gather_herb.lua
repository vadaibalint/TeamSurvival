lua_alchemist_gather_herb = class ({})

function lua_alchemist_gather_herb:CastFilterResultTarget(target)
	if target:GetUnitName() == "team_survival_mushroom" or
		target:GetUnitName() == "team_survival_cattail" then
		return UF_SUCCESS
	else
		return UF_FAIL_CUSTOM
	end
end

function lua_alchemist_gather_herb:GetCustomCastErrorTarget( hTarget )
	return "#dota_hud_error_cant_cast_on_non_herb"
end

function lua_alchemist_gather_herb:OnSpellStart(keys)
	local caster = self:GetCaster()
	local gatherHerbLvl = caster:FindAbilityByName("lua_alchemist_gather_herb"):GetLevel()
	local target = self:GetCursorTarget()

	for i=1,gatherHerbLvl do
        local item = CreateItem("item_" .. target:GetUnitName(), nil, nil)
        item:SetPurchaseTime(0)
        local pos = caster:GetAbsOrigin()
        local drop = CreateItemOnPositionSync(pos, item)
        local pos_launch = pos+RandomVector(RandomFloat(150,200))
        item:LaunchLoot(false, 200, 0.75, pos_launch)
	end
end
