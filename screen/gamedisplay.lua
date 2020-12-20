local GameDisplay = {}
GameDisplay.__index = GameDisplay

local metatable = {
	__call = function(self, ...)
		local obj = setmetatable({}, self)
		obj:new(...)
		return obj
	end
}

setmetatable(Screen, metatable)

function GameDisplay:new