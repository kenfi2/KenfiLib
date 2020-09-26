return setmetatable(
{
	getGuild = function(self)
		return Guild(getPlayerGuildId(self.id), getPlayerGuildName(self.id))
	end,
	setGuild = function(self, id)
		doPlayerSetGuildId(self.id, id)
	end,
	getGuildLevel = function(self)
		return getPlayerGuildLevel(self.id)
	end,
	setGuildLevel = function(self, level)
		doPlayerSetGuildLevel(self.id, level)
	end,
	getGuildNick = function(self)
		return getPlayerGuildNick(self.id)
	end,
	setGuildNick = function(self, nick)
		doPlayerSetGuildNick(self.id, nick)
	end,
	getTown = function(self)
		return Town(getPlayerTown(self.id))
	end,
	addOutfit = function(self, lookType)
		doPlayerAddOutfit(self.id, lookType)
	end,
	addOutfitAddon = function(self, lookType, addon)
		if not tonumber(addon) then
			return error(("bad argument #2 to 'addOutfitAddon' (number expected, got %s)"):format(type(addon)))
		elseif tonumber(addon) <= 0 then
			return error(("bad argument #2 to 'addOutfitAddon' (the numeric value must be greater than 0)"):format(type(addon)))
		end
		doPlayerAddOutfit(self.id, lookType, addon)
	end,
	removeOutfit = function(self, outfit)
		doPlayerRemoveOutfit(self.id, outfit)
	end,
	removeOutfitAddon = function(self, outfit, addon)
		if not tonumber(addon) then
			return error(("bad argument #2 to 'removeOutfitAddon' (number expected, got %s)"):format(type(addon)))
		elseif tonumber(addon) <= 0 then
			return error(("bad argument #2 to 'removeOutfitAddon' (the numeric value must be greater than 0)"):format(type(addon)))
		end
		doPlayerRemoveOutfit(self.id, outfit, addon)
	end,
	isPremium = function(self)
		return getPlayerPremiumDays(self.id) > 0 or getBooleanFromString(getConfigValue('freePremium'))
	end,
	isPlayer = function(self) return true end,
	getDescription = function(self)
		return ("%s. %s"):format(getPlayerNameDescription(self.id), getPlayerSpecialDescription(self.id))
	end,
	getItemCount = function(self, itemId, ...)
		return getPlayerItemCount(self.id, itemId, ...)
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
	sendCancelMessage = function(self, message)
		doPlayerSendCancel(self.id, message)
	end,
	getMana = function(self) return getCreatureMana(self.id) end,
	getMaxMana = function(self) return getCreatureMaxMana(self.id) end,
	getLastLoginSaved = function(self)
		return getPlayerLastLogin(self.id)
	end,
	getAccountManager = function(self)
		return getPlayerAccountManager(self.id)
	end,
	getFreeCapacity = function(self)
		return getPlayerFreeCap(self.id)
	end,
	getDepotItems = function(self, depotId)
		return getPlayerDepotItems(self.id, depotId)
	end,
	getSkullTime = function(self)
		return getPlayerSkullEnd(self.id)
	end,
	setSkullTime = function(self, skullTime, skullType)
		return doPlayerSetSkullEnd(self.id, skullTime, skullType or self:getSkull())
	end,
	getExperience = function(self)
		return getPlayerExperience(self.id)
	end,
	addExperience = function(self, amount)
		doPlayerAddExperience(cid, math.abs(amount))
	end,
	removeExperience = function(self, amount)
		doPlayerAddExperience(cid, -(math.abs(amount)))
	end,
	getMagicLevel = function(self)
		return getPlayerMagLevel(self.id)
	end,
	getBaseMagicLevel = function(self)
		return getPlayerMagLevel(self.id, true)
	end,
	getManaSpent = function(self)
		return getPlayerSpentMana(self.id)
	end,
	addManaSpent = function(self, amount, bool)
		doPlayerAddSpentMana(self.id, amount, bool)
	end,
	getBaseMaxHealth = function(self)
		return getCreatureMaxHealth(self.id, true)
	end,
	getBaseMaxMana = function(self)
		return getCreatureMaxMana(self.id, true)
	end,
	removeMoney = function(self, quant)
		return doPlayerRemoveMoney(self.id, quant)
	end,
	removeItem = function(self, itemId, quant, ...)
		return doPlayerRemoveItem(self.id, itemId, quant, ...)
	end,
	addMoney = function(self, value)
		return doPlayerAddMoney(self.id, value)
	end,
	getSlotItem = function(self, slot)
		local item = PushFunction(getPlayerSlotItem, self.id, slot)
		if item.uid == 0 then
			return
		end
		if isContainer(item.uid) then
			return Container(item.uid)
		end
		return Item(item.uid)
	end,
	popupFYI = function(self, msg)
		return doPlayerPopupFYI(self.id, msg)
	end,
},
{
	__index = Creature,
	__call = function(this, var)
		local id = 0
		if isNumber(var) then
			if var >= 268435456 then
				id = tonumber(var)
			else
				id = getPlayerByGUID(var)
			end
		elseif isString(var) then
			if getPlayerByName(var) then
				id = getPlayerByName(var)
			end
		elseif isMetatable(var) then
			if var:isPlayer() then
				id = var:getId()
			end
		end
		if isPlayer(id) then
			return setmetatable(
				{
					id = id
				},
				{
					__index = this,
					__unm = function(self)
						local id = self.id
						return Creature(id)
					end,
				}
			)
		end
		return error("attempt to create metatable 'Player' (not player value)")
	end,
}
)