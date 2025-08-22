-- core vim settings
vim.g.loaded_netrw = 1 -- disables file explorer
vim.g.loaded_netrwPlugin = 1 -- disables netrw plugin
vim.opt.number = true -- line numbers
vim.opt.ignorecase = true -- case insensitive search
vim.opt.hlsearch = true -- persist search highlight
vim.opt.wrap = true -- enable line wrapping
vim.opt.linebreak = true -- wrap only at word boundaries
vim.opt.breakindent = true -- maintain linebreak indentations
vim.opt.smartindent = true -- contextual indentation
vim.opt.tabstop = 2 -- set tab to 2 spaces
vim.opt.shiftwidth = 2 -- audoindent tabstop
vim.opt.expandtab = true -- tabs are spaces
vim.opt.ttimeout = true -- enables key code timeout
vim.opt.ttimeoutlen = 100 -- length of key code timeout
vim.g.noswapfile = true -- disables swap files
vim.g.nobakcup = true -- disables backup files
vim.g.mapleader = ' ' -- sets leader to space
vim.opt.termguicolors = true

--remaps
local map = require('utils').map

-- lazy package manager
require("config.lazy")

-- lsp config
pcall(require, "config.lsp")

-- always show the tabline
vim.o.showtabline = 2
vim.o.tabline = "%!v:lua._my_tabline()"

-- remember the last non-NvimTree window per tab
vim.api.nvim_create_autocmd("WinEnter", {
  callback = function()
    local ft = vim.bo.filetype
    if ft ~= "NvimTree" then
      vim.t.last_real_buf = vim.api.nvim_get_current_buf()
    end
  end,
})

-- render function for the tabline
function _G._my_tabline()
  local tabs = vim.api.nvim_list_tabpages()
  local cur  = vim.api.nvim_get_current_tabpage()
  local dev = package.loaded["nvim-web-devicons"] and require("nvim-web-devicons") or nil

  local out = {}
  for i, tab in ipairs(tabs) do
    local hl = (tab == cur) and "%#TabLineSel#" or "%#TabLine#"
    table.insert(out, hl .. "%" .. i .. "T ") -- make the area clickable

    -- choose title buffer
    local title_buf
    do
      local ok, remembered = pcall(vim.api.nvim_tabpage_get_var, tab, "last_real_buf")
      if ok and vim.api.nvim_buf_is_valid(remembered) then
        title_buf = remembered
      else
        for _, win in ipairs(vim.api.nvim_tabpage_list_wins(tab)) do
          local b = vim.api.nvim_win_get_buf(win)
          if vim.bo[b].filetype ~= "NvimTree" then title_buf = b; break end
        end
      end
      if not title_buf then
        -- fallback: current window's buffer in that tab
        local wins = vim.api.nvim_tabpage_list_wins(tab)
        title_buf = vim.api.nvim_win_get_buf(wins[1])
      end
    end

    local name = vim.api.nvim_buf_get_name(title_buf)
    local fname = (name == "" and "[No Name]") or vim.fn.fnamemodify(name, ":t")

    -- icon
    local icon = ""
    if dev then
      local ext = fname:match("%.([^.]+)$")
      icon = (dev.get_icon(fname, ext, { default = true }) or "") .. (icon ~= "" and " " or " ")
    end

    -- modified marker if any buffer in the tab is modified
    local modified = ""
    for _, win in ipairs(vim.api.nvim_tabpage_list_wins(tab)) do
      local b = vim.api.nvim_win_get_buf(win)
      if vim.bo[b].modifiable and vim.bo[b].modified then modified = " [+]"; break end
    end

    table.insert(out, string.format("%d: %s%s%s ", i, icon, fname, modified))
  end

  table.insert(out, "%#TabLineFill#%T")
  return table.concat(out)
end
