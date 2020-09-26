return setmetatable( 
{
	getId = function(self)
		return self.id
	end,
	getName = function(self)
		return self.name
	end,
	getFlags = function(self, custom)
		return custom and self.customFlags or self.flags
	end,
	getAccess = function(self, ghost)
		return ghost and self.ghostAccess or self.access
	end,
	getMaxDepotItems = function(self)
		return self.depotLimit
	end,
	getMaxVipEntries = function(self)
		return self.maxVips
	end,
	hasFlag = function(self, flag)
		--
	end,
	getOutfit = function(self)
		return self.outfit
	end,
},
{
	__call = function(this, uid)
		return setmetatable(getGroupInfo(id, true), {__index = this, __eq = eq_event})
	end,
}
)