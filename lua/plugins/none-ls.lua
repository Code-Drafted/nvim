return {
	"nvimtools/none-ls.nvim",
	config = function()
		local null_ls = require("null-ls")
		local formatting = null_ls.builtins.formatting
		local diagnostics = null_ls.builtins.diagnostics
		local utils = require("null-ls.utils")

		local root = vim.fn.getcwd()
		local has_selene = vim.fn.filereadable(root .. "/selene.toml") == 1
			or vim.fn.filereadable(root .. "/selene.yml") == 1

		local has_clang_tidy = vim.fn.filereadable(root .. "/.clang-tidy") == 1

		local sources = {
			formatting.stylua,
			formatting.clang_format,
		}

		if has_selene then
			table.insert(sources, diagnostics.selene)
		end

		if has_clang_tidy then
			vim.notify("clang-tidy kan niet via none-ls builtin; gebruik het via clangd LSP.", vim.log.levels.WARN)
		end

		null_ls.setup({
			sources = sources,
			root_dir = utils.root_pattern(".clang-format", "_clang-format", ".git", "compile_commands.json"),
		})

		vim.keymap.set("n", "<leader>gf", function()
			vim.lsp.buf.format({
				filter = function(client)
					return client.name == "null-ls"
				end,
				timeout_ms = 3000,
			})
		end, { desc = "Format with none-ls" })
	end,
}
