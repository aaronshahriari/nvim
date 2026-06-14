return function()
  vim.pack.add({
    { src = "https://github.com/nvim-tree/nvim-web-devicons" },
    { src = "https://github.com/stevearc/oil.nvim" },
  })
  local oil = require("oil")
  -- Open the entry under the cursor in zathura (detached). Handy for the
  -- ../pdf/ output from md-pdf.nvim.
  local function open_in_zathura()
    local entry = oil.get_cursor_entry()
    if not entry or entry.type ~= "file" then
      return
    end
    local path = oil.get_current_dir() .. entry.name
    vim.system({ "zathura", path }, { detach = true })
  end
  oil.setup({
    default_file_explorer = true,
    columns = {
      "icon",
    },
    view_options = {
      show_hidden = true,
    },
    keymaps = {
      ["<CR>"] = "actions.select",
      ["<C-v>"] = "actions.select_vsplit",
      ["<C-x>"] = "actions.select_split",
      -- ["<C-t>"] = "actions.select_tab",
      ["<C-q>"] = "actions.preview",
      ["<C-r>"] = "actions.refresh",
      ["-"] = "actions.parent",
      ["<space>z"] = { callback = open_in_zathura, desc = "Open file in zathura" },
    },
    use_default_keymaps = false,
    float = {
      -- Padding around the floating window
      padding = 2,
      max_width = 70,
      max_height = 30,
      border = "single",
      win_options = {
        winblend = 0,
      },
    },
    skip_confirm_for_simple_edits = true,
    prompt_save_on_select_new_entry = false,
  })
  -- Open parent directory in floating window
  vim.keymap.set("n", "<space>-", require("oil").toggle_float)
  vim.keymap.set("n", "<leader>pv", require("oil").open)
end
