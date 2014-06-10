local splash = {}

--clean up variables and event hooks
function splash.remove ()
	hook.remove( "load", "splash-screen" )
	hook.remove( "draw", "splash-screen" )
	hook.remove( "update", "splash-screen" )

	hook.call( "init" )

	splash = nil
end

--set up variables
hook.add( "load", "splash-screen", function ( args )
	--give it a nice white background
	love.graphics.setBackgroundColor( 255, 255, 255 )
	--load in the splash image
	splash.image = love.graphics.newImage( "images/splash-logo.png" )
	--time limit of the fading animation (seconds)
	splash.limit = 2
	splash.timer = 0
	--the alpha level of the splash image (transparency)
	splash.alpha = 0
	--if the game is not not in debug mode
	if love.filesystem.isFused() then
		--if the game was executed with the nosplash argument...
		if args[1] == "nosplash" then
			--set the timer to the limit to skip all the rest of the code
			splash.timer = splash.limit
		end	
	else
		--if the game was executed with the nosplash argument...
		if args[2] == "nosplash" then
			--set the timer to the limit to skip all the rest of the code
			splash.timer = splash.limit
		end
	end
end )

hook.add( "update", "splash-screen", function ( dt )
	--in the first third of the animation, the image fades in
	if splash.timer < splash.limit/3 then
		--increase the alpha! (reduce transparency)
		splash.alpha = splash.alpha + (255/(splash.limit/3))*dt
		--don't overflow with alpha now!
		if splash.alpha > 255 then
			splash.alpha = 255
		end
	end

	--the image then sits there for another third of the animation for the user to admire it
	--in the last third, fade it back out
	if (splash.timer > (splash.limit*2)/3) and (splash.timer < splash.limit) then
		splash.alpha = splash.alpha - (255/(splash.limit/3))*dt
		--can't have negative alpha, that would be silly
		if splash.alpha < 0 then
			splash.alpha = 0
		end
	end

	--increase the timer if time's not up
	if splash.timer < splash.limit then
		splash.timer = splash.timer + dt
	else
		--get rid of everything
		splash.remove()
	end
end )

--draw it all on the screen for the user to admire
hook.add( "draw", "splash-screen", function ()
	--keep the image normal colour with our changing alpha levels
	love.graphics.setColor( 255, 255, 255, splash.alpha )
	--position the image in the middle
	love.graphics.draw( splash.image, love.window.getWidth()/2 - splash.image:getWidth()/2, love.window.getHeight()/2 - splash.image:getHeight()/2 )
end )