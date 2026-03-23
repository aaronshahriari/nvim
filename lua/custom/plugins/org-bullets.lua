return {
  "akinsho/org-bullets.nvim",
  config = function()
    require("org-bullets").setup {
      concealcursor = false, -- If false then when the cursor is on a line underlying characters are visible
      symbols = {
        -- list symbol
        list = "•",
        -- headlines can be a list
        headlines = { "◉", "○", "✸", "✿" },
        checkboxes = {
          half = { "", "@org.checkbox.halfchecked" },
          done = { "", "@org.keyword.done" },
          todo = { "", "@org.keyword.todo" },
        },
      },
    }
  end
}
