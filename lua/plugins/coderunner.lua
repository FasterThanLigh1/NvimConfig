return {
	"CRAG666/code_runner.nvim",
	config = function()
		require("code_runner").setup({
			mode = "term",
			focus = true,
			startinsert = false,
			term = {
				position = "bot",
				size = 10, -- Changed from 15 to 10 (approximately 10% of screen)
			},
			filetype = {
				java = {
					"cd $dir &&",
					"javac $fileName &&",
					"java $fileNameWithoutExt",
				},
				python = "python3 -u",
				javascript = "node",
				typescript = "deno run",
				rust = {
					"cd $dir &&",
					"rustc $fileName &&",
					"$dir/$fileNameWithoutExt",
				},
				c = {
					"cd $dir &&",
					"gcc $fileName -o $fileNameWithoutExt &&",
					"$dir/$fileNameWithoutExt",
				},
				cpp = {
					"cd $dir &&",
					"g++ $fileName -o $fileNameWithoutExt &&",
					"$dir/$fileNameWithoutExt",
				},
			},
		})

		-- Code Runner keymaps
		vim.keymap.set("n", "<leader>rr", ":RunCode<CR>", {
			noremap = true,
			silent = false,
			desc = "Run code",
		})
		vim.keymap.set("n", "<leader>rf", ":RunFile<CR>", {
			noremap = true,
			silent = false,
			desc = "Run file",
		})
		vim.keymap.set("n", "<leader>rft", ":RunFile tab<CR>", {
			noremap = true,
			silent = false,
			desc = "Run file (tab)",
		})
		vim.keymap.set("n", "<leader>rp", ":RunProject<CR>", {
			noremap = true,
			silent = false,
			desc = "Run project",
		})
		vim.keymap.set("n", "<leader>rc", ":RunClose<CR>", {
			noremap = true,
			silent = false,
			desc = "Close runner",
		})
		vim.keymap.set("n", "<leader>crf", ":CRFiletype<CR>", {
			noremap = true,
			silent = false,
			desc = "Choose filetype",
		})
		vim.keymap.set("n", "<leader>crp", ":CRProjects<CR>", {
			noremap = true,
			silent = false,
			desc = "Choose project",
		})

		-- Gradle keymaps (works in ANY Gradle project)
		vim.keymap.set("n", "<leader>rg", function()
			vim.cmd("botright 10split | terminal ./gradlew run")
		end, {
			noremap = true,
			silent = false,
			desc = "Gradle run",
		})

		vim.keymap.set("n", "<leader>rd", function()
			-- Auto-detect LibGDX or regular Gradle
			local has_desktop = vim.fn.isdirectory("desktop") == 1
			local cmd = has_desktop and "./gradlew desktop:run" or "./gradlew run"
			vim.cmd("botright 10split | terminal " .. cmd)
		end, {
			noremap = true,
			silent = false,
			desc = "Gradle desktop:run",
		})

		vim.keymap.set("n", "<leader>rb", function()
			vim.cmd("botright 10split | terminal ./gradlew build")
		end, {
			noremap = true,
			silent = false,
			desc = "Gradle build",
		})

		vim.keymap.set("n", "<leader>rl", function()
			vim.cmd("botright 10split | terminal ./gradlew clean")
		end, {
			noremap = true,
			silent = false,
			desc = "Gradle clean",
		})

		vim.keymap.set("n", "<leader>rt", function()
			vim.cmd("botright 10split | terminal ./gradlew test")
		end, {
			noremap = true,
			silent = false,
			desc = "Gradle test",
		})

		-- Maven keymaps (works in ANY Maven project)
		vim.keymap.set("n", "<leader>rm", function()
			vim.cmd("botright 10split | terminal mvn compile exec:java")
		end, {
			noremap = true,
			silent = false,
			desc = "Maven run",
		})

		vim.keymap.set("n", "<leader>rM", function()
			vim.cmd("botright 10split | terminal mvn clean install")
		end, {
			noremap = true,
			silent = false,
			desc = "Maven clean install",
		})
	end,
}
