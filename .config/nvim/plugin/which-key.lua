local add, later = MiniDeps.add, MiniDeps.later

later(function()
  add("folke/which-key.nvim")
  require("which-key").setup({
    win = {
      width = 0.4,
      col = math.huge,
      no_overlap = false,
    },
  })
end)
