-- TODO: dev only, remove soon
vim.keymap.set("n", "<leader>pr", function()
  -- reload modules
  require("plenary.reload").reload_module("markdown-fileid")

  -- -- clear module cache
  package.loaded["markdown-fileid"] = nil
  package.loaded["markdown-fileid"] = nil
  --
  -- -- reload and reconfigure
  require("markdown-fileid").setup({})

  vim.notify("Markdown-fileid reloaded")
end, { desc = "Reload markdown-fileid" })

vim.api.nvim_create_user_command("MarkdownFileIdAddField", function()
  require("markdown-fileid").ensure_file_id()
end, { desc = "Add front matter and/or file_id to markdown file" })
