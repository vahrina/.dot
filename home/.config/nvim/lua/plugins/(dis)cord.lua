return {
  "vyfor/cord.nvim",
  event = "VeryLazy",
  opts = {
    editor = {
      client = "neovim",
      icon = "...",
    },
    display = {
      theme = "atom",
      flavor = "accent",
      swap_fields = false,
      swap_icons = false,
    },
    timestamp = {
      enabled = true,
      reset_on_idle = false,
    },
    idle = {
      enabled = true,
      timeout = 180000,
      smart_idle = false,
      show_status = true,
      details = "zz",
      state = nil,
      tooltip = false,
      image = "sleeping",
    },
    text = {
      editing = function(opts)
        return "[w] " .. opts.filename
      end,
      viewing = function(opts)
        return "[r] " .. opts.filename
      end,
      file_browser = "/",
      plugin_manager = "adding bloat",
      lsp = ":LspInfo",
      vcs = "git push -f",
      terminal = "$ _",
      dashboard = ">_",
    },
  },
}
