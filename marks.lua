-- Copyright (c) 2023 Luka Ivanović
-- This code is licensed under MIT licence (see LICENCE for details)

local mp = require("mp")
local utils = require("mp.utils")

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

mp.add_key_binding("b", "do-mark", function()
	local filename = utils.join_path(utils.getcwd(), mp.get_property_native("filename") .. ".marks")
	local file = assert(io.open(filename, "a"))
	file:write(format_time(mp.get_property_native("time-pos")) .. "\n")
	file:flush()
	file:close()
end, {
	repeatable = true
})

mp.add_key_binding("B", "undo-mark", function()
	local filename = utils.join_path(utils.getcwd(), mp.get_property_native("filename") .. ".marks")
	local file = assert(io.open(filename, "r"))
	local lines = {}
	for line in file:lines() do
		table.insert(lines, line)
	end
	file:close()
	table.remove(lines)
	file = assert(io.open(filename, "w"))
	file:write(table.concat(lines, "\n"))
	file:flush()
	file:close()
end, {
	repeatable = true
})
