return function()
  vim.pack.add({
    { src = "https://github.com/tpope/vim-fugitive" }
  })
  vim.keymap.set("n", "<leader>gc", function()
    vim.cmd("tabnew")
    vim.cmd("Gclog")
  end)
  vim.keymap.set("n", "<C-a>", function()
    -- find an open fugitive summary buffer
    for _, win in ipairs(vim.api.nvim_list_wins()) do
      local buf = vim.api.nvim_win_get_buf(win)
      if vim.bo[buf].filetype == "fugitive" then
        vim.api.nvim_win_close(win, false)
        return
      end
    end
    vim.cmd("Git")
    vim.cmd("resize 15")
    vim.cmd("setlocal winfixheight")
  end, { desc = "Toggle fugitive status" })
  local AaronShahriari = vim.api.nvim_create_augroup("AaronShahriari", {})
  local autocmd = vim.api.nvim_create_autocmd
  autocmd("BufWinEnter", {
    group = AaronShahriari,
    pattern = "*",
    callback = function()
      if vim.bo.ft ~= "fugitive" then
        return
      end

      local bufnr = vim.api.nvim_get_current_buf()
      local opts = { buffer = bufnr, remap = false }
      vim.keymap.set("n", "<leader>p", function()
        vim.cmd.Git('push')
        vim.cmd(':q')
      end, opts)

      -- rebase always
      vim.keymap.set("n", "<leader>P", function()
        vim.cmd.Git({ 'pull', '--rebase' })
      end, opts)

      vim.keymap.set("n", "<leader>t", ":Git push -u origin ", opts);
    end,
  })
  -- Disable textwidth for commit messages
  autocmd("BufRead", {
    group = AaronShahriari,
    pattern = "*/COMMIT_EDITMSG",
    callback = function()
      vim.opt_local.textwidth = 0
    end,
  })
end
