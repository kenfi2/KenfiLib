CombatLib = {
	setParameter = function(self, key, value)
		setCombatParam(self.combat, key, value)
	end,
	setFormula = function(self,type, ...)
		setCombatFormula(self.combat, type, ...)
	end,
	setArea = function(self, area)
		setCombatArea(self.combat, area)
	end,
	addCondition = function(self,condition)
		setCombatCondition(self.combat, condition)
	end,
	setCallback = function(self, key, function_name)
		setCombatCallBack(self.combat, key, function_name)
	end,
	execute = function(self, creature, variant)
		if getmetatable(creature) then
			doCombat(creature:getId(), self.combat, variant)
			return
		end
		doCombat(creature, self.combat, variant)
	end,
}

ConditionLib = {
	
}

ContainerLib = {
	addItem = function(self, item, count)
		doAddContainerItem(self.id, item, count or 1)
	end,
	addItemEx = function(self, uid)
		return doAddContainerItemEx(self.id, uid)
	end,
}

TileLib = {
	getPosition = function(self, bool)
		return bool and self.pos or Position(self.pos)
	end,
	getTopCreature = function(self)
		return Creature(getTopCreature(self.pos).uid)
	end,
}

TownLib = {
	getTemplePosition = function(self, bool)
		return bool and getTownTemplePosition(self.id) or Position(getTownTemplePosition(self.id))
	end,
}

