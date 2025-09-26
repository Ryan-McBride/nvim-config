local lsp = vim.lsp.config("lspconfig")

local capabilities = vim.lsp.protocol.make_client_capabilities()
local ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if ok then capabilities = cmp_nvim_lsp.default_capabilities(capabilities) end

-- TypeScript/JS language server (tsserver successor in lspconfig is ts_ls)
lsp.ts_ls.setup({
  capabilities = capabilities,
  handlers = {
    ["textDocument/publishDiagnostics"] = function(err, result, ctx, config)
      if result and result.diagnostics then
        local filtered = {}
        local ignore = {
          [6133] = true,
          [6196] = true,
          [7027] = true,
          [80001] = true,
        }
        for _, d in ipairs(result.diagnostics) do
          if not (d.code and ignore[tonumber(d.code)]) then
            table.insert(filtered, d)
          end
        end
        result.diagnostics = filtered
      end
      return vim.lsp.handlers["textDocument/publishDiagnostics"](err, result, ctx, config)
    end,
  },
  settings = {
    typescript = {
      preferences = {
        includeCompletionsForModuleExports = true,
        includeAutomaticOptionalChainCompletions = true,
      },
    },
    javascript = {
      preferences = {
        includeCompletionsForModuleExports = true,
        includeAutomaticOptionalChainCompletions = true,
      },
    },
  },
})

-- ESLint using eslint_d
lsp.eslint.setup({
  capabilities = capabilities,
  settings = {
    workingDirectory = { mode = "auto" },
    codeAction = {
      disableRuleComment = { enable = true },
      showDocumentation = { enable = true },
    },
    experimental = { useFlatConfig = true },
    format = true,
    nodePath = nil,
    run = "onType",
    useESLintClass = false,
    -- prefer eslint_d if available
    validate = "on",
  },
})

vim.diagnostic.config({
  virtual_text = true,
  signs = true,
  underline = true,
  float = { border = "rounded", source = "always" },
})

vim.keymap.set("n","<leader>e", function()
  vim.diagnostic.open_float(nil, { focus = false, border = "rounded", source = "always" })
end, { desc = "Line diagnostics" })
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Next diagnostic" })
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Prev diagnostic" })

-- Fix all via ESLint on save for JS/TS including React
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = { "*.js","*.jsx","*.ts","*.tsx" },
  callback = function()
    local clients = vim.lsp.get_active_clients({ bufnr = vim.api.nvim_get_current_buf() })
    local has_eslint = false
    for _, c in ipairs(clients) do
      if c.name == "eslint" then has_eslint = true break end
    end
    if has_eslint then
      vim.lsp.buf.code_action({
        context = { only = { "source.fixAll.eslint" } },
        apply = true,
      })
    end
  end,
})

vim.keymap.set("n", "<leader>af", function()
  vim.lsp.buf.code_action({ context = { only = { "source.fixAll.eslint" } }, apply = true })
end, { desc = "ESLint: Fix all" })

-- Show only one virtual_text per line
local orig_handler = vim.diagnostic.handlers.virtual_text
vim.diagnostic.handlers.virtual_text = {
  show = function(namespace, bufnr, diagnostics, opts)
    local filtered, seen_lines = {}, {}
    for _, d in ipairs(diagnostics) do
      if not seen_lines[d.lnum] then
        table.insert(filtered, d)
        seen_lines[d.lnum] = true
      end
    end
    orig_handler.show(namespace, bufnr, filtered, opts)
  end,
  hide = orig_handler.hide,
}
