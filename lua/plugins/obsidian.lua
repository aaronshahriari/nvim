return function()
  vim.pack.add({
    { src = "https://github.com/nvim-lua/plenary.nvim" },
    { src = "https://github.com/obsidian-nvim/obsidian.nvim" },
  })

  local personal_vault = "~/vaults/vault_personal"
  local obs = require("obsidian")
  obs.setup({
    attachments = {
      folder = "/attachments",
    },
    legacy_commands = false,
    workspaces = {
      {
        name = "personal",
        path = personal_vault,
      },
    },
    ui = {
      enable = false
    },
    picker = {
      name = "telescope.nvim",
    },
    note_id_func = function(title)
      if title ~= nil then
        -- slugify: lowercase, spaces/punct → dashes
        return title:gsub(" ", "-"):gsub("[^A-Za-z0-9-]", ""):lower()
      end
      -- fallback if no title given: timestamp
      return tostring(os.time())
    end,
    checkbox = {
      enabled = true,
      create_new = true,
      order = { " ", "x", "?" },
    },
  })
  -- vim.keymap.set("n", "<C-CR>", require("obsidian.api").smart_action, { buffer = true })
  vim.keymap.set("n", "<C-CR>", function()
    require("obsidian.api").follow_link(nil, { open_strategy = "vsplit" })
  end)

  vim.api.nvim_create_autocmd("FileType", {
    pattern = "markdown",
    callback = function(ev)
      vim.keymap.set("n", "<leader>nn", function()
        local vault = vim.fn.expand(personal_vault)
        local dirs = vim.fn.systemlist("find " .. vault .. " -type d -not -path '*/.*'")

        require("telescope.pickers").new({}, {
          prompt_title = "New note in folder",
          finder = require("telescope.finders").new_table({
            results = dirs,
            entry_maker = function(path)
              local rel = path:gsub("^" .. vim.pesc(vault) .. "/?", "")
              if rel == "" then rel = "." end -- the vault root itself
              return {
                value = rel,                  -- what we pass to ObsidianNew
                display = rel,                -- what shows in the picker
                ordinal = rel,                -- what the sorter matches on
              }
            end,
          }),
          sorter = require("telescope.config").values.generic_sorter({}),
          attach_mappings = function(bufnr, map)
            local actions = require("telescope.actions")
            local state = require("telescope.actions.state")
            actions.select_default:replace(function()
              actions.close(bufnr)
              local rel = state.get_selected_entry().value
              local title = vim.fn.input("Note title: ")
              local prefix = (rel == ".") and "" or (rel .. "/")
              vim.cmd("Obsidian new " .. prefix .. title)
            end)
            return true
          end,
        }):find()
      end, { buffer = ev.buf, desc = "New Obsidian note in folder" })
    end,
  })
end
