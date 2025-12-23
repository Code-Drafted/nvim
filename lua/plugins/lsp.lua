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
}
