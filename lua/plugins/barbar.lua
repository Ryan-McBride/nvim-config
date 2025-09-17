return {
  'romgrk/barbar.nvim',
  dependencies = {
    'lewis6991/gitsigns.nvim', -- OPTIONAL: for git status
    'nvim-tree/nvim-web-devicons', -- OPTIONAL: for file icons
  },
  event = "VimEnter", -- Load barbar immediately on startup
  init = function() vim.g.barbar_auto_setup = false end,
  opts = {
    auto_hide = false,
    animation = true,
  },
  keys = {
    -- Restore original gt/gT behavior for visual tab order navigation
    { 'gt', '<Cmd>BufferNext<CR>', desc = 'Next tab' },
    { 'gT', '<Cmd>BufferPrevious<CR>', desc = 'Previous tab' },
  },
  version = '^1.0.0', -- optional: only update when a new 1.x version is released
}
