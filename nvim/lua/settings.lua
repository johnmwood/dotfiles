local o = vim.o
local opt = vim.opt

o.relativenumber = true
o.number = true
o.hlsearch = false
o.incsearch = true 
o.smartcase = true
o.ignorecase = true 
o.tabstop = 4
o.softtabstop = 4
o.expandtab = true
o.shiftwidth = 4
o.autoindent = 4
opt.scrolloff = 24
o.ttyfast = true
o.wrap = false
opt.mouse = 'a'
vim.cmd 'set guicursor=i:ver25,i:blinkon1'
o.guitablabel = '%t'
-- o.swapfile = true
-- o.nobackup = true
-- ctrl + w + o == close all windows except one 
-- ctrl + w + H == verticle to horizontal split 
