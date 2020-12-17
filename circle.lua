Shape = require 'shape'

local Circle = {}
Circle.__index = Circle
Circle.super = Shape
setmetatable(Circle, Shape)

function Circle:new(x, y, r) 
	Circle.super.new(self, x, y)
	self.r = r
end

function Circle:draw()
	love.graphics.circle("line", self.x, self.y, self.r, 25)
end

function Circle:__call(...)
	local obj = setmetatable({}, self)
	obj = self.new(...)
	return obj
end

return Circle