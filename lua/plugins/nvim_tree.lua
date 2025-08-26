return {
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    keys = {
      { "<leader>t", "<cmd>NvimTreeToggle<CR>", desc = "Toggle file tree" },
      { "<leader>T", "<cmd>NvimTreeFindFile<CR>", desc = "Reveal current file" },
    },
    config = function()
      require("nvim-tree").setup({
        hijack_netrw = true,
        sync_root_with_cwd = true,
        update_focused_file = { enable = true, update_root = true },
        view = { width = 35, preserve_window_proportions = true },
        tab = { sync = { open = true, close = true, ignore = {} } }, -- keep tree synced across tabs
        renderer = {
          group_empty = true,
          highlight_git = true,
          icons = { show = { file = true, folder = true, git = true, folder_arrow = true } },
        },
        actions = { open_file = { quit_on_open = false } },
      })
    end,
  },
}
