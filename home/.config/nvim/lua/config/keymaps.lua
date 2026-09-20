-- default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
local map = vim.keymap.set

-- treat <C-c> as InsertLeave
map("i", "<C-c>", "<Esc>")

-- telescope
map({ "n", "v" }, "<leader>p", "<cmd>Telescope registers<cr>")
map({ "n", "v" }, "<leader>h", "<cmd>Telescope commad_history<cr>")

-- diffs
map("n", "<leader>go", function()
  require("mini.diff").toggle_overlay(0)
end, { desc = "git diff overlay" })
