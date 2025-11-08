return {
	-- Plugin 1: The official Copilot backend
	-- We need this so you can run :Copilot auth
	{
		"github/copilot.vim",
	},
	{
		"olimorris/codecompanion.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"zbirenbaum/copilot.lua",
			"nvim-treesitter/nvim-treesitter",
			"MeanderingProgrammer/render-markdown.nvim",
			"j-hui/fidget.nvim",
		},
		config = function()
			require("plugins.codecompanion.fidget-spinner"):init()
			require("codecompanion").setup({
				-- Set window globally for all strategies

				-- Tell CodeCompanion to use Copilot as its backend
				strategies = {
					chat = {
						adapter = "copilot",
						opts = {
							model = "claude-3-sonnet-20240229", -- Use Claude 3 Sonnet for Copilot Chat
						},
					},
					inline = { adapter = "copilot" },
					agent = { adapter = "copilot" },
					keymaps = {
						send = {
							modes = { n = "<C-s>", i = "<C-s>" }, -- keep if you want the keybinding
							callback = function(chat)
								vim.cmd("stopinsert")
								chat:submit()
								chat:add_buf_message({ role = "llm", content = "" })
							end,
							index = 1,
							description = "Send",
						},
						close = {
							modes = { n = "<C-c>", i = "<C-c>" },
							opts = {},
						},
						-- Add further custom keymaps here
					},
					opts = {
						---@param message string
						---@param adapter CodeCompanion.Adapter
						---@param context table
						---@return string
						prompt_decorator = function(message, adapter, context)
							return string.format([[<prompt>%s</prompt>]], message)
						end,
					},
				},
				display = {
					chat = {
						-- Change the default icons
						icons = {
							buffer_pin = " ",
							buffer_watch = "👀 ",
						},

						-- Alter the sizing of the debug window
						debug_window = {
							---@return number|fun(): number
							width = vim.o.columns - 5,
							---@return number|fun(): number
							height = vim.o.lines - 2,
						},

						-- Options to customize the UI of the chat buffer
						window = {
							layout = "vertical", -- float|vertical|horizontal|buffer
							position = "right", -- left|right|top|bottom (nil will default depending on vim.opt.splitright|vim.opt.splitbelow)
							border = "single",
							height = 0.8,
							width = 0.35,
							relative = "editor",
							full_height = true, -- when set to false, vsplit will be used to open the chat buffer vs. botright/topleft vsplit
							sticky = false, -- when set to true and `layout` is not `"buffer"`, the chat buffer will remain opened when switching tabs
							opts = {
								breakindent = true,
								cursorcolumn = false,
								cursorline = false,
								foldcolumn = "0",
								linebreak = true,
								list = false,
								numberwidth = 1,
								signcolumn = "no",
								spell = false,
								wrap = true,
							},
						},

						---Customize how tokens are displayed
						---@param tokens number
						---@param adapter CodeCompanion.Adapter
						---@return string
						token_count = function(tokens, adapter)
							return " (" .. tokens .. " tokens)"
						end,
					},
				},
			})
		end,

		---
		-- UPDATED: Keybindings
		---
		keys = {
			-- Toggle the chat panel (now configured to be on the right)
			{
				"<leader>ac",
				"<cmd>CodeCompanionChat<CR>",
				desc = "AI Chat",
			},
			{
				"<leader>aa",
				"<cmd>CodeCompanionActions<CR>",
				desc = "AI Actions",
			},
			-- The <leader>af keybinding has been removed.
		},
	},
}
