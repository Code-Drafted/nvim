return {
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
			local base = formatting.clang_format.with({
				filetypes = vim.tbl_extend("force", formatting.clang_format.filetypes or {}, GLSL_FTS),
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
				vim.notify("clang-tidy kan niet via none-ls builtin; gebruik het via clangd LSP.", vim.log.levels.WARN)
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
}
