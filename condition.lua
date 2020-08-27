ConditionLib = {
	--
}

function Condition(conditionType, conditionId)
	conditionId = conditionId or CONDITIONID_COMBAT
	return setmetatable({condition = createConditionObject(conditionType, 0, false, 0, conditionId)}, {__index = ConditionLib})
end