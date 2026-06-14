return function()
  vim.pack.add({
    { src = "https://github.com/epwalsh/obsidian.nvim" },
  })

  local obs = require("obsidian")
  obs.setup({
    workspaces = {
      {
        name = "work-todo",
        path = "~/work/important/todo",
      },
    },
  })
end
