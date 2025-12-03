local util = require("lspconfig.util")

local caps = require("cmp_nvim_lsp").default_capabilities()
caps.textDocument.completion.completionItem.snippetSupport = true

return {
  cmd = {
    "C:/msys64/mingw64/bin/clangd.exe",

    "header-insertion=never",
    "--pch-storage=memory",
    "--clang-tidy",
    "--fallback-style=Google",
    "--query-driver=C:/msys64/ucrt64/bin/g++.exe;C:/msys64/mingw64/bin/g++.exe",
    "--target=x86_64-w64-windows-gnu",
  },

  filetypes = { "c", "cpp", "objc", "objcpp" },

  root_dir = function(fname)
    return util.root_pattern("compile_commands.json", ".git")(fname)
      or util.path.dirname(fname)
  end,

  on_attach = nil,
  capabilities = caps,
}

