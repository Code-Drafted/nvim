local functions = require("config.lsp.functions")

-- lua_ls
local lua_ls = require("config.lsp.lua_ls")
lua_ls.on_attach = functions.on_attach
lua_ls.capabilities = functions.capabilities
vim.lsp.config.lua_ls = lua_ls
vim.lsp.enable("lua_ls")

local clangd = require("config.lsp.clangd")
clangd.setup(functions.on_attach, functions.capabilities)
