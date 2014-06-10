hook.add( "gameInit", "playerInit", function ()
	world = {}
	world.platforms = {}

	controls.newKeyBind( "left", "a" )
	controls.newKeyBind( "right", "d" )
	controls.newKeyBind( "shoot", " " )

	controls.axis.create( "horizontal", controls.keybinds.right, controls.keybinds.left, "leftx", 0.25 )
	controls.axis.create( "shoot", controls.keybinds.shoot, nil, "triggerright", 0.25 )

	pl = player.create( 640, 360 )

	for i = 1, 10 do
		table.insert( world.platforms, platform.create( math.random( 1, 128 )*10, math.random( 1, 72 )*10, "grass" ) )
	end
end )

hook.add( "gameUpdate", "update", function ( dt )
	pl:update( dt )
	pl:move( controls.axes.horizontal:value(), dt )

	for k, v in pairs( world.platforms ) do
		v:update()

		if v.y > love.window.getHeight()+144 then
			table.remove( world.platforms, k )
		end
	end	
end )

hook.add( "gameDraw", "draw", function ()
	for k, v in pairs( world.platforms ) do
		v:draw()
	end

	pl:draw()
end )