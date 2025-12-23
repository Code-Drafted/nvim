return {
	{
		"akinsho/toggleterm.nvim",
		version = "*",

		config = function()
			require("toggleterm").setup({
				size = 20,
				open_mapping = [[<c-\>]],
				hide_numbers = true,
				direction = "float",
				close_on_exit = true,
				shell = vim.o.shell,

				float_opts = {
					border = "single",
					winblend = 3,
				},
			})

			vim.keymap.set("n", "<leader>tt", ":ToggleTerm<CR>", { silent = true })

			vim.keymap.set("n", "<leader>ts", ":ToggleTerm direction=horizontal size=15<CR>", { silent = true })
			vim.keymap.set("n", "<leader>tv", ":ToggleTerm direction=vertical size=80<CR>", { silent = true })
		end,
	},
}
