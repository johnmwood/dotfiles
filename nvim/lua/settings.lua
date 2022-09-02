local o = vim.o
local opt = vim.opt
local cmd = vim.cmd

o.autoindent = 4
o.et = false
o.expandtab = true
o.guitablabel = '%t'
o.hlsearch = false
o.ignorecase = true
o.incsearch = true
o.number = true
o.relativenumber = true
o.shiftwidth = 4
o.smartcase = true
o.softtabstop = 4
o.swapfile = false
o.tabstop = 4
o.ttyfast = true
o.wrap = false

opt.scrolloff = 24
opt.mouse = 'a'

cmd 'set updatetime=300'
cmd 'set guicursor=i:ver25,i:blinkon1'
