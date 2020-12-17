Shape = require 'shape'

local Rectangle = {}
Rectangle.__index = Rectangle
Rectangle.super = Shape
setmetatable(Rectangle, Shape)

function Rectangle:new(x, y, w, h) 
	Rectangle.super.new(self, x, y)
	self.w = w
	self.h = h
end

function Rectangle:draw(mode)
	love.graphics.rectangle(mode, self.x, self.y, self.w, self.h)
end


function Rectangle:checkCollision(other)
	return self.x + self.w > other.x 
			and self.x < other.x + other.w 
			and self.y + self.h > other.y 
			and self.y < other.y + other.h
end 

function Rectangle:__call(...)
	local obj = setmetatable({}, self)
	obj = self.new(...)
	return obj
end

return Rectangle