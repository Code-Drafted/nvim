-- directories
vim.keymap.set("n", "<leader>vd", vim.cmd.Ex)

--switching modes
vim.api.nvim_set_keymap("i", "JK", "<Esc>", { noremap = false })
vim.api.nvim_set_keymap("v", "JK", "<Esc>", { noremap = false })
