return {
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"mason-org/mason.nvim",
		},
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			-- Use the new vim.lsp.config API for Neovim 0.11+
			vim.lsp.config.vtsls = {}
			vim.lsp.config.lua_ls = {}
			vim.lsp.config.pyright = {}
			vim.lsp.config.html = {}
			vim.lsp.config.angularls = {}

			vim.lsp.config.tailwindcss = {
				-- This is the crucial part.
				-- By default, this server only activates for a few filetypes.
				-- We need to tell it to also activate in your Angular
				-- templates (filetype 'angular') and TypeScript files.
				filetypes = {
					"angular",
					"html",
					"htmlangular",
					"typescript",
					"javascript",
					"typescriptreact",
					"javascriptreact",
					"css",
					"scss",
					"less",
					"svelte",
					"vue",
				},
			}

			vim.lsp.enable({ "vtsls", "lua_ls", "pyright", "angularls" })

			-- Use LspAttach autocommand to only map the following keys
			-- after the language server attaches to the current buffer
			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("UserLspConfig", {}),
				callback = function(ev)
					-- Enable completion triggered by <c-x><c-o>
					vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

					-- Buffer local mappings.
					-- See `:help vim.lsp.*` for documentation on any of the below functions
					local opts = { buffer = ev.buf }

					-- Example keybindings (add the ones you need):
					vim.keymap.set({ "n", "v" }, "<space>ca", vim.lsp.buf.code_action, opts) -- Added keymap for Code Actions
					vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
					vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
					vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
					vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
					vim.keymap.set("n", "<space>wa", vim.lsp.buf.add_workspace_folder, opts)
					vim.keymap.set("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, opts)
					vim.keymap.set("n", "<space>wl", function()
						print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
					end, opts)
					vim.keymap.set("n", "<space>f", function()
						vim.lsp.buf.format({ async = true })
					end, opts)
					-- Map <leader>oi to organize imports
					vim.keymap.set("n", "<leader>oi", function()
						vim.lsp.buf.code_action({
							context = {
								only = { "source.organizeImports" },
							},
							apply = true,
						})
					end, { desc = "Organize Imports" })
				end,
			})
		end,
	},
	{
		"mfussenegger/nvim-lint", -- Linting engine
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			local lint = require("lint")

			-- Configure linters per filetype
			lint.linters_by_ft = {
				javascript = { "eslint" },
				typescript = { "eslint" },
				javascriptreact = { "eslint" },
				typescriptreact = { "eslint" },
				python = { "pylint", "flake8" },
			}

			-- Auto-lint on save and text change
			vim.api.nvim_create_autocmd({ "BufWritePost", "BufReadPost", "InsertLeave" }, {
				callback = function()
					require("lint").try_lint()
				end,
			})
		end,
	},
}
