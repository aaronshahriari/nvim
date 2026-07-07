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
    player = { cmd = { "mpv", "--save-position-on-quit=yes" } }, -- video URL appended
    results_side = "right",
    icons = {
      installed = "", -- marker for a downloaded video
      downloading = "", -- marker shown while a download runs
    },
    home = {
      sections  = { "recent", "pinned", "playlists", "installed" },
      recent    = { limit = 5 },
      pinned    = { limit = 5 },
      installed = { limit = 5 },
      playlists = { limit = 5, items = 5 }, -- 5 playlists, 5 videos per expanded one
    },
  })
end
