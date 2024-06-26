return {
    {
        "nvim-telescope/telescope.nvim",
        tag = "0.1.5",
        event = "VimEnter",
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function()
            local builtin = require("telescope.builtin")
            vim.keymap.set("n", "<C-p>", builtin.git_files, {})
            vim.keymap.set("n", "<leader>sf", builtin.find_files, {})
            vim.keymap.set("n", "<leader>sg", builtin.live_grep, {})
        end
    },
    {
        "folke/todo-comments.nvim",
        cmd = { "TodoTrouble", "TodoTelescope" },
        event = { "BufReadPost", "BufWritePost", "BufNewFile" },
        config = true,
        keys = {
            { "]t",         function() require("todo-comments").jump_next() end, desc = "Next todo comment" },
            { "[t",         function() require("todo-comments").jump_prev() end, desc = "Previous todo comment" },
            { "<leader>st", "<cmd>TodoTelescope<cr>",                            desc = "Todo" },
            { "<leader>sT", "<cmd>TodoTelescope keywords=TODO,FIX,FIXME<cr>",    desc = "Todo/Fix/Fixme" },
        },
    },
    {
        "tpope/vim-sleuth",
    },
    {
        "github/copilot.vim",
        event = "InsertEnter",
    },
    {
        "numToStr/Comment.nvim",
        lazy = false,
        opts = {
            toggler = {
                line = "<leader>/",
            },
            opleader = {
                line = "<leader>/",
            }
        },
    },
    {
        "mbbill/undotree",
        keys = {
            { "<leader>u", "<cmd>UndotreeToggle<cr>", desc = "Undo tree" },
        },
        config = function()
            vim.g.undotree_SetFocusWhenToggle = 1
        end
    }
}
