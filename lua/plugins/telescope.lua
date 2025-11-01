return {
	"nvim-telescope/telescope.nvim",
	tag = "0.1.8",
	dependencies = { "nvim-lua/plenary.nvim" },
	keys = {
		-- Find files
		{
			"<leader>ff",
			function()
				require("telescope.builtin").find_files()
			end,
			mode = "n",
			desc = "Find files",
		},
		-- Live grep (search all files)
		{
			"<leader>fg",
			function()
				require("telescope.builtin").live_grep()
			end,
			mode = "n",
			desc = "Find in files (grep)",
		},
		-- Search word under cursor
		{
			"<leader>fs",
			function()
				require("telescope.builtin").grep_string()
			end,
			mode = "n",
			desc = "Find word under cursor",
		},
		-- Search word under cursor (visual mode)
		{
			"<leader>fs",
			function()
				require("telescope.builtin").grep_string()
			end,
			mode = "v",
			desc = "Find selected text",
		},
		-- Recent files
		{
			"<leader>fr",
			function()
				require("telescope.builtin").oldfiles()
			end,
			mode = "n",
			desc = "Find recent files",
		},
		-- Buffers
		{
			"<leader>fb",
			function()
				require("telescope.builtin").buffers()
			end,
			mode = "n",
			desc = "Find buffers",
		},
		-- Help tags
		{
			"<leader>fh",
			function()
				require("telescope.builtin").help_tags()
			end,
			mode = "n",
			desc = "Find help",
		},
		-- Quick find files (alternative)
		{
			"<leader><leader>",
			function()
				require("telescope.builtin").find_files()
			end,
			mode = "n",
			desc = "Find files",
		},
		-- LSP: Go to definition
		{
			"gd",
			function()
				require("telescope.builtin").lsp_definitions()
			end,
			mode = "n",
			desc = "Go to definition",
		},

		-- LSP: Go to references
		{
			"gr",
			function()
				require("telescope.builtin").lsp_references()
			end,
			mode = "n",
			desc = "Find references",
		},

		-- LSP: Go to implementations
		{
			"gi",
			function()
				require("telescope.builtin").lsp_implementations()
			end,
			mode = "n",
			desc = "Go to implementations",
		},

		-- LSP: Go to type definition
		{
			"gy",
			function()
				require("telescope.builtin").lsp_type_definitions()
			end,
			mode = "n",
			desc = "Go to type definition",
		},

		-- LSP: Find symbols in current buffer
		{
			"<leader>fo",
			function()
				require("telescope.builtin").lsp_document_symbols()
			end,
			mode = "n",
			desc = "Find symbols (current file)",
		},

		-- LSP: Find symbols in workspace
		{
			"<leader>fw",
			function()
				require("telescope.builtin").lsp_workspace_symbols()
			end,
			mode = "n",
			desc = "Find symbols (workspace)",
		},

		-- LSP: Show diagnostics
		{
			"<leader>fd",
			function()
				require("telescope.builtin").diagnostics()
			end,
			mode = "n",
			desc = "Find diagnostics (errors/warnings)",
		},
	},
}
