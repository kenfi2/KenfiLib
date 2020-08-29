Container = setmetatable(
{
	isContainer = function(self) return true end,
	addItem = function(self, item, count)
		doAddContainerItem(self.uid, item, count or 1)
	end,
	addItemEx = function(self, uid)
		return doAddContainerItemEx(self.uid, uid)
	end,
},
{
	__index = Item,
	__call = function(this, uid)
		local id = 0
		if type(uid) == "table" then
			id = uid:getId()
			uid = uid:getUnique()
		elseif getThing(uid) then
			id = getThing(uid).itemid
		end
		if uid and id then
			return setmetatable({id = id, uid = uid}, {__index = this})
		end
	end,
}
)