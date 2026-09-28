return function()
  -- A local checkout wins when it is present, so the working tree is what
  -- loads while curlite is being worked on. Delete or rename the directory and
  -- this falls back to the published plugin with no edit needed. Same pattern
  -- as plugins/dblite.lua.
  local dev = vim.fn.expand("~/personal/projects/curlite.nvim")
  if vim.fn.isdirectory(dev) == 1 then
    vim.opt.runtimepath:prepend(dev)
  else
    vim.pack.add({
      { src = "https://github.com/aaronshahriari/curlite.nvim" },
    })
  end

  require("curlite").setup({
    ui = {
      display = "right",
      -- Fractions, not cells: an even split whatever the terminal's width.
      width = 0.5,
      height = 0.5,
      -- Stay in the request buffer after firing, so the next one is a
      -- keystroke away. `<leader>Ro` moves into the response window.
      focus = false,
      wrap = false,
      -- Match dblite's quick execution flash.
      flash_timeout = 1500,
    },

    format = {
      bodies = true,
      -- kulala leaned on kulala-fmt through its LSP; curlite formats
      -- in-process, so this is just an autocmd away.
      on_save = true,
    },

    request = {
      -- Matches the `variables_scope` the old kulala config used.
      variables_scope = "request",
    },

    keymaps = {
      -- `<leader>R` is the kulala prefix and curlite's default, so the muscle
      -- memory carries over. `<leader>e` is the personal override that the
      -- kulala config set by hand.
      select_env = "<leader>e",
      -- Free globally; buffer-local and Kulala-compatible in .http files.
      copy_curl = "<leader>Rc",
      -- Buffer-local, so it shadows conform's `<leader>f` only in .http files.
      format = "<leader>f",
    },

    result_keymaps = {
      -- Kept free for window navigation, exactly as the kulala config did with
      -- `["Previous tab"] = false` / `["Next tab"] = false`. The direct pane
      -- keys below are what replace them.
      prev_pane = false,
      next_pane = false,
      -- B body · H headers · A all · S stats · V verbose · O script output,
      -- the same letters kulala uses inside its window.
    },
  })
end
