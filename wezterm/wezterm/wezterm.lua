-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This table will hold the configuration.
local config = {
}

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
  config = wezterm.config_builder()
end

-- This is where you actually apply your config choices

-- For example, changing the color scheme:
config.color_scheme = 'AdventureTime'
-- config.color_scheme = 'Batman'

config.window_decorations = "RESIZE"
config.enable_tab_bar = false
config.hide_tab_bar_if_only_one_tab = true
config.show_tab_index_in_tab_bar = false
config.tab_bar_at_bottom = fase
config.use_fancy_tab_bar = false
config.window_background_opacity = 0.90
config.text_background_opacity = 0.90
config.adjust_window_size_when_changing_font_size = false

-- Font
-- config.font = wezterm.font_with_fallback { 'JetBrains Mono' }
config.font_size = 14
config.freetype_load_target = "Light" -- Possible alternatives are `HorizontalLcd`, `Light`, `Mono`, `Normal`, `VerticalLcd`.

config.keys = {
	-- 方便tmux 切换window
	{
		key = "1",
		mods = "ALT",
		action = wezterm.action.Multiple ({
			wezterm.action.SendKey({mods = "CTRL", key = "b"}),
			wezterm.action.SendKey({key = "1"}),
		}),
	},
	{
		key = "2",
		mods = "ALT",
		action = wezterm.action.Multiple ({
			wezterm.action.SendKey({mods = "CTRL", key = "b"}),
			wezterm.action.SendKey({key = "2"}),
		}),
	},
	{
		key = "3",
		mods = "ALT",
		action = wezterm.action.Multiple ({
			wezterm.action.SendKey({mods = "CTRL", key = "b"}),
			wezterm.action.SendKey({key = "3"}),
		}),
	},
	{
		key = "4",
		mods = "ALT",
		action = wezterm.action.Multiple ({
			wezterm.action.SendKey({mods = "CTRL", key = "b"}),
			wezterm.action.SendKey({key = "4"}),
		}),
	},
	{
		key = "5",
		mods = "ALT",
		action = wezterm.action.Multiple ({
			wezterm.action.SendKey({mods = "CTRL", key = "b"}),
			wezterm.action.SendKey({key = "5"}),
		}),
	},
	{
		key = "6",
		mods = "ALT",
		action = wezterm.action.Multiple ({
			wezterm.action.SendKey({mods = "CTRL", key = "b"}),
			wezterm.action.SendKey({key = "6"}),
		}),
	},
	{
		key = "7",
		mods = "ALT",
		action = wezterm.action.Multiple ({
			wezterm.action.SendKey({mods = "CTRL", key = "b"}),
			wezterm.action.SendKey({key = "7"}),
		}),
	},
	{
		key = "8",
		mods = "ALT",
		action = wezterm.action.Multiple ({
			wezterm.action.SendKey({mods = "CTRL", key = "b"}),
			wezterm.action.SendKey({key = "8"}),
		}),
	},
	{
		key = "9",
		mods = "ALT",
		action = wezterm.action.Multiple ({
			wezterm.action.SendKey({mods = "CTRL", key = "b"}),
			wezterm.action.SendKey({key = "9"}),
		}),
	}

}

-- and finally, return the configuration to wezterm
return config
