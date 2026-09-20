local add, now = MiniDeps.add, MiniDeps.now

now(function()
	add("YousefHadder/markdown-plus.nvim")

	add("jghauser/follow-md-links.nvim")
	vim.keymap.set("n", "gf", "<cmd>FollowLink<CR>", { desc = "Follow Markdown Link" })

	add({
		source = "delphinus/md-render.nvim",
		depends = {
			"nvim-tree/nvim-web-devicons",
			"delphinus/budoux.lua",
		},
	})
	vim.keymap.set("n", "<leader>mp", "<Plug>(md-render-preview)", { desc = "Markdown preview (toggle)" })
	vim.keymap.set("n", "<leader>mt", "<Plug>(md-render-preview-tab)", { desc = "Markdown preview in tab (toggle)" })
end)
