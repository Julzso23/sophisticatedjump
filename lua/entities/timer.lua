timer = {}
timer.__index = timer

timer.timers = {}

function timer.temp ( delay, rep, func, ... )
	local t = {}

	t.time = 0
	t.delay = delay
	t.rep = rep
	t.active = true
	t.func = func
	t.params = ...

	setmetatable( t, timer )

	table.insert( timer.timers, t )
end

hook.add( "update", "tempTimers", function ( dt )
	for k, v in pairs( timer.timers ) do
		if v:update( dt, v.params ) then
			if v.rep > 0 then
				v.rep = v.rep - 1
			else
				table.remove( timer.timers, k )
			end
		end
	end
end )

function timer.create( delay, active, func )
	local t = {}

	t.time = 0
	t.delay = delay
	t.active = active
	t.func = func

	setmetatable( t, timer )

	return t
end

function timer:start ()
	self.active = true
end
function timer:stop ()
	self.active = false
	self.time = 0
end

function timer:update ( dt, ... )
	if self.active then
		if self.time < self.delay then
			self.time = self.time + dt
		else
			self.time = 0
			self.func( ... )

			return true
		end
	end
end

function timer:setDelay ( delay )
	self.delay = delay
end