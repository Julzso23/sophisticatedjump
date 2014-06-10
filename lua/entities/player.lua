player = {}
player.__index = player

function player.create ( x, y )
	local p = {}

	p.x = x
	p.y = y

	p.hSpeed = 400
	p.vSpeed = 0

	p.distance = 0
	p.totalDist = 0

	p.falling = false
	p.standing = false

	p.img = love.graphics.newImage( "images/player.png" )

	p.stance = "idle"
	p.quads = {
		idle = love.graphics.newQuad( 0, 0, 96, 96, 288, 288 ),
		crouching = love.graphics.newQuad( 96, 0, 96, 96, 288, 288 ),
		jumping = love.graphics.newQuad( 192, 0, 96, 96, 288, 288 )
	}

	setmetatable( p, player )

	return p
end

function player:update ( dt )
	if not self.standing then
		if self.vSpeed <= 0 then
			self.falling = true
			self.stance = "crouching"
		end
		self.vSpeed = self.vSpeed - 450 * dt
	end

	for k, v in pairs( world.platforms ) do
		v.y = v.y + self.vSpeed * dt
	end
	self.distance = self.distance + self.vSpeed * dt
	self.totalDist = self.totalDist + self.vSpeed * dt

	if self.distance >= 200 then
		self.distance = 0
		table.insert( world.platforms, platform.create( math.random( 1, 128 )*10, -12, "grass" ) )
	end

	if self.y > love.window.getHeight() + 48 then
		self.totalDist = 0
		self.y = 360
	end

	if self.x < -48 then
		self.x = love.window.getWidth() + 48
	elseif self.x > love.window.getWidth() + 48 then
		self.x = -48
	end
end

function player:draw ()
	love.graphics.setColor( 255, 255, 255, 255 )
	love.graphics.draw( self.img, self.quads[ self.stance ], self.x, self.y, 0, 1, 1, 48, 48 )
end

function player:jump ()
	self.standing = true
	self.falling = false
	self.vSpeed = 0

	self.stance = "crouching"
	
	timer.temp( 0.05, 0, function ( self )
		self.stance = "idle"
		timer.temp( 0.05, 0, function ( self )
			self.stance = "jumping"
			self.vSpeed = 500
			self.standing = false
		end, self )
	end, self )
end

function player:move( x, dt )
	self.x = self.x + x * self.hSpeed * dt
end