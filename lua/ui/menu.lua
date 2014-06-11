gui = require( "lib/jGui" )

menu = {}
menu.__index = menu

menu.menus = {}

function menu.create ( name, key, x, y, w, h, buttons, onLoad )
	local m = {}

	m.name = name

	m.x = x
	m.y = y
	m.w = w
	m.h = h

	m.buttons = {}

	m.label = gui.create( "label", x, y, w, 100 )
	m.label:setText( name )

	m.onLoad = onLoad or function()end

	m.visible = false
	m.active = false

	for k, v in pairs ( buttons ) do
		m.buttons[k] = gui.create( "button", x, y + (k-1)*((h - 100)/(#buttons)) + 100, w, (( h - 100 )/(#buttons)) )
		m.buttons[k]:setText( v[1] )
		m.buttons[k].onClick = v[2]
	end

	setmetatable( m, menu )

	menu.menus[key] = m
end

function menu.remove ( key )
	menu.menus[key] = nil
end

function menu.isOpen ()
	local open = false

	for k, v in pairs( menu.menus ) do
		if v.visible then
			open = true
		end
	end

	return open
end

function menu:setVisible ( visible )
	if visible then
		self:onLoad()

		for _, i in pairs( menu.menus ) do
			i.visible = false
			i.active = false
		end
	end

	self.visible = visible
	self.active = visible
end


hook.add( "load", "menus", function ()
	menu.create( "Sophisticated Jump", "main", love.window.getWidth()/4, 0, love.window.getWidth()/2, love.window.getHeight(),
	{
		{ "Play", function ()
			hook.call( "gameInit" )
			menu.menus.main:setVisible( false )
		end },
		{ "Options", function () menu.menus.options:setVisible( true ) end },
		{ "Exit", function () love.event.quit() end }
	},
	function ()
		love.graphics.setBackgroundColor( 200, 200, 200 )
	end )

	menu.create( "Options", "options", love.window.getWidth()/4, 0, love.window.getWidth()/2, love.window.getHeight(),
	{
		{ "Video", function () print( "video" ) end },
		{ "Audio", function () print( "audio" ) end },
		{ "Controls", function () print( "controls" ) end },
		{ "Back", function () menu.menus.main:setVisible( true ) end }
	})

	menu.create( "Controls", "options_controls", love.window.getWidth()/4, 0, love.window.getWidth()/2, love.window.getHeight(),
	{
		{ "Left", function () end },
		{ "Right", function () end },
		{ "Shoot", function () end },
		{ "Back", function () menu.menus.main:setVisible( true ) end }
	})

	menu.menus.main:setVisible( true )
end )

hook.add( "update", "menus", function ( dt )
	for _, i in pairs( menu.menus ) do
		if i.active then
			for k, v in pairs( i.buttons ) do
				v:update()
			end
		end
	end
end )

hook.add( "draw", "menus", function ()
	for _, i in pairs( menu.menus ) do
		if i.visible then
			i.label:draw()
			for k, v in pairs( i.buttons ) do
				v:draw()
			end
		end
	end
end )

hook.add( "mousepressed", "menus", function ( x, y, button )
	for _, i in pairs( menu.menus ) do
		if i.active then
			for k, v in pairs( i.buttons ) do
				v:mousePressed( x, y, button )
			end
		end
	end
end )
hook.add( "mousereleased", "menus", function ( x, y, button )
	for _, i in pairs( menu.menus ) do
		if i.active then
			for k, v in pairs( i.buttons ) do
				v:mouseReleased( x, y, button )
			end
		end
	end
end )