return {
  "Civitasv/cmake-tools.nvim",
  config = function()
    require("cmake-tools").setup({
      cmake_command = "cmake",
      build_dir = "build",
      configure_args = { "-DCMAKE_EXPORT_COMPILE_COMMANDS=1" },
      build_args = {},
      on_build_success = function()
        vim.notify(" Build succeeded!", vim.log.levels.INFO)
      end,
    })
  end,
}
