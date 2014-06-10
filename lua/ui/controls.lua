controls = {}

controls.joysticks = {}

controls.axis = {}
controls.axis.__index = controls.axis

controls.axes = {}

controls.keybinds = {}

function controls.axis.create ( name, positive, negative, axis, deadzone )
	local a = {}

	a.positive = positive
	a.negative = negative
	a.axis = axis
	a.deadzone = deadzone

	setmetatable( a, controls.axis )

	controls.axes[ name ] = a
end

function controls.axis:value ()
	if self.positive and self.negative then
		if love.keyboard.isDown( self.positive ) and love.keyboard.isDown( self.negative ) then
			return 0
		end
	end

	if self.positive then
		if love.keyboard.isDown( self.positive ) then
			return 1
		end
	end

	if self.negative then
		if love.keyboard.isDown( self.negative ) then
			return -1
		end
	end

	if controls.joysticks[1] then
		if math.abs( controls.joysticks[1]:getGamepadAxis( self.axis ) ) > self.deadzone then
			return controls.joysticks[1]:getGamepadAxis( self.axis )
		end
	end

	return 0
end


function controls.newKeyBind ( name, default )
	controls.keybinds[ name ] = default
end

function controls.isDown ( bind )
	return love.keyboard.isDown( controls.keybinds[ bind ] )
end

function controls.vibrate( intensity )
	if controls.joysticks[1] then
		if controls.joysticks[1]:isVibrationSupported() then
			controls.joysticks[1]:setVibration( intensity, intensity )
			timer.temp( intensity, 0, function ()
				controls.joysticks[1]:setVibration( 0, 0 )
			end )
		end
	end
end

hook.add( "load", "loadJoysticks", function ()
	controls.joysticks = love.joystick.getJoysticks()
end )

hook.add( "joystickadded", "updateJoysticks", function ()
	controls.joysticks = love.joystick.getJoysticks()
end )

hook.add( "joystickremoved", "updateJoysticks", function ()
	controls.joysticks = love.joystick.getJoysticks()
end )