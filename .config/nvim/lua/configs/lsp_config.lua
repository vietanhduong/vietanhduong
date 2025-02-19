local lsp = require "configs.lsp.lsp"

lsp.defaults()

local lspconfig = require "lspconfig"

local servers = {
  "clangd",
  "gopls",
  "rust_analyzer",
  "lua_ls",
  "bashls",
}

-- lsps with default config
for _, e in ipairs(servers) do
  lspconfig[e].setup {
    on_attach = lsp.on_attach,
    on_init = lsp.on_init,
    capabilities = lsp.capabilities,
  }
end

-- Rust
lspconfig.rust_analyzer.setup {
  cargo = {
    allFeatures = true,
  },
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
