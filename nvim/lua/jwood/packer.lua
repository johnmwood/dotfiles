-- -- ensure that packer is installed
-- local install_path = vim.fn.stdpath('data')..'/site/pack/packer/opt/packer.nvim'
-- if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
--     vim.api.nvim_command.execute('!git clone https://github.com/wbthomason/packer.nvim '..install_path)
--     vim.api.nvim_command.execute 'packadd packer.nvim'
-- end

-- Only required if you have packer configured as `opt`
vim.cmd('packadd packer.nvim')

return require('packer').startup(function(use)
    -- Packer can manage itself
    use('wbthomason/packer.nvim')

    use('nvim-treesitter/nvim-treesitter', {run = ':TSUpdate'})
    use('nvim-treesitter/playground')
    use('theprimeagen/harpoon')
    use('mbbill/undotree')
    use("folke/zen-mode.nvim")
    use("folke/trouble.nvim")
    use {
        'nvim-telescope/telescope.nvim', tag = '0.1.0',
        -- or                            , branch = '0.1.x',
        requires = { {'nvim-lua/plenary.nvim'} }
    }

    -- language plugins
    use('fatih/vim-go', {run = ':GoUpdateBinaries'})
    use('neovim/nvim-lspconfig')
    use('jose-elias-alvarez/null-ls.nvim')
    use('MunifTanjim/eslint.nvim')

    use('tpope/vim-fugitive') -- git 
    use('tpope/vim-commentary') -- comment things out
    use('tpope/vim-vinegar') -- netrw enhancements
    -- git
    use('airblade/vim-gitgutter')
    use('ruanyl/vim-gh-line')

    -- colors
    use({ 'rose-pine/neovim', as = 'rose-pine' })
    use('gruvbox-community/gruvbox')
    use('cocopon/iceberg.vim')

    use {
	    'VonHeikemen/lsp-zero.nvim',
	    requires = {
		    -- LSP Support
		    {'neovim/nvim-lspconfig'},
		    {'williamboman/mason.nvim'},
		    {'williamboman/mason-lspconfig.nvim'},

		    -- Autocompletion
		    {'hrsh7th/nvim-cmp'},
		    {'hrsh7th/cmp-buffer'},
		    {'hrsh7th/cmp-path'},
		    {'saadparwaiz1/cmp_luasnip'},
		    {'hrsh7th/cmp-nvim-lsp'},
		    {'hrsh7th/cmp-nvim-lua'},

		    -- Snippets
		    {'L3MON4D3/LuaSnip'},
		    {'rafamadriz/friendly-snippets'},
	    }
    }
end)
