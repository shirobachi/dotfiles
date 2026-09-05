local now, later = MiniDeps.now, MiniDeps.later

now(function()
  require("mini.icons").setup()
  MiniIcons.mock_nvim_web_devicons()

  require("mini.notify").setup()
  vim.notify = require("mini.notify").make_notify()
end)

later(function()
  require("mini.pairs").setup()

  require("mini.files").setup({
    mappings = {
      go_in = "<CR>",
      go_in_plus = "L",
      go_out = "-",
      go_out_plus = "H",
    },
    options = { use_as_default_explorer = true },
  })
  vim.keymap.set("n", "<leader>ee", "<cmd>lua MiniFiles.open()<CR>", { desc = "Toggle mini file explorer" })
  vim.keymap.set("n", "<leader>ef", function()
    MiniFiles.open(vim.api.nvim_buf_get_name(0), false)
    MiniFiles.reveal_cwd()
  end, { desc = "Toggle into currently opened file" })

  require("mini.surround").setup()
  local trailspace = require("mini.trailspace")
  trailspace.setup({ only_in_normal_buffers = true })
  vim.keymap.set("n", "<leader>cw", trailspace.trim, { desc = "Erase Whitespace" })
  vim.api.nvim_create_autocmd("CursorMoved", {
    callback = function() trailspace.unhighlight() end,
  })

  local splitjoin = require("mini.splitjoin")
  splitjoin.setup({ mappings = { toggle = "" } })
  vim.keymap.set({ "n", "x" }, "sj", splitjoin.join, { desc = "Join arguments" })
  vim.keymap.set({ "n", "x" }, "sk", splitjoin.split, { desc = "Split arguments" })
end)
