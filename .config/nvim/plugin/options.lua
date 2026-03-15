local opt = vim.opt

opt.tabstop = 4
opt.softtabstop = 4
opt.shiftwidth = 4

opt.number = true
opt.relativenumber = true

-- Don't show the mode, since it's already in the status line
opt.showmode = false

-- Sync clipboard between OS and Neovim.
opt.clipboard = "unnamedplus"

opt.breakindent = true

-- Sets how neovim will display certain whitespace characters in the editor.
-- opt.list = true
-- opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

-- Save undo history
opt.undofile = true

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
opt.ignorecase = true
opt.smartcase = true

opt.signcolumn = "yes"

opt.updatetime = 250

-- Preview substitutions live, as you type!
opt.inccommand = "split"

-- Show which line your cursor is on
opt.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
opt.scrolloff = 10

-- line wrap settings
vim.o.linebreak = true
vim.o.wrap = true
vim.o.breakindent = true
vim.o.showbreak = "↳ "
vim.o.winborder = "rounded"
