local lsp = require "configs.lsp.lsp"

lsp.defaults()

local lspconfig = require "lspconfig"

local servers = {
  "clangd",
  "gopls",
  "rust_analyzer",
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
