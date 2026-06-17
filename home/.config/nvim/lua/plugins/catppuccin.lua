return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    config = function()
      require("catppuccin").setup({
        compile_path = vim.fn.stdpath("cache") .. "/catppuccin",
        compile = true,
        flavor = "mocha",
        transparent_background = false,
        term_colors = true,

        color_overrides = {
          mocha = {
            base = "#2E2A3A",
            mantle = "#261E30",
            crust = "#1E1828",

            surface0 = "#3B3850",
            surface1 = "#4A4460",
            surface2 = "#5A5470",

            overlay0 = "#6B687E",
            overlay1 = "#7E7A90",
            overlay2 = "#9490A2",

            text = "#EEF0F8",
            subtext1 = "#D4D8F0",
            subtext0 = "#B8BCD8",

            red = "#E8A0B0",
            maroon = "#F0BEC8",
            peach = "#F0D4A0",
            yellow = "#FAE8C0",
            green = "#A8D8B0",
            teal = "#A0D8E0",
            sky = "#BEF0F8",
            sapphire = "#A0B8E8",
            blue = "#BED0F8",
            lavender = "#DEC8F8",
            mauve = "#C8A8E8",
            flamingo = "#F0BEC8",
            rosewater = "#EEF0F8",
          },
        },

        integrations = {
          cmp = true,
          dashboard = true,
          gitsigns = true,
          indent_blankline = { enabled = true },
          lsp_trouble = true,
          mason = true,
          mini = true,
          native_lsp = {
            enabled = true,
            underlines = {
              errors = { "undercurl" },
              hints = { "undercurl" },
              warnings = { "undercurl" },
              information = { "undercurl" },
            },
          },
          neotree = true,
          noice = true,
          notify = true,
          semantic_tokens = true,
          telescope = true,
          treesitter = true,
          treesitter_context = true,
          which_key = true,
        },
      })
      vim.cmd.colorscheme("catppuccin")
    end,
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "catppuccin",
    },
  },
}
