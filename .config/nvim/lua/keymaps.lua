-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- Diagnostic keymaps
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })
vim.keymap.set("n", "<leader>e", function()
  vim.diagnostic.open_float(0, { scope = "line" })
end, { desc = "Show inline diagnostic" })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

vim.keymap.set("n", "<left>", '<cmd>echo "Use h to move!!"<CR>')
vim.keymap.set("n", "<right>", '<cmd>echo "Use l to move!!"<CR>')
vim.keymap.set("n", "<up>", '<cmd>echo "Use k to move!!"<CR>')
vim.keymap.set("n", "<down>", '<cmd>echo "Use j to move!!"<CR>')

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

-- Tab movements
vim.keymap.set("n", "<leader>1", "1gt", { desc = "Switch to tab 1" })
vim.keymap.set("n", "<leader>2", "2gt", { desc = "Switch to tab 2" })
vim.keymap.set("n", "<leader>3", "3gt", { desc = "Switch to tab 3" })
vim.keymap.set("n", "<leader>4", "4gt", { desc = "Switch to tab 4" })
vim.keymap.set("n", "<leader>5", "5gt", { desc = "Switch to tab 5" })
vim.keymap.set("n", "<leader>6", "6gt", { desc = "Switch to tab 6" })
vim.keymap.set("n", "<leader>7", "7gt", { desc = "Switch to tab 7" })
vim.keymap.set("n", "<leader>8", "8gt", { desc = "Switch to tab 8" })
vim.keymap.set("n", "<leader>9", "9gt", { desc = "Switch to tab 9" })
vim.keymap.set("n", "<leader>n", "gt", { desc = "Switch to the [N]ext tab" })
vim.keymap.set("n", "<leader>N", "gT", { desc = "Switch to the previous tab" })

-- Map Ctrl + t to open file in a new tab
vim.keymap.set("n", "<C-t>", function()
  vim.api.node.open.tab()
  vim.cmd "-tabnext"
  vim.api.tree.toggle()
  vim.cmd "tabnext"
end, { desc = "Open new tab" })

-- Shift left/right selected lines
vim.keymap.set("v", "<Tab>", ">gv", { desc = "Shift selected line(s) to the right" })
vim.keymap.set("v", "<S-Tab>", "<gv", { desc = "Shift selected line(s) to the left" })

-- Move lines up/down
vim.keymap.set("v", "<S-j>", ":m '>+1<CR>gv=gv", { desc = "Move line up" })
vim.keymap.set("v", "<S-k>", ":m '<-2<CR>gv=gv", { desc = "Move line down" })
