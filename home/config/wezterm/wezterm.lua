
local wezterm = require('wezterm')
local action = wezterm.action

local mykeys = {}

for i = 1, 8 do
	table.insert(mykeys, {
		key = tostring(i),
		mods = 'ALT',
		action = action.ActivateTab(i - 1),
	})
end

local config = {}

if wezterm.config_builder then
	config = wezterm.config_builder()
end

config.color_scheme = 'Darcula (base16)'
config.leader = { key = ' ', mods = 'CTRL', timeout_milliseconds = 1000}
config.keys = mykeys
config.window_padding = {
	left = 2,
	right = 2,
	top = 1,
	bottom = 1
}
config.use_fancy_tab_bar = false
config.check_for_updates = false
config.enable_wayland = true

return config

-- return {
-- 	-- color_scheme = 'Catppuccin Macchiato',
-- 	color_scheme = 'Darcula (base16)',
--
-- 	leader = { key = ' ', mods = 'CTRL', timeout_milliseconds = 1000},
-- 	keys = mykeys,
--
-- 	window_padding = {
-- 		left = 2,
-- 		right = 2,
-- 		top = 1,
-- 		bottom = 1,
-- 	},
--
-- 	use_fancy_tab_bar = false,
--
-- 	check_for_updates = false,
-- }
