local lsp = require "configs.lsp"

local autocmd = vim.api.nvim_create_autocmd

lsp.defaults()

local lspconfig = require "lspconfig"

-- LSP with default setup, otherwise have to define setup for each server
local servers = {
  "clangd",
  "gopls",
  "lua_ls",
}

-- lsps with default config
for _, e in ipairs(servers) do
  lspconfig[e].setup {
    on_attach = lsp.on_attach,
    on_init = lsp.on_init,
    capabilities = lsp.capabilities,
  }
end

-- Rust LSP
lspconfig.rust_analyzer.setup {
  cargo = {
    allFeatures = true,
  },
  on_attach = lsp.on_attach,
  on_init = lsp.on_init,
  capabilities = lsp.capabilities,
}

-- Bash LSP
local configs = require "lspconfig.configs"
if not configs.bash_lsp and vim.fn.executable "bash-language-server" == 1 then
  configs.bash_lsp = {
    default_config = {
      cmd = { "bash-language-server", "start" },
      filetypes = { "sh" },
      root_dir = lspconfig.util.find_git_ancestor,
      init_options = {
        settings = {
          args = {},
        },
      },
    },
  }
end
