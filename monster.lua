return setmetatable(
{
	isMonster = function(self) return true end,
	getDescription = function(self)
		return getMonsterInfo(self:getName()).description
	end,
	getType = function(self)
		return MonsterType(self)
	end,
},
{
	__index = Creature,
	__call = function(this, var)
		local id = 0
		if isNumber(var) then
			id = tonumber(var)
		elseif isString(var) then
			if getCreatureByName(var) then
				id = getCreatureByName(var)
			end
		elseif isMetatable(var) then
			if var:isMonster() then
				return Monster(var:getId())
			end
		end
		if isMonster(id) then
			return setmetatable(
				{
					id = id
				},
				{
					__index = this,
					__unm = function(self)
						local id = self.id
						return Creature(id)
					end,
				}
			)
		end
		return error("attempt to create metatable 'Monster' (not monster value)")
	end,
}
)
