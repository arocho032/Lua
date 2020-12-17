-- Object Definition

local Tile = {}
Tile.__index = Tile

local metatable = {
	__call = function(self, ...)
		local obj = setmetatable({}, self)
		obj:new(...)
		return obj		
	end 
}

setmetatable(Tile, metatable)

function Tile:new(tileimage)
	self.tileimage = tileimage
end 

function Tile:draw(x, y)
	-- TODO: Add Color as a class variable and pass as a parameter?
	for i,v in ipairs(self.tileimage) do
		v:draw(x, y)
	end
end 

return Tile