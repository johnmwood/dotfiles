local o = vim.o
local opt = vim.opt

o.autoindent = 4
o.et = false
o.expandtab = true
o.guitablabel = '%t'
o.ignorecase = true
o.incsearch = true
o.number = true
o.relativenumber = true
o.shiftwidth = 4
o.smartcase = true
o.softtabstop = 4
-- o.swapfile = true
o.tabstop = 4
o.ttyfast = true
o.wrap = false

opt.scrolloff = 24
opt.mouse = 'a'

vim.cmd 'set guicursor=i:ver25,i:blinkon1'
