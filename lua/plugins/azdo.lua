return function()
  -- Local plugin (not yet published): https://github.com/<you>/azdo.nvim
  -- Loaded manually from the working copy at ~/github/azdo.nvim.
  -- Once it's pushed, swap this for: vim.pack.add({ { src = "https://github.com/<you>/azdo.nvim" } })
  local dir = vim.fn.expand("~/github/azdo.nvim")
  if vim.fn.isdirectory(dir) == 0 then
    vim.notify("azdo.nvim not found at " .. dir, vim.log.levels.WARN)
    return
  end

  vim.opt.runtimepath:append(dir)
  -- plugins/init.lua runs mid-startup, so source the plugin file explicitly to
  -- register :Azdo + the <Plug>(azdo-*) maps deterministically.
  vim.cmd("runtime! plugin/azdo.lua")
  -- Generate helptags so `:help azdo` works (best-effort).
  pcall(vim.cmd, "helptags " .. dir .. "/doc")

  -- The PAT `az` stored in the macOS keychain — fetched once here, so no token
  -- is committed to this repo and azdo.nvim authenticates via HTTP Basic
  -- (no `az login` needed).
  local function keychain_pat()
    local out = vim.fn.system({
      "security", "find-generic-password",
      "-s", "azdevops-cli:https://tfs.rjf.com/tfs", "-w",
    })
    return vim.v.shell_error == 0 and vim.trim(out) or nil
  end

  -- RJ-specific custom work-item fields. Org-private (RaymondJames.ALM.*), so
  -- they live in my config, not in azdo.nvim's shipped defaults.
  local rj_extra = {
    { "Technical Analysis", "RaymondJames.ALM.TechnicalAnalysis" },
    { "RJ Comments",        "RaymondJames.ALM.Comments" },
    { "Business Impact",    "RaymondJames.ALM.Impact" },
  }

  require("azdo").setup({
    -- On-prem Azure DevOps Server (not cloud dev.azure.com): collection root.
    base_url = "https://tfs.rjf.com/tfs/RJ_Git_Collection",
    project  = "KnowledgebasePlatform", -- one-part form, on-prem
    pat      = keychain_pat(),

    workitem_sections = {
      default = {
        { "Description",         "System.Description" },
        { "Acceptance Criteria", "Microsoft.VSTS.Common.AcceptanceCriteria" },
        rj_extra[1], rj_extra[2], rj_extra[3],
      },
      Bug = {
        { "Repro Steps",         "Microsoft.VSTS.TCM.ReproSteps" },
        { "System Info",         "Microsoft.VSTS.TCM.SystemInfo" },
        { "Acceptance Criteria", "Microsoft.VSTS.Common.AcceptanceCriteria" },
        rj_extra[1], rj_extra[2], rj_extra[3],
      },
    },

    -- Command palette on <leader>w (sets the mapping for me).
    menu = "<leader>w",
  })

  -- Status in a new tab.
  vim.keymap.set("n", "<leader>q", function()
    vim.cmd("tabnew")
    vim.cmd("Azdo")
  end, { desc = "Azure DevOps: status (new tab)" })

  -- Create a PR from the current branch (prompts for target, then title/body).
  vim.keymap.set("n", "<leader>Q", "<Plug>(azdo-create)", { desc = "Azure DevOps: create PR" })
end
