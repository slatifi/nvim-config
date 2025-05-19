-- To use a jupyter notebook, setup a virtual environment with the following packages: jupyter jupytext pynvim wt/ Python >= 3.10

-- Notes to install:
-- 1. install lua 5.1 manually
-- 2. brew install imagemagick pkg-config luarocks
-- 3. install the luarock magick
-- 4. symlink the /opt/homebrew/Cellar/Imagemagick/<version>/lib/libMagick* -> /usr/local/lib

-- automatically import output chunks from a jupyter notebook
-- tries to find a kernel that matches the kernel in the jupyter notebook
-- falls back to a kernel that matches the name of the active venv (if any)
local imb = function(e) -- init molten buffer
    vim.schedule(function()
        local kernels = vim.fn.MoltenAvailableKernels()
        local try_kernel_name = function()
            local metadata = vim.json.decode(io.open(e.file, "r"):read("a"))["metadata"]
            return metadata.kernelspec.name
        end
        local ok, kernel_name = pcall(try_kernel_name)
        if not ok or not vim.tbl_contains(kernels, kernel_name) then
            kernel_name = nil
            local venv = os.getenv("VIRTUAL_ENV")
            if venv ~= nil then
                kernel_name = string.match(venv, "/.+/(.+)")
            end
        end
        if kernel_name ~= nil and vim.tbl_contains(kernels, kernel_name) then
            vim.cmd(("MoltenInit %s"):format(kernel_name))
        end
        vim.cmd("MoltenImportOutput")
    end)
end

-- automatically import output chunks from a jupyter notebook
vim.api.nvim_create_autocmd("BufAdd", {
    pattern = { "*.ipynb" },
    callback = imb,
})

-- we have to do this as well so that we catch files opened like nvim ./hi.ipynb
vim.api.nvim_create_autocmd("BufEnter", {
    pattern = { "*.ipynb" },
    callback = function(e)
        if vim.api.nvim_get_vvar("vim_did_enter") ~= 1 then
            imb(e)
        end
    end,
})

-- automatically export output chunks to a jupyter notebook on write
vim.api.nvim_create_autocmd("BufWritePost", {
    pattern = { "*.ipynb" },
    callback = function()
        if require("molten.status").initialized() == "Molten" then
            vim.cmd("MoltenExportOutput!")
        end
    end,
})


return {
    {
        "benlubas/molten-nvim",
        version = "^1.0.0", -- use version <2.0.0 to avoid breaking changes
        dependencies = { "3rd/image.nvim" },
        build = ":UpdateRemotePlugins",
        ft = { "quarto", "markdown" },
        init = function()
            -- these are examples, not defaults. Please see the readme
            vim.g.molten_image_provider = "image.nvim"
            vim.g.molten_wrap_output = true
            -- vim.g.molten_virt_text_output = true
            vim.g.molten_virt_lines_off_by_1 = true
            vim.keymap.set("n", "<leader>je", "<cmd>MoltenEvaluateOperator<cr>",
                { desc = "evaluate operator", silent = true })
            vim.keymap.set("v", "<leader>je", "<cmd><C-u>MoltenEvaluateVisual<CR>gv",
                { desc = "evaluate cell", silent = true })
            vim.keymap.set("n", "<leader>jd", "<cmd>MoltenDelete<cr>", { desc = "delete output", silent = true })
            vim.keymap.set("n", "<leader>jc", "i```python<cr>```<esc>ko", { desc = "New jupyter cell" })
            vim.keymap.set("n", "<leader>jh", ":MoltenHideOutput<CR>",
                { silent = true, desc = "hide output" })
            vim.keymap.set("n", "<leader>js", ":noautocmd MoltenEnterOutput<CR>",
                { silent = true, desc = "show/enter output" })
        end,
    },
    {
        -- see the image.nvim readme for more information about configuring this plugin
        "3rd/image.nvim",
        ft = { "quarto", "markdown" },
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
        ft = { "quarto", "markdown" },
        config = function()
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
            vim.keymap.set("n", "<localleader>jc", runner.run_cell, { desc = "run cell", silent = true })
            vim.keymap.set("n", "<localleader>ja", runner.run_above, { desc = "run cell and above", silent = true })
            vim.keymap.set("n", "<localleader>jA", runner.run_all, { desc = "run all cells", silent = true })
        end
    },
    {
        "jmbuhr/otter.nvim",
        ft = { "quarto", "markdown" },
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
