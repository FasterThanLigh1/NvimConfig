return {
	"mrjones2014/smart-splits.nvim",
	-- Set up keymaps that use <C-h/j/k/l> for seamless movement
	config = function()
		require("smart-splits").setup({
			-- Optional: Configure settings here if needed.
			-- For most users, the default settings work great.
		})

		-- Define keymaps for moving between splits
		local map = vim.keymap.set
		local opts = { silent = true, noremap = true }

		map("n", "<C-h>", require("smart-splits").move_cursor_left, opts)
		map("n", "<C-j>", require("smart-splits").move_cursor_down, opts)
		map("n", "<C-k>", require("smart-splits").move_cursor_up, opts)
		map("n", "<C-l>", require("smart-splits").move_cursor_right, opts)
	end,
}
