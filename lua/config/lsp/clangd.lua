local M = {}

local clangd_cmd = {
  "clangd",
  "--background-index",
  "--clang-tidy",
  "--completion-style=detailed",
  "--header-insertion=never",
  "--header-insertion-decorators=0",
}

function M.setup(on_attach, capabilities)
  vim.lsp.config("clangd", {
    cmd = clangd_cmd,
    on_attach = on_attach,
    capabilities = capabilities,
  })

  vim.lsp.enable("clangd")
end

return M

