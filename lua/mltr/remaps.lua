-- directories
vim.keymap.set("n", "<leader>pf", vim.cmd.Ex)

--tabs
vim.keymap.set('n', 'tn', ':tabnew<CR>', { noremap = true, silent = true })

--switching modes
vim.api.nvim_set_keymap("i", "JK", "<Esc>", { noremap = false })
vim.api.nvim_set_keymap("v", "JK", "<Esc>", { noremap = false })
