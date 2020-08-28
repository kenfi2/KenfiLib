MonsterLib = {
	getDescription = function(self)
		return getMonsterInfo(self:getName()).description
	end,
}

function Monster(uid)
	if tonumber(uid) and isMonster(uid) then
		return setmetatable({id = uid}, {__index = setmetatable(MonsterLib, {__index = CreatureLib}), __eq = eq_event(a, b)})
	elseif getmetatable(uid) and Creature(uid):isMonster() then
		uid = Creature(uid)
		return setmetatable({id = uid:getId()}, {__index = setmetatable(MonsterLib, {__index = CreatureLib}), __eq = eq_event(a, b)})
	elseif getCreatureByName(uid) then
		if isMonster(getCreatureByName(uid)) then
			return setmetatable({id = getCreatureByName(uid)}, {__index = setmetatable(MonsterLib, {__index = CreatureLib}), __eq = eq_event(a, b)})
		end
	end
end
