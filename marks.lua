-- Copyright © 2023 Luka Ivanović
-- This code is licensed under the terms of the MIT licence (see LICENCE for details)

local mp = require("mp")

local floor = math.floor

local format_time = function(time)
	local remaining = floor(time)
	local hours = floor(remaining / 3600)
	remaining = remaining % 3600
	local minutes = floor(remaining / 60)
	remaining = remaining % 60
	local seconds = remaining
	local hours_s = tostring(hours)
	local minutes_s = tostring(minutes)
	local seconds_s = tostring(seconds)
	if (hours < 10) then
		hours_s = "0" .. hours_s
	end
	if (minutes < 10) then
		minutes_s = "0" .. minutes_s
	end
	if (seconds < 10) then
		seconds_s = "0" .. seconds_s
	end
	return hours_s .. ":" .. minutes_s .. ":" .. seconds_s
end

local format_time_precise = function(time)
	local hours = floor(time / 3600)
	time = time - (hours * 3600)
	local minutes = floor(time / 60)
	time = time - (minutes * 60)
	local seconds = floor(time / 1)
	time = time - seconds
	local milliseconds = floor(time * 1000)
	return (string.format("%02d", hours) .. ":" .. string.format("%02d", minutes) .. ":" .. string.format("%02d", seconds) .. "." .. string.format("%03d", milliseconds))
end

mp.add_key_binding("b", "do-mark", function()
	local filename = mp.get_property_native("path") .. ".marks"
	local file = assert(io.open(filename, "a"))
	local time = format_time_precise(mp.get_property_native("time-pos"))
	file:write(time .. "\n")
	file:flush()
	file:close()
	-- os.execute(string.format("notify-send 'do-mark: %s' '%s'", time, filename))
	mp.osd_message(string.format("marked at %s", time))
end, {
	repeatable = true
})

mp.add_key_binding("B", "undo-mark", function()
	local filename = mp.get_property_native("path") .. ".marks"
	local file = assert(io.open(filename, "r"))
	local lines = {}
	for line in file:lines() do
		table.insert(lines, line)
	end
	file:close()
	table.remove(lines) -- pop .....
	file = assert(io.open(filename, "w"))
	file:write(table.concat(lines, "\n"))
	file:flush()
	file:close()
	-- os.execute(string.format("notify-send 'undo-mark one line' %s", filename))
	mp.osd_message("unmarked")
end, {
	repeatable = true
})

mp.add_key_binding("c", "cut", function()
	local filename = mp.get_property_native("path") .. ".marks"
	local file = assert(io.open(filename, "a"))
	file:write("cut\n")
	file:flush()
	file:close()
	mp.osd_message("cut.")
end, {
	repeatable = true
})
