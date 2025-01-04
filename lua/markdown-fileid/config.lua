local M = {}

M.options = {
  id_key = "file_id",
}

function M.setup(opts)
  print("Setup called with opts:", vim.inspect(opts))
  M.options = vim.tbl_deep_extend("force", M.options, opts or {})
  print("Updated options:", vim.inspect(M.options))
end

return M
