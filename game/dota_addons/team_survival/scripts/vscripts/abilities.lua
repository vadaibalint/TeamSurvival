function OnComaCreated(keys)
        local hero = keys.caster
        Timers:CreateTimer("ComaTimer", { endTime = 1, callback = function()
                        GameMode:AddEnergy(hero, 1)
                        local event_data = { energy = hero.energy }
                        CustomGameEventManager:Send_ServerToPlayer(hero.player, "event_energy_change", event_data)
                        return 1
                end})
end

function OnComaDestroy(keys)
        Timers:RemoveTimer("ComaTimer")
        GameMode:AddEnergyTimer(keys.caster, 1, 1)
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
