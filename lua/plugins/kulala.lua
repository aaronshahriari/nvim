return function()
  vim.pack.add({
    { src = "https://github.com/mistweaverco/kulala.nvim" },
  })

  -- .http is detected natively by nvim; .rest and *.http.* are not.
  -- Treesitter registration and highlighting are owned by kulala itself
  -- (it registers the "kulala_http" parser for both filetypes) -- do not
  -- duplicate it here.
  vim.filetype.add({
    extension = {
      rest = "http",
    },
    pattern = {
      [".*%.http%..*"] = "http",
    },
  })

  local kl = require("kulala")
  kl.setup({
    variables_scope = "request",
    global_keymaps = true,
    global_keymaps_prefix = "<leader>R",
    kulala_keymaps_prefix = "",
    kulala_keymaps = {
      ["Previous tab"] = false, -- disable <C-h>
      ["Next tab"] = false,     -- disable <C-l>
    },
    ui = {
      win_opts = {
        wo = { wrap = false, foldmethod = "manual" },
      },
      display_mode = "split",
      split_direction = "vertical",
    },
    lsp = {
      enable = true,
      keymaps = false,
      formatter = {
        sort = {
          metadata = true,
          variables = true,
          commands = true,
          json = false,
        },
      },
    },
  })

  vim.keymap.set("n", "<leader>e", function()
    kl.set_selected_env()
  end, { desc = "Set environment" })
end
