hook.add( "update", "gameUpdate", function ( dt )
	if not menu.isOpen() then
		hook.call( "gameUpdate", dt )
	end
end )

hook.add( "draw", "gameDraw", function ()
	if not menu.isOpen() then
		hook.call( "gameDraw" )
	end
end )