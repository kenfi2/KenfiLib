ItemType = setmetatable( 
{
	isCorpse = function(self) return self.corpseType ~= 0 end,
	isDoor = function(self) return self.group == ITEM_TYPE_DOOR end,
	isContainer = function(self) return self.group == ITEM_GROUP_CONTAINER end,
	isFluidContainer = function(self) return self.group == ITEM_GROUP_FLUID end,
	isMovable = function(self) return self.movable end,
	isRune = function(self) return self.group == ITEM_TYPE_RUNE end,
	isStackable = function(self) return self.stackable end,
	getName = function(self) return self.name end,
	getId = function(self) return self.id end,
},
{
	__call = function(this, var)
		if isNumber(var) then
			if var > 65535 then
				var = getThing(var).itemid
			end
		elseif isString(var) then
			if getItemIdByName(var) then
				var = getItemIdByName(var)
			end
		elseif isMetatable(var) then
			var = var:getId()
		end
		local itemTable = getItemInfo(var)
		itemTable.id = var
		return setmetatable(itemTable, {__index = this, __eq = eq_event(a, b)})
	end,
}
)