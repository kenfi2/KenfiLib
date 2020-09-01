House = setmetatable(
{
	getId = function(self)
		return self.id
	end,
	getName = function(self)
		return self.name
	end,
	getTown = function(self)
		return Town(self.town)
	end,
	getExitPosition = function(self)
		return Position(self.entry)
	end,
	getRent = function(self)
		return self.price
	end,
	getOwnerGuid = function(self)
		return self.owner
	end,
	setOwnerGuid = function(self, guid, clean)
		clean = clean or true
		setHouseOwner(self.id, guid, clean)
	end,
	getBeds = function(self)
		local beds = {}
		for _, pos in ipairs(self.beds) do
			local tile = Tile(pos)
			local bed = tile:getItemByType(ITEM_TYPE_BED)
			table.insert(beds, bed)
		end
		return beds
	end,
	getBedCount = function(self)
		return #self.beds
	end,
	getDoors = function(self)
		local doors = {}
		for _, pos in ipairs(self.doors) do
			local tile = Tile(pos)
			local door = tile:getItemByType(ITEM_TYPE_DOOR)
			table.insert(doors, door)
		end
		return doors
	end,
	getDoorCount = function(self)
		return #self.doors
	end,
	getDoorIdByPosition = function(self, position)
		for _, pos in ipairs(self.doors) do
			local tile = Tile(pos)
			local door = tile:getItemByType(ITEM_TYPE_DOOR)
			if pos.x == position.x and pos.y == position.y and pos.z == position.z then
				return door:getId()
			end
		end
	end,
	getTiles = function(self)
		local tiles = {}
		for _, pos in ipairs(self.tiles) do
			local tile = Tile(pos)
			table.insert(tiles, tile)
		end
		return tiles
	end,
	getItems = function(self)
		-- This function was not completed due to an error in the function getThing.
	end,
	getTileCount = function(self)
		return self.size
	end,
	canEditAccessList = function(self, player)
		for i = 256,257 do
			if list:find(player:getName()) then
				return true
			end
		end
		return false
	end,
	getAccessList = function(self, listid)
		return getHouseAccessList(self.id, listid)
	end,
	setAccessList = function(self, listid, listtext)
		setHouseAccessList(self.id, listid, listtext)
	end,
},
{
	__call = function(this, var)
		local id = 0
		if isTable(var) then
			id = var.id
		elseif isNumber(var) then
			id = tonumber(var)
		end
		return setmetatable(getHouseInfo(id), {__index = this, __eq = eq_event(a, b),})
	end,
}
)