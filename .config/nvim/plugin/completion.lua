local add, later = MiniDeps.add, MiniDeps.later

later(function()
	add("zbirenbaum/copilot.lua")
	require("copilot").setup({
		suggestion = {
			enabled = true,
			auto_trigger = true,
			keymap = {
				accept = "<M-l>",
				next = "<M-j>",
				prev = "<M-k>",
				dismiss = "<C-c>",
				accept_word = "<M-w>",
				accept_line = "<M-e>",
			},
		},
		panel = { enabled = false },
	})

	require("mini.snippets").setup({
		mappings = {
			expand = "",
			jump_next = "<Tab>",
			jump_prev = "<S-Tab>",
			stop = "",
		},
	})

	add("milanglacier/minuet-ai.nvim")
	require("minuet").setup({
		provider = "openai_fim_compatible",
		provider_options = {
			openai_fim_compatible = {
				api_key = "DEEPSEEK_KEY",
				end_point = "https://api.deepseek.com/beta/completions",
				model = "deepseek-flash",
			},
		},
		virtualtext = {
			auto_trigger_ft = {}, -- Keep this empty for manual toggling
			keymap = {
				accept = "<A-l>",
				dismiss = "<A-e>",
			},
		},
	})
	vim.keymap.set("n", "<leader>mt", ":Minuet virtualtext toggle<CR>", { desc = "Toggle Minuet completions" })

	add({ source = "saghen/blink.cmp", checkout = "v1" })
	require("blink.cmp").setup({
		snippets = { preset = "mini_snippets" },
		keymap = {
			preset = "none",
			["<C-j>"] = { "select_next", "fallback" },
			["<C-k>"] = { "select_prev", "fallback" },
			["<C-l>"] = { "accept", "fallback" },
			["<C-e>"] = { "hide", "fallback" },
			["<C-space>"] = { "show", "fallback" },
			["<C-f>"] = { "scroll_documentation_down", "fallback" },
			["<C-b>"] = { "scroll_documentation_up", "fallback" },
		},
		completion = {
			documentation = { auto_show = true },
		},
		sources = {
			default = { "lsp", "path", "buffer" },
		},
	})
end)
