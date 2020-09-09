Position = setmetatable(
{
	getDistance = function(self, positionEx)
		local x, y = math.abs(self.x - positionEx.x), math.abs(self.y - positionEx.y)
		local diff = math.max(x, y)
		if(self.z ~= positionEx.z) then
			diff = diff + 9 + 6
		end

		return diff
	end,
	isSightClear = function(self, positionEx, ...)
		return isSightClear(self, positionEx, ...)
	end,
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
		if isTable(arg[1]) and #arg == 1 then
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
				if isTable(value) then
					if value.x and value.y and value.z then
						return Position(this.x+value.x,this.y+value.y,this.z+value.z)
					end
				elseif isNumber(value) then
					return Position(this.x+value,this.y+value,this.z+value)
				end
			end,
			__sub = function(this, value)
				if isTable(value) then
					if value.x and value.y and value.z then
						return Position(this.x-value.x,this.y-value.y,this.z-value.z)
					end
				elseif isNumber(value) then
					return Position(this.x-value,this.y-value,this.z-value)
				end
			end,
		}
		)
	end,
}
)