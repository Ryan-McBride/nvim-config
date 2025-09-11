return {
  {
    'neovim/nvim-lspconfig',
  },
  {
    'numToStr/Comment.nvim',
    opts = {
      toggler = {
        block = gbc
      }
    }
  },
  {
    'windwp/nvim-autopairs',
    event = "InsertEnter",
    config = true
  },
  {
    'norcalli/nvim-colorizer.lua',
    opts = {
      DEFAULT_OPTIONS = {
        names = false,
      }
    }
  },
  {
    'goolord/alpha-nvim',
    config = function ()
      require'alpha'.setup(require'alpha.themes.dashboard'.config)
    end
  },
  {
    'lewis6991/gitsigns.nvim',
  },
}
