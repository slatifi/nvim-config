return {
	settings = {
		texlab = {
			auxDirectory = "build",
			build = {
				executable = "latexmk",
				args = {
					"-pdf",
					"-lualatex",
					"-interaction=nonstopmode",
					"-synctex=1",
					"-outdir=build",
					"-shell-escape",
					"%f",
				},
				onSave = true,
				forwardSearchAfter = true,
			},
			forwardSearch = {
				executable = "/Applications/Skim.app/Contents/SharedSupport/displayline",
				args = { "-g", "%l", "%p", "%f" },
			},
			diagnostics = {
				ignoredPatterns = {
					"Overfull \\\\[vh]box",
					"Underfull \\\\[vh]box",
				},
			},
		},
	},
}
