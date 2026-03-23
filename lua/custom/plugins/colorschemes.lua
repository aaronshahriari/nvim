return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    opts = {
      integrations = { blink_cmp = true },
      term_colors = true,
      transparent_background = false,
      color_overrides = {
        mocha = {
          base = "#000000",
          mantle = "#000000",
          crust = "#000000",
        },
      },
      custom_highlights = function(colors)
        return {
          WinSeparator = { fg = colors.flamingo, bg = colors.base },
          TermCursorNC = { fg = "#000000", bg = "#000000" },
          CurSearch = { fg = "#000000", bg = "#F6FF00" },
          LspSignatureActiveParameter = { fg = "#ffffff", bg = colors.base },
          Cursor = { bg = "#ffffff" },
          StatusLine = { bg = "#424242" },
          BlinkCmpMenu = { bg = "#1d1e29" },
          Folded = { bg = "NONE" },
          FoldColumn = { bg = "NONE" },
          WhichKey = {},
          WhichKeyGroup = {},
          WhichKeySeparator = {},
          WhichKeyNormal = { bg = "#1a1b26" },
          FFFMatched = { fg = "#000000", bg = "#a0ab63", bold = true },
          FFFVisual = { bg = "#1c1c1c", bold = true },

          -- org-mode highlights
          ["@org.agenda.header"] = { fg = "#737272", bold = true, italic = false },
          ["@org.agenda.deadline"] = { fg = "#FFAAAA" },
          ["@org.agenda.scheduled_past"] = { fg = "#ff8282" },
          ["@org.agenda.scheduled"] = { fg = "#EBEBEB" },
          ["@org.agenda.time_grid"] = { fg = "#424242" },
          ["@org.hyperlink"] = { underline = true },
        }
      end
    },
  },
}
