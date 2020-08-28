PositionLib = {
	sendMagicEffect = function(self, effect)
		doSendMagicEffect(self, effect)
	end,
	sendDistanceEffect = function(self, positionEx, distanceEffect)
		doSendDistanceShoot(self, positionEx, distanceEffect)
	end,
}

function Position(x, y, z, stackpos)
	if type(x) == "table" then
		pos = x
		if pos.x and pos.y and pos.z then
			return setmetatable(pos, {
			__index = PositionLib,
			__add = function(pos, value)
				if type(value) == "table" or getmetatable(value) then
					if value.x and value.y and value.z then
						return Position(pos.x+value.x,pos.y+value.x,pos.z+value.x)
					end
				elseif tonumber(value) then
					return Position(pos.x+value,pos.y+value,pos.z+value)
				end
				return false
			end,
			__eq = eq_event(a, b),
			__sub = function(pos, value)
				if type(value) == "table" or getmetatable(value) then
					if value.x and value.y and value.z then
						return Position(pos.x-value.x,pos.y-value.y,pos.z-value.z)
					end
				elseif tonumber(value) then
					return Position(pos.x-value,pos.y-value,pos.z-value)
				end
				return false
			end,
		})
		end
	else
		return setmetatable({x=x,y=y,z=z,stackpos=stackpos or 0}, {
		__index = PositionLib,
		__add = function(pos, value)
			if type(value) == "table" or getmetatable(value) then
				if value.x and value.y and value.z then
					return Position(pos.x+value.x,pos.y+value.x,pos.z+value.x)
				end
			elseif tonumber(value) then
				return Position(pos.x+value,pos.y+value,pos.z+value)
			end
			return false
		end,
		__eq = eq_event(a, b),
		__sub = function(pos, value)
			if type(value) == "table" or getmetatable(value) then
				if value.x and value.y and value.z then
					return Position(pos.x-value.x,pos.y-value.y,pos.z-value.z)
				end
			elseif tonumber(value) then
				return Position(pos.x-value,pos.y-value,pos.z-value)
			end
			return false
		end,
	})
	end
end
