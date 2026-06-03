return {
  "catgoose/nvim-colorizer.lua",
  event = "BufReadPre",
  opts = {
    filetypes = {
      "css",
      "scss",
      "html",
      "javascript",
      "lua",
      "vim",
    },
    user_default_options = {
      RGB = true,
      RRGGBB = true,
      names = true,
      rgb_fn = true,
      hsl_fun = true,
      RRGGBBAA = false,
      tailwind = false,
    },
    buftypes = {},
  },
}
