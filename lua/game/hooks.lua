hook.add( "update", "gameUpdate", function ( dt )
	if not menu.open() then
		hook.call( "gameUpdate", dt )
	end
end )

hook.add( "draw", "gameDraw", function ()
	if not menu.open() then
		hook.call( "gameDraw" )
	end
end )