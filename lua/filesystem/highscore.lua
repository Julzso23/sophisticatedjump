if not filesystem then
	filesystem = {}
end

local msg = require( "lib/MessagePack" )

filesystem.highScore = 0

hook.add( "load", "loadHighScores", function ()
	if love.filesystem.exists( "saves/save.sjf" ) then
		local load = love.filesystem.read( "saves/save.sjf" )
		filesystem = msg.unpack( load )
	end
end )

hook.add( "highScore", "newHighScore", function ( score )
	if score > filesystem.highScore then
		filesystem.highScore = score

		local save = msg.pack( filesystem )
		if not love.filesystem.exists( "saves" ) then
			love.filesystem.createDirectory( "saves" )
		end
		love.filesystem.write( "saves/save.sjf", save )
	end
end )