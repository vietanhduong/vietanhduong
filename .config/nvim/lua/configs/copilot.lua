require("copilot").setup {
  panel = { enabled = false },
  suggestion = { enabled = false },
  on_status_update = require("lualine").refresh,
}

require("copilot_cmp").setup()
