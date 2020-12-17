-- Object Definition

local TileImage = {}
TileImage.__index = TileImage

local metatable = {
	__call = function(self, ...)
		local obj = setmetatable({}, self)
		obj:new(...)
		return obj		
	end 
}

setmetatable(TileImage, metatable)

-- Object Functions

function TileImage:new(image, tw, th, quad)
	self.image = image
	self.tw = tw
	self.th = th
	self.quad = quad  
end 

function TileImage:draw(x, y)
	-- TODO: Add Color as a parameter?
	love.graphics.draw(self.image, self.quad, x, y)
end

-- Static Methods

function TileImage.processSpritesheet(img, tw, th)
	
	local tileimages = {}
	
	local iw = img:getWidth()
	local ih = img:getHeight()
	for col = 0, iw / (tw + 1) do
		for row = 0, ih / (th + 1) do
			table.insert(
					tileimages, 
					TileImage(img, tw, th, 
							love.graphics.newQuad(
								col * (tw + 1),
							 	row * (th + 1), 																
							 	tw, th, iw, ih)
						)
				)
		end 
	end 

	return tileimages

end

return TileImage