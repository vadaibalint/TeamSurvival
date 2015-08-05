lua_miner_gather_resource = class ({})

function lua_miner_gather_resource:CastFilterResultTarget(target)
	if target:GetClassname() == "ent_dota_tree" or
		target:GetUnitName() == "team_survival_rock" then
		return UF_SUCCESS
	else
		return UF_FAIL_CUSTOM
	end
end

function lua_miner_gather_resource:GetCustomCastErrorTarget( hTarget )
	return "#dota_hud_error_cant_cast_on_non_rock__or_wood"
end

function lua_miner_gather_resource:OnSpellStart()
	local caster = self:GetCaster()
	local ability = caster:FindAbilityByName("lua_miner_gather_resource")
	local gatherLvl = ability:GetLevel()
	local target = self:GetCursorTarget()
	local tree = false
	
	if (target:GetClassname() == "ent_dota_tree") then
		tree = true
	else
		tree = false
	end

	if not target.health then
		target.health = 5
	end

	-- Timer name conflict?
	Timers:CreateTimer("ResourceGathering", {endTime = 5, callback =
		function ()
			if target:IsAlive() then
				local drops = {}

				if tree then
					drops = lua_miner_gather_resource:GetWoodDrops(gatherLvl)
				else
					drops = lua_miner_gather_resource:GetRockDrops(gatherLvl)
				end

				lua_miner_gather_resource:DropItems(drops, caster, target)
				
				target.health = target.health - 1

				if target.health == 0 then
					if tree then
						target:CutDown(caster:GetTeamNumber())
					else
						target:Kill(ability, caster)
					end
					caster:Interrupt()
				end
			else
				caster:Interrupt()
			end
			
			return 1
		end}
	)
end

function lua_miner_gather_resource:OnChannelFinish(interrupted)
	-- Timer name conflict?
	Timers:RemoveTimer("ResourceGathering")
end

function lua_miner_gather_resource:GetWoodDrops(gatherLvl)
	local drops = {}
	if gatherLvl == 1 then
		lua_miner_gather_resource:AddDrop(drops, 25, "item_team_survival_wood")
	elseif gatherLvl == 2 then
		lua_miner_gather_resource:AddDrop(drops, 75, "item_team_survival_wood")
		lua_miner_gather_resource:AddDrop(drops, 25, "item_team_survival_wood")
	elseif gatherLvl == 3 then
		lua_miner_gather_resource:AddDrop(drops, 100, "item_team_survival_wood")
		lua_miner_gather_resource:AddDrop(drops, 50, "item_team_survival_wood")
		lua_miner_gather_resource:AddDrop(drops, 25, "item_team_survival_wood")
	elseif gatherLvl == 4 then
		lua_miner_gather_resource:AddDrop(drops, 100, "item_team_survival_wood")
		lua_miner_gather_resource:AddDrop(drops, 100, "item_team_survival_wood")
		lua_miner_gather_resource:AddDrop(drops, 50, "item_team_survival_wood")
		lua_miner_gather_resource:AddDrop(drops, 25, "item_team_survival_wood")
	end

	return drops
end

function lua_miner_gather_resource:GetRockDrops(gatherLvl)
	local drops = {}
	if gatherLvl == 1 then
		lua_miner_gather_resource:AddDrop(drops, 25, "item_team_survival_rock")
	elseif gatherLvl == 2 then
		lua_miner_gather_resource:AddDrop(drops, 75, "item_team_survival_rock")
		lua_miner_gather_resource:AddDrop(drops, 25, "item_team_survival_rock")
	elseif gatherLvl == 3 then
		lua_miner_gather_resource:AddDrop(drops, 100, "item_team_survival_rock")
		lua_miner_gather_resource:AddDrop(drops, 50, "item_team_survival_rock")
		lua_miner_gather_resource:AddDrop(drops, 25, "item_team_survival_rock")
	elseif gatherLvl == 4 then
		lua_miner_gather_resource:AddDrop(drops, 100, "item_team_survival_rock")
		lua_miner_gather_resource:AddDrop(drops, 100, "item_team_survival_rock")
		lua_miner_gather_resource:AddDrop(drops, 50, "item_team_survival_rock")
		lua_miner_gather_resource:AddDrop(drops, 25, "item_team_survival_rock")
	end

	return drops
end

function lua_miner_gather_resource:AddDrop(drops, chance, itemName)
	if chance == 100 or RollPercentage(chance) then
		table.insert(drops, itemName)
	end
end

function lua_miner_gather_resource:DropItems(drops, caster, target)
	local dir = (caster:GetAbsOrigin() - target:GetAbsOrigin()):Normalized()
	for i,itemName in ipairs(drops) do
        local item = CreateItem(itemName, nil, nil)
        item:SetPurchaseTime(0)
        local pos = caster:GetAbsOrigin() + (dir * 100) + RandomVector(RandomFloat(50,100))
        local drop = CreateItemOnPositionSync(pos, item)
        item:LaunchLoot(false, 200, 0.75, pos)
	end
end
