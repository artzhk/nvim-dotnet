-- adapted from https://stackoverflow.com/a/11204889 (CC BY-SA 4.0)
local function file_exists(file)
  local f = io.open(file, "rb")
  if f then f:close() end
  return f ~= nil
end

local function lines_from(file)
  local cfg = {}
  if not file_exists(file) then return cfg end
  for line in io.lines(file) do
    local k, v = line:match("^%s*([%w_]+)%s*=%s*(.-)%s*$")
    if k then cfg[k] = v end
  end
  return cfg
end

local editorconfig = lines_from(".editorconfig")
return editorconfig
