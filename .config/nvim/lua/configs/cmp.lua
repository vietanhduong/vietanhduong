local cmp = require "cmp"
local luasnip = require "luasnip"
luasnip.config.setup {}

local lspkind = require "lspkind"

cmp.setup {
  formatting = {
    format = lspkind.cmp_format {
      mode = "symbol",
      symbol_map = { Copilot = "" },
      maxwidth = {
        menu = 50,
        abbr = 50,
      },
      ellipsis_char = "...",
      show_labelDetails = true,
      before = function(entry, vim_item)
        return vim_item
      end,
    },
  },
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  completion = { completeopt = "menu,menuone,noinsert" },

  mapping = cmp.mapping.preset.insert {
    ["<C-n>"] = cmp.mapping.scroll_docs(-4),
    ["<C-p>"] = cmp.mapping.scroll_docs(4),

    ["<CR>"] = cmp.mapping.confirm { select = true },
    ["<Tab>"] = cmp.mapping.select_next_item(),
    ["<S-Tab>"] = cmp.mapping.select_prev_item(),

    ["<C-Space>"] = cmp.mapping.complete {},
    ["<C-l>"] = cmp.mapping(function()
      if luasnip.expand_or_locally_jumpable() then
        luasnip.expand_or_jump()
      end
    end, { "i", "s" }),
    ["<C-h>"] = cmp.mapping(function()
      if luasnip.locally_jumpable(-1) then
        luasnip.jump(-1)
      end
    end, { "i", "s" }),
  },
  sources = {
    {
      name = "lazydev",
      group_index = 0,
    },
    { name = "copilot" },
    { name = "nvim_lsp" },
    { name = "luasnip" },
    { name = "path" },
    { name = "nvim_lsp_signature_help" },
  },
}
