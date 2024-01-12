-- this file stores old/unused functions that were once used in 'rc.lua'
-- these are no longer used because they were replaced with other functions that look/perform better


--[[
function get_battery_percentage()
	local handle = io.popen("sysctl hw.acpi.battery.life")
	local text = handle:read("*a")
	-- from the beginning of the line, replace one or more occurrences of whitespaces with nothing
	text = string.gsub(text, '^%s+', '')
	-- from the end of the line, replace one or more occurrences of whitespaces with nothing
	text = string.gsub(text, '%s+$', '')
	-- replace one or more occurrences of line feed and carriage return with nothing
	text = string.gsub(text, '[\n\r]+', ' ')
	-- obtain only the number found within the text
	text = string.gsub(text, 'hw.acpi.battery.life: ', '')
	handle:close()
	return tonumber(text)/100
end
--]]


--[[
myprogressbar_watch = wibox.widget {
    awful.widget.watch("sysctl hw.acpi.battery.life",
						60,
						function(widget, text)
							text = string.gsub(text, '^%s+', '')
							text = string.gsub(text, '%s+$', '')
							text = string.gsub(text, '[\n\r]+', ' ')
							text = string.gsub(text, 'hw.acpi.battery.life: ', '')

							value = tonumber(text)
							percent = value/100
							gradient_color_value = map_int_colorcode(value)

							widget:set_max_value(1)
							widget:set_value(percent)
							widget:set_forced_height(20)
							widget:set_forced_width(100)
							widget:set_shape(gears.shape.rounded_bar)
							widget:set_bar_shape(gears.shape.rounded_bar)
							widget:set_paddings(1)
							widget:set_border_width(2)

							widget:set_border_color("#444444")
							widget:set_color(gradient_color_value)
							widget:set_background_color("#111111")
							-- widget:set_bar_border_color("#777777")
						end,
						wibox.widget.progressbar()
    ),
    awful.widget.watch("sysctl hw.acpi.battery.life",
						60,
						function(widget, text)
							text = string.gsub(text, '^%s+', '')
							text = string.gsub(text, '%s+$', '')
							text = string.gsub(text, '[\n\r]+', ' ')
							text = string.gsub(text, 'hw.acpi.battery.life: ', '')
							pango_markup = '<span color="#FFF"> '..text..' </span>'
							widget:set_markup(pango_markup)
							-- widget:set_text(text)
							widget:set_align("right")
						end
    ),
    layout = wibox.layout.stack
}
]]

