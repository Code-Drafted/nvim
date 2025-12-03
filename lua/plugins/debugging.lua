return {
    {
        "mfussenegger/nvim-dap",
        dependencies = {
            "nvim-neotest/nvim-nio",
            "rcarriga/nvim-dap-ui",
            {
                "folke/neodev.nvim",
                opts = {
                    library = { plugins = { "nvim-dap-ui" }, types = true },
                },
            },
        },

        config = function()
            local dap = require("dap")
            local dapui = require("dapui")

            dapui.setup()

            dap.listeners.before.attach.dapui_config = function() dapui.open() end
            dap.listeners.before.launch.dapui_config = function() dapui.open() end
            dap.listeners.before.event_terminated.dapui_config = function() dapui.close() end
            dap.listeners.before.event_exited.dapui_config = function() dapui.close() end

            local lldb_cmd = vim.fn.executable("lldb-vscode") == 1 and "lldb-vscode" or "lldb"
            local lldb_args = lldb_cmd == "lldb" and { "--dap" } or {}

            dap.adapters.lldb = {
                type = "executable",
                command = lldb_cmd,
                args = lldb_args,
                name = "lldb",
            }

            dap.configurations.cpp = {
                {
                    name = "🔹 Launch C++ binary",
                    type = "lldb",
                    request = "launch",
                    program = function()
                        return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
                    end,
                    cwd = "${workspaceFolder}",
                    stopOnEntry = false,
                    args = {},
                },
            }
            dap.configurations.c = dap.configurations.cpp

            local project_dap = vim.fn.getcwd() .. "/.nvim/dap.lua"
            if vim.fn.filereadable(project_dap) == 1 then
                dofile(project_dap)
            end

            vim.keymap.set("n", "<leader>dt", dap.toggle_breakpoint, { desc = "Toggle breakpoint" })
            vim.keymap.set("n", "<leader>dc", dap.continue, { desc = "Continue debugging" })
            vim.keymap.set("n", "<leader>dr", dap.repl.open, { desc = "Open REPL" })
            vim.keymap.set("n", "<leader>du", dapui.toggle, { desc = "Toggle DAP UI" })
        end,
    },
}
