local wezterm = require 'wezterm'

local config = wezterm.config_builder()

config.font = wezterm.font 'SF Mono'
config.font_size = 14.0

config.color_scheme = 'Gruvbox Dark (Gogh)'

config.window_padding = {
  left = '1cell',
  right = '1cell',
  top = '0.5cell',
  bottom = '0.5cell',
}

config.use_fancy_tab_bar = false

return config
