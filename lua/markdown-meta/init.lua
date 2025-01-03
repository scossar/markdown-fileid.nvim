local config = require("markdown-meta.config")
local M = {}

function M.setup(opts)
  config.setup(opts)
end

local function is_valid_buffer(bufnr)
  return bufnr and vim.api.nvim_buf_is_valid(bufnr)
end

local function generate_id(base_name)
  local timestamp = vim.fn.strftime("%Y%m%d_%H%M%S")
  -- generates a hex number between 0 and 65535
  local random_suffix = string.format("%04x", math.random(0, 0xffff))
  return string.format("%s_%s_%s", base_name, timestamp, random_suffix)
end

local function parse_filename(bufnr)
  local buffer_path = vim.api.nvim_buf_get_name(bufnr)
  -- ":t" gets the tail, ":r" removes the file extension
  local base_name = vim.fn.fnamemodify(buffer_path, ":t:r")
  -- handle filenames with spaces
  return base_name:gsub("%s+", "_")
end

local function has_front_matter(bufnr)
  if not is_valid_buffer(bufnr) then
    vim.notify("Invalid buffer", vim.log.levels.ERROR)
    return
  end

  local lines = vim.api.nvim_buf_get_lines(bufnr, 0, 10, false)

  if #lines < 2 then
    return false
  end

  if lines[1] ~= "---" then
    return false
  end

  for i = 2, #lines do
    if lines[i] == "---" then
      local content = table.concat(lines, "\n", 2, i - 1)
      if content:match("%S") then
        return true
      end
    end
  end
  return false
end

local function insert_front_matter(bufnr)
  local file_name = parse_filename(bufnr)
  local file_id = generate_id(file_name)
  local front_matter = { "---" }
  table.insert(front_matter, string.format("ID: %s", file_id))
  table.insert(front_matter, "---")
  table.insert(front_matter, "")
  vim.api.nvim_buf_set_lines(bufnr, 0, 0, false, front_matter)
  return true
end

local function insert_id_field(bufnr)
  local file_name = parse_filename(bufnr)
  local file_id = generate_id(file_name)
  local id_field = { string.format("ID: %s", file_id) }
  vim.api.nvim_buf_set_lines(bufnr, 1, 1, false, id_field)
end

function M.get_field(field_name, bufnr)
  if not is_valid_buffer(bufnr) then
    vim.notify("Invalid buffer", vim.log.levels.ERROR)
    return
  end

  local first_lines = vim.api.nvim_buf_get_lines(bufnr, 0, 10, false)
  local in_front_matter = false

  for _, line in ipairs(first_lines) do
    if line:match("^%-%-%-") then
      in_front_matter = not in_front_matter
      goto continue
    end

    if in_front_matter then
      local value = line:match("^" .. field_name .. ":%s*(.+)$")
      if value then
        return value
      end
    end

    ::continue::
  end
  return nil
end

--- just hacking things together here
function M.maybe_add_meta()
  local bufnr = vim.api.nvim_get_current_buf()
  if not is_valid_buffer(bufnr) then
    vim.notify("Invalid buffer", vim.log.levels.ERROR)
    return
  end

  local front_matter_exists = has_front_matter(bufnr)
  if not front_matter_exists then
    insert_front_matter(bufnr)
    return true
  end

  local id_exists = M.get_field("ID", bufnr)
  if id_exists then
    return true
  end

  insert_id_field(bufnr)

  return true
end

return M
