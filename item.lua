Item = setmetatable(
{
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
		doRemoveItem(self.uid, count or 0)
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
	__call = function(this, uid)
		local id = 0
		if type(uid) == "table" then
			return setmetatable({id = uid:getId(), uid = uid:getUniqueId()}, {__index = ItemLib, __eq = eq_event(a, b)})
		elseif getThing(uid) then
			id = getThing(uid).itemid
		end
		if id and uid then
			return setmetatable({id = id, uid = uid}, {__index = this, __eq = eq_event(a, b)})
		end
		return 
	end,
}
)