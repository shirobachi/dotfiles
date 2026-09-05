local add, now, later = MiniDeps.add, MiniDeps.now, MiniDeps.later

now(function()
  add("rmagatti/auto-session")
  require("auto-session").setup({
    enabled = true,
    show_auto_restore_notif = true,
    auto_restore_last_session = true,
    auto_session_suppress_dirs = { "~/", "~/Downloads", "~/Documents", "~/repo" },
  })
  vim.keymap.set("n", "<leader>wr", "<cmd>AutoSession restore<CR>", { desc = "Restore session for cwd" })
  vim.keymap.set("n", "<leader>ws", "<cmd>AutoSession save<CR>", { desc = "Save session for cwd" })
end)

later(function()
  vim.opt.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"
end)
