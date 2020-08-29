Town = setmetatable(
{
	getTemplePosition = function(self)
		return Position(getTownTemplePosition(self.id))
	end,
},
{
	__call = function(this, uid)
		if type(uid) == "table" then
			uid = uid:getId()
		end
		if tonumber(uid) then
			return setmetatable({id = uid}, {__index = this, __eq = eq_event(a, b),})
		end
	end,
}
)