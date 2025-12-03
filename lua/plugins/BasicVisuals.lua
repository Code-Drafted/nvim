return {
	{
		"folke/noice.nvim",
		event = "VeryLazy",
		dependencies = {
			"MunifTanjim/nui.nvim",
			"rcarriga/nvim-notify",
			"nvim-tree/nvim-web-devicons",
		},
		opts = {
			lsp = {
				progress = { enabled = true },
				signature = { enabled = true },
				hover = { enabled = true },
				override = {
					["vim.lsp.util.convert_input_to_markdown_lines"] = true,
					["vim.lsp.util.stylize_markdown"] = true,
					["cmp.entry.get_documentation"] = true,
				},
			},
			presets = {
				bottom_search = true,
				command_palette = true,
				long_message_to_split = true,
				inc_rename = true,
				lsp_doc_border = true,
			},
			views = {
				cmdline_popup = {
					position = {
						row = math.floor(vim.o.lines * 0.75),
						col = "50%",
					},
					size = {
						width = math.floor(vim.o.columns * 0.8),
						height = "auto",
					},
					border = {
						style = "rounded",
						padding = { 0, 1 },
					},
					win_options = {
						winhighlight = "Normal:Normal,FloatBorder:FloatBorder",
					},
				},
				popupmenu = {
					relative = "editor",
					position = {
						row = math.floor(vim.o.lines * 0.75) + 1,
						col = "50%",
					},
					size = {
						width = math.floor(vim.o.columns * 0.6),
						height = 10,
					},
					border = {
						style = "rounded",
						padding = { 0, 1 },
					},
					win_options = {
						winhighlight = "Normal:Normal,FloatBorder:FloatBorder,CursorLine:PmenuSel,Search:None",
					},
				},
			},
			routes = {
				{
					filter = {
						event = "msg_show",
						kind = "",
						find = "written",
					},
					opts = { skip = true },
				},
			},
		},
	},

	{
		"stevearc/dressing.nvim",
		event = "VeryLazy",
		opts = {
			input = {
				border = "rounded",
				win_options = {
					winhighlight = "Normal:Normal,FloatBorder:FloatBorder",
				},
				relative = "cursor",
				prefer_width = 40,
				insert_only = true,
			},
			select = {
				backend = { "telescope", "builtin" },
				builtin = {
					border = "rounded",
					win_options = {
						winhighlight = "Normal:Normal,FloatBorder:FloatBorder",
					},
				},
				telescope = require("telescope.themes").get_dropdown({
					previewer = false,
					layout_config = { width = 0.5, height = 0.5 },
				}),
			},
		},
	},

	{
		"rcarriga/nvim-notify",
		lazy = true,
		opts = {
			stages = "fade_in_slide_out",
			timeout = 3000,
			background_colour = "#000000",
			render = "default",
			fps = 60,
			top_down = false,
		},
		config = function(_, opts)
			local notify = require("notify")
			notify.setup(opts)
			vim.notify = notify
		end,
	},

	{
		"nvim-lualine/lualine.nvim",
		event = "VeryLazy",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		opts = {
			options = {
				theme = "auto",
				section_separators = { left = "", right = "" },
				component_separators = { left = "│", right = "│" },
				globalstatus = true,
			},
			sections = {
				lualine_a = { "mode" },
				lualine_b = { "branch", "diff" },
				lualine_c = { { "filename", path = 1 } },
				lualine_x = { "encoding", "fileformat", "filetype" },
				lualine_y = { "progress" },
				lualine_z = { "location" },
			},
		},
	},

	{
		"petertriho/nvim-scrollbar",
		event = "BufWinEnter",
		dependencies = { "kevinhwang91/nvim-hlslens" },
		config = function()
			require("scrollbar").setup()
			require("scrollbar.handlers.search").setup()
		end,
	},

	{
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
		event = { "BufReadPre", "BufNewFile" },
		opts = {
			indent = {
				char = "│",
			},
			scope = {
				enabled = true,
				show_start = true,
				show_end = false,
			},
		},
	},

	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		opts = {
			plugins = {
				marks = true,
				registers = true,
				spelling = { enabled = true, suggestions = 20 },
			},
			window = {
				border = "rounded",
				winblend = 0,
			},
		},
	},

	{
		"folke/todo-comments.nvim",
		event = { "BufReadPost", "BufNewFile" },
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = {
			signs = true,
		},
	},
}
