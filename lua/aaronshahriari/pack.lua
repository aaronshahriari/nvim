local actions = { "clean", "list", "remove", "update" }

local function get_plugins()
  local plugins = vim.pack.get(nil, { info = false })
  table.sort(plugins, function(a, b) return a.spec.name < b.spec.name end)
  return plugins
end

local function complete(arglead, cmdline, cursorpos)
  local before_cursor = cmdline:sub(1, cursorpos)
  local body = before_cursor:match("^%s*Pack%s+(.*)$")
  local candidates = actions

  if body and body:find("%s") then
    candidates = vim.iter(get_plugins())
        :map(function(plugin) return plugin.spec.name end)
        :totable()
  end

  return vim.tbl_filter(function(item)
    return vim.startswith(item, arglead)
  end, candidates)
end

vim.api.nvim_create_user_command("Pack", function(opts)
  local action = opts.fargs[1]
  local names = vim.list_slice(opts.fargs, 2)

  if action == "update" then
    vim.pack.update(#names > 0 and names or nil)
  elseif action == "remove" then
    if #names == 0 then
      vim.notify("Usage: Pack remove <plugin>...", vim.log.levels.ERROR)
      return
    end
    vim.pack.del(names)
  elseif action == "clean" then
    local stale = vim.iter(get_plugins())
        :filter(function(plugin) return not plugin.active end)
        :map(function(plugin) return plugin.spec.name end)
        :totable()

    if #stale == 0 then
      vim.notify("No inactive plugins", vim.log.levels.INFO, { title = "Pack" })
      return
    end

    vim.pack.del(stale)
    vim.notify("Removed: " .. table.concat(stale, ", "), vim.log.levels.INFO, { title = "Pack" })
  elseif action == "list" then
    local lines = vim.iter(get_plugins())
        :map(function(plugin)
          return string.format("%-8s %s", plugin.active and "active" or "inactive", plugin.spec.name)
        end)
        :totable()
    vim.notify(table.concat(lines, "\n"), vim.log.levels.INFO, { title = "Pack plugins" })
  else
    vim.notify("Usage: Pack {clean|list|remove|update}", vim.log.levels.ERROR)
  end
end, {
  nargs = "*",
  complete = complete,
  desc = "Manage plugins with vim.pack",
})
