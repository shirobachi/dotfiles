local add, later = MiniDeps.add, MiniDeps.later

later(function()
  add("b0o/incline.nvim")

  local severity = {
    { name = "Error", icon = " " },
    { name = "Warn", icon = " " },
    { name = "Info", icon = " " },
    { name = "Hint", icon = "󰠠 " },
  }

  require("incline").setup({
    hide = { only_win = false },
    render = function(props)
      local bufname = vim.api.nvim_buf_get_name(props.buf)
      local path = vim.fn.fnamemodify(bufname, ":~:.")
      if path == "" then path = "[No Name]" end
      if #path > 40 then path = vim.fn.pathshorten(path) end

      local icon, hl = MiniIcons.get("file", bufname)
      local modified = vim.bo[props.buf].modified

      local diag = {}
      for _, s in ipairs(severity) do
        local n = #vim.diagnostic.get(props.buf, { severity = vim.diagnostic.severity[s.name:upper()] })
        if n > 0 then
          table.insert(diag, { s.icon .. n .. " ", group = "DiagnosticSign" .. s.name })
        end
      end

      return {
        diag,
        { " ", icon, " ", group = hl },
        { path, gui = modified and "bold" or "none" },
        modified and { " [+]", guifg = "#ff9e64" } or "",
        " ",
      }
    end,
  })
end)
