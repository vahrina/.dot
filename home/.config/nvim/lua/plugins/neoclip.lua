return {
  "AckslD/nvim-neoclip.lua",
  dependencies = {
    { "nvim-telescope/telescope.nvim" },
  },
  event = "BufReadPre",
  config = function()
    require("neoclip").setup()
    require("telescope").load_extension("neoclip")
    vim.keymap.set("n", "<leader>Y", "<cmd>Telescope neoclip<cr>")
  end,
}
