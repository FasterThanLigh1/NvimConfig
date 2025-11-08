return {
	{
		"akinsho/bufferline.nvim",
		event = "BufReadPre", -- Load the plugin right before opening any buffer
		dependencies = { "nvim-tree/nvim-web-devicons" }, -- Needed for icons

		-- Configuration and keymaps for bufferline
		config = function()
			require("bufferline").setup({
				options = {
					-- Set your preferred style for the buffer line
					style_preset = require("bufferline").style_preset.default, -- You can try 'slant', 'padded_slant', or 'default'

					-- Show diagnostic errors/warnings from LSP
					diagnostics = "nvim_lsp",

					-- Automatically close buffers that are hidden/unlisted
					close_command = function(bufnr)
						vim.cmd("bdelete! " .. bufnr)
					end, -- Enable mouse support for clicking on tabs
					mouse_mode = true,

					-- Show buffer number on the tab
					show_buffer_numbers = true,

					-- Other useful options
					always_show_bufferline = true, -- Always show the bar even with one buffer

					-- Hide the file icons for terminal and help buffers
					-- but still show them for code files.
					offsets = {
						{
							filetype = "NvimTree",
							text = "File Explorer",
							highlight = "Directory",
							padding = 1,
						},
					},
				},
			})

			-- === Buffer Keymaps (The commands you requested) ===
			vim.keymap.set("n", "<leader>bd", ":bdelete!<CR>", { desc = "Close current buffer" })
			-- This keymap closes ALL buffers EXCEPT the current one
			vim.keymap.set("n", "<leader>bo", ":BufferLineCloseOthers<CR>", { desc = "Close all other buffers" })

			-- Keymaps for navigating the bufferline
			vim.keymap.set("n", "<Tab>", ":BufferLineCycleNext<CR>", { desc = "Next buffer" })
			vim.keymap.set("n", "<S-Tab>", ":BufferLineCyclePrev<CR>", { desc = "Previous buffer" })
		end,
	},
}
