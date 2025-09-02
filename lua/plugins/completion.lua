return {
  "hrsh7th/nvim-cmp",
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",

    -- Snippet engine + VSCode loader
    {
      "L3MON4D3/LuaSnip",
      version = "v2.*",
      build = "make install_jsregexp",
      dependencies = { "rafamadriz/friendly-snippets" }, -- ensure on runtimepath
      config = function()
        -- Load VSCode-format snippets (includes friendly-snippets)
        require("luasnip.loaders.from_vscode").lazy_load()
        -- Load your own Lua snippets
        require("luasnip.loaders.from_lua").lazy_load({
          paths = vim.fn.stdpath("config") .. "/LuaSnip/snippets",
        })
        -- Make TS snippets available in TSX too
        require("luasnip").filetype_extend("typescriptreact", { "typescript" })
      end,
    },

    "saadparwaiz1/cmp_luasnip",
  },

  config = function()
    local cmp = require("cmp")
    local luasnip = require("luasnip")

    -- --- FIX: define helper used by <Tab> ---
    local has_words_before = function()
      local line, col = unpack(vim.api.nvim_win_get_cursor(0))
      if col == 0 then return false end
      local text = vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]
      return text:sub(col, col):match("%s") == nil
    end

    -- --- FIX: kill stale snippet state so cmp re-enables reliably ---
    vim.api.nvim_create_autocmd("InsertLeave", {
      callback = function()
        if luasnip and luasnip.session
          and luasnip.session.current_nodes[vim.api.nvim_get_current_buf()] then
          luasnip.unlink_current()
        end
      end,
    })

    cmp.setup({
      -- --- FIX: safer check; don’t rely on raw internal tables ---
      enabled = function()
        local bt = vim.api.nvim_get_option_value("buftype", { buf = 0 })
        if bt == "prompt" then return false end
        if luasnip.in_snippet and luasnip.in_snippet() then
          return false
        end
        return true
      end,

      snippet = { expand = function(args) luasnip.lsp_expand(args.body) end },

      mapping = cmp.mapping.preset.insert({
        ["<CR>"]  = cmp.mapping.confirm({ select = true }),
        -- macOS often eats <C-Space>; use <C-l> as a reliable manual trigger
        ["<C-l>"] = cmp.mapping.complete(),
        ["<C-s>"] = function()
          cmp.complete({ config = { sources = { { name = "luasnip" } } } })
        end,

        ["<Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
          elseif luasnip.expand_or_jumpable() then
            luasnip.expand_or_jump()
          elseif has_words_before() then
            cmp.complete()
          else
            fallback()
          end
        end, { "i", "s" }),

        -- --- FIX: this must live INSIDE `mapping` ---
        ["<S-Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          elseif luasnip.jumpable(-1) then
            luasnip.jump(-1)
          else
            fallback()
          end
        end, { "i", "s" }),
      }),

      sources = {
        { name = "nvim_lsp" },
        { name = "luasnip" },
      },

      -- If you hate accidental <CR> accepts, uncomment:
      -- preselect = cmp.PreselectMode.None,
    })
  end,
}
