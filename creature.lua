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
}

function Creature(uid)
	if tonumber(uid) then
		return setmetatable({id = uid}, {__index = CreatureLib, __eq = eq_event(a, b)})
	elseif getCreatureByName(uid) then
		return setmetatable({id = getCreatureByName(uid)}, {__index = CreatureLib, __eq = eq_event(a, b)})
	end
end
