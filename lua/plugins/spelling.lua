local spell_types = { "tex", "markdown" }

-- Enable spell checking for specific file types
vim.opt.spelllang = "en_gb"
vim.opt.spell = false

vim.api.nvim_create_autocmd("FileType", {
	pattern = spell_types,
	callback = function()
		vim.opt.spell = true
	end,
})

return {
	"ravibrock/spellwarn.nvim",
	event = "VeryLazy",
	config = function()
		require("spellwarn").setup({
			ft_default = false,
			enable = true,
			ft_config = (function()
				local ft_table = {}
				for _, ft in ipairs(spell_types) do
					ft_table[ft] = true
				end
				return ft_table
			end)(),
		})
	end,
}
