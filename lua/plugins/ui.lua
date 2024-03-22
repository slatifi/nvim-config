return {
    {
        "catppuccin/nvim",
        name = "catppuccin",
        priority = 1000,
        config = function()
            vim.cmd.colorscheme("catppuccin")
        end,
    },
    {
        "nvim-lualine/lualine.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        opts = {
            options = {
                -- disabling separators fixes intro screen flash
                section_separators = "",
            },
        },
    },
    {
        "stevearc/oil.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function()
            vim.keymap.set("n", "<leader>e", "<cmd>Oil --float<CR>")
            require("oil").setup({
                skip_confirm_for_simple_edits = true,
                view_options = {
                    show_hidden = true,
                },
            })
        end,
    },
    {
        "lewis6991/gitsigns.nvim",
        config = true,
    },
    {
        "lukas-reineke/indent-blankline.nvim",
        event = "BufReadPost",
        main = "ibl",
        opts = {
            indent = { char = "▏" },
            scope = {
                show_start = false,
                show_end = false,
            },
        },
    },
    {
        "akinsho/toggleterm.nvim",
        version = "*",
        keys = {
            { "<leader>t", "<cmd>ToggleTerm<CR>" },
        },
    },
}
