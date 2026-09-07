local add, now = MiniDeps.add, MiniDeps.now

now(function()
	add("nvim-lualine/lualine.nvim")

	local colors = {
		color0 = "#092236",
		color1 = "#ff5874",
		color2 = "#c3ccdc",
		color3 = "#1c1e26",
		color6 = "#a1aab8",
		color7 = "#828697",
		color8 = "#ae81ff",
	}

	local theme = {
		normal = {
			a = { fg = colors.color0, bg = colors.color7, gui = "bold" },
			b = { fg = colors.color2, bg = colors.color3 },
			c = { fg = colors.color2, bg = colors.color3 },
		},
		insert = {
			a = { fg = colors.color0, bg = colors.color2, gui = "bold" },
			b = { fg = colors.color2, bg = colors.color3 },
		},
		visual = {
			a = { fg = colors.color0, bg = colors.color8, gui = "bold" },
			b = { fg = colors.color2, bg = colors.color3 },
		},
		replace = {
			a = { fg = colors.color0, bg = colors.color1, gui = "bold" },
			b = { fg = colors.color2, bg = colors.color3 },
		},
		inactive = {
			a = { fg = colors.color6, bg = colors.color3, gui = "bold" },
			b = { fg = colors.color6, bg = colors.color3 },
			c = { fg = colors.color6, bg = colors.color3 },
		},
	}

	require("lualine").setup({
		options = {
			icons_enabled = true,
			theme = theme,
			component_separators = { left = "|", right = "|" },
			section_separators = { left = "|", right = "" },
		},
		sections = {
			lualine_a = { {
				"mode",
				fmt = function(str)
					return " " .. str
				end,
			} },
			lualine_b = { { "branch", icon = { "", color = { fg = "#A6D4DE" } } } },
			lualine_c = {
				{ "diff", colored = true, symbols = { added = " ", modified = " ", removed = " " } },
				{ "filename", file_status = true, path = 0 },
			},
			lualine_x = { { "filetype" } },
		},
	})
end)
