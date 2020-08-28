TownLib = {
	getTemplePosition = function(self)
		return Position(getTownTemplePosition(self.id))
	end,
}

function Town(uid)
	if tonumber(uid) then
		return setmetatable({id = uid}, {__index = TownLib, __eq = eq_event(a, b),})
	elseif getmetatable(uid) then
		return setmetatable({id = uid:getId()}, {__index = TownLib, __eq = eq_event(a, b),})
	end
end
