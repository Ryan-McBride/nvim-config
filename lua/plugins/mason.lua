return {
  { "mason-org/mason.nvim", opts = {} },
  {
    "mason-org/mason-lspconfig.nvim",
    dependencies = { "neovim/nvim-lspconfig" },
    opts = {
      ensure_installed = { "ts_ls", "lua_ls", "jsonls", "bashls" },
      automatic_enable = true,
    },
    config = function(_, opts)
      require("mason-lspconfig").setup(opts)

      local caps = require("cmp_nvim_lsp").default_capabilities()

      vim.lsp.config("ts_ls", { capabilities = caps })
      vim.lsp.config("lua_ls", {
        capabilities = caps,
        settings = {
          Lua = {
            runtime = { version = "LuaJIT" },
            diagnostics = { globals = { "vim" } },
            workspace = {
              library = vim.api.nvim_get_runtime_file("", true),
              checkThirdParty = false,
            },
            telemetry = { enable = false },
          },
        },
      })
      vim.lsp.config("jsonls", { capabilities = caps })
      vim.lsp.config("bashls", { capabilities = caps })

      vim.lsp.config("tsserver", { capabilities = caps })
    end,
  },
}
