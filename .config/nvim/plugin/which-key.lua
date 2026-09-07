local add, later = MiniDeps.add, MiniDeps.later

later(function()
  add("folke/which-key.nvim")
  local wk = require("which-key")
  wk.setup({
    win = {
      width = 0.4,
      col = math.huge,
      no_overlap = false,
    },
  })

  wk.add({
    { "<leader>g", group = "Git" },
  })
end)
