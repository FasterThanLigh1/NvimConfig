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
			{
				"<leader>de",
				function()
					require("dapui").eval()
				end,
				desc = "Debug: Evaluate under cursor",
			},
			{
				"<leader>B",
				function()
					require("dap").clear_breakpoints()
				end,
				desc = "Debug: Clear All Breakpoints",
			},
		},
		config = function()
			local dap = require("dap")
			local dapui = require("dapui")

			vim.fn.sign_define("DapBreakpoint", {
				text = "🔴",
				texthl = "DapBreakpoint",
				linehl = "",
				numhl = "",
			})

			vim.fn.sign_define("DapStopped", {
				text = "➡️",
				texthl = "DapStopped",
				linehl = "DapStoppedLine",
				numhl = "",
			})

			-- Optional: Add colors for the icons and line highlight
			vim.api.nvim_set_hl(0, "DapStoppedLine", { bg = "#3E4452" }) -- Dark bg for current line
			vim.api.nvim_set_hl(0, "DapBreakpoint", { fg = "#E06C75" }) -- Red icon
			vim.api.nvim_set_hl(0, "DapStopped", { fg = "#61AFEF" }) -- Blue arrow

			-- Setup UI
			dapui.setup()

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
	{
		"theHamsta/nvim-dap-virtual-text",
		-- It's common practice to load this plugin with nvim-dap
		dependencies = { "mfussenegger/nvim-dap" },

		-- The config function runs when the plugin is loaded
		config = function()
			require("nvim-dap-virtual-text").setup({
				-- This is the key option you asked for:
				commented = true,
				show_stop_reason = true,
			})
		end,
	},
}
