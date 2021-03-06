function love.conf(t)
	t.identity = "SJump"
	t.version = "0.9.0"
	t.console = true

	t.window.title = "Sophisticated Jump"
	t.window.icon = "images/icon.png"
	t.window.width = 1280
	t.window.height = 720
	t.window.borderless = false
	t.window.resizable = false
	t.window.minwidth = 1
	t.window.minheight = 1
	t.window.fullscreen = false
	t.window.fullscreentype = "normal"
	t.window.vsync = true
	t.window.fsaa = 0
	t.window.display = 1

	t.modules.audio = true
	t.modules.event = true
	t.modules.graphics = true
	t.modules.image = true
	t.modules.joystick = true
	t.modules.keyboard = true
	t.modules.math = true
	t.modules.mouse = true
	t.modules.physics = false
	t.modules.sound = true
	t.modules.system = true
	t.modules.timer = true
	t.modules.window = true
end