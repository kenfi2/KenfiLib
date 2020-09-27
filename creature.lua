return setmetatable(
{
	getPlayer = function(self)
		if self:isPlayer() then
			return Player(self.id)
		end
	end,
	getMonster = function(self)
		if self:isMonster() then
			return Monster(self.id)
		end
	end,
	getNpc = function(self)
		if self:isNpc() then
			return Npc(self.id)
		end
	end,
	isItem = function(self) return false end,
	isPlayer = function(self) return isPlayer(self.id) end,
	isMonster = function(self) return isMonster(self.id) end,
	isNpc = function(self) return isNpc(self.id) end,
	getHealth = function(self) return getCreatureHealth(self.id) end,
	getMaxHealth = function(self) return getCreatureMaxHealth(self.id) end,
	getStorageValue = function(self,key)
		local value = getCreatureStorage(self.id, key)
		if tostring(value):isTable() then
			return value:totable()
		end
		return value
	end,
	setStorageValue = function(self, key, value)
		if isTable(value) then
			value = table.tostring(value)
			doCreatureSetStorage(self.id, key, value)
		else
			doCreatureSetStorage(self.id, key, value)
		end
	end,
	getName = function(self) 
		return getCreatureName(self.id)
	end,
	setDescription = function(self, value)
		doPlayerSetSpecialDescription(self.id, value)
	end,
	getId = function(self) return self.id end,
	getPosition = function(self)
		local pos = PushFunction(getThingPos, self.id)
		return Position(pos)
	end,
	getTile = function(self) return Tile(self:getPosition()) end,
	teleportTo = function(self, toPos, ...)
		doTeleportThing(self.id, toPos, ...)
	end,
	remove = function(self)
		doRemoveCreature(self.id)
	end,
	getSkull = function(self, ...)
		return getCreatureSkullType(self.id, ...)
	end,
	registerEvent = function(self, name)
		registerCreatureEvent(self.id, name)
	end,
	unregisterEvent = function(self, name)
		function_name = type(name) == "string" and unregisterCreatureEvent or unregisterCreatureEventType
		function_name(self.id, name)
	end,
	addCondition = function(self, condition)
		if isMetatable(condition) then
			doAddCondition(self.id, condition.condition)
			return
		end
		doAddCondition(self.id, condition)
	end,
	removeCondition = function(self, conditionType, conditionId, subId)
		conditionId = conditionId or CONDITIONID_COMBAT
		subId = subId or 0
		doRemoveCondition(self.id, conditionType, subId, conditionId)
	end,
	getOutfit = function(self)
		return getCreatureOutfit(self.id)
	end,
	setOutfit = function(self, outfit)
		doCreatureChangeOutfit(self.id, outfit)
	end,
	addHealth = function(self, health)
		doCreatureAddHealth(self.id, health)
	end,
	getMaster = function(self)
		local masterId = getCreatureMaster(self.id)
		if masterId and masterId > 0 then
			return Creature(masterId)
		end
	end,
	setMaster = function(self, master)
		local cid = master:getId()
		return doConvinceCreature(cid, self:getId())
	end,
	isSummon = function(self)
		return self:getMaster()
	end,
	getSummons = function(self)
		local summons = {}
		for i, v in ipairs(getCreatureSummons(self.id)) do
			table.insert(summons, Creature(v))
		end
		return summons
	end,
},
{
	__eq = eq_event,
	__call = function(this, var)
		local id = 0
		if isNumber(var) then
			id = tonumber(var)
		elseif isString(var) then
			if getCreatureByName(var) then
				id = getCreatureByName(var)
			end
		elseif isMetatable(var) then
			return Creature(var.id)
		end
		if isCreature(id) then
			if isNpc(id) then
				return Npc(id)
			elseif isPlayer(id) then
				return Player(id)
			elseif isMonster(id) then
				return Monster(id)
			end
			return setmetatable(
				{
					id = id
				},
				{
					__index = this
				}
			)
		end
		return error("attempt to create metatable 'Creature' (not creature value)")
	end,
}
)--
