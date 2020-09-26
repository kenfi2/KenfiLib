return setmetatable(
{
	isItem = function(self) return true end,
	getParent = function(self)
		return getItemParent(self.uid)
	end,
	isContainer = function(self) return isContainer(self.uid) end,
	getPosition = function(self) return Position(getThingPos(self.uid)) end,
	getCount = function(self) return self.type == 0 and 1 or self.type end,
	getId = function(self) return self.itemid end,
	getUniqueId = function(self) return self.uid end,
	getActionId = function(self) return self.aid end,
	getAttribute = function(self, key)
		return getItemAttribute(self.uid, key)
	end,
	setAttribute = function(self, key, value)
		doItemSetAttribute(self.uid, key, value)
	end,
	setActionId = function(self, value)
		self:setAttribute("aid", value)
	end,
	getName = function(self) 
		local itemName = ""
		local itemType = ItemType(self.itemid)
		itemName = getItemAttribute(self.uid, "name") or itemType:getName()
		return itemName
	end,
	getDescription = function(self)
		local itemDescription = ""
		local itemType = ItemType(self.itemid)
		itemName = getItemAttribute(self.uid, "description") or itemType:getDescription()
		return itemName
	end,
	setDescription = function(self, value)
		self:setAttribute("description", value)
	end,
	remove = function(self, count)
		return PushFunction(doRemoveItem, self.uid, count or (self:getCount()))
	end,
	moveTo = function(self, toCylinder, ...)
		if isMetatable(toCylinder) and not (toCylinder.x or toCylinder.y or toCylinder.z) then
			self:remove()
			error("bad argument #2 to 'moveTo' (table expected, got metatable)")
			return
		end
		doTeleportThing(self.uid, toCylinder, ...)
	end,
},
{
	__call = function(this, var)
		local id = 0
		if isMetatable(var) then
			id = var:getId()
			var = var:getUniqueId()
		end
		local value = PushFunction(getThing, var)
		if value.uid ~= 0 then
			return setmetatable(value, {__index = this, __eq = eq_event})
		end
	end,
}
)--