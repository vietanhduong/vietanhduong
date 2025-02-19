local char = "▎ "

require("ibl").setup {
  whitespace = {
    remove_blankline_trail = false,
  },
  indent = { char = string.gsub(char, "%s+", "") },
}
--
-- Sets how neovim will display certain whitespace characters in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
vim.opt.list = true
vim.opt.listchars = { tab = char, trail = "·", nbsp = "␣" }
