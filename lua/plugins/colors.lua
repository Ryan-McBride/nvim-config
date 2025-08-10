return {
  {
    "Mofiqul/dracula.nvim", -- Dracula theme for Neovim
    lazy = false,           -- load immediately
    priority = 1000,        -- make sure it loads before other plugins
    config = function()
      vim.cmd.colorscheme("dracula")
    end,
  }
}
