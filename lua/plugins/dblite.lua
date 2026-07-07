return function()
  vim.api.nvim_create_autocmd("PackChanged", {
    callback = function(ev)
      local name, kind = ev.data.spec.name, ev.data.kind
      if name == "dblite" and (kind == "install" or kind == "update") then
        if not ev.data.active then vim.cmd.packadd("dblite") end
        require("dblite.download").download_or_build()
      end
    end,
  })

  vim.pack.add({
    { src = "https://github.com/aaronshahriari/dblite.nvim" },
  })

  pcall(function()
    require("dblite.download").ensure_binary()
  end)

  local dblite = require("dblite")
  dblite.setup({
    split_dir         = "horizontal",
    split_size        = { width = 80, height = 17 },
    page_size         = 100,
    flash_timeout     = 1500,
    max_rows          = 10000,
    max_col_width     = 50,
    binds_split       = {
      style  = 'float',
      width  = 80,
      height = 30,
    },
    style             = {
      dbout = {
        cursorline = false,
        sections = {
          { "pagination" },
          { "query_time", sep = " · " },
          { "connection", sep = " · ", hl = "LineNr" },
        },
      },
    },
    connection_picker = 'telescope',
    telescope_picker  = {
      preview       = true,
      width         = 0.5,
      height        = 0.55,
      preview_width = 0.5,
    },
    keymaps           = {
      dbout = { next = "L", prev = "H", cancel = "<C-c>" },
      editor = { filetypes = {} },
    },
  })

  -- all dblite keymaps live only in sql buffers
  vim.api.nvim_create_autocmd("FileType", {
    pattern  = "sql",
    callback = function()
      local opts = { buffer = true }
      vim.keymap.set("n", "<leader>s", dblite.execute, opts)
      vim.keymap.set("n", "<leader>e", dblite.toggle_panel, opts)
      vim.keymap.set("n", "<leader>h", dblite.toggle_dbout, opts)
      vim.keymap.set("n", "<leader>b", dblite.edit_binds, opts)
      vim.keymap.set("n", "<CR>", dblite.execute_at_cursor, opts)
    end,
  })
end
