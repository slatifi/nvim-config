-- Leader key
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Sync OS & Vim clipboard
vim.opt.clipboard = 'unnamedplus'

-- Line Numbers
vim.opt.number = true
vim.opt.relativenumber = true

-- Line signs
vim.opt.signcolumn = 'yes'

-- Indentation
vim.opt.expandtab = true
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.softtabstop = 4

-- Word Wrap
vim.opt.wrap = false

-- Character column marker
vim.opt.colorcolumn = '120'

vim.opt.virtualedit = 'block'

vim.opt.splitbelow = true
vim.opt.splitright = true

vim.opt.termguicolors = true

-- Completion height
vim.opt.pumheight = 10

-- Highlight cursor line
vim.opt.cursorline = true
