return {
  {
    "luukvbaal/nnn.nvim",
    keys = {
      { "<leader><leader>", "<cmd>NnnPicker<cr>", desc = "picker (nnn)" },
      { "<leader>e", "<cmd>NnnExplorer<cr>", desc = "explorer (nnn)" },
    },
    config = function()
      require("nnn").setup({
        replace_netrw = "explorer",
        picker = {
          style = { border = "single" },
        },
        windownav = { left = "<C-w>h", right = "<C-w>l" },
      })
    end,
  },
  -- disable folke's snacks or they fight D:
  {
    "folke/snacks.nvim",
    keys = {
      { "<leader><leader>", false },
      { "<leader>e", false },
    },
  },
}
