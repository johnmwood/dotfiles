local opt = vim.opt
local cmd = vim.cmd
local api = vim.api
local highlight = vim.highlight

opt.termguicolors = true
cmd "set t_8f=^[[38;2;%lu;%lu;%lum"
cmd "set t_8b=^[[48;2;%lu;%lu;%lum"

cmd "colorscheme gruvbox"

highlight.create('Comment', { cterm = 'italic', gui = 'italic' }, false)
highlight.create('String', { cterm = 'italic', gui = 'italic' }, false)

require 'nvim-treesitter.configs'.setup {
    ensure_installed = { "c", "lua", "rust", "go", "java", "elixir", "cpp", "yaml" },
    highlight = { enable = true },
    incremental_selection = { enable = true },
    textobjects = { enable = true }
}

-- LSP Settings
local opts = { noremap = true, silent = true }

require('nvim-lsp-installer').setup {}

local group = api.nvim_create_augroup("LSP Group", { clear = true })

local on_attach = function(client, bufnr)
    require('coq').lsp_ensure_capabilities({})
    api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
    api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)

    api.nvim_create_autocmd("CursorHold", {
        buffer = bufnr,
        group = group,
        callback = function()
            local hold_opts = {
                focusable = false,
                close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
                border = 'rounded',
                source = 'always',
                prefix = '',
            }
            vim.diagnostic.open_float(hold_opts)
        end
    }
    )
end

local lspconfig = require('lspconfig')

vim.diagnostic.config({ virtual_text = false })

vim.g.coq_settings = { auto_start = 'shut-up' }

local servers = { 'gopls', 'rust_analyzer', 'jedi_language_server', 'vimls', 'clangd', 'cmake', 'elixirls', 'graphql',
    'html', 'bashls', 'dockerls', 'sumneko_lua', 'jdtls', 'yamlls' }
for _, lsp in ipairs(servers) do
    if lsp == 'gopls' then do
            lspconfig.gopls.setup {
                on_attach = on_attach,
                settings = {
                    gopls = {
                        completeUnimported = true,
                        buildFlags = { "-tags=debug" },
                        ["local"] = "github.com/sourcegraph/sourcegraph",
                        analyses = {
                            unusedparams = true,
                        },
                        staticcheck = true,
                        experimentalPostfixCompletions = true,
                        hints = {
                            parameterNames = true,
                            assignVariableTypes = true,
                            constantValues = true,
                            rangeVariableTypes = true,
                            compositeLiteralTypes = true,
                            compositeLiteralFields = true,
                            functionTypeParameters = true,
                        }
                    }
                },
                flags = {
                    debounce_text_changes = 200,
                },
            }
        end
    else
        lspconfig[lsp].setup { on_attach = on_attach }
    end
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
        help_tags = {
            theme = 'ivy'
        }
    }
}

require('trouble').setup {
    icons = false,
}
