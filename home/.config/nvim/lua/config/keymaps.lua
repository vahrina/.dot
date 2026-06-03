-- default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
local map = vim.keymap.set

-- indenting
map("v", "<", "<gv")
map("v", ">", ">gv")

-- buffers
map("n", "<S-h>", "<cmd>bp<cr>")
map("n", "<S-l>", "<cmd>bn<cr>")

-- treat <C-c> as InsertLeave
map("i", "<C-c>", "<Esc>")
