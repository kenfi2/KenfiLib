Teleport = setmetatable(
{
	getDestination = function(self)
		return self.destination and Position(self.destination)
	end,
	setDestination = function(self, destination)
		doItemSetDestination(self.uid, destination)
		self.destination = destination
	end,
},
{
	__index = Item,
	__call = function(this, var)
		local id = 0
		if isMetatable(var) then
			id = var:getId()
			var = var:getUniqueId()
		elseif getThing(var) then
			id = getThing(var).itemid
		end
		if var and id then
			return setmetatable({id = id, uid = var}, {__index = this})
		end
	end,
}
)