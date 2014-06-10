platform = {}
platform.__index = platform

function platform.create ( x, y, variant )
	local p = {}

	p.x = x
	p.y = y

	p.variant = variant
	p.img = love.graphics.newImage( "images/platform_"..variant..".png" )

	setmetatable( p, platform )

	return p
end

function platform:update ()
	if (pl.x+24 > self.x-48) and (pl.x-24 < self.x+48) and (pl.y+48 > self.y-12) and (pl.y+48 < self.y+12) and (pl.falling) then
		for k, v in pairs( world.platforms ) do
			v.y = v.y + ( pl.y - (self.y - 60) )
		end
		pl:jump()
	end
end

function platform:draw ()
	love.graphics.setColor( 255, 255, 255, 255 )
	love.graphics.draw( self.img, self.x, self.y, 0, 1, 1, 48, 12 )
end