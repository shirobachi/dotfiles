local add, later = MiniDeps.add, MiniDeps.later

later(function()
	add("zbirenbaum/copilot.lua")
	add({ source = "saghen/blink.cmp", checkout = "v1" })

	require("copilot").setup({
		suggestion = {
			enabled = true,
			auto_trigger = true,
			keymap = {
				accept = "<M-l>",
				next = "<M-j>",
				prev = "<M-k>",
				dismiss = "<C-c>",
				accept_word = "<M-;>",
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
