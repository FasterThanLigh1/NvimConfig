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

			-- Mini.files setup
			require("mini.files").setup({
				mappings = {
					close = "q",
					go_in = "l",
					go_in_plus = "L",
					go_out = "h",
					go_out_plus = "H",
					reset = "<BS>",
					reveal_cwd = "@",
					show_help = "g?",
					synchronize = "=",
					trim_left = "<",
					trim_right = ">",
				},
				options = {
					permanent_delete = true,
					use_as_default_explorer = true,
				},
				windows = {
					preview = false,
					width_focus = 30,
					width_nofocus = 15,
				},
			})

			-- Toggle mini.files with <leader>e
			vim.keymap.set("n", "<leader>e", function()
				if not MiniFiles.close() then
					MiniFiles.open()
				end
			end, { desc = "Toggle file explorer" })

			-- Open mini.files at current file
			vim.keymap.set("n", "<leader>E", function()
				MiniFiles.open(vim.api.nvim_buf_get_name(0))
			end, { desc = "Explorer at current file" })

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

					-- Custom clue groups
					{ mode = "n", keys = "<Leader>c", desc = "+Copilot/Code" },
					{ mode = "v", keys = "<Leader>c", desc = "+Copilot/Code" },
					{ mode = "n", keys = "<Leader>r", desc = "+Run" },
					{ mode = "n", keys = "<Leader>f", desc = "+Find (Telescope)" },
					{ mode = "v", keys = "<Leader>f", desc = "+Find (Telescope)" },
					{ mode = "n", keys = "<Leader>n", desc = "+Notifications" },
					{ mode = "n", keys = "<Leader>e", desc = "Toggle explorer" },
					{ mode = "n", keys = "<Leader>E", desc = "Explorer at file" },
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

			-- Mini.notify setup
			require("mini.notify").setup()
			-- Keymap to show notification history
			vim.keymap.set("n", "<leader>nh", function()
				require("mini.notify").show_history()
			end, { desc = "Show notification history" })
		end,
	},
}
