local Callable = {}
Callable.__index = Callable

function Callable:__call(...)
	local obj = setmetatable({}, self)
	obj = self.new(...)
	return obj
end

return Callable