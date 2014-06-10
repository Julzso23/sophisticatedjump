function includeFolder ( path )
	for k, v in pairs( love.filesystem.getDirectoryItems( path ) ) do
		if love.filesystem.isFile( path.."/"..v ) then
			require( path.."/"..string.gsub( v, ".lua", "" ) )
		elseif love.filesystem.isDirectory( path.."/"..v ) then
			includeFolder( path.."/"..v )
		end
	end
end