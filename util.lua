local vector = require("libs/vector/vector")

interpolate = function(a, b, t)
	return a*t + b*(1-t) 
end

dot_grid_gradient = function(x0, y0, x, y, dv)
	local v = vector.random()

	local dx = (x - x0) / dv.x
	local dy = (y - y0) / dv.y

	return (dx*v.x + dy*v.y)
end

perlin = function(x, y, dv)
	local dx = x % dv.x		-- dx from point to grid point
	local dy = y % dv.y		-- dy from point to grid point

	local x0 = x - dx		-- top left grid point
	local y0 = y - dy
	local x1 = x0 + dv.x		-- down right grid point
	local y1 = y0 + dv.y

	dx = (x - x0) / dv.x
	dy = (y - y0) / dv.y

	local n0, n1, ix0, ix1, value

	n0 = dot_grid_gradient(x0, y0, x, y, dv)
	n1 = dot_grid_gradient(x1, y0, x, y, dv)
	ix0 = interpolate(n0, n1, dx)

	n0 = dot_grid_gradient(x0, y1, x, y, dv)
	n1 = dot_grid_gradient(x1, y1, x, y, dv)
	ix1 = interpolate(n0, n1, dx)

	value = interpolate(ix0, ix1, dy)

	return value
end
