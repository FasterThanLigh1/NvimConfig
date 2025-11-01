return {
	"nvimdev/lspsaga.nvim",
	event = "LspAttach",
	dependencies = {
		"nvim-treesitter/nvim-treesitter",
		"nvim-tree/nvim-web-devicons",
	},
	config = function()
		require("lspsaga").setup({
			-- UI settings
			ui = {
				border = "rounded",
				title = true,
				winblend = 0,
				expand = "",
				collapse = "",
				code_action = "💡",
				actionfix = " ",
				lines = { "┗", "┣", "┃", "━", "┏" },
				kind = {},
				imp_sign = "󰳛 ",
			},

			-- Hover doc
			hover = {
				max_width = 0.6,
				max_height = 0.8,
				open_link = "gx",
				open_cmd = "!open", -- macOS: open, Linux: xdg-open
			},

			-- Diagnostic
			diagnostic = {
				show_code_action = true,
				show_source = true,
				jump_num_shortcut = true,
				max_width = 0.7,
				max_height = 0.6,
				text_hl_follow = true,
				border_follow = true,
				extend_relatedInformation = false,
				diagnostic_only_current = false,
				keys = {
					exec_action = "o",
					quit = "q",
					toggle_or_jump = "<CR>",
					quit_in_show = { "q", "<ESC>" },
				},
			},

			-- Code action
			code_action = {
				num_shortcut = true,
				show_server_name = true,
				extend_gitsigns = false,
				keys = {
					quit = "q",
					exec = "<CR>",
				},
			},

			-- Lightbulb (shows when code actions available)
			lightbulb = {
				enable = true,
				sign = true,
				sign_priority = 40,
				virtual_text = false,
			},

			-- Scroll in hover doc or definition preview
			scroll_preview = {
				scroll_down = "<C-f>",
				scroll_up = "<C-b>",
			},

			-- Request timeout
			request_timeout = 2000,

			-- Finder (references, implementations, etc.)
			finder = {
				max_height = 0.5,
				min_width = 30,
				force_max_height = false,
				keys = {
					jump_to = "p",
					expand_or_jump = "o",
					vsplit = "s",
					split = "i",
					tabe = "t",
					tabnew = "r",
					quit = { "q", "<ESC>" },
					close_in_preview = "<ESC>",
				},
			},

			-- Definition
			definition = {
				edit = "<C-c>o",
				vsplit = "<C-c>v",
				split = "<C-c>i",
				tabe = "<C-c>t",
				quit = "q",
			},

			-- Rename
			rename = {
				quit = "<C-c>",
				exec = "<CR>",
				mark = "x",
				confirm = "<CR>",
				in_select = true,
			},

			-- Outline
			outline = {
				win_position = "right",
				win_with = "",
				win_width = 30,
				preview_width = 0.4,
				show_detail = true,
				auto_preview = true,
				auto_refresh = true,
				auto_close = true,
				auto_resize = false,
				custom_sort = nil,
				keys = {
					expand_or_jump = "o",
					quit = "q",
				},
			},

			-- Callhierarchy
			callhierarchy = {
				show_detail = false,
				keys = {
					edit = "e",
					vsplit = "s",
					split = "i",
					tabe = "t",
					jump = "o",
					quit = "q",
					expand_collapse = "u",
				},
			},

			-- Beacon (shows cursor position after jump)
			beacon = {
				enable = true,
				frequency = 7,
			},

			-- Symbol in winbar
			symbol_in_winbar = {
				enable = true,
				separator = " › ",
				hide_keyword = true,
				show_file = true,
				folder_level = 2,
				respect_root = false,
				color_mode = true,
			},
		})
	end,
	keys = {
		-- Code actions
		{
			"<leader>ca",
			"<cmd>Lspsaga code_action<CR>",
			mode = { "n", "v" },
			desc = "Code actions",
		},

		-- Hover documentation
		{
			"K",
			"<cmd>Lspsaga hover_doc<CR>",
			desc = "Hover documentation",
		},

		-- Go to definition
		{
			"gd",
			"<cmd>Lspsaga goto_definition<CR>",
			desc = "Go to definition",
		},

		-- Peek definition (floating window without jumping)
		{
			"gp",
			"<cmd>Lspsaga peek_definition<CR>",
			desc = "Peek definition",
		},

		-- Go to type definition
		{
			"gt",
			"<cmd>Lspsaga goto_type_definition<CR>",
			desc = "Go to type definition",
		},

		-- Peek type definition
		{
			"gP",
			"<cmd>Lspsaga peek_type_definition<CR>",
			desc = "Peek type definition",
		},

		-- Find references and implementations
		{
			"gr",
			"<cmd>Lspsaga finder<CR>",
			desc = "Find references & implementations",
		},

		-- Rename
		{
			"<leader>rn",
			"<cmd>Lspsaga rename<CR>",
			desc = "Rename symbol",
		},

		-- Rename with file operations (for imports)
		{
			"<leader>rN",
			"<cmd>Lspsaga rename ++project<CR>",
			desc = "Rename symbol (project-wide)",
		},

		-- Outline (file structure)
		{
			"<leader>o",
			"<cmd>Lspsaga outline<CR>",
			desc = "Toggle outline",
		},

		-- Diagnostics (errors/warnings)
		{
			"<leader>cd",
			"<cmd>Lspsaga show_line_diagnostics<CR>",
			desc = "Show line diagnostics",
		},
		{
			"<leader>cD",
			"<cmd>Lspsaga show_cursor_diagnostics<CR>",
			desc = "Show cursor diagnostics",
		},
		{
			"<leader>cb",
			"<cmd>Lspsaga show_buf_diagnostics<CR>",
			desc = "Show buffer diagnostics",
		},

		-- Navigate diagnostics
		{
			"[d",
			"<cmd>Lspsaga diagnostic_jump_prev<CR>",
			desc = "Previous diagnostic",
		},
		{
			"]d",
			"<cmd>Lspsaga diagnostic_jump_next<CR>",
			desc = "Next diagnostic",
		},

		-- Jump to errors only
		{
			"[e",
			function()
				require("lspsaga.diagnostic"):goto_prev({ severity = vim.diagnostic.severity.ERROR })
			end,
			desc = "Previous error",
		},
		{
			"]e",
			function()
				require("lspsaga.diagnostic"):goto_next({ severity = vim.diagnostic.severity.ERROR })
			end,
			desc = "Next error",
		},

		-- Incoming/Outgoing calls
		{
			"<leader>ci",
			"<cmd>Lspsaga incoming_calls<CR>",
			desc = "Incoming calls",
		},
		{
			"<leader>co",
			"<cmd>Lspsaga outgoing_calls<CR>",
			desc = "Outgoing calls",
		},

		-- Terminal
		{
			"<A-d>",
			"<cmd>Lspsaga term_toggle<CR>",
			mode = { "n", "t" },
			desc = "Toggle terminal",
		},
	},
}
