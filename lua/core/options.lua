-- line numbers
vim.opt.number = true
vim.opt.relativenumber = true

-- indenting
vim.opt.tabstop = 4
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.smartindent = true

vim.opt.wrap = false

-- crash recovery
vim.opt.swapfile = true

-- search
vim.opt.incsearch = true

-- gui
vim.opt.termguicolors = true

-- scrolling
vim.opt.scrolloff = 15
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

-- update
vim.opt.updatetime = 50

-- cmp highlight groups
vim.api.nvim_set_hl(0, "CmpItemAbbr", { link = "Normal" })
vim.api.nvim_set_hl(0, "CmpItemAbbrMatch", { link = "Identifier" })
vim.api.nvim_set_hl(0, "CmpItemAbbrMatchFuzzy", { link = "Identifier" })
vim.api.nvim_set_hl(0, "CmpItemMenu", { link = "Comment" })
vim.api.nvim_set_hl(0, "CmpItemKind", { link = "Type" })
vim.api.nvim_set_hl(0, "CmpItemKindFunction", { link = "Function" })
vim.api.nvim_set_hl(0, "CmpItemKindVariable", { link = "Identifier" })
vim.api.nvim_set_hl(0, "CmpItemKindSnippet", { link = "Special" })

