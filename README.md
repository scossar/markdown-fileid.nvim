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

The key that is used for the UUID defaults to `"file_id"`. This can be configured when installing the plugin:

```lua
{
    "scossar/markdown-fileid.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {
        id_key = "uuid",
    },
}
```
## Functions

The plugin provides the following function that can be used by other plugins:

### `ensure_file_id()`

Ensures that a file ID exists in the markdown file's front matter. If no front matter exists, it creates one with a file ID. If front matter exists but has no file ID, it adds one.

### `get_field(bufnr, field_name)`

Retrieves a field value from the markdown file's front matter.

Parameters:
- `bufnr`: buffer number of the markdown file
- `field_name`: name of the field to retrieve

Returns: the field value if found, `nil` otherwise

Example usage in another plugin:

```lua
local fileid = require("markdown-fileid")
local id = fileid.get_field(0, "file_id") -- get file_id from current buffer
```

## Commands

- `:MarkdownFileIdAddField`: calls `ensure_file_id()`

