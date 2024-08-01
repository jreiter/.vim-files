-- See:
-- :options
-- :help vim.opt

-- moving around, searching and patterns
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- wildmenu
vim.opt.wildmenu = true
vim.opt.wildmode = "list:longest,full"
vim.opt.wildignore = "*.class,*.git"

-- displaying text
vim.opt.number = true
vim.opt.ruler = true
vim.opt.colorcolumn = "80"
vim.opt.background = "dark"

-- Colrs and display
vim.opt.hlsearch = true
vim.opt.inccommand = "nosplit"
vim.opt.termguicolors = true
vim.opt.colorcolumn = "80"

-- Enable persistent undo so that undo history persists across vim sessions
-- vim.opt.undofile = true
-- vim.opt.undodir = os.getenv("HOME") .. "/.local/share/nvim/undo"

-- tabs and indenting
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.shiftround = true
vim.opt.expandtab = true

-- reading and writing files
vim.opt.writebackup = false
vim.opt.backup = false
vim.opt.autoread = true

-- the swap file
vim.opt.swapfile = false
vim.opt.updatetime = 100

-- various
vim.opt.signcolumn = "yes"
