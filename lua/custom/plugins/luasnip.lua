return {
  "L3MON4D3/LuaSnip",
  version = "v2.*",
  build = "make install_jsregexp",
  config = function()
    local ls = require("luasnip")
    local s = ls.snippet
    local t = ls.text_node
    local i = ls.insert_node
    local f = ls.function_node

    ls.add_snippets("markdown", {
      s("priority", {
        t("[priority:: "),
        i(1, "priority"),
        t("]"),
        i(0),
      }),
    })

    ls.add_snippets("markdown", {
      s("due", {
        t("[due:: "),
        i(1, os.date("%Y-%m-%d")),
        t("]"),
        i(0),
      }),
    })

    ls.add_snippets("markdown", {
      s("todo", {
        t("- [ ] TODO "),
        i(1, "task"),
        t(" [created:: "),
        f(function() return os.date("%Y-%m-%d") end, {}),
        t("]"),
        i(0),
      }),
    })

    ls.add_snippets("go", {
      s("iferr", {
        t({ "if err != nil {", "\treturn " }),
        i(1, "err"),
        t({ "", "}" }),
        i(0),
      }),
    })

    -- expand snippet under cursor
    -- vim.keymap.set({ "i", "s" }, "<M-CR>", function()
    --   if ls.expandable() then
    --     ls.expand()
    --   end
    -- end, { desc = "Expand snippet" })
  end,
}
