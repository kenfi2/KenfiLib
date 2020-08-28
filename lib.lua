function eq_event(a,b)
	if getmetatable(a) and getmetatable(b) then
		return getmetatable(a) == getmetatable(b)
	end
end

dofile('data/lib/KenfiLib/combat.lua')
dofile('data/lib/KenfiLib/condition.lua')
dofile('data/lib/KenfiLib/container.lua')
dofile('data/lib/KenfiLib/creature.lua')
dofile('data/lib/KenfiLib/game.lua')
dofile('data/lib/KenfiLib/item.lua')
dofile('data/lib/KenfiLib/monster.lua')
dofile('data/lib/KenfiLib/player.lua')
dofile('data/lib/KenfiLib/position.lua')
dofile('data/lib/KenfiLib/tile.lua')
dofile('data/lib/KenfiLib/town.lua')
