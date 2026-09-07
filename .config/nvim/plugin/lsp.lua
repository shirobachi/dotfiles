local add, later = MiniDeps.add, MiniDeps.later

later(function()
	add("neovim/nvim-lspconfig")
	add("mason-org/mason.nvim")
	add("WhoIsSethDaniel/mason-tool-installer.nvim")
	add("folke/lazydev.nvim")

	require("mason").setup()
	require("mason-tool-installer").setup({
		ensure_installed = {
			"lua-language-server",
			"bash-language-server",
			"yaml-language-server",
			"dockerfile-language-server",
			"docker-compose-language-service",
			"marksman",
			"pyright",
			"stylua",
			"shfmt",
			"shellcheck",
			"prettier",
			"ruff",
			"dockerfmt",
			"selene",
			"yamllint",
			"markdownlint",
			"hadolint",
		},
	})
	vim.cmd("MasonToolsInstall")

	require("lazydev").setup({
		library = {
			"mini.nvim",
			{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
		},
	})

	local diagnostic_icons = {
		[vim.diagnostic.severity.ERROR] = vim.fn.nr2char(0xf057, true),
		[vim.diagnostic.severity.WARN] = vim.fn.nr2char(0xf071, true),
		[vim.diagnostic.severity.INFO] = vim.fn.nr2char(0xf05a, true),
		[vim.diagnostic.severity.HINT] = vim.fn.nr2char(0xf0820, true),
	}
	vim.diagnostic.config({
		virtual_text = true,
		severity_sort = true,
		float = { border = "rounded", source = true },
		signs = { text = diagnostic_icons },
	})

	vim.api.nvim_create_autocmd("LspAttach", {
		group = vim.api.nvim_create_augroup("UserLspConfig", {}),
		callback = function(ev)
			local function map(mode, lhs, rhs, desc)
				vim.keymap.set(mode, lhs, rhs, { buffer = ev.buf, desc = desc })
			end
			map("n", "gd", function()
				MiniExtra.pickers.lsp({ scope = "definition" })
			end, "LSP definitions")
			map("n", "gD", vim.lsp.buf.declaration, "Go to declaration")
			map("n", "gR", function()
				MiniExtra.pickers.lsp({ scope = "references" })
			end, "LSP references")
			map("n", "gi", function()
				MiniExtra.pickers.lsp({ scope = "implementation" })
			end, "LSP implementations")
			map("n", "gt", function()
				MiniExtra.pickers.lsp({ scope = "type_definition" })
			end, "LSP type definitions")
			map({ "n", "v" }, "<leader>vca", vim.lsp.buf.code_action, "Code actions")
			map("n", "<leader>rn", vim.lsp.buf.rename, "Smart rename")
			map("n", "<leader>ld", vim.diagnostic.open_float, "Line diagnostics")
			map("n", "<leader>D", function()
				MiniExtra.pickers.diagnostic({ scope = "current" })
			end, "Buffer diagnostics")
			map("n", "<leader>rs", "<cmd>LspRestart<CR>", "Restart LSP")
			map("i", "<C-h>", vim.lsp.buf.signature_help, "Signature help")
		end,
	})

	vim.lsp.config("lua_ls", {
		settings = {
			Lua = {
				completion = { callSnippet = "Replace" },
				workspace = { checkThirdParty = false },
				diagnostics = {
					globals = {
						"vim",
						"MiniDeps",
						"MiniIcons",
						"MiniNotify",
						"MiniFiles",
						"MiniGit",
						"MiniDiff",
						"MiniPick",
						"MiniExtra",
						"MiniSnippets",
					},
				},
			},
		},
	})

	vim.lsp.config("bashls", {
		settings = {
			bashIde = {
				shellcheckPath = vim.fn.exepath("shellcheck"),
			},
		},
	})

	vim.lsp.enable({
		"lua_ls",
		"bashls",
		"yamlls",
		"dockerls",
		"docker_compose_language_service",
		"marksman",
		"pyright",
	})
end)
