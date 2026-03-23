return {
  'nvim-orgmode/orgmode',
  event = 'VeryLazy',
  config = function()
    require('orgmode').setup({
      ui = {
        folds = {
          colored = false
        }
      },
      org_ellipsis = " [...]",
      win_split_mode = function(name)
        local is_agenda = name:match("orgagenda") ~= nil                            -- open in new tab view
        local is_capture = name:match("^/tmp/nvim%.aaronshahriari/.*%.org$") ~= nil -- open in float window

        local bufnr = vim.api.nvim_create_buf(false, false)
        vim.api.nvim_buf_set_name(bufnr, name)
        if is_capture then
          local fill = 0.8
          local width = math.floor((vim.o.columns * fill))
          local height = math.floor((vim.o.lines * fill))
          local row = math.floor((((vim.o.lines - height) / 2) - 1))
          local col = math.floor(((vim.o.columns - width) / 2))

          vim.api.nvim_open_win(bufnr, true, {
            relative = "editor",
            width = width,
            height = height,
            row = row,
            col = col,
            style = "minimal",
            border = "rounded"
          })
        elseif is_agenda then
          -- vim.cmd('enew')
          vim.api.nvim_win_set_buf(0, bufnr)
        else
          vim.cmd('split')
          vim.api.nvim_win_set_buf(0, bufnr)
        end
      end,
      org_time_stamp_rounding_minutes = 1,
      org_todo_keywords = { 'TODO(t)', 'PENDING(p)', '|', 'DONE(d)', 'CANCELLED(c)' },
      org_todo_keyword_faces = {
        TODO = ':foreground #34ed6f',
        DONE = ':foreground #eb4034',
        PENDING = ':foreground #36a1ff :slant italic',
        CANCELLED = ':foreground #6e6e6e'
      },
      org_agenda_files = {
        '~/Dropbox/org/inbox.org',
        '~/Dropbox/org/todo.org',
        '~/Dropbox/org/calendar.org',
        '~/Dropbox/org/personal-calendar/**/*.org',
        '~/Dropbox/org/spontivly-calendar/**/*.org',
        '~/Dropbox/org/notes.org',
        '~/Dropbox/org/roam/**/*.org',
      },
      -- agenda 3 day span
      org_agenda_span = 3,
      org_agenda_start_on_weekday = false,
      org_agenda_use_time_grid = true,
      org_agenda_current_time_string = '<- now',
      org_agenda_time_grid = {
        type = { 'today' },
        time_separator = '┄┄┄┄┄',
        time_label = '┄┄┄┄┄┄┄┄',
      },
      org_agenda_custom_commands = {
        o = {
          description = 'Overdue + Weekly agenda + All TODOs',
          types = {
            {
              type = 'tags_todo',
              org_agenda_overriding_header = ' Overdue',
              match = '+DUE<"<today>"',
              org_agenda_sorting_strategy = { 'priority-down', 'category-keep' },
            },
            {
              type = 'agenda',
              org_agenda_overriding_header = ' Weekly Schedule',
              org_agenda_span = 'week',
              org_agenda_start_on_weekday = false,
              org_agenda_sorting_strategy = { 'time-up', 'todo-state-up' },
            },
            {
              type = 'tags_todo',
              org_agenda_overriding_header = ' All TODOs',
              org_agenda_sorting_strategy = { 'todo-state-up', 'priority-down', 'category-keep' },
            },
            {
              type = "tags",
              org_agenda_overriding_header = " Weekly Completed",
              match = '+TODO="DONE"-daily+CLOSED>="<-7d>"',
            },
          },
        },
        n = {
          description = 'Notes',
          types = {
            {
              type = 'tags', -- IMPORTANT: notes are not TODOs
              match = '+TYPE="note"',
              org_agenda_overriding_header = 'Notes',
              org_agenda_sorting_strategy = { 'category-keep' },
            },
          },
        },
      },

      org_default_notes_file = '~/org/refile.org',
      org_capture_templates = {
        g = {
          description = 'Groceries',
          template = [[
** TODO Groceries :groceries:
SCHEDULED: %^t
:PROPERTIES:
:CREATED: %U
:END:
+ [ ] %?]],
          target = '~/Dropbox/org/todo.org',
          headline = 'Personal',
        },
        t = 'Todo',
        tp = {
          description = 'Personal',
          template = [[
** TODO %^{TASK} %^{TAGS}
SCHEDULED: %^T
:PROPERTIES:
:CREATED: %U
:END:
%?]],
          target = '~/Dropbox/org/todo.org',
          headline = 'Personal',
        },
        ts = {
          description = 'Spontivly',
          template = [[
** TODO %^{TASK} %^{TAGS}
SCHEDULED: %^T
:PROPERTIES:
:CREATED: %U
:END:
%?]],
          target = '~/Dropbox/org/todo.org',
          headline = 'Personal',
        },

        -- using ROAM
        --         n = 'Note',
        --         np = {
        --           template = [[
        -- * %^{TITLE} %^{TAGS}
        -- :PROPERTIES:
        -- :CREATED: %U
        -- :TYPE: note
        -- :END:
        -- %?]],
        --           target = '~/Dropbox/org/notes.org',
        --           headline = 'Personal'
        --         },
      }

    })
    vim.api.nvim_create_user_command('OrgExport', function()
      require('orgmode').action('org_export')
    end, {})
    -- vim.keymap.set('n', '<leader>eo', ":OrgSuperAgenda<CR>") -- org agenda
    vim.keymap.set('n', '<leader>ea', ":Org agenda<CR>")   -- org agenda
    vim.keymap.set('n', '<leader>eo', ":Org agenda o<CR>") -- org agenda
    vim.keymap.set('n', '<leader>r', ":Org capture<CR>")   -- capture todo
    -- vim.keymap.set('n', '<leader>n', ":Org capture n<CR>") -- capture note
    -- vim.keymap.set('n', '<leader>et', ":Org agenda t<CR>") -- org todo

    -- forcefully split window when hitting TAB in agenda
    vim.api.nvim_create_autocmd('FileType', {
      pattern = 'orgagenda',
      callback = function(args)
        vim.schedule(function()
          vim.keymap.set('n', '<TAB>', function()
            vim.cmd('set splitbelow')
            require('orgmode').action('agenda.goto_item')
          end, {
            buffer = args.buf,
            desc = 'Open agenda item in split below'
          })
        end)
      end,
    })

    -- in colorschemes.lua
    -- vim.api.nvim_create_autocmd("ColorScheme", {
    --   callback = function()
    --     vim.api.nvim_set_hl(0, "@org.agenda.header", { fg = "#737272", bold = true, italic = false })
    --     vim.api.nvim_set_hl(0, "@org.agenda.deadline", { fg = "#FFAAAA" })
    --     vim.api.nvim_set_hl(0, "@org.agenda.scheduled_past", { fg = "#ff8282" })
    --     vim.api.nvim_set_hl(0, "@org.agenda.scheduled", { fg = "#EBEBEB" })
    --     vim.api.nvim_set_hl(0, "@org.agenda.time_grid", { fg = "#424242" })
    --   end,
    -- })
  end,
}
