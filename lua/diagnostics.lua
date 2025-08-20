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
	signs = true,
	underline = true,
	update_in_insert = false,
	severity_sort = true,
	float = {
		border = "rounded",
		source = "always",
	},
})

local signs = {
	Error = "●",
	Warn = "●",
	Hint = "○",
	Info = "○",
}

for type, icon in pairs(signs) do
	local hl = "DiagnosticSign" .. type
	vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end

vim.keymap.set("n", "ge", function()
	vim.diagnostic.open_float(nil, {
		focusable = true,
		scope = "cursor",
	})
end, { desc = "Open diagnostic float" })
