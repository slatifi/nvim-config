-- To use a jupyter notebook, setup a virtual environment with the following packages: jupyter jupytext pynvim
return {
    {
        "benlubas/molten-nvim",
        version = "^1.0.0", -- use version <2.0.0 to avoid breaking changes
        dependencies = { "3rd/image.nvim" },
        build = ":UpdateRemotePlugins",
        init = function()
            -- these are examples, not defaults. Please see the readme
            vim.g.molten_image_provider = "image.nvim"
            vim.g.molten_wrap_output = true
            vim.g.molten_virt_text_output = true
            vim.g.molten_virt_lines_off_by_1 = true
            vim.keymap.set("n", "<leader>je", "<cmd>MoltenEvaluateOperator<cr>", { desc = "evaluate operator", silent=true })
            vim.keymap.set("v", "<leader>je", "<cmd><C-u>MoltenEvaluateVisual<CR>gv", { desc = "evaluate cell", silent=true })
            vim.keymap.set("n", "<leader>jr", "<cmd>MoltenReevaluateCell<cr>", { desc = "re-evaluate cell", silent=true })
            vim.keymap.set("n", "<leader>jd", "<cmd>MoltenDelete<cr>", { desc = "delete output", silent=true })
            vim.keymap.set("n", "<leader>jr", "<cmd>MoltenReevaluateCell<cr>", { desc = "re-evaluate cell", silent=true })
            vim.keymap.set("n", "<leader>jc", "i```python<cr>```<esc>ko", { desc = "New jupyter cell" })
        end,
    },
    {
        -- see the image.nvim readme for more information about configuring this plugin
        "3rd/image.nvim",
        opts = {
            backend = "kitty", -- whatever backend you would like to use
            max_width = 100,
            max_height = 12,
            max_height_window_percentage = math.huge,
            max_width_window_percentage = math.huge,
            window_overlap_clear_enabled = true, -- toggles images when windows are overlapped
            window_overlap_clear_ft_ignore = { "cmp_menu", "cmp_docs", "" },
        },
    },
    {
        "quarto-dev/quarto-nvim",
        ft = {"quarto", "markdown"},
        config = function ()
            require("quarto").setup({
                lspFeatures = {
                    languages = { "r", "python", "rust" },
                    chunks = "all",
                    diagnostics = {
                        enabled = true,
                        triggers = { "BufWritePost" },
                    },
                    completion = {
                        enabled = true,
                    },
                },
                keymap = {
                    hover = "H",
                    definition = "gd",
                    rename = "<leader>rn",
                    references = "gr",
                    format = "<leader>gf",
                },
                codeRunner = {
                    enabled = true,
                    default_method = "molten",
                }
            })
            local runner = require("quarto.runner")
            vim.keymap.set("n", "<localleader>rc", runner.run_cell,  { desc = "run cell", silent = true })
            vim.keymap.set("n", "<localleader>ra", runner.run_above, { desc = "run cell and above", silent = true })
            vim.keymap.set("n", "<localleader>rA", runner.run_all,   { desc = "run all cells", silent = true })
        end
    },
    {
        "akinsho/nvim-toggleterm.lua"
    },
    {
        "jmbuhr/otter.nvim",
    },
    {
        "GCBallesteros/jupytext.nvim",
        opts = {
            style = "markdown",
            output_extension = "md",
            force_ft = "markdown",
        }
    }
}
