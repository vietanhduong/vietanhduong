local wezterm = require 'wezterm'

local config = wezterm.config_builder()

config.font = wezterm.font 'SF Mono'
config.font_size = 14.0

-- config.color_scheme = 'Gruvbox Dark (Gogh)'
config.color_scheme = 'Wombat'

config.window_padding = {
  left = '1cell',
  right = '1cell',
  top = '0.5cell',
  bottom = '0.5cell',
}

config.use_fancy_tab_bar = false
config.keys = {
  -- Make Option-Left equivalent to Alt-b which many line editors interpret as backward-word
  {key="LeftArrow", mods="OPT", action=wezterm.action{SendString="\x1bb"}},
  -- Make Option-Right equivalent to Alt-f; forward-word
  {key="RightArrow", mods="OPT", action=wezterm.action{SendString="\x1bf"}},
}

-- config.window_background_opacity = 0.95
return config
