require("aaronshahriari")

local uv = vim.uv or vim.loop

-- single-file override: NVIM_EXTRA=/abs/path/to/extra.lua
do
  local p = os.getenv("NVIM_EXTRA")
  if p and uv.fs_stat(p) then
    local ok, err = pcall(dofile, p)
    if not ok then vim.notify("NVIM_EXTRA error: " .. tostring(err), vim.log.levels.WARN) end
  end
end
