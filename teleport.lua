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
		end
		local value = PushFunction(getThing, var)
		if value > 0 then
			return setmetatable(value, {__index = this})
		end
	end,
}
)