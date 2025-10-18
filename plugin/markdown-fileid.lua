vim.api.nvim_create_user_command("MarkdownFileIdAddField", function()
  require("markdown-fileid").ensure_file_id()
end, { desc = "Add front matter and/or file_id to markdown file" })
