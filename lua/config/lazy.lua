-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
			{ out, "WarningMsg" },
			{ "\nPress any key to exit..." },
		}, true, {})
		vim.fn.getchar()
		os.exit(1)
	end
end
vim.opt.rtp:prepend(lazypath)

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Setup lazy.nvim
require("lazy").setup({
	spec = {
		-- import your plugins
		{ import = "plugins" },
	},
	-- Configure any other settings here. See the documentation for more details.
	-- colorscheme that will be used when installing plugins.
	install = { colorscheme = { "habamax" } },
	-- automatically check for plugin updates
	checker = { enabled = true },
})

-- Set color scheme
vim.cmd("colorscheme catppuccin-macchiato")
-- vim.cmd("colorscheme catppuccin-macchiato")

-- Setup keymaps (after plugins are loaded)
require("config.keymap")

vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.expandtab = true

vim.opt.clipboard = "unnamedplus"

-- Force the clipboard provider
vim.g.clipboard = {
	name = "macOS-clipboard",
	copy = {
		["+"] = "pbcopy",
		["*"] = "pbcopy",
	},
	paste = {
		["+"] = "pbpaste",
		["*"] = "pbpaste",
	},
	cache_enabled = 0,
}

-- Works on any file
vim.keymap.set("n", "<leader>ip", function()
	local file = vim.fn.expand("%:p")
	local ext = vim.fn.expand("%:e"):lower()

	-- Check if it's an image file
	local image_exts = { "png", "jpg", "jpeg", "gif", "webp", "svg" }
	if vim.tbl_contains(image_exts, ext) then
		vim.fn.system("open " .. vim.fn.shellescape(file))
	else
		print("Not an image file")
	end
end, { desc = "Preview image" })

-- Save file with Ctrl+S in normal, insert, and visual modes
vim.keymap.set("n", "<C-s>", ":w<CR>", { noremap = true, silent = true, desc = "Save file" })
vim.keymap.set("i", "<C-s>", "<Esc>:w<CR>a", { noremap = true, silent = true, desc = "Save file" })
vim.keymap.set("v", "<C-s>", "<Esc>:w<CR>gv", { noremap = true, silent = true, desc = "Save file" })

-- Show line numbers
vim.opt.number = true
