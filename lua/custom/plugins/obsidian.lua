return {
  "obsidian-nvim/obsidian.nvim",
  version = "*", -- use latest release, remove to use latest commit
  -- ft = "markdown", -- commented to use everywhere
  ---@module 'obsidian'
  ---@type obsidian.config
  opts = {
    attachments = {
      folder = "/attachments",
    },
    legacy_commands = false, -- this will be removed in the next major release
    workspaces = {
      {
        name = "main",
        path = "~/vaults/vault_personal",
      },
    },
    ui = {
      enable = false,
      -- checkboxes = {},
      -- bullets = {},
      ignore_conceal_warn = true,
    },
    notes_subdir = "inbox",
    -- new_notes_location = "inbox",
    -- FIXME: update filename convention
    note_id_func = function(title)
      local date = os.date("%Y_%m_%d")
      local formated_title = title:gsub(" ", "_"):lower() or ""
      local filename = date .. "_" .. formated_title .. ".md"
      return filename
    end,
    open_notes_in = "current",
    daily_notes = {
      folder = "dailies",
      date_format = "%Y-%m-%d",
      template = "daily",
    },
    templates = {
      folder = "templates/nvim",
      date_format = "%Y-%m-%d",
      time_format = "%I:%M:%S %p",
      substitutions = {
        todo = function()
          local todo = vim.fn.input("Todo: ")
          return "TODO " .. todo
        end,
        created = function()
          local date = os.date("%Y-%m-%d")
          return "[created:: " .. date .. "]"
        end,
        priority = function()
          local input = vim.fn.input("Priority (h/m/l): "):lower()
          local map = { h = "highest", m = "medium", l = "low" }
          local val = map[input]
          if not val then
            return ""
          end
          return "[priority:: " .. val .. "] "
        end,
        due = function()
          local default = os.date("%Y-%m-%d")
          local input = vim.fn.input("Due (YYYY-MM-DD): ", default)
          input = (input or ""):gsub("^%s+", ""):gsub("%s+$", "")
          if input == "" then
            return "" -- or nil, if your caller prefers
          end
          return "[due:: " .. input .. "]"
        end,
        tags = function()
          local input = vim.fn.input("Tags (comma separated): ")
          if input == "" then return "" end
          local tags = {}
          for tag in input:gmatch("[^,]+") do
            local trimmed = tag:match("^%s*(.-)%s*$")
            if trimmed ~= "" then
              table.insert(tags, "  - " .. trimmed)
            end
          end
          return table.concat(tags, "\n")
        end,
      },
      customizations = {
        personal_todo = {
          notes_subdir = "personal/todo",
          note_id_func = function()
            local week_id = os.date("%Y-W%V")
            return week_id
          end,
        },
        personal_note = {
          notes_subdir = "personal/notes",
          note_id_func = function(title)
            local date = os.date("%Y-%m-%d")
            local slug = title and title:gsub(" ", "_"):lower() or "untitled"
            return string.format("%s_%s", slug, date)
          end,
        },
        spontivly_todo = {
          notes_subdir = "spontivly/todo",
          note_id_func = function()
            local week_id = os.date("%Y-W%W")
            return week_id
          end,
        },
        spontivly_note = {
          notes_subdir = "spontivly/notes",
          note_id_func = function(title)
            local date = os.date("%Y-%m-%d")
            local slug = title and title:gsub(" ", "_"):lower() or "untitled"
            return string.format("%s_%s", slug, date)
          end,
        },
      },
    },
  },
  config = function(_, opts)
    require("obsidian").setup(opts)

    vim.keymap.set("n", "<M-CR>", function()
      local bufnr = 0
      local row = vim.api.nvim_win_get_cursor(0)[1]
      local line = (vim.api.nvim_buf_get_lines(bufnr, row - 1, row, false)[1] or "")

      local stamp_pat = "%s*%[completion::.-%]"
      local has_x = line:match("%[x%]") ~= nil

      if has_x then
        -- [x] -> [ ] and remove stamp
        line = line:gsub("%[x%]", "[ ]", 1)
        line = line:gsub(stamp_pat, "")
      else
        -- [ ] -> [x] and add stamp (once)
        line = line:gsub("%[%s%]", "[x]", 1)
        if not line:match("%[completion::.-%]") then
          line = line .. string.format(" [completion:: %s]", os.date("%Y-%m-%d"))
        end
      end

      vim.api.nvim_buf_set_lines(bufnr, row - 1, row, false, { line })
      vim.cmd("silent! write")
    end, { desc = "Obsidian: toggle checkbox + completion + save" })
    vim.api.nvim_create_autocmd("User", {
      pattern = "ObsidianNoteEnter",
      callback = function()
        local api = require("obsidian.api")

        vim.keymap.set("n", "<leader>o", function() vim.cmd("Obsidian open") end)
        vim.keymap.set("n", "<CR>", function()
          local link = api.cursor_link() -- returns link, link_type or nil
          if link ~= nil then
            vim.cmd("Obsidian follow_link vsplit")
          else
            api.smart_action()
          end
        end, { buffer = true, desc = "Obsidian smart_action (vsplit links)" })
      end,
    })
  end
}
