return {
	"stevearc/overseer.nvim",
	dependencies = {
		-- Required dependency for task management
		"nvim-lua/plenary.nvim",
	},
	config = function()
		require("overseer").setup({
			-- 🍎 Set the task source priority to check for Bun, then Yarn, then NPM
			task_source_priority = {
				"builtin", -- Standard shell commands
				"package_json", -- Handles package.json scripts
				"bun", -- Checks for Bun first (e.g., bun.lockb)
				"yarn", -- Checks for Yarn (e.g., yarn.lock)
				"npm", -- Checks for NPM (e.g., package-lock.json)
				"cargo", -- Rust projects
				-- Add other sources here if needed
			},
		})

		-- Keymaps for Run and Toggle
		vim.keymap.set("n", "<leader>Or", function()
			require("overseer").run_template()
		end, { desc = "Overseer: Run Task Picker" })
		vim.keymap.set("n", "<leader>Ot", function()
			require("overseer").toggle()
		end, { desc = "Overseer: Toggle Task List" })
	end,
}
