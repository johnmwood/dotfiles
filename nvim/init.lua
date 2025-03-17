-- ###############
-- ### Plugins ###
-- ###############
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end

vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
    -- colorschemes
    {
        "rose-pine/neovim",
        as = "rose-pine",
        priority = 1000,
        config = function()
            require("rose-pine").setup({
                dark_variant = "moon",
            })
            vim.cmd('colorscheme rose-pine')
        end
    },
    {
        "ellisonleao/gruvbox.nvim",
    },
    -- basics
    {
        'williamboman/mason.nvim',
        opts = {
            ensure_installed = {
                "gopls",
                "typescript-language-server",
                "eslint-lsp",
                "eslint_d",
                "prettierd",
                "pyright",
            }
        }
    },
    { 'williamboman/mason-lspconfig.nvim' },
    {
        'nvim-lualine/lualine.nvim',
        config = function()
            require("lualine").setup({
                options = {
                    theme = "auto",
                    icons_enabled = true,
                    icons = true,
                    globalstatus = true,
                },
                sections = {
                    lualine_c = {
                        {
                            'filename',
                            path = 1,
                        }
                    },
                },
            })
        end
    },
    { 'tpope/vim-commentary' },
    { 'tpope/vim-vinegar' },
    { 'nvim-lua/plenary.nvim' },
    { 'romainl/vim-cool' },
    {
        'folke/trouble.nvim',
        opts = {
            icons = false,
            fold_open = "v",      -- icon used for open folds
            fold_closed = ">",    -- icon used for closed folds
            indent_lines = false, -- add an indent guide below the fold icons
            signs = {
                error = "error",
                warning = "warn",
                hint = "hint",
                information = "info"
            },
            use_diagnostic_signs = false -- enabling this will use the signs defined in your lsp client
        }
    },

    -- treesitter
    {
        'nvim-treesitter/nvim-treesitter',
        dependencies = {
            'nvim-treesitter/nvim-treesitter-textobjects',
        },
        build = ":TSUpdate",
        config = function()
            require('nvim-treesitter.configs').setup({
                ensure_installed = { 'go', 'gomod', 'lua', 'vimdoc', 'vim', 'bash', 'markdown',
                    'markdown_inline', 'c', 'rust', 'cpp', 'yaml', 'toml', 'java', 'javascript', 'typescript'
                },
                indent = { enable = true },
                highlight = {
                    enable = true,
                    disable = function(_, buf)
                        local max_filesize = 100 * 1024 -- 100 KB
                        local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
                        if ok and stats and stats.size > max_filesize then
                            return true
                        end
                    end,
                    additional_vim_regex_highlighting = false,
                },
            })
        end,
    },
    {
        "ibhagwan/fzf-lua",
        config = function()
            require("fzf-lua").setup({
                keymap = {
                    fzf = {
                        ['tab'] = "down",
                        ['shift-tab'] = "up",
                    }
                }
            })
        end
    },
    { "nvim-telescope/telescope.nvim" },
    { 'theprimeagen/harpoon' },

    -- LSP Support
    {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v3.x',
        lazy = true,
        config = false,
    },
    {
        'neovim/nvim-lspconfig',
        dependencies = {
            { 'hrsh7th/cmp-nvim-lsp' },
        }
    },

    -- Autocompletion
    {
        "L3MON4D3/LuaSnip",
    },
    {
        'hrsh7th/nvim-cmp',
    },
    { "hrsh7th/cmp-buffer" },
    { "hrsh7th/cmp-path" },
    { "saadparwaiz1/cmp_luasnip" },
    { "hrsh7th/cmp-nvim-lsp" },
    { "rafamadriz/friendly-snippets" },
    -- {
    --     "zbirenbaum/copilot-cmp",
    --     config = function()
    --         require("copilot_cmp").setup()
    --     end
    -- },
    { "lukas-reineke/lsp-format.nvim", config = true },
    -- {
    --     "zbirenbaum/copilot.lua",
    --     cmd = "Copilot",
    --     event = "InsertEnter",
    --     config = function()
    --         require("copilot").setup({
    --             panel = {
    --                 enabled = false,
    --             },
    --             suggestion = {
    --                 enabled = true,
    --                 auto_trigger = true,
    --                 accept = false, -- disable built-in keymapping
    --             },
    --         })
    --     end
    -- },

    -- git
    { "tpope/vim-fugitive" },
    { "airblade/vim-gitgutter" },
    {
        "ruanyl/vim-gh-line",
        gh_git_remote = "https://bitbucket.cfdata.org",
    },

    -- go
    { 'fatih/vim-go' },

    -- typescript
    { 'jose-elias-alvarez/typescript.nvim' },
    { 'jose-elias-alvarez/null-ls.nvim' },
    { 'MunifTanjim/prettier.nvim' },
    { 'akinsho/nvim-bufferline.lua' }
})

