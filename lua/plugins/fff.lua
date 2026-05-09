return function()
  vim.pack.add({
    { src = "https://github.com/dmtrKovalenko/fff.nvim" },
  })

  pcall(function()
    require("fff.download").download_or_build_binary()
  end)

  local fff = require("fff")
  fff.setup({
    title = "FileSearch",
    prompt = " ",
    layout = {
      height = 0.75,
      width = 0.7,
      prompt_position = "bottom",
      preview_position = "right",
      preview_size = 0.5,
      show_scrollbar = false,
    },
    keymaps = {
      close = "<C-c>",
      select = "<CR>",
      select_split = "<C-x>",
      select_vsplit = "<C-v>",
      select_tab = "<C-t>",
      move_up = { "<Up>", "<C-p>" },
      move_down = { "<Down>", "<C-n>" },
      preview_scroll_up = "<C-u>",
      preview_scroll_down = "<C-d>",
      toggle_debug = "<F2>",
    },
    hl = {
      matched = "FFFMatched",
      active_file = "FFFVisual",
      grep_match = "FFFMatched",
    },
  })

  vim.keymap.set("n", "<leader>ff", function()
    fff.find_files()
  end, {})

  vim.keymap.set("n", "<leader>fg", function()
    fff.live_grep({
      grep = {
        modes = { "plain", "fuzzy" },
      },
    })
  end, {})

  vim.keymap.set("n", "<leader>fh", function()
    vim.cmd("help")
  end, {})

  vim.keymap.set("n", "<C-p>", function()
    fff.find_in_git_root({ no_ignore = true })
  end, {})

  vim.keymap.set("n", "<space>fc", function()
    fff.find_files_in_dir("/home/aaronshahriari/github/.dotfiles/nvim/")
  end, {})
end
