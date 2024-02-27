return {
    {
        'nvim-lualine/lualine.nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        config = true
    },
    {
        'stevearc/oil.nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        config = true
    },
    {
        "j-hui/fidget.nvim",
        config = true
    },
    {
        "lewis6991/gitsigns.nvim",
        config = true
    },
    {
        "lukas-reineke/indent-blankline.nvim",
        main = "ibl",
        opts = {
            indent = { char = "▏" },
            scope = {
                show_start = false,
                show_end = false
            }
        }
    }
}
