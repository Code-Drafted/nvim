return {
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		event = { "BufReadPost", "BufNewFile" },
		dependencies = {
			"HiPhish/rainbow-delimiters.nvim",
		},
		config = function()
			require("nvim-treesitter.configs").setup({
				ensure_installed = { "cpp", "c", "glsl", "lua", "vim", "bash" },
				highlight = { enable = true },
				indent = { enable = true },
			})

			local rainbow_delimiters = require("rainbow-delimiters")
			vim.g.rainbow_delimiters = {
				strategy = {
					[""] = rainbow_delimiters.strategy.global,
				},
				query = {
					[""] = "rainbow-delimiters",
				},
				highlight = {
					"RainbowDelimiterYellow",
					"RainbowDelimiterOrange",
					"RainbowDelimiterCyan",
					"RainbowDelimiterBlue",
					"RainbowDelimiterViolet",
				},
			}
		end,
	},

	{ "nvim-treesitter/playground" },

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
		event = "VeryLazy",
		opts = {
			padding = true,
			sticky = true,
			ignore = "^$",
			mappings = {
				basic = true, -- gcc, gc
				extra = true, -- gco, gcO, gcA
			},
		},
	},

	{
		"kylechui/nvim-surround",
		event = "VeryLazy",
		opts = {
			keymaps = {
				insert = "<C-s>i",
				insert_line = "<C-s>l",
				normal = "<C-s>nn",
				normal_cur = "<C-s>nc",
				normal_line = "<C-s>nl",
				normal_cur_line = "<C-s>ncl",
				visual = "<C-s>vv",
				visual_line = "<C-s>vl",
				delete = "<C-s>d",
				change = "<C-s>c",
			},
		},
	},

	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		opts = {
			check_ts = true,
			fast_wrap = {
				map = "<M-e>",
				chars = { "{", "[", "(", '"', "'" },
				pattern = "[%'%\"%)%>%]%)%}%,]",
				offset = 0,
				end_key = "$",
				keys = "qwertyuiopzxcvbnmasdfghjkl",
				check_comma = true,
				highlight = "Search",
				highlight_grey = "Comment",
			},
		},
	},

	{
		"ThePrimeagen/refactoring.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-treesitter/nvim-treesitter",
		},
		keys = {
			{
				"<leader>rs",
				function()
					require("refactoring").select_refactor()
				end,
				mode = { "n", "v" },
				desc = "Refactor: Select",
			},
			{
				"<leader>ref",
				function()
					require("refactoring").refactor("Extract Function")
				end,
				mode = "v",
				desc = "Refactor: Extract Function",
			},
			{
				"<leader>rff",
				function()
					require("refactoring").refactor("Extract Function To File")
				end,
				mode = "v",
				desc = "Refactor: Extract Function To File",
			},
			{
				"<leader>rev",
				function()
					require("refactoring").refactor("Extract Variable")
				end,
				mode = "v",
				desc = "Refactor: Extract Variable",
			},
			{
				"<leader>riv",
				function()
					require("refactoring").refactor("Inline Variable")
				end,
				mode = { "n", "v" },
				desc = "Refactor: Inline Variable",
			},
			{
				"<leader>reb",
				function()
					require("refactoring").refactor("Extract Block")
				end,
				mode = "n",
				desc = "Refactor: Extract Block",
			},
			{
				"<leader>rbf",
				function()
					require("refactoring").refactor("Extract Block To File")
				end,
				mode = "n",
				desc = "Refactor: Extract Block To File",
			},
		},
		config = function()
			require("refactoring").setup({
				prompt_func_return_type = {
					go = true,
					java = true,
					cpp = true,
					c = true,
					h = true,
					hpp = true,
					cxx = true,
				},
				prompt_func_param_type = {
					go = true,
					java = true,
					cpp = true,
					c = true,
					h = true,
					hpp = true,
					cxx = true,
				},
			})
		end,
	},
	{
		"monaqa/dial.nvim",
		keys = {
			{
				"<leader>ji",
				function()
					require("dial.map").manipulate("increment", "normal")
				end,
				mode = "n",
				desc = "Dial: Increment",
			},
			{
				"<leader>jd",
				function()
					require("dial.map").manipulate("decrement", "normal")
				end,
				mode = "n",
				desc = "Dial: Decrement",
			},
			{
				"<leader>jgi",
				function()
					require("dial.map").manipulate("increment", "gnormal")
				end,
				mode = "n",
				desc = "Dial: Increment (g)",
			},
			{
				"<leader>jgd",
				function()
					require("dial.map").manipulate("decrement", "gnormal")
				end,
				mode = "n",
				desc = "Dial: Decrement (g)",
			},

			{
				"<leader>jvi",
				function()
					require("dial.map").manipulate("increment", "visual")
				end,
				mode = "v",
				desc = "Dial: Increment (visual)",
			},
			{
				"<leader>jvd",
				function()
					require("dial.map").manipulate("decrement", "visual")
				end,
				mode = "v",
				desc = "Dial: Decrement (visual)",
			},
			{
				"<leader>jgvi",
				function()
					require("dial.map").manipulate("increment", "gvisual")
				end,
				mode = "v",
				desc = "Dial: Increment (visual g)",
			},
			{
				"<leader>jgvd",
				function()
					require("dial.map").manipulate("decrement", "gvisual")
				end,
				mode = "v",
				desc = "Dial: Decrement (visual g)",
			},
		},
		config = function()
			local augend = require("dial.augend")
			require("dial.config").augends:register_group({
				default = {
					augend.integer.alias.decimal,
					augend.integer.alias.hex,
					augend.date.alias["%Y-%m-%d"],
					augend.date.alias["%d/%m/%Y"],
					augend.constant.alias.bool,
					augend.constant.new({ elements = { "and", "or" }, word = true, cyclic = true }),
					augend.constant.new({ elements = { "&&", "||" }, word = false, cyclic = true }),
					augend.constant.new({ elements = { "on", "off" }, word = true, cyclic = true }),
					augend.constant.new({ elements = { "enable", "disable" }, word = true, cyclic = true }),
				},
			})
		end,
	},
	{
		"folke/flash.nvim",
		event = "VeryLazy",
		opts = {
			modes = {
				search = { enabled = true },
				char = { enabled = true },
			},
		},
		keys = {
			{
				"<leader>kf",
				function()
					require("flash").jump()
				end,
				desc = "Flash: Jump",
			},
			{
				"<leader>kd",
				function()
					require("flash").treesitter()
				end,
				desc = "Flash: Treesitter jump",
			},
			{
				"<leader>kr",
				function()
					require("flash").remote()
				end,
				mode = "o",
				desc = "Flash: Remote (operator)",
			},
			{
				"<leader>kg",
				function()
					require("flash").treesitter_search()
				end,
				desc = "Flash: TS Search",
			},
		},
	},
	{
		"gbprod/yanky.nvim",
		dependencies = {
			"nvim-telescope/telescope.nvim",
		},
		config = function()
			require("yanky").setup({
				highlight = {
					timer = 200,
				},
				preserve_cursor_position = {
					enabled = true,
				},
			})

			require("telescope").load_extension("yank_history")

			vim.keymap.set({ "n", "x" }, "y", "<Plug>(YankyYank)")
			vim.keymap.set({ "n", "x" }, "p", "<Plug>(YankyPutAfter)")
			vim.keymap.set({ "n", "x" }, "P", "<Plug>(YankyPutBefore)")
			vim.keymap.set("n", "gp", "<Plug>(YankyGPutAfter)")
			vim.keymap.set("n", "gP", "<Plug>(YankyGPutBefore)")

			vim.keymap.set("n", "<c-y>f", "<Plug>(YankyCycleForward)")
			vim.keymap.set("n", "<c-y>b", "<Plug>(YankyCycleBackward)")
			vim.keymap.set("n", "<c-y>h", "<cmd>Telescope yank_history<cr>")
		end,
	},

	{
		"mbbill/undotree",

		keys = {
			{ "<leader>u", "<cmd>UndotreeToggle<CR>", desc = "Undotree: Toggle" },
		},

		config = function()
			vim.opt.undofile = true
			vim.g.undotree_SetFocusWhenToggle = 1
		end,
	},
	{
		"chentoast/marks.nvim",
		event = "VeryLazy",
		config = function()
			require("marks").setup({
				sign_priority = 10,
				builtin_marks = {},
				cyclic = true,
				default_mappings = false,

				force_write_shada = false,

				excluded_buftypes = { "nofile", "prompt", "terminal" },
				excluded_filetypes = { "TelescopePrompt", "lazy", "mason", "help" },
			})

			vim.keymap.set("n", "<leader>mt", "<cmd>MarksToggleSigns<CR>", { desc = "Marks: toggle signs" })

			vim.keymap.set("n", "<leader>ml", "<cmd>MarksListBuf<CR>", { desc = "Marks: list buffer" })
			vim.keymap.set("n", "<leader>mg", "<cmd>MarksListGlobal<CR>", { desc = "Marks: list global" })

			vim.keymap.set("n", "<leader>mv", "<Plug>(Marks-preview)", { desc = "Marks: preview (float)" })
			vim.keymap.set("n", "<leader>mc", "<Plug>(Marks-deletebuf)", { desc = "Marks: clear buffer marks" })

			vim.keymap.set("n", "]m", "<Plug>(Marks-next)", { desc = "Marks: next" })
			vim.keymap.set("n", "[m", "<Plug>(Marks-prev)", { desc = "Marks: prev" })
		end,
	},
}
