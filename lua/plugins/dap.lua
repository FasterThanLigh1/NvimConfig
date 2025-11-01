return {
	-- DAP Core
	{
		"mfussenegger/nvim-dap",
		dependencies = {
			"rcarriga/nvim-dap-ui",
			"nvim-neotest/nvim-nio",
			"theHamsta/nvim-dap-virtual-text",
		},
		keys = {
			{
				"<F5>",
				function()
					require("dap").continue()
				end,
				desc = "Debug: Start/Continue",
			},
			{
				"<F10>",
				function()
					require("dap").step_over()
				end,
				desc = "Debug: Step Over",
			},
			{
				"<F11>",
				function()
					require("dap").step_into()
				end,
				desc = "Debug: Step Into",
			},
			{
				"<F12>",
				function()
					require("dap").step_out()
				end,
				desc = "Debug: Step Out",
			},
			{
				"<leader>b",
				function()
					require("dap").toggle_breakpoint()
				end,
				desc = "Debug: Toggle Breakpoint",
			},
			{
				"<leader>dr",
				function()
					require("dapui").toggle()
				end,
				desc = "Debug: Toggle UI",
			},
		},
		config = function()
			local dap = require("dap")
			local dapui = require("dapui")

			-- Setup UI
			dapui.setup()
			require("nvim-dap-virtual-text").setup()

			-- Auto open/close UI
			dap.listeners.after.event_initialized["dapui_config"] = function()
				dapui.open()
			end
			dap.listeners.before.event_terminated["dapui_config"] = function()
				dapui.close()
			end
			dap.listeners.before.event_exited["dapui_config"] = function()
				dapui.close()
			end

			-- Firefox adapter configuration
			dap.adapters.firefox = {
				type = "executable",
				command = "node",
				args = {
					vim.fn.stdpath("data") .. "/mason/packages/firefox-debug-adapter/dist/adapter.bundle.js",
				},
			}

			-- Angular/TypeScript configurations for Firefox
			dap.configurations.typescript = {
				{
					name = "Debug with Firefox",
					type = "firefox",
					request = "launch",
					reAttach = true,
					url = "http://localhost:4200", -- Angular default port
					webRoot = "${workspaceFolder}",
					firefoxExecutable = "/Applications/Firefox.app/Contents/MacOS/firefox", -- macOS path
					-- For Linux: '/usr/bin/firefox'
					-- For custom path, change accordingly
				},
				{
					name = "Debug with Firefox (Custom Port)",
					type = "firefox",
					request = "launch",
					reAttach = true,
					url = function()
						return "http://localhost:" .. vim.fn.input("Port: ", "4200")
					end,
					webRoot = "${workspaceFolder}",
					firefoxExecutable = "/Applications/Firefox.app/Contents/MacOS/firefox",
				},
			}

			-- Also add for JavaScript files
			dap.configurations.javascript = dap.configurations.typescript

			-- For Angular component/template files
			dap.configurations.html = {
				{
					name = "Debug with Firefox",
					type = "firefox",
					request = "launch",
					reAttach = true,
					url = "http://localhost:4200",
					webRoot = "${workspaceFolder}",
					firefoxExecutable = "/Applications/Firefox.app/Contents/MacOS/firefox",
				},
			}
		end,
	},

	-- Mason DAP installer
	{
		"jay-babu/mason-nvim-dap.nvim",
		dependencies = { "mason.nvim", "nvim-dap" },
		cmd = { "DapInstall", "DapUninstall" },
		opts = {
			ensure_installed = { "firefox" }, -- Auto-install Firefox debug adapter
			automatic_installation = true,
		},
	},
}
