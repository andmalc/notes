# Neovim Macro Recording and TS config

## 1. How to Record a Neovim Macro

### Basic Workflow

| Step | Keystroke | Description |
| :--- | :--- | :--- |
| **Start recording** | `q{register}` | Press `q` followed by any lowercase letter (e.g., `qa` to record into register `a`). |
| **Perform actions** | *keystrokes* | Perform whatever edits, motions, or commands you want to capture. |
| **Stop recording** | `q` | Press `q` while in Normal mode to finish. |

> [!NOTE]
> When recording, you will see `recording @a` in the bottom command/status line.

### Playing Back the Macro

* **Run once:** `@{register}` (e.g., `@a`)
* **Repeat last run:** `@@`
* **Run multiple times:** `{count}@{register}` (e.g., `10@a` runs it 10 times)

### Running Across Multiple Lines

#### Visual Selection
Select lines with `V` (Visual Line mode) and apply the macro across all selected lines:
```vim
:'<,'>normal @a
```
*(When you press `:` with lines selected, `:'<,'>` is automatically inserted; just type `normal @a` and press <kbd>Enter</kbd>.)*

#### Whole File / Pattern
Run over every line matching a pattern:
```vim
:g/pattern/normal @a
```

### Best Practices & Pro Tips

* **Normalize cursor position:** Always start your macro with a predictable motion like `0` (or `^`) to jump to the start of the line, and end with `j` (or movement to the next target).
* **Append to an existing macro:** Use the uppercase version of the register (e.g., `qA` to append new actions to register `a`).
* **Edit an existing macro:**
  1. Paste register contents into a buffer: `"ap`
  2. Edit the keystrokes as text.
  3. Yank back into the register: `"ay$` (or `"add` for a full line without newline).

---

## 2. Insert Two Spaces When Tab Key is Pressed in Neovim

Configure `expandtab`, `tabstop`, `softtabstop`, and `shiftwidth`.

### Configuration Files

#### Lua (`init.lua`)
```lua
vim.opt.expandtab = true   -- Convert tabs to spaces
vim.opt.tabstop = 2       -- Width of a hard tabstop (visual representation)
vim.opt.softtabstop = 2   -- Number of spaces inserted when pressing <Tab>
vim.opt.shiftwidth = 2    -- Number of spaces used for indentation (>>, <<, ==)
```

#### Vimscript (`init.vim`)
```vim
set expandtab
set tabstop=2
set softtabstop=2
set shiftwidth=2
```

### For the Current Session / Buffer Only

Run this in command mode:
```vim
:set expandtab tabstop=2 softtabstop=2 shiftwidth=2
```

### What Each Option Does

| Option | Purpose |
| :--- | :--- |
| `expandtab` | Replaces the literal `<Tab>` character with space characters. |
| `softtabstop=2` | Makes <kbd>Tab</kbd> insert 2 spaces and <kbd>Backspace</kbd> delete 2 spaces at once when indented. |
| `shiftwidth=2` | Controls indentation size for operators like `>>`, `<<`, and auto-indentation. |
| `tabstop=2` | Defines how many spaces an existing literal `\t` character occupies visually. |

### Setting It for Specific Filetypes Only

If you only want 2 spaces for certain filetypes (e.g., Markdown, Lua, YAML):

#### In `init.lua`:
```lua
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "markdown", "lua", "yaml", "json" },
  callback = function()
    vim.opt_local.expandtab = true
    vim.opt_local.tabstop = 2
    vim.opt_local.softtabstop = 2
    vim.opt_local.shiftwidth = 2
  end,
})
```

Or place `setlocal expandtab tabstop=2 softtabstop=2 shiftwidth=2` inside `~/.config/nvim/after/ftplugin/<filetype>.vim` (or `.lua`).