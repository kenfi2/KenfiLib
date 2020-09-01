Game = {
	getGameState = function() return getGameState() end,
	setGameState = function(id) doSetGameState(id) end,
	getWorldType = function()
		return getWorldType()
	end,
	setWorldType = function(type)
		setWorldType(type)
	end,
	getExperienceStage = function(level, ...)
		return getExperienceStage(level, ...)
	end,
	getReturnMessage = function(self)

	end,
	createItem = function(itemid,type,pos)
		return Item(doCreateItem(itemid, type, pos))
	end,
	createContainer = function()
		--
	end,
	createMonster = function(name, pos, extend, force)
		return Monster(doCreateMonster(name, pos, extend, force))
	end,
	createNpc = function(name, pos)
		return Npc(doCreateNpc(name, pos))
	end,
	createTile = function()
		-- don't work in this version. Use Tile()
	end,
	createMonsterType = function()
		-- don't work in this version.
	end,
	startRaid = function(raid)
		doExecuteRaid(raid)
	end,
	sendAnimatedText = function(message, position, color, ...)
		doSendAnimatedText(position, message, color, ...)
	end,
	getClientVersion = function()
		local versionMin = getConfigValue(versionMin)
		local versionMax = getConfigValue(versionMax)
		local versionMsg = getConfigValue(versionMsg)
		local tb = {
			min = versionMin,
			max = versionMax,
			string = versionMsg
		}
		return tb
	end,
	reload = function(reloadType, ...)
		doReloadInfo(reloadType, ...)
	end,
	getMonsterCount = function()
		return getWorldCreatures(1)
	end,
	getPlayerCount = function()
		return getWorldCreatures(0)
	end,
	getNpcCount = function()
		return getWorldCreatures(2)
	end,
	getTowns = function()
		local towns = {}
		for i, v in ipairs(getTownList()) do
			local town = Town(v.id)
			table.insert(towns, town)
		end
		return towns
	end,
	getHouses = function()
		local houses = {}
		for _, town in ipairs(Game.getTowns()) do
			local townId = town:getId()
			for i, v in ipairs(getTownHouses(townId)) do
				local house = House(v)
				table.insert(houses, house)
			end
		end
		return houses
	end,
	getStorageValue = function(key)
		return getStorage(key)
	end,
	setStorageValue = function(key, value)
		doSetStorage(key, value)
	end,
	getSpectators = function(position, multifloor, onlyPlayer, minRangeX, maxRangeX, minRangeY, maxRangeY)
		spectatorList = getSpectators(position, minRangeX, minRangeY, multifloor)
		spectatorVec = {}
		for _, creature in ipairs(spectatorList)do
			creature = Creature(creature)
			player = Player(creature)
			if onlyPlayer then
				table.insert(spectatorVec, player)
			else
				table.insert(spectatorVec, creature)
			end
		end
		return spectatorVec
	end,
	getPlayers = function()
		players = {}
		for _, v in ipairs(getPlayersOnline()) do
			local player = Player(v)
			table.insert(players, player)
		end
		return players
	end,
	sendTextMessage = function(type, message)
		for _, players in ipairs(Game.getPlayers()) do
			players:sendTextMessage(type, message)	
		end
	end,
	getEvents = function()
		local nextEvent = {}
		local file = io.open('data/globalevents/globalevents.xml')
		if not file then
			return
		end
		local XML = file:read('a*')
		for i, v in ipairs(XML:splitTrimmed(">")) do
			local hasName = v:find("name")
			local hasTime = v:find("time")
			if hasName and hasTime then
				local name = v:match('name=".-"'):splitTrimmed('"')[2]
				local time = v:match('time=".-"'):splitTrimmed('"')[2]
				local hour = (time:splitTrimmed(":")[1])
				table.insert(nextEvent, {name = name, time = (tonumber(hour) == 24 and 0 or tonumber(hour)), realTime = time})
			end
		end
		table.sort(nextEvent, function(a,b)
			return b.time > a.time
		end)
		io.close(file)
		return nextEvent
	end,
	getNextEvent = function()
		if #nextEvent == 0 then
			return "Empty", "00:00:00"
		end
		local hour = tonumber(os.date("%H"))
		local i = 0
		local stop = false
		repeat
			i = i + 1
			nextEvent.times = nextEvent.times + 1
			if nextEvent[i] and tonumber(nextEvent[i].time) == hour then
				name = nextEvent[i].name
				time = nextEvent[i].realTime
				break
			elseif i > #nextEvent then
				hour = hour + 1
				hour = (hour == 24 and 0 or hour)
				i = 0
			end
		until nextEvent:stop()
		nextEvent.times = 0
		return name, time
	end,
}
nextEvent = {
	times = 0,
	stop = function(self)
		return self.times >= (#self * 24)
	end,
	sendTextMessage = function(type, message)
		return Game.sendTextMessage(type, (message):format(Game.getNextEvent()))
	end,	
}