-- plugins/mini.lua
return {
	{
		"nvim-mini/mini.nvim",
		version = false,
		config = function()
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
			require("mini.starter").setup({
				autoopen = true,
			})
			require("mini.icons").setup()
			require("mini.tabline").setup()
			require("mini.cursorword").setup()
			require("mini.animate").setup()
			require("mini.statusline").setup()
			require("mini.completion").setup()
			require("mini.hipatterns").setup()
			require("mini.jump").setup()
			require("mini.jump2d").setup()

			-- Mini.clue setup
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
				},
			})

			-- Mini.trailspace setup
			require("mini.trailspace").setup()
			-- Keymap to trim trailing whitespace
			vim.keymap.set("n", "<leader>cw", function()
				require("mini.trailspace").trim()
			end, { desc = "Trim trailing whitespace" })
			-- Keymap to trim trailing empty lines
			vim.keymap.set("n", "<leader>cl", function()
				require("mini.trailspace").trim_last_lines()
			end, { desc = "Trim trailing empty lines" })

			-- Mini.keymap setup
			require("mini.keymap").setup()
			require("mini.fuzzy").setup()
			require("mini.notify").setup()
			-- Keymap to show notification history
			vim.keymap.set("n", "<leader>nh", function()
				require("mini.notify").show_history()
			end, { desc = "Show notification history" })
		end,
	},
}
