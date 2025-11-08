return {
	"MeanderingProgrammer/render-markdown.nvim",
	dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-mini/mini.nvim" }, -- if you use the mini.nvim suite
	-- dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-mini/mini.icons' },        -- if you use standalone mini plugins
	-- dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' }, -- if you prefer nvim-web-devicons
	---@module 'render-markdown'
	---@type render.md.UserConfig
	opts = {},
	ft = { "markdown", "codecompanion" },
	config = function()
		require("render-markdown").setup({
			-- You can configure this plugin here
			-- See its documentation for all options
			code_block = {
				conceal_start_delimiter = true,
				conceal_end_delimiter = true,
				conceal_language = true,
			},
		})
	end,
}
