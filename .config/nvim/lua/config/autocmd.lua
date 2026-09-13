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
		[".*/roles/.*%.ya?ml"] = "yaml.ansible",
		[".*/tasks/.*%.ya?ml"] = "yaml.ansible",
		[".*/handlers/.*%.ya?ml"] = "yaml.ansible",
		[".*/defaults/.*%.ya?ml"] = "yaml.ansible",
		[".*/vars/.*%.ya?ml"] = "yaml.ansible",
		[".*/meta/.*%.ya?ml"] = "yaml.ansible",
		[".*/group_vars/.*%.ya?ml"] = "yaml.ansible",
		[".*/host_vars/.*%.ya?ml"] = "yaml.ansible",
		[".*/playbooks/.*%.ya?ml"] = "yaml.ansible",
		["playbook%.ya?ml"] = "yaml.ansible",
		["site%.ya?ml"] = "yaml.ansible",
	},
})

vim.api.nvim_create_autocmd("BufReadPost", {
	group = vim.api.nvim_create_augroup("restore-cursor", { clear = true }),
	callback = function(args)
		local mark = vim.api.nvim_buf_get_mark(args.buf, '"')
		local lcount = vim.api.nvim_buf_line_count(args.buf)
		if mark[1] > 0 and mark[1] <= lcount then
			vim.api.nvim_win_set_cursor(0, mark)
		end
	end,
})
