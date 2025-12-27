local f = {}

f.on_attach = function(client, bufnr)
    local opts = { noremap=true, silent=true, buffer=bufnr }

    --in file
    vim.keymap.set("n", "<leader>ldf", vim.lsp.buf.definition, opts)
    vim.keymap.set("n", "<leader>lh", vim.lsp.buf.hover, opts)
    vim.keymap.set("n", "<leader>lrn", vim.lsp.buf.rename, opts)

    --diagnostics
    vim.keymap.set("n", "]d", function()
        vim.diagnostic.goto_next({ float = true })
    end, opts)

    vim.keymap.set("n", "[d", function()
        vim.diagnostic.goto_prev({ float = true })
    end, opts)

    local function open_diagnostic_float()
        pcall(vim.diagnostic.open_float, nil, {
            focusable = false,
            border = "rounded",
            scope = "cursor",
        })
    end

    vim.keymap.set("n", "<leader>ldo", open_diagnostic_float, { desc = "diagnostics in float" })
end

f.capabilities = require("cmp_nvim_lsp").default_capabilities()
f.capabilities.textDocument.completion.completionItem.snippetSupport = true

return f
