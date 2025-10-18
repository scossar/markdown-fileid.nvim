local M = {}

M.options = {
  id_key = "file_id",
}

function M.setup(opts)
  M.options = vim.tbl_deep_extend("force", M.options, opts or {})
end

return M
