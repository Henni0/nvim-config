-- bootstrap lazy.nvim, LazyVim and your plugins
vim.g.ai_cmp = false -- disable blink installation from copilot extra
require("config.lazy")
vim.cmd("filetype plugin indent on")
vim.opt.termguicolors = true
