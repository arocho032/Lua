function love.load()

	TileImage = require 'map/tileimage'
	TileMap = require 'map/tilemap'
	MazeMaker = require 'map/mazemaker'

	image = love.graphics.newImage('Spritesheet/roguelikeSheet_transparent.png')
	tileimages = TileImage.processSpritesheet(image, 16, 16) 
	local numrows = (image:getHeight() + 1) / (16 + 1)
	local numcols = (image:getWidth() + 1) / (16 + 1)

	local map = {}
	map['wall']  = numrows * 19 + 10
	map['floor'] = numrows * 5 + 1

	mm = MazeMaker(10, 10)
	rm = mm:asRawmap(map)
	tm = TileMap(0, 0, rm, tileimages)

end

function love.update(dt)
end

function love.draw()
	tm:draw()
end

function print_r(arr, indentLevel)
    local str = ""
    local indentStr = "#"

    if(indentLevel == nil) then
        print(print_r(arr, 0))
        return
    end

    for i = 0, indentLevel do
        indentStr = indentStr.."\t"
    end

    for index,value in pairs(arr) do
    	if indentLevel < 3 then
	        if type(value) == "table" then
	            str = str..indentStr..index..": \n"..print_r(value, (indentLevel + 1))
	        else 
	            str = str..indentStr..index..": "..value.."\n"
	        end
	    else
            str = str..indentStr..index..": "..tostring(value).."\n"
	    end 
    end
    return str
end