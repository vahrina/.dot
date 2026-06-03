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

    timeout = 1,
    maxkeys = 5,
    position = "bottom-right",
    show_count = true,
  },
  config = function(_, opts)
    require("showkeys").setup(opts)
    vim.cmd("ShowkeysToggle")
  end,
}
