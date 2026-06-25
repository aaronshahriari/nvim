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
    -- { src = "git@git_personal:aaronshahriari/dblite" },
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
      style  = 'float', -- 'vertical' | 'horizontal'
      width  = 80,      -- columns; used when split_dir = 'vertical'. 0 = let nvim decide.
      height = 30,      -- rows; used when split_dir = 'horizontal'. 0 = let nvim decide.
    },
    style             = {
      dbout = {
        cursorline = false, -- highlight the line under the cursor
        -- Status line sections. Each entry: { "item", sep = "…", hl = "HlGroup" }
        -- Available items: "pagination" | "query_time" | "connection"
        -- sep   — separator printed before this item (default "  ·  ")
        -- hl    — highlight group applied to this item's text (optional)
        sections = {
          { "pagination" },
          { "query_time", sep = " · " },
          { "connection", sep = " · ", hl = "LineNr" },
        },
      },
    },
    connection_picker = 'telescope', -- other opt: panel
    telescope_picker  = {
      preview       = true,
      width         = 0.5,
      height        = 0.55,
      preview_width = 0.5,
    },
    keymaps           = {
      dbout = { next = "L", prev = "H", cancel = "<C-c>" },
      editor = { binds = false },
    },
  })
  vim.keymap.set("n", "<leader>s", dblite.execute)
  vim.keymap.set("n", "<leader>e", dblite.toggle_panel)
  vim.keymap.set("n", "<leader>h", dblite.toggle_dbout)
  vim.keymap.set("n", "<leader>b", dblite.edit_binds)
  vim.api.nvim_create_autocmd("FileType", {
    pattern  = "sql",
    callback = function()
      vim.keymap.set("n", "<CR>", dblite.execute_at_cursor, {
        buffer = true,
        desc = "dblite: run query at cursor",
      })
    end
  })
end
