local add, later = MiniDeps.add, MiniDeps.later

later(function()
	add("stevearc/conform.nvim")

	require("conform").setup({
		formatters_by_ft = {
			lua = { "stylua" },
			sh = { "shfmt" },
			python = { "ruff_format" },
			yaml = { "prettier" },
			json = { "prettier" },
			markdown = { "prettier" },
			dockerfile = { "dockerfmt" },
		},
		format_on_save = {
			lsp_format = "fallback",
			timeout_ms = 500,
		},
	})
end)
