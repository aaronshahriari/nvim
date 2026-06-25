return function()
  -- Local plugin (not yet published): https://github.com/<you>/azdo.nvim
  -- Loaded manually from the working copy at ~/github/azdo.nvim.
  -- Once it's pushed, swap this for: vim.pack.add({ { src = "https://github.com/<you>/azdo.nvim" } })
  local dir = vim.fn.expand("~/github/azdo.nvim")
  if vim.fn.isdirectory(dir) == 0 then
    vim.notify("azdo.nvim not found at " .. dir, vim.log.levels.WARN)
    return
  end

  -- On-prem Azure DevOps Server (not cloud dev.azure.com): point azdo.nvim at the
  -- collection root, and authenticate with the PAT `az` already stored in the macOS
  -- keychain — so there's no token committed to this repo. api-version 7.1 works as-is.
  vim.g.azdo_base_url = "https://tfs.rjf.com/tfs/RJ_Git_Collection"
  local pat = vim.fn.system({
    "security",
    "find-generic-password",
    "-s",
    "azdevops-cli:https://tfs.rjf.com/tfs",
    "-w",
  })
  if vim.v.shell_error == 0 and vim.trim(pat) ~= "" then
    vim.g.azdo_pat = vim.trim(pat)
  end

  vim.opt.runtimepath:append(dir)
  -- plugins/init.lua runs mid-startup, so source the plugin file explicitly to
  -- register :Azdo + the <Plug>(azdo-*) maps deterministically.
  vim.cmd("runtime! plugin/azdo.lua")
  -- Generate helptags so `:help azdo` works (best-effort).
  pcall(vim.cmd, "helptags " .. dir .. "/doc")

  -- Entry point: `:Azdo` (status), `:Azdo <id|url|sha>`. In-buffer maps are set
  -- automatically; `g?` lists them.
  vim.keymap.set("n", "<leader>q", function()
    vim.cmd("tabnew")
    vim.cmd("Azdo")
  end, { desc = "Azure DevOps: status (new tab)" })

  -- Create a PR from the current branch (prompts for target, then title/body).
  vim.keymap.set("n", "<leader>Q", "<Plug>(azdo-create)", { desc = "Azure DevOps: create PR" })
end
