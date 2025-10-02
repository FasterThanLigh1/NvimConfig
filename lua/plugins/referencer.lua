return {
  "romus204/referencer.nvim",
  keys = {
    { "<leader>rr", "<cmd>ReferencerToggle<cr>", desc = "Toggle Referencer" },
    { "<leader>ru", "<cmd>ReferencerUpdate<cr>", desc = "Update Referencer" },
  },
  config = function()
    require("referencer").setup()
  end,
}
