local wezterm = require 'wezterm'

local config = wezterm.config_builder()

config.font = wezterm.font 'Menlo'
config.font_size = 14.0

config.color_scheme = 'Wombat'
config.use_fancy_tab_bar = false
config.keys = {
  {key="LeftArrow", mods="OPT", action=wezterm.action{SendString="\x1bb"}},
  {key="RightArrow", mods="OPT", action=wezterm.action{SendString="\x1bf"}},
}
return config
