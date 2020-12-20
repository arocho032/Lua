Tile = require 'map/tile'

-- Object Definition

local TileMap = {}
TileMap.__index = TileMap

local metatable = {
	__call = function(self, ...)
		local obj = setmetatable({}, self)
		obj:new(...)
		return obj		
	end 
}

setmetatable(TileMap, metatable)

-- Object Functions

function TileMap:new(x, y, rawmap, tileimage)

	self.x = x
	self.y = y

	-- TODO: Catch error here when len(tileimage) == 0 ?
	self.tw = tileimage[1].tw
	self.th = tileimage[1].th
	self.mr = table.getn(rawmap)
	self.mc = table.getn(rawmap[1])

	self.h = self.mr * self.th
	self.w = self.mc * self.tw

	self.map = {}
	for row = 1, self.mr do
		for col = 1, self.mc do
			if type(rawmap[row][col]) == "table" then
				local tims = {}
				for i,v in ipairs(rawmap[row][col]) do 
					table.insert(tims, tileimage[v])
				end 
				table.insert(self.map, Tile(tims))
			else
				table.insert(self.map, Tile({tileimage[rawmap[row][col]]}))
			end
		end 
	end 

end

function TileMap:draw()
	local icol = 0
	local irow = 0
	for i,v in ipairs(self.map) do
		icol = math.floor((i - 1) / self.mc)
		irow = (i - 1) % self.mc
		v:draw(self.x + irow * self.tw, self.y + icol * self.th) 
	end
end

return TileMap