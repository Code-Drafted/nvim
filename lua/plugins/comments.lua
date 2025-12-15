return {
	{
		"folke/todo-comments.nvim",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = {
			signs = true,
			highlight = {
				before = "",
				keyword = "wide",
				after = "fg",
			},
			keywords = {
				TODO = { icon = " ", color = "info" },
				FIX = { icon = " ", color = "error" },
				HACK = { icon = " ", color = "warning" },
				NOTE = { icon = " ", color = "hint" },
			},
			search = {
				command = "rg",
				args = {
					"--color=never",
					"--no-heading",
					"--with-filename",
					"--line-number",
					"--column",
				},
			},
		},
	},

	{
		"numToStr/Comment.nvim",
		event = { "BufReadPre", "BufNewFile" },
		opts = {
			padding = true,
			sticky = true,
			ignore = nil,
			mappings = {
				basic = true, -- gcc, gc
				extra = true, -- gco, gcO, gcA
			},
		},
	},
}
