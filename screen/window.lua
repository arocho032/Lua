local Window = {}
Window.__index = Window

local metatable = {
	__call = function(self, ...)
		local obj = setmetatable({}, self)
		obj:new(...)
		return obj
	end
}

setmetatable(Window, metatable)

function Window:new(x, y, w, h, layers)
	self.x = x
	self.y = y
	self.w = w
	self.h = h
	self.layer = layers
	self.screen_elements = {}
	for i,layer in ipairs(self.layer) do
		self.screen_elements[layer] = {}
	end
	print_r(self.screen_elements)
end 

function Window:add_element(element, layer)
	print(self.x, self.y, self.w, self.h)
	print(element.x, element.y, element.w, element.h)
	if element.x >= self.x 
		and element.x + element.w <= self.x + self.w
		and element.y >= self.y 
		and element.y + element.h <= self.y + self.h
		then
			table.insert(self.screen_elements[layer], element)
	else
		error("Element out of bounds of window", 2)
	end 
end

function Window:remove_element(element, layer)
	-- TODO
end	

function Window:draw()
	for i, layer in pairs(self.screen_elements) do
		for j, element in pairs(layer) do
			element:draw()
		end 
	end 
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

return Window 
