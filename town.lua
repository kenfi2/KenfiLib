Town = setmetatable(
{
	getId = function(self) return self.id end,
	getName = function(self) return getTownName(self.id) end,
	getTemplePosition = function(self)
		return Position(getTownTemplePosition(self.id))
	end,
},
{
	__call = function(this, var)
		if isMetatable(var) then
			var = var:getId()
		end
		return setmetatable({id = var}, {__index = this, __eq = eq_event(a, b),})
	end,
}
)