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
    -- Navigation
    { 'gt', '<Cmd>BufferNext<CR>', desc = 'Next tab' },
    { 'gT', '<Cmd>BufferPrevious<CR>', desc = 'Previous tab' },
    -- Close current buffer
    { '<leader>x', '<Cmd>BufferClose<CR>', desc = 'Close buffer' },
    { '<leader>X', '<Cmd>BufferCloseAllButCurrent<CR>', desc = 'Close all but current' },
  },
  version = '^1.0.0', -- optional: only update when a new 1.x version is released
}
