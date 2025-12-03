local f = {}

f.on_attach = function(client, bufnr)
    local opts = { noremap=true, silent=true, buffer=bufnr }

    --in file
    vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, opts)
    vim.keymap.set("n", "<leader>h", vim.lsp.buf.hover, opts)
    vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)

    --diagnostics
    vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
    vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
    vim.keymap.del("n", "do")
    vim.keymap.set("n", "do", function()
        vim.diagnostic.open_float()
    end, { noremap = true, silent = true })

end

f.capabilities = require("cmp_nvim_lsp").default_capabilities()

return f
