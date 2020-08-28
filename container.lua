ContainerLib = {
	addItem = function(self, item, count)
		doAddContainerItem(self.id, item, count or 1)
	end,
	addItemEx = function(self, uid)
		return doAddContainerItemEx(self.id, uid)
	end,
}

function Container(uid)
	if tonumber(uid) then
		return setmetatable({id = uid}, {__index = setmetatable(ContainerLib, {__index = ItemLib}), __eq = eq_event(a,b)})
	elseif getmetatable(uid) then
		return setmetatable({id = uid}, {__index = setmetatable(ContainerLib, {__index = ItemLib}), __eq = eq_event(a,b)})
	end
end
