Guild = setmetatable( 
{
	getId = function(self)
		return self.id
	end,
	getName = function(self)
		return self.name
	end,
	getMembersOnline = function(self)
		local members = {}
		for _, player in ipairs(Game.getPlayers()) do
			if player:getGuild():getId() == self.id then
				table.insert(members, player)
			end
		end
		return members
	end,
	getMotd = function(self)
		return getGuildMotd(self.id)
	end,
	setMotd = function(self, motd)
		--
	end,
},
{
	__call = function(this, var, name)
		if isString(var) then
			var = getGuildId(var)
		elseif isMetatable(var) then
			var = var:getId()
		end
		return setmetatable({id = var, name = name}, {__index = this, __eq = eq_event(a, b)})
	end,
}
)

-- In this version, this class was developed using the player's id