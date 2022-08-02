local api = vim.api
local cmd = vim.cmd
local opt = vim.opt

opt.termguicolors = true
cmd "colorscheme gruvbox"
require 'nvim-treesitter.configs'.setup { highlight = { enable = true }, incremental_selection = { enable = true },
    textobjects = { enable = true } }

-- LSP Settings
local opts = { noremap = true, silent = true }
local on_attach = function(client, bufnr)
    -- Enable completion triggered by <c-x><c-o>
    -- require('coq').lsp_ensure_capabilities({})
    api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
    api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)

    --     buffer = bufnr,
    --     group = group,
    --     callback = function()
    --         local hold_opts = {
    --             focusable = false,
    --             close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
    --             border = 'rounded',
    --             source = 'always',
    --             prefix = '',
    --         }
    --         vim.diagnostic.open_float(hold_opts)
    --     end
    -- })
end

require('nvim-lsp-installer').setup {}

local lspconfig = require('lspconfig')

vim.g.coq_settings = { auto_start = 'shut-up' }
-- vim.diagnostic.config({ virtual_text = false })

local servers = { 'gopls', 'rust_analyzer', 'jedi_language_server', 'vimls', 'clangd', 'cmake',
    'html', 'bashls', 'dockerls', 'sumneko_lua', 'jdtls', 'yamlls' }
for _, lsp in ipairs(servers) do
    lspconfig[lsp].setup(require('coq').lsp_ensure_capabilities({}))
end

require('telescope').setup {
    pickers = {
        find_files = {
            theme = 'ivy',
        },
        live_grep = {
            theme = 'ivy',
        },
        buffers = {
            theme = 'ivy',
        },
    }
}
require('luatab').setup {}
require('trouble').setup {}
require('lualine').setup()

-- gofmt save on write
local group = api.nvim_create_augroup("On Write", { clear = true })
api.nvim_create_autocmd("BufWritePre", { command = ":lua vim.lsp.buf.formatting_sync()", group = group })

-- gitgutter
vim.g.gitgutter_enabled = 1
vim.g.gitgutter_map_keys = 0
