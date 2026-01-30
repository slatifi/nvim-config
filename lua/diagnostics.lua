vim.api.nvim_create_autocmd("FileType", {
	pattern = "htmldjango",
	callback = function()
		vim.bo.filetype = "html"
	end,
})

vim.diagnostic.config({
	virtual_text = {
		prefix = "●",
	},
	underline = true,
	update_in_insert = false,
	severity_sort = true,
	float = {
		border = "rounded",
		source = true,
	},
	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = "●",
			[vim.diagnostic.severity.WARN] = "●",
			[vim.diagnostic.severity.INFO] = "○",
			[vim.diagnostic.severity.HINT] = "○",
		},
		linehl = {
			[vim.diagnostic.severity.ERROR] = "Error",
			[vim.diagnostic.severity.WARN] = "Warn",
			[vim.diagnostic.severity.INFO] = "Info",
			[vim.diagnostic.severity.HINT] = "Hint",
		},
	},
})

vim.keymap.set("n", "ge", function()
	vim.diagnostic.open_float(nil, {
		focusable = true,
		scope = "cursor",
	})
end, { desc = "Open diagnostic float" })
