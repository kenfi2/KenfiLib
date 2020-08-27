Game = {
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
		if #nextEvent > 0 then
			return
		end
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