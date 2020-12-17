-- -- function createRect(x, y)
-- -- 	local rect = {}
-- -- 	rect.x = x
-- -- 	rect.y = y
-- -- 	rect.w = 70
-- -- 	rect.h = 90
-- -- 	rect.speed = 100
-- -- 	table.insert(listOfRectangles, rect)
-- -- end

-- -- function love.keypressed(key)
-- -- 	if key == "space" then
-- -- 		createRect(math.random(100, 500), math.random(100, 500))
-- -- 	end
-- -- end

-- function love.load()
-- 	Rectangle = require "rectangle"
-- 	Circle = require "circle"

-- 	-- collectionOfCircles = {}
-- 	-- for i = 1,20 do
-- 	-- 	table.insert(collectionOfCircles, i, Circle(300, 300, 5 * i))
-- 	-- end 	

-- 	r1 = Rectangle(math.random(100, 500), math.random(100, 500),  100, 20)
-- 	r2 = Rectangle(math.random(100, 500), math.random(100, 500),  20, 100)

-- 	-- c1 = Circle(math.random(100, 500), math.random(100, 500), 100)
-- 	-- c2 = Circle(math.random(100, 500), math.random(100, 500), 20)

-- end

-- function love.update(dt)
-- 	-- for i,v in ipairs(collectionOfCircles) do
-- 	-- 	v:update(dt / (1.2^(21 - i)))
-- 	-- end 

-- 	r1:update(dt)
-- 	-- r2:update(dt / 2)
-- 	-- c1:update(dt)
-- 	-- c2:update(dt / 2)	
-- -- 	for i,v in ipairs(listOfRectangles) do
-- -- 		if love.keyboard.isDown("right") then v.x = v.x + v.speed * dt end 
-- -- 		if love.keyboard.isDown("left")  then v.x = v.x - v.speed * dt end
-- -- 		if love.keyboard.isDown("down")	 then v.y = v.y + v.speed * dt end	
-- -- 		if love.keyboard.isDown("up") 	 then v.y = v.y - v.speed * dt end		
-- -- 	end
-- -- 	tick.update(dt)
-- end

-- function love.draw()

-- 	if r1:checkCollision(r2) then
-- 		mode = "fill"
-- 	else
-- 		mode = "line"
-- 	end

-- 	-- for i,v in ipairs(collectionOfCircles) do
-- 	-- 	v:draw()
-- 	-- end 
-- 	r1:draw(mode)
-- 	r2:draw(mode)
-- 	-- c1:draw()
-- 	-- c2:draw()	
-- 	-- if drawRectangle then
-- 	-- 	for i,v in ipairs(listOfRectangles) do
-- 	-- 		love.graphics.rectangle("line", v.x, v.y, v.w, v.h)
-- 	-- 	end 	
-- 	-- end
-- end

-- function love.load()

	TileImage = require 'map/tileimage'
	TileMap = require 'map/tilemap'

	image = love.graphics.newImage('Spritesheet/roguelikeSheet_transparent.png')
	tileimages = TileImage.processSpritesheet(image, 16, 16) 

	local numrows = (image:getHeight() + 1) / (16 + 1)
	local numcols = (image:getWidth() + 1) / (16 + 1)
	print((image:getHeight() + 1) / (16 + 1), numrows)
	print((image:getWidth() + 1) / (16 + 1), numcols)

	-- local rawmap = {}
	-- for i = 1, numrows do
	-- 	local rawrow = {}
	-- 	for j = 1, numcols do
	-- 		print(i, j, (j - 1) * numrows + 1)
	-- 		table.insert(rawrow, (j - 1) * numrows + i)
	-- 	end 	
	-- 	table.insert(rawmap, rawrow)
	-- end

	local nwc = numrows * 2 + 1
	local wed = numrows * 2 + 2
	local swc = numrows * 2 + 3
	local ned = numrows * 3 + 1 
	local cen = numrows * 3 + 2
	local sed = numrows * 3 + 3
	local nec = numrows * 4 + 1
	local eed = numrows * 4 + 2
	local sec = numrows * 4 + 3

	local rawmap = {
			{nwc, ned, ned, ned, nec},
			{wed, cen, cen, cen, eed},
			{wed, cen, cen, cen, eed},
			{wed, cen, cen, cen, eed},
			{wed, cen, cen, cen, eed},
			{wed, cen, cen, cen, eed},
			{wed, cen, cen, cen, eed},			
			{wed, cen, cen, cen, eed},
			{wed, cen, cen, cen, eed},
			{wed, cen, cen, cen, eed},
			{wed, cen, cen, cen, eed},
			{wed, cen, cen, cen, eed},
			{wed, cen, cen, cen, eed},
			{wed, cen, cen, cen, eed},
			{wed, cen, cen, cen, eed},			
			{wed, cen, cen, cen, eed},
			{wed, cen, cen, cen, eed},			
			{swc, sed, sed, sed, sec},
		}

	-- local rawmap = {
	-- 	{1,1,1,1},
	-- 	{2,2,2,2},
	-- 	{3,3,3,3},
	-- 	{4,4,4,4}
	-- }

	tilemap = TileMap(0, 0, rawmap, tileimages)
	
end

function love.update(dt)
end

function love.draw()
	tilemap:draw()
end