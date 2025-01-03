vim.keymap.set("n", "<leader>pr", function()
  -- reload modules
  require("plenary.reload").reload_module("markdown-meta")

  -- -- clear module cache
  package.loaded["markdown-meta"] = nil
  -- package.loaded["converse"] = nil
  --
  -- -- reload and reconfigure
  require("markdown-meta").setup({
    config = {},
  })
  -- require("converse").setup({})

  vim.notify("Markdown-meta reloaded")
end, { desc = "Reload markdown-meta" })

vim.api.nvim_create_user_command("MarkdownMetaInitialize", function()
  require("markdown-meta").maybe_add_meta()
end, { desc = "Add front matter to markdown file" })
