return {
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",        -- required per docs
    lazy = false,           -- NOT lazy-loadable
    build = ":TSUpdate",    -- keep parsers in sync
  },
}
