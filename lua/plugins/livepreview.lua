return {
	"brianhuster/live-preview.nvim",
	dependencies = {
		"nvim-telescope/telescope.nvim",
	},
	keys = {
		{ "<leader>hp", ":LivePreview start<CR>", desc = "Start Live Preview" },
		{ "<leader>hs", ":LivePreview stop<CR>", desc = "Stop Live Preview" },
		{ "<leader>hk", ":LivePreview pick<CR>", desc = "Pick Live Preview" },
	},
}
