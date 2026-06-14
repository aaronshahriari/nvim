-- Read/write Confluence Data Center pages without leaving Neovim.
-- Thin wrapper around the `confluence` CLI (bin/confluence in the dotfiles).
--
--   :ConfluenceEdit <id|url>    download a page as Markdown and open it
--   :ConfluencePush [message]   convert the current buffer back and PUT a new version
--   :ConfluenceRefresh[!]       re-fetch the latest version of the current page
--                               (! discards local edits)
--   :ConfluenceList <SPACEKEY>  list pages in a space (to find an id)
--
-- Requires CONFLUENCE_TOKEN (a Personal Access Token) in the environment that
-- launched nvim. Pages live under stdpath('data')/confluence so the sidecar
-- metadata files sit next to their Markdown.
return function()
  local dir = vim.fn.stdpath("data") .. "/confluence"
  vim.fn.mkdir(dir, "p")

  local function run(args, cwd)
    local res = vim.system({ "confluence", unpack(args) }, { text = true, cwd = cwd }):wait()
    if res.code ~= 0 then
      vim.notify("confluence: " .. (res.stderr ~= "" and res.stderr or res.stdout), vim.log.levels.ERROR)
      return nil
    end
    return res.stdout
  end

  vim.api.nvim_create_user_command("ConfluenceEdit", function(opts)
    local out = run({ "get", opts.args }, dir)
    if not out then return end
    local file = out:match("^(%S+)")
    if not file then
      vim.notify("confluence: unexpected output: " .. out, vim.log.levels.ERROR)
      return
    end
    vim.cmd.edit(dir .. "/" .. file)
    vim.notify(vim.trim(out))
  end, { nargs = 1, desc = "Download a Confluence page as Markdown" })

  vim.api.nvim_create_user_command("ConfluencePush", function(opts)
    local file = vim.api.nvim_buf_get_name(0)
    if vim.fn.filereadable(file .. ".confl.json") == 0 then
      vim.notify("confluence: this buffer wasn't fetched via :ConfluenceEdit", vim.log.levels.ERROR)
      return
    end
    vim.cmd.write()
    local args = { "put", vim.fn.fnamemodify(file, ":t") }
    if opts.args ~= "" then
      vim.list_extend(args, { "-m", opts.args })
    end
    local out = run(args, vim.fn.fnamemodify(file, ":h"))
    if out then vim.notify(vim.trim(out)) end
  end, { nargs = "?", desc = "Push the current buffer back to Confluence as a new version" })

  vim.api.nvim_create_user_command("ConfluenceRefresh", function(opts)
    local file = vim.api.nvim_buf_get_name(0)
    if vim.fn.filereadable(file .. ".confl.json") == 0 then
      vim.notify("confluence: this buffer wasn't fetched via :ConfluenceEdit", vim.log.levels.ERROR)
      return
    end
    if vim.bo.modified and not opts.bang then
      vim.notify("confluence: unsaved edits -- :w first, or :ConfluenceRefresh! to discard", vim.log.levels.WARN)
      return
    end
    local args = { "pull", vim.fn.fnamemodify(file, ":t") }
    if opts.bang then table.insert(args, "--force") end
    local out = run(args, vim.fn.fnamemodify(file, ":h"))
    if not out then return end
    vim.cmd.edit({ bang = true })  -- reload buffer from the refreshed file
    vim.notify(vim.trim(out))
  end, { bang = true, desc = "Re-fetch the latest version of the current Confluence page" })

  vim.api.nvim_create_user_command("ConfluenceList", function(opts)
    local out = run({ "ls", opts.args }, dir)
    if out then vim.notify(vim.trim(out)) end
  end, { nargs = 1, desc = "List pages in a Confluence space" })
end
