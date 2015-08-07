function OnComaCreated(keys)
        local hero = keys.caster
        Timers:CreateTimer("ComaTimer", { endTime = 1, callback = function()
                        GameMode:AddEnergy(hero, 1)
                        local event_data = { energy = hero.energy }
                        CustomGameEventManager:Send_ServerToPlayer(hero.player, "event_resource_change", event_data)
                        return 1
                end})
end

function OnComaDestroy(keys)
        -- Naming conflict?
        Timers:RemoveTimer("ComaTimer")
        GameMode:AddEnergyTimer(keys.caster, 1, -1)
end

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


        -- move to SpellStart?
        local tree = keys.target

        if tree.health then
                tree.health = tree.health - 1
                if tree.health == 0 then
                        tree:CutDown(caster:GetTeamNumber())
                end
        else
                tree.health = 5
        end
end

function CampFireAura(keys)
        local caster = keys.caster
        local unitsInRange = FindUnitsInRadius(caster:GetTeam(), caster:GetAbsOrigin(), nil, 500, DOTA_UNIT_TARGET_TEAM_FRIENDLY,
                                DOTA_UNIT_TARGET_HERO, DOTA_UNIT_TARGET_FLAG_NONE, FIND_ANY_ORDER, false)

        for _,hero in pairs(unitsInRange) do
                if hero.heat then
                        GameMode:AddHeat(hero, 2)
                        local event_data = { heat = hero.heat }
                        CustomGameEventManager:Send_ServerToPlayer(hero.player, "event_resource_change", event_data)
                end
        end
end
