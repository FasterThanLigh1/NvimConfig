return {
	"folke/edgy.nvim",
	event = "VeryLazy",
	opts = {
		rights = {
			{
				ft = "Sidekick", -- The filetype for the Code Companion chat window
				title = "Sidekick",
				-- Set the width for a right panel (e.g., 35% of screen width)
				size = { width = 0.35 },
				-- If you need a custom function to open it, you would add it here
				-- open = function() require("codecompanion").open_chat() end,
			},
		},
		bottoms = {
			"Trouble",
			{ ft = "qf", title = "QuickFix" },
			{
				ft = "help",
				size = { height = 20 },
				-- only show help buffers
				filter = function(buf)
					return vim.bo[buf].buftype == "help"
				end,
			},
			{
				ft = "OverseerList",
				title = "Overseer",
				-- This function tells Edgy how to open the window
				open = function()
					require("overseer").open()
				end,
				-- Set the height for a bottom panel (e.g., 20% of screen height)
				size = { height = 0.2 },
				pinned = false,
			},
		},
	},
}
