return function()
  vim.pack.add({
    { src = "https://github.com/nvim-lua/plenary.nvim" },
    { src = "https://github.com/nvim-telescope/telescope.nvim" },
  })

  local telescope = require("telescope")
  telescope.setup {
    extensions = {},
    pickers = {
      colorscheme = {
        enable_preview = true
      }
    },
    defaults = {
      file_ignore_patterns = {
        "__pycache__",
        "^tmp/",
        "/tmp/",
        "tmp/.*",
        "%.lock",
        "^node_modules/",
        "%.git/",
        "%.jpg",
        "%.png",
        "%target/",
      },
      preview = {
        treesitter = true,
      },
      path_display = { "smart" },
      layout_strategy = 'horizontal',
      -- layout_config = { height = 0.75, width = 0.75 }, -- OLD
      layout_config = {
        horizontal = {
          preview_width = 0.6
        },
      },
    },
  }

  local builtin = require('telescope.builtin')
  vim.keymap.set('n', '<leader>ff', function() builtin.find_files() end, {})
  -- vim.keymap.set('n', '<C-p>', function() builtin.git_files({ no_ignore = true }) end, {})
  vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
  vim.keymap.set("n", "<leader>fh", builtin.help_tags)
  vim.keymap.set("n", "grr", builtin.lsp_references)
  -- vim.keymap.set('n', '<C-b>', function() builtin.grep_string({ search = "FIXME:" }) end, {})
  vim.keymap.set("n", "<leader>fc", function()
    builtin.find_files { cwd = "/home/aaronshahriari/github/.dotfiles/nvim/" }
  end)
end
