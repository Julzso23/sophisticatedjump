local jGui = {}

jGui.colours = {
	idle = {250, 250, 250, 100},
	hover = {240, 240, 240, 100},
	click = {230, 230, 230, 100},
	solid = {230, 230, 230, 200},
	text = {50, 50, 50, 255}
}

jGui.font = love.graphics.newFont("fonts/segoeui.ttf", 30)
love.graphics.setFont(jGui.font)
love.keyboard.setKeyRepeat(true)

jGui.button = {}
jGui.button.__index = jGui.button
jGui.slider = {}
jGui.slider.__index = jGui.slider
jGui.textbox = {}
jGui.textbox.__index = jGui.textbox
jGui.label = {}
jGui.label.__index = jGui.label

jGui.objects = {
	button = function(x, y, w, h)
		local o = {}
		setmetatable(o, jGui.button)
		o.ox = x
		o.oy = y
		o.x = x
		o.y = y
		o.w = w
		o.h = h
		o.text = ""
		o.colour = "idle"
		o.mouseDown = false

		return o
	end,
	slider = function(x, y, w, h)
		local o = {}
		setmetatable(o, jGui.slider)
		o.ox = x
		o.oy = y
		o.x = x
		o.y = y
		o.w = w
		o.h = h
		o.scale = 10
		o.slidePos = 0

		return o
	end,
	textbox = function(x, y, w, h)
		local o = {}
		setmetatable(o, jGui.textbox)
		o.ox = x
		o.oy = y
		o.x = x
		o.y = y
		o.w = w
		o.h = h
		o.text = ""
		o.colour = "idle"
		o.selected = false

		return o
	end,
	label = function(x, y, w, h)
		local o = {}
		setmetatable(o, jGui.label)
		o.ox = x
		o.oy = y
		o.x = x
		o.y = y
		o.w = w
		o.h = h
		o.text = ""
		o.align = "center"

		return o
	end
}

function jGui.create(obj, x, y, w, h)
	return jGui.objects[obj](x, y, w, h)
end

------BUTTONS------
function jGui.button:update()
	local x, y = love.mouse.getX(), love.mouse.getY()
	if x > self.x and x < self.x+self.w and y > self.y and y < self.y+self.h then
		if love.mouse.isDown("l") then
			if self.mouseDown then
				self.colour = "click"
			end
		else
			self.colour = "hover"
		end
	else
		if love.mouse.isDown("l") then
			self.mouseDown = false
		end

		self.colour = "idle"
	end
end

function jGui.button:draw()
	love.graphics.setColor(jGui.colours[self.colour])
	love.graphics.rectangle("fill", self.x, self.y, self.w, self.h)

	love.graphics.setColor(jGui.colours.text)
	love.graphics.printf(self.text, self.x, self.y+self.h/2-love.graphics.getFont():getHeight()/2, self.w, "center")
end

function jGui.button:setText(text)
	self.text = text
end

function jGui.button:mousePressed(x, y, button)
	if button == "l" and x > self.x and x < self.x+self.w and y > self.y and y < self.y+self.h then
		self.mouseDown = true
	end
end
function jGui.button:mouseReleased(x, y, button)
	if button == "l" and self.mouseDown and x > self.x and x < self.x+self.w and y > self.y and y < self.y+self.h then
		self:onClick()
	end
end

function jGui.button:onClick()
end

function jGui.button:textinput(text)
end

function jGui.button:keyPressed(key, isRepeat)
end

------TEXT BOXES------
function jGui.textbox:update()
	if self.selected then
		self.colour = "hover"
	else
		self.colour = "idle"
	end
end

function jGui.textbox:draw()
	love.graphics.setColor(jGui.colours[self.colour])
	love.graphics.rectangle("fill", self.x, self.y, self.w, self.h)

	love.graphics.setColor(jGui.colours.text)
	love.graphics.printf(self.text, self.x, self.y+self.h/2-love.graphics.getFont():getHeight()/2, self.w, "center")
	if self.selected then
		love.graphics.rectangle("fill", 2+self.x+self.w/2+love.graphics.getFont():getWidth(self.text)/2, self.y+self.h/2-love.graphics.getFont():getHeight()/2, 2, love.graphics.getFont():getHeight())
	end
end

function jGui.textbox:setText(text)
	self.text = text
end
function jGui.textbox:getText()
	return self.text
end

function jGui.textbox:mouseReleased(x, y, button)
	if button == "l" and x > self.x and x < self.x+self.w and y > self.y and y < self.y+self.h then
		self.selected = true
		self:onClick()
	else
		self.selected = false
	end
end

function jGui.textbox:onClick()
end

function jGui.textbox:submit()
end

function jGui.textbox:textinput(text)
	if self.selected and love.graphics.getFont():getWidth(self.text) < self.w-40 then
		self.text = self.text..text
	end
end

function jGui.textbox:keyPressed(key, isRepeat)
	local keys = {
		["backspace"] = function()
			self.text = string.sub(self.text, 1, -2)
		end,
		["return"] = function()
			self:submit()
		end
	}
	if keys[key] then
		keys[key]()
	end
end

------SLIDERS------
function jGui.slider:update()
	local x, y = love.mouse.getX(), love.mouse.getY()
	if x > self.x+self.slidePos-5 and x < self.x+self.slidePos+5 and y > self.y and y < self.y+self.h then
		if love.mouse.isDown("l") then
			self.slidePos = x - self.x
		end
	end

	if self.slidePos < 0 then
		self.slidePos = 0
	elseif self.slidePos > self.w then
		self.slidePos = self.w
	end
end

function jGui.slider:draw()
	love.graphics.setColor(jGui.colours.idle)
	love.graphics.rectangle("fill", self.x, self.y+self.h/4, self.w, self.h/1.2)

	love.graphics.setColor(jGui.colours.solid)
	love.graphics.rectangle("fill", self.x+self.slidePos-5, self.y, 10, self.h)
end

function jGui.slider:mouseReleased(x, y, button)
end

function jGui.slider:textinput(text)
end

function jGui.slider:keyPressed(key, isRepeat)
end

------LABELS------
function jGui.label:update()
end

function jGui.label:draw()
	love.graphics.setColor(jGui.colours.text)
	love.graphics.printf(self.text, self.x, self.y+self.h/2-love.graphics.getFont():getHeight()/2, self.w, self.align)
end

function jGui.label:mouseReleased(x, y, button)
end

function jGui.label:textinput(text)
end

function jGui.label:keyPressed(key, isRepeat)
end

function jGui.label:setText(text)
	self.text = text
end

function jGui.label:setAlign(align)
	self.algin = algin
end

return jGui