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
    {
        "echasnovski/mini.ai",
        version = "*"
    },

     "folke/todo-comments.nvim",

     "nvim-lua/plenary.nvim",

     "numToStr/Comment.nvim",

    {
        "nvim-telescope/telescope.nvim",
        tag = "0.1.4",
        dependencies = {"nvim-lua/plenary.nvim"},
    },

    {
        "dasupradyumna/midnight.nvim",
        lazy = false,
        priority = 1000,
        config = function()
            -- load the colorscheme here
            vim.cmd([[colorscheme midnight]])
        end,
    },

    {
        "nvim-treesitter/nvim-treesitter",
        tag = "v0.9.2",
        build = ":TSUpdate",
    },

    {
        "ThePrimeagen/harpoon",
        branch = "harpoon2",
        dependencies = {"nvim-lua/plenary.nvim"}
    },

    "mbbill/undotree",
    "tpope/vim-fugitive",
    "itchyny/lightline.vim",

    {
        "VonHeikemen/lsp-zero.nvim",
        branch = "v3.x",
        dependencies = {
            --- Uncomment these if you want to manage LSP servers from neovim
            {"williamboman/mason.nvim"},
            {"williamboman/mason-lspconfig.nvim"},
            -- LSP Support
            {"neovim/nvim-lspconfig"},
            -- Autocompletion
            {"hrsh7th/nvim-cmp"},
            {"hrsh7th/cmp-nvim-lsp"},
            {"L3MON4D3/LuaSnip"},
        }
    },

    "lukas-reineke/indent-blankline.nvim",

})
