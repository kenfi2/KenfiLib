Item = setmetatable(
{
	isItem = function(self) return true end,
	isContainer = function(self) return isContainer(self.uid) end,
	getPosition = function(self) return Position(getThingPos(self.uid)) end,
	getCount = function(self) return getThing(self.uid).type == 0 and 1 or getThing(self.uid).type end,
	getId = function(self) return self.id end,
	getUniqueId = function(self) return self.uid end,
	getAttribute = function(self, key)
		return getItemAttribute(self.uid, key)
	end,
	setAttribute = function(self, key, value)
		doItemSetAttribute(self.uid, key, value)
	end,
	getName = function(self) 
		return getItemAttribute(self.uid, "name") or getItemInfo(getThing(self.uid).itemid).name
	end,
	getDescription = function(self)
		return getItemAttribute(self.uid, "description") or getItemInfo(getThing(self.uid).itemid).description
	end,
	setDescription = function(self, value)
		self:setAttribute("description", value)
	end,
	remove = function(self, count)
		return doRemoveItem(self.uid, count or (self:getCount()))
	end,
	moveTo = function(self, toCylinder, ...)
		if getmetatable(toCylinder) then
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
		elseif getThing(var) then
			id = getThing(var).itemid
		end
		if id and var then
			return setmetatable({id = id, uid = var}, {__index = this, __eq = eq_event(a, b)})
		end
	end,
}
)