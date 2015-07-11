function SleepingEnergyRegenStart(keys) 
	local player = keys.caster:GetPlayerOwner()

	Timers:CreateTimer("SleepingEnergyRegenTimer", {callback = function()
			print("SleepingEnergyRegen: " .. player.energy .. " --> " .. player.energy + 5)
    		player.energy = player.energy + 5
    		local event_data = {
				energy = player.energy
			}
		
			CustomGameEventManager:Send_ServerToPlayer(player, "event_resource_change", event_data)

    		return 1
    	end
	})
	print("regenTimer added.")
end

function SleepingEnergyRegenStop()
	Timers:RemoveTimer("SleepingEnergyRegenTimer")
	print("regenTimer removed.")
end

function GainLumber(keys)
	local player = keys.caster:GetPlayerOwner()
	player.lumber = player.lumber + 1

	local event_data = {
				lumber = player.lumber
			}
		
	CustomGameEventManager:Send_ServerToPlayer(player, "event_resource_change", event_data)
end

function AddMinerAbilities(keys)
	local caster = keys.caster
	if caster:FindAbilityByName("datadriven_miner_mine") then
		print("already a miner")
		-- show error msg
	else
		caster:AddAbility("datadriven_miner_mine")
		caster:AddAbility("datadriven_miner_chopchop")
		print("IM A MINER !!")
	end
end
