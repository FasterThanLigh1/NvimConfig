-- ~/.config/nvim/lua/plugins/mason.lua
return {
	{
		"mason-org/mason.nvim",
		cmd = "Mason",
		keys = {
			{
				"<leader>mm",
				"<cmd>Mason<cr>",
				mode = "n",
				desc = "Mason: Open UI",
			},
			{
				"<leader>mU",
				"<cmd>MasonUpdate<cr>",
				mode = "n",
				desc = "Mason: Update Registries",
			},
			{
				"<leader>mi",
				":MasonInstall ",
				mode = "n",
				desc = "Mason: Install Package",
			},
			{
				"<leader>mu",
				":MasonUninstall ",
				mode = "n",
				desc = "Mason: Uninstall Package",
			},
			{
				"<leader>mua",
				"<cmd>MasonUninstallAll<cr>",
				mode = "n",
				desc = "Mason: Uninstall All",
			},
			{
				"<leader>ml",
				"<cmd>MasonLog<cr>",
				mode = "n",
				desc = "Mason: Open Log",
			},
		},
		opts = {
			PATH = "prepend",
		},
	},
	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		dependencies = { "mason-org/mason.nvim", "neovim/nvim-lspconfig" },
		opts = {
			ensure_installed = {
				-- Lua
				"stylua", -- Lua formatter
				"lua-language-server", -- Lua LSP

				-- JavaScript/TypeScript
				"vtsls", -- TS/JS LSP (faster than typescript-language-server)
				"prettier", -- JS/TS/HTML formatter

				-- Angular (uses vtsls)
				"angular-language-server", -- Angular LSP

				-- HTML
				"html-lsp", -- HTML LSP

				-- Python
				"pyright", -- Python LSP (or use "pylsp")
				"black", -- Python formatter
				-- or "ruff",       -- Alternative: faster Python formatter
				"jdtls", -- Java LSP
			},
			auto_update = false,
			run_on_start = true,
		},
	},
}
