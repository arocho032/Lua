local Screen = {}
Screen.__index = Screen

local metatable = {
	__call = function(self, ...)
		local obj = setmetatable({}, self)
		obj:new(...)
		return obj
	end
}

setmetatable(Screen, metatable)

function Screen:new()
	self.w = love.graphics.getWidth()
	self.h = love.graphics.getHeight()
	self.windows = {}
end

function Screen:draw()
	for i, window in ipairs(self.windows) do
		window:draw()
	end 
end

function Screen.standard_configuration()
	Window = require 'screen/window'
	local screen = Screen()
	-- game window (0.75 W X 0.75 H)
	local stlayer = {"background", "midground", "foreground"}
	local xbound = screen.w * 0.75
	local ybound = screen.h * 0.75
	local gamewindow = Window(0, 0, xbound, ybound, stlayer)
	local sidewindow = Window(xbound, 0, screen.w - xbound, screen.h, stlayer)
	local textwindow = Window(0, ybound, xbound, screen.h - ybound, stlayer)
	table.insert(screen.windows, gamewindow)
	table.insert(screen.windows, sidewindow)
	table.insert(screen.windows, textwindow)
	return screen 
end

return Screen