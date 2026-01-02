local M = {}

local colors = {
	bg = "#1B1B1B",
	fg = "#D0C8BE",

	gutter = "#24211C",
	border = "#2E2A25",
	dim = "#9C9489",

	comment = "#6F685E",
	string = "#7E9E6A",
	keyword = "#D08A3F",
	func = "#E16A2D",
	type = "#8FB3A2",
	constant = "#8F3A3A",
	number = "#AEBF90",

	ident = "#B39B6A",

	visual = "#3B3028",
	error = "#A14C4C",
}

local function setTransparent(transparent)
	if not transparent then
		return
	end
	vim.cmd([[
    highlight Normal guibg=NONE ctermbg=NONE
    highlight NormalNC guibg=NONE ctermbg=NONE
    highlight EndOfBuffer guibg=NONE ctermbg=NONE
    highlight SignColumn guibg=NONE ctermbg=NONE
    highlight VertSplit guibg=NONE ctermbg=NONE
  ]])
end

function M.colorscheme()
	vim.cmd("highlight clear")
	vim.cmd("syntax reset")

	vim.o.background = "dark"
	vim.g.colors_name = "mikails-Theme"

	local set = vim.api.nvim_set_hl

	set(0, "Normal", { fg = colors.fg, bg = colors.bg })
	set(0, "NormalNC", { fg = colors.fg, bg = colors.bg })
	set(0, "CursorLine", { bg = colors.cursor })
	set(0, "Visual", { bg = colors.visual })
	set(0, "LineNr", { fg = colors.lineNr })
	set(0, "CursorLineNr", { fg = colors.fg, bold = true })
	set(0, "VertSplit", { fg = "#2F2F2F", bg = colors.bg })
	set(0, "SignColumn", { bg = colors.bg })
	set(0, "EndOfBuffer", { fg = "#2A2A2A" })

	set(0, "Comment", { fg = colors.comment, italic = true })
	set(0, "String", { fg = colors.string })
	set(0, "Character", { fg = colors.string })
	set(0, "Number", { fg = colors.number })
	set(0, "Boolean", { fg = colors.constant })
	set(0, "Constant", { fg = colors.constant })

	set(0, "Identifier", { fg = colors.ident })
	set(0, "Function", { fg = colors.func })

	set(0, "Statement", { fg = colors.keyword })
	set(0, "Keyword", { fg = colors.keyword })
	set(0, "Operator", { fg = colors.fg })

	set(0, "Type", { fg = colors.type })
	set(0, "Special", { fg = colors.constant })

	set(0, "Error", { fg = colors.error, bold = true })

	set(0, "@comment", { link = "Comment" })
	set(0, "@string", { link = "String" })
	set(0, "@function", { link = "Function" })
	set(0, "@keyword", { link = "Keyword" })
	set(0, "@type", { link = "Type" })
	set(0, "@constant", { link = "Constant" })
	set(0, "@number", { link = "Number" })
	set(0, "@variable", { link = "Identifier" })

	-- Statusline / splits / tabs
	set(0, "StatusLine", { fg = colors.fg, bg = colors.gutter })
	set(0, "StatusLineNC", { fg = colors.dim, bg = colors.gutter })
	set(0, "WinSeparator", { fg = colors.border, bg = colors.bg })
	set(0, "TabLine", { fg = colors.dim, bg = colors.gutter })
	set(0, "TabLineSel", { fg = colors.fg, bg = colors.bg, bold = true })
	set(0, "TabLineFill", { bg = colors.gutter })

	-- Popups / completion menu
	set(0, "Pmenu", { fg = colors.fg, bg = colors.gutter })
	set(0, "PmenuSel", { fg = colors.bg, bg = colors.keyword, bold = true })
	set(0, "PmenuSbar", { bg = colors.gutter })
	set(0, "PmenuThumb", { bg = colors.border })

	-- Floats (ook voor LSP windows)
	set(0, "NormalFloat", { fg = colors.fg, bg = colors.gutter })
	set(0, "FloatBorder", { fg = colors.border, bg = colors.gutter })

	-- Telescope (maakt ‘m meteen minder wit en minder blauw)
	set(0, "TelescopeNormal", { fg = colors.fg, bg = colors.gutter })
	set(0, "TelescopeBorder", { fg = colors.border, bg = colors.gutter })
	set(0, "TelescopePromptNormal", { fg = colors.fg, bg = colors.gutter })
	set(0, "TelescopePromptBorder", { fg = colors.border, bg = colors.gutter })
	set(0, "TelescopeSelection", { bg = colors.visual })
	set(0, "TelescopeMatching", { fg = colors.keyword, bold = true })
	set(0, "TelescopePromptTitle", { fg = colors.bg, bg = colors.keyword, bold = true })
	set(0, "TelescopeResultsTitle", { fg = colors.bg, bg = colors.border, bold = true })
	set(0, "TelescopePreviewTitle", { fg = colors.bg, bg = colors.func, bold = true })

	-- cmp highlight groups
	vim.api.nvim_set_hl(0, "CmpItemAbbr", { link = "Normal" })
	vim.api.nvim_set_hl(0, "CmpItemAbbrMatch", { link = "Identifier" })
	vim.api.nvim_set_hl(0, "CmpItemAbbrMatchFuzzy", { link = "Identifier" })
	vim.api.nvim_set_hl(0, "CmpItemMenu", { link = "Comment" })
	vim.api.nvim_set_hl(0, "CmpItemKind", { link = "Type" })
	vim.api.nvim_set_hl(0, "CmpItemKindFunction", { link = "Function" })
	vim.api.nvim_set_hl(0, "CmpItemKindVariable", { link = "Identifier" })
	vim.api.nvim_set_hl(0, "CmpItemKindSnippet", { link = "Special" })

	-- Netrw / titles / directories
	set(0, "Directory", { fg = colors.func })
	set(0, "Title", { fg = colors.func, bold = true })

	setTransparent(false)
end

return M
