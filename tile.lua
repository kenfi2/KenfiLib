Tile = setmetatable(
{
	getPosition = function(self)
		return Position(self)
	end,
	getTopCreature = function(self)
		return Creature(getTopCreature(self).uid)
	end,
},
{
	__call = function(this, ...)
		local pos = nil
		if type(arg[1]) == "table" and #arg == 1 then
			pos = arg[1]
		elseif #arg >= 3 then
			pos = {x=arg[1], y=arg[2], z=arg[3], stackpos = arg[4]}
		end
		pos.stackpos = pos.stackpos or 0
		return setmetatable(pos,
		{
			__index = this,
			__eq = eq_event(a, b)
		}
		)
	end,
}
)