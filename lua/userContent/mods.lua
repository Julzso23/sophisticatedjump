function addModFolder( path )
	if not love.filesystem.exists( path ) then
		love.filesystem.createDirectory( path )
	end

	for k, v in pairs( love.filesystem.getDirectoryItems( path ) ) do
		if love.filesystem.isFile( path.."/"..v ) then
			if string.find( path.."/"..v, ".lua" ) then
				love.filesystem.load( path.."/"..v )()
			end
		elseif love.filesystem.isDirectory( path.."/"..v ) then
			addModFolder( path.."/"..v )
		end
	end
end

hook.add( "load", "loadMods", function ()
	addModFolder( "mods" )
end )