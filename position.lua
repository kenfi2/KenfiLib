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
			return setmetatable(pos, {__index = PositionLib})
		end
	else
		return setmetatable({x=x,y=y,z=z,stackpos=stackpos or 0}, {__index = PositionLib})
	end
end