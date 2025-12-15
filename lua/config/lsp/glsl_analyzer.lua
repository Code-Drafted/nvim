return {
	cmd = { "glsl_analyzer" },
	filetypes = { "glsl", "vert", "frag", "geom", "comp", "tesc", "tese" },

	root_markers = {
		".git",
		"compile_commands.json",
		".clang-format",
	},

	on_attach = nil,
	capabilities = nil,

	settings = {},
}
