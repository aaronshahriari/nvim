return {
  {
    "saghen/blink.cmp",
    version = "1.*",
    -- dependencies = { 'L3MON4D3/LuaSnip', version = 'v2.*' },  -- added outside
    opts = {
      enabled = function()
        local filetype = vim.bo.filetype
        if filetype == 'org-roam-select' then
          return false
        end
        return true
      end,
      snippets = { preset = 'luasnip' },
      sources = {
        default = { 'lsp', 'path', 'snippets' },
        per_filetype = {
          sql = { 'orgmode', 'snippets', 'dadbod', 'buffer' },
        },
        -- add vim-dadbod-completion to your completion providers
        providers = {
          dadbod = { name = "Dadbod", module = "vim_dadbod_completion.blink" },
          orgmode = {
            name = 'Orgmode',
            module = 'orgmode.org.autocompletion.blink',
            fallbacks = { 'buffer' },
          },
        },
      },
      keymap = { preset = "default", },
      appearance = {
        use_nvim_cmp_as_default = true,
        nerd_font_variant = "mono"
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
    },
    opts_extend = { "sources.default" }
  },
}
