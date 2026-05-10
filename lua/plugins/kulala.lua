return function()
  vim.pack.add({
    { src = "https://github.com/mistweaverco/kulala.nvim" },
  })

  vim.filetype.add({
    extension = {
      http = "http",
      rest = "http",
    },
    pattern = {
      [".*%.http%..*"] = "http",
    },
  })

  pcall(vim.treesitter.language.register, "http", "rest")

  vim.api.nvim_create_autocmd("FileType", {
    group = vim.api.nvim_create_augroup("kulala-http-treesitter", { clear = true }),
    pattern = { "http", "rest" },
    callback = function(args)
      pcall(vim.treesitter.start, args.buf, "http")
    end,
  })

  local kl = require("kulala")
  kl.setup({
    global_keymaps = true,
    global_keymaps_prefix = "<leader>R",
    kulala_keymaps_prefix = "",
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

  vim.keymap.set("n", "<leader>r", function()
    kl.set_selected_env()
  end, { desc = "Set environment" })
end
