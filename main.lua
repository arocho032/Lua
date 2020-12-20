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

	Screen = require 'screen/screen'
	screen = Screen.standard_configuration()
	gamewindow_w = screen.windows[1].w
	gamewindow_h = screen.windows[1].h
	max_cols = math.floor(gamewindow_w / 16)
	max_rows = math.floor(gamewindow_h / 16)

	mm = MazeMaker(math.floor((max_rows - 1)/2), math.floor((max_cols - 1)/2))
	rm = mm:asRawmap(map)
	map = TileMap(0, 0, rm, tileimages)

	screen.windows[1]:add_element(map, "midground")

    bgCanvas = love.graphics.newCanvas(gamewindow_w, gamewindow_h)
    love.graphics.setCanvas(bgCanvas)
    love.graphics.setColor(0.8, 0.9, 0.4)
    love.graphics.rectangle("fill", 0, 0, gamewindow_w, gamewindow_h)
    love.graphics.setCanvas()
    
    screen.windows[1]:add_element(bgCanvas, "background")


end

function love.update(dt)
end

function love.draw()
	screen:draw()
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