return {
  "ray-x/lsp_signature.nvim",
  event = "InsertEnter",
  opts = {
    bind = true,
    handler_opts = {
      border = "rounded",
    },
  },
  keys = {
    {
      "<C-k>",
      function()
        require("lsp_signature").toggle_float_win()
      end,
      mode = "n",
      silent = true,
      noremap = true,
      desc = "Toggle signature",
    },
    {
      "<Leader>k",
      function()
        vim.lsp.buf.signature_help()
      end,
      mode = "n",
      silent = true,
      noremap = true,
      desc = "LSP signature help",
    },
  },
}
