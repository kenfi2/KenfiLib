Condition = setmetatable(
{
	
},
{
	__call = function(this, conditionType, conditionId)
		return setmetatable({condition = createConditionObject(conditionType, 0, false, 0, conditionId)}, {__index = this, __eq = eq_event(a, b)})
	end,
}
)