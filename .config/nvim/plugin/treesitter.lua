local add, later = MiniDeps.add, MiniDeps.later

later(function()
	add({
		source = "nvim-treesitter/nvim-treesitter",
		checkout = "main",
		hooks = {
			post_checkout = function()
				vim.cmd("TSUpdate")
			end,
		},
	})

	local ts = require("nvim-treesitter")
	local wanted = {
		"bash",
		"python",
		"yaml",
		"json",
		"toml",
		"dockerfile",
		"lua",
		"vim",
		"vimdoc",
		"markdown",
		"markdown_inline",
		"gitcommit",
		"gitignore",
		"diff",
		"regex",
		"ssh_config",
	}
	local installed = ts.get_installed()
	local missing = vim.tbl_filter(function(lang)
		return not vim.tbl_contains(installed, lang)
	end, wanted)
	if #missing > 0 then
		ts.install(missing)
	end

	vim.api.nvim_create_autocmd("FileType", {
		group = vim.api.nvim_create_augroup("treesitter-start", { clear = true }),
		callback = function()
			pcall(vim.treesitter.start)
		end,
	})
end)
