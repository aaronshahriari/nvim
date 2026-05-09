return function()
  vim.pack.add({
    { src = "https://github.com/nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },
  })

    local tree = require("nvim-treesitter")
    tree.setup {
      ensure_installed = {
        "elixir",
        "php",
        "html",
        "java",
        "python",
        "javascript",
        "c",
        "lua",
        "vim",
        "vimdoc",
        "query",
        "eex",
        "elixir",
        "erlang",
        "heex",
        "html",
        "surface",
        "apex",
      },
      sync_install = false,
      auto_install = false,
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = { "markdown", "markdown_inline" },
      },
      indent = {
        enable = true,
        disable = { "html" },
      }
    }
end
