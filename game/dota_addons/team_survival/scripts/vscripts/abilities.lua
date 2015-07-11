function OnMineFinished(keys)
	local caster = keys.caster
	local mineLvl = caster:FindAbilityByName("datadriven_miner_mine"):GetLevel()

	for i=1,mineLvl do
        local item = CreateItem("item_team_survival_rock", nil, nil)
        item:SetPurchaseTime(0)
        local pos = caster:GetAbsOrigin()
        local drop = CreateItemOnPositionSync(pos, item )
        local pos_launch = pos+RandomVector(RandomFloat(150,200))
        item:LaunchLoot(false, 200, 0.75, pos_launch)
	end
end

function OnChopChopFinished(keys)
	local caster = keys.caster
	local chopChopLvl = caster:FindAbilityByName("datadriven_miner_chopchop"):GetLevel()

	for i=1,chopChopLvl do
        local item = CreateItem("item_team_survival_wood", nil, nil)
        item:SetPurchaseTime(0)
        local pos = caster:GetAbsOrigin()
        local drop = CreateItemOnPositionSync(pos, item )
        local pos_launch = pos+RandomVector(RandomFloat(150,200))
        item:LaunchLoot(false, 200, 0.75, pos_launch)
	end
end
