return {
	{
		"folke/zen-mode.nvim",
		keys = {
			{ "<leader>z", "<cmd>ZenMode<cr>", desc = "ZenMode: Toggle" },
		},
		opts = {
			window = {
				backdrop = 0.9,
				width = 0.72,
				height = 1,
				options = {
					number = false,
					relativenumber = true,
					signcolumn = "no",
					cursorline = false,
					foldcolumn = "0",
				},
			},
			plugins = {
				options = {
					enabled = true,
					ruler = false,
					showcmd = false,
					laststatus = 0,
				},
				gitsigns = { enabled = true },
				tmux = { enabled = false },
				kitty = { enabled = false, font = "+2" },
			},
		},
	},

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

			cmdline = {
				view = "cmdline_popup",
			},

			views = {
				cmdline_popup = {
					position = {
						row = math.floor(vim.o.lines * 0.90),
						col = "50%",
					},
					size = {
						width = 60,
						height = "auto",
					},
				},

				popupmenu = {
					relative = "editor",
					position = {
						row = math.floor(vim.o.lines * 0.90),
						col = "50%",
					},
					size = {
						width = 60,
						height = 10,
					},
					border = {
						style = "none",
						padding = { 1, 2 },
					},
					win_options = {
						winhighlight = "NormalFloat:NormalFloat,FloatBorder:FloatBorder",
					},
				},
			},

			routes = {
				{
					filter = {
						event = "msg_show",
						find = "written",
					},
					opts = { skip = true },
				},

				{
					filter = {
						event = "msg_showmode",
						find = "recording",
					},
					opts = { skip = true },
				},

				{
					filter = { event = "msg_show", kind = "wmsg", find = "search hit" },
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
				highlight = "IblIndent",
			},
			scope = {
				enabled = true,
				show_start = true,
				show_end = false,
				highlight = "IblScope",
			},
		},
		config = function(_, opts)
			local hooks = require("ibl.hooks")

			hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
				vim.api.nvim_set_hl(0, "IblIndent", {
					fg = "#34302C",
				})

				vim.api.nvim_set_hl(0, "IblScope", {
					fg = "#E16A2D",
					bold = false,
				})
			end)

			require("ibl").setup(opts)
		end,
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
				padding = { 1, 2, 1, 2 },
				winblend = 0,
			},
			layout = {
				spacing = 6,
				align = "center",
			},
		},
	},
}
