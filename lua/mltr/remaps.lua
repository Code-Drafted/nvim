-- directories
vim.keymap.set("n", "<leader>vd", vim.cmd.Ex)

--switching modes
vim.api.nvim_set_keymap("i", "<C-c>", "<Esc>", { noremap = false })
vim.api.nvim_set_keymap("v", "<C-c>", "<Esc>", { noremap = false })

-- move lines
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("n", "J", "mzJ`z")

-- page jumping
vim.keymap.set("n", "C-d", "<C-d>zz")
vim.keymap.set("n", "C-u", "<C-u>zz")

vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- copy, paste and delete
vim.keymap.set("x", "<leader>p", '"_dP')

vim.keymap.set("n", "<leader>y", '"+y')
vim.keymap.set("n", "<leader>Y", '"+Y')
vim.keymap.set("v", "<leader>y", '"+y')

vim.keymap.set("n", "<leaderd", "\"_d")
vim.keymap.set("v", "<leaderd", "\"_d")

-- quickfix list
vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")

vim.keymap.set("n", "<leader>s", ":%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<left><left><left>")
