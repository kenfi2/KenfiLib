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

function Player(uid)
	if tonumber(uid) and isPlayer(uid) then
		return setmetatable({id = uid}, {__index = setmetatable(PlayerLib, {__index = CreatureLib}), __eq = eq_event()})
	elseif getmetatable(uid) then
		return setmetatable({id = uid:getId()}, {__index = setmetatable(PlayerLib, {__index = CreatureLib}), __eq = eq_event()})
	elseif getPlayerByName(uid) then
		return setmetatable({id = getPlayerByName(uid)}, {__index = setmetatable(PlayerLib, {__index = CreatureLib}), __eq = eq_event()})
	end
end
