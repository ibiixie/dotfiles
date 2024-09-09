vim.opt.nu = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.smartindent = true

vim.opt.wrap = false

-- Todo: Automatically create backupdir and undodir if they don't exist

vim.opt.swapfile = true
vim.opt.backupdir = vim.fn.expand('$HOME/.nvim/backupdir/')
vim.opt.backup = true
vim.opt.undodir = vim.fn.expand('$HOME/.nvim/undodir/')
vim.opt.undofile = true

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 8

vim.opt.updatetime = 50

vim.opt.colorcolumn = "80"

vim.opt.mouse = ""

vim.g.mapleader = " "
