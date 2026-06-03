return {
  "chrisgrieser/nvim-spider",
  keys = {
    { "w", "<cmd>lua require('spider').motion('w')<cr>", mode = { "n", "o", "x" } },
    { "e", "<cmd>lua require('spider').motion('e')<cr>", mode = { "n", "o", "x" } },
    { "b", "<cmd>lua require('spider').motion('b')<cr>", mode = { "n", "o", "x" } },
    { "ge", "<cmd>lua require('spider').motion('ge')<cr>", mode = { "n", "o", "x" } },
  },
}
