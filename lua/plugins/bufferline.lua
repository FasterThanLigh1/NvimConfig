-- ~/.config/nvim/lua/plugins/bufferline.lua

return {
	-- 📦 Bufferline Plugin
	{
		"akinsho/bufferline.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		event = "VeryLazy",
		opts = {
			options = {
				close_command = "Bdelete",
				right_mouse_command = "Bdelete",
				always_show_bufferline = true,
				separator_style = "slant",
				indicator_icon = "▎",
				buffer_close_icon = "",
				modified_icon = "●",
				show_buffer_close_icons = true,
				show_tab_indicators = true,
				diagnostics = "nvim_lsp",
			},
		},

		-- ⌨️ Keymaps using <Tab> and <S-Tab>
		keys = {
			{
				"<Tab>",
				"<Cmd>BufferLineCycleNext<CR>",
				mode = "n", -- Explicitly Normal Mode
				desc = "Buffer: Next",
			},
			{
				"<S-Tab>",
				"<Cmd>BufferLineCyclePrev<CR>",
				mode = "n", -- Explicitly Normal Mode
				desc = "Buffer: Previous",
			}, -- 3. Jump to buffer by number (1-5)
			{ "<leader>t1", "<Cmd>BufferLineGoToBuffer 1<CR>", desc = "Buffer: Go to #1" },
			{ "<leader>t2", "<Cmd>BufferLineGoToBuffer 2<CR>", desc = "Buffer: Go to #2" },
			{ "<leader>t3", "<Cmd>BufferLineGoToBuffer 3<CR>", desc = "Buffer: Go to #3" },
			{ "<leader>t4", "<Cmd>BufferLineGoToBuffer 4<CR>", desc = "Buffer: Go to #4" },
			{ "<leader>t5", "<Cmd>BufferLineGoToBuffer 5<CR>", desc = "Buffer: Go to #5" },

			-- 4. Buffer Closing
			{ "<leader>td", "<Cmd>Bdelete<CR>", desc = "Buffer: Delete Current" },
			{
				"<leader>to",
				function()
					local current_buf = vim.api.nvim_get_current_buf()
					local buffers = vim.fn.getbufinfo({ buflisted = true })
					for _, buf in ipairs(buffers) do
						if buf.bufnr ~= current_buf then
							vim.cmd(buf.bufnr .. "Bdelete!")
						end
					end
				end,
				desc = "Buffer: Close All Others",
			},

			-- 5. Pin/Unpin
			{ "<leader>tP", "<Cmd>BufferLineTogglePin<CR>", desc = "Buffer: Pin/Unpin" },
		},
	},

	-- 📦 Buffer Delete Plugin (Essential for clean closing)
	{
		"famiu/bufdelete.nvim",
		lazy = false,
		cmd = { "Bdelete", "Bwipeout" },
		-- No 'opts' table required here
	},
}
