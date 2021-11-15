require("util")
local vector = require("libs/vector/vector")

local start 		= true
local width, height 	= love.graphics.getDimensions()
local N 	      	= width * height		-- number of intersections on grid
local offx		= 1				-- every freq pixels create a vector
local offy		= 1				-- every freq pixels create a vector
local perlins 		= {}
local dv		= {x = offx, y = offy}

love.load = function()
	for i = 0, height-1 do
		perlins[i] = {}
		for j = 0, width-1 do
			perlins[i][j] = perlin(j, i, dv)
		end
	end
end

love.update = function(dt)
	if start then
		for i = 0, height-1 do
			for j = 0, width-1 do
				perlins[i][j] = perlin(j, i, dv)
			end
		end
		start = not start
	end
end

love.draw = function()
	for i = 0, height-1 do
		for j = 0, width-1 do
			color = perlins[i][j] 
			if color > 1 then
				color = 1
			elseif color < -1 then
				color = -1
			end
			love.graphics.setColor(1, 1, 1, color)
			love.graphics.points(j, i)
		end
	end

end

love.keypressed = function(key, code, isrepeat)
	if key == "q" then
		love.event.quit()
	elseif key == "space" then
		start = not start
	end
end
