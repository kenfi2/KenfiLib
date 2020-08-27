TownLib = {
	getTemplePosition = function(self)
		return Position(getTownTemplePosition(self.id))
	end,
}

function Town(uid)
	if tonumber(uid) then
		return setmetatable({id = uid}, {__index = TownLib})
	elseif getmetatable(uid) then
		return setmetatable({id = uid:getId()}, {__index = TownLib})
	end
end