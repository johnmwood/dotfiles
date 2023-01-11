require('rose-pine').setup({ dark_variant = 'moon' })

function SCS(color)
    local final = 'rose-pine'
    if color == 'g' then
        final = 'gruvbox'
    elseif color == 'i' then
        final = 'iceberg'
    end

    vim.cmd.colorscheme(final)
end

SCS()
