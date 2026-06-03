return {
  "romus204/tree-sitter-manager.nvim",
  dependencies = {},
  config = function()
    require("tree-sitter-manager").setup({
      border = "rounded",
      auto_install = true,
      highlight = true,
    })
  end,
}
