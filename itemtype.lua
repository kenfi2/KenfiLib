ItemType = setmetatable( 
{
	isCorpse = function(self) return self.corpseType ~= 0 end,
	isDoor = function(self) return self.group == ITEM_TYPE_DOOR end,
	isContainer = function(self) return self.group == ITEM_GROUP_CONTAINER end,
	isFluidContainer = function(self) return self.group == ITEM_GROUP_FLUID end,
	isMovable = function(self) return self.movable end,
	isRune = function(self) return self.group == ITEM_TYPE_RUNE end,
	isStackable = function(self) return self.stackable end,
},
{
	__call = function(this, uid)
		if uid > 65535 then
			uid = getThing(uid).itemid
		end
		return setmetatable(getItemInfo(uid), {__index = this, __eq = eq_event(a, b)})
	end,
}
)