TileLib = {
	getPosition = function(self)
		return Position(self)
	end,
	getTopCreature = function(self)
		return Creature(getTopCreature(self).uid)
	end,
}

function Tile(x,y,z,stackpos)
	if type(x) == "table" then
		pos = x
		if pos.x and pos.y and pos.z then
			return setmetatable(pos, {__index = TileLib})
		end
	else
		pos = {x = x,y = y,z = z,stackpos = stackpos or 0}
		return setmetatable(pos, {__index = TileLib})
	end
end