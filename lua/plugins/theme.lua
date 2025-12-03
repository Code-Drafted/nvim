local themes = {
    tokyonight = {
        path = "folke/tokyonight.nvim",
        schemes = {
            "tokyonight",
            "tokyonight-storm",
            "tokyonight-night",
            "tokyonight-day",
        },
    },
    catppuccin = {
        path = "catppuccin/nvim",
        schemes = {
            "catppuccin-latte",
            "catppuccin-frappe",
            "catppuccin-macchiato",
            "catppuccin-mocha",
        },
    },
    kanagawa = {
        path = "rebelot/kanagawa.nvim",
        schemes = {
            "kanagawa-wave",
            "kanagawa-dragon",
            "kanagawa-lotus",
        },
    },
    gruvbox = {
        path = "ellisonleao/gruvbox.nvim",
        schemes = {
            "gruvbox-dark",
            "gruvbox-light",
        },
    },
    everforest = {
        path = "neanias/everforest-nvim",
        schemes = {
            "everforest-dark",
            "everforest-light",
        },
    },
    rose_pine = {
        path = "rose-pine/neovim",
        schemes = {
            "rose-pine",
            "rose-pine-moon",
            "rose-pine-dawn",
        },
    },
}



local function setTransparent(transparent)
    if not transparent then return end

    vim.cmd([[
      highlight Normal guibg=NONE ctermbg=NONE
      highlight NormalNC guibg=NONE ctermbg=NONE
      highlight EndOfBuffer guibg=NONE ctermbg=NONE
      highlight SignColumn guibg=NONE ctermbg=NONE
      highlight VertSplit guibg=NONE ctermbg=NONE
      ]])
end

local function setTheme(theme, index, transparent)
    return {
        theme.path,
        priority = 1000,
        config = function()
            vim.cmd.colorscheme(theme["schemes"][index])

            setTransparent(transparent)
        end,
    }
end

return setTheme(themes.kanagawa, 1, true)