local null_ls = require("null-ls")
null_ls.setup({
    sources = {
        null_ls.builtins.formatting.prettierd,
        null_ls.builtins.diagnostics.eslint_d,
        null_ls.builtins.code_actions.eslint_d,
    },
    on_attach = function(client, bufnr)
        require("lsp-format").on_attach(client, bufnr)
    end,
})

require("typescript").setup({
    server = {
        on_attach = function(client, bufnr)
            require("lsp-format").on_attach(client, bufnr)
        end,
    }
})

require('lspconfig').eslint.setup({
    enabled = false
})

vim.lsp.set_log_level("debug")

local lsp_zero = require('lsp-zero')
lsp_zero.preset("recommended")
lsp_zero.on_attach(function(client, bufnr)
    require("lsp-format").on_attach(client, bufnr)
    local opts = { buffer = bufnr, remap = false }
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
    vim.keymap.set('n', 'gs', vim.lsp.buf.signature_help, opts)
    vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, opts)
    vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
    vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
    vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, opts)
    vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
    vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
end)

local lua_opts = lsp_zero.nvim_lua_ls()
require('lspconfig').lua_ls.setup(lua_opts)

require('mason').setup({})
require('mason-lspconfig').setup({
    handlers = {
        lsp_zero.default_setup,
    },
})

local cmp = require('cmp')
local cmp_action = lsp_zero.cmp_action()
local cmp_format = require('lsp-zero').cmp_format()
require('luasnip.loaders.from_vscode').lazy_load()
local luasnip = require('luasnip')

cmp.setup({
    sources = {
        { name = "nvim_lsp" },
        { name = "nvim_lua" },
        { name = "buffer" },
        { name = "path" },
        { name = "cmp_luasnip" },
        { name = "luasnip" },
        { name = "friendly-snippets" },
        -- { name = "copilot" },
    },
    mapping = cmp.mapping.preset.insert({
        ['<CR>'] = cmp.mapping.confirm({ select = false }),
        ['<Tab>'] = cmp.mapping.select_next_item(),
        ['<S-Tab>'] = cmp.mapping.select_prev_item(),

        -- copilot specific config
        -- ["<Tab>"] = cmp.mapping(function(fallback)
        --     if cmp.visible() then
        --         cmp.confirm({ behavior = cmp.ConfirmBehavior.Insert, select = true })
        --     elseif require("copilot.suggestion").is_visible() then
        --         require("copilot.suggestion").accept()
        --     elseif luasnip.expand_or_locally_jumpable() then
        --         luasnip.expand_or_jump()
        --     else
        --         fallback()
        --     end
        -- end, { "i", "s" }),

        -- ["<S-Tab>"] = cmp.mapping(function(fallback)
        --     if cmp.visible() then
        --         cmp.select_prev_item()
        --     elseif luasnip.jumpable(-1) then
        --         luasnip.jump(-1)
        --     else
        --         fallback()
        --     end
        -- end, { "i", "s" }),
    })
})

vim.diagnostic.config { virtual_text = false }

-- ################
-- ### Settings ###
-- ################
vim.opt.nu = true
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.scrolloff = 24
vim.opt.wrap = true
vim.opt.number = false
vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.opt.termguicolors = true
-- vim.opt.background = "light"
vim.g.mapleader = " "
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.updatetime = 300
vim.opt.guicursor = "i:ver25,i:blinkon1"
vim.opt.joinspaces = false
vim.opt.swapfile = false

-- ##############
-- ### Remaps ###
-- ##############
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")

vim.keymap.set("n", "<leader>ll", "<cmd>set background=light<cr>", { silent = true, noremap = true })
vim.keymap.set("n", "<leader>dd", "<cmd>set background=dark<cr>", { silent = true, noremap = true })

