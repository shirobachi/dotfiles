local later = MiniDeps.later

later(function()
	require("mini.git").setup()
	require("mini.diff").setup({
		view = {
			style = "sign",
			signs = { add = "+", change = "±", delete = "-" },
		},
	})

	vim.keymap.set("n", "<leader>gp", MiniDiff.toggle_overlay, { desc = "Git: toggle change overlay" })
	vim.keymap.set("n", "<leader>gS", function()
		MiniDiff.do_hunks(0, "apply")
	end, { desc = "Git: stage entire buffer" })
	vim.keymap.set("n", "<leader>gR", function()
		MiniDiff.do_hunks(0, "reset")
	end, { desc = "Git: reset entire buffer" })
	vim.keymap.set({ "n", "x" }, "<leader>gl", MiniGit.show_at_cursor, { desc = "Git: line history" })
	vim.keymap.set("n", "<leader>gd", function()
		vim.cmd("Git diff -- " .. vim.fn.expand("%"))
	end, { desc = "Git: diff current file" })
	vim.keymap.set("n", "<leader>gc", "<cmd>Git commit<cr>", { desc = "Git: commit" })
	vim.keymap.set("n", "<leader>gP", "<cmd>Git push<cr>", { desc = "Git: push" })
	vim.keymap.set("n", "<leader>gu", "<cmd>Git pull --rebase<cr>", { desc = "Git: pull --rebase" })
end)
