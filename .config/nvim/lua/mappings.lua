require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

map("n", "<C-\\>", ":NvimTreeToggle<CR>", { desc = "Toggle Nvim Tree Window" })
map("n", "<leader>e", function()
  vim.diagnostic.open_float(0, { scope = "line" })
end, { desc = "Show full diagnostic" })

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <:cr>")
