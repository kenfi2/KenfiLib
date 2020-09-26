return setmetatable( 
{
	getId = function(self)
		return self.id
	end,
	getClientId = function(self)
		--
	end,
	getName = function(self)
		return self.name
	end,
	getDescription = function(self)
		return self.description
	end,
	getRequiredSkillTries = function(self)
		-- called with player function
	end,
	getRequiredManaSpent = function(self)
		-- called with player function
	end,
	getCapacityGain = function(self)
		return self.capacity
	end,
	getHealthGain = function(self)
		return self.healthGain
	end,
	getHealthGainTicks = function(self)
		return self.healthGainTicks
	end,
	getHealthGainAmount = function(self)
		return self.healthGainAmount
	end,
	getManaGain = function(self)
		return self.manaGain
	end,
	getManaGainTicks = function(self)
		return self.manaGainTicks
	end,
	getManaGainAmount = function(self)
		return self.manaGainAmount
	end,
	getMaxSoul = function(self)
		return self.soul
	end,
	getSoulGainTicks = function(self)
		return self.soulTicks
	end,
	getAttackSpeed = function(self)
		return self.attackSpeed
	end,
	getBaseSpeed = function(self)
		return self.baseSpeed
	end,
	getDemotion = function(self)
		return Vocation(self.fromVocation)
	end,
	getPromotion = function(self)
		return Vocation(self.promotedVocation)
	end,
},
{
	__call = function(this, uid)
		local id = 0
		if isTable(uid) then
			id = uid.id
		elseif isNumber(uid) then
			id = tonumber(uid)
		end
		return setmetatable(getVocationInfo(id), {__index = this, __eq = eq_event})
	end,
}
)--