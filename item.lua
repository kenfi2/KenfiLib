ItemLib = {
	getPosition = function(self) return Position(getThingPos(self.id)) end,
	getCount = function(self) return getThing(self.id).type == 0 and 1 or getThing(self.id).type end,
	getId = function(self) return self.id end,
	getAttribute = function(self, key)
		return getItemAttribute(self.id, key)
	end,
	setAttribute = function(self, key, value)
		doItemSetAttribute(self.id, key, value)
	end,
	getName = function(self) 
		return getItemAttribute(self.id, "name") or getItemInfo(getThing(self.id).itemid).name
	end,
	getDescription = function(self)
		return getItemAttribute(self.id, "description") or getItemInfo(getThing(self.id).itemid).description
	end,
	setDescription = function(self, value)
		self:setAttribute("description", value)
	end,
	remove = function(self, count)
		doRemoveItem(self.id, count or 0)
	end,
	moveTo = function(self, toCylinder, ...)
		if getmetatable(toCylinder) then
			self:remove()
			error("bad argument #2 to 'moveTo' (table expected, got metatable)")
			return
		end
		doTeleportThing(self.id, toCylinder, ...)
	end,
}

function Item(uid)
	if tonumber(uid) then
		return setmetatable({id = uid}, {__index = ItemLib, __eq = eq_event(a, b)})
	elseif getmetatable(uid) then
		return setmetatable({id = uid:getId()}, {__index = ItemLib, __eq = eq_event(a, b)})
	end
end
