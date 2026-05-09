return function()
  vim.pack.add({
    { src = "https://github.com/saghen/blink.cmp", version = "v1.10.2" },
  })

  require("blink.cmp").setup({
    enabled = function()
      local filetype = vim.bo.filetype
      if filetype == "org-roam-select" then
        return false
      end
      return true
    end,
    snippets = { preset = "luasnip" },
    sources = {
      default = { "lsp", "path", "snippets" },
      per_filetype = {
        sql = { "orgmode", "snippets", "dadbod", "buffer" },
      },
      providers = {
        dadbod = { name = "Dadbod", module = "vim_dadbod_completion.blink" },
        orgmode = {
          name = "Orgmode",
          module = "orgmode.org.autocompletion.blink",
          fallbacks = { "buffer" },
        },
      },
    },
    keymap = { preset = "default" },
    appearance = {
      use_nvim_cmp_as_default = true,
      nerd_font_variant = "mono",
    },
    completion = {
      menu = {
        border = "none",
      },
      list = {
        selection = {
          preselect = true,
          auto_insert = false,
        },
      },
      documentation = {
        auto_show = true,
        window = {
          border = "single",
        },
      },
    },
    -- signature = {
    --   enabled = true,
    --   window = {
    --     min_width = 1,
    --     max_width = 100,
    --     max_height = 10,
    --     border = "single",
    --   },
    -- },
  })
end
