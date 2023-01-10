local o = vim.o
local opt = vim.opt
local cmd = vim.cmd

o.autoindent = 4
o.softtabstop = 4
o.tabstop = 4
o.shiftwidth = 4
o.et = false
o.expandtab = true

o.incsearch = true
o.hlsearch = false
o.ignorecase = true

o.swapfile = false
o.backup = false
o.undodir = os.getenv("HOME") .. "/.vim/undodir"
o.undofile = true

o.termguicolors = true

o.number = true
o.relativenumber = false
o.smartcase = true
o.ttyfast = true
o.wrap = false

opt.scrolloff = 12
opt.mouse = 'a'

cmd 'set updatetime=300'
cmd 'set guicursor=i:ver25,i:blinkon1'

