-- plugins/telescope.lua
return {
	"nvim-telescope/telescope.nvim",
	tag = "0.1.8",
	-- or , branch = '0.1.x',
	dependencies = { "nvim-lua/plenary.nvim" },

	-- ADD YOUR KEYMAPS HERE in the 'keys' table
	keys = {
		-- Map <C-p> to find_files
		{
			"<leader>ff",
			function()
				require("telescope.builtin").find_files()
			end,
			mode = "n", -- Normal mode
			desc = "Telescope Find Files",
		},
		-- Map <C-f> to live_grep (search for words)
		{
			"<leader>fg",
			function()
				require("telescope.builtin").live_grep()
			end,
			mode = "n", -- Normal mode
			desc = "Telescope Live Grep (Search Words)",
		},

		-- Optional: Add the LazyVim default for files as well, but pointed to the right function
		-- This ensures you don't lose the LazyVim-standard <Leader>ff keymap, or you can override it.
		{
			"<leader><leader>",
			function()
				require("telescope.builtin").find_files()
			end,
			desc = "Find Files (Telescope)",
		},
	},

	-- You can also add your configuration options here
	-- opts = {
	--     ...
	-- },
}
