return {
  "MeanderingProgrammer/render-markdown.nvim",
  dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" },
  ---@module "render-markdown"
  ---@type render.md.UserConfig
  config = function()
    local render = require("render-markdown")
    render.setup({
      heading = { position = 'inline', width = 'block' },
      paragraph = { enabled = false, },
      code = { enabled = false, },
      dash = { enabled = false, },
      callout = {
        note      = { raw = '[!NOTE]', rendered = '󰋽 Note ', highlight = 'RenderMarkdownInfo', category = 'github' },
        tip       = { raw = '[!TIP]', rendered = '󰌶 Tip ', highlight = 'RenderMarkdownSuccess', category = 'github' },
        important = { raw = '[!IMPORTANT]', rendered = '󰅾 Important ', highlight = 'RenderMarkdownHint', category = 'github' },
        warning   = { raw = '[!WARNING]', rendered = '󰀪 Warning ', highlight = 'RenderMarkdownWarn', category = 'github' },
        caution   = { raw = '[!CAUTION]', rendered = '󰳦 Caution ', highlight = 'RenderMarkdownError', category = 'github' },
        abstract  = { raw = '[!ABSTRACT]', rendered = '󰨸 Abstract ', highlight = 'RenderMarkdownInfo', category = 'obsidian' },
        summary   = { raw = '[!SUMMARY]', rendered = '󰨸 Summary ', highlight = 'RenderMarkdownInfo', category = 'obsidian' },
        tldr      = { raw = '[!TLDR]', rendered = '󰨸 Tldr ', highlight = 'RenderMarkdownInfo', category = 'obsidian' },
        info      = { raw = '[!INFO]', rendered = '󰋽 Info  ', highlight = 'RenderMarkdownInfo', category = 'obsidian' },
        todo      = { raw = '[!TODO]', rendered = '󰗡 Todo ', highlight = 'RenderMarkdownInfo', category = 'obsidian' },
        hint      = { raw = '[!HINT]', rendered = '󰌶 Hint ', highlight = 'RenderMarkdownSuccess', category = 'obsidian' },
        success   = { raw = '[!SUCCESS]', rendered = '󰄬 Success ', highlight = 'RenderMarkdownSuccess', category = 'obsidian' },
        check     = { raw = '[!CHECK]', rendered = '󰄬 Check ', highlight = 'RenderMarkdownSuccess', category = 'obsidian' },
        done      = { raw = '[!DONE]', rendered = '󰄬 Done ', highlight = 'RenderMarkdownSuccess', category = 'obsidian' },
        question  = { raw = '[!QUESTION]', rendered = '󰘥 Question ', highlight = 'RenderMarkdownWarn', category = 'obsidian' },
        help      = { raw = '[!HELP]', rendered = '󰘥 Help ', highlight = 'RenderMarkdownWarn', category = 'obsidian' },
        faq       = { raw = '[!FAQ]', rendered = '󰘥 Faq ', highlight = 'RenderMarkdownWarn', category = 'obsidian' },
        attention = { raw = '[!ATTENTION]', rendered = '󰀪 Attention ', highlight = 'RenderMarkdownWarn', category = 'obsidian' },
        failure   = { raw = '[!FAILURE]', rendered = '󰅖 Failure ', highlight = 'RenderMarkdownError', category = 'obsidian' },
        fail      = { raw = '[!FAIL]', rendered = '󰅖 Fail ', highlight = 'RenderMarkdownError', category = 'obsidian' },
        missing   = { raw = '[!MISSING]', rendered = '󰅖 Missing ', highlight = 'RenderMarkdownError', category = 'obsidian' },
        danger    = { raw = '[!DANGER]', rendered = '󱐌 Danger ', highlight = 'RenderMarkdownError', category = 'obsidian' },
        error     = { raw = '[!ERROR]', rendered = '󱐌 Error ', highlight = 'RenderMarkdownError', category = 'obsidian' },
        bug       = { raw = '[!BUG]', rendered = '󰨰 Bug ', highlight = 'RenderMarkdownError', category = 'obsidian' },
        example   = { raw = '[!EXAMPLE]', rendered = '󰉹 Example ', highlight = 'RenderMarkdownHint', category = 'obsidian' },
        quote     = { raw = '[!QUOTE]', rendered = '󱆨 Quote ', highlight = 'RenderMarkdownQuote', category = 'obsidian' },
        cite      = { raw = '[!CITE]', rendered = '󱆨 Cite ', highlight = 'RenderMarkdownQuote', category = 'obsidian' },
      },
      bullet = {
        enabled = true,
        render_modes = false,
        icons = { '●', '', '◆', '◇' },
        ordered_icons = function(ctx)
          local value = vim.trim(ctx.value)
          local index = tonumber(value:sub(1, #value - 1))
          return ('%d.'):format(index > 1 and index or ctx.index)
        end,
        left_pad = 0,
        right_pad = 1,
        highlight = 'RenderMarkdownBullet',
        scope_highlight = {},
        scope_priority = nil,
      },
      quote = {
        enabled = true,
        render_modes = false,
        icon = '▋',
        -- Whether to repeat icon on wrapped lines. Requires neovim >= 0.10. This will obscure text
        -- if incorrectly configured with :h 'showbreak', :h 'breakindent' and :h 'breakindentopt'.
        -- A combination of these that is likely to work follows.
        -- | showbreak      | '  ' (2 spaces)   |
        -- | breakindent    | true              |
        -- | breakindentopt | '' (empty string) |
        -- These are not validated by this plugin. If you want to avoid adding these to your main
        -- configuration then set them in win_options for this plugin.
        repeat_linebreak = false,
        -- Highlight for the quote icon.
        -- If a list is provided output is evaluated by `cycle(value, level)`.
        highlight = {
          'RenderMarkdownQuote1',
          'RenderMarkdownQuote2',
          'RenderMarkdownQuote3',
          'RenderMarkdownQuote4',
          'RenderMarkdownQuote5',
          'RenderMarkdownQuote6',
        },
      },
      pipe_table = { enabled = false, },
      link = {
        enabled = true,
        icon = ' ',
        wiki = {
          enabled = true,
          icon = '',
          highlight = 'RenderMarkdownLink',
          scope_highlight = '@markup.underline',
        },
      },
      sign = { enabled = false, },
      indent = { enabled = false, },
      checkbox = {
        enabled = true,
        render_modes = false,
        bullet = false,
        left_pad = 0,
        right_pad = 1,
        unchecked = {
          icon = ' ',
          highlight = 'RenderMarkdownUnchecked',
          scope_highlight = nil,
        },
        checked = {
          icon = ' ',
          highlight = 'RenderMarkdownChecked',
          scope_highlight = '@markup.strikethrough',
        },
        custom = {
          pending = {
            raw = '[?]',
            rendered = ' ',
            highlight = 'RenderMarkdownInfo',
            scope_highlight = nil
          },
        },
      },
    })
  end
}
