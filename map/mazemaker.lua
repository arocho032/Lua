-- ################################################
-- 					Cell Function
-- ################################################

local Cell = {}
Cell.__index = Cell

local metatable = {
	__call = function(self, ...)
		local obj = setmetatable({}, self)
		obj:new(...)
		return obj
	end
}

setmetatable(Cell, metatable)

function Cell:new(x, y)

	self.x = x
	self.y = y
	self.links = {}

	-- Directions
	self.north = nil
	self.south = nil
	self.west = nil
	self.east = nil

end

function Cell:link(other, bidir)
	self.links[other] = true
	if bidir then other.link(self, false) end
end

function Cell:unlink(other, bidir)
	self.links[other] = false
	if bidir then other.unlink(self, false) end
end

function Cell:isLinked(other)
	return self.links[other] == true
end

function Cell:neighbors()
	neighbors = {}
	if self.north then table.insert(neighbors, self.north) end 
	if self.south then table.insert(neighbors, self.south) end 
	if self.west then table.insert(neighbors, self.west) end 
	if self.east then table.insert(neighbors, self.east) end
	return neighbors
end

-- ################################################
-- 					Grid Function
-- ################################################

local Grid = {}
Grid.__index = Grid
setmetatable(Grid, metatable)

function Grid:new(w, h)
	self.w = w
	self.h = h
	self.grid = {}

	-- Initialize Cells
	for i = 1, w do
		local row = {}
		for j = 1, h do
			local cell = Cell(i, j)
			table.insert(row, cell)
		end 
		table.insert(self.grid, row)
	end	

	-- Configure Cells 	
	for i = 1, w do
		local row = {}
		for j = 1, h do
			local cell = self:get(i, j)
			cell.north = self:get(i - 1, j)
			cell.south = self:get(i + 1, j)
			cell.west  = self:get(i, j - 1)
			cell.east  = self:get(i, j + 1)
		end 
		table.insert(self.grid, row)
	end
end

function Grid:get(x, y)
	if x < 1 or x > self.w then return nil end 
	if y < 1 or y > self.h then return nil end 
	return self.grid[x][y]
end

function Grid:getRandom()
	x = math.random(1, self.w)
	y = math.random(1, self.h)
	return self.get(x, y)
end

-- ################################################
-- 					MazeMaker Function
-- ################################################

local MazeMaker = {}
MazeMaker.__index = MazeMaker
setmetatable(MazeMaker, metatable)

-- Object Functions

function MazeMaker:new(w, h)
	self.grid = Grid(w, h)
	self:__binaryTree()
end 

function MazeMaker:__binaryTree()
	math.randomseed( os.time() )				
	for i = 1, self.grid.w do
		for j  = 1, self.grid.h do
			local neighbors = {}
			local cell = self.grid:get(i, j)
			if cell.south then table.insert(neighbors, cell.south) end
			if cell.east then table.insert(neighbors, cell.east) end
			index = math.random(1, table.getn(neighbors))
			local neighbor = neighbors[index]
			if neighbor ~= nil then cell:link(neighbor, true) end
		end
	end
end

function MazeMaker:asRawmap(tilemap)
	local rawmap = {}
	local row = {}
	for i = 1, self.grid.w * 2 + 1 do
		table.insert(row, {tilemap['floor'], tilemap['wall']})	
	end 
	table.insert(rawmap, row)

	for i = 1, self.grid.h do
		local top = {}
		local bottom = {}
		table.insert(top, {tilemap['floor'], tilemap['wall']})
		table.insert(bottom, {tilemap['floor'], tilemap['wall']})
		for j  = 1, self.grid.w do
			local cell = self.grid:get(i, j)
			table.insert(top, tilemap['floor'])			
			if cell:isLinked(cell.east)                                                                                                                                                                   
				then table.insert(top, tilemap['floor'])
				else table.insert(top, {tilemap['floor'], tilemap['wall']}) 
			end
			if cell:isLinked(cell.south) 
				then table.insert(bottom, tilemap['floor']) 
				else table.insert(bottom, {tilemap['floor'], tilemap['wall']})
			end
			table.insert(bottom, {tilemap['floor'], tilemap['wall']})
		end
		table.insert(rawmap, top)
		table.insert(rawmap, bottom)
	end
	return rawmap
end

return MazeMaker