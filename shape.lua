local Shape = {}
Shape.__index = Shape

local metatable = {
	__call = function(self, ...)
		local obj = setmetatable({}, self)
		obj:new(...)
		return obj		
	end 
}

setmetatable(Shape, metatable)

function Shape:new(x, y)
	self.x = x
	self.y = y
	self.speed = 500
end 

function Shape:update(dt)
	if love.keyboard.isDown("right") then self.x = self.x + self.speed * dt end 
	if love.keyboard.isDown("left")  then self.x = self.x - self.speed * dt end
	if love.keyboard.isDown("down")	 then self.y = self.y + self.speed * dt end	
	if love.keyboard.isDown("up") 	 then self.y = self.y - self.speed * dt end		
end

return Shape