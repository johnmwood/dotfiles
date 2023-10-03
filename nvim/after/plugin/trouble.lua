require('trouble').setup({
    icons = false,
    signs = {
        -- icons / text used for a diagnostic
        error = 'E',
        warning = 'W',
        hint = 'H',
        information = 'I',
        other = 'O'
    },
})

vim.keymap.set("n", "<leader>xx", "<cmd>Trouble workspace_diagnostics<cr>", { silent = true, noremap = true })
vim.keymap.set("n", "<leader>xd", "<cmd>Trouble document_diagnostics<cr>", { silent = true, noremap = true })
vim.keymap.set("n", "<leader>xl", "<cmd>Trouble loclist<cr>", { silent = true, noremap = true })
vim.keymap.set("n", "<leader>xq", "<cmd>Trouble quickfix<cr>", { silent = true, noremap = true })
vim.keymap.set("n", "gR", "<cmd>Trouble lsp_references<cr>", { silent = true, noremap = true })
