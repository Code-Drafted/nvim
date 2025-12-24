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
				insert = "<C-g>s",
				insert_line = "<C-g>S",
				normal = "ys",
				normal_cur = "yss",
				normal_line = "yS",
				normal_cur_line = "ySS",
				visual = "S",
				visual_line = "gS",
				delete = "ds",
				change = "cs",
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
		"nvimtools/none-ls.nvim",
		config = function()
			local null_ls = require("null-ls")
			local formatting = null_ls.builtins.formatting
			local diagnostics = null_ls.builtins.diagnostics
			local utils = require("null-ls.utils")

			local GLSL_FTS = { "glsl", "vert", "frag", "geom", "comp", "tesc", "tese" }

			local function project_root()
				return vim.fn.getcwd()
			end

			local function has_file(root, filenames)
				for _, name in ipairs(filenames) do
					if vim.fn.filereadable(root .. "/" .. name) == 1 then
						return true
					end
				end
				return false
			end

			local function has_selene(root)
				return has_file(root, { "selene.toml", "selene.yml" })
			end

			local function has_clang_format(root)
				return has_file(root, { ".clang-format", "_clang-format" })
			end

			local function has_clang_tidy(root)
				return has_file(root, { ".clang-tidy" })
			end

			local function clang_format_source(root)
				local cf_fts = vim.deepcopy(formatting.clang_format.filetypes or {})
				vim.list_extend(cf_fts, GLSL_FTS)

				local base = formatting.clang_format.with({
					filetypes = cf_fts,
					extra_args = { "--assume-filename=shader.glsl" },
				})

				if has_clang_format(root) then
					return base.with({
						extra_args = { "--style=file", "--assume-filename=shader.glsl" },
					})
				end

				return base
			end

			local function glsl_lint_source()
				return diagnostics.glslc.with({
					filetypes = { "glsl", "vert", "frag", "geom", "comp", "tesc", "tese" },
					extra_args = {
						"--target-env=opengl",
						"-std=330core",
						"-c",

						"-fauto-map-locations",
						"-fauto-bind-uniforms",
					},
				})
			end

			local function build_sources(root)
				local sources = {
					formatting.stylua,
					clang_format_source(root),

					glsl_lint_source(),
				}

				if has_selene(root) then
					table.insert(sources, diagnostics.selene)
				end

				if has_clang_tidy(root) then
					vim.notify(
						"clang-tidy kan niet via none-ls builtin; gebruik het via clangd LSP.",
						vim.log.levels.WARN
					)
				end

				return sources
			end

			local function setup_format_keymap()
				vim.keymap.set("n", "<leader>gf", function()
					vim.lsp.buf.format({
						filter = function(client)
							return client.name == "null-ls"
						end,
						timeout_ms = 3000,
					})
				end, { desc = "Format with none-ls" })
			end

			local root = project_root()

			null_ls.setup({
				sources = build_sources(root),
				root_dir = utils.root_pattern(".clang-format", "_clang-format", ".git", "compile_commands.json"),
			})

			setup_format_keymap()
		end,
	},
	{
		"mbbill/undotree",
		keys = {
			{ "<leader>u", "<cmd>UndotreeToggle<cr>", desc = "Undotree: Toggle" },
		},
		config = function()
			vim.g.undotree_WindowLayout = 2
			vim.g.undotree_ShortIndicators = 1
			vim.g.undotree_SetFocusWhenToggle = 1
		end,
	},
	{
		"ThePrimeagen/refactoring.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-treesitter/nvim-treesitter",
		},
		keys = {
			{
				"<leader>rr",
				function()
					require("refactoring").select_refactor()
				end,
				mode = { "n", "v" },
				desc = "Refactor: Select",
			},
			{
				"<leader>re",
				function()
					require("refactoring").refactor("Extract Function")
				end,
				mode = "v",
				desc = "Refactor: Extract Function",
			},
			{
				"<leader>rf",
				function()
					require("refactoring").refactor("Extract Function To File")
				end,
				mode = "v",
				desc = "Refactor: Extract Function To File",
			},
			{
				"<leader>rv",
				function()
					require("refactoring").refactor("Extract Variable")
				end,
				mode = "v",
				desc = "Refactor: Extract Variable",
			},
			{
				"<leader>ri",
				function()
					require("refactoring").refactor("Inline Variable")
				end,
				mode = { "n", "v" },
				desc = "Refactor: Inline Variable",
			},
			{
				"<leader>rb",
				function()
					require("refactoring").refactor("Extract Block")
				end,
				mode = "n",
				desc = "Refactor: Extract Block",
			},
			{
				"<leader>rB",
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

			vim.keymap.set("v", "<leader>rp", function()
				require("refactoring").debug.print_var()
			end, { desc = "Refactor: Debug Print Var" })

			vim.keymap.set("n", "<leader>rP", function()
				require("refactoring").debug.printf({ below = false })
			end, { desc = "Refactor: Debug Printf" })

			vim.keymap.set("n", "<leader>rc", function()
				require("refactoring").debug.cleanup({})
			end, { desc = "Refactor: Debug Cleanup" })
		end,
	},
	{
		"monaqa/dial.nvim",
		keys = {
			{
				"<C-a>",
				function()
					require("dial.map").manipulate("increment", "normal")
				end,
				mode = "n",
				desc = "Dial: Increment",
			},
			{
				"<C-x>",
				function()
					require("dial.map").manipulate("decrement", "normal")
				end,
				mode = "n",
				desc = "Dial: Decrement",
			},
			{
				"g<C-a>",
				function()
					require("dial.map").manipulate("increment", "gnormal")
				end,
				mode = "n",
				desc = "Dial: Increment (g)",
			},
			{
				"g<C-x>",
				function()
					require("dial.map").manipulate("decrement", "gnormal")
				end,
				mode = "n",
				desc = "Dial: Decrement (g)",
			},

			{
				"<C-a>",
				function()
					require("dial.map").manipulate("increment", "visual")
				end,
				mode = "v",
				desc = "Dial: Increment (visual)",
			},
			{
				"<C-x>",
				function()
					require("dial.map").manipulate("decrement", "visual")
				end,
				mode = "v",
				desc = "Dial: Decrement (visual)",
			},
			{
				"g<C-a>",
				function()
					require("dial.map").manipulate("increment", "gvisual")
				end,
				mode = "v",
				desc = "Dial: Increment (visual g)",
			},
			{
				"g<C-x>",
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
}
