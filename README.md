# Markdown FileId

A Neovim plugin that adds a file ID key/value pair to the front matter section of a markdown file. If the file doesn't have a front matter section, it will be added along with the ID field.

The plugin is intended to solve the problem of needing a way of associating a (reasonably) permanent ID with a markdown file that may get renamed or moved within the file system. It's (soon to be) a dependency of (converse.nvim)[https://github.com/scossar/converse.nvim].

## Requirements

Neovim `>= 0.9.0`

## Installation

### Using lazy.nvim

```lua
{
    "scossar/markdown-fileid.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
}
```

## Configuration

The key that is used for the file ID defaults to `"file_id"`. This can be configured when installing the plugin:

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

## Notes

The ID that is generated is the concatenated `file_base_name`, `timestamp`, and a random hex value:

```lua
local function generate_id(base_name)
  local timestamp = vim.fn.strftime("%Y%m%d_%H%M%S")
  -- generates a hex number between 0 and 65535
  local random_suffix = string.format("%04x", math.random(0, 0xffff))
  return string.format("%s_%s_%s", base_name, timestamp, random_suffix)
end
```
The plugin only supports front matter in the YAML format.
