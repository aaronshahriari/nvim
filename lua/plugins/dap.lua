return function()
  vim.pack.add({
    { src = "https://github.com/mfussenegger/nvim-dap" },
    { src = "https://github.com/rcarriga/nvim-dap-ui" },
    { src = "https://github.com/nvim-neotest/nvim-nio" },
    { src = "https://github.com/jay-babu/mason-nvim-dap.nvim" },
    { src = "https://github.com/theHamsta/nvim-dap-virtual-text" },
    { src = "https://github.com/mfussenegger/nvim-dap-python" },
  })

  local dap = require("dap")

  require("dap-python").setup(vim.fn.expand("~/.virtualenvs/debugpy/bin/python"))

  dap.configurations.python = {
    {
      type = "python",
      request = "launch",
      name = "Launch Module",
      module = function()
        local rel = vim.fs.basename(vim.fn.getcwd())
        rel = rel:gsub("-", "_")
        return rel
      end,
      pythonPath = function()
        local cwd = vim.fn.getcwd()
        if vim.fn.executable(cwd .. "/venv/bin/python") == 1 then
          return cwd .. "/venv/bin/python"
        elseif vim.fn.executable(cwd .. "/.venv/bin/python") == 1 then
          return cwd .. "/.venv/bin/python"
        else
          return "/usr/bin/python"
        end
      end,
    },
  }

  vim.fn.sign_define("DapBreakpoint", {
    text = "",
    texthl = "DiagnosticSignError",
    linehl = "",
    numhl = "",
  })

  vim.fn.sign_define("DapBreakpointRejected", {
    text = "",
    texthl = "DiagnosticSignError",
    linehl = "",
    numhl = "",
  })

  vim.fn.sign_define("DapStopped", {
    text = "",
    texthl = "DiagnosticSignWarn",
    linehl = "Visual",
    numhl = "DiagnosticSignWarn",
  })

  local opts = { noremap = true, silent = true }

  vim.keymap.set("n", "<leader>db", function()
    dap.toggle_breakpoint()
  end, opts)

  vim.keymap.set("n", "<leader>dc", function()
    dap.continue()
  end, opts)

  vim.keymap.set("n", "<leader>do", function()
    dap.step_over()
  end, opts)

  vim.keymap.set("n", "<leader>di", function()
    dap.step_into()
  end, opts)

  vim.keymap.set("n", "<leader>dO", function()
    dap.step_out()
  end, opts)

  vim.keymap.set("n", "<leader>dq", function()
    dap.terminate()
  end, opts)
end
