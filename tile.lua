Tile = setmetatable(
{
	getInfo = function(self)
		return getTileInfo(self)
	end,
	getPosition = function(self)
		return Position(self)
	end,
	getTopCreature = function(self)
		local uid = getTopCreature(self).uid
		if uid > 0 then
			return Creature(uid)
		end
	end,
	getItemById = function(self, itemid, subType)
		subType = subType or -1
		local item = getTileItemById(self, itemid, subType).uid
		if isContainer(item) then
			return Container(item)
		end
		return Item(item)
	end,
	getItemByType = function(self, itemtype)
		local item = getTileItemByType(self, itemtype).uid
		if isContainer(item) then
			return Container(item)
		end
		return Item(item) 
	end,
	getThing = function(self, index)
		local pos = Position(self.x,self.y,self.z,index)
		local thing = getThingFromPosition(pos)
		if not thing then
			return
		end
		if isCreature(thing.uid) then
			return Creature(thing.uid)
		else
			return Item(thing.uid)
		end
	end,
	getTopVisibleThing = function(self)
		for i = 5,1,-1 do
			self.stackpos = i
			local count = getThingFromPos(self)
			if (count.uid) then
				if isCreature(count.uid) then
					return Creature(count.uid)
				else
					return Item(count.uid)
				end
			end
		end
	end,
	getThingCount = function(self)
		return self:getInfo().things
	end,
	getItems = function(self) end,
	getItemCount = function(self)
		return self:getInfo().items
	end,
	getItemList = function(self)
		local list = {}
		local thing = self:getThing()
		if thing and thing:isItem() then
			table.insert(list, thing)
		end
		return list
	end,
},
{
	__call = function(this, ...)
		local pos = nil
		if isTable(arg[1]) then
			pos = arg[1]
		elseif #arg >= 3 then
			pos = {x=arg[1], y=arg[2], z=arg[3], stackpos = arg[4]}
		end
		pos.stackpos = pos.stackpos or 0
		return setmetatable(pos,
		{
			__index = this,
			__eq = eq_event(a, b)
		}
		)
	end,
}
)