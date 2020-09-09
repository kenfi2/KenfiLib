Tile = setmetatable(
{
	getInfo = function(self)
		return getTileInfo(self)
	end,
	getPosition = function(self)
		return Position(self)
	end,
	getGround = function(self)
		local pos = Position(self.x,self.y,self.z,0)
		local thing = PushFunction(getThingFromPosition, pos)
		return Item(thing.uid)
	end,
	getTopCreature = function(self)
		local creature = PushFunction(getTopCreature, self)
		if creature.uid == 0 then
			return
		end
		return Creature(creature.uid)
	end,
	getItemById = function(self, itemid, subType)
		subType = subType or -1
		local item = PushFunction(getTileItemById, self, itemid, subType)
		if item.uid == 0 then
			return
		end
		if isContainer(item.uid) then
			return Container(item.uid)
		end
		return Item(item.uid)
	end,
	getItemByType = function(self, itemtype)
		local item = PushFunction(getTileItemByType, self, itemtype)
		if item.uid == 0 then
			return
		end
		if isContainer(item.uid) then
			return Container(item.uid)
		end
		return item.uid(item) 
	end,
	getThing = function(self, index)
		local pos = Position(self.x,self.y,self.z,index)
		local thing = PushFunction(getThingFromPosition, pos)
		if thing.uid == 0 then
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
			local count = PushFunction(getThingFromPosition, self)
			if count.uid > 0 then
				if isCreature(count.uid) then
					return Creature(count.uid)
				else
					return Item(count.uid)
				end
			end
		end
	end,
	getTopVisibleCreature = function(self)
		for i = 5,1,-1 do
			self.stackpos = i
			local count = PushFunction(getThingFromPosition, self)
			if count.uid > 0 then
				if isCreature(count.uid) then
					return Creature(count.uid)
				end
			end
		end
	end,
	getTopTopItem = function(self)
		for i = 255,1,-1 do
			self.stackpos = i
			local count = PushFunction(getThingFromPosition, self)
			if count.uid > 0 then
				if not isCreature(count.uid) then
					return Item(count.uid)
				end
			end
		end
	end,
	getTopDownItem = function(self)
		self.stackpos = 255
		local count = PushFunction(getThingFromPosition, self)
		if count.uid > 0 then
			if not isCreature(count.uid) then
				return Item(count.uid)
			end
		end
	end,
	getFieldItem = function(self)
		self.stackpos = 254
		local count = PushFunction(getThingFromPosition, self)
		if count.uid > 0 then
			return Item(count.uid)
		end
	end,
	getBottomCreature = function(self)
		for i = 252, 1, -1 do
			self.stackpos = i
			local count = PushFunction(getThingFromPosition, self)
			if count.uid > 0 then
				if isCreature(count.uid) then
					return Creature(count.uid)
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
	getDownItemCount = function(self)
		return self:getInfo().topItems
	end,
	getTopItemCount = function(self)
		return self:getInfo().downItems
	end,
	queryAdd = function(self, thing, ...)
		local uid = 0
		if isMetatable(thing) then
			if thing:isItem() then
				uid = thing:getUniqueId()
			else
				uid = thing:getId()
			end
		end
		doTileQueryAdd(uid, pos, ...)
	end,
	addItem = function(self, itemid, subType)
		return Item(Game.createItem(item,subType,self))
	end,
	addItemEx = function(self, item)
		local uid = 0
		if isMetatable(item) then
			uid = item:getUniqueId()
		end
		doTileAddItemEx(self, uid)
	end,
	hasFlag = function(self, flag)
		local tileStates = {}
		-- preguiça
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