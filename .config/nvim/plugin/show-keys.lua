local add, later = MiniDeps.add, MiniDeps.later

later(function()
	add("nvzone/showkeys")
	require("showkeys").setup({
		position = "bottom-right",
		maxkeys = 5,
		show_count = true,
		winopts = {
			focusable = false,
			relative = "editor",
			style = "minimal",
			border = "single",
		},
	})

	vim.keymap.set("n", "<leader>sk", function()
		require("showkeys").toggle()
	end, { desc = "Toggle Showkeys" })
end)
