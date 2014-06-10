hook.add( "gameDraw", "drawHUD", function ()
	love.graphics.setColor( 0, 0, 0, 255 )
	love.graphics.print( "Score: "..math.floor(pl.totalDist / 100), 10, 10 )
end )