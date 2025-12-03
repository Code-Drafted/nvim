return {
  "nvim-tree/nvim-tree.lua",
  dependencies = {
        "nvim-tree/nvim-web-devicons",

    },
  cmd = "NvimTreeToggle",
  keys = {
    {"<leader>fe", function() vim.cmd("NvimTreeToggle") end, desc = "Toggle tree"}
  },
  config = function()
    require("nvim-tree").setup({
            view = {
                side = "right",
            }
        })
  end,
}
