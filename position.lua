Position = setmetatable(
{
	sendMagicEffect = function(self, effect)
		doSendMagicEffect(self, effect)
	end,
	sendDistanceEffect = function(self, positionEx, distanceEffect)
		doSendDistanceShoot(self, positionEx, distanceEffect)
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
			__eq = eq_event(a, b),
			__add = function(this, value)
				if type(value) == "table" or getmetatable(value) then
					if value.x and value.y and value.z then
						return Position(this.x+value.x,this.y+value.x,this.z+value.x)
					end
				elseif tonumber(value) then
					return Position(this.x+value,this.y+value,this.z+value)
				end
			end,
			__sub = function(this, value)
				if type(value) == "table" or getmetatable(value) then
					if value.x and value.y and value.z then
						return Position(this.x-value.x,this.y-value.y,this.z-value.z)
					end
				elseif tonumber(value) then
					return Position(this.x-value,this.y-value,this.z-value)
				end
			end,
		}
		)
	end,
}
)