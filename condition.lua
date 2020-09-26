return setmetatable(
{
	setTicks = function(self, value)
		setConditionParam(self.condition, CONDITION_PARAM_TICKS, value)
	end,
	setParameter = function(self, key, value)
		setConditionParam(self.condition, key, value)
	end,
	setFormula = function(self, ...)
		setConditionFormula(self.condition, ...)
	end,
	setOutfit = function(self, outfit)
		print(outfit.lookType)
		addOutfitCondition(self.condition, outfit)
	end,
	addDamage = function(self, rounds, time, value)
		addDamageCondition(self.condition, rounds, time, value)
	end,
},
{
	__call = function(this, conditionType, conditionId)
		return setmetatable({condition = createConditionObject(conditionType, 0, false, 0, conditionId), id = conditionId}, {__index = this, __eq = eq_event})
	end,
}
)--