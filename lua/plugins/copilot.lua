return {
	{ "github/copilot.vim" },
	{
		"CopilotC-Nvim/CopilotChat.nvim",
		dependencies = {
			{ "nvim-lua/plenary.nvim", branch = "master" },
		},
		build = "make tiktoken",
		opts = {
			-- Model configuration - Claude 4.5 Sonnet
			model = "claude-3.5-sonnet",
			-- Window configuration
			window = {
				layout = "vertical",
				width = 0.3, -- This might not work with vertical layout
				relative = "editor",
				border = "rounded",
				title = "🤖 AI Assistant",
			},
			-- Custom headers
			headers = {
				user = "👤 You",
				assistant = "🤖 Copilot",
				tool = "🔧 Tool",
			},
			-- Separator
			separator = "━━",
			-- Auto fold non-assistant messages
			auto_fold = true,
			-- Show help actions with telescope
			show_help = true,
			-- Auto follow cursor
			auto_follow_cursor = true,
			-- Prompts configuration
			prompts = {
				Explain = "Explain how this code works.",
				Review = "Review this code and provide suggestions.",
				Tests = "Write tests for this code.",
				Refactor = "Refactor this code to improve its quality.",
				FixBugs = "Find and fix bugs in this code.",
				Documentation = "Write documentation for this code.",
				SwaggerApiDocs = "Write Swagger API documentation for this code.",
				SwaggerJsDocs = "Write JSDoc annotations for this API.",
				Summarize = "Summarize this code.",
				Spelling = "Fix spelling and grammar.",
				Wording = "Improve wording.",
				Concise = "Make this code more concise.",
			},
		},
		config = function(_, opts)
			local chat = require("CopilotChat")
			chat.setup(opts)

			-- Override to open on the right side with custom width
			vim.api.nvim_create_autocmd("BufEnter", {
				pattern = "copilot-*",
				callback = function()
					vim.cmd("wincmd L") -- Move window to far right
					-- Set custom width (adjust the number: 40, 50, 60, etc.)
					vim.cmd("vertical resize 50") -- 50 columns wide
				end,
			})
		end,
		keys = {
			-- Open/Toggle/Close
			{
				"<leader>cc",
				":CopilotChatToggle<CR>",
				mode = { "n", "v" },
				desc = "Toggle Copilot Chat",
			},
			{
				"<leader>co",
				":CopilotChatOpen<CR>",
				mode = "n",
				desc = "Open Copilot Chat",
			},
			{
				"<leader>cq",
				":CopilotChatClose<CR>",
				mode = "n",
				desc = "Close Copilot Chat",
			},
			-- Chat actions
			{
				"<leader>cs",
				":CopilotChatStop<CR>",
				mode = "n",
				desc = "Stop Copilot output",
			},
			{
				"<leader>cr",
				":CopilotChatReset<CR>",
				mode = "n",
				desc = "Reset Copilot Chat",
			},
			-- Save/Load
			{
				"<leader>cS",
				":CopilotChatSave<CR>",
				mode = "n",
				desc = "Save Copilot Chat",
			},
			{
				"<leader>cL",
				":CopilotChatLoad<CR>",
				mode = "n",
				desc = "Load Copilot Chat",
			},
			-- Prompts and Models
			{
				"<leader>cp",
				":CopilotChatPrompts<CR>",
				mode = "n",
				desc = "View Copilot prompts",
			},
			{
				"<leader>cm",
				":CopilotChatModels<CR>",
				mode = "n",
				desc = "Select Copilot model",
			},
			-- Quick chat with input
			{
				"<leader>ci",
				function()
					local input = vim.fn.input("Ask Copilot: ")
					if input ~= "" then
						vim.cmd("CopilotChat " .. input)
					end
				end,
				mode = "n",
				desc = "Ask Copilot (input)",
			},
			-- Prompt actions (common ones)
			{
				"<leader>ce",
				":CopilotChatExplain<CR>",
				mode = { "n", "v" },
				desc = "Explain code",
			},
			{
				"<leader>ct",
				":CopilotChatTests<CR>",
				mode = { "n", "v" },
				desc = "Generate tests",
			},
			{
				"<leader>cR",
				":CopilotChatReview<CR>",
				mode = { "n", "v" },
				desc = "Review code",
			},
			{
				"<leader>cf",
				":CopilotChatRefactor<CR>",
				mode = { "n", "v" },
				desc = "Refactor code",
			},
			{
				"<leader>cb",
				":CopilotChatFixBugs<CR>",
				mode = { "n", "v" },
				desc = "Fix bugs",
			},
			{
				"<leader>cd",
				":CopilotChatDocumentation<CR>",
				mode = { "n", "v" },
				desc = "Generate documentation",
			},
			{
				"<leader>cw",
				":CopilotChatWording<CR>",
				mode = { "n", "v" },
				desc = "Improve wording",
			},
		},
	},
}
