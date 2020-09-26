return setmetatable( 
{
	--[[function_name = function(self, params)
			body
		end,
	]]
	corpseId = function(self)
		return self.lookCorpse
	end,
},
{
	__call = function(this, var)
		if isMetatable(var) then
			var = var:getName()
		end
		return setmetatable(getMonsterInfo(var), {__index = this, __eq = eq_event})
	end,
}
)--