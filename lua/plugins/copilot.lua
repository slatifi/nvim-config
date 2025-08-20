return {
	{
		"github/copilot.vim",
		event = "InsertEnter",
		config = function()
			vim.g.copilot_no_tab_map = true
			vim.g.copilot_hide_during_completion = false
			vim.g.copilot_settings = { selectedCompletionModel = "gpt-4o-copilot" }
			vim.keymap.set("i", "<S-Tab>", 'copilot#Accept("\\<S-Tab>")', { expr = true, replace_keycodes = false })
		end,
	},
	{
		"CopilotC-Nvim/CopilotChat.nvim",
		dependencies = {
			{ "nvim-lua/plenary.nvim", branch = "master" },
		},
		build = "make tiktoken",
		config = function()
			local chat = require("CopilotChat")

			chat.setup({
				model = "gpt-4.1", -- AI model to use
				temperature = 0.1, -- Lower = focused, higher = creative
				sticky = "#buffers:visible", -- Start each chat with the buffer context
				window = {
					layout = "vertical", -- 'vertical', 'horizontal', 'float'
					width = 0.5, -- 50% of screen width
				},
				auto_insert_mode = true, -- Enter insert mode when opening
				mappings = {
					reset = false,
					complete = {
						insert = "<Tab>",
					},
					show_diff = {
						full_diff = true,
					},
				},
			})

			vim.keymap.set({ "n" }, "<leader>aa", chat.toggle, { desc = "AI Toggle" })
			vim.keymap.set({ "n" }, "<leader>ad", chat.reset, { desc = "AI Reset" })
			vim.keymap.set({ "n" }, "<leader>am", chat.select_model, { desc = "AI Models" })
			vim.keymap.set({ "n", "v" }, "<leader>ap", chat.select_prompt, { desc = "AI Prompts" })
		end,
	},
}
