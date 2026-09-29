---@diagnostic disable: undefined-global
local add, later = MiniDeps.add, MiniDeps.later

later(function()
	add("zbirenbaum/copilot.lua")
	require("copilot").setup({
		suggestion = {
			enabled = true,
			auto_trigger = false,
			keymap = {
				accept = "<Tab>",
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
			auto_trigger_ft = { "*" },
			keymap = {
				accept = "<Tab>",
				dismiss = "<A-e>",
				-- next = "<M-j>",
				-- prev = "<M-k>",
			},
		},
	})

	local ai_states = { "def", "deepseek", "copilot" }
	local current_ai_idx = 1

	local function cycle_ai_completion()
		local prev_state = ai_states[current_ai_idx]
		current_ai_idx = (current_ai_idx % #ai_states) + 1
		local next_state = ai_states[current_ai_idx]

		-- Wyłączenie poprzednio aktywnego dostawcy
		if prev_state == "copilot" then
			require("copilot.suggestion").toggle_auto_trigger()
		elseif prev_state == "deepseek" then
			vim.cmd("Minuet virtualtext toggle")
		end

		-- Aktywacja nowego dostawcy i wysłanie powiadomienia
		if next_state == "deepseek" then
			vim.cmd("Minuet virtualtext toggle")
			vim.notify("AI Provider: DeepSeek", vim.log.levels.INFO)
		elseif next_state == "copilot" then
			require("copilot.suggestion").toggle_auto_trigger()
			vim.notify("AI Provider: Copilot", vim.log.levels.INFO)
		else
			vim.notify("AI Provider: Disabled", vim.log.levels.INFO)
		end
	end

	vim.keymap.set(
		"n",
		"<leader>mt",
		cycle_ai_completion,
		{ desc = "Cycle AI completions (Off -> DeepSeek -> Copilot)" }
	)

	add({ source = "saghen/blink.cmp", checkout = "v1" })
	require("blink.cmp").setup({
		snippets = { preset = "mini_snippets" },
		keymap = {
			preset = "none",
			["<CR>"] = { "accept", "fallback" },
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