vim.cmd [[
" temporary hack
function! SetShiftWidth()
    let l:filetype = &filetype
    if l:filetype == "javascript" || l:filetype == "typescript"
        setlocal shiftwidth=2
    else
        setlocal shiftwidth=4
    end
endfunction
]]
vim.keymap.set('', '<leader>sw', ':call SetShiftWidth()<CR>')

vim.keymap.set("n", "<leader>gh", "<cmd>GH<cr>")
vim.keymap.set("n", "<leader>gb", "<cmd>GB<cr>")

vim.cmd [[
" Command to store link to current line in bitbucket UI in the system's
" clipboard.
function! GetSourceLink() range
  let giturls={'git@stash.cfops.it:7999': 'bitbucket.cfdata.org/projects', 'git@bitbucket.cfdata.org:7999': 'bitbucket.cfdata.org/projects', 'git.kernel.org': "elixir.bootlin.com", "github.com": "github.com"}

  let remote=system("git remote get-url origin")
  let commit=system("git rev-parse HEAD")
  let domain=split(remote, '/')[2]
  let project=split(remote, '/')[-2]
  let repo=split(split(remote, '/')[-1], '\.')[0]

  if domain ==# "git.kernel.org"
    let @+=join(["https:/", giturls[domain], "linux/latest/source" , @%.'#L'.line('.')], "/")
  elseif domain ==# "github.com"
    let @+=join(["https:/", giturls[domain], project, repo, "tree/master", commit, @%.'#L'.a:firstline.'-'.'L'.a:lastline ], "/")
  else " bitbucket
    let @+=join(["https:/", giturls[domain], project, "repos", repo ,"browse", @%.'?at='.commit.'#'.a:firstline.'-'.a:lastline], "/")
  endif
endfunction
]]

vim.api.nvim_create_autocmd("TextYankPost", {
    desc = "Highlight when yanking (copying) text",
    group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
    callback = function()
        vim.highlight.on_yank()
    end,
})

vim.keymap.set('', '<leader>bb', ':call GetSourceLink()<CR>')

-- trouble
vim.keymap.set("n", "<leader>xx", "<cmd>Trouble workspace_diagnostics<cr>", { silent = true, noremap = true })
vim.keymap.set("n", "<leader>xd", "<cmd>Trouble document_diagnostics<cr>", { silent = true, noremap = true })
vim.keymap.set("n", "<leader>xl", "<cmd>Trouble loclist<cr>", { silent = true, noremap = true })
vim.keymap.set("n", "<leader>xq", "<cmd>Trouble quickfix<cr>", { silent = true, noremap = true })
vim.keymap.set("n", "gR", "<cmd>Trouble lsp_references<cr>", { silent = true, noremap = true })

vim.keymap.set('n', '<leader>ff', "<cmd>Telescope find_files<CR>", { silent = true })
vim.keymap.set('n', '<leader>rr', "<cmd>Telescope live_grep<CR>", { silent = true })
vim.keymap.set('n', '<leader>b', "<cmd>Telescope buffers<CR>", { silent = true })

-- goto next/prev references
vim.keymap.set('n', '<C-j>', "<cmd>cprev<cr>", { silent = true })
vim.keymap.set('n', '<C-k>', "<cmd>cnext<cr>", { silent = true })

-- harpoon
local mark = require("harpoon.mark")
local ui = require("harpoon.ui")

vim.keymap.set("n", "<leader>a", mark.add_file)
vim.keymap.set("n", "<leader>h", ui.toggle_quick_menu)

vim.keymap.set("n", "<C-h>", function() ui.nav_file(1) end)
vim.keymap.set("n", "<C-t>", function() ui.nav_file(2) end)
vim.keymap.set("n", "<C-n>", function() ui.nav_file(3) end)
vim.keymap.set("n", "<C-s>", function() ui.nav_file(4) end)

-- resize windows
vim.keymap.set("n", "<leader>=", '<cmd>resize +10<cr>')
vim.keymap.set("n", "<leader>-", '<cmd>resize -10<cr>')

-- paste buffer over current text
vim.keymap.set("x", "<leader>p", [["_dP]])
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

-- go
vim.keymap.set("n", "<leader>gt", vim.cmd.GoTest)
vim.keymap.set("n", "<leader>k", vim.cmd.GoFmt)
vim.keymap.set("n", "<leader>gr", vim.cmd.GoRun)
