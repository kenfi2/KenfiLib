Creature = setmetatable(
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
	getPosition = function(self) return Position(getThingPos(self.id)) end,
	getTile = function(self) return Tile(self:getPosition()) end,
	teleportTo = function(self, toPos, ...)
		doTeleportThing(self.id, toPos, ...)
	end,
	remove = function(self, count)
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
		if isMetatable(condition) then
			doRemoveCondition(self.id, conditionType, subId, conditionId)
			return
		end
	end,
	getOutfit = function(self)
		return getCreatureOutfit(self.id)
	end,
	setOutfit = function(self, outfit)
		doCreatureChangeOutfit(self.id, outfit)
	end,
},
{
	__eq = eq_event(a,b),
	__call = function(this, var)
		local id = 0
		if isNumber(var) then
			id = tonumber(var)
		elseif isString(var) then
			if getCreatureByName(var) then
				id = getCreatureByName(var)
			end
		end
		if isCreature(id) then
			return setmetatable({id = id}, {__index = this})
		end
		return error("attempt to create metatable 'Creature' (not creature value)")
	end,
}
)