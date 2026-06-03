return {
  "nvimdev/dashboard-nvim",
  event = "VimEnter",
  config = function()
    local builtin = require("telescope.builtin")
    local telescope = require("telescope")

    telescope.load_extension("fzf")

    local ignore = { "^%.git/" }

    local layout = {
      previewer = true,
      layout_strategy = "vertical",
      layout_config = { preview_height = 0.45 },
      file_ignore_patterns = ignore,
    }

    local function pick(fn, opts)
      return function()
        fn(vim.tbl_extend("force", layout, opts or {}))
      end
    end

    require("dashboard").setup({
      theme = "hyper",
      config = {
        week_header = { enable = false },
        header = {},
        footer = {},
        project = { enable = true, limit = 6, label = " projects" },
        mru = { enable = true, limit = 6, label = " history" },
        shortcut = {
          {
            desc = "find",
            key = "f",
            action = pick(builtin.find_files, { prompt_title = "find files", hidden = true }),
          },
          { desc = "hist", key = "h", action = pick(builtin.oldfiles, { prompt_title = "history" }) },
          {
            desc = "grep",
            key = "g",
            action = pick(builtin.live_grep, {
              prompt_title = "grep",
              additional_args = { "--hidden", "--glob", "!.git" },
            }),
          },
          {
            desc = "dots",
            key = "d",
            action = pick(builtin.find_files, {
              prompt_title = "dots",
              cwd = vim.fn.expand("~/.dot"),
              hidden = true,
              follow = true,
            }),
          },
          {
            desc = "conf",
            key = "c",
            action = pick(
              builtin.find_files,
              { prompt_title = "conf", cwd = vim.fn.stdpath("config"), hidden = true, follow = true }
            ),
          },
          { desc = "lazy", key = "l", action = "Lazy" },
        },
      },
    })
  end,
  dependencies = { "nvim-tree/nvim-web-devicons" },
}
