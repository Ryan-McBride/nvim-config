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
