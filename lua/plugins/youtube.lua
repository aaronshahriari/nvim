return function()
  vim.api.nvim_create_autocmd("PackChanged", {
    callback = function(ev)
      local name, kind = ev.data.spec.name, ev.data.kind
      if name == "yt.nvim" and (kind == "install" or kind == "update") then
        require("yt.download").download_or_build()
      end
    end,
  })

  vim.pack.add({
    { src = "https://github.com/aaronshahriari/yt.nvim" },
  })

  require("yt").setup({
    per_page = 10,                                               -- results shown per page
    max_pages = 5,                                               -- max pages fetched (total = per_page × max_pages)
    keymaps = { page_next = "L", page_prev = "H" },              -- set to false to drop
    player = { cmd = { "mpv", "--save-position-on-quit=yes" } }, -- video URL appended
    results_side = "right"
  })
end
