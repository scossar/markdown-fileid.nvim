# Markdown FileId

A Neovim plugin that adds a UUID to the front matter section of a markdown file. If the file doesn't have a front matter section, it will be added along with the UUID.

The plugin required Neovim `>= 0.9.0`

## Installation

### Using lazy.nvim

```lua
{
    "scossar/markdown-fileid.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
}
```

## Configuration

The key that is used for the UUID defaults to `"file_id"`. Use the `setup` function to set it to a different value:

```lua
{
    "scossar/markdown-fileid.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    require("markdown-fileid").setup({
        opts = {
            id_key = "uuid"
        }
    })
}

```
