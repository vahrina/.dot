return {
  "nvzone/showkeys",
  cmd = "ShowkeysToggle",
  event = "VimEnter",
  keys = {
    { "<leader>uk", "<cmd>ShowkeysToggle<cr>", desc = "show keys" },
  },
  opts = {
    winopts = {
      border = "rounded",
    },

    timeout = 3,
    maxkeys = 7,
    position = "top-right",
    show_count = true,
  },
  config = function(_, opts)
    require("showkeys").setup(opts)
    vim.cmd("ShowkeysToggle")
  end,
}
