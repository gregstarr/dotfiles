local ensure_packer = function()
    local fn = vim.fn
    local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
    if fn.empty(fn.glob(install_path)) > 0 then
        fn.system({
            'git',
            'clone',
            '--depth',
            '1',
            'https://github.com/wbthomason/packer.nvim',
            install_path
        })
        vim.cmd [[packadd packer.nvim]]
        return true
    end
    return false
end

local packer_bootstrap = ensure_packer()

-- This file can be loaded by calling `lua require('plugins')` from your init.vim
return require('packer').startup(function(use)
    use 'wbthomason/packer.nvim'
    use "tpope/vim-fugitive"
    use {
        "nvim-tree/nvim-tree.lua",
        config = function()
            require("nvim-tree").setup()
        end
    }
    use {
        'echasnovski/mini.surround',
        config = function()
            require('mini.surround').setup()
        end
    }
    use "akinsho/toggleterm.nvim"
    use {
        'echasnovski/mini.starter',
        config = function()
            require('mini.starter').setup()
        end
    }
    use {
        'echasnovski/mini.ai',
        config = function()
            require('mini.ai').setup()
        end
    }
    use "stevearc/dressing.nvim"
    use {
        "lukas-reineke/indent-blankline.nvim",
        config = function()
            require("indent_blankline").setup {
                show_current_context = true,
                show_current_context_start = true,
            }
        end
    }
    use {
        "folke/trouble.nvim",
        requires = "nvim-tree/nvim-web-devicons",
        config = function()
            require("trouble").setup()
        end
    }
    use {
        'nvim-telescope/telescope.nvim',
        requires = { { 'nvim-lua/plenary.nvim' } }
    }
    use 'benfowler/telescope-luasnip.nvim'
    use {
        'rose-pine/neovim',
        as = 'rose-pine',
        config = function()
            vim.cmd('colorscheme rose-pine')
        end
    }
    use {
        'nvim-lualine/lualine.nvim',
        requires = { 'nvim-tree/nvim-web-devicons', opt = true }
    }
    use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
    use "nvim-treesitter/playground"
    -- LSP
    use 'L3MON4D3/LuaSnip'
    use {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v1.x',
        requires = {
            -- LSP Support
            { 'neovim/nvim-lspconfig' },             -- Required
            { 'williamboman/mason.nvim' },           -- Optional
            { 'williamboman/mason-lspconfig.nvim' }, -- Optional
            -- Autocompletion
            { 'hrsh7th/nvim-cmp' },                  -- Required
            { 'hrsh7th/cmp-nvim-lsp' },              -- Required
        }
    }
    if packer_bootstrap then
        require('packer').sync()
    end
end)
