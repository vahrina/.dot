return {
  "folke/twilight.nvim",
  keys = {
    { "<leader>tw", "<cmd>Twilight<cr>", desc = "toggle twilight" },
  },
  event = "BufReadPost",
  opts = {
    context = 6,
    treesitter = true,
    dimming = {
      alpha = 0.25,
      color = { "Normal", "#cdd6f4" },
      inactive = false,
    },
    expand = {
      "function",
      "method",
      "table",
      "if_statement",
    },
    exclude = { "txt", "help", "markdown" },
  },
  config = function(_, opts)
    require("twilight").setup(opts)
    vim.cmd("TwilightEnable")
  end,
}
