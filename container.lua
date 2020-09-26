return setmetatable(
{
	isContainer = function(self) return true end,
	getSize = function(self)
		return getContainerSize(self.uid)
	end,
	getCapacity = function(self)
		return getContainerCap(self.uid)
	end,
	getEmptySlots = function(self)
		local slots = self:getCapacity() - self:getSize()
		return slots
	end,
	getItem = function(self, index)
		local item = getContainerItem(self.uid, index)
		if item.uid and item.uid > 0 then
			return Item(item.uid)
		end
	end,
	addItem = function(self, item, count)
		doAddContainerItem(self.uid, item, count or 1)
	end,
	addItemEx = function(self, uid)
		return doAddContainerItemEx(self.uid, uid)
	end,
},
{
	__index = Item,
	__call = function(this, var)
		local id = 0
		if isMetatable(var) then
			id = var:getId()
			var = var:getUniqueId()
		end
		local value = PushFunction(getThing, var)
		if value.uid > 0 then
			return setmetatable(value, {__index = this})
		end
	end,
}
)