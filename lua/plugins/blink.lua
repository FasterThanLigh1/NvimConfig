return {
	"saghen/blink.cmp",
	-- Add codecompanion as a dependency
	dependencies = {
		"rafamadriz/friendly-snippets",
		"olimorris/codecompanion.nvim",
	},
	version = "1.*",

	---@module 'blink.cmp'
	---@type blink.cmp.Config
	opts = {
		-- 'default' (C-y to accept), 'super-tab', 'enter', or 'none'
		keymap = { preset = "default" },

		appearance = {
			nerd_font_variant = "mono",
		},

		completion = { documentation = { auto_show = false } },

		-- Configure completion sources
		sources = {
			-- Global sources, active in all buffers
			global = { "lsp", "path", "snippets", "buffer" },

			-- Per-filetype sources
			per_filetype = {
				-- Only activate "codecompanion" source in its own chat window
				codecompanion = { "codecompanion" },
			},
		},

		fuzzy = { implementation = "prefer_rust_with_warning" },
	},

	-- Allow other plugins to extend the source lists
	opts_extend = { "sources.global", "sources.per_filetype" },
}
