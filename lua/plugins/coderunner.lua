return {
	"CRAG666/code_runner.nvim",
	config = function()
		require("code_runner").setup({
			mode = "term",
			focus = true,
			startinsert = false,
			term = {
				position = "bot",
				size = 15,
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

		-- Your keymaps
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
	end,
}
