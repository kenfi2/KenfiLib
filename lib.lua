--basical functions.
function isTable(var)
	return type(var) == "table"
end
function isString(var)
	return type(var) == "string"
end
function isNumber(var)
	return tonumber(var) or type(var) == "number"
end
function isFunction(var)
	return type(var) == "function"
end
function isMetatable(var) -- this function won't work with strings
	return type(var) == "table" and getmetatable(var)
end
--thread function don't need be worked

-- basical strings function.

string.trim = function(self) -- Replace this function with 'string.trim' in the folder 'data/lib/011-string.lua'
	return self:match'^()%s*$' and '' or self:match'^%s*(.*%S)'
end

string.splitTrimmed = function(self, sep) -- This function has the same functionality as 'string.explode'
	local res = {}
	for v in self:gmatch("([^" .. sep .. "]+)") do
		res[#res + 1] = v:trim()
	end
	return res
end

string.tonumber = function(self) -- Special function that returns, in order, all numbers in string
	local signal = (self:match("%p") == "-" and self:match("%p") or "")
	local number = ""
	for i in self:gmatch("%d") do
		number = number..i
	end
	return tonumber(signal..number)
end

function eq_event(a,b) -- __eq metamethod function used in all developed classes
	if getmetatable(a) and getmetatable(b) then
		return getmetatable(a) == getmetatable(b)
	end
end

--Principal
dofile('data/lib/KenfiLib/game.lua') -- 19/24: Approximately 80% Functions TFS 1.3 (4 additional functions)
dofile('data/lib/KenfiLib/variant.lua') -- 3/3: 100% Functions TFS 1.3
dofile('data/lib/KenfiLib/position.lua') -- 4/4: 100% Functions TFS 1.3
dofile('data/lib/KenfiLib/tile.lua') -- 7/29: Approximately 25% Functions TFS 1.3
--Networkmessage isn't workable in this version
dofile('data/lib/KenfiLib/item.lua') -- 13/33: Approximately 40% Functions TFS 1.3
dofile('data/lib/KenfiLib/container.lua') -- 7/12: Approximately 60% Functions TFS 1.3
dofile('data/lib/KenfiLib/teleport.lua') -- 2/2: 50% Functions TFS 1.3 (because the 'getDestination' function doesn't exist in this version)
dofile('data/lib/KenfiLib/creature.lua') -- 21/53: Approximately 40% Functions TFS 1.3
dofile('data/lib/KenfiLib/player.lua') -- 37/105: Approximately 35% Functions TFS 1.3 ;(
dofile('data/lib/KenfiLib/monster.lua') -- 2/21: Approximately 10% Functions TFS 1.3  ;(
dofile('data/lib/KenfiLib/npc.lua') -- 100% Functions TFS 1.3
dofile('data/lib/KenfiLib/guild.lua') -- 4/8: 50% Functions TFS 1.3 (because in this version, this class was worked on using the player id)
dofile('data/lib/KenfiLib/group.lua') -- 6/7: Approximately 85% Functions TFS 1.3 (1 additional function)
dofile('data/lib/KenfiLib/vocation.lua') -- 16/19: Approximately 85% Functions TFS 1.3
dofile('data/lib/KenfiLib/town.lua') -- 100% Functions TFS 1.3
dofile('data/lib/KenfiLib/house.lua') -- 16/20: 80% Functions TFS 1.3
dofile('data/lib/KenfiLib/itemtype.lua') -- 9/43: Approximately 20% Functions TFS 1.3
dofile('data/lib/KenfiLib/combat.lua') -- 5/6: Approximately 80% Functions TFS 1.3 ('setOrigin' function doesn't exist ins this version)
dofile('data/lib/KenfiLib/condition.lua') -- 5/12: Approximately 40% Functions TFS 1.3
dofile('data/lib/KenfiLib/monstertype.lua') -- MonsterType SET functions does not work in this version. 0% Functions TFS 1.3
--Loot lib must be created manually
--MonsterSpell isn't workable in this version
--PARTY
--Callback's isn't workable in this version.
