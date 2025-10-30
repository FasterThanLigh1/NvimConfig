return {
	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"MunifTanjim/nui.nvim",
			"nvim-tree/nvim-web-devicons", -- optional, but recommended
		},
		lazy = false,

		-- 🚨 The change is in the 'config' block
		config = function()
			-- Keymap in normal mode (n) to toggle Neo-tree
			-- '<Leader>e' will use your currently configured Leader key (often '\' or space)
			vim.keymap.set("n", "<Leader>e", ":Neotree toggle<CR>", { desc = "Toggle Neo-tree" })

			-- Optional: You can still include the setup call here if needed
			require("neo-tree").setup({
				-- ... other settings
			})
		end,
	},
}
