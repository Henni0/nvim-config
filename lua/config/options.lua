--- Global tab/indent settings
vim.opt.tabstop = 4 -- A tab character appears as 4 spaces
vim.opt.shiftwidth = 4 -- Number of spaces to use for autoindent
vim.opt.softtabstop = 4 -- Number of spaces per Tab key
vim.opt.expandtab = true -- Use spaces instead of tab characters
vim.opt.autoindent = true -- Copy indent from previous line
vim.opt.smartindent = true -- Enable smart indentation for programming
vim.cmd("filetype plugin indent on")
--Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
