local function on_attach(bufnr)
  local api = require "nvim-tree.api"

  api.events.subscribe("TreeOpen", function()
    vim.wo.statusline = " "
  end)

  api.config.mappings.default_on_attach(bufnr)

  -- Map Ctrl + \ to toggle open file tree
  vim.keymap.set("n", "<C-\\>", ":NvimTreeToggle<CR>", { desc = "nvim tree: toggle tree" })
  vim.keymap.set("n", "<leader>v", api.node.open.vertical, { desc = "nvim tree: open [v]ertical" })
  vim.keymap.set("n", "<leader>h", api.node.open.horizontal, { desc = "nvim tree: open [h]orizontal" })
end

require("nvim-tree").setup {
  filters = { dotfiles = false },
  disable_netrw = true,
  hijack_cursor = true,
  sync_root_with_cwd = true,
  on_attach = on_attach,
  update_focused_file = {
    enable = true,
    update_root = false,
  },
  view = {
    width = 30,
    preserve_window_proportions = true,
  },
  actions = {
    change_dir = { enable = false },
  },
  renderer = {
    root_folder_label = false,
    highlight_git = true,
    indent_markers = { enable = true },
    icons = {
      glyphs = {
        default = "󰈚",
        folder = {
          default = "",
          empty = "",
          empty_open = "",
          open = "",
          symlink = "",
        },
        git = { unmerged = "" },
      },
    },
  },
}

local function open_nvim_tree(data)
  local real_file = vim.fn.filereadable(data.file) == 1
  local no_name = data.file == "" and vim.bo[data.buf].buftype == ""

  if not real_file and not no_name then
    return
  end

  require("nvim-tree.api").tree.toggle { focus = false, find_file = true }
end

vim.api.nvim_create_autocmd({ "VimEnter" }, { callback = open_nvim_tree })
vim.api.nvim_create_autocmd("BufEnter", {
  group = vim.api.nvim_create_augroup("NvimTreeClose", { clear = true }),
  callback = function(data)
    -- If the data.path is a directory, we will open
    -- a buffer by toggle the tree and open the tree one again.
    -- This will prevent closing window when no buffer found
    if vim.fn.isdirectory(data.file) == 1 then
      vim.cmd.cd(data.file)
      require("nvim-tree.api").tree.toggle { focus = false, find_file = true }
      require("nvim-tree.api").tree.open { find_file = true }
      return
    end

    local layout = vim.api.nvim_call_function("winlayout", {})
    if
      layout[1] == "leaf"
      and vim.api.nvim_buf_get_option(vim.api.nvim_win_get_buf(layout[2]), "filetype") == "NvimTree"
      and layout[3] == nil
    then
      vim.cmd "quit"
    end
  end,
})
