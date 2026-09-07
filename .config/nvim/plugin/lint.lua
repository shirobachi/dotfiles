local add, later = MiniDeps.add, MiniDeps.later

later(function()
	add("mfussenegger/nvim-lint")

	local lint = require("lint")
	lint.linters_by_ft = {
		lua = { "selene" },
		python = { "ruff" },
		yaml = { "yamllint" },
		markdown = { "markdownlint-cli2" },
		dockerfile = { "hadolint" },
	}

	vim.api.nvim_create_autocmd({ "BufWritePost", "InsertLeave" }, {
		group = vim.api.nvim_create_augroup("nvim-lint", { clear = true }),
		callback = function()
			lint.try_lint()
		end,
	})
end)
