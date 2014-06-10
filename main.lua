require( "lua/core/include" )

includeFolder( "lua/core" )

function love.load ( args ) hook.call( "load", args ) end

function love.update ( dt ) hook.call( "update", dt ) end

function love.draw () hook.call( "draw" ) end

function love.keypressed ( key, isRepeat ) hook.call( "keypressed", key, isRepeat ) end

function love.keyreleased ( key ) hook.call( "keyreleased", key ) end

function love.textinput ( text ) hook.call( "textinput", text ) end

function love.gamepadpressed ( joystick, button ) hook.call( "gamepadpressed", joystick, button ) end

function love.gamepadreleased ( joystick, button ) hook.call( "gamepadreleased", joystick, button ) end

function love.gamepadaxis ( joystick, axis ) hook.call( "gamepadaxis", joystick, axis ) end

function love.mousepressed ( x, y, button ) hook.call( "mousepressed", x, y, button ) end

function love.mousereleased ( x, y, button ) hook.call( "mousereleased", x, y, button ) end

function love.mousefocus ( f ) hook.call( "mousefocus", f ) end

function love.focus ( f ) hook.call( "focus", f ) end

function love.resize ( w, h ) hook.call( "resize", w, h ) end

function love.visible ( v ) hook.call( "visible", v ) end

function love.joystickadded ( joystick ) hook.call( "joystickadded", joystick ) end

function love.joystickremoved ( joystick ) hook.call( "joystickremoved", joystick ) end

function love.quit () hook.call( "quit" ) end

hook.add( "init", "load", function ()
	includeFolder( "lua" )
	hook.call( "load" )
end )