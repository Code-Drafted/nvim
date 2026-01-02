return {
	{
		"lewis6991/gitsigns.nvim",
		event = { "BufReadPre", "BufNewFile" },
		opts = {
			signs = {
				add = { text = "│" },
				change = { text = "│" },
				delete = { text = "_" },
				topdelete = { text = "‾" },
				changedelete = { text = "~" },
			},
			current_line_blame = true,
		},
	},
	{
		"NeogitOrg/neogit",
		dependencies = { "nvim-lua/plenary.nvim", "sindrets/diffview.nvim" },
		cmd = "Neogit",
		opts = {
			integrations = { diffview = true },
		},
	},
	{
		"sindrets/diffview.nvim",
		lazy = true,
		dependencies = "nvim-lua/plenary.nvim",
	},
	{
		"tpope/vim-fugitive",
		cmd = { "Git", "Gvdiffsplit", "Gclog", "Gblame" },
		dependencies = {
			"tpope/vim-rhubarb",
		},
		keys = {
			{ "<leader>gs", "<cmd>Git<cr>", desc = "Git status" },
			{ "<leader>gc", "<cmd>Git commit<cr>", desc = "Git commit" },
			{ "<leader>gp", "<cmd>Git push<cr>", desc = "Git push" },
			{ "<leader>gl", "<cmd>Git pull<cr>", desc = "Git pull" },
			{ "<leader>gb", "<cmd>Git blame<cr>", desc = "Git blame" },
			{ "<leader>gd", "<cmd>Gvdiffsplit<cr>", desc = "Git diff split" },
			{ "<leader>gL", "<cmd>Gclog<cr>", desc = "Git log (current file)" },

			{ "<leader>go", "<cmd>GBrowse<cr>", desc = "Open on GitHub" },
			{ "<leader>gO", "<cmd>GBrowse!<cr>", desc = "Copy GitHub URL" },
		},
	},
}
