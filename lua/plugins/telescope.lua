return {
	{
		"nvim-telescope/telescope.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			{
				"nvim-telescope/telescope-ui-select.nvim",
				config = function()
					local telescope = require("telescope")
					telescope.setup({
						extensions = {
							["ui-select"] = require("telescope.themes").get_dropdown(),
						},
					})
					telescope.load_extension("ui-select")
				end,
			},
		},
		config = function()
			if vim.fn.executable("rg") == 0 then
				vim.notify("Ripgrep not found live_grep won't work!", vim.log.levels.WARN)
			end

			local builtin = require("telescope.builtin")

			vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Find help" })
			vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Find buffers" })
			vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Find files" })
			vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Find grep" })
			vim.keymap.set("n", "<leader>cm", builtin.commands, { desc = "Find commands" })

			vim.keymap.set("n", "<leader>fi", function()
				require("telescope.builtin").current_buffer_fuzzy_find()
			end, { desc = "VSCode-like search" })

			vim.keymap.set({ "n", "v" }, "<leader>ca", function()
				vim.lsp.buf.code_action()
			end, { desc = "LSP Code Actions" })
		end,
	},
}
