return {
  "ahmedkhalf/project.nvim",
  event = "VeryLazy",
  opts = {
    manual_mode = false,
    detection_methods = { "lsp", "pattern" },
    patterns = {
      ".nvim", ".git", "Makefile", "package.json", "compile_commands.json", "CMakeLists.txt",
    },
    ignore_lsp = {},
    exclude_dirs = {
      "~/.cargo/*",
      "~/.local/*",
      "~/.config/*",
    },
    show_hidden = true,
    silent_chdir = true,
    datapath = vim.fn.stdpath("data"),
  },
  config = function(_, opts)
    require("project_nvim").setup(opts)
  end,
}
