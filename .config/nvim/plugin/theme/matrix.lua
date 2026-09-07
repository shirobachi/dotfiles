local add, now = MiniDeps.add, MiniDeps.now

now(function()
	vim.g.matrix_disable_background = true
	vim.g.matrix_borders = true
	vim.g.matrix_cursorline_transparent = true
	vim.g.matrix_enable_sidebar_background = true

	add("iruzo/matrix-nvim")
	vim.cmd.colorscheme("matrix")

	vim.api.nvim_set_hl(0, "GitSignsAdd", { fg = "#00ff00", bg = "NONE" })
	vim.api.nvim_set_hl(0, "GitSignsChange", { fg = "#0088ff", bg = "NONE" })
	vim.api.nvim_set_hl(0, "GitSignsDelete", { fg = "#ff0000", bg = "NONE" })
	vim.api.nvim_set_hl(0, "GitSignsAddNr", { fg = "#00ff00", bg = "NONE" })
	vim.api.nvim_set_hl(0, "GitSignsChangeNr", { fg = "#0088ff", bg = "NONE" })
	vim.api.nvim_set_hl(0, "GitSignsDeleteNr", { fg = "#ff0000", bg = "NONE" })

	vim.api.nvim_set_hl(0, "MiniDiffSignAdd", { fg = "#00ff00", bg = "NONE" })
	vim.api.nvim_set_hl(0, "MiniDiffSignChange", { fg = "#0088ff", bg = "NONE" })
	vim.api.nvim_set_hl(0, "MiniDiffSignDelete", { fg = "#ff0000", bg = "NONE" })

	vim.api.nvim_set_hl(0, "DiagnosticSignError", { fg = "#ff0000" })
	vim.api.nvim_set_hl(0, "DiagnosticSignWarn", { fg = "#ffff00" })
	vim.api.nvim_set_hl(0, "DiagnosticSignInfo", { fg = "#0088ff" })
	vim.api.nvim_set_hl(0, "DiagnosticSignHint", { fg = "#00ff00" })
end)
