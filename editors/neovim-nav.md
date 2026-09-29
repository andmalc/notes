---
type: note
title: Neovim Navigation Shortcuts and Session Export
tags: [editors, cli]
---

# Chat Export: Neovim Navigation

**Date:** 2026-07-02 – 2026-09-15  
**Session ID:** `6e5c06c6-2d01-4eed-bdf0-243a237862bc`

---

## Turn 1: Neovim Navigation Shortcuts

### User
> nvim shortcuts for jumping between previous cursor movement locations in a file.

### Assistant
In Neovim (and Vim), you can navigate your jump history using the **jump list** and the **change list**.

#### 1. The Jump List (Cursor Movements)
Neovim automatically records significant cursor movements (like searches, page scrolls, or jumps to line numbers) in a jump list.

* **`<Ctrl-o>`**: Jump to the **older** (previous) cursor location.
* **`<Ctrl-i>`** (or **`<Tab>`** in some terminal setups): Jump to the **newer** (next) cursor location.
* **`:jumps`**: Display the entire jump list for the current session.
* **`<Ctrl-t>`**: Jump back to the older entry in the tag stack (specifically when using tag jumps like `Ctrl-]` on a symbol).

---

#### 2. The Change List (Modification Locations)
If you specifically want to jump between locations where you actually **edited/modified** the text (rather than just moved the cursor):

* **`g;`**: Jump to the **older** edit location.
* **`g,`**: Jump to the **newer** edit location.
* **`:changes`**: Display the list of change locations.

---

#### 3. Quick Jumps to Previous Positions
* **`''`** (two single quotes) or **`` `` ``** (two backticks): Jump back to the exact position before the last jump.
* **`'.`** or **``.``**: Jump to the exact position of the last modification.
* **`'^`**: Jump to the position of the cursor when last leaving Insert mode.


