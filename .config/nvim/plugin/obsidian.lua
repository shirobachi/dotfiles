local add, later = MiniDeps.add, MiniDeps.later

later(function()
	add("nvim-lua/plenary.nvim") -- lib
	add("obsidian-nvim/obsidian.nvim")

	require("obsidian").setup({
		legacy_commands = false,
		workspaces = {
			{
				name = "personal",
				path = "~/repo/obsidian",
			},
		},
		daily_notes = {
			folder = "Daily",
			date_format = "%Y-%m-%d",
		},
		completion = {
			min_chars = 2,
		},
		picker = {
			name = "mini.pick",
		},
	})
end)
