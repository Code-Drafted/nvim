return {
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      {
        "nvim-telescope/telescope-ui-select.nvim",
        config = function()
          require("telescope").setup({
            extensions = {
              ["ui-select"] = require("telescope.themes").get_dropdown(),
            },
          })
          require("telescope").load_extension("ui-select")
        end,
      },
    },
    config = function()
      local builtin = require("telescope.builtin")

      vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Find help" })
      vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Find buffers" })
      vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Find files" })
      vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Find grep" })
      vim.keymap.set("n", "<leader>cm", builtin.commands, { desc = "Find commands" })

      -- Gebruik native LSP code actions
      vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, {
        desc = "LSP Code Actions",
      })
    end,
  },
}
