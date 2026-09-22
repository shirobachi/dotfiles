local add, later = MiniDeps.add, MiniDeps.later

later(function()
	add("folke/which-key.nvim")
	local wk = require("which-key")
	wk.setup({
		win = {
			width = 0.4,
			col = math.huge,
			no_overlap = false,
		},
	})

	wk.add({
		{ "<leader>g", group = "Git" },

		{ "<leader>m", group = "Markdown" },
		{ "<leader>p", group = "Pick / Paste" },
		{ "<leader>r", group = "Rename / Restart" },
		{ "<leader>c", group = "Whitespace" },
		{ "<leader>s", group = "Split / Search" },
		{ "<leader>e", group = "Explorer" },
		{ "<leader>t", group = "Tabs" },
		{ "<leader>f", group = "Format / File" },
		{ "<leader>v", group = "Code Actions" },
		{ "<leader>w", group = "Session" },
		{ "<leader>l", group = "LSP" },
	})
end)
