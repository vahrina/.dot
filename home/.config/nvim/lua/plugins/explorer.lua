return {
  {
    "folke/snacks.nvim",
    opts = {
      explorer = {
        replace_netrw = false,
      },
      picker = {
        hidden = true,
        ignored = true,
        sources = {
          files = { hidden = true, ignored = true },
          explorer = {
            hidden = true,
            ignored = true,
            layout = { layout = { position = "right" } },
          },
          grep = { hidden = true, ignored = true },
        },
      },
    },
  },
}
