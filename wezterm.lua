local wezterm = require 'wezterm'

local config = wezterm.config_builder()

config.font = wezterm.font 'Fira Code'
config.harfbuzz_features = { 'calt=0' }
config.font_size = 14.0

config.color_scheme = 'Tomorrow Night (Gogh)'

config.window_padding = {
  left = "0.5cell",
  right = "0.5cell",
  top = "0.5cell",
  bottom = "0.5cell",
}

config.use_fancy_tab_bar = false
config.show_new_tab_button_in_tab_bar = false

config.tab_max_width = 32

local function tab_title(tab_info)
  local title = tab_info.tab_title
  if title and #title > 0 then
    return title
  end
  return tab_info.active_pane.title
end



wezterm.on("format-tab-title", function(tab, tabs, panes, conf, hover, max_width)
  local background = "#65737E"
  local foreground = "#F0F2F5"
  local edge_background = "#FAFAF9"

  if tab.is_active or hover then
    background = "#E5C07B"
    foreground = "#282C34"
  end
  local edge_foreground = background

  local title = tab_title(tab)

  local max = config.tab_max_width - 9
  if #title > max then
    title = wezterm.truncate_right(title, max) .. "…"
  end

  return {
    { Background = { Color = edge_background } },
    { Foreground = { Color = edge_foreground } },
    { Background = { Color = background } },
    { Foreground = { Color = foreground } },
    { Attribute = { Intensity = tab.is_active and "Bold" or "Normal" } },
    { Text = " " .. (tab.tab_index + 1) .. ": " .. title .. " " },
    { Background = { Color = edge_background } },
    { Foreground = { Color = edge_foreground } },
  }
end)


config.keys = {
  {key="LeftArrow", mods="OPT", action=wezterm.action{SendString="\x1bb"}},
  {key="RightArrow", mods="OPT", action=wezterm.action{SendString="\x1bf"}},
}

config.window_padding = {
  left = 0,
  right = 0,
  top = 0,
  bottom = 0,
}

config.window_background_opacity = 0.95

return config
