return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  event = { "BufReadPost", "BufNewFile" },
  config = function()
    require("nvim-treesitter.configs").setup {
      ensure_installed = { "cpp", "c", "glsl", "lua", "vim", "bash" },
      highlight = { enable = true },
      indent = { enable = true },
    }
  end,
}
