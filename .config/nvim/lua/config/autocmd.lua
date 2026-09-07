-- Highlight yanking
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking text",
	group = vim.api.nvim_create_augroup("highlight-yank", { clear = true }),
	callback = function()
		vim.hl.on_yank()
	end,
})

vim.filetype.add({
	pattern = {
		[".*docker%-compose.*%.ya?ml"] = "yaml.docker-compose",
		["compose%.ya?ml"] = "yaml.docker-compose",
	},
})
