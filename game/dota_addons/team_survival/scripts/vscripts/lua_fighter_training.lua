lua_fighter_training = class ({})
LinkLuaModifier("modifier_lua_fighter_training", LUA_MODIFIER_MOTION_NONE)

function lua_fighter_training:OnInventoryContentsChanged()
	lua_fighter_training:RefreshTrainingModifier(self)
 end

function lua_fighter_training:OnUpgrade()
	lua_fighter_training:RefreshTrainingModifier(self)
 end
 
function lua_fighter_training:RefreshTrainingModifier(params)
 	local caster = params:GetCaster()
 	local trainingLvl = params:GetLevel() + 1
 	local itemArmor = 0
 	local bonusArmor = 0

 	for i=0,5 do
		local itemHandle = caster:GetItemInSlot(i)
		if itemHandle then
			local item = caster:GetItemInSlot(i)
			itemArmor = itemArmor + item:GetSpecialValueFor("armor")
		end
	end

	bonusArmor = itemArmor * trainingLvl

	-- add modifier with +armor
	caster:RemoveModifierByName("modifier_lua_fighter_training")
	print("[TS] removed.")
	caster:AddNewModifier(caster, nil, "modifier_lua_fighter_training", {armor = bonusArmor})
	print("[TS] added.")
end
