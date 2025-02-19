local M = {}

local function renamer()
  local api = vim.api
  local var = vim.fn.expand "<cword>"
  local buf = api.nvim_create_buf(false, true)
  local opts = { height = 1, style = "minimal", border = "single", row = 1, col = 1 }

  opts.relative, opts.width = "cursor", #var + 15
  opts.title, opts.title_pos = { { " Renamer ", "@comment.danger" } }, "center"

  local win = api.nvim_open_win(buf, true, opts)
  vim.wo[win].winhl = "Normal:Normal,FloatBorder:Removed"
  api.nvim_set_current_win(win)

  api.nvim_buf_set_lines(buf, 0, -1, true, { " " .. var })

  vim.bo[buf].buftype = "prompt"
  vim.fn.prompt_setprompt(buf, "")
  vim.api.nvim_input "A"

  vim.keymap.set({ "i", "n" }, "<Esc>", "<cmd>q!<CR>", { buffer = buf })

  vim.fn.prompt_setcallback(buf, function(text)
    local newName = vim.trim(text)
    api.nvim_buf_delete(buf, { force = true })

    if #newName > 0 and newName ~= var then
      local params = vim.lsp.util.make_position_params()
      params.newName = newName
      vim.lsp.buf_request(0, "textDocument/rename", params)
    end
  end)
end

local function lsp_keymaps(bufnr)
  local map = function(keys, func, desc, mode)
    mode = mode or "n"
    vim.keymap.set(mode, keys, func, { buffer = bufnr, desc = "LSP: " .. desc })
  end

  -- Jump to the definition of the word under your cursor.
  --  This is where a variable was first declared, or where a function is defined, etc.
  --  To jump back, press <C-t>.
  map("gd", require("telescope.builtin").lsp_definitions, "[G]oto [D]efinition")

  -- Find references for the word under your cursor.
  map("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")

  -- Jump to the implementation of the word under your cursor.
  --  Useful when your language has ways of declaring types without an actual implementation.
  map("gI", require("telescope.builtin").lsp_implementations, "[G]oto [I]mplementation")

  -- Jump to the type of the word under your cursor.
  --  Useful when you're not sure what type a variable is and you want to see
  --  the definition of its *type*, not where it was *defined*.
  map("<leader>D", require("telescope.builtin").lsp_type_definitions, "Type [D]efinition")

  -- Fuzzy find all the symbols in your current document.
  --  Symbols are things like variables, functions, types, etc.
  map("<leader>ds", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")

  -- Fuzzy find all the symbols in your current workspace.
  --  Similar to document symbols, except searches over your entire project.
  map("<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")

  -- Rename the variable under your cursor.
  --  Most Language Servers support renaming across files, etc.
  -- map("<F2>", vim.lsp.buf.rename, "[R]e[n]ame")
  map("<leader>rn", renamer, "[R]e[n]ame")

  -- Execute a code action, usually your cursor needs to be on top of an error
  -- or a suggestion from your LSP for this to activate.
  map("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction", { "n", "x" })

  -- WARN: This is not Goto Definition, this is Goto Declaration.
  --  For example, in C this would take you to the header.
  map("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
end

-- export on_attach & capabilities
M.on_attach = function(client, bufnr)
  lsp_keymaps(bufnr)
end

-- disable semanticTokens
M.on_init = function(client, _)
  if client.supports_method "textDocument/semanticTokens" then
    client.server_capabilities.semanticTokensProvider = nil
  end
end

M.capabilities = vim.lsp.protocol.make_client_capabilities()

M.capabilities.textDocument.completion.completionItem = {
  documentationFormat = { "markdown", "plaintext" },
  snippetSupport = true,
  preselectSupport = true,
  insertReplaceSupport = true,
  labelDetailsSupport = true,
  deprecatedSupport = true,
  commitCharactersSupport = true,
  tagSupport = { valueSet = { 1 } },
  resolveSupport = {
    properties = {
      "documentation",
      "detail",
      "additionalTextEdits",
    },
  },
}

M.diagnostic_config = function()
  local x = vim.diagnostic.severity

  vim.diagnostic.config {
    virtual_text = {
      prefix = function(diag)
        local tbl = { [x.ERROR] = "E:", [x.WARN] = "W:", [x.INFO] = "I:", [x.HINT] = "H:" }
        return tbl[diag.severity]
      end,
    },
    signs = {
      text = { [x.ERROR] = "󰅙", [x.WARN] = "", [x.INFO] = "󰋼", [x.HINT] = "󰌵" },
      --  linehl = {
      --    [x.ERROR] = "DiagnosticVirtualTextError",
      --    [x.WARN] = "DiagnosticVirtualTextWarn",
      --    [x.INFO] = "DiagnosticVirtualTextInfo",
      --    [x.HINT] = "DiagnosticVirtualTextHint",
      --  },
    },
    underline = true,
    float = { border = "single" },
  }

  -- Default border style
  local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
  function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
    opts = opts or {}
    opts.border = "rounded"
    return orig_util_open_floating_preview(contents, syntax, opts, ...)
  end
end

M.defaults = function()
  M.diagnostic_config()

  require("lspconfig").lua_ls.setup {
    on_attach = M.on_attach,
    capabilities = M.capabilities,
    on_init = M.on_init,

    settings = {
      Lua = {
        diagnostics = {
          globals = { "vim" },
        },
        workspace = {
          library = {
            vim.fn.expand "$VIMRUNTIME/lua",
            vim.fn.expand "$VIMRUNTIME/lua/vim/lsp",
            vim.fn.stdpath "data" .. "/lazy/ui/nvchad_types",
            vim.fn.stdpath "data" .. "/lazy/lazy.nvim/lua/lazy",
            "${3rd}/luv/library",
          },
          maxPreload = 100000,
          preloadFileSize = 10000,
        },
      },
    },
  }
end

return M
