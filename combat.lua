Combat = setmetatable(
{
	setParameter = function(self, key, value)
		setCombatParam(self.combat, key, value)
	end,
	setFormula = function(self,type, ...)
		setCombatFormula(self.combat, type, ...)
	end,
	setArea = function(self, area)
		setCombatArea(self.combat, area)
	end,
	addCondition = function(self, condition)
		if isMetatable(condition) then
			setCombatCondition(self.combat, condition.condition)
			return
		end
		setCombatCondition(self.combat, condition)
	end,
	setCallback = function(self, key, function_name)
		setCombatCallBack(self.combat, key, function_name)
	end,
	execute = function(self, creature, variant)
		if not isMetatable(creature) then
			return error(("bad argument #1 to 'execute' (metatable expected, got %s)"):type(creature))
		end
		doCombat(creature:getId(), self.combat, variant)
	end,
},
{
	__call = function(this, ...)
		return setmetatable({combat = createCombatObject()}, {__index = this, __eq = eq_event(a, b)})
	end,
}
)