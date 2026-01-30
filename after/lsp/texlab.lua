return {
	settings = {
		texlab = {
			auxDirectory = "build",
			build = {
				executable = "latexmk",
				args = {
					"-pdf",
					"-interaction=nonstopmode",
					"-synctex=1",
					"-outdir=build",
					"%f",
				},
				onSave = true,
				forwardSearchAfter = true,
			},
			forwardSearch = {
				executable = "/Applications/Skim.app/Contents/SharedSupport/displayline",
				args = { "-g", "%l", "%p", "%f" },
			},
		},
	},
}
