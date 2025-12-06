local M = {}

local clangd_flags = {
  "--background-index",
  "--clang-tidy",
  "--completion-style=detailed",
  "--header-insertion=iwyu",
  "--header-insertion-decorators",
}

local on_attach = nil
local capabilities = nil

return M
