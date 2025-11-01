-- ~/.config/nvim/lua/config/keymaps.lua
local map = vim.keymap.set

-- Lazy plugin manager
map("n", "<leader>l", "<cmd>Lazy<cr>", { desc = "Open Lazy" })

-- Quit all
map("n", "<leader>qq", "<cmd>qa<cr>", { desc = "Quit all" })
map("n", "<C-q>", "<cmd>q<cr>", { desc = "Close window" })
