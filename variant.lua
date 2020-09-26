return setmetatable(
{
	getNumber = function(self)
		return self.number
	end,
	getString = function(self)
		return self.string
	end,
	getPosition = function(self)
		return Position(self.pos)
	end,
},
{
	__call = function(this, var)
		local variant = nil
		if isNumber(var) then
			variant = numberToVariant(var)
		elseif isString(var) then
			variant = stringToVariant(var)
		elseif isTable(var) then
			if var.x and var.y and var.z then
				if target then
					variant = targetPositionToVariant(var)
				else
					variant = positionToVariant(var)
				end
			else
				variant = var
			end
		end
		return setmetatable(variant, {__index = this})
	end,
}
)