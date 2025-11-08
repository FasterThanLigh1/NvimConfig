return {
	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"MunifTanjim/nui.nvim",
			"nvim-tree/nvim-web-devicons", -- optional, but recommended
		},
		-- The 'keys' table below enables lazy loading.
		-- The plugin will only load the first time you press <leader>e.
		keys = {
			{
				"<leader>e",
				"<cmd>Neotree toggle<CR>",
				desc = "Toggle Neo-tree File Explorer",
			},
		},
		-- The 'config' function should contain any mandatory setup
		-- but for a simple toggle, just ensuring the command is available is sufficient.
	},
}
