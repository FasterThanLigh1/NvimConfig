return {
	"nvim-neo-tree/neo-tree.nvim",
	-- 1. Specify the correct branch
	branch = "v3.x",

	-- 2. Define dependencies (Neo-tree requires these)
	dependencies = {
		"nvim-lua/plenary.nvim", -- Required utility library
		"nvim-tree/nvim-web-devicons", -- For file icons (highly recommended)
		"MunifTanjim/nui.nvim", -- UI toolkit dependency
	},

	-- 3. Configure the plugin
	opts = {
		-- Optional: Disable the default Neovim file explorer (netrw)
		-- This prevents conflicts and is generally recommended.
		disable_netrw = true,

		-- Sources to show in Neo-tree (filesystem, buffers, git_status)
		sources = { "filesystem", "buffers", "git_status" },

		-- Configuration for the main file explorer window
		window = {
			position = "left",
			width = 30, -- Adjust as needed
			-- You can add internal Neo-tree keymaps here if needed
		},

		-- Additional settings (customize as desired)
		filesystem = {
			-- Automatically focus on the currently open file
			follow_current_file = { enabled = true },
		},
	},

	-- 4. Set the Keymap for Toggling
	-- The `keys` table is the most idiomatic way to set keymaps within a lazy.nvim spec.
	-- It will also ensure the plugin is loaded when the keymap is used.
	keys = {
		{
			-- The keybinding you requested
			"<leader>e",

			-- The command to execute: 'Neotree' is the main command.
			-- 'toggle' ensures it opens if closed and closes if open.
			"<cmd>Neotree toggle<CR>",

			-- Optional: 'desc' is used by which-key.nvim if you have it
			desc = "Toggle Neo-tree Explorer",
		},
	},
}
