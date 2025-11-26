return {
	{
		"echasnovski/mini.nvim",
		version = false,
		config = function()
			-- Existing setups
			require("mini.surround").setup({
				mappings = {
					add = "gs",
					delete = "gS",
					find = "gF",
					find_next = "gn",
					find_prev = "gN",
					replace = "gr",
					update_n_lines = "gz",
				},
			})
			require("mini.pairs").setup()
			require("mini.indentscope").setup()
			require("mini.starter").setup({ autoopen = true })
			require("mini.icons").setup()
			require("mini.cursorword").setup()
			require("mini.statusline").setup()
			require("mini.completion").setup()
			require("mini.hipatterns").setup()
			require("mini.jump").setup()
			require("mini.jump2d").setup()
			require("mini.diff").setup()
			require("mini.ai").setup()

			-- Mini Files Setup
			require("mini.files").setup()

			-- Mini Clue Setup
			require("mini.clue").setup({
				triggers = {
					{ mode = "n", keys = "<Leader>" },
					{ mode = "x", keys = "<Leader>" },
					{ mode = "i", keys = "<C-x>" },
					{ mode = "n", keys = "g" },
					{ mode = "x", keys = "g" },
					{ mode = "n", keys = "'" },
					{ mode = "n", keys = "`" },
					{ mode = "x", keys = "'" },
					{ mode = "x", keys = "`" },
					{ mode = "n", keys = '"' },
					{ mode = "x", keys = '"' },
					{ mode = "i", keys = "<C-r>" },
					{ mode = "c", keys = "<C-r>" },
					{ mode = "n", keys = "<C-w>" },
					{ mode = "n", keys = "z" },
					{ mode = "x", keys = "z" },
				},
				clues = {
					require("mini.clue").gen_clues.builtin_completion(),
					require("mini.clue").gen_clues.g(),
					require("mini.clue").gen_clues.marks(),
					require("mini.clue").gen_clues.registers(),
					require("mini.clue").gen_clues.windows(),
					require("mini.clue").gen_clues.z(),
					{ mode = "n", keys = "<Leader>c", desc = "+Copilot/Code" },
					{ mode = "v", keys = "<Leader>c", desc = "+Copilot/Code" },
					{ mode = "n", keys = "<Leader>r", desc = "+Run" },
					{ mode = "n", keys = "<Leader>f", desc = "+Find (Telescope)" },
					{ mode = "v", keys = "<Leader>f", desc = "+Find (Telescope)" },
					{ mode = "n", keys = "<Leader>n", desc = "+Notifications" },
					-- Descriptions for Mini Files
					{ mode = "n", keys = "<Leader>e", desc = "Explorer (Root)" },
					{ mode = "n", keys = "<Leader>E", desc = "Explorer (Current Directory)" },
				},
			})

			require("mini.trailspace").setup()

			-- Trailspace Keymaps
			vim.keymap.set("n", "<leader>cw", function()
				require("mini.trailspace").trim()
			end, { desc = "Trim trailing whitespace" })

			vim.keymap.set("n", "<leader>cl", function()
				require("mini.trailspace").trim_last_lines()
			end, { desc = "Trim trailing empty lines" })

			require("mini.keymap").setup()
			require("mini.fuzzy").setup()
			require("mini.notify").setup()

			-- Notify Keymaps
			vim.keymap.set("n", "<leader>nh", function()
				require("mini.notify").show_history()
			end, { desc = "Show notification history" })

			require("mini.bracketed").setup()
			require("mini.tabline").setup()

			-- === MINI FILES KEYMAPS ===

			-- Toggle Mini Files (Root directory)
			vim.keymap.set("n", "<leader>e", function()
				local MiniFiles = require("mini.files")
				if not MiniFiles.close() then
					MiniFiles.open()
				end
			end, { desc = "Open mini.files" })

			-- Toggle Mini Files (Current File Directory)
			vim.keymap.set("n", "<leader>E", function()
				local MiniFiles = require("mini.files")
				if not MiniFiles.close() then
					MiniFiles.open(vim.api.nvim_buf_get_name(0))
				end
			end, { desc = "Open mini.files (Current File)" })
		end,
	},
}
