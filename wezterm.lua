local wezterm = require 'wezterm'

local config = wezterm.config_builder()

config.font = wezterm.font 'SF Mono'
config.font_size = 14.0

return config
