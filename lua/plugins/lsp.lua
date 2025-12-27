return {
	{
		"williamboman/mason.nvim",
		opts = {
			ui = {
				icons = {
					package_installed = "v",
					package_pending = "o",
					package_uninstalled = "x",
				},
			},
		},

		build = ":MasonUpdate",
		config = function()
			require("mason").setup()
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		dependencies = {
			"williamboman/mason.nvim",
			"neovim/nvim-lspconfig",
		},
		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = { "lua_ls" },
				automatic_installation = true,
			})
		end,
	},
	{
		"neovim/nvim-lspconfig",
	},
	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-nvim-lsp-signature-help",
			"L3MON4D3/LuaSnip",
			"saadparwaiz1/cmp_luasnip",
			"rafamadriz/friendly-snippets",
		},
	},
	{
		"nvimtools/none-ls.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			local null_ls = require("null-ls")
			local formatting = null_ls.builtins.formatting
			local diagnostics = null_ls.builtins.diagnostics
			local utils = require("null-ls.utils")

			-- GLSL filetypes
			local GLSL_FTS = { "glsl", "vert", "frag", "geom", "comp", "tesc", "tese" }

			-- clang-format uitbreiden met GLSL
			local clang_fts = vim.deepcopy(formatting.clang_format.filetypes or {})
			vim.list_extend(clang_fts, GLSL_FTS)

			local function root_has(params, files)
				local root = params and params.root
				if not root or root == "" then
					return false
				end
				for _, f in ipairs(files) do
					local p = root .. "/" .. f
					if vim.uv.fs_stat(p) then
						return true
					end
				end
				return false
			end

			null_ls.setup({
				debug = false,

				root_dir = utils.root_pattern(
					".git",
					"compile_commands.json",
					".clang-format",
					"_clang-format",
					"selene.toml",
					"selene.yml"
				),

				sources = {
					-- Lua
					formatting.stylua,

					diagnostics.selene.with({
						condition = function(params)
							return root_has(params, { "selene.toml", "selene.yml" })
						end,
					}),

					-- C / C++ / GLSL
					formatting.clang_format.with({
						filetypes = clang_fts,
						extra_args = function(params)
							local args = { "--assume-filename=shader.glsl" }

							if root_has(params, { ".clang-format", "_clang-format" }) then
								table.insert(args, 1, "--style=file")
							end

							return args
						end,
					}),

					diagnostics.glslc.with({
						filetypes = GLSL_FTS,
						extra_args = {
							"--target-env=opengl",
							"-std=330core",
							"-c",
							"-fauto-map-locations",
							"-fauto-bind-uniforms",
						},
					}),
				},
			})

			vim.keymap.set("n", "<leader>lf", function()
				vim.lsp.buf.format({
					filter = function(client)
						return client.name == "null-ls" or client.name == "none-ls"
					end,
					timeout_ms = 10000,
				})
			end, { desc = "Format buffer (none-ls)" })
		end,
	},
}
