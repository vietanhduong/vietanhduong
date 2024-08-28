local wezterm = require 'wezterm'

local config = wezterm.config_builder()

config.font = wezterm.font 'SF Mono'
config.harfbuzz_features = { 'calt=0' }
config.font_size = 15.0

config.color_scheme = 'Tomorrow Night (Gogh)'

--config.colors = {
--   foreground = "rgb(255,255,255)",
--      background = "rgb(30,30,30)",
--      cursor_bg = "rgb(157,157,157)",
--      cursor_fg = "rgb(157,157,157)",
--      selection_bg = "#424242",
--      selection_fg = "#ffffff",
--
--      ansi = {
--        "rgb(0,0,0)",  -- black
--        "rgb(202,51,36)",  -- red
--        "rgb(58,191,38)",  -- green
--        "rgb(170,171,37)",  -- yellow
--        "rgb(86,31,244)",  -- blue
--        "rgb(219,39,219)",  -- magenta
--        "rgb(55,185,199)",  -- cyan
--        "rgb(199,199,199)",  -- white
--      },
--      brights = {
--        "rgb(125,125,125)",  -- bright black
--        "rgb(252,51,32)",  -- bright red
--        "rgb(55,239,33)",  -- bright green
--        "rgb(235,239,24)",  -- bright yellow
--        "rgb(207,125,255)",  -- bright blue
--        "rgb(251,30,255)",  -- bright magenta
--        "rgb(50,244,241)",  -- bright cyan
--        "rgb(232,232,232)",  -- bright white
--      }
--}

config.bold_brightens_ansi_colors = false

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

-- config.window_background_opacity = 0.95

return config
