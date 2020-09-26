return setmetatable(
{
	isNpc = function() return true end,
	setMasterPos = function(self)
		--
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
			if var:isNpc() then
				return Npc(var:getId())
			end
		end
		if isNpc(id) then
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
		return error("attempt to create metatable 'Npc' (not npc value)")
	end,
}
)--