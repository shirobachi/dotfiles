local later = MiniDeps.later

local dotfiles_git_dir = vim.fn.expand("~/repo/dotfiles")
local dotfiles_work_tree = vim.env.HOME

local function set_ref(buf)
	local path = vim.api.nvim_buf_get_name(buf)
	if path == "" then
		return
	end
	local dir = vim.fs.dirname(path)
	local name = vim.fs.basename(path)

	local function apply(stdout)
		vim.schedule(function()
			if vim.api.nvim_buf_is_valid(buf) then
				MiniDiff.set_ref_text(buf, stdout)
			end
		end)
	end

	-- Try normal repo discovery first (covers regular projects, git-crypt repos, etc.)
	local normal_cmd = { "git", "-C", dir, "cat-file", "--filters", ":./" .. name }
	vim.system(normal_cmd, { text = true }, function(res)
		if res.code == 0 then
			apply(res.stdout)
			return
		end

		-- Fall back to the bare dotfiles repo
		local dotfiles_cmd = {
			"git",
			"--git-dir=" .. dotfiles_git_dir,
			"--work-tree=" .. dotfiles_work_tree,
			"-C",
			dir,
			"cat-file",
			"--filters",
			":./" .. name,
		}
		vim.system(dotfiles_cmd, { text = true }, function(res2)
			if res2.code ~= 0 then
				return
			end
			apply(res2.stdout)
		end)
	end)
end

local git_crypt_source = {
	name = "git-crypt",
	attach = function(buf)
		set_ref(buf)
		vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost" }, {
			group = vim.api.nvim_create_augroup("MiniDiffGitCrypt" .. buf, { clear = true }),
			buffer = buf,
			callback = function()
				set_ref(buf)
			end,
		})
	end,
	detach = function(buf)
		pcall(vim.api.nvim_del_augroup_by_name, "MiniDiffGitCrypt" .. buf)
	end,
}

later(function()
	require("mini.git").setup()
	require("mini.diff").setup({
		source = git_crypt_source,
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
