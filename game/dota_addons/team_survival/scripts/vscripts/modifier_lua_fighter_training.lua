modifier_lua_fighter_training = class ({})

function modifier_lua_fighter_training:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS,
	}
 
	return funcs
end

function modifier_lua_fighter_training:GetModifierPhysicalArmorBonus(params)
	return self.armor
end

function modifier_lua_fighter_training:OnCreated(params)
	if IsServer() then
		self.armor = params.armor
		self:SetStackCount(self.armor)
	end
end