ItemLib = {
	getPosition = function(self, tb) return tb and getThingPos(self.id) or Position(getThingPos(self.id)) end,
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

PlayerLib = {
	getTown = function(self)
		return getPlayerTown(self.id)
	end,
	getDescription = function(self)
		return ("%s. %s"):format(getPlayerNameDescription(self.id), getPlayerSpecialDescription(self.id))
	end,
	getLevel = function(self) return getPlayerLevel(self.id) end,
	getGuid = function(self) return getPlayerGUID(self.id) end,
	getIp = function(self) return getPlayerIp(self.id) end,
	getAccountId = function(self) return getAccountIdByName(getPlayerAccount(self.id)) end,
	addItem = function(self, item, count)
		local item = doPlayerAddItem(self.id, item, count or 1)
		if isContainer(item) then
			return Container(item)
		else
			return Item(item)
		end
	end,
	sendChannelMessage = function(self, author, message, type, channel)
		if type >= 18 then
			self:sendTextMessage(type, message)
			return
		end
		doPlayerSendChannelMessage(self.id, author, message, type, channel)
	end,
	sendTextMessage = function(self, type, message, channel)
		if type < 18 or channel then
			self:sendChannelMessage(self:getName(), message, type, channel)
			return
		end
		doPlayerSendTextMessage(self.id, type, message)
	end,
	getMana = function(self) return getCreatureMana(self.id) end,
	getMaxMana = function(self) return getCreatureMaxMana(self.id) end,
}

MonsterLib = {
	getDescription = function(self)
		return getMonsterInfo(self:getName()).description
	end,
}

CreatureLib = {
	getHealth = function(self) return getCreatureHealth(self.id) end,
	getMaxHealth = function(self) return getCreatureMaxHealth(self.id) end,
	isPlayer = function(self) return isPlayer(self.id) end,
	isMonster = function(self) return isMonster(self.id) end,
	getPlayer = function(self) return Player(self.id) end,
	getMonster = function(self) return Monster(self.id) end,
	getStorageValue = function(self,key)
		return getCreatureStorage(self.id, key)
	end,
	setStorageValue = function(self, key, value)
		doCreatureSetStorage(self.id, key, value)
	end,
	getName = function(self) 
		return getCreatureName(self.id)
	end,
	setDescription = function(self, value)
		doPlayerSetSpecialDescription(self.id, value)
	end,
	getId = function(self) return self.id end,
	getPosition = function(self, tb) return tb and getThingPos(self.id) or Position(getThingPos(self.id)) end,
	teleportTo = function(self, toPos, ...)
		doTeleportThing(self.id, toPos, ...)
	end,
	remove = function(self, count)
		doRemoveCreature(self.id)
	end,
}

PositionLib = {
	sendMagicEffect = function(self, effect)
		doSendMagicEffect(self.pos, effect)
	end,
	sendDistanceEffect = function(self, positionEx, distanceEffect)
		doSendDistanceShoot(self.pos, positionEx, distanceEffect)
	end,
}

function Position(x, y, z, stackpos)
	if type(x) == "table" then
		pos = x
		if pos.x and pos.y and pos.z then
			return setmetatable({pos = pos}, {__index = PositionLib})
		end
	else
		stackpos = stackpos or 0
		pos = {x = x,y = y,z = z,stackpos = stackpos}
		return setmetatable({pos = pos}, {__index = PositionLib})
	end
end

function Item(uid)
	if tonumber(uid) then
		return setmetatable({id = uid}, {__index = ItemLib})
	elseif type(uid) == "table" or getmetatable(uid) then
		return setmetatable({id = uid:getId()}, {__index = ItemLib})
	end
end

function Creature(uid)
	if tonumber(uid) then
		return setmetatable({id = uid}, {__index = CreatureLib})
	elseif getCreatureByName(uid) then
		return setmetatable({id = getCreatureByName(uid)}, {__index = CreatureLib})
	elseif type(uid) == "table" or getmetatable(uid) then
		return setmetatable({id = uid:getId()}, {__index = CreatureLib})
	end
end

function Monster(uid)
	if tonumber(uid) then
		return setmetatable({id = uid}, {__index = setmetatable(MonsterLib, {__index = Creature(uid)})})
	elseif getmetatable(uid) then
		uid = Creature(uid)
		return setmetatable({id = uid:getId()}, {__index = setmetatable(MonsterLib, {__index = Creature(uid)})})
	elseif getCreatureByName(uid) then
		return setmetatable({id = getCreatureByName(uid)}, {__index = setmetatable(MonsterLib, {__index = Creature(getCreatureByName(uid))})})
	end
end

function Player(uid)
	if tonumber(uid) then
		return setmetatable({id = uid}, {__index = setmetatable(PlayerLib, {__index = Creature(uid)})})
	elseif getmetatable(uid) then
		uid = Creature(uid)
		return setmetatable({id = uid:getId()}, {__index = setmetatable(PlayerLib, {__index = Creature(uid)})})
	elseif getPlayerByName(uid) then
		return setmetatable({id = getPlayerByName(uid)}, {__index = setmetatable(PlayerLib, {__index = Creature(getPlayerByName(uid))})})
	end
end

function Container(uid)
	if tonumber(uid) then
		return setmetatable({id = uid}, {__index = setmetatable(ContainerLib, {__index = Item(uid)})})
	elseif type(uid) == "table" or getmetatable(uid) then
		return setmetatable({id = uid}, {__index = setmetatable(ContainerLib, {__index = Item(uid)})})
	end
end

function Tile(x,y,z,stackpos)
	if type(x) == "table" then
		pos = x
		if pos.x and pos.y and pos.z then
			return setmetatable({pos = pos}, {__index = TileLib})
		end
	else
		stackpos = stackpos or 0
		pos = {x = x,y = y,z = z,stackpos = stackpos}
		return setmetatable({pos = pos}, {__index = TileLib})
	end
end

function Town(uid)
	if tonumber(uid) then
		return setmetatable({id = uid}, {__index = TownLib})
	elseif type(uid) == "table" or getmetatable(uid) then
		return setmetatable({id = uid:getId()}, {__index = TownLib})
	end
end

function Combat(uid)
	return setmetatable({combat = createCombatObject()},{__index = CombatLib})
end

function Condition(conditionType, conditionId)
	conditionId = conditionId or CONDITIONID_COMBAT
	return setmetatable({condition = createConditionObject(conditionType, 0, false, 0, conditionId)}, {__index = ConditionLib})
end