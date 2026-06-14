return function()
  vim.pack.add({
    { src = "https://github.com/igorlfs/nvim-dap-view", version = "v1.2.0" },
  })

  require("dap-view").setup({
    winbar = {
      show = true,
      sections = { "watches", "scopes", "exceptions", "breakpoints", "threads", "repl" },
      default_section = "breakpoints",
      show_keymap_hints = true,
      base_sections = {
        breakpoints = { label = "Breakpoints", keymap = "B" },
        scopes = { label = "Scopes", keymap = "S" },
        exceptions = { label = "Exceptions", keymap = "E" },
        watches = { label = "Watches", keymap = "W" },
        threads = { label = "Threads", keymap = "T" },
        repl = { label = "REPL", keymap = "R" },
        sessions = { label = "Sessions", keymap = "K" },
        console = { label = "Console", keymap = "C" },
      },
      custom_sections = {},
      controls = {
        enabled = false,
        position = "below",
        buttons = {
          "play",
          "step_into",
          "step_over",
          "step_out",
          "step_back",
          "run_last",
          "terminate",
          "disconnect",
        },
        custom_buttons = {},
      },
    },
    windows = {
      size = 0.35,
      position = "below",
      terminal = {
        size = 0.5,
        position = "left",
        hide = {},
      },
    },
    icons = {
      collapsed = "󰅂 ",
      disabled = "",
      disconnect = "",
      enabled = "",
      expanded = "󰅀 ",
      filter = "󰈲",
      negate = " ",
      pause = "",
      play = "",
      run_last = "",
      step_back = "",
      step_into = "",
      step_out = "",
      step_over = "",
      terminate = "",
    },
    help = {
      border = nil,
    },
    render = {
      sort_variables = nil,
      threads = {
        format = function(name, lnum, path)
          return {
            { text = name, separator = " " },
            { text = path, hl = "FileName",  separator = ":" },
            { text = lnum, hl = "LineNumber" },
          }
        end,
        align = false,
      },
      breakpoints = {
        format = function(line, lnum, path)
          return {
            { text = path, hl = "FileName" },
            { text = lnum, hl = "LineNumber" },
            { text = line, hl = true },
          }
        end,
        align = false,
      },
    },
    switchbuf = "usetab,uselast",
    auto_toggle = false,
    follow_tab = false,
  })

  vim.keymap.set("n", "<leader>dt", function()
    vim.cmd("DapViewToggle")
  end, { noremap = true, silent = true })

  vim.keymap.set("n", "<leader>dr", function()
    vim.cmd("DapViewShow repl")
  end, { noremap = true, silent = true })

  vim.keymap.set("n", "<leader>dw", function()
    vim.cmd("DapViewJump watches")
  end, { noremap = true, silent = true })

  vim.keymap.set("n", "<leader>ds", function()
    vim.cmd("DapViewJump scopes")
  end, { noremap = true, silent = true })
end
