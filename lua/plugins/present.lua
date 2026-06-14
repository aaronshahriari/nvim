return function()
  -- Local fork lives at: nvim/pack/local/opt/present (loaded as a native package)
  vim.cmd.packadd("present")

  require("present").setup({
    spacing = 0, -- blank rows between body lines (0 = no extra spacing, 1 line per text)
  })

  vim.keymap.set("n", "<C-p>", function() vim.cmd("PresentStart") end)
end
