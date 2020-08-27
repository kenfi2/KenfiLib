MonsterLib = {
	getDescription = function(self)
		return getMonsterInfo(self:getName()).description
	end,
}

function Monster(uid)
	if tonumber(uid) then
		return setmetatable({id = uid}, {__index = setmetatable(MonsterLib, {__index = Creature(uid)})})
	elseif getmetatable(uid) and Creature(uid):isMonster() then
		uid = Creature(uid)
		return setmetatable({id = uid:getId()}, {__index = setmetatable(MonsterLib, {__index = uid})})
	elseif getCreatureByName(uid) then
		if isMonster(getCreatureByName(uid)) then
			return setmetatable({id = getCreatureByName(uid)}, {__index = setmetatable(MonsterLib, {__index = Creature(getCreatureByName(uid))})})
		end
	end
end