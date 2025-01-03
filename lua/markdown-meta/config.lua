local M = {}

local defaults = {
  default_format = "yaml",
  auto_initialize = false,
  required_fields = {},
  default_fields = {},
}

M.options = vim.deepcopy(defaults)

function M.setup(opts)
  M.options = vim.tbl_deep_extend("force", vim.deepcopy(defaults), opts or {})
end

return M
