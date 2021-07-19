function PushFunction(function_name, ...)
	return select(2, pcall(function_name, ...))
end
function isTable(var)
	return type(var) == "table"
end
function isString(var)
	return type(var) == "string"
end
function isNumber(var)
	return tonumber(var) and type(var) == "number"
end
function isFunction(var)
	return type(var) == "function"
end
function isMetatable(var)
	return type(var) == "table" and getmetatable(var)
end
function isBoolean(var)
	return type(var) == "boolean"
end
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
string.empty = function(self)
	local count = #self
	return count == 0
end
string.isTable = function(self)
    return self:sub(1, 1) == "{" and self:sub(self:len()) == "}"
end
table.empty = function(tb)
	local count = 0
	for _ in pairs(tb) do
		count = count + 1
	end
	return count == 0
end
table.tostring = function(tb, err)
    var = err and error or print
    local str = '{'
    local begin = true
    for i, v in pairs(tb) do
        local index = nil
        if tonumber(i) then
            index = ("%d"):format(i)
        else
            index = ("'%s'"):format(i)
        end
        if not begin then
            str = str..", "
        else
            begin = false
        end
        if type(v) == "table" or type(v) == "userdata" then
            str = ("%s[%s] = %s"):format(str, index, table.tostring(v))
        elseif type(v) == "string" then
            str = ("%s[%s] = '%s'"):format(str, index, v)
        elseif type(v) == "number" then
            str = ("%s[%s] = %d"):format(str, index, v)
        else
            begin = true
            var(("is not possible convert '%s' to string. [%s])"):format(type(v), index))
        end
    end
    str = str.."}"
    return str
end
function string.totable(self)
    local str = ""
    if not self:isTable() then
        str = ("return {}")
    else
        str = ("return %s"):format(self)
    end
    local bool, func = pcall(assert, loadstring(str))
    if not bool then
        local find = func:find(":")
        return error(func:sub(find+4, func:len()),2)
    end
    return func()
end
eq_event = function(first, second) -- __eq metamethod function used in all developed classes
	if getmetatable(first) and getmetatable(second) then
		return getmetatable(first) == getmetatable(second)
	end
end
Game = dofile('data/lib/KenfiLib/game.lua')
Variant = dofile('data/lib/KenfiLib/variant.lua')
Position = dofile('data/lib/KenfiLib/position.lua')
Tile = dofile('data/lib/KenfiLib/tile.lua')
Item = dofile('data/lib/KenfiLib/item.lua')
Container = dofile('data/lib/KenfiLib/container.lua')
Teleport = dofile('data/lib/KenfiLib/teleport.lua')
Creature = dofile('data/lib/KenfiLib/creature.lua')
Player = dofile('data/lib/KenfiLib/player.lua')
Monster = dofile('data/lib/KenfiLib/monster.lua')
Npc = dofile('data/lib/KenfiLib/npc.lua')
Guild = dofile('data/lib/KenfiLib/guild.lua')
Group = dofile('data/lib/KenfiLib/group.lua')
Vocation = dofile('data/lib/KenfiLib/vocation.lua')
Town = dofile('data/lib/KenfiLib/town.lua')
House = dofile('data/lib/KenfiLib/house.lua')
ItemType = dofile('data/lib/KenfiLib/itemtype.lua')
Combat = dofile('data/lib/KenfiLib/combat.lua')
Condition = dofile('data/lib/KenfiLib/condition.lua')
MonsterType = dofile('data/lib/KenfiLib/monstertype.lua')
--PARTY ;( xddddd
