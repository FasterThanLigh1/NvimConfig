return {
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
		},
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			local lspconfig = require("lspconfig")
			local mason_lspconfig = require("mason-lspconfig")

			-- 1. SETUP MASON
			require("mason").setup()

			-- 2. DEFINE SERVERS & SETTINGS
			local servers = {
				lua_ls = {},
				pyright = {},
				html = {},
				angularls = {},
				-- VTSLS Configuration
				vtsls = {
					filetypes = {
						"javascript",
						"javascriptreact",
						"javascript.jsx",
						"typescript",
						"typescriptreact",
						"typescript.tsx",
					},
					settings = {
						complete_function_calls = true,
						vtsls = {
							enableMoveToFileCodeAction = true,
							autoUseWorkspaceTsdk = true,
							experimental = {
								completion = {
									enableServerSideFuzzyMatch = true,
								},
							},
						},
						typescript = {
							updateImportsOnFileMove = { enabled = "always" },
							suggest = {
								completeFunctionCalls = true,
							},
							inlayHints = {
								parameterNames = { enabled = "literals" },
								parameterTypes = { enabled = true },
								variableTypes = { enabled = false },
								propertyDeclarationTypes = { enabled = true },
								functionLikeReturnTypes = { enabled = true },
								enumMemberValues = { enabled = true },
							},
						},
					},
				},
				tailwindcss = {
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
				},
			}

			-- 3. AUTO-INSTALL & CONFIGURE SERVERS
			-- FIX: Handlers are now defined INSIDE setup() to prevent the nil error
			mason_lspconfig.setup({
				ensure_installed = vim.tbl_keys(servers),
				handlers = {
					function(server_name)
						local server_config = servers[server_name] or {}
						lspconfig[server_name].setup(server_config)
					end,
				},
			})

			-- 4. KEYMAPS (LspAttach)
			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("UserLspConfig", {}),
				callback = function(ev)
					-- Enable completion triggered by <c-x><c-o>
					vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

					local opts = { buffer = ev.buf }

					-- Keybindings
					vim.keymap.set(
						{ "n", "v" },
						"<space>ca",
						vim.lsp.buf.code_action,
						vim.tbl_extend("force", opts, { desc = "Code Action" })
					)
					vim.keymap.set(
						"n",
						"gD",
						vim.lsp.buf.declaration,
						vim.tbl_extend("force", opts, { desc = "Go to Declaration" })
					)
					vim.keymap.set(
						"n",
						"gd",
						vim.lsp.buf.definition,
						vim.tbl_extend("force", opts, { desc = "Go to Definition" })
					)
					vim.keymap.set(
						"n",
						"K",
						vim.lsp.buf.hover,
						vim.tbl_extend("force", opts, { desc = "Show Hover Documentation" })
					)
					vim.keymap.set(
						"n",
						"gi",
						vim.lsp.buf.implementation,
						vim.tbl_extend("force", opts, { desc = "Go to Implementation" })
					)
					vim.keymap.set(
						"n",
						"<space>wa",
						vim.lsp.buf.add_workspace_folder,
						vim.tbl_extend("force", opts, { desc = "Add Workspace Folder" })
					)
					vim.keymap.set(
						"n",
						"<space>wr",
						vim.lsp.buf.remove_workspace_folder,
						vim.tbl_extend("force", opts, { desc = "Remove Workspace Folder" })
					)
					vim.keymap.set("n", "<space>wl", function()
						print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
					end, vim.tbl_extend("force", opts, { desc = "List Workspace Folders" }))

					vim.keymap.set("n", "<space>f", function()
						vim.lsp.buf.format({ async = true })
					end, vim.tbl_extend("force", opts, { desc = "Format Buffer" }))

					-- Organize Imports (Specific to vtsls/tsserver logic)
					vim.keymap.set("n", "<leader>oi", function()
						vim.lsp.buf.code_action({
							context = { only = { "source.organizeImports" } },
							apply = true,
						})
					end, { desc = "Organize Imports" })
				end,
			})
		end,
	},
	{
		"mfussenegger/nvim-lint",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			local lint = require("lint")

			lint.linters_by_ft = {
				javascript = { "eslint" },
				typescript = { "eslint" },
				javascriptreact = { "eslint" },
				typescriptreact = { "eslint" },
				python = { "pylint", "flake8" },
			}

			vim.api.nvim_create_autocmd({ "BufWritePost", "BufReadPost", "InsertLeave" }, {
				callback = function()
					require("lint").try_lint()
				end,
			})
		end,
	},
}
