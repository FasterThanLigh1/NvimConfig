return {
	"yioneko/nvim-vtsls",
	event = { "BufReadPre", "BufNewFile" },
	ft = { "typescript", "typescriptreact", "javascript", "javascriptreact" },
	dependencies = { "neovim/nvim-lspconfig" },
	config = function()
		-- 1. Initialize the plugin extension
		require("vtsls").config({
			-- You can customize settings here if needed,
			-- but usually default is fine as settings are passed via lspconfig
		})

		-- 2. Define Keymaps
		-- We wrap this in an autocommand to ensure they only apply to TS/JS files
		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("VtslsKeymaps", {}),
			callback = function(ev)
				local client = vim.lsp.get_client_by_id(ev.data.client_id)

				-- Only attach these mappings if the server is vtsls
				if client.name == "vtsls" then
					local opts = { buffer = ev.buf }
					local commands = require("vtsls").commands

					local function map(mode, lhs, rhs, desc)
						vim.keymap.set(mode, lhs, rhs, vim.tbl_extend("force", opts, { desc = desc }))
					end

					-- === COMMANDS MAPPED TO <leader>t ===

					-- Server / Project management
					map("n", "<leader>tr", commands.restart_tsserver, "Restart TSServer")
					map("n", "<leader>tl", commands.open_tsserver_log, "Open TSServer Log")
					map("n", "<leader>tp", commands.reload_projects, "Reload Projects")
					map("n", "<leader>tc", commands.goto_project_config, "Go to Project Config (tsconfig)")
					map("n", "<leader>tv", commands.select_ts_version, "Select TS Version")

					-- Navigation
					map("n", "<leader>td", commands.goto_source_definition, "Go to Source Definition")
					map("n", "<leader>tf", commands.file_references, "Show File References")

					-- Refactoring / File Operations
					map("n", "<leader>tR", commands.rename_file, "Rename File (Update Imports)")

					-- Imports & Fixes
					map("n", "<leader>to", commands.organize_imports, "Organize Imports")
					map("n", "<leader>ts", commands.sort_imports, "Sort Imports")
					map("n", "<leader>tu", commands.remove_unused_imports, "Remove Unused Imports")
					map("n", "<leader>tm", commands.add_missing_imports, "Add Missing Imports")
					map("n", "<leader>tx", commands.fix_all, "Fix All Auto-fixable Problems")

					-- Actions
					map("n", "<leader>ta", commands.source_actions, "Source Actions (Menu)")
				end
			end,
		})
	end,
}
