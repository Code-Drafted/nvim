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
		"sindrets/diffview.nvim",
		lazy = true,
		dependencies = "nvim-lua/plenary.nvim",
	},
	{
		"tpope/vim-fugitive",
		cmd = { "Git", "G", "Gdiffsplit", "Gblame" },
	},
}
