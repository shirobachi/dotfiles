local add, later = MiniDeps.add, MiniDeps.later

later(function()
	add("OXY2DEV/markview.nvim")

	require("markview").setup({
		modes = { "n", "no", "c" },
		hybrid_modes = { "n", "i" },
	})
end)
