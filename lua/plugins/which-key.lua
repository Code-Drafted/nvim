return {
        "folke/which-key.nvim",
        event = "VeryLazy",
        config = function()
            require("which-key").setup({
                plugins = {
                    spelling = { enabled = true },
                },
                win = {
                    border = "single",
                    padding = { 1, 2, 1, 2 },
                },
                layout = {
                    spacing = 6,
                    align = "center",
                },
            })
        end,
    }
